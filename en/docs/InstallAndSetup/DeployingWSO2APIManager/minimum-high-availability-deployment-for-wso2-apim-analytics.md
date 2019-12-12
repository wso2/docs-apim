# Minimum High Availability Deployment for WSO2 APIM Analytics

!!! warning
    Took the page offline as the content is out dated. New content needs to be got from [Minimum High Availability Deployment](https://docs.wso2.com/display/SP430/Minimum+High+Availability+Deployment) SP430


This section explains how to configure WSO2 API Manager Analytics in a distributed setup. You can configure alerts to monitor these APIs and detect unusual activity, manage locations via geo location statistics and to carry out detailed analysis of logs relating to the APIs. WSO2 APIM Analytics is powered by WSO2 DAS. The following diagram indicates the minimum deployment pattern used for high availability.

![]({{base_path}}/assets/attachments/103334517/103334521.png)

APIM Analytics supports a deployment scenario that has focus on high availability (HA) along with HA processing. To enable HA processing, you should have two APIM Analytics servers in a cluster.

For this deployment, both nodes should be configured to receive all events. To achieve this, clients can either send all the requests to both the nodes or each request to any one of the two nodes (i.e., using load balancing or failover mechanisms). If clients send all the requests to both nodes, the user has to specify that events are duplicated in the cluster (i.e., the same event comes to all the members of the cluster). Alternatively, if a client sends a request to one node, internally it sends that particular request to the other node as well. This way, even if the clients send requests to only one node, both API-M Analytics nodes receive all the requests.

In this scenario, one API-M Analytics node works in active mode and the other works in passive mode. However, both nodes process all the data.

If the active node fails, the other node becomes active and receives all the requests.

![]({{base_path}}/assets/attachments/103334517/103334520.png)
When the failed node is up again, it fetches  all the internal states of the current active node via synching.

![]({{base_path}}/assets/attachments/103334517/103334519.png)
![]({{base_path}}/assets/attachments/103334517/103334518.png)
The newly arrived node then becomes the passive node and starts processing all the incoming messages to keep its state synched with the active node so that it can become active if the current active node fails.

!!! warning
**Warning** : Some of the requests may be lost during the time the passive node switches to the active mode.


### Prerequisites

Before you configure a minimum high availability API-M Analytics cluster, the following needs to be carried out.

1.  Download the WSO2 API-M Analytics distribution. Click **DOWNLOAD ANALYTICS** in the [WSO2 API Manager page](http://wso2.com/products/api-manager/) .
2.  Take the following steps to install WSO2 APIM Analytics. Because this procedure is identical to installing WSO2 Data Analytics Server (DAS), these steps take you to the DAS documentation for details.
    1.  Ensure that you have met the [Installation Prerequisites](http://docs.wso2.com/data-analytics-server/Getting%20Started) .
    2.  Go to the installation instructions relevant to your operating system:
        -   [Installing on Linux](http://docs.wso2.com/data-analytics-server/Installing%20on%20Linux)
        -   [Installing on Windows](http://docs.wso2.com/data-analytics-server/Installing%20on%20Windows)
        -   [Installing as a Windows Service](http://docs.wso2.com/data-analytics-server/Installing%20as%20a%20Windows%20Service)
        -   [Installing as a Linux Service](http://docs.wso2.com/data-analytics-server/Installing%20as%20a%20Linux%20Service)
3.  Follow the steps below to set up MySQL.
    1.  Download and install [MySQL Server](http://dev.mysql.com/downloads/) .

    2.  Download the [MySQL JDBC driver](http://dev.mysql.com/downloads/connector/j/) .

    3.  Unzip the downloaded MySQL driver zipped archive, and copy the MySQL JDBC driver JAR ( `mysql-connector-java-x.x.xx-bin.jar` ) into the `<APIM Analytics_HOME>/repository/components/lib` directory of all the nodes in the cluster.

    4.  Enter the following command in a terminal/command window, where `username` is the username you want to use to access the databases.
`mysql -u username -p           `
    5.  When prompted, specify the password that will be used to access the databases with the username you specified.
    6.  Create two databases named `userdb` and `regdb.            `

                !!! info
        About using MySQL in different operating systems

        For users of Microsoft Windows, when creating the database in MySQL, it is important to specify the character set as latin1. Failure to do this may result in an error (error code: 1709) when starting your cluster. This error occurs in certain versions of MySQL (5.6.x) and is related to the UTF-8 encoding. MySQL originally used the latin1 character set by default, which stored characters in a 2-byte sequence. However, in recent versions, MySQL defaults to UTF-8 to be friendlier to international users. Hence, you must use latin1 as the character set as indicated below in the database creation commands to avoid this problem. Note that this may result in issues with non-latin characters (like Hebrew, Japanese, etc.). The following is how your database creation command should look.

            mysql> create database <DATABASE_NAME> character set latin1;

        For users of other operating systems, the standard database creation commands will suffice. For these operating systems, the following is how your database creation command should look.

            mysql> create database <DATABASE_NAME>;


    7.  Execute the following script for the two databases you created in the previous step.
`mysql> source <APIM Analytics_HOME>/dbscripts/mysql.sql;                         `

        !!! note
            From WSO2 Carbon Kernel 4.4.6 onwards there are two MySQL DB scripts available in the product distribution. Click [here](https://docs.wso2.com/display/AM200/FAQ#FAQ-WhichMySQLdatabasescriptshouldIuse?) to identify as to which version of the MySQL script to use.


        ??? info "Click here to view the commands for performing steps f and g"

            ``` java
                    mysql> create database userdb;
                    mysql> use userdb;
                    mysql> source <APIM Analytics_HOME>/dbscripts/mysql.sql;
                    mysql> grant all on userdb.* TO username@localhost identified by "password";
                     
                     
                    mysql> create database regdb;
                    mysql> use regdb;
                    mysql> source <APIM Analytics_HOME>/dbscripts/mysql.sql;
                    mysql> grant all on regdb.* TO username@localhost identified by "password";
            ```

    8.  Create the following databases in MySQL.

        -`WSO2_ANALYTICS_EVENT_STORE_DB             `
        -`WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB             `

        !!! info
            It is recommended to create the databases with the same names given above because they are the default JNDI names that are included in the `<APIM Analytics_HOME>/repository/conf/analytics/analytics-conf.xml` file as shown in the extract below. If you change the name, the `analytics-conf.xml` file should be updated with the changed name.

        ``` xml
                <analytics-record-store name="EVENT_STORE">
                   <implementation>org.wso2.carbon.analytics.datasource.rdbms.RDBMSAnalyticsRecordStore</implementation>
                   <properties>
                      <property name="datasource">WSO2_ANALYTICS_EVENT_STORE_DB</property>
                      <property name="category">read_write_optimized</property>
                   </properties>
                </analytics-record-store>
                <analytics-record-store name="EVENT_STORE_WO">
                   <implementation>org.wso2.carbon.analytics.datasource.rdbms.RDBMSAnalyticsRecordStore</implementation>
                   <properties>
                      <property name="datasource">WSO2_ANALYTICS_EVENT_STORE_DB</property>
                      <property name="category">write_optimized</property>
                   </properties>
                </analytics-record-store>
                <analytics-record-store name="PROCESSED_DATA_STORE">
                   <implementation>org.wso2.carbon.analytics.datasource.rdbms.RDBMSAnalyticsRecordStore</implementation>
                   <properties>
                      <property name="datasource">WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB</property>
                      <property name="category">read_write_optimized</property>
                   </properties>
                </analytics-record-store>
        ```


### Required configurations

When configuring the minimum high availability cluster following setups should be done for both nodes.

1.  Do the following database-related configurations.
    1.  Follow the steps below to configure the &lt;APIM Analytics `_HOME>/repository/conf/datasources/master-datasources.xml` file as required

        1.  Enable the all the nodes to access the users database by configuring a datasource to be used by user manager as shown below.

            ``` xml
                        <datasource>
                            <name>WSO2UM_DB</name>
                            <description>The datasource used by user manager</description>
                            <jndiConfig>
                            <name>jdbc/WSO2UM_DB</name>
                            </jndiConfig>
                            <definition type="RDBMS">
                            <configuration>
                                <url>jdbc:mysql://[MySQL DB url]:[port]/userdb</url>
                                <username>[user]</username>
                                <password>[password]</password>
                                <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                                <maxActive>50</maxActive>
                                <maxWait>60000</maxWait>
                                <testOnBorrow>true</testOnBorrow>
                                <validationQuery>SELECT 1</validationQuery>
                                <validationInterval>30000</validationInterval>
                            </configuration>
                            </definition>
                        </datasource>
            ```

        2.  Enable the nodes to access the registry database by configuring the `WSO2REG_DB` data source as follows.

            ``` xml
                            <datasource>
                                <name>WSO2REG_DB</name>
                                <description>The datasource used by the registry</description>
                                <jndiConfig>
                                <name>jdbc/WSO2REG_DB</name>
                                </jndiConfig>
                                <definition type="RDBMS">
                                <configuration>
                                    <url>jdbc:mysql://[MySQL DB url]:[port]/regdb</url>
                                    <username>[user]</username>
                                    <password>[password]</password>
                                    <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                                    <maxActive>50</maxActive>
                                    <maxWait>60000</maxWait>
                                    <testOnBorrow>true</testOnBorrow>
                                    <validationQuery>SELECT 1</validationQuery>
                                    <validationInterval>30000</validationInterval>
                                </configuration>
                                </definition>
                            </datasource>
            ```

            For detailed information about registry sharing strategies, see the library article [Sharing Registry Space across Multiple Product Instances](http://wso2.com/library/tutorials/2010/04/sharing-registry-space-across-multiple-product-instances/) .

    2.  Point to `WSO2_ANALYTICS_EVENT_STORE_DB` and `WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB` in the `<APIM Analytics_HOME>/repository/conf/datasources/analytics-datasources.xml` file as shown below.

        ``` xml
                    <datasources-configuration>
                        <providers>
                            <provider>org.wso2.carbon.ndatasource.rdbms.RDBMSDataSourceReader</provider>
                        </providers>
            <datasources>
                <datasource>
                    <name>WSO2_ANALYTICS_EVENT_STORE_DB</name>
                    <description>The datasource used for analytics record store</description>
                    <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:mysql://[MySQL DB url]:[port]/WSO2_ANALYTICS_EVENT_STORE_DB</url>
                            <username>[username]</username>
                            <password>[password]</password>
                            <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                            <maxActive>50</maxActive>
                            <maxWait>60000</maxWait>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>false</defaultAutoCommit>
                        </configuration>
                    </definition>
                </datasource>
                <datasource>
                    <name>WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB</name>
                    <description>The datasource used for analytics record store</description>
                    <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:mysql://[MySQL DB url]:[port]/WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB</url>
                            <username>[username]</username>
                            <password>[password]</password>
                            <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                            <maxActive>50</maxActive>
                            <maxWait>60000</maxWait>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>false</defaultAutoCommit>
                        </configuration>
                    </definition>
                </datasource>
            </datasources>
        </datasources-configuration>
        ```
        For more information, see [Datasources in DAS documentation](https://docs.wso2.com/display/DAS300/Datasources) .

    3.  To share the user store among the nodes, open the `<APIM Analytics_HOME>/repository/conf/user-mgt.xml` file and modify the `dataSource` property of the `<configuration>` element as follows.

        ``` xml
                <configuration> 
                ...
                    <Property name="dataSource">jdbc/WSO2UM_DB</Property>
                </configuration>
        ```

                !!! info
        The datasource name specified in this configuration should be the same as the datasource used by user manager that you configured in sub step **a, i** .


    4.  In the `<APIM Analytics_HOME>/repository/conf/registry.xml` file, add or modify the `dataSource` attribute of the `<dbConfig name="govregistry">` element as follows.

        ``` xml
                <dbConfig name="govregistry">
                    <dataSource>jdbc/WSO2REG_DB</dataSource>
                </dbConfig>
                <remoteInstance url="https://localhost:9443/registry"> 
                    <id>gov</id>
                    <cacheId>user@jdbc:mysql://localhost:3306/regdb</cacheId>
                    <dbConfig>govregistry</dbConfig>
                    <readOnly>false</readOnly>
                    <enableCache>true</enableCache>
                    <registryRoot>/</registryRoot>
                </remoteInstance>
                <mount path="/_system/governance" overwrite="true">
                    <instanceId>gov</instanceId>
                    <targetPath>/_system/governance</targetPath>
                </mount>
                <mount path="/_system/config" overwrite="true">
                    <instanceId>gov</instanceId>
                    <targetPath>/_system/config</targetPath>
                </mount>
        ```

        !!! note
            Do not replace the following configuration when adding in the mounting configurations. The registry mounting configurations mentioned in the above steps should be added in addition to the following.

        ``` xml
                <dbConfig name="wso2registry">
                    <dataSource>jdbc/WSO2CarbonDB</dataSource>
                </dbConfig>
        ```


2.  Update the `<APIM Analytics_HOME>/repository/conf/axis2/axis2.xml` file as follows to enable Hazlecast clustering for both nodes.
    1.  Set `clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent"` to `true` as shown below to enable Hazlecast clustering.

        ``` xml
                <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent" enable="true">
        ```

    2.  Enable **wka** mode on both nodes as shown below. For more information on **wka** mode, see [About Membership Schemes](https://docs.wso2.com/display/ADMIN44x/Clustering+Overview#ClusteringOverview-wka) in the Administration Guide.

        ``` xml
                    <parameter name="membershipScheme">wka</parameter>
        ```

    3.  Add both the  nodes as well known members in the cluster under the `members` tag in each node as shown in the example below.

        ``` xml
                    <members>
                        <member>
                            <hostName>[node1 IP]</hostName>
                            <port>[node1 port]</port>
                        </member>
                        <member>
                            <hostName>[node2 IP]</hostName>
                            <port>[node2 port]</port>
                        </member>
                    </members>
        ```

    4.  For each node, enter the respective server IP address as the value for the `localMemberHost` property as shown below.

        ``` xml
                    <parameter name="localMemberHost">[Server_IP_Address]</parameter>
        ```

    ??? info "Click here to view the complete clustering section of the axis2.xml file. with the changes mentioned above."

        ``` xml
                    <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent"
                                enable="true">
                <!--
                   This parameter indicates whether the cluster has to be automatically initalized
                   when the AxisConfiguration is built. If set to "true" the initialization will not be
                   done at that stage, and some other party will have to explictly initialize the cluster.
                -->
                <parameter name="AvoidInitiation">true</parameter>
    
                <!--
                   The membership scheme used in this setup. The only values supported at the moment are
                   "multicast" and "wka"
    
                   1. multicast - membership is automatically discovered using multicasting
                   2. wka - Well-Known Address based multicasting. Membership is discovered with the help
                            of one or more nodes running at a Well-Known Address. New members joining a
                            cluster will first connect to a well-known node, register with the well-known node
                            and get the membership list from it. When new members join, one of the well-known
                            nodes will notify the others in the group. When a member leaves the cluster or
                            is deemed to have left the cluster, it will be detected by the Group Membership
                            Service (GMS) using a TCP ping mechanism.
                -->
                
                <parameter name="membershipScheme">wka</parameter>
    
                <!--<parameter name="licenseKey">xxx</parameter>-->
                <!--<parameter name="mgtCenterURL">http://localhost:8081/mancenter/</parameter>-->
    
                <!--
                 The clustering domain/group. Nodes in the same group will belong to the same multicast
                 domain. There will not be interference between nodes in different groups.
                -->
                <parameter name="domain">wso2.carbon.domain</parameter>
    
                <!-- The multicast address to be used -->
                <!--<parameter name="mcastAddress">228.0.0.4</parameter>-->
    
                <!-- The multicast port to be used -->
                <parameter name="mcastPort">45564</parameter>
    
                <parameter name="mcastTTL">100</parameter>
    
                <parameter name="mcastTimeout">60</parameter>
    
                <!--
                   The IP address of the network interface to which the multicasting has to be bound to.
                   Multicasting would be done using this interface.
                -->
                <!--
                    <parameter name="mcastBindAddress">10.100.5.109</parameter>
                -->
                <!-- The host name or IP address of this member -->
    
                <parameter name="localMemberHost">[node IP]</parameter>
    
                <!--
                    The bind adress of this member. The difference between localMemberHost & localMemberBindAddress
                    is that localMemberHost is the one that is advertised by this member, while localMemberBindAddress
                    is the address to which this member is bound to.
                -->
                <!--
                <parameter name="localMemberBindAddress">[node IP]</parameter>
                -->
    
                <!--
                The TCP port used by this member. This is the port through which other nodes will
                contact this member
                 -->
                <parameter name="localMemberPort">[node port]</parameter>
    
                <!--
                    The bind port of this member. The difference between localMemberPort & localMemberBindPort
                    is that localMemberPort is the one that is advertised by this member, while localMemberBindPort
                    is the port to which this member is bound to.
                -->
                <!--
                <parameter name="localMemberBindPort">4001</parameter>
                -->
    
                <!--
                Properties specific to this member
                -->
                <parameter name="properties">
                    <property name="backendServerURL" value="https://${hostName}:${httpsPort}/services/"/>
                    <property name="mgtConsoleURL" value="https://${hostName}:${httpsPort}/"/>
                    <property name="subDomain" value="worker"/>
                </parameter>
    
                <!--
                Uncomment the following section to load custom Hazelcast data serializers.
                -->
                <!--
                <parameter name="hazelcastSerializers">
                    <serializer typeClass="java.util.TreeSet">org.wso2.carbon.hazelcast.serializer.TreeSetSerializer
                    </serializer>
                    <serializer typeClass="java.util.Map">org.wso2.carbon.hazelcast.serializer.MapSerializer</serializer>
                </parameter>
                -->
    
                <!--
                   The list of static or well-known members. These entries will only be valid if the
                   "membershipScheme" above is set to "wka"
                -->
                <members>
                    <member>
                        <hostName>[node1 IP]</hostName>
                        <port>[node1 port]</port>
                    </member>
                    <member>
                        <hostName>[node2 IP]</hostName>
                        <port>[node2 port]</port>
                    </member>
                </members>
    
                <!--
                Enable the groupManagement entry if you need to run this node as a cluster manager.
                Multiple application domains with different GroupManagementAgent implementations
                can be defined in this section.
                -->
                <groupManagement enable="false">
                    <applicationDomain name="wso2.as.domain"
                                       description="AS group"
                                       agent="org.wso2.carbon.core.clustering.hazelcast.HazelcastGroupManagementAgent"
                                       subDomain="worker"
                                       port="2222"/>
                </groupManagement>
            </clustering>
        ```
3.  Configure the `<APIM Analytics_HOME>/repository/conf/event-processor.xml` file as follows to cluster API-M Analytics in the Receiver.

    1.  Enable the `HA` mode by setting the following property.

        ``` xml
                <mode name="HA" enable="true">
        ```

    2.  Disable the `Distributed` mode by setting the following property.

        ``` xml
                    <mode name="Distributed" enable="false">
        ```

    3.  For each node, enter the respective server IP address under the `HA mode` Config section as shown in the example below.

        !!! info
            When you enable the HA mode for WSO2 API-M Analytics, the following are enabled by default.

        -   **State persistence:** If there is no real time use case that requires any state information after starting the cluster, you should disable event persistence by setting the `persistence` attribute to `false` in the `<APIM Analytics_HOME>/repository/conf/event-processor.xml` file as shown below.

            ``` xml
                        <persistence enable="false">
                            <persistenceIntervalInMinutes>15</persistenceIntervalInMinutes>
                            <persisterSchedulerPoolSize>10</persisterSchedulerPoolSize>
                            <persister class="org.wso2.carbon.event.processor.core.internal.persistence.FileSystemPersistenceStore">
                                <property key="persistenceLocation">cep_persistence</property>
                            </persister>
                        </persistence>
            ```

                        !!! tip
            When state persistence is enabled for WSO2 API-M Analytics, the internal state of API-M Analytics is persisted in files. These files are not automatically deleted. Therefore, if you want to save space in your API-M Analytics pack, you need to delete them manually.

            These files are created in the `<APIM Analytics_HOME>/cep_persistence/<tenant-id>` directory. This directory has a separate sub-directory for each execution plan. Each execution plan can have multiple files. The format of each file name is `<TIMESTAMP>_<EXECUTION_PLAN_NAME>` (e.g, `1493101044948_MyExecutionPlan` ). If you want to clear files for a specific execution plan, you need to leave the two files with the latest timestamps and delete the rest.


        -   **Event synchronization** : However, if you set the `event.duplicated.in.cluster=true` property for an event receiver configured in a node, API-M Analytics does not perform event synchronization for that receiver.


        ``` xml
                    <!-- HA Mode Config -->
                    <mode name="HA" enable="true">
                       ...
                        <eventSync>
                            <hostName>[Server_IP_Address]</hostName>
        ```

    ??? info "Click here to view the complete event-processor.xml file with the changes mentioned above."

        ``` xml
                <eventProcessorConfiguration>
                    <mode name="SingleNode" enable="false">
                        <persistence enable="false">
                            <persistenceIntervalInMinutes>15</persistenceIntervalInMinutes>
                            <persisterSchedulerPoolSize>10</persisterSchedulerPoolSize>
                            <persister class="org.wso2.carbon.event.processor.core.internal.persistence.FileSystemPersistenceStore">
                                <property key="persistenceLocation">cep_persistence</property>
                            </persister>
                        </persistence>
                    </mode>
            <!-- HA Mode Config -->
            <mode name="HA" enable="true">
                <nodeType>
                    <worker enable="true"/>
                    <presenter enable="false"/>
                </nodeType>
                <checkMemberUpdateInterval>10000</checkMemberUpdateInterval>
                <eventSync>
                    <hostName>172.18.1.217</hostName>
                    <port>11224</port>
                    <reconnectionInterval>20000</reconnectionInterval>
                    <serverThreads>20000</serverThreads>
                    <!--Size of TCP event publishing client's send buffer in bytes-->
                    <publisherTcpSendBufferSize>5242880</publisherTcpSendBufferSize>
                    <!--Character encoding of TCP event publishing client-->
                    <publisherCharSet>UTF-8</publisherCharSet>
                    <publisherBufferSize>1024</publisherBufferSize>
                    <publisherConnectionStatusCheckInterval>30000</publisherConnectionStatusCheckInterval>
                    <!--Number of events that could be queued at receiver before they are synced between CEP/DAS nodes-->
                    <receiverQueueSize>1000000</receiverQueueSize>
                    <!--Max total size of events that could be queued at receiver before they are synced between CEP/DAS nodes-->
                    <receiverQueueMaxSizeMb>10</receiverQueueMaxSizeMb>
                    <!--Number of events that could be queued at publisher to sync output between CEP/DAS nodes-->
                    <publisherQueueSize>1000000</publisherQueueSize>
                    <!--Max total size of events that could be queued at publisher to sync output between CEP/DAS nodes-->
                    <publisherQueueMaxSizeMb>10</publisherQueueMaxSizeMb>
                </eventSync>
                <management>
                    <hostName>172.18.1.217</hostName>
                    <port>10005</port>
                    <tryStateChangeInterval>15000</tryStateChangeInterval>
                    <stateSyncRetryInterval>10000</stateSyncRetryInterval>
                </management>
                <presentation>
                    <hostName>0.0.0.0</hostName>
                    <port>11000</port>
                    <!--Size of TCP event publishing client's send buffer in bytes-->
                    <publisherTcpSendBufferSize>5242880</publisherTcpSendBufferSize>
                    <!--Character encoding of TCP event publishing client-->
                    <publisherCharSet>UTF-8</publisherCharSet>
                    <publisherBufferSize>1024</publisherBufferSize>
                    <publisherConnectionStatusCheckInterval>30000</publisherConnectionStatusCheckInterval>
                </presentation>
            </mode>
    
            <!-- Distributed Mode Config -->
            <mode name="Distributed" enable="false">
                <nodeType>
                    <worker enable="true"/>
                    <manager enable="true">
                        <hostName>0.0.0.0</hostName>
                        <port>8904</port>
                    </manager>
                    <presenter enable="false">
                        <hostName>0.0.0.0</hostName>
                        <port>11000</port>
                    </presenter>
                </nodeType>
                <management>
                    <managers>
                        <manager>
                            <hostName>localhost</hostName>
                            <port>8904</port>
                        </manager>
                        <manager>
                            <hostName>localhost</hostName>
                            <port>8905</port>
                        </manager>
                    </managers>
                    <!--Connection re-try interval to connect to Storm Manager service in case of a connection failure-->
                    <reconnectionInterval>20000</reconnectionInterval>
                    <!--Heart beat interval (in ms) for event listeners in "Storm Receivers" and "CEP Publishers" to acknowledge their
                    availability for receiving events"-->
                    <heartbeatInterval>5000</heartbeatInterval>
                    <!--Storm topology re-submit interval in case of a topology submission failure-->
                    <topologyResubmitInterval>10000</topologyResubmitInterval>
                </management>
                <transport>
                    <!--Port range to be used for events listener servers in "Storm Receiver Spouts" and "CEP Publishers"-->
                    <portRange>
                        <min>15000</min>
                        <max>15100</max>
                    </portRange>
                    <!--Connection re-try interval (in ms) for connection failures between "CEP Receiver" to "Storm Receiver" connections
                    and "Storm Publisher" to "CEP Publisher" connections-->
                    <reconnectionInterval>20000</reconnectionInterval>
                    <!--Size of the output queue of each "CEP Receiver" which stores events to be published into "Storm Receivers" .
                    This must be a power of two-->
                    <cepReceiverOutputQueueSize>8192</cepReceiverOutputQueueSize>
                    <!--Size of the output queue of each "Storm Publisher" which stores events to be published into "CEP Publisher" .
                    This must be a power of two-->
                    <stormPublisherOutputQueueSize>8192</stormPublisherOutputQueueSize>
                    <!--Size of TCP event publishing client's send buffer in bytes-->
                    <tcpEventPublisherSendBufferSize>5242880</tcpEventPublisherSendBufferSize>
                    <!--Character encoding of TCP event publishing client-->
                    <tcpEventPublisherCharSet>UTF-8</tcpEventPublisherCharSet>
                    <!--Size of the event queue in each storm spout which stores events to be processed by storm bolts -->
                    <stormSpoutBufferSize>10000</stormSpoutBufferSize>
                    <connectionStatusCheckInterval>20000</connectionStatusCheckInterval>
                </transport>
                <presentation>
                    <presentationOutputQueueSize>1024</presentationOutputQueueSize>
                    <!--Size of TCP event publishing client's send buffer in bytes-->
                    <tcpEventPublisherSendBufferSize>5242880</tcpEventPublisherSendBufferSize>
                    <!--Character encoding of TCP event publishing client-->
                    <tcpEventPublisherCharSet>UTF-8</tcpEventPublisherCharSet>
                    <connectionStatusCheckInterval>20000</connectionStatusCheckInterval>
                </presentation>
                <statusMonitor>
                    <lockTimeout>60000</lockTimeout>
                    <updateRate>60000</updateRate>
                </statusMonitor>
                <stormJar>org.wso2.cep.storm.dependencies.jar</stormJar>
                <distributedUIUrl></distributedUIUrl>
                <memberUpdateCheckInterval>20000</memberUpdateCheckInterval>
            </mode>
        </eventProcessorConfiguration>
        ```
        !!! info
    The following node types are configured for the HA deployment mode in the `<APIM Analytics_HOME>/repository/conf/event-processor.xml` file.

    -   **`eventSync             `** : Both the active and the passive nodes in this setup are event synchronizing nodes as explained in the introduction. Therefore, each node should have the host and the port on which it is operating specified under the `<eventSync>` element .

        !!! info
            Note that the `eventSync` port is not automatically updated to the port in which each node operates via port offset.


    -   **`management             `** : In this setup, both the nodes carry out the same tasks, and therefore, both nodes are considered manager nodes. Therefore, each node should have the host and the port on which it is operating specified under the `<management>` element.

        !!! info
            Note that the `management` port is not automatically updated to the port in which each node operates via port offset.


    -   **`presentation            `** : You can optionally specify only one of the two nodes in this setup as the presenter node. The dashboards in which processed information is displayed are configured only in the presenter node. Each node should have the host and the port on which the assigned presenter node is operating specified under the `<presentation>` element. The host and the port as well as the other configurations under the `<presentation>` element are effective only when the `presenter enable="false` property is set under the `<!-- HA Mode Config -->` section.


4.  Update the `<APIM Analytics_HOME>/repository/conf/analytics/spark/spark-defaults.conf` file as follows to use the Spark cluster embedded within API-M Analytics.

    -   Keep the `carbon.spark.master` configuration as `local` . This instructs Spark to create a Spark cluster using the Hazelcast cluster.
    -   Enter `2` as the value for the `carbon.spark.master.count` configuration. This specifies that there should be two masters in the Spark cluster. One master serves as an active master and the other serves as a stand-by master.

    The following example shows the `<APIM Analytics_HOME>/repository/conf/analytics/spark/spark-defaults.conf` file with changes mentioned above.

    ``` java
        carbon.spark.master local
        carbon.spark.master.count 2
    ```

    For more information, see [Spark Configurations in DAS documentation](https://docs.wso2.com/display/DAS300/Spark+Configurations) .

        !!! warning
    **Important** : If the path to `<APIM Analytics_HOME>` is different in the two nodes, please do the following.

    -   [**UNIX environment**](#73d4ea32bf2848679081038c4b812873)
    -   [**Windows environment**](#4a68f6b27e41463d9444eff52f6c3ae1)

    Create a symbolic link to `<APIM Analytics_HOME>` in both nodes, where paths of those symbolic links are identical. This ensures that if we use the symbolic link to access API-M Analytics, we can use a common path. To do this, set the following property in the
`<APIM Analytics_HOME>/repository/conf/analytics/spark/spark-defaults.conf` file.

`carbon.das.symbolic.link /home/ubuntu/das/das_symlink/             `

    In the Windows environment there is a strict requirement to have both API-M Analytics distributions in a common path.


5.  In order to share the C-Apps deployed among the nodes, configure the SVN-based deployment synchronizer. For detailed instructions, see [Configuring SVN-Based Deployment Synchronizer](https://docs.wso2.com/display/CLUSTER44x/Configuring+SVN-Based+Deployment+Synchronizer) .

        !!! tip
    API-M Analytics Minimum High availability Deployment set up does not use a manager and a worker. For the purpose of configuring the deployment synchronizer, you can add the configurations relevant to the manager for the node of your choice, and add the configurations relating to the worker for the other node.

        !!! info
    If you do not configure the deployment synchronizer, you are required to deploy any C-App you use in the API-M Analytics Minimum High Availability Deployment set up to both the nodes.


6.  If the physical API-M Analytics server has multiple network interfaces with different IPs, and if you want Spark to use a specific Interface IP, open either the `<APIM Analytics_HOME>/bin/load-spark-env-vars.sh` file (for Linux) or `<APIM Analytics_HOME>/bin/load-spark-env-vars.bat` file (for Windows), and add the following parameter to configure the Spark IP address.

    ``` java
        export  SPARK_LOCAL_IP=<IP_Address>
    ```

7.  Note that if you are deploying in an environment where file systems do not get persisted automatically, it's required to persist and share some directories under &lt;APIM\_ANALYTICS\_HOME&gt; directory. Please see APIM Analytics section in the [Common Runtime and Configuration Artifacts](https://docs.wso2.com/display/AM210/Common+Runtime+and+Configuration+Artifacts) page.

### Starting the cluster

Once you complete the configurations mentioned above, start the two API-M Analytics nodes. If the cluster is successfully configured, the following CLI logs are generated.

-   The following is displayed in the CLIs of both nodes, and it indicates that the registry mounting is successfully done.

    ``` text
            [2016-01-28 14:20:53,596]  INFO {org.wso2.carbon.registry.core.jdbc.EmbeddedRegistryService} -  Configured Registry in 107ms
            [2016-01-28 14:20:53,631]  INFO {org.wso2.carbon.registry.core.jdbc.EmbeddedRegistryService} -  Connected to mount at govregistry in 7ms
            [2016-01-28 14:20:53,818]  INFO {org.wso2.carbon.registry.core.jdbc.EmbeddedRegistryService} -  Connected to mount at govregistry in 0ms
    ```

-   A CLI log similar to the following is displayed for the first node you start to indicate that it has successfully started.

    ``` text
            [2016-01-28 14:32:40,283]  INFO {org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent} -  Using wka based membership management scheme
            [2016-01-28 14:32:40,284]  INFO {org.wso2.carbon.core.clustering.hazelcast.util.MemberUtils} -  Added member: Host:10.100.0.46, Remote Host:null, Port: 4000, HTTP:-1, HTTPS:-1, Domain: null, Sub-domain:null, Active:true
            [2016-01-28 14:32:40,284]  INFO {org.wso2.carbon.core.clustering.hazelcast.util.MemberUtils} -  Added member: Host:10.100.0.46, Remote Host:null, Port: 4001, HTTP:-1, HTTPS:-1, Domain: null, Sub-domain:null, Active:true
            [2016-01-28 14:32:41,665]  INFO {org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent} -  Hazelcast initialized in 1379ms
            [2016-01-28 14:32:41,728]  INFO {org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent} -  Local member: [9c7619a9-8460-465d-8fd0-7eab1c464386] - Host:10.100.0.46, Remote Host:null, Port: 4000, HTTP:9763, HTTPS:9443, Domain: wso2.carbon.domain, Sub-domain:worker, Active:true
            [2016-01-28 14:32:41,759]  INFO {org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent} -  Elected this member [9c7619a9-8460-465d-8fd0-7eab1c464386] as the Coordinator node
            [2016-01-28 14:32:41,847]  INFO {org.wso2.carbon.event.processor.manager.core.internal.HAManager} -  CEP HA Snapshot Server started on 0.0.0.0:10005
            [2016-01-28 14:32:41,850]  INFO {org.wso2.carbon.event.processor.manager.core.internal.HAManager} -  Became CEP HA Active Member
            [2016-01-28 14:32:41,885]  INFO {org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent} -  Cluster initialization completed
    ```

-   Once you start the second node, a CLI log similar to the following will be displayed for the first node to indicate that another node has joined the cluster.

    ``` text
            [2016-01-28 14:34:13,252]  INFO {org.wso2.carbon.core.clustering.hazelcast.wka.WKABasedMembershipScheme} -  Member joined [504bceff-4a08-46fe-83e6-b9561d3fff81]: /10.100.0.46:4001
            [2016-01-28 14:34:15,963]  INFO {org.wso2.carbon.event.processor.manager.commons.transport.client.TCPEventPublisher} -  Connecting to 10.100.0.46:11224
            [2016-01-28 14:34:15,972]  INFO {org.wso2.carbon.event.processor.manager.core.internal.EventHandler} -  CEP sync publisher initiated to Member '10.100.0.46:11224'
    ```

-   A CLI log similar to the following is displayed for the second node once it joins the cluster.

    ``` text
            [2016-01-28 14:34:27,086]  INFO {org.wso2.carbon.analytics.spark.core.internal.SparkAnalyticsExecutor} -  Spark Master map size after starting masters : 2
    ```

!!! info
Following are some exceptions you may view in the start up log when you start the cluster.

-   When you start the passive node of the HA cluster, the following errors are displayed.

    ??? info "Click here to view the errors"

        ``` text
            ERROR {org.wso2.carbon.event.processor.manager.core.internal.HAManager} -  CEP HA State syncing failed, No execution plans exist for tenant  -1234
            org.wso2.carbon.event.processor.manager.core.exception.EventManagementException: No execution plans exist for tenant  -1234
                at org.wso2.carbon.event.processor.core.internal.CarbonEventProcessorManagementService.restoreState(CarbonEventProcessorManagementService.java:83)
                at org.wso2.carbon.event.processor.manager.core.internal.HAManager.syncState(HAManager.java:336)
                at org.wso2.carbon.event.processor.manager.core.internal.HAManager.access$100(HAManager.java:49)
                at org.wso2.carbon.event.processor.manager.core.internal.HAManager$2.run(HAManager.java:276)
                at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
                at java.util.concurrent.FutureTask.run(FutureTask.java:266)
                at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$201(ScheduledThreadPoolExecutor.java:180)
                at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:293)
                at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
                at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
                at java.lang.Thread.run(Thread.java:745)
        ```

    This is because the artifacts are yet to be deployed in the passive node even though it has received the sync message from the active node. This error is no longer displayed once the start up for the passive node is complete.

-   When the Apache Spark Cluster is not properly instantiated, the following errors are displayed.

    ??? info "Click here to view the errors"

    ``` text
            [2016-09-13 13:59:34,000]  INFO {org.wso2.carbon.event.processor.manager.core.internal.CarbonEventManagementService} -  Starting polling event receivers
            [2016-09-13 14:00:05,018] ERROR {org.wso2.carbon.analytics.spark.core.CarbonAnalyticsProcessorService} -  Error while executing query :         CREATE TEMPORARY TABLE isSessionAnalyticsPerMinute USING CarbonAnalytics OPTIONS (tableName "org_wso2_is_analytics_stream_SessionStatPerMinute", schema "meta_tenantId INT -i, bucketId LONG, bucketStart LONG -i, bucketEnd LONG -i, year INT, month INT, day INT, hour INT, minute INT, activeSessionCount LONG, newSessionCount LONG, terminatedSessionCount LONG, _timestamp LONG -i", primaryKeys "meta_tenantId, bucketId, bucketStart, bucketEnd", incrementalParams "isSessionAnalyticsPerHour, HOUR", mergeSchema "false")
            org.wso2.carbon.analytics.spark.core.exception.AnalyticsExecutionException: Exception in executing query CREATE TEMPORARY TABLE isSessionAnalyticsPerMinute USING CarbonAnalytics OPTIONS (tableName "org_wso2_is_analytics_stream_SessionStatPerMinute", schema "meta_tenantId INT -i, bucketId LONG, bucketStart LONG -i, bucketEnd LONG -i, year INT, month INT, day INT, hour INT, minute INT, activeSessionCount LONG, newSessionCount LONG, terminatedSessionCount LONG, _timestamp LONG -i", primaryKeys "meta_tenantId, bucketId, bucketStart, bucketEnd", incrementalParams "isSessionAnalyticsPerHour, HOUR", mergeSchema "false")
                at org.wso2.carbon.analytics.spark.core.internal.SparkAnalyticsExecutor.executeQueryLocal(SparkAnalyticsExecutor.java:764)
                at org.wso2.carbon.analytics.spark.core.internal.SparkAnalyticsExecutor.executeQuery(SparkAnalyticsExecutor.java:721)
                at org.wso2.carbon.analytics.spark.core.CarbonAnalyticsProcessorService.executeQuery(CarbonAnalyticsProcessorService.java:201)
                at org.wso2.carbon.analytics.spark.core.CarbonAnalyticsProcessorService.executeScript(CarbonAnalyticsProcessorService.java:151)
                at org.wso2.carbon.analytics.spark.core.AnalyticsTask.execute(AnalyticsTask.java:60)
                at org.wso2.carbon.ntask.core.impl.TaskQuartzJobAdapter.execute(TaskQuartzJobAdapter.java:67)
                at org.quartz.core.JobRunShell.run(JobRunShell.java:213)
                at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
                at java.util.concurrent.FutureTask.run(FutureTask.java:266)
                at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
                at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
                at java.lang.Thread.run(Thread.java:745)
            Caused by: org.wso2.carbon.analytics.spark.core.exception.AnalyticsExecutionException: Spark SQL Context is not available. Check if the cluster has instantiated properly.
                at org.wso2.carbon.analytics.spark.core.internal.SparkAnalyticsExecutor.executeQueryLocal(SparkAnalyticsExecutor.java:755)
                ... 11 more
            [2016-09-13 14:00:05,018] ERROR {org.wso2.carbon.analytics.spark.core.CarbonAnalyticsProcessorService} -  Error while executing query :         CREATE TEMPORARY TABLE activeSessionTable USING CarbonAnalytics OPTIONS (tableName "ORG_WSO2_IS_ANALYTICS_STREAM_ACTIVESESSIONS", schema "meta_tenantId INT -i -f, sessionId STRING -i -f, startTimestamp LONG -i, renewTimestamp LONG -i, terminationTimestamp LONG -i, year INT, month INT, day INT, hour INT, minute INT, action INT -i -f, username STRING -i -f, userstoreDomain STRING -i -f, remoteIp STRING -i -f, region STRING -i -f, tenantDomain STRING -i -f, serviceProvider STRING -i -f, identityProviders STRING -i -f, rememberMeFlag BOOLEAN, userAgent STRING -i -f, usernameWithTenantDomainAndUserstoreDomain STRING -i -f, _timestamp LONG -i", primaryKeys "meta_tenantId, sessionId", mergeSchema "false")
            org.wso2.carbon.analytics.spark.core.exception.AnalyticsExecutionException: Exception in executing query CREATE TEMPORARY TABLE activeSessionTable USING CarbonAnalytics OPTIONS (tableName "ORG_WSO2_IS_ANALYTICS_STREAM_ACTIVESESSIONS", schema "meta_tenantId INT -i -f, sessionId STRING -i -f, startTimestamp LONG -i, renewTimestamp LONG -i, terminationTimestamp LONG -i, year INT, month INT, day INT, hour INT, minute INT, action INT -i -f, username STRING -i -f, userstoreDomain STRING -i -f, remoteIp STRING -i -f, region STRING -i -f, tenantDomain STRING -i -f, serviceProvider STRING -i -f, identityProviders STRING -i -f, rememberMeFlag BOOLEAN, userAgent STRING -i -f, usernameWithTenantDomainAndUserstoreDomain STRING -i -f, _timestamp LONG -i", primaryKeys "meta_tenantId, sessionId", mergeSchema "false")
                at org.wso2.carbon.analytics.spark.core.internal.SparkAnalyticsExecutor.executeQueryLocal(SparkAnalyticsExecutor.java:764)
                at org.wso2.carbon.analytics.spark.core.internal.SparkAnalyticsExecutor.executeQuery(SparkAnalyticsExecutor.java:721)
                at org.wso2.carbon.analytics.spark.core.CarbonAnalyticsProcessorService.executeQuery(CarbonAnalyticsProcessorService.java:201)
                at org.wso2.carbon.analytics.spark.core.CarbonAnalyticsProcessorService.executeScript(CarbonAnalyticsProcessorService.java:151)
                at org.wso2.carbon.analytics.spark.core.AnalyticsTask.execute(AnalyticsTask.java:60)
                at org.wso2.carbon.ntask.core.impl.TaskQuartzJobAdapter.execute(TaskQuartzJobAdapter.java:67)
                at org.quartz.core.JobRunShell.run(JobRunShell.java:213)
                at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)
                at java.util.concurrent.FutureTask.run(FutureTask.java:266)
                at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
                at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
                at java.lang.Thread.run(Thread.java:745)
            Caused by: org.wso2.carbon.analytics.spark.core.exception.AnalyticsExecutionException: Spark SQL Context is not available. Check if the cluster has instantiated properly.
                at org.wso2.carbon.analytics.spark.core.internal.SparkAnalyticsExecutor.executeQueryLocal(SparkAnalyticsExecutor.java:755)
                ... 11 more
    ```

    All the nodes in the Spark cluster should be started in order to stop this exception from occurring.


### Testing the HA deployment

The HA deployment you configured can be tested as follows.

1.  Access the Spark UIs of the active master and the stand-by master using &lt; `node ip>:8081` in each node.
    -   Information relating to the active master is displayed as shown in the example below.
        ![]({{base_path}}/assets/attachments/103334517/103334525.png)
    -   Information relating to the stand-by master is displayed as shown in the example below.
        ![]({{base_path}}/assets/attachments/103334517/103334526.png)
2.  Click the links under **Running Applications** in the Spark UI of the active master to check the Spark application UIs of those applications. A working application is displayed as shown in the following example.
    ![]({{base_path}}/assets/attachments/103334517/103334527.png)
3.  Click the **Environment** tab of a Spark application UI to check whether all the configuration parameters are correctly set. You can also check whether the class path variables in this tab can be accessed manually.
    ![]({{base_path}}/assets/attachments/103334517/103334528.png)
4.  Check the Spark UIs of workers to check whether they have running executors. If a worker UI does not have running executors or if it is continuously creating executors, it indicates an issue in the Spark cluster configuration. The following example shows a worker UI with a running executor.
    ![]({{base_path}}/assets/attachments/103334517/103334529.png)
5.  Check the symbolic parameter, and check if you could manually access it via a `cd <directory>` command in the CLI.
6.  [Log into the API-M Analytics Management Console](https://docs.wso2.com/display/DAS300/Running+the+Product) and navigate to **Main** =&gt; **Manage** =&gt; **Batch Analytics** =&gt; **Console** to open the **Interactive Analytics Console** . Run a query in this console.


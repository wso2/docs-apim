# Working with Hazelcast Clustering

Hazelcast is an in-memory data grid, which is used in clustering and distributed shared memory. When using Hazelcast as a clustering implementation, data is evenly distributed among the nodes in a cluster. Hazelcast clustering is disabled in WSO2 API Manager (WSO2 APIM) by default, because you can successfully deploy WSO2 API-M without Hazelcast. The following subsections explain as to when you need Hazelcast clustering with WSO2 API Manager (WSO2 APIM) and how you can configure it.

-   [When to use Hazelcast](#WorkingwithHazelcastClustering-WhentouseHazelcast)
-   [Deploying WSO2 API-M Manager with Hazelcast clustering](#WorkingwithHazelcastClustering-DeployingWSO2API-MManagerwithHazelcastclustering)
-   [Enabling Hazelcast clustering](#WorkingwithHazelcastClustering-EnablingHazelcastclustering)
-   [Configuring Hazelcast properties](#WorkingwithHazelcastClustering-ConfiguringHazelcastproperties)

### When to use Hazelcast

You can seamlessly deploy WSO2 API Manager using local caching in a clustered setup without Hazelcast clustering. However, the following are the edge case scenarios where you need to enable Hazelcast clustering.

-   **Immediate revocation of tokens among the gateways**
    If you deploy WSO2 API-M without Hazelcast clustering, you can set the time-to-live (TTL) value in secs in order to define the period after which the token will automatically be revoked in the other gateways. However, if you want the token in all the gateways to be immediately revoked, then you need to enable Hazelcast clustering.
-   **Backend service throttling**
    The endpoint throttling limits and the spike arrest throttling limits will not be shared across the cluster when Hazelcast clustering is disabled.

### Deploying WSO2 API-M Manager with Hazelcast clustering

Follow the instructions below to deploy WSO2 API-M with Hazelcast clustering:

1.  Carryout the instructions related to deploying WSO2 API-M.
2.  Carryout the instructions to [enable Hazelcast clustering](#WorkingwithHazelcastClustering-EnablingHazelcastclustering) .
3.  Start the WSO2 API-M servers.

### Enabling Hazelcast clustering

Follow the instructions below to enable Hazelcast clustering when deploying WSO2 API-M:

-   [Step 1 - Enable Hazelcast clustering in the Gateway Manager](#WorkingwithHazelcastClustering-Step1-EnableHazelcastclusteringintheGatewayManager)
-   [Step 2 - Enable Hazelcast clustering in the Gateway Worker](#WorkingwithHazelcastClustering-Step2-EnableHazelcastclusteringintheGatewayWorker)

#### Step 1 - Enable Hazelcast clustering in the Gateway Manager

1.  Open the `<GATEWAY_MANAGER_HOME>/repository/conf/axis2/axis2.xml` file.
2.  Locate the clustering section and verify or configure the properties as follows (some of these properties are already set correctly by default).
    1.  Enable clustering for this node:

        ``` java
                <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent" enable="true">
        ```

    2.  Set the membership scheme to `wka` to enable the well-known address registration method (this node will send cluster initiation messages to WKA members that we will define later):

        ``` java
                    <parameter name="membershipScheme">wka</parameter>
        ```

    3.  Specify the name of the cluster this node will join:

        ``` java
                    <parameter name="domain">wso2.am.domain</parameter>
        ```

    4.  Specify the host used to communicate cluster messages. This is the IP of the Gateway manager node.

        ``` java
                    <parameter name="localMemberHost">xxx.xxx.xxx.xx3</parameter>
        ```

    5.  Specify the port used to communicate cluster messages:

        ``` java
                    <parameter name="localMemberPort">4500</parameter>
        ```

                !!! info
        This port number will not be affected by the port offset in `carbon.xml` . If this port number is already assigned to another server, the clustering framework will automatically increment this port number. However, if two servers are running on the same machine, you must ensure that a unique port is set for each server.


    6.  Do the following port mapping configurations for the Gateway manager node. There are two types of transports in API Manager and when a request comes into the API Manager, it always goes to the default transport which is the PTT/NIO transport. So when you access the management console of the Gateway Manager node, you send a servlet request. If you do not specify the port mapping parameter in the manager node, it would hit the PTT/NIO transport and the request would fail.

        ``` xml
                <parameter name="properties">
                    <property name="backendServerURL" value="https://${hostName}:${httpsPort}/services/"/>
                    <property name="mgtConsoleURL" value="https://${hostName}:${httpsPort}/"/>
                    <property name="subDomain" value="mgt"/>
                    <property name="port.mapping.80" value="9763"/>
                    <property name="port.mapping.443" value="9443"/>
                </parameter>
        ```

        The receiver's HTTP/HTTPS port values are without the `portOffset` addition; they get auto-incremented by `portOffset` . In the case of an ESB cluster, the ' `WSDLEPRPrefix` ' parameter should point to the worker node's host name ( `am.wso2.com` ) and load balancer's http (80)/https (443) transport ports.

    7.  Change the members listed in the `<members>` element. This defines the WKA members.

        ``` xml
                    <members>
                        <member>
                              <hostName>xxx.xxx.xxx.xx3</hostName>
                              <port>4500</port>
                        </member>
                        <member>
                              <hostName>xxx.xxx.xxx.xx4</hostName>
                              <port>4200</port>
                        </member>
                    </members>
        ```

        Here we configure the manager node and worker node as the well-known members.

    8.  See the instructions on [configuring hazelcast properties](#WorkingwithHazelcastClustering-ConfiguringHazelcastproperties) given below.

#### Step 2 - Enable Hazelcast clustering in the Gateway Worker

1.  Open the `<GATEWAY_WORKER_HOME>/repository/conf/axis2/axis2.xml` file.
2.  Locate the clustering section and verify or configure the properties as follows (some of these properties are already set correctly by default):
    1.  Enable clustering for this node:

        ``` java
                    <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent" enable="true">
        ```

    2.  Set the membership scheme to `wka` to enable the Well Known Address registration method (this node will send cluster initiation messages to WKA members that we will define later):

        ``` java
                    <parameter name="membershipScheme">wka</parameter>
        ```

    3.  Specify the name of the cluster this node will join:

        ``` java
                    <parameter name="domain">wso2.am.domain</parameter>
        ```

    4.  Specify the host used to communicate cluster messages. This is the IP address of the Gateway worker.

        ``` java
                    <parameter name="localMemberHost">xxx.xxx.xxx.xx4</parameter>
        ```

    5.  Specify the port used to communicate cluster messages (if this node is on the same server as the manager node, or another worker node, be sure to set this to a unique value, such as 4000 and 4001 for worker nodes 1 and 2).

        ``` java
                    <parameter name="localMemberPort">4200</parameter>
        ```

                !!! info
        This port number will not be affected by the port offset in `carbon.xml` . If this port number is already assigned to another server, the clustering framework will automatically increment this port number. However, if two servers are running on the same machine, you must ensure that a unique port is set for each server.


    6.  Define the sub-domain as worker by adding the following property under the `<parameter name="properties">` element:

        ``` java
                <property name="subDomain" value="worker"/>
        ```

    7.  Define the manager and worker nodes as well-known members of the cluster by providing their host name and `localMemberPort` values. The manager node is defined here because it is required for the [Deployment Synchronizer](https://docs.wso2.com/display/CLUSTER44x/Configuring+Deployment+Synchronizer) to function in an efficient manner. The deployment synchronizer uses this configuration to identify the manager and synchronize deployment artifacts across the nodes of a cluster.

        ``` xml
                    <members>
                        <member>
                            <hostName>xxx.xxx.xxx.xx3</hostName>
                            <port>4500</port>
                        </member>
                        <member>
                            <hostName>xxx.xxx.xxx.xx4</hostName>
                            <port>4200</port>
                        </member>
                    </members>
        ```

                !!! note
        it is recommended to add at least two well-known members here. This is done to ensure that there is high availability for the cluster.

        You can also use IP address ranges for the `hostName` . For example,  192.168.1.2-10. This should ensure that the cluster eventually recovers after failures. One shortcoming of doing this is that you can define a range only for the last portion of the IP address. You should also keep in mind that the smaller the range, the faster the time it takes to discover members, since each node has to scan a lesser number of potential members.


    8.  See the instructions on [configuring hazelcast properties](#WorkingwithHazelcastClustering-ConfiguringHazelcastproperties) given below.

### Configuring Hazelcast properties

You can configure the hazelcast properties for the product nodes by following the steps given below.

1.  Create the `hazelcast.properties` file with the following property configurations, and copy the file to the `<GATEWAY_HOME>/repository/conf/` directory.

    ``` java
        #Disabling the hazelcast shutdown hook
        hazelcast.shutdownhook.enabled=false
        #Setting the hazelcast logging type to log4j
        hazelcast.logging.type=log4j
    ```

    The above configurations are explained below.

    -   **Hazelcast shutdown hook:** This configuration disables the shutdown hook in hazelcast, which ensures that the hazelcast instance shuts down gracefully whenever the product node shuts down. If the hazelcast shutdown hook is enabled (which is the default behavior of a product), you will see errors such as " *Hazelcast instance is not active!* " at the time of shutting down the product node: This is because the hazelcast instance shuts down too early when the shutdown hook is enabled.
    -   **Hazelcast logging type:** This configuration sets the hazelcast logging type to log4j, which allows hazelcast logs to be written to the `wso2carbon.log` file.

2.  If you have enabled log4j for hazelcast logging as shown above, be sure to enter the configuration shown below in the `log4j.properties` file (stored in the `<GATEWAY_HOME>/repository/conf/` directory ). This can be used to configure the log level for hazelcast logging. For a clustered production environment, it is recommended to use INFO as the log level as shown below.

    ``` java
            log4j.logger.com.hazelcast=INFO
    ```



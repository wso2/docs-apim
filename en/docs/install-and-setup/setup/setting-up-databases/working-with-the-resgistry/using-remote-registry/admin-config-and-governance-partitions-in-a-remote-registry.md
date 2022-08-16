# Config and Governance Partitions in a Remote Registry

In this deployment strategy, the configuration and governance spaces are shared among instances of a group/cluster. For example, two WSO2 Application Server instances that have been configured to operate in a clustered environment can have a single configuration and governance registry that is shared across each node of the cluster. A separate instance of the WSO2 Governance Registry is used to provide the space used in common.

![]({{base_path}}/assets/attachments/21037149/21331972.png)
Figure 2: Config and governance partitions in the remote Governance Registry instance .

Configuration steps are given in the following sections.

-   [Creating the Database](#ConfigandGovernancePartitionsinaRemoteRegistry-Database)
-   [Configuring Governance Registry as the Remote Registry Instance](#ConfigandGovernancePartitionsinaRemoteRegistry-RemoteRegistry)
-   [Configuring Carbon Server Nodes](#ConfigandGovernancePartitionsinaRemoteRegistry-CarbonServerNodes)

### Creating the database

In a production setup, it is recommended to use an Oracle or MySQL database for the governance registry. As an example, we use MySQL database named ‘registrydb’. Instructions are as follows:

1. Access MySQL using the command:

``` java
    mysql -u root -p
```

2. Enter the password when prompted.

3. Create 'registrydb' database.

``` java
    create database registrydb;
```

The MySQL database for G-Reg is now created.

### Configuring Governance Registry as the remote registry instance

Database configurations are stored in $CARBON\_HOME/repository/conf/datasources/ master-datasources.xml file for all carbon servers. By default, all WSO2 products use the in-built H2 database. Since Governance Registry in this example is using a MySQL database named 'registrydb', the master-datasources.xml file needs to be configured so that the datasource used for the registry and user manager in Governance Registry is the said MySQL database.

1. Download and extract WSO2 Governance Registry distribution from [http://wso2.com/products/governance-registry.](http://wso2.com/products/governance-registry/)

2. Navigate to $G-REG\_HOME/repository/conf/datasources/master-datasources.xml file where G-REG\_HOME is the Governance Registry distribution home. Replace the existing WSO2\_CARBON\_DB datasource with the following configuration:

``` html/xml
    <datasource>
       <name>WSO2_CARBON_DB</name>
       <description>The datasource used for registry and user manager</description>
       <jndiConfig>
            <name>jdbc/WSO2CarbonDB</name>
       </jndiConfig>
       <definition type="RDBMS">
           <configuration>
               <url>jdbc:mysql://x.x.x.x:3306/registrydb</url>
               <username>root</username>
               <password>root</password>
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

Change the values of the following elements according to your environment.

-   &lt;url&gt; : URL of the MySQL database.
-   &lt;username&gt; and &lt;password&gt; : username and password of the mySQL database .
-   &lt;validationQuery&gt; : Validate and test the health of the DB connection .
-   &lt;validationInterval&gt; : specified time intervals at which the DB connection validations should run .

3. Navigate to $G-REG\_HOME /repository/conf/axis2/axis2.xml file in all Carbon-based product instances to be connected with the remote registry, and enable tribes clustering with the following configuration.

``` html/xml
    <clustering class="org.apache.axis2.clustering.tribes.TribesClusteringAgent" enable="true"/>
```

The above configuration is required only when caching is enabled for the Carbon server instances and &lt;enableCache&gt; parameter is set to true. This provides cache invalidation at the event of any updates on the registry resources.

4. Copy the 'mySQL JDBC connector jar ' ( <http://dev.mysql.com/downloads/connector/j/5.1.html> ) to G-REG\_HOME/repository/components/lib directory.

5. Start the Governance Registry server with -Dsetup so that all the required tables are created in the database. For example, in Linux

``` java
    sh wso2server.sh -Dsetup
```

!!! warning
Deprecation of -DSetup

When proper Database Administrative (DBA) practices are followed, the systems (except analytics products) are not granted DDL (Data Definition) rights on the schema. Therefore, maintaining the `-DSetup` option is redundant and typically unusable. **As a result, from [January 2018 onwards](https://wso2.com/products/carbon/release-matrix/) WSO2 has deprecated the `-DSetup` option** . Note that the proper practice is for the DBA to run the DDL statements manually so that the DBA can examine and optimize any DDL statement (if necessary) based on the DBA best practices that are in place within the organization.


The Governance Registry server is now running with all required user manager and registry tables for the server also created in ‘registrydb’ database.

### Configuring server nodes

Now that the shared registry is configured, let's take a look at the configuration of Carbon server nodes that use the shared, remote registry.

1. Download and extract the relevant WSO2 product distribution from the 'Products' menu of [https://wso2.com](https://wso2.com/) . In this example, we use two server instances (of any product) by the names CARBON-Node1 and CARBON-Node2.

2. We use the same datasource used for Governance Registry above as the registry space of Carbon-based product instances.

***Configuring master-datasources.xml file***

3. Configure $CARBON \_HOME/repository/conf/datasource/master-datasources.xml where CARBON \_HOME is the distribution home of any WSO2 Carbon-based product you downloaded in step 1. Then, add the following datasource for the registry space.

``` html/xml
    <datasource>
               <name>WSO2_CARBON_DB_GREG</name>
               <description>The datasource used for registry and user manager</description>
               <jndiConfig>
                    <name>jdbc/WSO2CarbonDB_GREG</name>
               </jndiConfig>
               <definition type="RDBMS">
                <configuration>
                           <url>jdbc:mysql://x.x.x.x:3306/registrydb</url>
                           <username>root</username>
                           <password>root</password>
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

Change the values of the relevant elements accordingly. **

***Configuring registry.xml file***

4. Navigate to $CARBON\_ HOME/repository/conf/registry.xml file and specify the following configurations for both server instances setup in step 1.

Add a new db config to the datasource configuration done in step 3 above. For example,

``` html/xml
    <dbConfig name="remote_registry">
          <dataSource>jdbc/WSO2CarbonDB_GREG</dataSource>
    </dbConfig>
```

Specify the remote Governance Registry instance with the following configuration:

``` html/xml
    <remoteInstance url="https://x.x.x.x:9443/registry">
        <id>instanceid</id>
        <dbConfig>remote_registry</dbConfig>
        <cacheId>root@https://x.x.x.x:9443/registry</cacheId>
        <readOnly>false</readOnly>
        <enableCache>true</enableCache>
        <registryRoot>/</registryRoot>
    </remoteInstance>
```

Change the values of the following elements according to your environment.

-   &lt;remoteInstance url&gt; : URL of the remote G-Reg instance.
-   &lt;dbConfig&gt; : The dbConfig name specified for the registry database configuration.
-   &lt;cacheId&gt; : This provides information on where the cache resource resides.
-   &lt;enableCache&gt; : Whether caching is enabled on the Carbon server instance.

Define the registry partitions using the remote Governance Registry instance. In this deployment strategy, we are mounting the config and governance partitions of the Carbon-based product instances to the remote Governance Registry instance. This is graphically represented in Figure 2 at the beginning.

``` html/xml
    <mount path="/_system/config" overwrite="true">
        <instanceId>instanceid</instanceId>
        <targetPath>/_system/config</targetPath>
    </mount>
    <mount path="/_system/governance" overwrite="true">
        <instanceId>instanceid</instanceId>
        <targetPath>/_system/governance</targetPath>
    </mount>
```

-   mount path : Registry collection of Carbon server instance that needs to be mounted
-   mount overwrite : Defines if an existing collection/resource at the given path should be overwritten or not. Possible vales are:
    -   true - The existing collection/resource in the specified location will always be deleted and overwritten with the resource/s in the remote registry instance.
    -   false - The resource/s will not be overwritten. An error will be logged if a resource exists at the existing location.
    -   virtual - If the existing location has a resource/collection, it will be preserved but virtual view of the remote registry resource/s can be viewed. The original resource/collection can be viewed once the remote registry configuration is removed.
-   target path : Path to the remote Governance Registry instance where the registry collection is mounted. In each of the mounting configurations, we specify the actual mount path and target mount path. The `targetPath` can be any meaningful name.

***Configuring axis2.xml file***

1. Navigate to $CARBON \_HOME/repository/conf/axis2/axis2.xml file where CARBON \_HOME is the distribution home of any WSO2 Carbon-based products to be connected with the remote registry. Enable carbon clustering by copying the following configuration to all Carbon server instances:

``` html/xml
    <clustering class="org.apache.axis2.clustering.tribes.TribesClusteringAgent" enable="true"/>
```

!!! info
Note


2. Copy 'MySQL JDBC connector jar' ( [http://dev.mysql.com/downloads/connector/j/5.1.html)](http://dev.mysql.com/downloads/connector/j/5.1.html) to $ G-REG\_HOME/repository/components/lib in both Carbon server instances.

3. Start both servers and note the log entries that indicate successful mounting to the remote Governance Registry instance. For example,

![]({{base_path}}/assets/attachments/21037149/21332021.png)
4. Navigate to the registry browser in the Carbon server's management console and note the config and governance partitions indicating successful mounting to the remote registry instance. For example,

![]({{base_path}}/assets/attachments/21037149/21332022.png)
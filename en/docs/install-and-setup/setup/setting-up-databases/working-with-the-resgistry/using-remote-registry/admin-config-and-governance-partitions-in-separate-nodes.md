# Config and Governance Partitions in Separate Nodes

In this deployment strategy, let's assume 2 clusters of Carbon-based product Foo and Carbon-based product Bar that share a governance registry space by the name G-Reg 1. In addition, the product Foo cluster shares a configuration registry space by the name G-Reg 2 and the product Bar cluster shares a configuration registry space by the name G-Reg 3.

![]({{base_path}}/assets/attachments/126562675/126562676.png)
Figure 4: Config and governance partitions in separate registry instances .

Configuration steps are given in the following sections.

-   [Creating the Database](#ConfigandGovernancePartitionsinSeparateNodes-Database)
-   [Configuring the Remote Registry Instances](#ConfigandGovernancePartitionsinSeparateNodes-RemoteRegistry)
-   Configuring Foo Product Cluster
-   Configuring Bar Product Cluster

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

The MySQL database for G-Reg 1 is now created. Similarly create 'registrydb 2' and ' registrydb 3' as the MySQL databases for G-Reg 2 and G-Reg 3 respectively.

### Configuring the Remote Registry instances

Database configurations are stored in $CARBON\_HOME/repository/conf/datasources/ master-datasources.xml file for all carbon servers. By default, all WSO2 products use the in-built H2 database. Since the Governance Registry nodes ( G-Reg 1 , G-Reg 2 and G-Reg 3) in this example are using MySQL databases ( 'registrydb', 'registrydb2' and 'registrydb3' respectively ) the master-datasources.xml file of each node needs to be configured so that the datasources used for the registry, user manager and configuration partitions in Governance Registry are the said MySQL databases.

1. Download and extract WSO2 Governance Registry distribution from [http://wso2.com/products/governance-registry.](http://wso2.com/products/governance-registry/)

2. First, navigate to $G-REG\_HOME/repository/conf/datasources/master-datasources.xml file where G-REG\_HOME is the distribution home of Governance Registry of G-Reg 1. Replace the existing WSO2\_CARBON\_DB datasource with the following configuration:

``` html/xml
    <datasource>
       <name>WSO2_CARBON_DB</name>
       <description>The datasource used for registry and user manager</description>
       <jndiConfig>
            <name>jdbc/WSO2CarbonDB</name>
       </jndiConfig>
       <definition type="RDBMS">
           <configuration>
               <url>jdbc:mysql://10.20.30.41:3306/registrydb</url>
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

3. Similarly, replace the existing WSO2\_CARBON\_DB datasource in G-Reg 2 with the following :

``` html/xml
    <datasource>
       <name>WSO2_CARBON_DB</name>
       <description>The datasource used for registry and user manager</description>
       <jndiConfig>
            <name>jdbc/WSO2CarbonDB</name>
       </jndiConfig>
       <definition type="RDBMS">
           <configuration>
               <url>jdbc:mysql://10.20.30.42:3306/registrydb2</url>
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

4. Repeat the same for G-Reg 3 as follows.

``` html/xml
    <datasource>
       <name>WSO2_CARBON_DB</name>
       <description>The datasource used for registry and user manager</description>
       <jndiConfig>
            <name>jdbc/WSO2CarbonDB</name>
       </jndiConfig>
       <definition type="RDBMS">
           <configuration>
               <url>jdbc:mysql://10.20.30.43:3306/registrydb3</url>
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

5. Navigate to $G-REG\_HOME /repository/conf/axis2/axis2.xml file in all instances and enable clustering with the following configuration.

``` html/xml
    <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent" enable="false"/>
```

The above configuration is required only when caching is enabled for the Carbon server instances and &lt;enableCache&gt; parameter is set to true. This provides cache invalidation at the event of any updates on the registry resources.

6. Copy the 'mySQL JDBC connector jar ' ( <http://dev.mysql.com/downloads/connector/j/5.1.html> ) to G-REG\_HOME/repository/components/lib directory in G-Reg 1, G-Reg 2 and G-Reg 3.

7. Start the Governance Registry servers with -Dsetup so that all the required tables will be created in the databases. For example, in Linux

``` java
    sh wso2server.sh -Dsetup
```

!!! warning
Deprecation of -DSetup

When proper Database Administrative (DBA) practices are followed, the systems (except analytics products) are not granted DDL (Data Definition) rights on the schema. Therefore, maintaining the `-DSetup` option is redundant and typically unusable. **As a result, from [January 2018 onwards](https://wso2.com/products/carbon/release-matrix/) WSO2 has deprecated the `-DSetup` option** . Note that the proper practice is for the DBA to run the DDL statements manually so that the DBA can examine and optimize any DDL statement (if necessary) based on the DBA best practices that are in place within the organization.


The Governance Registry server instances are now running with all required user manager and registry tables for the server created in ‘registrydb’, ‘registrydb1’ and ‘registrydb2’ databases.

### Configuring the foo product cluster

Now that the shared registry nodes are configured, let's take a look at the configuration of Carbon server clusters that share the remote registry instances. Namely, Foo product cluster shares G-Reg 1 and G-Reg 2 while Bar product cluster shares G-Reg 1 and G-Reg 3.

Include the following configurations in the master node of Foo product cluster.

***Configuring master-datasources.xml file***

1. Configure $CARBON \_HOME/repository/conf/datasource/master-datasources.xml where CARBON \_HOME is the distribution home of any WSO2 Carbon-based product. Then, add the following datasource for the registry space.

``` html/xml
    <datasource>
          <name>WSO2_CARBON_DB_GREG</name>
          <description>The datasource used for registry and user manager</description>
          <jndiConfig>
                <name>jdbc/WSO2CarbonDB_GREG</name>
          </jndiConfig>
          <definition type="RDBMS">
             <configuration>
                  <url>jdbc:mysql://10.20.30.41:3306/registrydb</url>
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
<datasource>
      <name>WSO2_CARBON_DB_GREG_CONFIG</name>
      <description>The datasource used for configuration partition</description>
      <jndiConfig>
            <name>jdbc/WSO2CarbonDB_GREG_CONFIG</name>
      </jndiConfig>
      <definition type="RDBMS">
         <configuration>
              <url>jdbc:mysql://10.20.30.42:3306/registrydb2</url>
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
Change the values of the relevant elements according to your environment.

***Configuring registry.xml file***

2. Navigate to $CARBON\_ HOME/repository/conf/registry.xml file and specify the following configurations.

Add a new db config to the datasource configuration done in step 1 above. For example,

``` html/xml
    <dbConfig name="governance_registry">
          <dataSource>jdbc/WSO2CarbonDB_GREG</dataSource>
    </dbConfig>
    <dbConfig name="config_registry">
          <dataSource>jdbc/WSO2CarbonDB_GREG_CONFIG</dataSource>
    </dbConfig>
```

Specify the remote Governance Registry instance with the following configuration:

``` html/xml
    <remoteInstance url="https://10.20.30.41:9443/registry">
        <id>governanceRegistryInstance</id>
        <dbConfig>governance_registry</dbConfig>
        <cacheId>root@https://10.20.30.41:9443/registry</cacheId>
        <readOnly>false</readOnly>
        <enableCache>true</enableCache>
        <registryRoot>/</registryRoot>
    </remoteInstance>
<remoteInstance url="https://10.20.30.42:9443/registry">
    <id>configRegistryInstance</id>
    <dbConfig>config_registry</dbConfig>
    <cacheId>root@https://10.20.30.42:9443/registry</cacheId>
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

!!! info
Note

When adding the corresponding configuration to the registry.xml file of a slave node, set &lt;readOnly&gt;true&lt;/readOnly&gt;. This is the only configuration change.


Define the registry partitions using the remote Governance Registry instance.

``` html/xml
    <mount path="/_system/config" overwrite="true">
        <instanceId>configRegistryInstance</instanceId>
        <targetPath>/_system/config</targetPath>
    </mount>
    <mount path="/_system/governance" overwrite="true">
        <instanceId>governanceRegistryInstance</instanceId>
        <targetPath>/_system/governance</targetPath>
    </mount>
```

-   mount path : Registry collection of Carbon server instance that needs to be mounted
-   mount overwrite : Defines if an existing collection/resource at the given path should be overwritten or not. Possible vales are:
    -   true - The existing collection/resource in the specified location will always be deleted and overwritten with the resource/s in the remote registry instance.
    -   false - The resource/s will not be overwritten. An error will be logged if a resource exists at the existing location.
    -   virtual - If the existing location has a resource/collection, it will be preserved but virtual view of the remote registry resource/s can be viewed. The original resource/collection can be viewed once the remote registry configuration is removed.
-   target path : Path to the remote Governance Registry instance where the registry collection is mounted.

***Configuring axis2.xml file***

3. Navigate to $CARBON \_HOME/repository/conf/axis2/axis2.xml file and enable carbon clustering by copying the following configuration to all Carbon server instances:

``` html/xml
    <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent" enable="false"/>
```

!!! info
Note


4. Copy 'MySQL JDBC connector jar' ( [http://dev.mysql.com/downloads/connector/j/5.1.html)](http://dev.mysql.com/downloads/connector/j/5.1.html) to $ G-REG\_HOME/repository/components/lib in Carbon server instances of Foo product cluster.

### Configuring the bar product cluster

The instructions here are similar to that of the Foo product cluster discussed above. The difference is that Bar product cluster shares G-Reg 1 (Governance space) and G-Reg 3 (Config space) remote registry spaces whereas Foo product cluster shares G-Reg 1 and G-Reg 2 (Config space).

Include the following configurations in the master node of Foo product cluster.

***Configure master-datasources.xml file***

1. Configure $CARBON \_HOME/repository/conf/datasource/master-datasources.xml where CARBON \_HOME is the distribution home of any WSO2 Carbon-based product. Then, add the following datasource for the registry space.

``` html/xml
    <datasource>
          <name>WSO2_CARBON_DB_GREG</name>
          <description>The datasource used for registry and user manager</description>
          <jndiConfig>
                <name>jdbc/WSO2CarbonDB_GREG</name>
          </jndiConfig>
          <definition type="RDBMS">
             <configuration>
                  <url>jdbc:mysql://10.20.30.41:3306/registrydb</url>
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
<datasource>
      <name>WSO2_CARBON_DB_GREG_CONFIG</name>
      <description>The datasource used for configuration partition</description>
      <jndiConfig>
            <name>jdbc/WSO2CarbonDB_GREG_CONFIG</name>
      </jndiConfig>
      <definition type="RDBMS">
         <configuration>
              <url>jdbc:mysql://10.20.30.43:3306/registrydb2</url>
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
Change the values of the relevant elements according to your environment. ******

***Configuring registry.xml file***

2. Navigate to $CARBON\_ HOME/repository/conf/registry.xml file and specify the following configurations.

Add a new db config to the datasource configuration done in step 1 above. For example,

``` html/xml
    <dbConfig name="governance_registry">
          <dataSource>jdbc/WSO2CarbonDB_GREG</dataSource>
    </dbConfig>
    <dbConfig name="config_registry">
          <dataSource>jdbc/WSO2CarbonDB_GREG_CONFIG</dataSource>
    </dbConfig>
```

Specify the remote Governance Registry instance with the following configuration:

``` html/xml
    <remoteInstance url="https://10.20.30.41:9443/registry">
        <id>governanceRegistryInstance</id>
        <dbConfig>governance_registry</dbConfig>
        <cacheId>root@https://10.20.30.41:9443/registry</cacheId>
        <readOnly>false</readOnly>
        <enableCache>true</enableCache>
        <registryRoot>/</registryRoot>
    </remoteInstance>
<remoteInstance url="https://10.20.30.43:9443/registry">
    <id>configRegistryInstance</id>
    <dbConfig>config_registry</dbConfig>
    <cacheId>root@https://10.20.30.43:9443/registry</cacheId>
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

!!! info
Note

When adding the corresponding configuration to the registry.xml file of a slave node, set &lt;readOnly&gt;true&lt;/readOnly&gt;. This is the only configuration change.


Define the registry partitions using the remote Governance Registry instance.

``` html/xml
    <mount path="/_system/config" overwrite="true">
        <instanceId>configRegistryInstance</instanceId>
        <targetPath>/_system/config</targetPath>
    </mount>
    <mount path="/_system/governance" overwrite="true">
        <instanceId>governanceRegistryInstance</instanceId>
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

3. Navigate to $CARBON \_HOME/repository/conf/axis2/axis2.xml file and enable carbon clustering by copying the following configuration to all Carbon server instances:

``` html/xml
    <clustering class="org.wso2.carbon.core.clustering.hazelcast.HazelcastClusteringAgent" enable="false"/>
```

!!! info
Note


4. Copy 'MySQL JDBC connector jar' ( [http://dev.mysql.com/downloads/connector/j/5.1.html)](http://dev.mysql.com/downloads/connector/j/5.1.html) to $ G-REG\_HOME/repository/components/lib in Carbon server instances of Bar product cluster.

5. Start both clusters and note the log entries that indicate successful mounting to the remote Governance Registry nodes.

6. Navigate to the registry browser in the Carbon server's management console of a selected node and note the config and governance partitions indicating successful mounting to the remote registry instances.

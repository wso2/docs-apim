# Installing and Configuring the Databases

The following steps describe how to download and install a RDBMS, which in this case is a MySQL Server, create the databases, configure the data sources, and configure the API Manager components to connect to them.

!!! warning
Although the following section instructs you to use MySQL Server, **you can use any RDBMS** in your deployment based on your preference. For information on working with other databases, see \_Changing the Default API-M Databases .

!!! info
The steps involved in installing and configuring the databases are the same irrespective of whether you are using a single node (standalone) deployment, an active-active deployment, or a distributed deployment.


1.  Unzip the WSO2 API Manager pack. Let's call it `           <API-M_HOME>          ` .

2.  Download and install [MySQL Server](http://dev.mysql.com/downloads/) .

3.  Download the [MySQL JDBC driver](http://dev.mysql.com/downloads/connector/j/) .

4.  Unzip the downloaded MySQL driver archive, and copy the MySQL JDBC driver JAR ( `           mysql-connector-java-x.x.xx-bin.jar          ` ) into the `           <API-M_HOME>/repository/components/lib          ` directory in all the nodes in the cluster.

5.  Define the hostname for configuring permissions for the new database by opening the `           /etc/hosts          ` file and adding the following:

        !!! warning
    Do this step only if your database is not on your local machine and on a separate server.


    ``` java
        <MYSQL-DB-SERVER-IP> carbondb.mysql-wso2.com
    ```

6.  Install mysql-client in each of the API-M servers in which WSO2 API-M is deployed.
    You need to do this in order to check if the servers can access the MySQL database.

    ``` java
            sudo apt install mysql-client
            mysql -h <mysqldb_host_ip> -u username -p
    ```

7.  Enter the following command in a command prompt, where `           username          ` is the username that you used to access the databases.

    ``` java
            mysql -u username -p
    ```

8.  When prompted, specify the password that will be used to access the databases with the username you specified.

9.  Create the databases using the following commands, where `           <API-M_HOME>          ` is the path to any of the API Manager instances you installed, and `           username          ` and `           password          ` are the same as those you specified in the previous steps.

        !!! note
    WSO2 API Manager is shipped with an H2 database. This embedded H2 database is suitable for development and testing environments. However, for **production environments,** it is recommended to use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, MS SQL, etc. The following steps explain how to create MySQL DBs.

        !!! info
    About using MySQL in different operating systems

    For users of Microsoft Windows, when creating the database in MySQL, it is important to specify the character set as latin1. Failure to do this may result in an error (error code: 1709) when starting your cluster. This error occurs in certain versions of MySQL (5.6.x) and is related to the UTF-8 encoding. MySQL originally used the latin1 character set by default, which stored characters in a 2-byte sequence. However, in recent versions, MySQL defaults to UTF-8 to be friendlier to international users. Hence, you must use latin1 as the character set as indicated below in the database creation commands to avoid this problem. Note that this may result in issues with non-latin characters (like Hebrew, Japanese, etc.). The following is how your database creation command should look.

        mysql> create database <DATABASE_NAME> character set latin1;

    For users of other operating systems, the standard database creation commands are sufficient. For these operating systems, the following is how your database creation command should look.

        mysql> create database <DATABASE_NAME>;

        !!! note
    If you are using MySQL to configure your datasources, we recommend that you use a case sensitive database collation. For more information, see the [MySQL Official Manual](https://dev.mysql.com/doc/refman/5.7/en/charset-mysql.html) . The default database collation, which is `                       latin1_swedish_ci                     ` , is case insensitive. However, you need to maintain case sensivity for database collation, because when the database or table has a case-insensitive collation in MySQL 5.6 or 5.7, if a user creates an API with letters using mixed case, deletes the API, and then creates another API with the same name, but in lower case letters, then the later created API loses its permission information, because when deleting the API, it keeps the Registry collection left behind.

    This issue could be avoided if you use a case sensitive collation for database and tables. In that case, when creating the second API (which has the same name, but is entirely in lowercase letters), it will create a new record with the lowercase name in the `           UM_PERMISSION          ` table.

        !!! note
    Additional notes

    -   Ensure that MySQL is configured so that all nodes can connect to it.
    -   From WSO2 API Manager 2.0.0 onwards there are two MySQL DB scripts available in the product distribution. Click [here](https://docs.wso2.com/display/AM2xx/FAQ#FAQ-WhichMySQLdatabasescriptshouldIuse?) to identify as to which version of the MySQL script to use.
    -   Table creation of the statistics database is handled by the Analytics scripts when you [configure APIM Analytics](https://docs.wso2.com/display/AM200/Configuring+APIM+Analytics) , so you will create the statistics database in this step but will not specify a source script.
    -   To access the databases from remote instances, its required to grant permission to the relevant username defined in the `            <API-M_HOME>/repository/conf/datasources/master-datasources.xml           ` file, by using the grant command. See the following sample commands.


    -   [**Format**](#654e0173796345a0b961733f09e063fa)
    -   [**Sample**](#277a27910bc54648ba75cf76df0dc45c)

    ``` plain
        mysql> create database apimgtdb;
        mysql> use apimgtdb;
        mysql> source <API-M_HOME>/dbscripts/apimgt/mysql.sql;
        mysql> grant all on apimgtdb.* TO '<username>'@'%' identified by '<password>';
    mysql> create database userdb;
    mysql> use userdb;
    mysql> source <API-M_HOME>/dbscripts/mysql.sql;
    mysql> grant all on userdb.* TO '<username>'@'%' identified by '<password>';

    mysql> create database regdb;
    mysql> use regdb;
    mysql> source <API-M_HOME>/dbscripts/mysql.sql;
    mysql> grant all on regdb.* TO '<username>'@'%' identified by '<password>';
     
    mysql> create database statdb;
    mysql> use statdb;
    mysql> grant all on statdb.* TO '<username>'@'%' identified by '<password>';
     
    mysql> create database mbstoredb;
    mysql> use mbstoredb;
    mysql> source <API-M_HOME>/dbscripts/mb-store/mysql-mb.sql;
    mysql> grant all on mbstoredb.* TO '<username>'@'%' identified by '<password>';
    ```
    ``` java
        mysql> create database apimgtdb;
        mysql> use apimgtdb;
        mysql> source <API-M_HOME>/dbscripts/apimgt/mysql.sql;
        mysql> grant all on apimgtdb.* TO 'wso2user'@'%' identified by 'wso2123';
    mysql> create database userdb;
    mysql> use userdb;
    mysql> source <API-M_HOME>/dbscripts/mysql.sql;
    mysql> grant all on userdb.* TO 'wso2user'@'%' identified by 'wso2123';

    mysql> create database regdb;
    mysql> use regdb;
    mysql> source <API-M_HOME>/dbscripts/mysql.sql;
    mysql> grant all on regdb.* TO 'wso2user'@'%' identified by 'wso2123';

    mysql> create database statdb;
    mysql> use statdb; 
    mysql> grant all on statdb.* TO 'wso2user'@'%' identified by 'wso2123';
     
    mysql> create database mbstoredb;
    mysql> use mbstoredb;
    mysql> source <API-M_HOME>/dbscripts/mb-store/mysql-mb.sql;
    mysql> grant all on mbstoredb.* TO 'wso2user'@'%' identified by 'wso2123';
    ```
        !!! note
        In the sample commands above, its assumed that the username and password defined in the datasource configurations in `              <API-M_HOME>/repository/conf/datasources/master-datasources.xml             ` file is **wso2user** and **wso2123** respectively,

10. Configure the data sources for the five databases as follows:

    1.  Open the `             <API-M_HOME>/repository/conf/datasources/master-datasources.xml            ` file.
        This file contains the different datasources used by WSO2 API Manager. By default, the API Manager connects to the local H2 database and it is recommended to use a separate RDBMS server for a production deployment.

        -   **If you are configuring API-M in a single node** , open the `              master-datasources.xml             ` in the single WSO2 API-M instance.
        -   I **f you are configuring API-M in a distributed setup** , open the `              master-datasources.xml             ` in all five WSO2 API-M components.

                !!! tip
        For more information, see [Configuring master-datasources.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+master-datasources.xml) in the Administration Guide.

                !!! note
        **Note** : When configuring clustering, ignore the `             WSO2_CARBON_DB            ` data source configuration.


    2.  Enable the components to access the WSO2 API Manager database by modifying the **`              WSO2AM_DB             `** data source in the `             master-datasources.xml            ` file by changing the URL as indicated below. Make sure to also replace `             db.mysql-wso2.com            ` with the hostname you specified in [step 5](#InstallingandConfiguringtheDatabases-stepDB5) ( `             carbondb.mysql-wso2.com            ` ).

        -   **If you are configuring API-M in a single node** , open the `              master-datasources.xml             ` in the single WSO2 API-M instance.
        -   I **f you are configuring API-M in a distributed setup** , open the `              master-datasources.xml             ` in the Publisher, Store, and Key Manager nodes.

            The page: **\_Understanding the Distributed Deployment of WSO2 API-M** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

        ``` xml
                <datasource>
                 <name>WSO2AM_DB</name>
                 <description>The datasource used for the API Manager database</description>
                 <jndiConfig>
                   <name>jdbc/WSO2AM_DB</name>
                 </jndiConfig>
                 <definition type="RDBMS">
                   <configuration>
                     <url>jdbc:mysql://db.mysql-wso2.com:3306/apimgtdb?autoReconnect=true</url>
                     <username>user</username>
                     <password>password</password>
                     <defaultAutoCommit>false</defaultAutoCommit>
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

    3.  Enable the Key Manager, Publisher, and Store components to access the user management database.
        You need to do this by adding the following code in the `             master-datasources.xml            ` file and changing `             db.mysql-wso2.com            ` to `             carbondb.mysql-wso2.com            ` in order to configure the **`              WSO2UM_DB             `** data source.

        -   **If you are configuring API-M in a single node** , open the `              master-datasources.xml             ` in the single WSO2 API-M instance.
        -   I **f you are configuring API-M in a distributed setup** , open the `              master-datasources.xml             ` in the Publisher, Store, and Key Manager nodes.

        ``` xml
                    <datasource>
                     <name>WSO2UM_DB</name>
                     <description>The datasource used by user manager</description>
                     <jndiConfig>
                       <name>jdbc/WSO2UM_DB</name>
                     </jndiConfig>
                     <definition type="RDBMS">
                       <configuration>
                         <url>jdbc:mysql://db.mysql-wso2.com:3306/userdb?autoReconnect=true</url>
                         <username>user</username>
                         <password>password</password>
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

    4.  Enable access to registry databases by adding the **`              WSO2REG_DB             `** data sources related configuration in their `             master-datasources.xml            ` files as follows. The components that need to access the registry database differs, based on whether the setup is multi tennanted or not.

        -   [**Single Tenant Setup**](#9dffc186a5444a2ca30cfae7d31a96c4)
        -   [**Multi Tenanted Setup**](#0330750c411846f0a1fde72bfbee48ad)

        The configuration needs to be added to API Publisher and Store components.

        The configuration needs to be added to API Publisher, Store, Key Manager, and Gateway components.

        ``` xml
                    <datasource>
                     <name>WSO2REG_DB</name>
                     <description>The datasource used by the registry</description>
                     <jndiConfig>
                       <name>jdbc/WSO2REG_DB</name>
                     </jndiConfig>
                     <definition type="RDBMS">
                       <configuration>
                         <url>jdbc:mysql://db.mysql-wso2.com:3306/regdb?autoReconnect=true</url>
                         <username>user</username>
                         <password>password</password>
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

    5.  Enable the Publisher and Store components to access the statistics databases by configuring the **`              WSO2AM_STATS_DB             `** data sources in their `             master-datasources.xml            ` files as follows:

                !!! note
        When deploying API-M in a distributed deployment, you need to share the `             WSO2AM_STATS_DB            ` with the following components:

        -   Publisher and the Store - to be able to read from the `               WSO2AM_STATS_DB              ` .


        ``` xml
                <datasource>
                 <name>WSO2AM_STATS_DB</name>
                 <description>The datasource used for getting statistics to API Manager</description>
                 <jndiConfig>
                   <name>jdbc/WSO2AM_STATS_DB</name>
                 </jndiConfig>
                 <definition type="RDBMS">
                   <configuration>
                     <url>jdbc:mysql://db.mysql-wso2.com:3306/statdb?autoReconnect=true</url>
                     <username>user</username>
                     <password>password</password>
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

    6.  Enable the Traffic Manager component to access the Message Broker database by configuring the **`              WSO2_MB_STORE_DB             `** data source, which is in its `             master-datasources.xml            ` file as follows:

                !!! warning
        -   **Do not share** the **`               WSO2_MB_STORE_DB              `** database among the nodes i n an **Active-Active set-up** or **Traffic Manager HA** scenario, because each node should have its own local `              WSO2_MB_STORE_DB             ` database to act as separate Traffic Managers.
        -   The latter mentioned DBs can be either H2 DBs or any RDBMS such as MySQL.

        -   If the database gets corrupted then you need to replace the database with a fresh database that is available in the product distribution.


        ``` xml
                <datasource>
                 <name>WSO2_MB_STORE_DB</name>
                 <description>The datasource used for message broker database</description>
                 <jndiConfig>
                   <name>WSO2MBStoreDB</name>
                 </jndiConfig>
                 <definition type="RDBMS">
                   <configuration>
                     <url>jdbc:mysql://db.mysql-wso2.com:3306/mbstoredb?autoReconnect=true</url>
                     <username>user</username>
                     <password>password</password>
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
        ```

11. To give the Key Manager, Publisher, and Store components access to the user management database with shared permissions, open the `           <API-M_HOME>/repository/conf/user-mgt.xml          ` file in each of these three components and add or modify the `           dataSource          ` property that corresponds to the `           <configuration>          ` element as follows:
    For more information, see [Configuring User Stores](https://docs.wso2.com/display/AM260/Configuring+User+Stores) .

    ``` xml
            <configuration> 
            ...
                <Property name="dataSource">jdbc/WSO2UM_DB</Property>
            </configuration>
             
            <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
                <Property name="TenantManager">org.wso2.carbon.user.core.tenant.JDBCTenantManager</Property>
                <Property name="ReadOnly">false</Property>
                <Property name="MaxUserNameListLength">100</Property>
                <Property name="IsEmailUserName">false</Property>
                <Property name="DomainCalculation">default</Property>
                <Property name="PasswordDigest">SHA-256</Property>
                <Property name="StoreSaltedPassword">true</Property>
                <Property name="ReadGroups">true</Property>
                <Property name="WriteGroups">true</Property>
                <Property name="UserNameUniqueAcrossTenants">false</Property>
                <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
                <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
                <Property name="UsernameJavaRegEx">^[^~!#$;%^*+={}\\|\\\\&lt;&gt;,\'\"]{3,30}$</Property>
                <Property name="UsernameJavaScriptRegEx">^[\S]{3,30}$</Property>
                <Property name="RolenameJavaRegEx">^[^~!#$;%^*+={}\\|\\\\&lt;&gt;,\'\"]{3,30}$</Property>
                <Property name="RolenameJavaScriptRegEx">^[\S]{3,30}$</Property>
                <Property name="UserRolesCacheEnabled">true</Property>
                <Property name="MaxRoleNameListLength">100</Property>
                <Property name="MaxUserNameListLength">100</Property>
                <Property name="SharedGroupEnabled">false</Property>
                <Property name="SCIMEnabled">false</Property>
            </UserStoreManager>
    ```

        !!! note
    If you are using the `           WSO2UM_DB          ` to store users, remember to change the administrator's username and password. For more information, see [Maintaining Logins and Passwords](https://docs.wso2.com/display/AM260/Maintaining+Logins+and+Passwords) .


12. To enable access to the registry database, open the `           <API-M_HOME>/repository/conf/registry.xml          ` file in each of these components and configure them as follows. The components that need to mount the governance registry space differs based on whether the setup is multi tennanted or not.

    -   [**Single Tenant Setup**](#c92b08990e2a42728961dfb90cc1a6ce)
    -   [**Multi Tenanted Setup**](#7a245e0103034219a7ae1deeded5c0e6)

    Configuration needs to be added to API Publisher and Store components.

    Configuration needs to be added to API Publisher, Store, Key Manager, and Gateway components.

        !!! note
    Do not replace the following configuration when adding in the mounting configurations mentioned below. The registry mounting configurations mentioned in the following steps must be added beneath the following entry, which is already in the configuration file.

    ``` java
        <dbConfig name="wso2registry">
            <dataSource>jdbc/WSO2CarbonDB</dataSource>
        </dbConfig>
    ```

    This configuration points to the local H2 database. This configuration is necessary and must always exist in this file.


    1.  In the Publisher component's `             registry.xml            ` file, add or modify the `             dataSource            ` attribute of the `             <dbConfig name="govregistry">            ` element as follows:

        ``` plain
                <dbConfig name="govregistry">
                  <dataSource>jdbc/WSO2REG_DB</dataSource>
                </dbConfig>
                <remoteInstance url="https://localhost:9443/registry"> 
                   <id>gov</id>
                   <cacheId>user@jdbc:mysql://db.mysql-wso2.com:3306/regdb</cacheId>
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

    2.  In the Store component's `             registry.xml            ` file, add or modify the `             dataSource            ` attribute of the `             <dbConfig name="govregistry">            ` element as follows (note that this configuration is almost identical to the previous step except for the `             remoteInstance            ` URL):

        ``` plain
                    <dbConfig name="govregistry">
                      <dataSource>jdbc/WSO2REG_DB</dataSource>
                    </dbConfig>
                    <remoteInstance url="https://localhost:9443/registry"> 
                       <id>gov</id>
                       <cacheId>user@jdbc:mysql://db.mysql-wso2.com:3306/regdb</cacheId> 
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

        `             CacheId            ` is a unique identification of remote instance. When you configure the remote instance, WSO2 recommends that you modify the `             <cacheId>            ` with the corresponding values of your setup, based on the following format : `             <username>@<JDBC_URL to_registry_database>            `

                !!! note
        -   You do not need to specify the `               remoteInstance              ` URL i n the above configuration because WS mounting in not used in WSO2 API-M 2.1.0 onward.

        -   In the above code snippet the governance registry and the config registry are pointed to the same database. If required, you can use two databases for the two registries that are shared with Publisher and Store nodes.


13. Skip caching.
    Uncomment the following configuration under the `           <indexingConfiguration>          ` element in the `           <API-M_HOME>/repository/conf/registry.xml          ` file.

        !!! note
    In a WSO2 API-M distributed deployment, you need to add this configuration in all the Publisher and Store nodes. By adding this configuration, you avoid facing caching related issues in the Store and Publisher nodes by directly getting the API information from the database.


    ``` java
        <skipCache>true</skipCache>
    ```



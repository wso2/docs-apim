# Configuring the Databases for IS as the Key Manager

The following steps describe how to download and install a RDBMS, which in this case is a MySQL Server, create the databases, configure the data sources, and configure the WSO2 Identity Server (WSO2 IS) components to connect to them.

!!! warning
Although the following section instructs you to use MySQL Server, **you can use any RDBMS** in your deployment based on your preference. For information on working with other databases, see \_Changing the Default API-M Databases .

!!! info
The steps involved in installing and configuring the databases are the same irrespective of whether you are using a single node (standalone) deployment, an active-active deployment, or a distributed deployment.


1.  Download the [MySQL JDBC driver](http://dev.mysql.com/downloads/connector/j/) .

2.  Unzip the downloaded MySQL driver archive, and copy the MySQL JDBC driver JAR ( `           mysql-connector-java-x.x.xx-bin.jar          ` ) into the `           <IS_HOME>/repository/components/lib          ` directory in all the nodes in the cluster where `           <IS_HOME>          ` refers to the location of the extracted WSO2 Identity Server (WSO2 IS) distribution.

3.  Define the hostname for configuring permissions for the new database by opening the `           /etc/hosts          ` file and adding the following:

        !!! warning
    Do this step only if your database is not on your local machine and on a separate server.


    ``` java
        <MYSQL-DB-SERVER-IP> carbondb.mysql-wso2.com
    ```

4.  Install mysql-client in each of the Identity Server nodes in which WSO2 Identity Server is deployed.
    You need to do this in order to check if the servers can access the MySQL database.

    ``` java
            sudo apt install mysql-client
            mysql -h <mysqldb_host_ip> -u username -p
    ```

5.  Enter the following command in a command prompt, where `           username          ` is the username that you used to access the databases.

    ``` java
            mysql -u username -p
    ```

6.  When prompted, specify the password that will be used to access the databases with the username you specified.

        !!! note
    When setting up WSO2 Identity Server (WSO2 IS) as the key manager, you need to work with the user ( `           userdb          ` ) and registry ( `           regdb          ` ) databases; however, as the latter mentioned two databases are databases that you have already created and setup for WSO2 API Manager (WSO2 API-M), you do not need to create the latter mentioned databases again.


7.  Configure the data sources for the user ( `           userdb          ` ) and the registry ( `           regdb          ` ) databases as follows in the `           <IS_HOME>/repository/conf/datasources/master-datasources.xml          ` file.
    This file contains the different datasources used by WSO2 Identity Server. By default, the Identity Server connects to the local H2 database and it is recommended to use a separate RDBMS for a production deployment.

        !!! tip
    For more information, see [Configuring master-datasources.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+master-datasources.xml) in the Administration Guide.

        !!! note
    **Note** : When configuring clustering, ignore the `           WSO2_CARBON_DB          ` data source configuration.


    1.  Enable the components to access the WSO2 API Manager database by changing the URL as indicated below. Make sure to replace `             db.mysql-wso2.com            ` with the hostname you specified in [step 5](#ConfiguringtheDatabasesforISastheKeyManager-stepDB5) ( `             carbondb.mysql-wso2.com            ` ) in the **`              WSO2AM_DB             `** data source.

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

    2.  Enable the Key Manager to access the user management database.
        You need to do this by adding the following code and changing the `             db.mysql-wso2.com            ` to `             carbondb.mysql-wso2.com            ` in order to configure the **`              WSO2UM_DB             `** data source.

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

    3.  Enable the Key Manager to have access to registry databases by adding the following **`              WSO2REG_DB             `** data source related configuration.

                !!! note
        This is only applicable in a multi-tenanted environment.


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

8.  Make the following changes in the `           <IS_HOME>/repository/conf/user-mgt.xml          ` file.

    1.  To give the Key Manager component access with shared permissions to the user management database, add or modify the `             dataSource            ` property that corresponds to the `             <configuration>            ` element as follows so that it points to the `             WSO2UM_DB            ` database. By default, this configuration points to the embedded H2 database.

                !!! note
        This is only applicable in a multi-tenanted environment.


        ``` xml
                <configuration> 
                ...
                    <Property name="dataSource">jdbc/WSO2UM_DB</Property>
                </configuration>
        ```

    2.  Make sure you add the user store configuration correctly so that both the WSO2 Identity Server and WSO2 API Manager server point to the same user store. For more information, see [Configuring User Stores](https://docs.wso2.com/display/ADMIN44x/Configuring+User+Stores) in the Administration Guide.

                !!! info
        You must change the `             <UserStoreManager>            ` element here as the internal LDAP user store is used by default. You need to remove or modify the `             <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager">            ` code block with the correct LDAP that you are using. You could alternatively use the embedded LDAP in the WSO2 Identity Server as your user store. For more information, see [Configuring the Primary User Store](https://docs.wso2.com/display/ADMIN44x/Configuring+the+Primary+User+Store) in the Administration Guide.


        ``` xml
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
        If you are using the `             WSO2UM_DB            ` to store users, remember to change the administrator's username and password. For more information, see [Maintaining Logins and Passwords](https://docs.wso2.com/display/AM260/Maintaining+Logins+and+Passwords) .


9.  To enable the Key Manager to access to the registry database, open the `           <IS_HOME>/repository/conf/registry.xml          ` file in the Key Manager node and add or modify the `           dataSource          ` attribute of the `           <dbConfig name="govregistry">          ` element as follows in order to mount the Key Manager to the governance registry space.
    For more information on the properties and values related to the remote mount configurations, see [Configuring registry.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+registry.xml) in the Administration Guide.

        !!! warning
    Note that this is only applicable in a multi-tenanted environment.

        !!! note
    Do not replace the following configuration when adding in the mounting configurations mentioned below. The registry mounting configurations mentioned in the following steps must be added beneath the following entry, which is already in the configuration file.

    ``` java
        <dbConfig name="wso2registry">
            <dataSource>jdbc/WSO2CarbonDB</dataSource>
        </dbConfig>
    ```

    This configuration is related to the local H2 DB, which is used to store the mount information, indexing configuration and anything local to the node, and hence should not be removed even if separate governance and config registries are used.


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

    `           CacheId          ` is a unique identification of the remote instance. When you configure the remote instance, WSO2 recommends that you modify the `           <cacheId>          ` with the corresponding values of your setup , based on the following format : `           <username>@<JDBC_URL_to_registry_database>          `

        !!! note
    -   You do not need to specify the `             remoteInstance            ` URL i n the above configuration, because WS mounting in not used in WSO2 API-M 2.1.0 onward .

    -   In the above code snippet the governance registry and the config registry are pointed to the same database. If required, you can use two databases for the two registries that are shared with Key Manager nodes .




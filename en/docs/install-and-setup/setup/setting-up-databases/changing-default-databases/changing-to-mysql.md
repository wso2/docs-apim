# Changing to MySQL

By default, WSO2 API Manager uses the embedded H2 database as the database for storing user management and registry data. Given below are the  instructions you need to follow in order to use MySQL for this purpose.

!!! info
    The  instructions involved in installing and configuring the databases are the same irrespective of whether you are using a single node (standalone) deployment, an active-active deployment, or a distributed deployment.

## Setting up MySQL

The following sections describe how to set up a MySQL database to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#setting-up-the-database-and-users)
-   [Setting up the drivers](#setting-up-the-drivers)
-   [Executing DB scripts to create tables on MySQL database](#executing-db-scripts-to-create-tables-on-mysql-database)

### Setting up the database and users

Follow the  instructions below to set up a MySQL database:

!!! note
    WSO2 recommends that you use Failover configuration over Load Balanced configuration with the MySQL clusters.

1.  Define the hostname for configuring permissions for the new database in the `/etc/hosts` file.

    !!! warning
        Do this step only if your database is not on your local machine and on a separate server.

    ``` java
    <MYSQL-DB-SERVER-IP> carbondb.mysql-wso2.com
    ```

1.  Start the MySQL service.

1.  Install a mysql-client in each of the API-M servers in which WSO2 API-M is deployed.

1.  Enter the following command in a command prompt, where `USER_NAME` is the username that you will use to access the databases and `MYSQL_HOST_IP` is the IP of the host.

    !!! tip
        The user should have database creation privileges.

    ``` java
    $ mysql -h <MYSQL_HOST_IP> -u <USER_NAME> -p
    ```

1.  When prompted, specify the password that will be used to access the databases with the username you specified.

1.  In the MySQL command prompt, create the database.

    ``` java
    mysql> create database <DATABASE_NAME>;
    ```

    !!! info
        Character Sets and Collations in MySQL
    
        - For users of Microsoft Windows, when creating the database in MySQL, it is important to specify the character set as latin1. Failure to do this may result in an error (error code: 1709) when starting your cluster. This error occurs in certain versions of MySQL (5.6.x) and is related to the UTF-8 encoding. MySQL originally used the latin1 character set by default, which stored characters in a 2-byte sequence. However, in recent versions, MySQL defaults to UTF-8 to be friendlier to international users. Hence, you must use latin1 as the character set as indicated below in the database creation commands to avoid this problem. Note that this may result in issues with non-latin characters (like Hebrew, Japanese, etc.). The following is how your database creation command should look.
          ```sh
          mysql> create database <DATABASE_NAME> character set latin1;
          ```

        - If you are using MySQL to configure your datasource, we recommend that you use a case sensitive database collation. For more information, see the [MySQL Official Manual](https://dev.mysql.com/doc/refman/5.7/en/charset-mysql.html). The default database collation, which is `latin1_swedish_ci`, is case insensitive. However, you need to maintain case sensitivity for database collation, because when the database or table has a case-insensitive collation in MySQL 5.6 or 5.7, if a user creates an API with letters using mixed case, deletes the API, and then creates another API with the same name, but in lower case letters, then the later created API loses its permission information because when deleting the API, it keeps the Registry collection left behind.
        
        - This issue could be avoided if you use a case sensitive collation for database and tables. In that case, when creating the second API (which has the same name, but is entirely in lowercase letters), it will create a new record with the lowercase name in the `UM_PERMISSION` table.
    

1.  Provide authorization to the user that you use to access the databases. 

     For example, let's consider `apimadmin` and `sharedadmin` as the users.

    ``` java
    mysql> GRANT ALL ON apim_db.* TO apimadmin@localhost IDENTIFIED BY "apimadmin";
    ```
    ``` java
    mysql> GRANT ALL ON shared_db.* TO sharedadmin@localhost IDENTIFIED BY "sharedadmin";
    ```

    !!! info
        If you are using MySQL version - 8.0.x, use the following commands to create the users and the grant authorization:

        ``` java
        mysql> CREATE USER 'apimadmin'@'localhost' IDENTIFIED BY 'apimadmin';
        ```

        ``` java
        mysql> GRANT ALL ON apim_db.* TO 'apimadmin'@'localhost';
        ```
    ``` java
        mysql> CREATE USER 'sharedadmin'@'localhost' IDENTIFIED BY 'sharedadmin';
        ```

        ``` java
        mysql> GRANT ALL ON shared_db.* TO 'sharedadmin'@'localhost';
        ```        

1.  After you have finalized the permissions, reload all the privileges.

    ``` java
    mysql> FLUSH PRIVILEGES;
    ```

1.  Log out from the MySQL command prompt.

    ``` java
    mysql> quit;
    ```

### Setting up the drivers

1. Unzip the WSO2 API Manager pack. Let's refer to it as `<API-M_HOME>`.

2. Download the MySQL Java connector [JAR file](https://dev.mysql.com/downloads/connector/j/), and extract it.

3. Copy it to the `<API-M_HOME>/repository/components/lib/` directory in all the nodes of the cluster.

!!! tip
    Be sure to use the connector version that is supported by the MySQL version you use. If you come across any issues due to version incompatibility, follow the  instructions below:

    1.  Shut down the server and remove all the existing connectors from the `<API-M_HOME>/repository/components/lib` and `<API-M_HOME>/repository/components/dropins` directories.
    2.  Download the connector JAR that is compatible with your current MySQL version.
    3.  Copy the JAR file **only to** the `<API-M_HOME>/repository/components/lib` location.
    
        Files will be copied automatically to the `dropins` folder during the server startup.

### Executing DB scripts to create tables on MySQL database

1.  Execute the relevant script to create tables in the registry and user manager database (`WSO2_SHARED_DB`).

    ```sh
    $ mysql -u sharedadmin -p -Dshared_db < '<API-M_HOME>/dbscripts/mysql.sql';
    ```

2. Execute the relevant script to create tables in the apim database (`WSO2AM_DB`).

    ```sh
    $ mysql -u apimadmin -p -Dapim_db < '<API-M_HOME>/dbscripts/apimgt/mysql.sql';
    ```

!!! note
    As the `WSO2_MB_STORE` DB is not shared and does not contain data that needs to be migrated, it is recommended to use the default H2 for `WSO2_MB_STORE_DB` even in production.
    
!!! warning "Troubleshooting"
    If you encounter the following error while using the default H2 database as the MB store database, follow the instructions in this section. Note that this error will only occur if the MB store database is corrupted.

    ```
    ERROR ApplicationRegistry org.wso2.andes.kernel.AndesException: Connecting to database failed with jndi lookup : WSO2MBStoreDB. data source username : wso2carbon. SQL Error message : General error: java.lang.ArrayIndexOutOfBoundsException
    ```

     1. Replace the MB store database with the default H2 MB store database from a fresh WSO2 API-M 3.2.0 pack.

     2. Restart the server.

!!! note
    Additional notes

    -   Ensure that MySQL is configured so that all nodes can connect to it.
    -   To access the databases from remote instances, it is required to grant permission to the relevant username defined in the `<API-M_HOME>/repository/conf/deployment.toml` file under the `[database.shared_db]` or `[database.apim_db]` elements, by using the grant command as shown in the following sample commands.

    ```tab="Format"
    mysql> grant all on <DATABASE_NAME>.* TO '<username>'@'%' identified by '<password>';
    ```

    ``` tab="Example"
    mysql> grant all on shared_db.* TO 'wso2user'@'%' identified by 'wso2123';
    mysql> grant all on apim_db.* TO 'wso2user'@'%' identified by 'wso2123';
    ```

!!! note
    In the sample commands above, it is assumed that the username and password defined in the datasource configurations in the `<API-M_HOME>/repository/conf/deployment.toml` file are **wso2user** and **wso2123** respectively.
    
!!! note
    If you are using NDB engine instead of INNODB engine, you can use the following DB scripts.

     - **`SHARED_DB`** - `<API-M_HOME>/dbscripts/mysql_cluster.sql` 
     - **`WSO2AM_DB`** - `<API-M_HOME>/dbscripts/apimgt/mysql_cluster.sql`
    
!!! note
    If you are using MySQL with group replication, it is mandatory to have primary keys for all the tables.
    
    You can use the following scripts when creating the respective tables instead of the ones provided in the DB scripts. (`<API-M_HOME>/dbscripts/mysql.sql` and `<API-M_HOME>/dbscripts/apimgt/mysql.sql`)
    
    ??? info "Creating tables"
        ```tab="SHARED_DB"
        CREATE TABLE IF NOT EXISTS REG_RESOURCE_COMMENT (
                REG_RESOURCE_COMMENT_ID     INTEGER NOT NULL AUTO_INCREMENT,
                REG_COMMENT_ID              INTEGER NOT NULL,
                REG_VERSION                 INTEGER,
                REG_PATH_ID                 INTEGER,
                REG_RESOURCE_NAME           VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY(REG_RESOURCE_COMMENT_ID)
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS REG_RESOURCE_PROPERTY (
                REG_RESOURCE_PROPERTY_ID    INTEGER NOT NULL AUTO_INCREMENT,
                REG_PROPERTY_ID             INTEGER NOT NULL,
                REG_VERSION                 INTEGER,
                REG_PATH_ID                 INTEGER,
                REG_RESOURCE_NAME           VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY(REG_RESOURCE_PROPERTY_ID)
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS REG_RESOURCE_RATING (
                REG_RESOURCE_RATING_ID      INTEGER NOT NULL AUTO_INCREMENT,
                REG_RATING_ID               INTEGER NOT NULL,
                REG_VERSION                 INTEGER,
                REG_PATH_ID                 INTEGER,
                REG_RESOURCE_NAME           VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY(REG_RESOURCE_RATING_ID)
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS REG_RESOURCE_TAG (
                REG_RESOURCE_TAG_ID     INTEGER NOT NULL AUTO_INCREMENT,
                REG_TAG_ID              INTEGER NOT NULL,
                REG_VERSION             INTEGER,
                REG_PATH_ID             INTEGER,
                REG_RESOURCE_NAME       VARCHAR(256),
                REG_TENANT_ID INTEGER DEFAULT 0,
                PRIMARY KEY(REG_RESOURCE_TAG_ID)
        )ENGINE INNODB;
        
        CREATE TABLE UM_SHARED_USER_ROLE(
                UM_SHARED_USER_ROLE_ID      INTEGER NOT NULL AUTO_INCREMENT,
                UM_ROLE_ID                  INTEGER NOT NULL,
                UM_USER_ID                  INTEGER NOT NULL,
                UM_USER_TENANT_ID           INTEGER NOT NULL,
                UM_ROLE_TENANT_ID           INTEGER NOT NULL,
                UNIQUE(UM_USER_ID,UM_ROLE_ID,UM_USER_TENANT_ID, UM_ROLE_TENANT_ID),
                FOREIGN KEY(UM_ROLE_ID,UM_ROLE_TENANT_ID) REFERENCES UM_ROLE(UM_ID,UM_TENANT_ID) ON DELETE CASCADE,
                FOREIGN KEY(UM_USER_ID,UM_USER_TENANT_ID) REFERENCES UM_USER(UM_ID,UM_TENANT_ID) ON DELETE CASCADE,
                PRIMARY KEY(UM_SHARED_USER_ROLE_ID)
        )ENGINE INNODB;
        ```
        
        ```tab="WSO2AM_DB"
        CREATE TABLE IF NOT EXISTS IDN_OAUTH2_ACCESS_TOKEN_AUDIT (
                IDN_OAUTH2_ACCESS_TOKEN_AUDIT_ID INTEGER NOT NULL AUTO_INCREMENT,
                TOKEN_ID VARCHAR (255),
                ACCESS_TOKEN VARCHAR(2048),
                REFRESH_TOKEN VARCHAR(2048),
                CONSUMER_KEY_ID INTEGER,
                AUTHZ_USER VARCHAR (100),
                TENANT_ID INTEGER,
                USER_DOMAIN VARCHAR(50),
                USER_TYPE VARCHAR (25),
                GRANT_TYPE VARCHAR (50),
                TIME_CREATED TIMESTAMP NULL,
                REFRESH_TOKEN_TIME_CREATED TIMESTAMP NULL,
                VALIDITY_PERIOD BIGINT,
                REFRESH_TOKEN_VALIDITY_PERIOD BIGINT,
                TOKEN_SCOPE_HASH VARCHAR(32),
                TOKEN_STATE VARCHAR(25),
                TOKEN_STATE_ID VARCHAR (128) ,
                SUBJECT_IDENTIFIER VARCHAR(255),
                ACCESS_TOKEN_HASH VARCHAR(512),
                REFRESH_TOKEN_HASH VARCHAR(512),
                INVALIDATED_TIME TIMESTAMP NULL,
                IDP_ID INTEGER DEFAULT -1 NOT NULL,
                PRIMARY KEY (IDN_OAUTH2_ACCESS_TOKEN_AUDIT_ID)
        );
        
        CREATE TABLE IF NOT EXISTS IDN_OAUTH2_SCOPE_BINDING (
                IDN_OAUTH2_SCOPE_BINDING_ID INTEGER NOT NULL AUTO_INCREMENT,
                SCOPE_ID INTEGER NOT NULL,
                SCOPE_BINDING VARCHAR(255) NOT NULL,
                BINDING_TYPE VARCHAR(255) NOT NULL,
                FOREIGN KEY (SCOPE_ID) REFERENCES IDN_OAUTH2_SCOPE (SCOPE_ID) ON DELETE CASCADE,
                PRIMARY KEY (IDN_OAUTH2_SCOPE_BINDING_ID)
        )ENGINE INNODB;
        
        CREATE TABLE IF NOT EXISTS IDN_AUTH_USER_SESSION_MAPPING (
                IDN_AUTH_USER_SESSION_MAPPING_ID INTEGER NOT NULL AUTO_INCREMENT,
                USER_ID VARCHAR(255) NOT NULL,
                SESSION_ID VARCHAR(255) NOT NULL,
                CONSTRAINT USER_SESSION_STORE_CONSTRAINT UNIQUE (USER_ID, SESSION_ID),
                PRIMARY KEY (IDN_AUTH_USER_SESSION_MAPPING_ID)
        );
        
        CREATE TABLE IF NOT EXISTS IDN_OAUTH2_CIBA_REQUEST_SCOPES (
                IDN_OAUTH2_CIBA_REQUEST_SCOPES_ID INTEGER NOT NULL AUTO_INCREMENT,
                AUTH_CODE_KEY CHAR (36),
                SCOPE VARCHAR (255),
                FOREIGN KEY (AUTH_CODE_KEY) REFERENCES IDN_OAUTH2_CIBA_AUTH_CODE(AUTH_CODE_KEY) ON DELETE CASCADE,
                PRIMARY KEY (IDN_OAUTH2_CIBA_REQUEST_SCOPES)
        )ENGINE INNODB;
    
        CREATE TABLE CM_SP_PURPOSE_PURPOSE_CAT_ASSC (
                CM_SP_PURPOSE_PURPOSE_CAT_ASSC_ID INTEGER NOT NULL AUTO_INCREMENT,
                SP_PURPOSE_ASSOC_ID INTEGER NOT NULL,
                PURPOSE_CATEGORY_ID INTEGER NOT NULL,
                UNIQUE KEY (SP_PURPOSE_ASSOC_ID, PURPOSE_CATEGORY_ID),
                PRIMARY KEY (CM_SP_PURPOSE_PURPOSE_CAT_ASSC_ID)
        );
        
        CREATE TABLE CM_PURPOSE_PII_CAT_ASSOC (
                CM_PURPOSE_PII_CAT_ASSOC_ID INTEGER NOT NULL AUTO_INCREMENT,
                PURPOSE_ID         INTEGER NOT NULL,
                CM_PII_CATEGORY_ID INTEGER NOT NULL,
                IS_MANDATORY       INTEGER NOT NULL,
                UNIQUE KEY (PURPOSE_ID, CM_PII_CATEGORY_ID),
                PRIMARY KEY (CM_PURPOSE_PII_CAT_ASSOC_ID)
        );
        
        CREATE TABLE CM_SP_PURPOSE_PII_CAT_ASSOC (
                CM_SP_PURPOSE_PII_CAT_ASSOC_ID INTEGER NOT NULL AUTO_INCREMENT,
                SP_PURPOSE_ASSOC_ID INTEGER NOT NULL,
                PII_CATEGORY_ID     INTEGER NOT NULL,
                VALIDITY            VARCHAR(1023),
                UNIQUE KEY (SP_PURPOSE_ASSOC_ID, PII_CATEGORY_ID),
                PRIMARY KEY (CM_SP_PURPOSE_PII_CAT_ASSOC_ID)
        );
        
        CREATE TABLE CM_CONSENT_RECEIPT_PROPERTY (
                CM_CONSENT_RECEIPT_PROPERTY_ID INTEGER NOT NULL AUTO_INCREMENT,
                CONSENT_RECEIPT_ID VARCHAR(255)  NOT NULL,
                NAME               VARCHAR(255)  NOT NULL,
                VALUE              VARCHAR(1023) NOT NULL,
                UNIQUE KEY (CONSENT_RECEIPT_ID, NAME),
                PRIMARY KEY (CM_CONSENT_RECEIPT_PROPERTY_ID)
        );
        ```
        
    If the tables are already created use the following scripts to update the existing tables in the respective databases.
        
    ??? info "Updating tables"
        ```tab="SHARED_DB"
        ALTER TABLE REG_RESOURCE_COMMENT ADD COLUMN REG_RESOURCE_COMMENT_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE REG_RESOURCE_PROPERTY ADD COLUMN REG_RESOURCE_PROPERTY_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE REG_RESOURCE_RATING ADD COLUMN REG_RESOURCE_RATING_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE REG_RESOURCE_TAG ADD COLUMN REG_RESOURCE_TAG_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE UM_SHARED_USER_ROLE ADD COLUMN UM_SHARED_USER_ROLE_ID INTEGER NOT NULL AUTO_INCREMENT;
        ```
        
        ```tab="WSO2AM_DB"
        ALTER TABLE IDN_OAUTH2_ACCESS_TOKEN_AUDIT ADD COLUMN IDN_OAUTH2_ACCESS_TOKEN_AUDIT_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE IDN_OAUTH2_SCOPE_BINDING ADD COLUMN IDN_OAUTH2_SCOPE_BINDING_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE IDN_AUTH_USER_SESSION_MAPPING ADD COLUMN IDN_AUTH_USER_SESSION_MAPPING_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE IDN_OAUTH2_CIBA_REQUEST_SCOPES ADD COLUMN IDN_OAUTH2_CIBA_REQUEST_SCOPES_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE CM_SP_PURPOSE_PURPOSE_CAT_ASSC ADD COLUMN CM_SP_PURPOSE_PURPOSE_CAT_ASSC_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE CM_PURPOSE_PII_CAT_ASSOC ADD COLUMN CM_PURPOSE_PII_CAT_ASSOC_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE CM_SP_PURPOSE_PII_CAT_ASSOC ADD COLUMN CM_SP_PURPOSE_PII_CAT_ASSOC_ID INTEGER NOT NULL AUTO_INCREMENT;
        
        ALTER TABLE CM_CONSENT_RECEIPT_PROPERTY ADD COLUMN CM_CONSENT_RECEIPT_PROPERTY_ID INTEGER NOT NULL AUTO_INCREMENT;
        ```
        
## Changing the database to MySQL

-   [Creating the datasource connection to MySQL](#creating-the-datasource-connection-to-mysql)

### Creating the datasource connection to MySQL

A datasource is used to establish a connection to a database. By default, `WSO2_SHARED_DB` and `WSO2AM_DB` datasources are configured in the `deployment.toml` file to connect to the default H2 databases.

After setting up the MySQL database to replace the default H2 database, either change the default configurations of the `WSO2_SHARED_DB` and `WSO2AM_DB` datasources, or configure a new datasource to point it to the new database as explained below.

!!! note
    **If you are configuring API-M in a distributed setup**, do the changes in all the WSO2 API-M components.

Follow the  instructions below to change the type of the default datasources.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file and locate the `[database.shared_db]` and `[database.apim_db]` configuration elements.

2.  You simply have to update the URL pointing to your MySQL database, the username, and password required to access the database, and the MySQL driver details as shown below.

    | **Element**                       | **Description**                                                 |
    |-------------------------------|-------------------------------------------------------------|
    | **type**                      | The database type used                                      |
    | **url**                       | The URL of the database. The default port for MySQL is 3306 |
    | **username** and **password** | The name and password of the database user                  |
    | **driverClassName**           | The class name of the database driver                       |

    Sample configuration is shown below:

    ``` tab="Format"
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/<DATABASE_NAME>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    ```

    ``` tab="Example"
    [database.shared_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/shared_db?useSSL=false"
    username = "sharedadmin"
    password = "sharedadmin"

    [database.apim_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/apim_db?useSSL=false"
    username = "apimadmin"
    password = "apimadmin"
    ```

    !!! info
        If you are using MySQL version - 8.0.x, you should add the driver name in the configuration as:
        ``` java
        driver="com.mysql.cj.jdbc.Driver"
        ```

    !!! Tip "Recommendation"
        It is **not recommended to disable the SSL connection** in Production Environments (with `useSSL=false`). For security reasons, enabling SSL connection with MySQL server is preferred in a Production Environment. For more information on establishing an SSL connection with the MySQL server, see [the official MySQL documentation](https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-reference-using-ssl.html).   

3.  You can update the configuration elements given below for your database connection.

    | **Element**                | **Description**                                                                                                                                                                                                                                                                                                                                  |
    |------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **maxActive**          | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                |
    | **maxWait**            | The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                              |
    | **minIdle**            | The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.                                                                                                                                                                                                    |
    | **testOnBorrow**       | The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.                                                                                                                              |
    | **validationQuery**    | The SQL query that will be used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                  |
    | **validationInterval** | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it will not be validated again.                                                                                      |
    | **defaultAutoCommit**  | This property is **not** applicable to the Carbon database in WSO2 products because auto-committing is usually handled at the code level, i.e., the default auto-commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto-committing is enabled for RDBMS drivers by default. When auto-committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.|                                                              
    | **commitOnReturn**     | If `defaultAutoCommit =false`, then you can set `commitOnReturn =true`, so that the pool can complete the transaction by calling the commit on the connection as it is returned to the pool. However, If `rollbackOnReturn =true` then this attribute is ignored. The default value is false.|
    | **rollbackOnReturn**   | If `defaultAutoCommit =false`, then you can set `rollbackOnReturn =true` so that the pool can terminate the transaction by calling rollback on the connection as it is returned to the pool. The default value is false.|

    Sample configuration is shown below:
    
    ``` tab="Format"
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/<DATABASE_NAME>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    pool_options.<OPTION-1> = <VALUE-1>
    pool_options.<OPTION-2> = <VALUE-2>
    ...
    ```

    ``` tab="Example"
    [database.shared_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/shared_db?useSSL=false"
    username = "sharedadmin"
    password = "sharedadmin"
    pool_options.maxActive = 100
    pool_options.maxWait = 10000
    pool_options.validationInterval = 10000

    [database.apim_db]
    type = "mysql"
    url = "jdbc:mysql://localhost:3306/apim_db?useSSL=false"
    username = "apimadmin"
    password = "apimadmin"
    pool_options.maxActive = 50
    pool_options.maxWait = 30000
    ```

    !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).

1.  Restart the server.

    !!! note
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, see [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).

    !!! info
        **Changing WSO2CARBON_DB to MySQL**
        
        By default `WSO2CARBON_DB` will be an embedded H2 database and it is **not necessary** to change it to another database. But if you have a requirement to change it, you can follow the below steps. (When changing the Carbon database, make sure that **each server node have its own WSO2CARBON_DB**. If you don't want to change the carbon database, then you can ignore this section.)
        
        - Create tables in the carbon database (`WSO2CARBON_DB`) using the script `<API-M_HOME>/dbscripts/mysql.sql`.
        -   Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file. Locate the `[database.local]` configuration element and update the URL pointing to your MySQL database, the username, and password required to access the database and the MySQL driver details similarly as explained before.
        
        ``` tab="Example"
        [database.local]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/carbon_db"
        username = "carbonadmin"
        password = "carbonadmin"
        driver = "com.mysql.cj.jdbc.Driver"
        ```

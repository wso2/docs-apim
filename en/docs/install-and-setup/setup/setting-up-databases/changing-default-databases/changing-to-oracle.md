# Changing to Oracle

By default, WSO2 API Manager uses the embedded H2 database as the database for storing user management and registry data. Given below are the instructions you need to follow in order to use Oracle database for this purpose.

## Setting up Oracle

The following sections describe how to set up Oracle database to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#setting-up-the-database-and-users)
-   [Setting up the drivers](#setting-up-the-drivers)
-   [Executing db scripts on Oracle database](#executing-db-scripts-to-create-tables-on-oracle-database)

### Setting up the database and users

Follow the instructions below to set up an Oracle database.

1. As SYSDBA, create a database user and grant privileges to the user as shown below:

    ```sh
    CREATE USER '<USER_NAME>' IDENTIFIED BY '<PASSWORD>' ACCOUNT UNLOCK;
    GRANT CONNECT TO '<USER_NAME>';
    GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE TO '<USER_NAME>';
    ALTER USER '<USER_NAME'> QUOTA '<SPACE_QUOTA_SIZE_IN_MEGABYTES>' ON '<TABLE_SPACE_NAME>';
    GRANT DBA TO '<USER_NAME>';
    COMMIT;
    ```

1. Exit from the session by executing the `quit;` command.

### Setting up the drivers

1. Unzip the WSO2 API Manager pack. Let's refer to this as `<API-M_HOME>`.

1. Download the [Oracle JDBC driver](https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html).

1. Copy it to the `<API-M_HOME>/repository/components/lib/` directory.


!!! info
    If you get a `"timezone region not found"` error when using the `ojdbc6.jar` file with WSO2 servers, set the Java property as follows: `export JAVA_OPTS="-Duser.timezone='+05:30'"        `

    The value of this property should be the GMT difference of the country. If it is necessary to set this property permanently, define it inside the `api-manager.sh` as a new `JAVA_OPT` property.

### Executing db scripts to create tables on Oracle database

1.  To create tables in the registry and user manager database (`WSO2_SHARED_DB`), login to the database via client and execute the relevant sql file. 
     
    For example, let's consider `shared_db` as the database.

    ```sh
    SQL> @<API-M_HOME>/dbscripts/oracle.sql
    ```

2.  To create tables in the apim database (`WSO2AM_DB`), login to the database via client and execute the relevant sql file. 
     
    For example, let's consider `apim_db` as the database.

    ```sh
    SQL> @<API-M_HOME>/dbscripts/apimgt/oracle.sql
    ```

!!! note
    As the `WSO2_MB_STORE` DB is not shared and does not contain data that needs to be migrated, it is recommended to use the default H2 for `WSO2_MB_STORE_DB` even in production.
    
!!! warning "Troubleshooting"
    If you encounter the following error while using the default H2 database as the MB store database, follow the instructions in this section. Note that this error will only occur if the MB store database is corrupted.

    ```
    ERROR ApplicationRegistry org.wso2.andes.kernel.AndesException: Connecting to database failed with jndi lookup : WSO2MBStoreDB. data source username : wso2carbon. SQL Error message : General error: java.lang.ArrayIndexOutOfBoundsException
    ```

     1. Replace the MB store database with the default H2 MB store database from a fresh WSO2 API-M distribution.

     2. Restart the server.

## Changing the database to Oracle

- [Creating the datasource connection to Oracle](#creating-the-datasource-connection-to-oracle)

### Creating the datasource connection to Oracle

A datasource is used to establish the connection to a database. By default, `WSO2_SHARED_DB` and `WSO2AM_DB` datasource are configured in the `deployment.toml` file for the purpose of connecting to the default H2 databases.

After setting up the Oracle database to replace the default H2 database, either change the default configurations of the `WSO2_SHARED_DB` and `WSO2AM_DB` datasource, or configure a new datasource to point it to the new database as explained below.

Follow the instructions below to change the type of the default datasource.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file and locate the `[database.shared_db]` and `[database.apim_db]` configuration elements.

1. You simply have to update the URL pointing to your Oracle database, the username, and password required to access the database and the Oracle driver details as shown below.

    | Element                       | Description                                                                                                |
    |-------------------------------|------------------------------------------------------------------------------------------------------------|
    | **type**                      | The database type used                                                                                     |
    | **url**                       | The URL of the database. The default port for Oracle is 1521                                                |
    | **username** and **password** | The name and password of the database user                                                                 |
    | **driverClassName**           | The class name of the database driver                                                                      |
    | **validationQuery**           | The SQL query that will be used to validate connections from this pool before returning them to the caller.|
    
    Sample configuration is shown below:
    
    ``` tab="Format"
    type = "oracle"
    url = "jdbc:oracle:thin:@localhost:1521/<DATABASE_NAME>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "oracle.jdbc.driver.OracleDriver"
    validationQuery = "SELECT 1 FROM DUAL"
    ```
    
    ``` tab="Example"
    [database.shared_db]
    type = "oracle"
    url = "jdbc:oracle:thin:@localhost:1521/shared_db"
    username = "sharedadmin"
    password = "sharedadmin"
    driver = "oracle.jdbc.driver.OracleDriver"
    validationQuery = "SELECT 1 FROM DUAL"
    
    [database.apim_db]
    type = "oracle"
    url = "jdbc:oracle:thin:@localhost:1521/apim_db"
    username = "apimadmin"
    password = "apimadmin"
    driver = "oracle.jdbc.driver.OracleDriver"
    validationQuery = "SELECT 1 FROM DUAL"
    ```

1. You can update the configuration elements given below for your database connection.
   
    | Element                | Description                                                                                                                                                                                                                                                                                                                                  |
    |------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **maxActive**          | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                |
    | **maxWait**            | The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                              |
    | **minIdle**            | The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.                                                                                                                                                                                                    |
    | **testOnBorrow**       | The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.                                                                                                                              |
    | **validationInterval** | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it will not be validated again.                                                                                      |
    | **defaultAutoCommit**  | This property is **not** applicable to the Carbon database in WSO2 products because auto committing is usually handled at the code level, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto committing is enabled for RDBMS drivers by default. When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.|                                                              
    | **commitOnReturn**     | If `defaultAutoCommit =false`, then you can set `commitOnReturn =true`, so that the pool can complete the transaction by calling the commit on the connection as it is returned to the pool. However, If `rollbackOnReturn =true` then this attribute is ignored. The default value is false.|
    | **rollbackOnReturn**   | If `defaultAutoCommit =false`, then you can set `rollbackOnReturn =true` so that the pool can terminate the transaction by calling rollback on the connection as it is returned to the pool. The default value is false.|
    
    Sample configuration is shown below:
    
    ``` tab="Format"
    type = "oracle"
    url = "jdbc:oracle:thin:@localhost:1521/<DATABASE_NAME>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "oracle.jdbc.driver.OracleDriver"
    validationQuery = "SELECT 1 FROM DUAL"
    pool_options.<OPTION-1> = <VALUE-1>
    pool_options.<OPTION-2> = <VALUE-2>
    ...
    ```
    
    ``` tab="Example"
    [database.shared_db]
    type = "oracle"
    url = "jdbc:oracle:thin:@localhost:1521/shared_db"
    username = "sharedadmin"
    password = "sharedadmin"
    driver = "oracle.jdbc.driver.OracleDriver"
    validationQuery = "SELECT 1 FROM DUAL"
    pool_options.maxActive = 100
    pool_options.maxWait = 10000
    pool_options.validationInterval = 10000
    
    [database.apim_db]
    type = "oracle"
    url = "jdbc:oracle:thin:@localhost:1521/apim_db"
    username = "apimadmin"
    password = "apimadmin"
    driver = "oracle.jdbc.driver.OracleDriver"
    validationQuery = "SELECT 1 FROM DUAL"
    pool_options.maxActive = 50
    pool_options.maxWait = 30000
    ```

    !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).

1.  Restart the server.

    !!! note
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, refer [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).

    !!! info
        **Changing WSO2CARBON_DB to Oracle**

        By default `WSO2CARBON_DB` will be an embedded H2 database and it is **not necessary** to change it to another database. But if you have a requirement to change it, you can follow the below steps. (When changing the carbon database, make sure that **each server node have its own WSO2CARBON_DB**. If you don't want to change the carbon database, then you can ignore this section.)
            
        - Create tables in the carbon database (`WSO2CARBON_DB`) using the script `<API-M_HOME>/dbscripts/oracle.sql`.
        -   Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file. Locate the `[database.local]` configuration element and update the URL pointing to your Oracle database, the username, and password required to access the database and the Oracle driver details similarly as explained before.
        
        ``` tab="Example"
        [database.local]
        type = "oracle"
        url = "jdbc:oracle:thin:@localhost:1521/carbon_db"
        username = "carbonadmin"
        password = "carbonadmin"
        driver = "oracle.jdbc.driver.OracleDriver"
        validationQuery = "SELECT 1 FROM DUAL"
        ```

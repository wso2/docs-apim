# Changing to MSSQL

By default, WSO2 API Manager uses the embedded H2 database as the database for storing user management and registry data. Given below are the steps you need to follow in order to use MSSQL for this purpose.

## Setting up MSSQL

The following sections describe how to set up a Microsoft SQL Server to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#setting-up-the-database-and-users)
-   [Setting up the drivers](#setting-up-the-drivers)
-   [Executing db scripts on MSSQL database](#executing-db-scripts-to-create-tables-on-mssql-database)

### Setting up the database and users

Follow the steps below to set up the Microsoft SQL database and users.


#### Enable TCP/IP

1.  In the start menu, click **Programs** and launch **Microsoft SQL Server 2017.**
1.  Click **Configuration Tools**, and then click **SQL Server Configuration Manager**.
1.  Enable **TCP/IP** and disable **Named Pipes** from protocols of your Microsoft SQL server.
1.  Double click **TCP/IP** to open the TCP/IP properties window and set **Listen All** to `Yes` on the **Protocol** tab.
1.  On the **IP Address** tab, disable **TCP Dynamic Ports** by leaving it blank and give a valid TCP port, so that Microsoft SQL server will listen on that port.

    !!! info
        The best practice is to use port 1433, because you can use it in order processing services.

1.  Similarly, enable TCP/IP from **SQL Native Client Configuration** and disable **Named Pipes**. Also, check whether the port is set correctly to 1433.
1.  Restart Microsoft SQL server.

#### Create the database and user

1.  Open the Microsoft SQL Management Studio to create a database and user.
1.  Click **New Database** from the **Database** menu and specify all the options to create a new database.
1.  Click **New Login** from the **Logins** menu, and specify all the necessary options.

#### Grant permissions

Assign newly created users the required grants/permissions to log in and create tables, to insert, index, select, update, and delete data in tables in the newly created database. These are the minimum set of SQL server permissions.


### Setting up the drivers

1. Unzip the WSO2 API Manager pack. Let's call it `<API-M_HOME>`.

1. Download the Microsoft SQL JDBC driver [tarball file](https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server), and extract it.

1. Copy the file relevant JAR file for your JRE version to the `<API-M_HOME>/repository/components/lib/` directory in all the nodes of the cluster.

!!! tip
    Be sure to use the connector version that is supported by the MSSQL version you use. If you come across any issues due to version incompatibility, follow the steps below:

    1.  Shut down the server and remove all the existing connectors from the `<API-M_HOME>/repository/components/lib` and `<API-M_HOME>/repository/components/dropins` directories.
    1.  Copy the JAR file **only to** the `<API-M_HOME>/repository/components/lib` location. Files will be copied automatically to the `dropins` folder during the server startup.


### Executing db scripts to create tables on MSSQL database

Install [mssql-cli command-line query tool for SQL Server](https://docs.microsoft.com/en-us/sql/tools/mssql-cli?view=sql-server-ver15).

```sh
$ pip install mssql-cli
```

1.  To create tables in the registry and user manager database (`WSO2_SHARED_DB`), execute the relevant script as shown below.

    ```sh
    $ mssql-cli -U sharedadmin -P sharedadmin -d shared_db -i <API-M_HOME>/dbscripts/mssql.sql;
    ```

1.  To create tables in the apim database (`WSO2AM_DB`), execute the relevant script as shown below.

    ```sh
    $ mssql-cli -U sharedadmin -P sharedadmin -d apim_db -i <API-M_HOME>/dbscripts/apimgt/mssql.sql;
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

## Changing the database to MSSQL

-   [Creating the datasource connection to MSSQL](#creating-the-datasource-connection-to-mssql)

### Creating the datasource connection to MSSQL

A datasource is used to establish a connection to a database. By default, the `SHARED_DB` and `AM_DB` datasources are configured in the `deployment.toml` file for the purpose of connecting to the default H2 databases.

After setting up the MSSQL database to replace the default H2 database, either change the default configurations of the `SHARED_DB` and `AM_DB` datasource, or configure a new datasource to point it to the new database as explained below.

!!! note
    **If you are configuring API-M in a distributed setup**, do the changes in all the WSO2 API-M components.

Follow the steps below to change the type of the default datasource.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file and locate the `[database.shared_db]` and `[database.apim_db]` configuration elements.

1.  You simply have to update the URL pointing to your MSSQL database, the username, and password required to access the database, the MSSQL driver details, and the validation query for validating the connection as shown below.

    | Element                       | Description                                                                                                |
    |-------------------------------|------------------------------------------------------------------------------------------------------------|
    | **type**                      | The database type used                                                                                     |
    | **url**                       | The URL of the database. The default port for MSSQL is 1433                                                |
    | **username** and **password** | The name and password of the database user                                                                 |
    | **driverClassName**           | The class name of the database driver                                                                      |
    | **validationQuery**           | The SQL query that will be used to validate connections from this pool before returning them to the caller.|

    Sample configuration is shown below:

    ``` tab="Format"
    type = "mssql"
    url = "jdbc:sqlserver://localhost:1433;databaseName=<DATABASE_NAME>;SendStringParametersAsUnicode=false"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    validationQuery = "SELECT 1"
    ```

    ``` tab="Example"
    [database.shared_db]
    type = "mssql"
    url = "jdbc:sqlserver://localhost:1433;databaseName=shared_db;SendStringParametersAsUnicode=false"
    username = "sharedadmin"
    password = "sharedadmin"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    validationQuery = "SELECT 1"

    [database.apim_db]
    type = "mssql"
    url = "jdbc:sqlserver://localhost:1433;databaseName=apim_db;SendStringParametersAsUnicode=false"
    username = "apimadmin"
    password = "apimadmin"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    validationQuery = "SELECT 1"
    ```
    
    !!! warning
        Set <strong><code>SendStringParametersAsUnicode</code></strong> to 'false' in order to overcome a limitation in the Microsoft SQL client driver. Without this parameter, the database driver will erroneously convert <code>VARCHAR</code> data into <code>NVARCHAR</code> and lower the database's performance.

1.  You can update the configuration elements given below for your database connection.

    | Element                | Description                                                                                                                                                                                                                                                                                                                                  |
    |------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **maxActive**          | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                |
    | **maxWait**            | The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                              |
    | **minIdle**            | The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.                                                                                                                                                                                                    |
    | **testOnBorrow**       | The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.                                                                                                                              |
    | **validationInterval** | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it will not be validated again.                                                                                      |
    | **defaultAutoCommit**  | This property is **not** applicable to the Carbon database in WSO2 products because auto committing is usually handled at the code level, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto committing is enabled for RDBMS drivers by default. When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.|                                                              
    | **commitOnReturn**     | If `defaultAutoCommit =false`, then you can set `commitOnReturn =true`, so that the pool can complete the transaction by calling the commit on the connection as it is returned to the pool. However, If `rollbackOnReturn =true` then this attribute is ignored. The default value is false.|
    | **rollbackOnReturn** | If `defaultAutoCommit =false`, then you can set `rollbackOnReturn =true` so that the pool can terminate the transaction by calling rollback on the connection as it is returned to the pool. The default value is false.|

    Sample configuration is shown below:
    
    ``` tab="Format"
    type = "mssql"
    url = "jdbc:sqlserver://localhost:1433;databaseName=<DATABASE_NAME>;SendStringParametersAsUnicode=false"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    validationQuery = "SELECT 1"
    pool_options.<OPTION-1> = <VALUE-1>
    pool_options.<OPTION-2> = <VALUE-2>
    ...
    ```
    
    ``` tab="Example"
    [database.shared_db]
    type = "mssql"
    url = "jdbc:sqlserver://localhost:1433;databaseName=shared_db;SendStringParametersAsUnicode=false"
    username = "sharedadmin"
    password = "sharedadmin"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    validationQuery = "SELECT 1"
    pool_options.maxActive = 100
    pool_options.maxWait = 10000
    pool_options.validationInterval = 10000
    
    [database.apim_db]
    type = "mssql"
    url = "jdbc:sqlserver://localhost:1433;databaseName=apim_db;SendStringParametersAsUnicode=false"
    username = "apimadmin"
    password = "apimadmin"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    validationQuery = "SELECT 1"
    pool_options.maxActive = 50
    pool_options.maxWait = 30000
    ```

    !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).

1.  Restart the server.

    !!! note
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, see [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).

    !!! info
        **Changing WSO2CARBON_DB to MSSQL**

        By default `WSO2CARBON_DB` will be an embedded H2 database and it is **not necessary** to change it to another database. But if you have a requirement to change it, you can follow the below steps. (When changing the carbon database, make sure that **each server node have its own WSO2CARBON_DB**. If you don't want to change the carbon database, then you can ignore this section.)
            
        - Create tables in the carbon database (`WSO2CARBON_DB`) using the script `<API-M_HOME>/dbscripts/mssql.sql`.
        -   Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file. Locate the `[database.local]` configuration element and update the URL pointing to your MSSQL database, the username, and password required to access the database and the MSSQL driver details similarly as explained before.
        
        ``` tab="Example"
        [database.local]
        type = "mssql"
        url = "jdbc:sqlserver://localhost:1433;databaseName=carbon_db;SendStringParametersAsUnicode=false"
        username = "carbonadmin"
        password = "carbonadmin"
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
        validationQuery = "SELECT 1"
        ```

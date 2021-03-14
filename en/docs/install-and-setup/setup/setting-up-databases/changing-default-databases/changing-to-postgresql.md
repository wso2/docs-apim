# Changing to PostgreSQL

By default, WSO2 API Manager uses the embedded H2 database as the database for storing user management and registry data. Given below are the  instructions you need to follow in order to use PostgreSQL for this purpose.

## Setting up PostgreSQL

The following sections describe how to set up PostgreSQL database to replace the default H2 database in your WSO2 product.

- [Setting up the database and users](#setting-up-the-database-and-users)
- [Setting up the drivers](#setting-up-the-drivers)
- [Executing db scripts to create tables on PostgreSQL database](#executing-db-scripts-to-create-tables-on-postgresql-database)

### Setting up the database and users

Follow the  instructions below to set up the PostgreSQL database and users.

1. Login to PostgreSQL using a client (e.g. `psql`). Enter the following command in a command prompt, where `USER_NAME` is the username that you will use to access the databases and `POSTGRE_HOST_IP` is the IP of the host of PostgreSQL server.
  
   ```sh
   $ psql -h <POSTGRE_HOST_IP> -U <USER_NAME> -W
   ```
   
1. When prompted, specify the password that will be used to access the databases with the username you specified.

1. In the PostgreSQL command prompt, create the database using the following command:
   
   ```sh
   postgres# CREATE DATABASE <DATABASE_NAME>;
   ```

1. Give authorization to the user you use to access the databases as follows. 

    For example, let's consider `apimadmin` as the user.

    ```sh
    postgres# grant all privileges on database <DATABASE_NAME> to apimadmin;
    ```
   
1. Log out from the postgres command prompt by executing the following command:
   
   ```sh
   postgres# quit;
   ```

### Setting up the drivers

1. Unzip the WSO2 API Manager pack. Let's refer to it as `<API-M_HOME>`.

1. Download the [PostgreSQL JDBC driver](http://jdbc.postgresql.org/download.html).

1. Copy it to the `<API-M_HOME>/repository/components/lib/` directory.

### Executing db scripts to create tables on PostgreSQL database

1.  To create tables in the registry and user manager database (`WSO2_SHARED_DB`), execute the relevant script as shown below. 

    For example, take `shared_db` as the database.

    ```sh
    $ psql -U <USER_NAME> -d shared_db -f <API-M_HOME>/dbscripts/postgresql.sql -W
    ```

2.  To create tables in the apim database (`WSO2AM_DB`), execute the relevant script as shown below. 
    
    For example, take `apim_db` as the database

    ```sh
    $ psql -U <USER_NAME> -d apim_db -f <API-M_HOME>/dbscripts/apimgt/postgresql.sql  -W
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

## Changing the database to PostgreSQL

- [Creating the datasource connection to PostgreSQL](#creating-the-datasource-connection-to-postgresql)

### Creating the datasource connection to PostgreSQL

A datasource is used to establish the connection to a database. By default, `WSO2_SHARED_DB` and `WSO2AM_DB` datasource are configured in the `deployment.toml` file for the purpose of connecting to the default H2 databases.

After setting up the PostgreSQL database to replace the default H2 database, either change the default configurations of the `WSO2_SHARED_DB` and `WSO2AM_DB` datasources, or configure a new datasource to point it to the new database as explained below.

!!! note
    **If you are configuring API-M in a distributed setup**, do the changes in all the WSO2 API-M components.

Follow the instructions below to change the type of the default datasource.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file and locate the `[database.shared_db]` and `[database.apim_db]` configuration elements.

1. You simply have to update the URL pointing to your PostgreSQL database, the username, and password required to access the database and the PostgreSQL driver details as shown below.

    | Element                       | Description                                                                                                |
    |-------------------------------|------------------------------------------------------------------------------------------------------------|
    | **type**                      | The database type used                                                                                     |
    | **url**                       | The URL of the database. The default port for PostgreSQL is 5432                                                |
    | **username** and **password** | The name and password of the database user                                                                 |
    | **driverClassName**           | The class name of the database driver                                                                      |
    | **validationQuery**           | The SQL query that will be used to validate connections from this pool before returning them to the caller.|
    
    Sample configuration is shown below:
    
    ``` tab="Format"
    type = "postgre"
    url = "jdbc:postgresql://localhost:5432/<DATABASE_NAME>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "org.postgresql.Driver"
    validationQuery = "SELECT 1"
    ```
    
    ``` tab="Example"
    [database.shared_db]
    type = "postgre"
    url = "jdbc:postgresql://localhost:5432/shared_db"
    username = "sharedadmin"
    password = "sharedadmin"
    driver = "org.postgresql.Driver"
    validationQuery = "SELECT 1"
    
    [database.apim_db]
    type = "postgre"
    url = "jdbc:postgresql://localhost:5432/apim_db"
    username = "apimadmin"
    password = "apimadmin"
    driver = "org.postgresql.Driver"
    validationQuery = "SELECT 1"
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
    type = "postgre"
    url = "jdbc:postgresql://localhost:5432/<DATABASE_NAME>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "org.postgresql.Driver"
    validationQuery = "SELECT 1"
    pool_options.<OPTION-1> = <VALUE-1>
    pool_options.<OPTION-2> = <VALUE-2>
    ...
    ```
    
    ``` tab="Example"
    [database.shared_db]
    type = "postgre"
    url = "jdbc:postgresql://localhost:5432/shared_db"
    username = "sharedadmin"
    password = "sharedadmin"
    driver = "org.postgresql.Driver"
    validationQuery = "SELECT 1"
    pool_options.maxActive = 100
    pool_options.maxWait = 10000
    pool_options.validationInterval = 10000
    
    [database.apim_db]
    type = "postgre"
    url = "jdbc:postgresql://localhost:5432/apim_db"
    username = "apimadmin"
    password = "apimadmin"
    driver = "org.postgresql.Driver"
    validationQuery = "SELECT 1"
    pool_options.maxActive = 50
    pool_options.maxWait = 30000
    ```

    !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).

1. Restart the server.

    !!! note
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, refer [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).

    !!! info
        **Changing WSO2CARBON_DB to PostgreSQL**

        By default `WSO2CARBON_DB` will be an embedded H2 database and it is **not necessary** to change it to another database. But if you have a requirement to change it, you can follow the below steps. (When changing the carbon database, make sure that **each server node have its own WSO2CARBON_DB**. If you don't want to change the carbon database, then you can ignore this section.)
            
        - Create tables in the carbon database (`WSO2CARBON_DB`) using the script `<API-M_HOME>/dbscripts/postgresql.sql`.
        -   Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file. Locate the `[database.local]` configuration element and update the URL pointing to your PostgreSQL database, the username, and password required to access the database and the PostgreSQL driver details similarly as explained before.
        
        ``` tab="Example"
        [database.local]
        type = "postgre"
        url = "jdbc:postgresql://localhost:5432/carbon_db"
        username = "carbonadmin"
        password = "carbonadmin"
        driver = "org.postgresql.Driver"
        validationQuery = "SELECT 1"
        ```

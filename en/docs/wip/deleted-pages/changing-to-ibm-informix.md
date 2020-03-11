# Changing to IBM Informix

By default, WSO2 API Manager uses the embedded H2 database as the database for storing user management and registry data. Given below are the steps you need to follow in order to use IBM Informix for this purpose.

## Setting up IBM Informix

The following sections describe how to set up a IBM Informix database to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#setting-up-the-database-and-users)
-   [Setting up the drivers](#setting-up-the-drivers)
-   [Executing db scripts on IBM Informix database](#executing-db-scripts-on-ibm-informix-database)

### Setting up the database and users

Create the database and users in Informix. For instructions on creating the database and users, see [Informix product documentation](http://www-947.ibm.com/support/entry/portal/all_documentation_links/information_management/informix_servers?productContext=-1122713425).

!!! tip
    Do the following changes to the default database when creating the Informix database.

    -   Define the page size as 4K or higher when creating the dbspace as shown in the following command (i.e. denoted by `-k 4` ) :
    
        ``` java
        onspaces -c -S testspace4 -k 4 -p /usr/informix/logdir/data5.dat -o 100 -s 3000000
        ```
    
    -   Add the following system environment variables.
    
        ``` text
        export DB_LOCALE=en_US.UTF-8
        export CLIENT_LOCALE=en_US.UTF-8
        ```
    
    -   Create an sbspace other than the dbspace by executing the following command:
    
        ``` java
        onspaces -c -S testspace4 -k 4 -p /usr/informix/logdir/data5.dat -o 100 -s 3000000
        ```
    
    -   Add the following entry to the `<INFORMIX_HOME>/etc/onconfig` file, and replace the given example sbspace name (i.e. `testspace4` ) with your sbspace name:
    
        ``` java
        SBSPACENAME testspace4
        ```


### Setting up the drivers

1. Unzip the WSO2 API Manager pack. Let's refer to it as `<API-M_HOME>`.

1. Download the [Informix JDBC driver](https://www.ibm.com/support/knowledgecenter/SSGU8G_12.1.0/com.ibm.jdbc_pg.doc/ids_jdbc_013.htm).

1. Copy the file relevant JAR file for your JRE version to the `<API-M_HOME>/repository/components/lib/` directory in all the nodes of the cluster.

!!! info
    Use Informix JDBC driver version 3.70.JC8, 4.10.JC2 or higher.

### Executing db scripts on IBM Informix database

1.  To create tables in the registry and user manager database (`WSO2_SHARED_DB`), use the script: `<API-M_HOME>/dbscripts/informix.sql/`

1.  To create tables in the apim database (`WSO2AM_DB`), use the script: `<API-M_HOME>/dbscripts/apimgt/informix.sql/`


## Changing the Carbon database to IBM Informix

-   [Creating the datasource connection to IBM Informix](#creating-the-datasource-connection-to-ibm-informix)

### Creating the datasource connection to IBM Informix

A datasource is used to establish the connection to a database. By default, `SHARED_DB` and `AM_DB` datasource are configured in the `deployment.toml` file for the purpose of connecting to the default H2 databases.

After setting up the IBM Informix database to replace the default H2 database, either change the default configurations of the `SHARED_DB` and `AM_DB` datasource, or configure a new datasource to point it to the new database as explained below.

Follow the steps below to change the type of the default datasource.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file and locate the `[database.shared_db]` and `[database.apim_db]` configuration elements.

1.  You simply have to update the URL pointing to your IBM Informix database, the username, and password required to access the database, the IBM Informix driver details and validation query for validating the connection as shown below.

    | Element                       | Description                                                                                                |
    |-------------------------------|------------------------------------------------------------------------------------------------------------|
    | **type**                      | The database type used                                                                                     |
    | **url**                       | The URL of the database. The default port for IBM Informix is 1533.                                        |
    | **username** and **password** | The name and password of the database user                                                                 |
    | **driverClassName**           | The class name of the database driver                                                                      |
    | **validationQuery**           | The SQL query that will be used to validate connections from this pool before returning them to the caller.|

    !!! tip
        Add the following configuration to the connection URL when specifying it as shown in the example below:
        
        `CLIENT_LOCALE=en_US.utf8;DB_LOCALE=en_us.utf8;IFX_USE_STRENC=true;`

    Sample configuration is shown below:

    ``` tab="Format"
    url = "jdbc:informix-sqli://localhost:1533/<DATABASE_NAME>;CLIENT_LOCALE=en_US.utf8;DB_LOCALE=en_us.utf8;IFX_USE_STRENC=true;"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "com.informix.jdbc.IfxDriver"
    validationQuery = "SELECT 1"
    ```

    ``` tab="Example"
    [database.shared_db]
    url = "jdbc:informix-sqli://localhost:1533/shared_db;CLIENT_LOCALE=en_US.utf8;DB_LOCALE=en_us.utf8;IFX_USE_STRENC=true;"
    username = "regadmin"
    password = "regadmin"
    driver = "com.informix.jdbc.IfxDriver"
    validationQuery = "SELECT 1"

    [database.apim_db]
    url = "jdbc:informix-sqli://localhost:1533/apim_db;CLIENT_LOCALE=en_US.utf8;DB_LOCALE=en_us.utf8;IFX_USE_STRENC=true;"
    username = "apimadmin"
    password = "apimadmin"
    driver = "com.informix.jdbc.IfxDriver"
    validationQuery = "SELECT 1"
    ```

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
    url = "jdbc:informix-sqli://localhost:1533/<DATABASE_NAME>;CLIENT_LOCALE=en_US.utf8;DB_LOCALE=en_us.utf8;IFX_USE_STRENC=true;"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    driver = "com.informix.jdbc.IfxDriver"
    validationQuery = "SELECT 1"
    pool_options.<OPTION-1> = <VALUE-1>
    pool_options.<OPTION-2> = <VALUE-2>
    ...
    ```
    
    ``` tab="Example"
    [database.shared_db]
    url = "jdbc:informix-sqli://localhost:1533/shared_db;CLIENT_LOCALE=en_US.utf8;DB_LOCALE=en_us.utf8;IFX_USE_STRENC=true;"
    username = "regadmin"
    password = "regadmin"
    driver = "com.informix.jdbc.IfxDriver"
    validationQuery = "SELECT 1"
    pool_options.maxActive = 100
    pool_options.maxWait = 10000
    pool_options.validationInterval = 10000
    
    [database.apim_db]
    url = "jdbc:informix-sqli://localhost:1533/apim_db;CLIENT_LOCALE=en_US.utf8;DB_LOCALE=en_us.utf8;IFX_USE_STRENC=true;"
    username = "apimadmin"
    password = "apimadmin"
    driver = "com.informix.jdbc.IfxDriver"
    validationQuery = "SELECT 1"
    pool_options.maxActive = 50
    pool_options.maxWait = 30000
    ```
    
    !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).

1.  Restart the server.

    !!! note
<<<<<<< HEAD:en/docs/install-and-setup/setting-up-databases/changing-default-databases/changing-to-ibm-informix.md
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, refer [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).
=======
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, refer [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).
>>>>>>> 3.0.0:en/docs/wip/deleted-pages/changing-to-ibm-informix.md

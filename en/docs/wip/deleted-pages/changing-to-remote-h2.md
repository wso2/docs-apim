# Changing to Remote H2

By default, WSO2 API Manager uses the embedded H2 database as the database for storing user management and registry data. Given below are the instructions you need to follow in order to use remote H2 for this purpose.

!!! warning
    H2 is not recommended in production.
    
    The embedded H2 database is NOT recommended in enterprise testing and production environments. It has lower performance, clustering limitations, and can cause file corruption failures. Please use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL or MS SQL instead.
    
    You can use the embedded H2 database in development environments and as the local registry in a registry mount.

## Setting up remote H2

The following sections describe how to set up a remote H2 database to replace the default embedded H2 database in your WSO2 product:

-   [Setting up the drivers](#setting-up-the-drivers)
-   [Executing db scripts to create tables on remote H2 database](#executing-db-scripts-to-create-tables-on-remote-h2-database)

### Setting up the drivers

1.  Unzip the WSO2 API Manager pack. Let's refer to it as `<API-M_HOME>`.

1.  Download the [h2 zip file](http://www.h2database.com/html/download.html), and extract it.

1.  Copy the JAR file to the `<API-M_HOME>/repository/components/lib/` directory in all the nodes of the cluster.

### Executing db scripts to create tables on remote H2 database

1.  Run the `./h2.sh` command to start the Web console.

1.  To create tables in the registry and user manager database (`WSO2_SHARED_DB`) use the script: `<API-M_HOME>/dbscripts/h2.sql`

1.  To create tables in the registry and user manager database (`WSO2_SHARED_DB`) use the script: `<API-M_HOME>/dbscripts/apimgt/h2.sql`


## Changing the Carbon database to remote H2

-   [Creating the datasource connection to remote H2](#creating-the-datasource-connection-to-remote-h2)

### Creating the datasource connection to remote H2

A datasource is used to establish the connection to a database. By default, `WSO2_SHARED_DB` and `WSO2AM_DB` datasource are configured in the `deployment.toml` file for the purpose of connecting to the default embedded H2 databases.

After setting up the remote H2 database to replace the default embedded H2 database, either change the default configurations of the `WSO2_SHARED_DB` and `WSO2AM_DB` datasource, or configure a new datasource to point it to the new database as explained below.

!!! note
    **If you are configuring API-M in a distributed setup**, do the changes in all the WSO2 API-M components.

Follow the instructions below to change the type of the default datasource.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` configuration file and locate the `[database.shared_db]` and `[database.apim_db]` configuration elements.

1.  You simply have to update the URL pointing to your remote H2 database, the username, and password required to access the database as shown below.

    | Element                       | Description                                                 |
    |-------------------------------|-------------------------------------------------------------|
    | **type**                      | The database type used                                      |
    | **url**                       | The URL of the database. The default port for H2 remote is 9092    |
    | **username** and **password** | The name and password of the database user                  |

    Sample configuration is shown below:

    ``` tab="Format"
    type = "h2"
    url = "jdbc:h2:tcp://localhost:9092/<DATABASE_LOCATION>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    ```

    ``` tab="Example"
    [database.shared_db]
    type = "h2"
    url = "jdbc:h2:tcp://localhost:9092/~/shared_db"
    username = "regadmin"
    password = "regadmin"

    [database.apim_db]
    type = "h2"
    url = "jdbc:h2:tcp://localhost:9092/~/apim_db"
    username = "apimadmin"
    password = "apimadmin"
    ```

1.  You can update the configuration elements given below for your database connection.

    | Element                | Description                                                                                                                                                                                                                                                                                                                                  |
    |------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **maxActive**          | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                |
    | **maxWait**            | The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                              |
    | **minIdle**            | The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.                                                                                                                                                                                                    |
    | **testOnBorrow**       | The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.                                                                                                                              |
    | **validationQuery**    | The SQL query that will be used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                  |
    | **validationInterval** | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it will not be validated again.                                                                                      |
    | **defaultAutoCommit**  | This property is **not** applicable to the Carbon database in WSO2 products because auto committing is usually handled at the code level, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto committing is enabled for RDBMS drivers by default. When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.|                                                              
    | **commitOnReturn**     | If `defaultAutoCommit =false`, then you can set `commitOnReturn =true`, so that the pool can complete the transaction by calling the commit on the connection as it is returned to the pool. However, If `rollbackOnReturn =true` then this attribute is ignored. The default value is false.|
    | **rollbackOnReturn**   | If `defaultAutoCommit =false`, then you can set `rollbackOnReturn =true` so that the pool can terminate the transaction by calling rollback on the connection as it is returned to the pool. The default value is false.|

    Sample configuration is shown below:
    
    ``` tab="Format"
    type = "h2"
    url = "jdbc:h2:tcp://localhost:9092/<DATABASE_LOCATION>"
    username = "<USER_NAME>"
    password = "<PASSWORD>"
    pool_options.<OPTION-1> = <VALUE-1>
    pool_options.<OPTION-2> = <VALUE-2>
    ...
    ```

    ``` tab="Example"
    [database.shared_db]
    type = "h2"
    url = "jdbc:h2:tcp://localhost:9092/~/shared_db"
    username = "regadmin"
    password = "regadmin"
    pool_options.maxActive = 100
    pool_options.maxWait = 10000
    pool_options.validationInterval = 10000

    [database.apim_db]
    type = "h2"
    url = "jdbc:h2:tcp://localhost:9092/~/apim_db"
    username = "apimadmin"
    password = "apimadmin"
    pool_options.maxActive = 50
    pool_options.maxWait = 30000
    ```

    !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).

1. Restart the server.

    !!! note
<<<<<<< HEAD:en/docs/install-and-setup/setting-up-databases/changing-default-databases/changing-to-remote-h2.md
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, refer [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).
=======
        To give the Key Manager, Publisher, and Developer Portal components access to the user management data with shared permissions, JDBCUserStoreManager has been configured by default. For more information, refer [Configuring Userstores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-a-jdbc-user-store).
>>>>>>> 3.0.0:en/docs/wip/deleted-pages/changing-to-remote-h2.md

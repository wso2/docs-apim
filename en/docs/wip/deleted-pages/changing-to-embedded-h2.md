# Setting up Embedded H2

The following sections describe how to set up an embedded H2 database to replace the default H2 database in your WSO2 product.

!!! warning 
    H2 is not recommended in production

    The embedded H2 database is NOT recommended in enterprise testing and production environments. It has lower performance, clustering limitations, and can cause file corruption failures. Please use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, or MS SQL instead.

    You can use the embedded H2 database in development environments and as the local registry in a registry mount.


## Setting up the database

Download and install the H2 database engine on your computer.

!!! info
    For instructions on installing DB2 Express-C, see [H2 installation guide.](http://www.h2database.com/html/quickstart.html)


## Setting up the drivers

WSO2 currently ships H2 database engine version h2_1.4.199.\* and its related H2 database driver. If you want to use a different H2 database driver, follow the instructions below:

1.  Delete the following H2 database-related JAR file, which is shipped with WSO2 products:
`<API-M_HOME>/repository/components/plugins/h2_1.4.199.wso2v1.jar`
2.  Find the JAR file of the new H2 database driver (`<H2_HOME>/bin/h2-*.jar`, where `<H2_HOME>` is the H2 installation directory) and copy it to your WSO2 product's `<API-M_HOME>/repository/components/lib/` directory.

## Changing the Carbon database to Embedded H2
The following sections describe how to replace the default H2 database with Embedded H2:

-   [Setting up datasource configurations](#ChangingtoEmbeddedH2-Settingupdatasourceconfigurations)
-   [Creating database tables](#ChangingtoEmbeddedH2-Creatingdatabasetables)

!!! tip
    Before you begin,

<<<<<<< HEAD:en/docs/install-and-setup/setting-up-databases/changing-default-databases/changing-to-embedded-h2.md
    You need to set up Embedded H2 before following the steps to configure your product with it. For more information, see [Setting up Embedded H2]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-embedded-h2/) .
=======
    You need to set up Embedded H2 before following the instructions to configure your product with it. For more information, see [Setting up Embedded H2]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-embedded-h2/).
>>>>>>> 3.0.0:en/docs/wip/deleted-pages/changing-to-embedded-h2.md


### Setting up datasource configurations

A datasource is used to establish the connection to a database. By default, `WSO2_CARBON_DB` datasource is used to connect to the default  H2 database, which stores registry and user management data. After setting up the Embedded H2 database to replace the default H2 database, either [change the default configurations of the WSO2_CARBON_DB datasource](#ChangingtoEmbeddedH2-Changingthedefaultdatabase), or [configure a new datasource](#ChangingtoEmbeddedH2-Configuringnewdatasourcestomanageregistryorusermanagementdata) to point it to the new database as explained below.

#### Changing the default WSO2\_CARBON\_DB datasource

Follow the instructions below to change the type of the default `WSO2_CARBON_DB` datasource.

Edit the default datasource configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file as shown below.

```toml tab="Format"
type = "h2"
url = "jdbc:h2:./repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000"
username = "wso2carbon"
password = "wso2carbon"
driver="org.h2.Driver"
validationQuery="SELECT 1"
```

```toml tab="Example"
[database.carbon_db]
type = "h2"
url = "jdbc:h2:./repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000"
username = "wso2carbon"
password = "wso2carbon"
driver="org.h2.Driver"
validationQuery="SELECT 1"
```

The elements in the above configuration are described below:

| Element                       | Description                                                                                                                                                                                                                                                                                                                                  |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **url**                       | The URL of the database. The default port for a DB2 instance is 50000.                                                                                                                                                                                                                                                                       |
| **username** and **password** | The name and password of the database user                                                                                                                                                                                                                                                                                                   |
| **driver**                    | The class name of the database driver                                                                                                                                                                                                                                                                                                        |
| **maxActive**                 | The maximum number of active connections that can be allocated  at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                 |
| **maxWait**                   | The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                              |
| **minIdle**                   | The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.                                                                                                                                                                                                    |
| **testOnBorrow**              | The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.                                                                                                                              |
| **validationQuery**           | The SQL query that will be used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                  |
| **validationInterval**        | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it will not be validated again.                                                                                      |
| **defaultAutoCommit**         | This property is **not** applicable to the Carbon database in WSO2 products because auto committing is usually handled at the code level, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto committing is enabled for RDBMS drivers by default.                                             When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.                                                                                                                                                     |

!!! info
    For more information on other parameters that can be defined in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes).


!!! warning
    The following elements are available only as a **WUM** update and is effective from 14th September 2018 (2018-09-14).  For more information, see [Updating WSO2 API Manager]({{base_path}}/administer/product-administration/updating-wso2-api-manager).
    This WUM update is only applicable to Carbon 4.4.11 and will be shipped out-out-the-box with Carbon versions newer than Carbon 4.4.35. For more information on Carbon compatibility, see [Release Matrix](https://wso2.com/products/carbon/release-matrix/).


| **Element**          | **Description**                                                                                                                                                                                                                                                                                                                                                                |
|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **commitOnReturn**   | If `defaultAutoCommit =false`, then you can set `commitOnReturn =true`, so that the pool can complete the transaction by calling the commit on the connection as it is returned to the pool. However, If `rollbackOnReturn =true` then this attribute is ignored. The default value is false. |
| **rollbackOnReturn** | If `defaultAutoCommit =false`, then you can set `rollbackOnReturn =true` so that the pool can terminate the transaction by calling rollback on the connection as it is returned to the pool. The default value is false.                                                                                            |

**Configuring the connection pool behavior on return**

When a database connection is returned to the pool, by default  the product rolls back the pending transactions if `defaultAutoCommit =true`. However, if required, you can disable the latter mentioned default behavior by disabling the `ConnectionRollbackOnReturnInterceptor`, which is a JDBC-Pool JDBC interceptor, and setting the connection pool behavior on return via the datasource configurations by using the following options.

!!! warning
    Disabling the `ConnectionRollbackOnReturnInterceptor` is only possible with the **WUM** update and is effective from 14th September 2018 (2018-09-14). For more information on updating WSO2 API Manager, see [Updating WSO2 API Manager]({{base_path}}/administer/product-administration/updating-wso2-api-manager). This WUM update is only applicable to Carbon 4.4.11.


-   **Configure the connection pool to commit pending transactions on connection return**
    1.  Navigate to either one of the following locations based on your OS.
        -   On Linux/Mac OS: `<API-M_HOME>/bin/api-manager.sh/`
        -   On Windows: `<API-M_HOME>\bin\api-manager.bat`
    2.  Add the following JVM option:

        ``` java
        -Dndatasource.disable.rollbackOnReturn=true
        ```

    3.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.
    4.  Disable the `defaultAutoCommit` by defining it as `false`.
    5.  Add the `commitOnReturn` property and set it to `true` for all the datasources, including the custom datasources.

        ``` toml
        [database.shared_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/shared_db"
        username = "regadmin"
        password = "regadmin"
        pool_options.maxActive = 100
        pool_options.maxWait = 10000
        pool_options.validationInterval = 10000
        pool_options.defaultAutoCommit=false
        pool_options.commitOnReturn=true

        [database.apim_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/apim_db"
        username = "apimadmin"
        password = "apimadmin"
        pool_options.maxActive = 50
        pool_options.maxWait = 30000
        pool_options.validationInterval = 10000
        pool_options.defaultAutoCommit=false
        ```

-   **Configure the connection pool to rollback pending transactions on connection return**

    1.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.
    2.  Disable the `defaultAutoCommit` by defining it as false.
    3.  Add the `rollbackOnReturn` property to the datasources.

        ``` toml
        [database.shared_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/shared_db"
        username = "regadmin"
        password = "regadmin"
        pool_options.maxActive = 100
        pool_options.maxWait = 10000
        pool_options.validationInterval = 10000
        pool_options.defaultAutoCommit=false
        pool_options.commitOnReturn=true
        pool_options.rollbackOnReturn=true

        [database.apim_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/apim_db"
        username = "apimadmin"
        password = "apimadmin"
        pool_options.maxActive = 50
        pool_options.maxWait = 30000
        pool_options.validationInterval = 10000
        pool_options.defaultAutoCommit=false
        pool_options.rollbackOnReturn=true
        ```

#### Configuring new datasources to manage registry or user management data

Follow the instructions below to configure new datasources to point to the new database(s) you create to manage registry and/or user management data separately.

1.  Add a new datasource with similar configurations as the [WSO2_CARBON_DB datasource](#changing-the-default-wso295carbon95db-datasource) above to the `<API-M_HOME>/repository/conf/deployment.toml` file. Change its elements with your custom values. For instructions, see [Setting up datasource configurations.](#setting-up-datasource-configurations)
2.  If you are setting up a separate database to store registry-related data, update the following configurations in the `<API-M_HOME>/repository/conf/deployment.toml` file.


    ```toml tab="Format"
    [database.config]
    dataSource = "jdbc/MY_DATASOURCE_NAME"
    ```

    ```toml tab="Example"
    [database.config]
    dataSource = "jdbc/WSO2_CARBON_DB"
    ```

3.  If you are setting up a separate database to store user management data, update the following configurations in the `<API-M_HOME>/repository/conf/deployment.toml` file.

    ```toml tab="Format"
    [user_store]
    dataSource = "jdbc/MY_DATASOURCE_NAME"
    ```

    ```toml tab="Example"
    [user_store]
    dataSource = "jdbc/WSO2_CARBON_DB"
    ```

### Creating database tables

To create the database tables, connect to the database that you created earlier and run the following scripts in the H2 shell or web console:

-   To create tables in the registry and user manager database (`WSO2CARBON_DB`), use the following script:

    ``` java
    <API-M_HOME>/dbscripts/h2.sql
    ```

Follow the instructions below to run the script in Web console:

1.  Run the `./h2.sh` command to start the Web console.
2.  Copy the script text from the SQL file.
3.  Paste it into the console.
4.  Click **Run**.
5.  Restart the server.

!!! info
    You can create database tables automatically **when starting the product for the first time** by using the `-Dsetup` parameter as follows:

    -   For Windows: `<API-M_HOME>/bin/api-manager.bat -Dsetup`

    -   For Linux: `<API-M_HOME>/bin/api-manager.sh -Dsetup`

!!! warning
        Deprecation of -DSetup
    When proper Database Administrative (DBA) practices are followed, the systems (except analytics products) are not granted DDL (Data Definition) rights on the schema. Therefore, maintaining the `-DSetup` option is redundant and typically unusable. **As a result, from [January 2018 onwards](https://wso2.com/products/carbon/release-matrix/) WSO2 has deprecated the `-DSetup` option**. Note that the proper practice is for the DBA to run the DDL statements manually so that the DBA can examine and optimize any DDL statement (if necessary) based on the DBA best practices that are in place within the organization.





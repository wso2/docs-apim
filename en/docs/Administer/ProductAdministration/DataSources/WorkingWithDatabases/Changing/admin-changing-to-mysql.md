# admin\_Changing to MySQL

By default, WSO2 products use the embedded H2 database as the database for storing user management and registry data. Given below are the steps you need to follow in order to use a MySQL database for this purpose.

-   [Creating the datasource connection to MySQL](#admin_ChangingtoMySQL-CreatingthedatasourceconnectiontoMySQL)
-   [Updating other configuration files](#admin_ChangingtoMySQL-Updatingotherconfigurationfiles)
-   [Creating database tables](#admin_ChangingtoMySQL-Creatingdatabasetables)

!!! tip
Before you begin

You need to set up MySQL before following the steps to configure your product with MySQL. For more information, see [Setting up MySQL](https://docs.wso2.com/display/ADMIN44x/Setting+up+MySQL) .


### Creating the datasource connection to MySQL

A datasource is used to establish the connection to a database. By default, `WSO2_SHARED_DB` datasource is configured in the `master-datasources.xml` file for the purpose of connecting to the default H2 database, which stores registry and user management data.

After setting up the MySQL database to replace the default H2 database, either change the default configurations of the `WSO2_SHARED_DB` datasource, or configure a new datasource to point it to the new database as explained below.

Follow the steps below to change the type of the default `WSO2_SHARED_DB` datasource.

1.  Open the &lt; `PRODUCT_HOME>/repository/conf/deployment.toml` configuration file and locate the `[database.shared_db]` configuration element.

2.  You simply have to update the URL pointing to your MySQL database, the username, and password required to access the database and the MySQL driver details as shown below.

    | Element                       | Description                                                 |
    |-------------------------------|-------------------------------------------------------------|
    | **type**                      | The database type used                                      |
    | **url**                       | The URL of the database. The default port for MySQL is 3306 |
    | **username** and **password** | The name and password of the database user                  |
    | **driverClassName**           | The class name of the database driver                       |

    Sample configuration is shown below:

    ```
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/<DATABASE_NAME>"
        username = "regadmin"
        password = "regadmin"
    ```

    !!! info

    If you are using MySQL version - 8.0.x, you should add the driver name in the configuration as:
    ```
        driver="com.mysql.cj.jdbc.Driver"
    ```

    After adding these configurations, you could see that master-datasource.xml which located in <PRODUCT_HOME>/repository/conf/datasource will be updated as follows after server startup:

    ``` html/xml
        <datasource>
               <name>WSO2_SHARED_DB</name>
               <description>The datasource used for registry and user manager</description>
               <jndiConfig>
                   <name>jdbc/SHARED_DB</name>
               </jndiConfig>
               <definition type="RDBMS">
                   <configuration>
                       <url>jdbc:mysql://localhost:3306/<DATABASE_NAME></url>
                       <username>regadmin</username>
                       <password>regadmin</password>
                       <driverClassName>com.mysql.cj.jdbc.Driver</driverClassName>
                       <testOnBorrow>true</testOnBorrow>
                       <maxWait>60000</maxWait>
                       <defaultAutoCommit>true</defaultAutoCommit>
                       <validationInterval>30000</validationInterval>
                       <maxActive>50</maxActive>
                   </configuration>
               </definition>
        </datasource>
    ```

3.  You can update the configuration elements given below for your database connection.

    | Element                | Description                                                                                                                                                                                                                                                                                                                                  |
    |------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **maxActive**          | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                |
    | **maxWait**            | The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                              |
    | **minIdle**            | The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.                                                                                                                                                                                                    |
    | **testOnBorrow**       | The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.                                                                                                                              |
    | **validationQuery**    | The SQL query that will be used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                  |
    | **validationInterval** | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it will not be validated again.                                                                                      |
    | **defaultAutoCommit**  | This property is **not** applicable to the Carbon database in WSO2 products because auto committing is usually handled at the code level, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto committing is enabled for RDBMS drivers by default.

      When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.                                                                                                                                                     |

        !!! info
    For more information on other parameters that can be defined in the `<PRODUCT_HOME>/repository/conf/` datasources/ `master-datasources.xml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes) .


        !!! warning
    The following elements are available only as a **WUM** update and is effective from 14th September 2018 (2018-09-14).  For more information, see [Updating WSO2 Products](https://www.google.com/url?q=https%3A%2F%2Fdocs.wso2.com%2Fdisplay%2FADMIN44x%2FUpdating%2BWSO2%2BProducts&sa=D&sntz=1&usg=AFQjCNEMvqxxFtu8Qv8K4YugxNXrTfNtUA) .
    This WUM update is only applicable to Carbon 4.4.11 and will be shipped out-out-the-box with Carbon versions newer than Carbon 4.4.35. For more information on Carbon compatibility, see [Release Matrix](https://wso2.com/products/carbon/release-matrix/) .


    | **Element**          | **Description**                                                                                                                                                                                                                                                                                                                                                                            |
    |----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **commitOnReturn**   | If `defaultAutoCommit =false`, then you can set `commitOnReturn =true`, so that the pool can complete the transaction by calling the commit on the connection as it is returned to the pool. However, If `rollbackOnReturn =true` then this attribute is ignored. The default value is false. |
    | **rollbackOnReturn** | If `defaultAutoCommit =false`, then you can set `rollbackOnReturn =true` so that the pool can terminate the transaction by calling rollback on the connection as it is returned to the pool. The default value is false.                                                                                                |

    **Configuring the connection pool behavior on return
    ** When a database connection is returned to the pool, by default  the product rolls back the pending transactions if defaultAutoCommit =true . However, if required you can disable the latter mentioned default behavior by disabling the `ConnectionRollbackOnReturnInterceptor` , which is a JDBC-Pool JDBC interceptor, and setting the connection pool behavior on return via the datasource configurations by using the following options.

        !!! warning
    Disabling the `ConnectionRollbackOnReturnInterceptor` is only possible with the **WUM** update and is effective from 14th September 2018 (2018-09-14). For more information on updating WSO2 API Manager, see [Updating WSO2 Products](https://www.google.com/url?q=https%3A%2F%2Fdocs.wso2.com%2Fdisplay%2FADMIN44x%2FUpdating%2BWSO2%2BProducts&sa=D&sntz=1&usg=AFQjCNEMvqxxFtu8Qv8K4YugxNXrTfNtUA) . This WUM update is only applicable to Carbon 4.4.11.


    -   **Configure the connection pool to commit pending transactions on connection return**
        1.  Navigate to either one of the following locations based on your OS.
            -   On Linux/Mac OS: `<PRODUCT_HOME>/bin/wso2server.sh/`
            -   On Windows: `<PRODUCT_HOME>\bin\wso2server.bat`
        2.  Add the following JVM option:

            ``` java
                        -Dndatasource.disable.rollbackOnReturn=true \
            ```

        3.  Navigate to the `<PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file.
        4.  Disable the `defaultAutoCommit` by defining it as false.
        5.  Add the `commitOnReturn` property and set it to true for all the datasources, including the custom datasources.

            ``` html/xml
                            <datasource>
                                 ...
                                 <definition type="RDBMS">
                                     <configuration>
                                           ...
                                           <defaultAutoCommit>false</defaultAutoCommit>
                                           <commitOnReturn>true</commitOnReturn>    
                                           ...
                                     </configuration>
                                 </definition>
                            </datasource>
            ```

    -   **Configure the connection pool to rollback pending transactions on connection return**

        1.  Navigate to the `<PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file.
        2.  Disable the `defaultAutoCommit` by defining it as false.

        3.  Add the `rollbackOnReturn` property to the datasources.

            ``` html/xml
                            <datasource>
                                 ...
                                 <definition type="RDBMS">
                                     <configuration>
                                           ...
                                           <defaultAutoCommit>false</defaultAutoCommit>
                                           <rollbackOnReturn>true</rollbackOnReturn>
                                           ...
                                     </configuration>
                                 </definition>
                            </datasource>
            ```

### Updating other configuration files

-   The `registry.xml` file (stored in the `<PRODUCT_HOME>/repository/conf` directory) specifies the datasource information corresponding to the database that stores registry information. Therefore, if you have changed the datasource name, you need to update the following accordingly:

    ``` xml
            <dbConfig name="wso2registry">
                <dataSource>jdbc/MY_DATASOURCE_NAME</dataSource>
            </dbConfig>
    ```

-   The `user-mgt.xml` file (stored in the `<PRODUCT_HOME>/repository/conf` directory) specifies the datasource information corresponding to the database that stores user management information. Therefore, if you have changed the datasource name, you need to update the following accordingly:

    ``` xml
            <Configuration>
                <Property name="dataSource">jdbc/MY_DATASOURCE_NAME</Property>
            </Configuration>
    ```

### Creating database tables

To create the database tables, connect to the database that you created earlier and run the relevant scripts.

!!! info
Alternatively, you can create database tables automatically **when starting the product for the first time** by using the `-Dsetup` parameter as follows:

-   For Windows: `<PRODUCT_HOME>/bin/wso2server.bat -Dsetup`

-   For Linux: `<PRODUCT_HOME>/bin/wso2server.sh -Dsetup`

!!! warning
Deprecation of -DSetup

When proper Database Administrative (DBA) practices are followed, the systems (except analytics products) are not granted DDL (Data Definition) rights on the schema. Therefore, maintaining the `-DSetup` option is redundant and typically unusable. **As a result, from [January 2018 onwards](https://wso2.com/products/carbon/release-matrix/) WSO2 has deprecated the `-DSetup` option** . Note that the proper practice is for the DBA to run the DDL statements manually so that the DBA can examine and optimize any DDL statement (if necessary) based on the DBA best practices that are in place within the organization.



1.  To create tables in the registry and user manager database ( `WSO2SHARED_DB` ), execute the relevant script as shown below.

    ``` powershell
        mysql -u regadmin -p -Dregdb < '<PRODUCT_HOME>/dbscripts/mysql.sql';
    ```

        !!! note
    For MySQL 5.7:

    From Carbon kernel 4.4.6 onwards your product will be shipped with two scripts for MySQL as follows (click [here](http://wso2.com/products/carbon/release-matrix/) to see if your product is based on this kernel version or newer):

    -`mysql.sql` : Use this script for MySQL versions prior to version 5.7.

    -`mysql5.7.sql` : Use this script for MySQL 5.7 and later versions.

    Note that if you are automatically creating databases during server startup using the `-DSetup` option, the `mysql.sql` script will be used by default to set up the database. Therefore, if you have MySQL version 5.7 set up for your server, be sure to do the following **before starting the server** :

    1.  First, change the existing `mysql.sql` file to a different filename.

    2.  Change the `<PRODUCT_HOME>/dbscripts/mysql5.7.sql` script to **`mysql.sql`** .
    3.  Change the `<PRODUCT_HOME>/dbscripts/identity/mysql5.7.sql` script to **`mysql.sql`** .

    MySQL 5.7 is only recommended for products that are based on Carbon 4.4.6 or a later version.


2.  Restart the server.

# admin\_Setting up Oracle

The following sections describe how to set up an Oracle database to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#admin_SettingupOracle-Settingupthedatabaseandusers)
-   [Setting up the JDBC driver](#admin_SettingupOracle-SettinguptheJDBCdriver)

### Setting up the database and users

Follow the steps below to set up an Oracle database.

1.  Create a new database by using the Oracle database configuration assistant (dbca) or manually.

2.  Make the necessary changes in the Oracle `tnsnames.ora` and `listner.ora` files in order to define addresses of the databases for establishing connections to the newly created database.

3.  After configuring the `.ora` files, start the Oracle instance using the following command:

        $ sudo /etc/init.d/oracle-xe restart

4.  Connect to Oracle using SQL\*Plus as SYSDBA as follows:

`$ ./$<ORACLE_HOME>/config/scripts/sqlplus.sh sysadm/password as SYSDBA          `

5.  Connect to the instance with the username and password using the following command:

        $ connect

6.  As SYSDBA, create a database user and grant privileges to the user as shown below:

    ``` powershell
        Create user <USER_NAME> identified by <PASSWORD> account unlock;
        grant connect to <USER_NAME>;
        grant create session, create table, create sequence, create trigger to <USER_NAME>;
        alter user <USER_NAME> quota <SPACE_QUOTA_SIZE_IN_MEGABYTES> on '<TABLE_SPACE_NAME>';
        commit;
    ```

7.  Exit from the SQL\*Plus session by executing the `quit` command.

### Setting up the JDBC driver

1.  Copy the Oracle JDBC libraries (for example, &lt; `ORACLE_HOME/jdbc/lib/ojdbc14.jar)` to the &lt; `PRODUCT_HOME>/repository/components/lib/` directory.
2.  Remove the old database driver from the `<PRODUCT_HOME>/repository/components/dropins/` directory.

!!! info
If you get a " `timezone region not found"` error when using the `ojdbc6.jar` file with WSO2 servers, set the Java property as follows: `export JAVA_OPTS="-Duser.timezone='+05:30'"        `

The value of this property should be the GMT difference of the country. If it is necessary to set this property permanently, define it inside the `wso2server.sh` as a new `JAVA_OPT` property.


## What's next

By default, all WSO2 products are configured to use the embedded H2 database. To configure your product with Oracle, see [Changing to Oracle](https://docs.wso2.com/display/ADMIN44x/Changing+to+Oracle) .


# admin\_Changing to Oracle

By default, WSO2 products use the embedded H2 database as the database for storing user management and registry data. Given below are the steps you need to follow in order to use an Oracle database for this purpose.

-   [Setting up datasource configurations](#admin_ChangingtoOracle-Settingupdatasourceconfigurations)
    -   [Changing the default WSO2\_CARBON\_DB datasource](#admin_ChangingtoOracle-ChangingthedefaultdatabaseChangingthedefaultWSO2_CARBON_DBdatasource)
    -   [Configuring new datasources to manage registry or user management data](#admin_ChangingtoOracle-ConfiguringanewdatabaseConfiguringnewdatasourcestomanageregistryorusermanagementdata)
-   [Creating the database tables](#admin_ChangingtoOracle-Creatingthedatabasetables)

!!! tip
Before you begin

You need to set up Oracle before following the steps to configure your product with Oracle. For more information, see [Setting up Oracle](https://docs.wso2.com/display/ADMIN44x/Setting+up+Oracle) .


### Setting up datasource configurations

A datasource is used to establish the connection to a database. By default, `WSO2_CARBON_DB` datasource is used to connect to the default  H2 database, which stores registry and user management data. After setting up the Oracle database to replace the default H2 database, either [change the default configurations of the `WSO2_CARBON_DB` datasource](#admin_ChangingtoOracle-Changingthedefaultdatabase) , or [configure a new datasource](#admin_ChangingtoOracle-Configuringanewdatabase) to point it to the new database as explained below.

#### Changing the default WSO2\_CARBON\_DB datasource

Follow the steps below to change the type of the default `WSO2_CARBON_DB` datasource.

1.  Edit the default datasource configuration in the &lt; `PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file as shown below.

    ``` xml
        <datasource>
             <name>WSO2_CARBON_DB</name>
             <description>The datasource used for registry and user manager</description>
             <jndiConfig>
                   <name>jdbc/WSO2CarbonDB</name>
             </jndiConfig>
             <definition type="RDBMS">
                   <configuration>
                       <url>jdbc:oracle:thin:@SERVER_NAME:PORT/SID</url>
                       <username>regadmin</username>
                       <password>regadmin</password>
                       <driverClassName>oracle.jdbc.OracleDriver</driverClassName>
                       <maxActive>80</maxActive>
                       <maxWait>60000</maxWait>
                       <minIdle>5</minIdle>
                       <testOnBorrow>true</testOnBorrow>
                       <validationQuery>SELECT 1 FROM DUAL</validationQuery>
                       <validationInterval>30000</validationInterval>
                       <defaultAutoCommit>false</defaultAutoCommit>
                   </configuration>
             </definition>
        </datasource>
    ```

    The elements in the above configuration are described below:

    | Element                       | Description                                                                                                                                                                                                                                                                                                                                  |
    |-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **url**                       | The URL of the database. The default port for a DB2 instance is 50000.                                                                                                                                                                                                                                                                       |
    | **username** and **password** | The name and password of the database user                                                                                                                                                                                                                                                                                                   |
    | **driverClassName**           | The class name of the database driver                                                                                                                                                                                                                                                                                                        |
    | **maxActive**                 | The maximum number of active connections that can be allocated  at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                               |
    | **maxWait**                   | The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                              |
    | **minIdle**                   | The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.                                                                                                                                                                                                    |
    | **testOnBorrow**              | The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.                                                                                                                              |
    | **validationQuery**           | The SQL query that will be used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                  |
    | **validationInterval**        | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation, but has been validated previously within this interval, it will not be validated again.                                                                                     |
    | **defaultAutoCommit**         | This property is **not** applicable to the Carbon database in WSO2 products because auto committing is usually handled at the code level, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto committing is enabled for RDBMS drivers by default. 
                                                                                                                                                                                                                                                                                                                                                    
      When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.                                                                                                                                                     |

        !!! info
    The default port for Oracle is 1521.

        !!! info
    For more information on other parameters that can be defined in the &lt; `PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes) .


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

#### Configuring new datasources to manage registry or user management data

Follow the steps below to configure new datasources to point to the new  databases you create to manage registry and/or user management data separately.

1.  Add a new datasource with similar configurations as the [`WSO2_CARBON_DB` datasource](#admin_ChangingtoOracle-Changingthedefaultdatabase) above to the &lt; `PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file. Change its elements with your custom values. For instructions, see [Setting up datasource configurations.](#admin_ChangingtoOracle-Settingupdatasourceconfigurations)
2.  If you are setting up a separate database to store registry-related data, update the following configurations in the &lt; `PRODUCT_HOME>/repository/conf/registry.xml` file.

    ``` xml
            <dbConfig name="wso2registry">
                <dataSource>jdbc/MY_DATASOURCE_NAME</dataSource>
            </dbConfig>
    ```

3.  If you are setting up a separate database to store user management data, update the following configurations in the &lt; `PRODUCT_HOME>/repository/conf/user-mgt.xml` file.

    ``` xml
            <Configuration>
                <Property name="dataSource">jdbc/MY_DATASOURCE_NAME</Property>
            </Configuration>
    ```

### Creating the database tables

To create the database tables, connect to the database that you created earlier and run the following scripts in SQL\*Plus:

1.  To create tables in the registry and user manager database ( `WSO2CARBON_DB` ), use the below script:

    ``` powershell
            SQL> @$<PRODUCT_HOME>/dbscripts/oracle.sql
    ```

2.  Restart the server.

        !!! info
    You can create database tables automatically **when starting the product for the first time** by using the `-Dsetup` parameter as follows:

    -   For Windows: `<PRODUCT_HOME>/bin/wso2server.bat -Dsetup`

    -   For Linux: `<PRODUCT_HOME>/bin/wso2server.sh -Dsetup`

        !!! warning
        Deprecation of -DSetup
    When proper Database Administrative (DBA) practices are followed, the systems (except analytics products) are not granted DDL (Data Definition) rights on the schema. Therefore, maintaining the `-DSetup` option is redundant and typically unusable. **As a result, from [January 2018 onwards](https://wso2.com/products/carbon/release-matrix/) WSO2 has deprecated the `-DSetup` option** . Note that the proper practice is for the DBA to run the DDL statements manually so that the DBA can examine and optimize any DDL statement (if necessary) based on the DBA best practices that are in place within the organization.





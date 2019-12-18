# Setting up Microsoft SQL

The following sections describe how to set up Microsoft SQL to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#SettingupMicrosoftSQL-Settingupthedatabaseandusers)
-   [Setting up the JDBC driver](#SettingupMicrosoftSQL-SettinguptheJDBCdriver)

### Setting up the database and users

Follow the steps below to set up the Microsoft SQL database and users.

#### Enable TCP/IP

1.  In the start menu, click **Programs** and launch **Microsoft SQL Server 2012.**
2.  Click **Configuration Tools** , and then click **SQL Server Configuration Manager** .
3.  Enable **TCP/IP** and disable **Named Pipes** from protocols of your Microsoft SQL server.
4.  Double click **TCP/IP** to open the TCP/IP properties window and set **Listen All** to `Yes` on the **Protocol** tab.
5.  On the **IP Address** tab, disable **TCP Dynamic Ports** by leaving it blank and give a valid TCP port, so that Microsoft SQL server will listen on that port.

        !!! info
    The best practice is to use port 1433, because you can use it in order processing services.


6.  Similarly, enable TCP/IP from **SQL Native Client Configuration** and disable **Named Pipes** . Also, check whether the port is set correctly to 1433.
7.  Restart Microsoft SQL server.

##### Create the database and user

1.  Open the Microsoft SQL Management Studio to create a database and user.
2.  Click **New Database** from the **Database** menu and specify all the options to create a new database.
3.  Click **New Login** from the **Logins** menu, and specify all the necessary options.

##### Grant permissions

Assign newly created users the required grants/permissions to log in and create tables, to insert, index, select, update and delete data in tables in the newly created database. These are the minimum set of SQL server permissions.

### Setting up the JDBC driver

[Download](https://msdn.microsoft.com/en-us/data/aa937724.aspx) and copy the sqljdbc4 Microsoft SQL JDBC driver file to the WSO2 product's `<PRODUCT_HOME>/repository/components/lib/` directory. Use `com.microsoft.sqlserver.jdbc.SQLServerDriver` asthe `<driverClassName>` in your datasource configuration in `<PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file as explained in the next section.

!!! info
In WSO2 IoT Server copy the driver file to the `<IOTS_HOME>/lib` directory


## What's next

By default, all WSO2 products are configured to use the embedded H2 database. To configure your product with MSSQL, see [Changing to MSSQL](https://docs.wso2.com/display/ADMIN44x/Changing+to+MSSQL) .


# Changing to MSSQL

By default, WSO2 products use the embedded H2 database as the database for storing user management and registry data. Given below are the steps you need to follow in order to use a MSSQL database for this purpose.

-   [Setting up datasource configurations](#ChangingtoMSSQL-Settingupdatasourceconfigurations)
    -   [Changing the default WSO2\_CARBON\_DB datasource](#ChangingtoMSSQL-ChangingthedefaultdatabaseChangingthedefaultWSO2_CARBON_DBdatasource)
    -   [Configuring new  datasources to manage registry or user management data](#ChangingtoMSSQL-ConfiguringnewdatasourcestomanageregistryorusermanagementdataConfiguringnewdatasourcestomanageregistryorusermanagementdata)
-   [Creating the database tables](#ChangingtoMSSQL-Creatingthedatabasetables)

!!! tip
Before you begin

You need to set up MSSQL before following the steps to configure your product with MSSQL. For more information, see [Setting up Microsoft SQL](https://docs.wso2.com/display/ADMIN44x/Setting+up+Microsoft+SQL) .


### Setting up datasource configurations

A datasource is used to establish the connection to a database. By default, `WSO2_CARBON_DB` datasource is used to connect to the default H2 database, which stores registry and user management data. After setting up the Microsoft SQL database to replace the default H2 database, either [change the default configurations of the `WSO2_CARBON_DB` datasource](#ChangingtoMSSQL-Changingthedefaultdatabase) , or [configure a new datasource](#ChangingtoMSSQL-Configuringnewdatasourcestomanageregistryorusermanagementdata) to point it to the new database as explained below.

#### Changing the default WSO2\_CARBON\_DB datasource

Follow the steps below to change the type of the default `WSO2_CARBON_DB` datasource.

1.  Edit the default datasourceconfigurationin the &lt; `PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file as shown below.

    ``` html/xml
        <datasource>
            <name>WSO2_CARBON_DB</name>
            <description>The datasource used for registry and user manager</description>
            <jndiConfig>
                   <name>jdbc/WSO2CarbonDB</name>
            </jndiConfig>
            <definition type="RDBMS">
                   <configuration>
                      <url>jdbc:sqlserver://<IP>:1433;databaseName=wso2greg;SendStringParametersAsUnicode=false</url>
                      <username>regadmin</username>
                      <password>regadmin</password>
                      <driverClassName>com.microsoft.sqlserver.jdbc.SQLServerDriver</driverClassName>
                      <maxActive>50</maxActive>
                      <maxWait>60000</maxWait>
                      <testOnBorrow>true</testOnBorrow>
                      <validationQuery>SELECT 1</validationQuery>
                      <validationInterval>30000</validationInterval>
                      <defaultAutoCommit>false</defaultAutoCommit>
                   </configuration>
            </definition>
        </datasource>
    ```

    The elements in the above configuration are described below:

    <table>
    <thead>
    <tr class="header">
    <th>Element</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><strong>url</strong></td>
    <td><div class="content-wrapper">
    <p>Give the URL to connect to the Microsoft SQL database. Shown below is the most simple form of the database connection URL. It includes the URL and two parameters:</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeContent panelContent pdl">
    <pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>jdbc:sqlserver://&lt;IP&gt;:&lt;PORT&gt;;databaseName=&lt;db_name_value&gt;;SendStringParametersAsUnicode=false</code></pre>
    </div>
    </div>
    <p>Change &lt;IP&gt; to the IP of the server. The best practice is to use port 1433 because you can use it in order processing services.</p>
        !!! warning
        <p>Set <strong><code>                  SendStringParametersAsUnicode                 </code></strong> to ‘false’ in order to overcome a limitation in the Microsoft SQL client driver. Without this parameter, the database driver will erroneously convert <code>                 VARCHAR                </code> data into <code>                 NVARCHAR                </code> and lower the database's performance.</p>

    </div></td>
    </tr>
    <tr class="even">
    <td><strong>username</strong> and <strong>password</strong></td>
    <td>The name and password of the database user</td>
    </tr>
    <tr class="odd">
    <td><strong>driverClassName</strong></td>
    <td>The class name of the database driver</td>
    </tr>
    <tr class="even">
    <td><strong>maxActive</strong></td>
    <td>The maximum number of active connections that can be allocated  at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.</td>
    </tr>
    <tr class="odd">
    <td><strong>maxWait</strong></td>
    <td>The maximum number of milliseconds that the pool will wait (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.</td>
    </tr>
    <tr class="even">
    <td><strong>minIdle</strong></td>
    <td>The minimum number of active connections that can remain idle in the pool without extra ones being created, or enter zero to create none.</td>
    </tr>
    <tr class="odd">
    <td><p><strong>testOnBorrow</strong></p></td>
    <td>The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and another attempt will be made to borrow another.</td>
    </tr>
    <tr class="even">
    <td><strong>validationQuery</strong></td>
    <td>The SQL query that will be used to validate connections from this pool before returning them to the caller.</td>
    </tr>
    <tr class="odd">
    <td><strong>validationInterval</strong></td>
    <td>The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation, but has been validated previously within this interval, it will not be validated again.</td>
    </tr>
    <tr class="even">
    <td><strong>defaultAutoCommit</strong></td>
    <td><p>This property is <strong>not</strong> applicable to the Carbon database in WSO2 products because auto committing is usually handled at the code level, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Typically, auto committing is enabled for RDBMS drivers by default.</p>
    <p>When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.</p></td>
    </tr>
    </tbody>
    </table>

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

#### Configuring new  datasources to manage registry or user management data

Follow the steps below to configure new datasources to point to the new  databases you create to manage registry and/or user management data separately.

1.  Add a new datasource with similar configurations as the [`WSO2_CARBON_DB` datasource](#ChangingtoMSSQL-Changingthedefaultdatabase) above to the &lt; `PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file. Change its elements with your custom values. For instructions, see [Setting up datasource configurations.](#ChangingtoMSSQL-Settingupdatasourceconfigurations)
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

To create the database tables, connect to the database that you created earlier and run the following scripts.

1.  To create tables in the registry and user manager database ( `WSO2CARBON_DB` ), use the below script:

    ``` java
            <PRODUCT_HOME>/dbscripts/mssql.sql
    ```

2.  Restart the server.

        !!! info
    You can create database tables automatically **when starting the product for the first time** by using the `-Dsetup` parameter as follows:

    -   For Windows: `<PRODUCT_HOME>/bin/wso2server.bat -Dsetup`

    -   For Linux: `<PRODUCT_HOME>/bin/wso2server.sh -Dsetup`

        !!! warning
        Deprecation of -DSetup
    When proper Database Administrative (DBA) practices are followed, the systems (except analytics products) are not granted DDL (Data Definition) rights on the schema. Therefore, maintaining the `-DSetup` option is redundant and typically unusable. **As a result, from [January 2018 onwards](https://wso2.com/products/carbon/release-matrix/) WSO2 has deprecated the `-DSetup` option** . Note that the proper practice is for the DBA to run the DDL statements manually so that the DBA can examine and optimize any DDL statement (if necessary) based on the DBA best practices that are in place within the organization.





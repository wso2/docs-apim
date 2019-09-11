# Changing the Default API-M Databases

When you use WSO2 API Manager (WSO2 API-M), you need the following databases in addition to the [Carbon database](https://docs.wso2.com/display/ADMIN44x/Changing+the+Carbon+Database) . By default, WSO2 API-M is shipped with embedded H2 databases for the following in addition to the Carbon database. These databases are stored in the `<API-M_HOME>/repository/database` directory.

-   **`WSO2AM_DB` :** For API-M-specific data.

-   **`WSO2MB_DB` :** For message brokering data.

-`WSO2METRICS_DB` : For storing data for Metrics monitoring.

!!! info
For instructions on changing the default Carbon database, see [Changing the Carbon Database](https://docs.wso2.com/display/ADMIN44x/Changing+the+Carbon+Database) in the WSO2 Product Administration Guide.

!!! info
Database Capacity

When planning the capacity of the underlying databases, note that the database holding the Access Tokens ( `WSO2AM_DB` ) and Statistics Data ( `WSO2AM_STATS_DB` ) will grow with the usage and the traffic on the gateway. To remove historical data see [Removing Unused Tokens from the Database](https://docs.wso2.com/display/AM260/Removing+Unused+Tokens+from+the+Database) and [Purging Analytics Data](https://docs.wso2.com/display/AM260/Purging+Analytics+Data)


Given below are the steps you need to follow in order to change the default databases listed above.

-   [Step 1 - Set up the database](#ChangingtheDefaultAPI-MDatabases-Step1-Setupthedatabase)
-   [Step 2 - Create the datasource connection](#ChangingtheDefaultAPI-MDatabases-Step2-Createthedatasourceconnection)
    -   [Create the datasource connection for the API-M database](#ChangingtheDefaultAPI-MDatabases-CreatethedatasourceconnectionfortheAPI-Mdatabase)
    -   [Create the datasource connection for the MB database (MB Store in WSO2 API-M)](#ChangingtheDefaultAPI-MDatabases-CreatethedatasourceconnectionfortheMBdatabase(MBStoreinWSO2API-M))
    -   [Create the datasource connection for the Metrics database](#ChangingtheDefaultAPI-MDatabases-CreatethedatasourceconnectionfortheMetricsdatabase)
    -   [Create the datasource connection for the Analytics database](#ChangingtheDefaultAPI-MDatabases-CreatethedatasourceconnectionfortheAnalyticsdatabase)
-   [Step 3 - Create database tables](#ChangingtheDefaultAPI-MDatabases-Step3-Createdatabasetables)
    -   [Create database tables in the API-M database](#ChangingtheDefaultAPI-MDatabases-CreatedatabasetablesintheAPI-Mdatabase)
    -   [Create database tables in the MB database](#ChangingtheDefaultAPI-MDatabases-CreatedatabasetablesintheMBdatabase)
    -   [Create database tables in the Metrics database](#ChangingtheDefaultAPI-MDatabases-CreatedatabasetablesintheMetricsdatabase)

------------------------------------------------------------------------

### Step 1 - Set up the database

You can set up the following database types for the API-M-specific databases:

-   [Setting up a MySQL database](https://docs.wso2.com/display/ADMIN44x/Setting+up+MySQL)
-   [Setting up an MS SQL database](https://docs.wso2.com/display/ADMIN44x/Setting+up+Microsoft+SQL)
-   [Setting up an Oracle database](https://docs.wso2.com/display/ADMIN44x/Setting+up+Oracle)
-   [Setting up an IBM DB2 database](https://docs.wso2.com/display/ADMIN44x/Setting+up+IBM+DB2)
-   [Setting up a PostgreSQL database](https://docs.wso2.com/display/ADMIN44x/Setting+up+PostgreSQL)

!!! note
Note that we recommend to use Fail Over configuration over Load Balanced configuration with the MySQL clusters.


### Step 2 - Create the datasource connection

A datasource is used to establish the connection to a database. By default, datasource connections for the API-M database, API-M statistics database, and the Message Brokering database are configured in the `master-` datasources `.xml` file. The datasource connection for the Metrics database is configured in the `metrics-` datasources `.xml` file. These datasource configurations point to the default  H2 databases, which are shipped with the product. After setting up new databases to replace the default H2 databases, you can either change the default configurations in the above-mentioned files or configure new datasources.

#### Create the datasource connection for the API-M database

Follow the steps below.

1.  Open the &lt; `API-M_HOME>/repository/conf/datasources/master-datasources.xml` file and locate the `<datasource>` configuration element.

2.  Update the **URL** pointing to your database, the **username** and **password** required to access the database, and the **driver** details as shown below.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Optionally, you can update the other elements for your database connection.

    | Element                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
    |-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | `maxActive`             | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    | `maxWait`               | The maximum number of milliseconds that the pool waits (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                                                                                                                                                                                                                                                                                                                      |
    | `minIdle`               | The minimum number of active connections that can remain idle in the pool without extra ones being created. You can enter zero to create none.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
    | `testOnBorrow`          | The indication of whether objects are validated before being borrowed from the pool. If the object fails to validate, it is dropped from the pool, and another attempt is made to borrow another.                                                                                                                                                                                                                                                                                                                                                                                                                                |
    | `validationQuery`       | The SQL query that is used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
    | `validationInterval`    | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it is not validated again.                                                                                                                                                                                                                                                                                                                                                                               |
    | **`defaultAutoCommit`** | This property is only applicable to the [MB Store database](#ChangingtheDefaultAPI-MDatabases-CreatingthedatasourceconnectionfortheMBdatabase(MBStoreinWSO2APIM)) of WSO2 APIM, where this property should be explicitly set to `false` . In all other database connections explained above, auto committing is enabled or disabled at the code level as required for that database, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Note that auto committing is typically enabled for an RDBMS by default. 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.                                                                                                                                                                                                                                                                                                                                                                                                                                         |

        !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/conf/datasources/master-datasources.xml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes) .

    -   [**MySQL**](#fc0ba8bc54444ede93888019d9694fd4)
    -   [**MS SQL**](#1efb222cc27d44c9bd697220af1f07a7)
    -   [**Oracle**](#6f0a30dd76b54021810fe73159f3eefb)
    -   [**IBM DB2**](#38b828a70de945aa8d123b763a22bee6)
    -   [**PostgreSQL**](#2b5156d19d2c4e5ea16d063b246d1692)

    ``` html/xml
        <datasource>
              <name>WSO2AM_DB</name>
              <description>The datasource used for API Manager database</description>
              <jndiConfig>
                    <name>jdbc/WSO2AM_DB</name>
              </jndiConfig>
              <definition type="RDBMS">
                    <configuration>
                        <url>jdbc:mysql://localhost:3306/WSO2AM_DB</url>
                        <username></username>
                        <password></password>
                        <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                        <maxActive>80</maxActive>
                        <maxWait>60000</maxWait>
                        <minIdle>5</minIdle>
                        <testOnBorrow>true</testOnBorrow>
                        <validationQuery>SELECT 1</validationQuery>
                        <validationInterval>30000</validationInterval>
                        <defaultAutoCommit>true</defaultAutoCommit>
                    </configuration>
              </definition>
        </datasource>
    ```

    ``` xml
            <datasource>
                  <name>WSO2AM_DB</name>
                  <description>The datasource used for API Manager database</description>
                  <jndiConfig>
                        <name>jdbc/WSO2AM_DB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:jtds:sqlserver://localhost:1433/WSO2AM_DB</url>
                            <username></username>
                            <password></password>
                            <driverClassName>com.microsoft.sqlserver.jdbc.SQLServerDriver</driverClassName>
                            <maxActive>200</maxActive>
                            <maxWait>60000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                  </definition>
            </datasource>         
    ```

    ``` xml
            <datasource>
                  <name>WSO2AM_DB</name>
                  <description>The datasource used for API Manager database</description>
                  <jndiConfig>
                        <name>jdbc/WSO2AM_DB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:oracle:thin:@localhost:1521/orcl</url>
                            <username></username>
                            <password></password>
                            <driverClassName>oracle.jdbc.driver.OracleDriver</driverClassName>
                            <maxActive>100</maxActive>
                            <maxWait>60000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1 FROM DUAL</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                  </definition>
            </datasource>
    ```

    ``` xml
            <datasource>
                  <name>WSO2AM_DB</name>
                  <description>The datasource used for API Manager database</description>
                  <jndiConfig>
                        <name>jdbc/WSO2AM_DB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:db2://SERVER_NAME:PORT/WSO2AM_DB</url>
                            <username></username>
                            <password></password>
                            <driverClassName>com.ibm.db2.jcc.DB2Driver</driverClassName>
                            <maxActive>80</maxActive>
                            <maxWait>360000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                  </definition>
            </datasource>
    ```

    ``` xml
            <datasource>
                  <name>WSO2AM_DB</name>
                  <description>The datasource used for API Manager database</description>
                  <jndiConfig>
                        <name>jdbc/WSO2AM_DB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:postgresql://localhost:5432/WSO2AM_DB</url>
                            <username></username>
                            <password></password>
                            <driverClassName>org.postgresql.Driver</driverClassName>
                            <maxActive>80</maxActive>
                            <maxWait>60000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>               
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                  </definition>
            </datasource>
    ```

#### Create the datasource connection for the MB database (MB Store in WSO2 API-M)

Follow the steps below.

1.  Open the &lt; `API-M_HOME>/repository/conf/datasources/master-datasources.xml` file and locate the `<datasource>` configuration element.

2.  Update the **URL** pointing to your database, the **username** and **password** required to access the database, and the **driver** details as shown below. Further, be sure to set the [**`<defaultAutoCommit>            `** element](#ChangingtheDefaultAPI-MDatabases-default_auto_commit) to `false` for the MB database.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Optionally, you can update the other elements for your database connection.

    | Element                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
    |-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | `maxActive`             | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    | `maxWait`               | The maximum number of milliseconds that the pool waits (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                                                                                                                                                                                                                                                                                                                      |
    | `minIdle`               | The minimum number of active connections that can remain idle in the pool without extra ones being created. You can enter zero to create none.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
    | `testOnBorrow`          | The indication of whether objects are validated before being borrowed from the pool. If the object fails to validate, it is dropped from the pool, and another attempt is made to borrow another.                                                                                                                                                                                                                                                                                                                                                                                                                                |
    | `validationQuery`       | The SQL query that is used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
    | `validationInterval`    | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it is not validated again.                                                                                                                                                                                                                                                                                                                                                                               |
    | **`defaultAutoCommit`** | This property is only applicable to the [MB Store database](#ChangingtheDefaultAPI-MDatabases-CreatingthedatasourceconnectionfortheMBdatabase(MBStoreinWSO2APIM)) of WSO2 APIM, where this property should be explicitly set to `false` . In all other database connections explained above, auto committing is enabled or disabled at the code level as required for that database, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Note that auto committing is typically enabled for an RDBMS by default. 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.                                                                                                                                                                                                                                                                                                                                                                                                                                         |

        !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/conf/datasources/master-datasources.xml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes) .

        !!! note
    If you are using PostgresSQL, make sure to remove the &lt;validationQuery&gt; property from the datasource configuration.


    -   [**MySQL**](#7a8a914e8014401d9ed6e745b5b73049)
    -   [**MS SQL**](#32a4f58344794510916e1f3e686b3793)
    -   [**Oracle**](#4e83c1e81cd74f7a9e0277bb1df58d85)
    -   [**IBM DB2**](#37a242dd353d4469b92b18aaadbe9960)
    -   [**PostgreSQL**](#4f45c9a4554d413199e2e6af1262ae1e)

    ``` html/xml
        <datasource>
              <name>WSO2_MB_STORE_DB</name>
              <description>The datasource used for message broker database</description>
              <jndiConfig>
                    <name>WSO2MBStoreDB</name>
              </jndiConfig>
              <definition type="RDBMS">
                    <configuration>
                        <url>jdbc:mysql://localhost:3306/WSO2MB_DB</url>
                        <username></username>
                        <password></password>
                        <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                        <maxActive>80</maxActive>
                        <maxWait>60000</maxWait>
                        <minIdle>5</minIdle>
                        <testOnBorrow>true</testOnBorrow>
                        <validationQuery>SELECT 1</validationQuery>
                        <validationInterval>30000</validationInterval>
                        <defaultAutoCommit>true</defaultAutoCommit>
                    </configuration>
              </definition>
        </datasource>
    ```

    ``` xml
            <datasource>
                  <name>WSO2_MB_STORE_DB</name>
                  <description>The datasource used for message broker database</description>
                  <jndiConfig>
                        <name>WSO2MBStoreDB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:jtds:sqlserver://localhost:1433/WSO2MB_DB</url>
                            <username></username>
                            <password></password>
                            <driverClassName>com.microsoft.sqlserver.jdbc.SQLServerDriver</driverClassName>
                            <maxActive>200</maxActive>
                            <maxWait>60000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                  </definition>
            </datasource>         
    ```

    ``` xml
            <datasource>
                  <name>WSO2_MB_STORE_DB</name>
                  <description>The datasource used for message broker database</description>
                  <jndiConfig>
                        <name>WSO2MBStoreDB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:oracle:thin:@localhost:1521/orcl</url>
                            <username></username>
                            <password></password>
                            <driverClassName>oracle.jdbc.driver.OracleDriver</driverClassName>
                            <maxActive>100</maxActive>
                            <maxWait>60000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1 FROM DUAL</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                  </definition>
            </datasource>
    ```

    ``` html/xml
            <datasource>
                  <name>WSO2_MB_STORE_DB</name>
                  <description>The datasource used for message broker database</description>
                  <jndiConfig>
                        <name>WSO2MBStoreDB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:db2://SERVER_NAME:PORT/WSO2MB_DB</url>
                            <username></username>
                            <password></password>
                            <driverClassName>com.ibm.db2.jcc.DB2Driver</driverClassName>
                            <maxActive>80</maxActive>
                            <maxWait>360000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>
                            <validationQuery>SELECT 1</validationQuery>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                   </definition>
            </datasource>
    ```

    ``` xml
            <datasource>
                  <name>WSO2_MB_STORE_DB</name>
                  <description>The datasource used for message broker database</description>
                  <jndiConfig>
                        <name>WSO2MBStoreDB</name>
                  </jndiConfig>
                  <definition type="RDBMS">
                        <configuration>
                            <url>jdbc:postgresql://localhost:5432/WSO2MB_DB</url>
                            <username></username>
                            <password></password>
                            <driverClassName>org.postgresql.Driver</driverClassName>
                            <maxActive>80</maxActive>
                            <maxWait>60000</maxWait>
                            <minIdle>5</minIdle>
                            <testOnBorrow>true</testOnBorrow>
                            <validationInterval>30000</validationInterval>
                            <defaultAutoCommit>true</defaultAutoCommit>
                        </configuration>
                   </definition>
            </datasource>
    ```

#### Create the datasource connection for the Metrics database

Follow the steps below.

1.  Open the &lt; `API-M_HOME>/repository/conf/datasources/metrics-datasources.xml` file and locate the `<datasource>` configuration element.

2.  Update the **URL** pointing to you database, the **username** and **password** required to access the database, and the **driver** details as shown below.

    ![](images/icons/grey_arrow_down.png){.expand-control-image} Optionally, you can update the other elements for your database connection.

    | Element                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
    |------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | `maxActive`            | The maximum number of active connections that can be allocated at the same time from this pool. Enter any negative value to denote an unlimited number of active connections.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
    | `maxWait`              | The maximum number of milliseconds that the pool waits (when there are no available connections) for a connection to be returned before throwing an exception. You can enter zero or a negative value to wait indefinitely.                                                                                                                                                                                                                                                                                                                                                                                                      |
    | `minIdle`              | The minimum number of active connections that can remain idle in the pool without extra ones being created. You can enter zero to create none.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
    | `testOnBorrow`         | The indication of whether objects are validated before being borrowed from the pool. If the object fails to validate, it is dropped from the pool, and another attempt is made to borrow another.                                                                                                                                                                                                                                                                                                                                                                                                                                |
    | `validationQuery`      | The SQL query that is used to validate connections from this pool before returning them to the caller.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
    | `validationInterval`   | The indication to avoid excess validation, and only run validation at the most, at this frequency (time in milliseconds). If a connection is due for validation but has been validated previously within this interval, it is not validated again.                                                                                                                                                                                                                                                                                                                                                                               |
    | **`defaultAutoCommi`** | This property is only applicable to the [MB Store database](#ChangingtheDefaultAPI-MDatabases-CreatingthedatasourceconnectionfortheMBdatabase(MBStoreinWSO2APIM)) of WSO2 APIM, where this property should be explicitly set to `false` . In all other database connections explained above, auto committing is enabled or disabled at the code level as required for that database, i.e., the default auto commit configuration specified for the RDBMS driver will be effective instead of this property element. Note that auto committing is typically enabled for an RDBMS by default. 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      When auto committing is enabled, each SQL statement will be committed to the database as an individual transaction, as opposed to committing multiple statements as a single transaction.                                                                                                                                                                                                                                                                                                                                                                                                                                         |

        !!! info
        For more information on other parameters that can be defined in the `<API-M_HOME>/conf/datasources/master-datasources.xml` file, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Tomcat_JDBC_Enhanced_Attributes) .

-   [**MySQL**](#c29481cd6f83408485305530714ab7f6)
-   [**MS SQL**](#4ec87fe0533743d68b3c3fb2faf76dbb)
-   [**Oracle**](#c898c5554f034b649dc0bda14cf95295)
-   [**PostgreSQL**](#63c10ea37ed94bc6a09226391472b918)

``` html/xml
    <datasource>
          <name>WSO2_METRICS_DB</name>
          <description>The MySQL datasource used for WSO2 Carbon Metrics</description>
          <jndiConfig>
                <name>jdbc/WSO2MetricsDB</name>
          </jndiConfig>
          <definition type="RDBMS">
                 <configuration>
                     <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                     <url>jdbc:mysql://localhost:3306/WSO2METRICS_DB</url>
                     <username>root</username>
                     <password>root</password>
                     <maxActive>50</maxActive>
                     <maxWait>60000</maxWait>
                     <minIdle>5</minIdle>
                     <testOnBorrow>true</testOnBorrow>
                     <validationQuery>SELECT 1</validationQuery>
                     <validationInterval>30000</validationInterval>
                     <defaultAutoCommit>true</defaultAutoCommit>
                </configuration>
          </definition>
    </datasource>
```

``` xml
    <datasource>
          <name>WSO2_METRICS_DB</name>
          <description>The MSSQL datasource used for WSO2 Carbon Metrics</description>
          <jndiConfig>
                <name>jdbc/WSO2MetricsDB</name>
          </jndiConfig>
          <definition type="RDBMS">
                <configuration>
                    <driverClassName>net.sourceforge.jtds.jdbc.Driver</driverClassName>
                    <url>jdbc:jtds:sqlserver://localhost:1433/wso2_metrics</url>
                    <username>sa</username>
                    <password>sa</password>
                    <maxActive>200</maxActive>
                    <maxWait>60000</maxWait>
                    <minIdle>5</minIdle>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1</validationQuery>
                    <validationInterval>30000</validationInterval>
                    <defaultAutoCommit>true</defaultAutoCommit>
                </configuration>
          </definition>
    </datasource>       
```

``` xml
    <datasource>
          <name>WSO2_METRICS_DB</name>
          <description>The Oracle datasource used for WSO2 Carbon Metrics</description>
          <jndiConfig>
                <name>jdbc/WSO2MetricsDB</name>
          </jndiConfig>
          <definition type="RDBMS">
                <configuration>
                    <driverClassName>oracle.jdbc.OracleDriver</driverClassName>
                    <url>jdbc:oracle:thin:@localhost:1521/wso2_metrics</url>
                    <username>scott</username>
                    <password>tiger</password>
                    <maxActive>100</maxActive>
                    <maxWait>60000</maxWait>
                    <minIdle>5</minIdle>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1 FROM DUAL</validationQuery>
                    <validationInterval>30000</validationInterval>
                    <defaultAutoCommit>true</defaultAutoCommit>
                    <databaseProps>
                        <property name="SetFloatAndDoubleUseBinary">true</property>
                    </databaseProps>
                </configuration>
          </definition>
    </datasource>
```

``` xml
    <datasource>
          <name>WSO2_METRICS_DB</name>
          <description>The MSSQL datasource used for WSO2 Carbon Metrics</description>
          <jndiConfig>
                <name>jdbc/WSO2MBStoreDB</name>
          </jndiConfig>
          <definition type="RDBMS">
                <configuration>
                    <url>jdbc:postgresql://localhost:5432/wso2_metrics</url>
                    <username></username>
                    <password></password>
                    <driverClassName>org.postgresql.Driver</driverClassName>
                    <maxActive>80</maxActive>
                    <maxWait>60000</maxWait>
                    <minIdle>5</minIdle>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1</validationQuery>
                    <validationInterval>30000</validationInterval>
                    <defaultAutoCommit>true</defaultAutoCommit>
                </configuration>
           </definition>
    </datasource>
```

#### Create the datasource connection for the Analytics database

!!! note
This section is only applicable if you have downloaded the [WSO2 API Analytics distribution](http://wso2.com/api-management/#download) to use WSO2 API Analytics with WSO2 API-M.


The API Manager integrates with the WSO2 Analytics platform to provide reports, statistics, and graphs on the APIs deployed in WSO2 API Manager. You can then configure alerts to monitor these APIs, and detect unusual activity, manage locations via geo location statistics, and carry out detailed analysis of the logs.

Follow the steps below to create the datasource connection for the Analytics database:

!!! warning
When working with Analytics, ensure that the `WSO2AM_DB` database is of the same RDBMS type as the Analytics database. For example, if the Analytics related DBs are created in MySQL, the API-M databases ( `WSO2AM_DB` ) should also be created in MySQL.


!!! info
The following is a list of database versions that are compatible with WSO2 API-M Analytics.

-   Postgres 9.5 and later
-   MySQL 5.6
-   MySQL 5.7
-   Oracle 12c
-   MS SQL Server 2012
-   DB2


1.  Stop the WSO2 API-M Analytics server if it is running already.
2.  Configure the dashboard profile.

    1.  Open the `<API-M_ANALYTICS_HOME>/conf/dashboard/deployment.yaml` file.

    2.  Edit the `APIM_ANALYTICS_DB` section.
        A sample for MySQL is shown below.

        ``` java
                 - name: APIM_ANALYTICS_DB
                      description: "The datasource used for APIM statistics aggregated data."
                      jndiConfig:
                        name: jdbc/APIM_ANALYTICS_DB
                      definition:
                        type: RDBMS
                        configuration:
                          jdbcUrl: 'jdbc:mysql://localhost:3306/ANALYTICS_DB'
                          username: 'root'
                          password: '123'
                          driverClassName: com.mysql.jdbc.Driver
                          maxPoolSize: 50
                          idleTimeout: 60000
                          connectionTestQuery: SELECT 1
                          validationTimeout: 30000
                          isAutoCommit: false
        ```

3.  Configure the worker profile.

        !!! note
    If your deployment does not consist of any Mirogateways, you do not need to configure the `WSO2AM_MGW_ANALYTICS_DB` to an external database as you can use the default embedded H2 database.


    1.  Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.
    2.  Edit the `APIM_ANALYTICS_DB` section.
        A sample for MySQL is shown below.

        ``` java
                 - name: APIM_ANALYTICS_DB
                      description: "The datasource used for APIM statistics aggregated data."
                      jndiConfig:
                        name: jdbc/APIM_ANALYTICS_DB
                      definition:
                        type: RDBMS
                        configuration:
                          jdbcUrl: 'jdbc:mysql://localhost:3306/ANALYTICS_DB'
                          username: 'root'
                          password: '123'
                          driverClassName: com.mysql.jdbc.Driver
                          maxPoolSize: 50
                          idleTimeout: 60000
                          connectionTestQuery: SELECT 1
                          validationTimeout: 30000
                          isAutoCommit: false
        ```

    3.  Configure `WSO2AM_MGW_ANALYTICS_DB` to the same database as `APIM_ANALYTICS_DB` in the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.

        ``` java
                     - name: WSO2AM_MGW_ANALYTICS_DB
                          description: "The datasource used for APIM MGW analytics data."
                          jndiConfig:
                            name: jdbc/WSO2AM_MGW_ANALYTICS_DB
                          definition:
                            type: RDBMS
                            configuration:
                              jdbcUrl: 'jdbc:mysql://localhost:3306/ANALYTICS_DB'
                              username: 'root'
                              password: '123'
                              driverClassName: com.mysql.jdbc.Driver
                              maxPoolSize: 50
                              idleTimeout: 60000
                              connectionTestQuery: SELECT 1
                              validationTimeout: 30000
                              isAutoCommit: false
        ```

    4.  Create the `AM_USAGE_UPLOADED_FILES` table in the `APIM_ANALYTICS_DB` database.

        -   [**MySQL**](#mysql-AM_USAGE_UPLOADED_FILES)
        -   [**MSSQL**](#MSSQL-AM_USAGE_UPLOADED_FILES)
        -   [**Oracle**](#Oracle-AM_USAGE_UPLOADED_FILES)
        -   [**Postgres**](#Postgres-AM_USAGE_UPLOADED_FILES)
        -   [**DB2**](#DB2-AM_USAGE_UPLOADED_FILES)
        -   [**Informix**](#INFORMIX-AM_USAGE_UPLOADED_FILES)

        ``` java
                    CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
                    FILE_NAME varchar(255) NOT NULL,
                    FILE_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FILE_PROCESSED tinyint(1) DEFAULT 0,
                    FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
                    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
                    );
        ```

        ``` java
                    CREATE TABLE AM_USAGE_UPLOADED_FILES (
                    FILE_NAME varchar(255) NOT NULL,
                    FILE_TIMESTAMP DATETIME2(0) DEFAULT GETDATE(),
                    FILE_PROCESSED smallint DEFAULT 0,
                    FILE_CONTENT VARBINARY(max) DEFAULT NULL,
                    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
                    );
        ```

        ``` java
                    CREATE TABLE AM_USAGE_UPLOADED_FILES (
                    FILE_NAME varchar2(255) NOT NULL,
                    FILE_TIMESTAMP TIMESTAMP(0) DEFAULT SYSTIMESTAMP,
                    FILE_PROCESSED number(3) DEFAULT 0,
                    FILE_CONTENT BLOB DEFAULT NULL,
                    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
                    );
        ```

        ``` java
                    CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
                    FILE_NAME varchar(255) NOT NULL,
                    FILE_TIMESTAMP TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP,
                    FILE_PROCESSED smallint DEFAULT 0,
                    FILE_CONTENT BYTEA DEFAULT NULL,
                    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
                    );
        ```

        ``` java
                    CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
                    FILE_NAME varchar(255) NOT NULL,
                    FILE_TIMESTAMP TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP,
                    FILE_PROCESSED tinyint DEFAULT 0,
                    FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
                    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
                    );
        ```

        ``` java
                    CREATE TABLE IF NOT EXISTS AM_USAGE_UPLOADED_FILES (
                    FILE_NAME varchar(255) NOT NULL,
                    FILE_TIMESTAMP TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP,
                    FILE_PROCESSED tinyint DEFAULT 0,
                    FILE_CONTENT MEDIUMBLOB DEFAULT NULL,
                    PRIMARY KEY (FILE_NAME, FILE_TIMESTAMP)
                    );
        ```

4.  Point the following data sources to external databases.
    None of the following databases need DB scripts. The tables will be automatically created.

    -`BUSINESS_RULES_DB` (dashboard)
    -`WSO2_PERMISSIONS_DB` (worker + dashboard)
    -`GEO_LOCATION_DATA` (Only if you need [geo-location based statistics](https://docs.wso2.com/display/AM260/Configuring+Geolocation+Based+Statistics) .)

5.  Integrate third-party products when configuring the databases.

        !!! note
    WSO2 SP is a OSGi-based product. Therefore, when you integrate third party products such as Oracle with WSO2 API-M Analytics, you need to check whether the libraries you need to add are OSGi based. If they are not, you need to convert them to OSGi bundles before adding them to the `<API-M_ANALYTICS_HOME>/lib` directory.

    To convert the jar files to OSGi bundles, follow the steps below.

    1. Download the non-OSGi jar for the required third party product, and save it in a preferred directory in your machine.

    2. Go to the `<API-M_ANALYTICS_HOME>/bin` directory. Run the command given below, to generate the converted file in the `<API-M_ANALYTICS_HOME>/lib` directory.

    ``` java
        ./jartobundle.sh <PATH_TO_NON-OSGi_JAR> ../lib
    ```


6.  Start the WSO2 API-M Analytics server.

### Step 3 - Create database tables

To create the database tables, connect to the databases that you created earlier and run the scripts provided in the product pack.

#### Create database tables in the API-M database

The DB scripts corresponding to the database type are provided in the `<API-M_HOME>/dbscripts/apimgt` directory.

To create the necessary database tables:

1.  Connect to the database and run the relevant script.
    For example, run the following command to create the API-M tables in a **MySQL** database.

    ``` powershell
        mysql -u root -p -DWSO2AM_DB < '<API-M_HOME>/dbscripts/apimgt/mysql.sql';
    ```

        !!! note
`<API-M_HOME>/dbscripts/mb-store/apimgt/mysql.sql` is the script that should be used for MySQL 5.6 and prior versions. If you database is MySQL 5.7 or later version, use `<API-M_HOME>/dbscripts/apimgt/mb-store/mysql5.7.sql` script file.


2.  Restart the WSO2 API-M server.

#### Create database tables in the MB database

The DB scripts corresponding to the database type are provided in the `<API-M_HOME>/dbscripts/mb-store` directory.

To create the necessary database tables:

1.  Connect to the database and run the relevant script.
    For example, run the following command to create the MB tables in a **MySQL** database.

    ``` powershell
        mysql -u root -p -DWSO2MB_DB < '<API-M_HOME>/dbscripts/mb-store/mysql.sql';
    ```

        !!! note
`<API-M_HOME>/dbscripts/mb-store/mb-store/mysql.sql` is the script that should be used for MySQL 5.6 and prior versions. If you database is MySQL 5.7 or later version, use `<API-M_HOME>/dbscripts/mb-store/mb-store/mysql5.7.sql` script file.


2.  Restart the WSO2 API-M server.

#### Create database tables in the Metrics database

The DB scripts corresponding to the database type are provided in the `<API-M_HOME>/dbscripts/metrics` directory.

To create the necessary database tables:

1.  Connect to the database and run the relevant script.
    For example, run the following command to create the MB tables in a **MySQL** database.

    ``` powershell
        mysql -u root -p -DWSO2_METRICS_DB < '<API-M_HOME>/dbscripts/metrics/mysql.sql';
    ```

        !!! note
`<API-M_HOME>/dbscripts/metrics/metrics/mysql.sql` is the script that should be used for MySQL 5.6 and prior versions. If you database is MySQL 5.7 or later version, use `<API-M_HOME>/dbscripts/metrics/metrics/mysql5.7.sql` script file.


2.  Restart the WSO2 API-M server.


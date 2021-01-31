# Configuring Data Sources

In the Streaming Integrator, there are datasources specific to both the Streaming Integrator server and Streaming Integrator Tooling. The data sources of
each runtime are defined in the `<SI_HOME>|<SI_TOOLING_HOME>/conf/server/deployment.yaml` file.

e.g., To configure a data source in the server runtime, the relevant configurations need to be added in the `<SI_Home>/conf/server/deployment.yaml` file.

To view a sample data source configuration for each database type supported, expand the following sections:

!!!info
    If the database driver is not an OSGI bundle, then it should be converted to OSGI (using jartobundle.sh) before placing it in the
    `<SI_HOME>|<SI_TOOLING_HOME>/lib` directory. For detailed instructions,see [Adding Third Party Non OSGi Libraries]({{base_path}}/install-and-setup/setup/si-setup/adding-third-party-non-osgi-libraries.md).

    e.g., `sh WSO2_SI_HOME/bin/jartobundle.sh ojdbc6.jar WSO2_SI_HOME/lib/`

    The database should be tuned to handle the total **maxPoolSize** (The maximum number of threads that should be reserved at any given time to handle events) that is defined in the `deployment.yaml` file.


???info "MySQL"
    ``` xml
        wso2.datasources:
         dataSources:
         name: TEST_DB
         description: The datasource used for test database
         jndiConfig:
         definition:
           type: RDBMS
           configuration:
             jdbcUrl: jdbc:mysql://hostname:port/testdb
             username: root
             password: root
             driverClassName: com.mysql.jdbc.Driver
             minIdle: 5
             maxPoolSize: 50
             idleTimeout: 60000
             connectionTestQuery: SELECT 1
             validationTimeout: 30000
             isAutoCommit: false
    ```
    
    ** Parameter descriptions*
    
    | **Parameter**         | **Description**                                                           |
    |-----------------------|---------------------------------------------------------------------------|
    | `name`                | A unique name for the data source. |
    | `description`         | A description of the data source. |
    | `type`                | The database type to which the data source connects. |
    | `jdbcUrl`             | The string used by the database driver to connect to the database. |
    | `username`            | the username with which WSO2 Streaming Integrator accesses the database.|
    | `password`            | The password with which WSO2 Streaming Integrator accesses the database. |
    | `driverClassName`     | The name of the driver class that establishes the connection to the database. |
    | `minIdle`             | The minimum number of active connections that can remain idle in the pool at a given time without extra connections being created. e.g., If you specify `2` as the value for this parameter, the system creates a new connection to the database only if the connection pool currently has only two or less active and idle connections. | 
    | `maxPoolSize`         | The maximum number of total connections that are allowed to exist in the connection pool at a given time. |
    | `idleTimeout`         | The maximum duration of time (in milliseconds) for which the system allows a connection to the database to be idle before closing it. |
    | `connectionTestQuery` | The test query executed on the database to check the validity of the connection. |
    | `validationTimeout`   | The maximum duration of time (in milliseconds) that is allowed between validation tests carried out for the database connection. |
    | `isAutoCommit`        | If this parameter is set to `true`, each database query you perform during a single session is treated as a separate database transaction. As a result, the result of any query is visible to other database sessions soon after it is executed. If this parameter is set to `true`, the system considers the whole database session as a single transaction. Therefore, the reults of all the queries you execute within a single session are visible only after the session is over. |
    
???info "POSTGRES"
    ``` xml
    wso2.datasources:
     dataSources:
         description: The datasource used for test database
         jndiConfig:
         definition:
           type: RDBMS
          configuration:
            jdbcUrl: jdbc:postgresql://hostname:port/testdb
            username: root
            password: root
            driverClassName: org.postgresql.Driver
            minIdle: 5
            maxPoolSize: 50
            idleTimeout: 60000
            connectionTestQuery: SELECT 1
            validationTimeout: 30000
            isAutoCommit: false
    ```
    | **Parameter**         | **Description**                                                           |
    |-----------------------|---------------------------------------------------------------------------|
    | `name`                | A unique name for the data source. |
    | `description`         | A description of the data source. |
    | `type`                | The database type to which the data source connects. |
    | `jdbcUrl`             | The string used by the database driver to connect to the database. |
    | `username`            | the username with which WSO2 Streaming Integrator accesses the database.|
    | `password`            | The password with which WSO2 Streaming Integrator accesses the database. |
    | `driverClassName`     | The name of the driver class that establishes the connection to the database. |
    | `minIdle`             | The minimum number of active connections that can remain idle in the pool at a given time without extra connections being created. e.g., If you specify `2` as the value for this parameter, the system creates a new connection to the database only if the connection pool currently has only two or less active and idle connections. | 
    | `maxPoolSize`         | The maximum number of total connections that are allowed to exist in the connection pool at a given time. |
    | `idleTimeout`         | The maximum duration of time (in milliseconds) for which the system allows a connection to the database to be idle before closing it. |
    | `connectionTestQuery` | The test query executed on the database to check the validity of the connection. |
    | `validationTimeout`   | The maximum duration of time (in milliseconds) that is allowed between validation tests carried out for the database connection. |
    | `isAutoCommit`        | If this parameter is set to `true`, each database query you perform during a single session is treated as a separate database transaction. As a result, the result of any query is visible to other database sessions soon after it is executed. If this parameter is set to `true`, the system considers the whole database session as a single transaction. Therefore, the reults of all the queries you execute within a single session are visible only after the session is over. |
    
???info "Oracle"
    There are two ways to configure this database type. If you have a System
    Identifier (SID), use this (older) format:
    
    `jdbc:oracle:thin:@[HOST][:PORT]:SID`
    
    ``` xml
    wso2.datasources:
     dataSources:
         description: The datasource used for test database
         jndiConfig:
         definition:
           type: RDBMS
           configuration:
             jdbcUrl: jdbc:oracle:thin:@hostname:port:SID
             username: testdb
             password: root
             driverClassName: oracle.jdbc.driver.OracleDriver
             minIdle: 5
             maxPoolSize: 50
             idleTimeout: 60000
             connectionTestQuery: SELECT 1
             validationTimeout: 30000
             isAutoCommit: false
    ```
    
    If you have an Oracle service name, use this (newer) format:
    
    `jdbc:oracle:thin:@//[HOST][:PORT]/SERVICE`
    
    ``` xml
    wso2.datasources:
     dataSources:
         description: The datasource used for test database
         jndiConfig:
         definition:
           type: RDBMS
           configuration:
             jdbcUrl: jdbc:oracle:thin:@hostname:port/SERVICE
             username: testdb
             password: root
             driverClassName: oracle.jdbc.driver.OracleDriver
             minIdle: 5
             maxPoolSize: 50
             idleTimeout: 60000
             connectionTestQuery: SELECT 1
             validationTimeout: 30000
             isAutoCommit: false
    ```
    
    The Oracle driver need to be converted to OSGi (using `jartobundle.sh`) before put into `SI_HOME/lib` directory. For detailed
    instructions, see [Adding Third Party Non OSGi Libraries]({{base_path}}/install-and-setup/setup/si-setup/adding-third-party-non-osgi-libraries.md).
    
    If you are using persisted aggregations, you can include the `connectionInitSql` parameter instead of `connectionTestQuery` as shown in the following sample configuration.
    
    ```
    Sample datasource configuration -
    
     - name: TEST_DB
       description: The datasource used for test database
       jndiConfig:
         name: jdbc/TEST_DB
       definition:
         type: RDBMS
         configuration:
           jdbcUrl: jdbc:oracle:thin:@localhost:1521/ORCLCDB.localdomain
           username: <username>
           password: <password>
           driverClassName: oracle.jdbc.driver.OracleDriver
           minIdle: 5
           maxPoolSize: 50
           idleTimeout: 60000
           connectionInitSql: ALTER SESSION SET NLS_DATE_FORMAT='RRRR/fmMM/fmDD'
           validationTimeout: 30000
           isAutoCommit: false  
    ```
    
    | **Parameter**       | **Description**                                                           |
    |---------------------|---------------------------------------------------------------------------|
    | name                | A unique name for the data source. |
    | description         | A description of the data source. |
    | type                | The database type to which the data source connects. |
    | jdbcUrl             | The string used by the database driver to connect to the database. |
    | username            | the username with which WSO2 Streaming Integrator accesses the database.|
    | password            | The password with which WSO2 Streaming Integrator accesses the database. |
    | driverClassName     | The name of the driver class that establishes the connection to the database. |
    | minIdle             | The minimum number of active connections that can remain idle in the pool at a given time without extra connections being created. e.g., If you specify `2` as the value for this parameter, the system creates a new connection to the database only if the connection pool currently has only two or less active and idle connections. | 
    | maxPoolSize         | The maximum number of total connections that are allowed to exist in the connection pool at a given time. |
    | idleTimeout         | The maximum duration of time (in milliseconds) for which the system allows a connection to the database to be idle before closing it. |
    | connectionInitSql   | The test query executed on the database to check the validity of the connection. You can use this parameter instead of the `connectionTestQuery` parameter when you are using persisted aggregations. This is because when you use persisted aggregation with an Oracle database, the database connection session time format needs to be changed to `RRRR/fmMM/fmDD`. This is addressed when you use the `connectionInitSql` parameter. |
    | connectionTestQuery | The test query executed on the database to check the validity of the connection. |
    | validationTimeout   | The maximum duration of time (in milliseconds) that is allowed between validation tests carried out for the database connection. |
    | isAutoCommit        | If this parameter is set to `true`, each database query you perform during a single session is treated as a separate database transaction. As a result, the result of any query is visible to other database sessions soon after it is executed. If this parameter is set to `true`, the system considers the whole database session as a single transaction. Therefore, the reults of all the queries you execute within a single session are visible only after the session is over. |      
    
???info "MSSQL"
    ``` xml
    wso2.datasources:
     dataSources:
         description: The datasource used for test database
         jndiConfig:
         definition:
           type: RDBMS
           configuration:
             jdbcUrl: jdbc:sqlserver://hostname:port;databaseName=testdb
             username: root
             password: root
             driverClassName: com.microsoft.sqlserver.jdbc.SQLServerDriver
             minIdle: 5
             maxPoolSize: 50
             idleTimeout: 60000
             connectionTestQuery: SELECT 1
             validationTimeout: 30000
             isAutoCommit: false
    ```
    
The following tables explain the default data sources configured in the Streaming Integrator components for different purposes, and how to change them.
    
### RDBMS data provider

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement
                <br />
            </td>
            <td>The RDBMS provider publishes records from RDBMS tables into generated widgets. It can also be configured to purge records in tables. In order to carry out these actions, this provider requires access to read and delete records in user defined tables of the database. For more information about the RDBMS data provider, see <a href="https://docs.wso2.com/display/SP440/Generating+Widgets">Generating Widgets</a>.</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>This is required if you select a datasource when generating the widget or use existing widgets that connect to the RDBMS data provider when you run the dashboard server for the Streaming Integrator.</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td><code>SAMPLE_DB</code></td>
        </tr>
        <tr class="even">
            <td>Default Database</td>
            <td>The default <code>H2</code> database location is <code> &lt;DASHBOARD_HOME&gt;/wso2/dashboard/database/SAMPLE_DB</code>.</td>
        </tr>
        <tr class="odd">
            <td>Tables</td>
            <td>The default database shipped with a sample table named <code>TRANSACTION_TABLE</code> .</td>
        </tr>
        <tr class="even">
            <td>Schemas and Queries</td>
            <td>
                <p>The schema for the sample table is <code>TRANSACTIONS_TABLE (creditCardNo VARCHAR(50), country VARCHAR(50), transaction VARCHAR(50), amount INT)</code></p>
                <p>You can also view <a href="https://github.com/wso2/carbon-analytics/blob/v2.0.250/components/org.wso2.carbon.data.provider/src/main/resources/queries.yaml">default schemas and queries</a> .</p>
            </td>
        </tr>
        <tr class="odd">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Postgres, Mssql, Oracle 11g</td>
        </tr>
    </tbody>
</table>



### Carbon coordination

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>Carbon coordination supports zookeeper and RDBMS based coordination. In RDBMS coordination, database access is required for updating the heartbeats of the nodes. In addition, database access is required to update the coordinator and the other members in the cluster. For more information, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/admin/configuring-Cluster-Coordination/">Configuring Cluster Coordination</a>.</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>This is required. However, you can also use Zookeeper coordination instead of RDBMS.</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td><code>WSO2_CARBON_DB</code>
            </td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td><code>LEADER_STATUS_TABLE</code>, <code>MEMBERSHIP_EVENT_TABLE</code>, <code>REMOVED_MEMBERS_TABLE</code>, <code>CLUSTER_NODE_STATUS_TABLE</code></td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p>See <a href="https://github.com/wso2/carbon-coordination/blob/v2.0.12/components/cluster-coordinator/org.wso2.carbon.cluster.coordinator/org.wso2.carbon.cluster.coordinator.rdbms/src/main/java/org/wso2/carbon/cluster/coordinator/rdbms/util/RDBMSConstants.java">information about schemas and queries</a>.</p>
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>MySQL, Postgres, Mssql, Oracle 11g</td>
        </tr>
    </tbody>
</table>



### Streaming Integrator core - persistence

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>This involves persisting the state of Siddhi Applications periodically in the database. State persistence is enabled by selecting the <code>org.wso2.carbon.stream.processor.core.persistence.DBPersistenceStore</code> class in the <code>state.persistence</code> section of the <code>&lt;SI_Home&gt;/conf/&lt;server&gt;/deployment.yaml</code> file. For more information, see <a href="https://ei.docs.wso2.com/en/latest/streaming-integrator/admin/configuring-Database-and-File-System-State-Persistence/">Configuring Database and File System State Persistence</a>.</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>This is optional. WSO2 is configured to persist the state of Siddhi applications by default.</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td>N/A. If state persistence is required, you need to configure the datasource in the <code>&lt;SI_Home&gt;/conf/&lt;server&gt;/deployment.yaml</code> file under <code>state.persistence</code> &gt;<code>config</code> &gt; <code>datasource</code> .</td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td>N/A. If state persistence is required, you need to specify the table name to be used when persisting the state in the <code>&lt;SI_Home&gt;/conf/&lt;server&gt;/deployment.yaml</code> file under <code>state.persistence</code> &gt; <code>config</code> &gt; <code>table</code> .</td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p>See <a href="https://github.com/wso2/carbon-analytics/blob/master/components/org.wso2.carbon.streaming.integrator.core/src/main/resources/queries.yaml">information about schemas and queries</a>.</p>
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Postgres, Mssql, Oracle 11g</td>
        </tr>
    </tbody>
</table>



### Streaming Integrator - Status Dashboard

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>To display information relating to the status of your Streaming Integrator deployment, the Status Dashboard needs to retrieve carbon metrics data, registered Streaming Integrator server details and authentication details within the cluster from the database. For more information, see <a href="https://docs.wso2.com/display/SP440/Monitoring+Stream+Processor">Monitoring Stream Processor</a> .</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>Required</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td><code>WSO2_STATUS_DASHBOARD_DB</code>, <code>WSO2_METRICS_DB</code></td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td><code>METRIC_COUNTER</code>, <code>METRIC_GAUGE</code>, <code>METRIC_HISTOGRAM</code>, <code>METRIC_METER</code>, <code>METRIC_TIMER</code>, <code>WORKERS_CONFIGURATIONS</code>, <code>WORKERS_DETAILS</code></td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p>See <a href="https://github.com/wso2/carbon-analytics/blob/v2.0.250/components/org.wso2.carbon.status.dashboard.core/src/main/resources/queries.yaml">information about schemas and queries</a>.
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Mssql, Oracle 11g ( Postgres is tested with Carbon-Metrics only)</td>
        </tr>
    </tbody>
</table>



### Siddhi RDBMS store

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>It gives the capability of creating the tables at the siddhi application runtime and access the existing tables if a user-defined carbon data source or JNDI property in a siddhi application. Documentation can be found in [Siddhi Extensions Documentation](https://siddhi-io.github.io/siddhi-store-rdbms/api/latest/).</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>Optional</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td>No such default Datasource. User has to create the datasource in the Siddhi application</td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td>No such default tables. User has to define the tables</td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p>See <a href="https://github.com/wso2-extensions/siddhi-store-rdbms/blob/v4.0.15/component/src/main/resources/rdbms-table-config.xml">information about schemas and queries</a>.</p>
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Mssql, Oracle 11g, DB2, PostgreSQL</td>
        </tr>
    </tbody>
</table>



### Carbon Dashboards

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>Carbon Dashboard feature uses its datasource to persist the dashboard related information</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>Optional</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td><code>WSO2_DASHBOARD_DB</code></td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td><code>DASHBOARD_RESOURCES</code></td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p><See <a href="https://github.com/wso2/carbon-dashboards/tree/master/features/org.wso2.carbon.dashboards.api.feature/src/main/resources/sql">information about schemas and queries</a>.
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Postgres</td>
        </tr>
    </tbody>
</table>



### Business Rules

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>Business Rules feature uses database to persist the derived business rules</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>Mandatory</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td><code>BUSINESS_RULES_DB</code>
                <br />
            </td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td><code>BUSINESS_RULES</code>, <code>RULES_TEMPLATES</code></td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p>See <a href="https://github.com/wso2/carbon-analytics/blob/v2.0.250/components/org.wso2.carbon.business.rules.core/src/main/resources/queries.yaml">information about schemas and queries</a>.</p>
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Oracle 11g</td>
        </tr>
    </tbody>
</table>



### IdP client

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>IdP client access the DB layer to persist the client id and the client secret of dynamic client registration</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>Mandatory for external IdP client</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td><code>DB_AUTH_DB</code></td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td><code>OAUTH_APPS</code></td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p> See <a href="https://github.com/wso2/carbon-analytics-common/blob/v6.0.52/components/authentication/org.wso2.carbon.analytics.idp.client/src/main/resources/queries.yaml">information about schemas and queries</a>.</p>
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Oracle 11g</td>
        </tr>
    </tbody>
</table>



#### Permission  provider

<table>
    <colgroup>
        <col style="width: 13%" />
        <col style="width: 86%" />
    </colgroup>
    <tbody>
        <tr class="odd">
            <td>Database Access Requirement</td>
            <td>Permission provider will access the DB to persist permissions and role - permission mappings.</td>
        </tr>
        <tr class="even">
            <td>Required/Optional</td>
            <td>Mandatory, default is in H2</td>
        </tr>
        <tr class="odd">
            <td>Default Datasource Name</td>
            <td><code>PERMISSIONS_DB</code></td>
        </tr>
        <tr class="even">
            <td>Tables</td>
            <td><code>PERMISSIONS, ROLE_PERMISSIONS</code>
                <br />
            </td>
        </tr>
        <tr class="odd">
            <td>Schemas and Queries</td>
            <td>
                <p>See <a href="https://github.com/wso2/carbon-analytics-common/blob/v6.0.52/components/permission-provider/org.wso2.carbon.analytics.permissions/src/main/resources/queries.yaml">information about schemas and queries</a>.</p>
            </td>
        </tr>
        <tr class="even">
            <td>Tested Database Types</td>
            <td>H2, MySQL, Mssql, Oracle 11g , Postgres
                <br />
            </td>
        </tr>
    </tbody>
</table
# Tuning JDBC Pool Configurations

If you have connected a [JDBC user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-ldap-user-store) to the Micro Integrator, you can apply the following datasource tuning recommendations in the `deployment.toml` file (stored in the `<MI_HOME>/conf` directory).

!!! Info
    The following recommendations also apply when you create a data service to expose data in an RDBMS. Find out more about [RDBMS configurations]({{base_path}}/reference/synapse-properties/data-services/datasource-configuration-parameters) in data services.

## JDBC connection pool tuning recommendations

When a database operation is processed, the server spawns a database
connection from an associated datasource. After using this connection,
the server returns it to the pool of connections. The physical
connection is not dropped with the database server unless it becomes
stale or the datasource connection is closed. This is called
**datasource connection pooling** and is a recommended way to gain more
performance/throughput in the system. The goal of tuning the pool properties is to maintain an 
RDBMS connection pool that is large enough to handle peak load without unnecessarily utilizing resources.

The following parameters should be considered when tuning the connection pool for the database:

-   The application's concurrency requirement.
-   The average time used for running a database query.
-   The maximum number of connections the database server can support.

The table below indicates some recommendations on how to configure the JDBC pool. See the complete list of [JDBC configuration parameters]({{base_path}}/reference/config-catalog-mi/#database-connection) that you can use in the `deployment.toml` file. For more details about recommended JDBC configurations, see [Tomcat JDBC Connection Pool](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html). 

<table>
    <tr>
        <th>Property</th>
        <th>Description</th>
        <th>Tuning Recommendations</th>
    </tr>
    <tr>
        <td>pool_options.maxActive</td>
        <td>
            The maximum number of active connections that can be allocated from the connection pool at the same time. The default value is 100.
        </td>
        <td>
            The maximum latency (approximately) = (P / M) * T , where,
            <ul>
                <li>M = maxActive value</li>
                <li>P = Peak concurrency value</li>
                <li>T = Time (average) taken to process a query.</li>
            </ul>
            Therefore, by increasing the maxActive value (up to the expected highest number of concurrency), the time that requests wait in the queue for a connection to be released will decrease. But before increasing the Max. Active value, consult the database administrator, as it will create up to maxActive connections from a single node during peak times, and it may not be possible for the DBMS to handle the accumulated count of these active connections.</br></br>
            Note that this value should not exceed the maximum number of requests allowed for your database.
        </td>
    </tr>
    <tr>
        <td>pool_options.maxWait</td>
        <td>
            The maximum time that requests are expected to wait in the queue for a connection to be released. This property comes into effect when the maximum number of active connections allowed in the connection pool (see maxActive property) is used up.
        </td>
        <td>
            Adjust this to a value slightly higher than the maximum latency for a request, so that a buffer time is added to the maximum latency. That is, ff the maximum latency (approximately) = (P / M) * T , where,
            <ul>
                <li>M = maxActive value</li>
                <li>P = Peak concurrency value</li>
                <li>T = Time (average) taken to process a query.</li>
            </ul>
            then, the maxWait = (P / M) * T + buffer time.
        </td>
    </tr>
    <tr>
        <td>pool_options.minIdle</td>
        <td>
            The maximum number of connections that can remain idle in the pool.
        </td>
        <td>
            The value should be less than the maxActive value. For high performance, tune maxIdle to match the number of average, concurrent requests to the pool. If this value is set to a large value, the pool will contain unnecessary idle connections.
        </td>
    </tr>
    <tr>
        <td>pool_options.testOnBorrow</td>
        <td>
            The indication of whether connection objects will be validated before they are borrowed from the pool. If the object validation fails, the connection is dropped from the pool, and there will be an attempt to borrow another connection.
        </td>
        <td>
            When the connection to the database is broken, the connection pool does not know that the connection has been lost. As a result, the connection pool will continue to distribute connections to the application until the application actually tries to use the connection. To resolve this problem, set "Test On Borrow" to "true" and make sure that the "ValidationQuery" property is set. To increase the efficiency of connection validation and to improve performance, validationInterval property should also be used.
        </td>
    </tr>
    <tr>
        <td>pool_options.validationInterval</td>
        <td>
            This parameter controls how frequently a given validation query is executed (time in milliseconds). The default value is 30000 (30 seconds). That is, if a connection is due for validation, but has been validated previously within this interval, it will not be validated again.
        </td>
        <td>
            Deciding the value for the "validationInterval" depends on the target application's behavior. Therefore, selecting a value for this property is a trade-off and ultimately depends on what is acceptable for the application.</br></br>
            If a larger value is set, the frequency of executing the Validation Query is low, which results in better performance. Note that this value can be as high as the time it takes for your DBMS to declare a connection as stale. For example, MySQL will keep a connection open for as long as 8 hours, which requires the validation interval to be within that range. However, note that the validation query execution is usually fast. Therefore, even if this value is only large by a few seconds, there will not be a big penalty on performance. Also, specially when the database requests have a high throughput, the negative impact on performance is negligible. For example, a single extra validation query run every 30 seconds is usually negligible.</br></br>
            If a smaller value is set, a stale connection will be identified quickly when it is presented. This maybe important if you need connections repaired instantly, e.g. during a database server restart.
        </td>
    </tr>
    <tr>
        <td>pool_options.validationQuery</td>
        <td>
            The SQL query used to validate connections from this pool before returning them to the caller. If specified, this query does not have to return any data, it just can't throw an SQLException. The default value is null. Example values are SELECT 1(mysql), select 1 from dual(oracle), SELECT 1(MS Sql Server).
        </td>
        <td>
            Specify an SQL query, which will validate the availability of a connection in the pool. This query is necessary when testOnBorrow property is true.
        </td>
    </tr>
    <tr>
        <td>pool_options.MaxPermSize</td>
        <td>
            The memory size allocated for the WSO2 product. 
        </td>
        <td>
            The default memory allocated for the product via this parameter is as follows:
            <code>-Xms256m -Xmx512m -XX:MaxPermSize=256m</code> </br></br>
            You can increase the performance by increasing this value in the <MI_HOME>/bin/micro-integrator.sh file as follows: 
            <code>-Xms2048m -Xmx2048m -XX:MaxPermSize=1024m</code>
        </td>
    </tr>
</table>

The following properties are used for detecting and removing the connections that get leaked from the connection pool:

| Property Name            | How to configure                                                                                                                                                                                                                                                   |
|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| pool_options.removeAbandoned         | If this property is set to 'true', a connection is considered abandoned and eligible for removal if it has been in use for longer than the `removeAbandonedTimeout` value explained below.                                              |
| pool_options.removeAbandonedTimeout | The time in seconds that should pass before a connection that is in use can be removed. This is the time period after which the connection will be declared abandoned. This value should be set to the longest running query that the applications might have.     |
| pool_options.logAbandoned            | Set this property to "true" if you wish to log when the connection was abandoned. If this option is set to "true", a stack trace is recorded during the `dataSource.getConnection` call and is printed when a connection is not returned. |

!!! Info
    -   When it comes to web applications, users are free to experiment and package their own pooling framework such BoneCP.
    -   If you are using an Oracle database, you may sometimes come across an error (ORA-04031) indicating that you have not allocated enough memory for the shared pool of connections. To overcome this, you can allocate more memory to the shared pool by adjusting the following parameters in the <ORACLE_HOME>/dbs/init<SID>.ora file of your Oracle database: SHARED_POOL_RESERVED_SIZE, SHARED_POOL_SIZE and LARGE_POOL_SIZE.

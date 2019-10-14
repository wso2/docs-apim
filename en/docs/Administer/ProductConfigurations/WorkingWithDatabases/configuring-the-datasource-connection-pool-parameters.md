# Configuring the Datasource Connection Pool Parameters

When the server processes a database operation, it spawns a database connection from an associated datasource. After using this connection, the server returns it to the pool of connections. This is called datasource connection pooling. It is a recommended way to gain more performance/throughput in the system. In datasource connection pooling, the physical connection is not dropped with the database server, unless it becomes stale or the datasource connection is closed.

RDBMS datasources in WSO2 products use Tomcat JDBC connection pool ( `org.apache.tomcat.jdbc.pool` ). It is common to all components that access databases for data persistence, such as the registry, user management (if configured against a JDBC userstore), etc.

You can configure the datasource connection pool parameters, such as how long a connection is persisted in the pool, using the datasource configuration parameters section that appears in the product management console when creating a datasource. Click and expand the option as shown below:

![]({{base_path}}/assets/attachments/43977373/44172374.png)

Following are descriptions of the parameters you can configure. For more details on datasource configuration parameters, see [ApacheTomcat JDBC Connection Pool guide](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html) .

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Transaction isolation</td>
<td>The default <code>              TransactionIsolation             </code> state of connections created by this pool are as follows:
<ul>
<li>TRANSACTION_UNKNOWN</li>
<li>TRANSACTION_NONE</li>
<li>TRANSACTION_READ_COMMITTED</li>
<li>TRANSACTION_READ_UNCOMMITTED</li>
<li>TRANSACTION_REPEATABLE_READ</li>
<li>TRANSACTION_SERIALIZABLE</li>
</ul></td>
</tr>
<tr class="even">
<td>Initial Size (int)</td>
<td><p>The initial number of connections created, when the pool is started. Default value is zero.</p></td>
</tr>
<tr class="odd">
<td>Max. Active (int)</td>
<td><p>Maximum number of active connections that can be allocated from this pool at the same time. The default value is 100.</p></td>
</tr>
<tr class="even">
<td>Max. Idle (int)</td>
<td><p>Maximum number of connections that should be kept in the pool at all times. Default value is 8. Idle connections are checked periodically (if enabled), and connections that have been idle for longer than <code>               minEvictableIdleTimeMillis              </code> will be released. (also see <a href="#ConfiguringtheDatasourceConnectionPoolParameters-TestWhileIdle">testWhileIdle</a> )</p></td>
</tr>
<tr class="odd">
<td>Min. Idle (int)</td>
<td><p>Minimum number of established connections that should be kept in the pool at all times. The connection pool can shrink below this number, if validation queries fail. Default value is zero. For more information, see <a href="#ConfiguringtheDatasourceConnectionPoolParameters-TestWhileIdle">testWhileIdle</a> .</p></td>
</tr>
<tr class="even">
<td>Max. Wait (int)</td>
<td><p>Maximum number of milliseconds that the pool waits (when there are no available connections) for a connection to be returned before throwing an exception. Default value is 30000 (30 seconds).</p></td>
</tr>
<tr class="odd">
<td>Validation Query (String)</td>
<td><p>The SQL query used to validate connections from this pool before returning them to the caller. If specified, this query does not have to return any data, it just can't throw a SQLException. The default value is null. Example values are SELECT 1 (mysql), select 1 from dual (oracle), SELECT 1 (MS Sql Server).</p></td>
</tr>
<tr class="even">
<td>Test On Return (boolean)</td>
<td><p>Used to indicate if objects will be validated before returned to the pool. The default value is false.</p>
!!! info
<p>For a true value to have any effect, the <code>               validationQuery              </code> parameter must be set to a non-null string.</p>
</td>
</tr>
<tr class="odd">
<td>Test On Borrow (boolean)</td>
<td><p>Used to indicate if objects will be validated before borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and we will attempt to borrow another. Default value is false.</p>
!!! info
<p>For a true value to have any effect, the <code>               validationQuery              </code> parameter must be set to a non-null string. In order to have a more efficient validation, see <a href="#ConfiguringtheDatasourceConnectionPoolParameters-ValidationInterval">validationInterval</a> .</p>
</td>
</tr>
<tr class="even">
<td>Test While Idle (boolean)</td>
<td><p>The indication of whether objects will be validated by the idle object evictor (if any). If an object fails to validate, it will be dropped from the pool. The default value is false and this property has to be set in order for the pool cleaner/test thread to run. For more information, see <a href="#ConfiguringtheDatasourceConnectionPoolParameters-timeBetweenEvictionRunsMillis">timeBetweenEvictionRunsMillis</a> .</p>
!!! info
<p>For a true value to have any effect, the <a href="#ConfiguringtheDatasourceConnectionPoolParameters-ValidationQuery">validationQuery</a> parameter must be set to a non-null string.</p>
</td>
</tr>
<tr class="odd">
<td>Time Between Eviction Runs Mills (int)</td>
<td><p>Number of milliseconds to sleep between runs of the idle connection validation/cleaner thread. This value should not be set under 1 second. It indicates how often we check for idle, abandoned connections, and how often we validate idle connections. The default value is 5000 (5 seconds).</p></td>
</tr>
<tr class="even">
<td>Minimum Evictable Idle Time (int)</td>
<td><p>Minimum amount of time an object may sit idle in the pool before it is eligible for eviction. The default value is 60000 (60 seconds).</p></td>
</tr>
<tr class="odd">
<td>Remove Abandoned (boolean)</td>
<td><p>Flag to remove abandoned connections if they exceed the <a href="#ConfiguringtheDatasourceConnectionPoolParameters-removeAbandonedTimout">removeAbandonedTimout</a> . If set to true, a connection is considered abandoned and eligible for removal, if it has been in use longer than the <code>               removeAbandonedTimeout.              </code> Setting this to true can recover database connections from applications that fail to close a connection. For more information, see <a href="#ConfiguringtheDatasourceConnectionPoolParameters-LogAbandoned">logAbandoned</a> . The default value is false.</p></td>
</tr>
<tr class="even">
<td>Remove Abandoned Timeout (int)</td>
<td>Timeout in seconds before an abandoned (in use) connection can be removed. The default value is 60 (60 seconds). The value should be set to the longest running query that your applications might have.</td>
</tr>
<tr class="odd">
<td>Log Abandoned (boolean)</td>
<td>Flag to log stack traces for application code which abandoned a connection. Logging of abandoned connections, adds overhead for every connection borrowing, because a stack trace has to be generated. The default value is false.</td>
</tr>
<tr class="even">
<td>Auto Commit (boolean)</td>
<td>The default auto-commit state of connections created by this pool. If not set, default is JDBC driver default. If not set, then the <code>              setAutoCommit             </code> method will not be called.</td>
</tr>
<tr class="odd">
<td>Default Read Only (boolean)</td>
<td>The default read-only state of connections created by this pool. If not set then the <code>              setReadOnly             </code> method will not be called. (Some drivers don't support read only mode. For example: Informix)</td>
</tr>
<tr class="even">
<td>Default Catalog (String)</td>
<td>The default catalog of connections created by this pool.</td>
</tr>
<tr class="odd">
<td>Validator Class Name (String)</td>
<td>The name of a class which implements the <code>              org.apache.tomcat.jdbc.pool             </code> .Validates the interface and provides a no-arg constructor (may be implicit). If specified, the class will be used to create a <code>              Validator             </code> instance, which is then used instead of any validation query to validate connections. The default value is null. An example value is <code>              com.mycompany.project.SimpleValidator             </code> .</td>
</tr>
<tr class="even">
<td>Connection Properties (String)</td>
<td><p>Connection properties that will be sent to our JDBC driver when establishing new connections. Format of the string must be <code>               [propertyName=property;]*              </code> . The default value is null.</p>
!!! info
<p>The <code>               user              </code> and <code>               password              </code> properties will be passed explicitly, so that they do not need to be included here.</p>
</td>
</tr>
<tr class="odd">
<td>Init SQL</td>
<td>Ability to run a SQL statement exactly once, when the connection is created.</td>
</tr>
<tr class="even">
<td>JDBC Interceptors</td>
<td>Flexible and pluggable interceptors to create any customizations around the pool, the query execution and the result set handling.</td>
</tr>
<tr class="odd">
<td>Validation Interval (long)</td>
<td>To avoid excess validation, only run validation at most at this frequency - time in milliseconds. If a connection is due for validation, but has been validated previously within this interval, it will not be validated again. The default value is 30000 (30 seconds).</td>
</tr>
<tr class="even">
<td>JMX Enabled (boolean)</td>
<td>Register the pool with JMX or not. The default value is true.</td>
</tr>
<tr class="odd">
<td>Fair Queue (boolean)</td>
<td>Set to true, if you wish that calls to <code>              getConnection             </code> should be treated fairly in a true FIFO fashion. This uses the <code>              org.apache.tomcat.jdbc.pool.FairBlockingQueue             </code> implementation for the list of the idle connections. The default value is true. This flag is required when you want to use asynchronous connection retrieval. Setting this flag ensures that threads receive connections in the order they arrive. During performance tests, there is a very large difference in how locks and lock waiting is implemented. When <code>              fairQueue=true             </code> , there is a decision making process based on what operating system the system is running. If the system is running on Linux (property <code>              os.name=Linux             </code> ), then to disable this Linux specific behavior and still use the fair queue, simply add the property <code>              org.apache.tomcat.jdbc.pool.FairBlockingQueue.ignoreOS=true             </code> to your system properties, before the connection pool classes are loaded.</td>
</tr>
<tr class="even">
<td>Abandon When Percentage Full (int)</td>
<td>Connections that have been abandoned (timed out) will not get closed and reported up, unless the number of connections in use are above the percentage defined by <code>              abandonWhenPercentageFull             </code> . The value should be between 0-100. The default value is zero, which implies that connections are eligible for closure as soon as <code>              removeAbandonedTimeout             </code> has been reached.</td>
</tr>
<tr class="odd">
<td>Max Age (long)</td>
<td>Time in milliseconds to keep this connection. When a connection is returned to the pool, the pool will check to see if the current time when connected, is greater than the <code>              maxAge             </code> that has been reached. If so, it closes the connection rather than returning it to the pool. The default value is zero, which implies that connections will be left open and no age check will be done upon returning the connection to the pool.</td>
</tr>
<tr class="even">
<td>Use Equals (boolean)</td>
<td>Set to true, if you wish the <code>              ProxyConnection             </code> class to use <code>              String.equals,             </code> and set to false when you wish to use <code>              ==             </code> when comparing method names. This property does not apply to added interceptors as those are configured individually. The default value is true.</td>
</tr>
<tr class="odd">
<td>Suspect Timeout (int)</td>
<td>Timeout value in seconds. Default value is zero. Similar to to the <code>              removeAbandonedTimeout             </code> value, but instead of treating the connection as abandoned, and potentially closing the connection, this simply logs the warning if <code>              logAbandoned             </code> is set to true. If this value is equal or less than zero, no suspect checking will be performed. Suspect checking only takes place if the timeout value is larger than zero, and the connection was not abandoned, or if abandon check is disabled. If a connection is suspected, a warning message gets logged and a JMX notification will be sent.</td>
</tr>
<tr class="even">
<td>Alternate User Name Allowed (boolean)</td>
<td>By default, the <code>              jdbc-pool             </code> will ignore the <code>              DataSource.getConnection(username,password)             </code> call, and simply return a previously pooled connection under the globally configured properties username and password, for performance reasons.<br />
<br />
The pool can however be configured to allow use of different credentials each time a connection is requested. To enable the functionality described in the <code>              DataSource.getConnection(username,password)             </code> call, simply set the property <code>              alternateUsernameAllowed,             </code> to true. If you request a connection with the credentials user1/password1, and the connection was previously connected using different user2/password2, then the connection will be closed, and reopened with the requested credentials. This way, the pool size is still managed on a global level, and not on a per-schema level. The default value is false.</td>
</tr>
</tbody>
</table>



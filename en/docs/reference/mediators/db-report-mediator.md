# DB Report Mediator

The **DB Report Mediator** is similar to the [DBLookup Mediator]({{base_path}}/reference/mediators/dblookup-mediator). The difference between the two mediators is that the DB Report mediator writes information to a database using the specified insert SQL statement.

!!! Info
    The DB Report mediator is a [content-aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

!!! Note
    Currently, the 'DB-Report-mediator' does not support the 'json-eval' expression used to extract the parameters.

## Syntax

The syntax of the DB Report mediator changes depending on whether you connect to the database using a connection pool, or using a data source.

-   **Connection Pool**
    ``` java
    <dbreport>
       <connection>
         <pool>
          (
            <driver/>
            <url/>
            <user/>
            <password/>

            <dsName/>
            <icClass/>
            <url/>
            <user/>
            <password/>
          )
            <property name="name" value="value"/>*
         </pool>
       </connection>
       <statement>
           <sql>insert into something values(?, ?, ?, ?)</sql>
          <parameter [value="" | expression=""] type="CHAR|VARCHAR|LONGVARCHAR|NUMERIC|DECIMAL|BIT|TINYINT|SMALLINT|INTEGER|BIGINT|REAL|FLOAT|DOUBLE|DATE|TIME|TIMESTAMP"/>*
       </statement>+
    </dbreport>
    ```

-   **Data source**
    The syntax of the DBLookup mediator further differs based on whether the connection to the database is made using an external datasource or a Carbon datasource. Click on the relevant tab to view the required syntax.

    ``` java tab='External Datasource'
    <dbreport>
       <connection>
          <pool>
            <dsName/>
            <icClass/>
            <url/>
            <user/>
            <password/>
            <property name="name" value="value"/>*
          </pool>
       </connection>
       <statement>
          <sql>select something from table where something_else = ?</sql>
          <parameter [value="" | expression=""] type="CHAR|VARCHAR|LONGVARCHAR|NUMERIC|DECIMAL|BIT|TINYINT|SMALLINT|INTEGER|BIGINT|REAL|FLOAT|DOUBLE|DATE|TIME|TIMESTAMP"/>*
       </statement>+
    </dbreport>
    ```

    ``` java tab='Carbon Datasource'
    <dbreport>
       <connection>
          <pool>
            <dsName/>
          </pool>
       </connection>
       <statement>
          <sql>select something from table where something_else = ?</sql>
          <parameter [value="" | expression=""] type="CHAR|VARCHAR|LONGVARCHAR|NUMERIC|DECIMAL|BIT|TINYINT|SMALLINT|INTEGER|BIGINT|REAL|FLOAT|DOUBLE|DATE|TIME|TIMESTAMP"/>*
       </statement>+
    </dbreport>
    ```

## Configurations

The configuration of the DBQuery mediator changes depending on whether you connect to the database using a connection pool, or using a data
source.

### Connection Pool configurations

The parameters available to configure the DB Report mediator are as follows.

!!! Info
    When specifying the DB connection using a connection pool, other than specifying parameter values inline, you can also specify following parameter values of the connection information (i.e. Driver, URL, User and password) as registry entries. The advantage of specifying a parameter value as a registry entry is that the same connection information configurations can be used in different environments simply by changing the registry entry value. To do this, give the registry path within the `key` attribute as shown in the example below.
    ```
    <dblookup xmlns="http://ws.apache.org/ns/synapse">
    <connection>
        <pool>
            <password key="conf:/repository/esb/password"/>
            <driver key="conf:/repository/esb/driver"/>
            <url key="conf:/repository/esb/url"/>
            <user key="conf:/repository/esb/username"/>
        </pool>
    </connection>
    </dblookup>
  ```

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Use Transaction</strong></td>
<td><div class="content-wrapper">
<p>This parameter specifies whether the database operation should be performed within a transaction or not. Click <strong>Yes</strong> or <strong>No</strong> as relevant.</p>
<p>To include multiple database reports within the same database transaction i nside a particular message flow, set the value of this <strong>Use Transaction</strong> property to <strong>Yes</strong> .<br />
</p>
<p>However, when you have more reports it takes more time to complete a transaction and when multiple messages flow in, then multiple transactions can become active at the same time.</p>
<p>By default, the maximum number of active transactions is 50 as imposed by the Atomikos JTA implementation. To override this, create a file named <code>                  transaction.properties                 </code> by including the following property and add it to the <code>                  &lt;EI_HOME&gt;/lib                 </code> directory:</p>
<pre><code>com.atomikos.icatch.max_actives=1000</code></pre>
<div>
Specifying the value as -1 allows unlimited transactions. Change the value accordingly to limit the number of active transactions based on your environment and the concurrency level of the service.
</div>
<p>If you click <strong>Yes</strong> to perform the database operation within a transaction, you need to ensure the following:</p>
<ul>
<li>The DBReport mediator configuration must be preceded by a Transaction Mediator configuration with <code>                   new                  </code> as the transaction action.</li>
<li>The DBReport mediator configuration must be followed by a Transaction Mediator configuration with <code>commit</code> as the transaction action.</li>
</ul>
<p>For detailed information about configuring Transaction mediators, see <a href="{{base_path}}/reference/mediators/transaction-mediator">Transaction Mediator</a> .</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Driver</strong></td>
<td>The class name of the database driver.</td>
</tr>
<tr class="odd">
<td><strong>Url</strong></td>
<td><p>The JDBC URL of the database that data will be written to.</p>
<p>Set the <code>                 autoReconnect                </code> parameter to <code>                 true                </code> to help reconnect to the database when the connection between the client and the database is dropped. For example, <code>                 &lt;url&gt;jdbc:mysql://&lt;ip&gt;:&lt;port&gt;/test?autoReconnect=true&lt;/url&gt;                </code> .</p></td>
</tr>
<tr class="even">
<td><strong>User</strong></td>
<td>The user name for connecting to the database.</td>
</tr>
<tr class="odd">
<td><strong>Password</strong></td>
<td>The password used to connect to the database.</td>
</tr>
</tbody>
</table>

To add properties to the DBReport mediator, start with the following parameters:

| Parameter Name | Description                                      |
|----------------|--------------------------------------------------|
| **Name**       | The name of the property.                        |
| **Value**      | The value of the property.                       |
| **Action**     | This parameter enables a property to be deleted. |

Once you have defined the above parameters, enter the following properties:

<table>
<thead>
<tr class="header">
<th><p>Name</p></th>
<th><p>Value</p></th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>autocommit</p></td>
<td><p>true / false</p></td>
<td>The auto-commit state of the connections created by the pool.</td>
</tr>
<tr class="even">
<td><p>isolation</p></td>
<td><p>Connection.TRANSACTION_NONE / Connection.TRANSACTION_READ_COMMITTED / Connection.TRANSACTION_READ_UNCOMMITTED / Connection.TRANSACTION_REPEATABLE_READ / Connection.TRANSACTION_SERIALIZABLE</p></td>
<td>The isolation state of the connections created by the pool.</td>
</tr>
<tr class="odd">
<td><p>initialsize</p></td>
<td><p>int</p></td>
<td>The initial number of connections created when the pool is started.</td>
</tr>
<tr class="even">
<td><p>maxactive</p></td>
<td><p>int</p></td>
<td>The maximum number of active connections that can be allocated from this pool at a given time. When this maximum limit is reached, no more active connections will be created by the connection pool. Specify 0 or a negative value if you do not want to set a limit.</td>
</tr>
<tr class="odd">
<td><p>maxidle</p></td>
<td><p>int</p></td>
<td>The maximum number of idle connections to be allowed in the connection pool at a given time. Specify 0 or a negative value if you want the pool to wait indefinitely.</td>
</tr>
<tr class="even">
<td><p>maxopenstatements</p></td>
<td><p>int</p></td>
<td>The maximum number of open statements that can be allocated from the statement pool at a given time. When this maximum limit is reached, no more new statements will be created by the statement pool. Specify 0 or a negative value if you do not want to set a limit.</td>
</tr>
<tr class="odd">
<td><p>maxwait</p></td>
<td><p>long</p></td>
<td>The maximum number of milliseconds that the connection pool will wait for a connection to return before throwing an exception when there are no connections available in the pool. Specify 0 or a negative value if you want the pool to wait indefinitely.</td>
</tr>
<tr class="even">
<td><p>minidle</p></td>
<td><p>int</p></td>
<td>The minimum number of idle connections to be allowed in the connection pool at a given time. Specify 0 or a negative value if you want the pool to wait indefinitely.</td>
</tr>
<tr class="odd">
<td><p>poolstatements</p></td>
<td><p>true/ false</p></td>
<td>If the value is <code>true</code>, statement pooling is enabled for the pool.</td>
</tr>
<tr class="even">
<td><p>testonborrow</p></td>
<td><p>true/ false</p></td>
<td>If the value is <code>                true               </code> , objects are validated before they are borrowed from the pool. An object which fails the validation test will be dropped from the pool and another object in the pool will be picked instead.</td>
</tr>
<tr class="odd">
<td><p>testwhileidle</p></td>
<td><p>true/ false</p></td>
<td>If the value is <code>                true               </code> , the objects in the pool will be validated using an idle object evictor (if any exists). Any object which fails this validation test would be dropped from the pool.</td>
</tr>
<tr class="even">
<td><p>validationquery</p></td>
<td><p>String</p></td>
<td><p>The SQL query that will be used to validate connections from this pool before returning them to the caller.</p>
<p>This property helps to reconnect to the database when the database connection between the client and the database is dropped. For example, <code>                 &lt;property name="validationquery" value="select 1"/&gt;                </code> .</p></td>
</tr>
</tbody>
</table>

### Datasource configurations

The configuration of the DBLookup mediator further differs based on whether the connection to the database is made using an external datasource or a Carbon datasource. 

#### External Datasource
The parameters available to configure the DB Report mediator as an external datasource are as follows.

| Parameter Name      | Description                                                                                                                                                                                   |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Use Transaction** | This parameter specifies whether the database operation should be performed within a transaction or not. Click **Yes** or **No** as relevant.                                                 |
| **Initial Context** | The initial context factory class. The corresponding `                   Java                  ` environment property is `                   java.naming.factory.initial                  ` . |
| **Datasource Name** | The naming service provider URL . The corresponding `                   Java                  ` environment property is `                   java.naming.provider.url                  ` .     |
| **URL**             | The JDBC URL of the database that data will be written to.                                                                                                                                    |
| **User**            | The user name used to connect to the database.                                                                                                                                                |
| **Password**        | The password used to connect to the database.                                                                                                                                                 |

To add properties to the DBReport mediator, start with the following parameters:

| Parameter Name | Description                                      |
|----------------|--------------------------------------------------|
| **Name**       | The name of the property.                        |
| **Value**      | The value of the property.                       |
| **Action**     | This parameter enables a property to be deleted. |


Once you have defined the above parameters, enter the following properties:

| Name              | Value                                                                                                                                                                                                | Description                                                                                                                                                                                                                                                             |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| autocommit        | true / false                                                                                                                                                                                         | The auto-commit state of the connections created by the pool.                                                                                                                                                                                                           |
| isolation         | Connection.TRANSACTION\_NONE / Connection.TRANSACTION\_READ\_COMMITTED / Connection.TRANSACTION\_READ\_UNCOMMITTED / Connection.TRANSACTION\_REPEATABLE\_READ / Connection.TRANSACTION\_SERIALIZABLE | The isolation state of the connections created by the pool.                                                                                                                                                                                                             |
| initialsize       | int                                                                                                                                                                                                  | The initial number of connections created when the pool is started.                                                                                                                                                                                                     |
| maxactive         | int                                                                                                                                                                                                  | The maximum number of active connections that can be allocated from this pool at a given time. When this maximum limit is reached, no more active connections will be created by the connection pool. Specify 0 or a negative value if you do not want to set a limit.  |
| maxidle           | int                                                                                                                                                                                                  | The maximum number of idle connections to be allowed in the connection pool at a given time. Specify 0 or a negative value if you want the pool to wait indefinitely.                                                                                                   |
| maxopenstatements | int                                                                                                                                                                                                  | The maximum number of open statements that can be allocated from the statement pool at a given time. When this maximum limit is reached, no more new statements will be created by the statement pool. Specify 0 or a negative value if you do not want to set a limit. |
| maxwait           | long                                                                                                                                                                                                 | The maximum number of milliseconds that the connection pool will wait for a connection to return before throwing an exception when there are no connections available in the pool. Specify 0 or a negative value if you want the pool to wait indefinitely.             |
| minidle           | int                                                                                                                                                                                                  | The minimum number of idle connections to be allowed in the connection pool at a given time. Specify 0 or a negative value if you want the pool to wait indefinitely.                                                                                                   |
| poolstatements    | true/ false                                                                                                                                                                                          | If the value is `                   true                  ` , statement pooling is enabled for the pool.                                                                                                                                                                |
| testonborrow      | true/ false                                                                                                                                                                                          | If the value is `                   true                  ` , objects are validated before they are borrowed from the pool. An object which fails the validation test will be dropped from the pool and another object in the pool will be picked instead.              |
| testwhileidle     | true/ false                                                                                                                                                                                          | If the value is `                   true                  ` , the objects in the pool will be validated using an idle object evictor (if any exists). Any object which fails this validation test would be dropped from the pool.                                       |
| validationquery   | String                                                                                                                                                                                               | The SQL query that will be used to validate connections from this pool before returning them to the caller.                                                                                                                                                             |

#### Carbon Datasource

| Parameter Name      | Description                                                                                                                                                                                |
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Use Transaction** | This parameter specifies whether the database operation should be performed within a transaction or not. Click **Yes** or **No** as relevant.                                              |
| **Datasource**      | This parameter is used to selected a specific Carbon datasource you want to use to make the connection. All the Carbon datasources which are currently available are included in the list. |

### SQL statements

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>SQL</strong></td>
<td>This parameter is used to enter one or more SQL statements.</td>
</tr>
<tr class="even">
<td><strong>Parameters</strong></td>
<td>This section is used to specify how the values of parameters in the SQL will be determined. A parameter value can be static or calculated at runtime based on a given expression.</td>
</tr>
<tr class="odd">
<td><strong>Parameter Type</strong></td>
<td><p>The data type of the parameter. Possible values are as follows.</p>
<ul>
<li><strong>CHAR</strong></li>
<li><strong>VARCHAR</strong></li>
<li><strong>LONGVARCHAR<br />
</strong></li>
<li><strong>NUMERIC</strong></li>
<li><strong>DECIMAL</strong></li>
<li><strong>BIT</strong></li>
<li><strong>TINYINT</strong></li>
<li><strong>SAMLLINT</strong></li>
<li><strong>INTEGER</strong></li>
<li><strong>BIGINT</strong></li>
<li><strong>REAL</strong></li>
<li><strong>DOUBLE</strong></li>
<li><strong>DATE</strong></li>
<li><strong>TIME</strong></li>
<li><strong>TIMESTAMP</strong></li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Property Type</strong></td>
<td><p>This determines whether the parameter value should be a static value or calculated at run time via an expression.</p>
<ul>
<li><strong>Value</strong> : If this is selected, a static value would be considered as the property value and this value should be entered in the <strong>Value/Expression</strong> parameter.</li>
<li><p><strong>Expression:</strong> If this is selected, the property value will be determined during mediation by evaluating an expression. This expression should be entered in the <strong>Value/Expression</strong> parameter.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td><strong>Value/Expression</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to enter the static value or the XPath expression used to determine the property value based on the option you selected for the <strong>Property Type</strong> parameter.</p>
<p>You can click <strong>NameSpaces</strong> to add namespaces if you are providing an expression. Then the <strong>Namespace Editor</strong> panel would appear where you can provide any number of namespace prefixes and URLs used in the XPath expression.</p>

</div></td>
</tr>
<tr class="even">
<td><strong>Action</strong></td>
<td>This allows you to delete a parameter.</td>
</tr>
</tbody>
</table>

## Examples

### Simple database write operation

This example demonstrates simple database write operations. The DB Report mediator writes to a table using the details of the message. It updates the stock price of the company using the last quote value, which is calculated by evaluating an XPath expression against the response message.

``` java
<dbreport xmlns="http://ws.apache.org/ns/synapse">
    <connection>
        <pool>
            <driver>org.apache.derby.jdbc.ClientDriver</driver>
            <url>jdbc:derby://localhost:1527/esbdb;create=false</url>
            <user>esb</user>
            <password>esb</password>
        </pool>
    </connection>
    <statement>
        <sql><![CDATA[update company set price=? where name =?]]></sql>
        <parameter expression="//m0:return/m1:last/child::text()" type="DOUBLE" xmlns:m0="http://services.samples" xmlns:m1="http://services.samples/xsd"/>
        <parameter expression="//m0:return/m1:symbol/child::text()" type="VARCHAR" xmlns:m0="http://services.samples" xmlns:m1="http://services.samples/xsd"/>
    </statement>
</dbreport>
```

### Database write operation within a transaction

In this example, `         <transaction action="new"/>        ` is a Transaction Mediator configuration that starts a new transaction. The DBReport mediator configuration performs a few write operations incuding deleting records when the name matches a specific value derived via an
expression as well as a few insertions. Once the database operations are
complete, they are committed via
`         <transaction action="commit"/>        ` , which is another
Transaction Mediator configuration.

``` java
<sequence xmlns="http://ws.apache.org/ns/synapse" name="myFaultHandler">
    <log level="custom">
        <property name="text" value="** Rollback Transaction**"/>
    </log>
    <transaction action="rollback"/>
    <send/>
</sequence>
<proxy name="SimpleProxy" transports="http https" startonload="true" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
    <target>
         <inSequence>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </inSequence>
        <outSequence>
            <transaction action="new"/>
            <log level="custom">
                <property name="text" value="** Reporting to the Database EIdb**"/>
            </log>
            <dbreport useTransaction="true" xmlns="http://ws.apache.org/ns/synapse">
                <connection>
                    <pool>
                        <dsName>java:jdbc/XADerbyDS</dsName>
                        <icClass>org.jnp.interfaces.NamingContextFactory</icClass>
                        <url>localhost:1099</url>
                        <user>EI</user>
                        <password>EI</password>
                    </pool>
                </connection>
                <statement>
                     <sql>delete from company where name =?</sql>
                     <parameter expression="//m0:return/m1:symbol/child::text()"
                       xmlns:m0="http://services.samples" xmlns:m1="http://services.samples/xsd"
                                 type="VARCHAR"/>
                </statement>
            </dbreport>
            <log level="custom">
                <property name="text" value="** Reporting to the Database EIdb1**"/>
            </log>
            <dbreport useTransaction="true" xmlns="http://ws.apache.org/ns/synapse">
                <connection>
                    <pool>
                        <dsName>java:jdbc/XADerbyDS1</dsName>
                        <icClass>org.jnp.interfaces.NamingContextFactory</icClass>
                        <url>localhost:1099</url>
                        <user>EI</user>
                        <password>EI</password>
                    </pool>
                </connection>
                <statement>
                    <sql>INSERT into company values (?,'c4',?)</sql>
                    <parameter expression="//m0:return/m1:symbol/child::text()"
         xmlns:m1="http://services.samples/xsd" xmlns:m0="http://services.samples"
                               type="VARCHAR"/>
                    <parameter expression="//m0:return/m1:last/child::text()"
         xmlns:m1="http://services.samples/xsd" xmlns:m0="http://services.samples"
                               type="DOUBLE"/>
                </statement>
            </dbreport>
            <transaction action="commit"/>
            <send/>
        </outSequence>
            <faultSequence>
                 <sequence key="myFaultHandler"/>
            </faultSequence>
    </target>
</proxy>
```

<!--
#### Samples

For more examples of the DB Report mediator, see:

-   [Sample 361: Introduction to DB Report
    Mediator](https://docs.wso2.com/display/EI6xx/Sample+361%3A+Introduction+to+DBReport+Mediator)
-   [Sample 362: DB Report and DBLookup Mediators
    Together](https://docs.wso2.com/display/EI6xx/Sample+362%3A+DBReport+and+DBLookup+Mediators+Together)
-   [Sample 363: Reusable Database Connection
    Pools](https://docs.wso2.com/display/EI6xx/Sample+363%3A+Reusable+Database+Connection+Pools)
-   [Sample 271: File
    Processing](https://docs.wso2.com/display/EI6xx/Sample+271%3A+File+Processing)
    (moves files into a database using the VFS transport and the DB
    Report mediator)
-->

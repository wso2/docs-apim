# DBLookup Mediator

The **DBLookup Mediator** can execute an arbitrary SQL select statement
and then set a resulting values as a local message property in the
message context. The DB connection used may be looked up from an
external data source or specified inline.

!!! Info
    - The DBLookup mediator is a [content-aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.
    - The DBLookup mediator can set a property from one row in a result set. It cannot return multiple rows. If you need to get multiple records, or if you have a table with multiple parameters (such as URLs), you can create a data service and invoke that service from the Micro Integrator using the [Callout mediator]({{base_path}}/reference/mediators/callout-mediator) instead.

## Syntax

The syntax of the DBLookup mediator changes depending on whether you connect to the database using a connection pool, or using a data source. Click on the relevant tab to view the required syntax.

-   **Connection Pool**
    ``` java
    <dblookup>
       <connection>
          <pool>
            <driver/>
            <url/>
            <user/>
            <password/>
            <property name="name" value="value"/>*
          </pool>
       </connection>
       <statement>
          <sql>select something from table where something_else = ?</sql>
          <parameter [value="" | expression=""] type="CHAR|VARCHAR|LONGVARCHAR|NUMERIC|DECIMAL|BIT|TINYINT|SMALLINT|INTEGER|BIGINT|REAL|FLOAT|DOUBLE|DATE|TIME|TIMESTAMP"/>*
          <result name="string" column="int|string"/>*
       </statement>+
    </dblookup>
    ```

-   **Data source**
    The syntax of the DBLookup mediator further differs based on whether the connection to the database is made using an external datasource or a Carbon datasource.

    ``` java tab='External Datasource'
    <dblookup>
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
          <result name="string" column="int|string"/>*
       </statement>+
    </dblookup>
    ```

    ``` java tab='Carbon Datasource'
    <dblookup>
       <connection>
          <pool>
            <dsName/>
          </pool>
       </connection>
       <statement>
          <sql>select something from table where something_else = ?</sql>
          <parameter [value="" | expression=""] type="CHAR|VARCHAR|LONGVARCHAR|NUMERIC|DECIMAL|BIT|TINYINT|SMALLINT|INTEGER|BIGINT|REAL|FLOAT|DOUBLE|DATE|TIME|TIMESTAMP"/>*
          <result name="string" column="int|string"/>*
       </statement>+
    </dblookup>
    ```

## Configurations

The configuration of the DBLookup mediator changes depending on whether you connect to the database using a connection pool, or using a data source.

### Connection Pool configurations

The parameters available to configure the DBLookup mediator are as
follows:

!!! Info
    When specifying the DB connection using a connection pool, other than specifying parameter values inline, you can also specify following parameter values of the connection information (i.e. Driver, URL, User and password) as registry entries. The advantage of specifying a parameter value as a registry entry is that the same connection information configurations can be used in different environments simply by changing the registry entry value. To do this, give the registry path within the `key` attribute as shown in the example below.

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
    
| Parameter Name             | Description                                                                                                      |
|----------------------------|------------------------------------------------------------------------------------------------------------------|
| **Connection Information** | This parameter is used to specify whether the connection should be taken from a connection pool or a datasource. |
| **Driver**                 | The class name of the database driver.                                                                           |
| **URL**                    | JDBC URL of the database where the data will be looked up.                                                       |
| **User**                   | Username used to connect to the database.                                                                        |
| **Password**               | Password used to connect to the database.                                                                        |


To add properties to the DBLookup mediator, start with the following parameters:

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
<td><div class="content-wrapper">
<p>The maximum number of idle connections allowed in the connection pool at a given time. The value should be less than the <code style="color: rgb(0,0,0);line-height: 1.42857;">                  maxActive                 </code> value. For high performance, tune <code style="color: rgb(0,0,0);line-height: 1.42857;">                  maxIdle                 </code> to match the number of average, concurrent requests to the pool. If this value is set to a large value, the pool will contain unnecessary idle connections.</p>
<p>The enabled idle connections are checked periodically whenever a new connection is requested, and connections that are being idle for longer than <code>                  minEvictableIdleTimeMillis                 </code> are released, since it takes time to create a new connection.</p>
<p><br />
</p>
</div></td>
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
<td><div class="content-wrapper">
<p>The minimum number of idle connections allowed in the connection pool at a given time, without extra ones being created . Default value is 0, and is derived from <code>                  initialSize                 </code>. The connection pool can shrink below this number if validation queries fail.</p>
<p>This value should be similar or near to the average number of requests that will be received by the server at the same time. With this setting, you can avoid having to open and close new connections every time a request is received by the server.</p>
<p><br />
</p>
</div></td>
</tr>
<tr class="odd">
<td><p>poolstatements</p></td>
<td><p>true/ false</p></td>
<td>If the value is <code>true</code>, statement pooling is enabled for the pool.</td>
</tr>
<tr class="even">
<td><p>testonborrow</p></td>
<td><p>true/ false</p></td>
<td>If the value is <code>true</code>, objects are validated before they are borrowed from the pool. An object which fails the validation test will be dropped from the pool and another object in the pool will be picked instead.</td>
</tr>
<tr class="odd">
<td><p>testwhileidle</p></td>
<td><p>true/ false</p></td>
<td>If the value is <code>                true               </code>, the objects in the pool will be validated using an idle object evictor (if any exists). Any object which fails this validation test would be dropped from the pool.</td>
</tr>
<tr class="even">
<td><p>validationquery</p></td>
<td><p>String</p></td>
<td>The SQL query that will be used to validate connections from this pool before returning them to the caller.</td>
</tr>
</tbody>
</table>

### Datasource configurations

The configuration of the DBLookup mediator further differs based on whether the connection to the database is made using an external datasource or a Carbon datasource.

The parameters available to configure the DBLookup mediator are as follows.

| Parameter Name             | Description                                                                                                                                  |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| **Connection Information** | This parameter is used to specify whether the connection should be taken from a connection pool or a datasource.                             |
| **Datasource Type**        | This parameter is used to specify whether the connection to the database should be made using an external datasource or a Carbon datasource. |
| **JNDI Name**              | The JNDI used to look up data.                                                                                                               |

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
<tr class="odd">
<td><strong>Results</strong></td>
<td><p>This section is used to specify how to deal with the rerun result from a Database query execution.</p>
<ul>
<li><strong>Result Name</strong></li>
<li><strong>Column</strong></li>
<li><strong>Action</strong> - Deletes the result.</li>
</ul></td>
</tr>
</tbody>
</table>

## Example

``` java
<dblookup xmlns="http://ws.apache.org/ns/synapse">
    <connection>
        <pool>
            <driver>org.apache.derby.jdbc.ClientDriver</driver>
            <url>jdbc:derby://localhost:1527/esbdb;create=false</url>
            <user>esb</user>
            <password>esb</password>
        </pool>
    </connection>
    <statement>
        <sql><![CDATA[select * from company where name =?]]></sql>
        <parameter expression="//m0:getQuote/m0:request/m0:symbol" type="VARCHAR" xmlns:m0="http://services.samples/xsd"/>
        <result column="id" name="company_id"/>
    </statement>
</dblookup>
```

In this example, when a message is received by a proxy service with a DBLookup mediator configuration, it opens a connection to the database and executes the SQL query. The SQL query uses **?** character for attributes that will be filled at runtime. The parameters define how to calculate the value of those attributes at runtime. In this sample, the DBLookup Mediator has been used to extract  the `         id        ` of the company from the company database using the symbol which is evaluated using an XPath against the SOAP envelope.

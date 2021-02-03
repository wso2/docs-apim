# Elements of a Data Service

Data services and resources provide a service-and-resource interface to
some data stored in a relational database. In a service interface, you
must indicate how service requests map to queries against collections of
tables in a relational database and how query results are mapped to
service responses. In a resource interface, you must indicate how a set
of resources map to queries and how query responses are returned as
resource representations (or reports of resource creation or deletion,
depending on the HTTP verb in use).

The following topics describe the data service configuration language
and the key elements used when composing a data service, such as
queries, databases, operations, etc., along with example syntax.

## Data services and resource language

Data services and resources are defined using the Data Services and
Resource Language (DSRL) where a \<data\> element describes a data
service or a resource. The common attributes of a \<data\> element is
given in the following example:

```xml
<data baseURI="xs:anyURI" name="xs:NMTOKEN" enableBatchRequests="xs:BOOLEAN" enableBoxcarring="xs:BOOLEAN" txManagerJNDIName="xs:NMTOKEN" serviceNamespace="xs:anyURI" serviceGroup="xs:NMTOKEN" serviceStatus="active|inactive" transports="http https JMS local" >
    config+
    query+
    operation+
    resource+
    event-trigger+
</data>
```

| Attribute          | Description                                                                                                                            |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| baseURI            | A REQUIRED URI indicating the base URI for the operations and resources definedwithinthe \<data\> element.                             |
| name               | A REQUIRED name of the data service.                                                                                                   |
| enableBatchRequest | An OPTIONAL boolean to enable the batch request feature.                                                                               |
| enableBoxcarring   | An OPTIONAL boolean to enable theboxcarringfeature.                                                                                    |
| txManagerJNDIName  | An OPTIONAL JNDI name for overriding the standard JNDI location for locating the JTA transaction manager                               |
| serviceNamespace   | An OPTIONAL URI to uniquely identify the web service.                                                                                  |
| serviceGroup       | An OPTIONAL name that is used to categorizedata-servicesin different groups.                                                           |
| serviceStatus      | An OPTIONAL string to enable WIP (specifiesweatherthe data service is deployed or work in progress) support.                           |
| transports         | An OPTIONAL string to enable the transports required for the data service. The possible values are "http", "https", "JMS" and "local". |


## Configuring the datasource

The following sample demonstrates the common elements used for connecting to
a datasource:

```xml
<config id="xs:ID">
    <property name="xs:NMTOKEN">xs:urType</property>+
</config>
```

-   `config/@id`: An OPTIONAL XML ID identifying the config element. If
    the configuration file has multiple \<config\> elements, then this
    attribute is required.

The actual set of properties is defined by each type of database connection (e.g., JDBC will have its own standard set).

## Defining queries

A query consists of parameters that describe how to map the result to an
XML element. It is similar to a function that maps some parameters to an
XML element. A query definition does not indicate how the parameters are
acquired. Instead, it just lists the parameters that are needed,
assuming that the parameters will be provided. If the query is at a top
level (i.e., direct child of \<data\>), then either an operation
definition or a resource definition provides the context for the
parameters. If the query is nested within a \<result\> element, then the
parameter names refer to column names of the result table described by
the \<result\> element of the XML.

The following sample config shows the common attributes of a \<query\>
element:

```xml
<query id="xs:ID"?  useConfig="xs:ConfigID" returnGeneratedKeys="xs:BOOLEAN">
    <param name="xs:NMTOKEN" sqlType="xs:string"  paramType="SCALAR | ARRAY"  type="IN | OUT | IN-OUT" ordinal="xs:integer"   defaultValue="xs:string" />*
           ( <validateCustom class= "xs:string"/> | <validateLength minimum="xs:integer" maximum="xs:integer" /> | <validatePattern pattern="xs:string" />)
      </param>
    ( <sql dialect="xs:NMTOKEN">xs:string</sql>+ | <sparql>xs:string</sparql> )
    <properties>
        <property name="xs:NMTOKEN">xs:string</property>+
    </properties>
    <result element="xs:QName" rowName="xs:QName"  defaultNamespace="xs:anyURI" />
        (element | attribute | call-query )*
    </result>
</query>

<element name="xs:QName" column="xs:NMTOKEN" requiredRoles="xs:NMTOKEN" export="xs:NMTOKEN" exportType="SCALAR | ARRAY" xsdType="xs:QName">
     (element | attribute | call-query )*
</element>

<attribute name="xs:QName" column="xs:NMTOKEN" requiredRoles="xs:NMTOKEN" export="xs:NMTOKEN" exportType="SCALAR | ARRAY" xsdType="xs:QName"/>

<call-query href="xs:NCName"         requiredRoles="xs:NMTOKEN" >
            <with-param name="xs:string" query-param="xs:string" />*
</call-query>
```

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Attributes</th>
<th>Sub-attributes</th>
<th>Sub-attributes</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>id</td>
<td></td>
<td></td>
<td>An OPTIONAL XML ID identifying the query. If &lt;query&gt; is a direct child of &lt;data&gt;, then this attribute is required.</td>
</tr>
<tr class="even">
<td>useConfig</td>
<td></td>
<td></td>
<td>A REQUIRED reference to the datasource that is to be used in the query.</td>
</tr>
<tr class="odd">
<td>returnGeneratedKeys</td>
<td></td>
<td></td>
<td><p>An OPTIONAL boolean parameter to enable returnGeneratedKeys.</p>
<p>Set this attribute to true only in INSERT queries, where the query inserts to a table that has an auto incrementing key column. In such a case, an auto incremented key value is added to the results.</p>.</td>
</tr>
<tr class="even">
<td>param</td>
<td></td>
<td></td>
<td>A declaration of a parameter of the query.</td>
</tr>
<tr class="odd">
<td></td>
<td>name</td>
<td></td>
<td>A REQUIRED name of the parameter.</td>
</tr>
<tr class="even">
<td></td>
<td>sqlType</td>
<td></td>
<td>An OPTIONAL string containing a legal SQL type, which defines the type of parameter. If 'none' is specified, the value defaults to STRING.</td>
</tr>
<tr class="odd">
<td></td>
<td>paramType</td>
<td></td>
<td>A REQUIRED parameter type. If 'none' is specified, it defaults to SCALAR.</td>
</tr>
<tr class="even">
<td></td>
<td>ordinal</td>
<td></td>
<td>REQUIRED only for stored procedures that map the parameter positions with the query.</td>
</tr>
<tr class="odd">
<td></td>
<td>defaultValue</td>
<td></td>
<td>An OPTIONAL default value of the input parameter.</td>
</tr>
<tr class="even">
<td></td>
<td>validateCustom</td>
<td>class</td>
<td>A REQUIRED custom validation class to validate the input parameter.</td>
</tr>
<tr class="odd">
<td></td>
<td>validateLength</td>
<td>minimum</td>
<td>A REQUIRED integer when specifying the minimum length of the parameter.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>maximum</td>
<td>A REQUIRED integer when specifying the maximum length of the parameter.</td>
</tr>
<tr class="odd">
<td></td>
<td>validatePattern</td>
<td>pattern</td>
<td>A REQUIRED string pattern to validate the string input parameter.</td>
</tr>
<tr class="even">
<td>sql</td>
<td></td>
<td></td>
<td>A REQUIRED string containing the SQL query or SQL function to execute.</td>
</tr>
<tr class="odd">
<td></td>
<td>dialect</td>
<td></td>
<td>An OPTIONAL string containing the <code>jdbcdriver</code> prefix for usesql-dialects.</td>
</tr>
<tr class="even">
<td>sparql</td>
<td></td>
<td></td>
<td>A REQUIRED string containing the sparql query to execute when using RDF as a datasource.</td>
</tr>
<tr class="odd">
<td>properties</td>
<td></td>
<td></td>
<td>An OPTIONAL XML to define advanced query properties. Each property is defined as a child element of this property.</td>
</tr>
<tr class="even">
<td></td>
<td>name</td>
<td></td>
<td>A REQUIRED name of the property.</td>
</tr>
<tr class="odd">
<td>result</td>
<td></td>
<td></td>
<td>A REQUIRED element descriibing how the table resulting from executing the query will be converted to an XML element. If any &lt;column&gt; or &lt;query&gt; child elements are present, then ONLY those are transferred as child elements of the result element (or elements, depending on whether result/@rowName is given or not). The order of the nested &lt;column&gt; or &lt;query&gt; elements defines the order of elements in the result element.</td>
</tr>
<tr class="even">
<td></td>
<td>element</td>
<td></td>
<td>A REQUIRED name, which is the name of the element holding the results.</td>
</tr>
<tr class="odd">
<td></td>
<td>rowName</td>
<td></td>
<td>An OPTIONAL name, which is the name of the element wrapping each row of the result table if more than one element from the table is to be returned. If this attribute is not given, then only the first row is returned and hence no second level wrapper element is needed.</td>
</tr>
<tr class="even">
<td></td>
<td>defaultNamespace</td>
<td></td>
<td>An OPTIONAL URI being the default namespace to use for the namespace name of elements and attributesthat result columnsare mapped to. Defaultsto "" (meaning no namespace).</td>
</tr>
<tr class="odd">
<td></td>
<td>call-query</td>
<td></td>
<td>An OPTIONAL element (which may occur any number of times) that is used to execute a further query and produce an element that will be present in the current element as a child. This is used primarily to use a value of a column as key to select data from a new table.</td>
</tr>
<tr class="even">
<td></td>
<td>element</td>
<td></td>
<td>An OPTIONAL element (which may occur any number of times) indicating how a specific column in the result table is to be mapped into an element</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
<td>element/@name</td>
<td>A REQUIRED name specifying the name of the element into which the column data will be inserted.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>element/@column</td>
<td>An OPTIONAL string giving the name of the column of which the value is to be copied into the element.</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
<td>element/@requiredRoles</td>
<td>An OPTIONAL string giving the names of roles that have permission to see the result element. Bydefaultit has set to all users.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>element/@export</td>
<td>An OPTIONAL name given to the element that is to be export. This feature is used with boxcarring support.</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
<td>element/@exportType</td>
<td>A REQUIRED parameter when using the export option. Used to give the export element type: scalar or array.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>element/@xsdType</td>
<td>An OPTIONAL indication of the XML Schema type of the element. If none is given, the value defaults to the mapping of the SQL type of the result column named by @column to an XML Schema type as per SQL XML Mapping.</td>
</tr>
<tr class="odd">
<td></td>
<td>attribute</td>
<td></td>
<td>An OPTIONAL element (which may occur any number of times) indicating how a specific column in the result table is to be mapped into an attribute of the element representing the current row</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>attribute/@name</td>
<td>a REQUIRED QName giving the name of the attribute to put the column data into</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
<td>attribute/@column</td>
<td>an OPTIONAL string giving the name of the column whose value is to be copied into the attribute. Either @column or @param is required.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>attribute/@param</td>
<td>an OPTIONAL string giving the name of the param whose value is to be copied into the attribute. Either @column or @param is required.</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
<td>attribute/@requiredRoles</td>
<td>an OPTIONAL string giving the names of roles that who has permission to see the result attribute. Bydefaultit has set to all users.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>attribute/@export</td>
<td>an OPTIONAL name giving to the attribute that to be export outside of query. This feature is used withboxcarringsupport.</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
<td>attribute/@exportType</td>
<td>a REQUIRED parameter when using export option. Used to give the export element type whether scalar or array.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>attribute/@xsdType</td>
<td>an OPTIONAL indication of the XML Schema type of the attribute. If none is given defaults to the mapping of the SQL type of the result column named by @column to an XML Schema type as per [SQL XML Mapping]</td>
</tr>
<tr class="odd">
<td></td>
<td>call-querry</td>
<td></td>
<td>an OPTIONAL element (which may occur any number of times) indicating how a specific column in the result table is to be mapped into a query result.</td>
</tr>
<tr class="even">
<td></td>
<td></td>
<td>with-param/@name</td>
<td>a REQUIRED name of the query to put the column data into</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
<td>with-param/@query-param</td>
<td>an OPTIONAL string giving the name of the column whose value is to be copied into the element.</td>
</tr>
</tbody>
</table>

## Defining service operations

Operation refers to a Web service operation defined by a query. The
operation is defined as an invocation of a query indicating how the
parameters of the query are computed or derived. The syntax is as
follows:

```xml
<operation name="xs:NCName" disableStreaming="xs:BOOLEAN"/>
    <description>"xs:string"</description>
    <call-query href="xs:IDREF"/>
        <with-param name="xs:NMTOKEN" (query-param="xs:NMTOKEN" | column="xs:NMTOKEN | param="xs:NMTOKEN")/>
    </call-query>
</operation>
```

-   `operation/@name`: is the REQUIRED name of the operation.
-   `operation/@disableStreaming`: an OPTIONAL boolean that is used to
    disable streaming. By default streaming is enable.
-   `operation/@description`: an OPTIONAL string used to
    describe the operation.
-   `operation/call-query`: describes how a query is to be invoked with the
    data received in the operation invocation.
    -   `call-query/@href`: an OPTIONAL reference to the query that is to
        be invoked. If this is missing, then a query must be nested
        within this element.
    -   `call-query/with-param`: a description of a parameter binding for
        the query invocation. This explains how a named parameter's value is
        computed.  
        -   `with-param/@name`: a REQUIRED NMTOKEN identifying the
            parameter of which the value is being specified.
        -   `with-param/@query-param`: an OPTIONAL attribute indicating
            the name of the URI query parameter (from operation/@path)
            of which the value is the value of this parameter.
        -   `with-param/@column`: an OPTIONAL attribute naming a column of
            the immediate parent \<result\> element. That is, this
            applies only for nested queries and serves the purpose of
            being able to use a query result as input to a nested query.
        -   `with-param/@param`: an OPTIONAL attribute naming a \<param\>
            of the parent \<query\>. That is, this applies only for nested
            queries and serves the purpose of being able to use a
            parameter of the parent query input to a nested query.
    -   `call-query/query`: an OPTIONAL \<query\> being the anonymous
        query to be invoked as the implementation of this operation with
        the parameters identified above.

## Defining resources

```xml
<resource path="uri-template" method="GET|POST|PUT|DELETE" disableStreaming="xs:BOOLEAN">
    <description>"xs:string"</description>
    <call-query href="xs:IDREF"      />
        <with-param name="xs:NMTOKEN" />
        query?
    </call-query>
</resource>
```

This defines the resource identified by "new URI (/data/@baseURI,
/data/resource/@path)" and indicates how the request is mapped to a
query invocation.

<!--
## Defining event trigger

```xml
<event-trigger id=xs:NCName" language="XPath">
     <expression>xs:string</expression>
     <target-topic>xs:string</target-topic>
     <subscriptions>
         <subscription>xs:string</subscription>
     </subscriptions>
</event-trigger>
```

-   `event-triger/@id`: REQUIRED id used to identify the event-trigger,
    used in data services queries.
-   `event-triger/language`: REQUIRED currently only XPath issupported 
    asthe event trigger language.
-   `target-topic`: REQUIRED topic, to which the event notifications will
    be published.
-   `subscriptions`: REQUIRED  can be any WS-Eventingcomplientendpoint. For
    example, an SMTP transport can be used to send a message to a mail
    inbox, where an email address is given as the subscription. Here
    many subscriptions can be defined for the given topic.
    -->

## Security configuration

When a data service receives messages, it expects to receive a signed
and encrypted message as specified by the security policy stored in the
registry of your server. Therefore, as shown below,
you can embed the security configurations directly in the .dbs file of
the data service by adding the path to the relevant security policy.
Please see Apache Rampart and Axis2 documentation on the format of the
policy file stored in the registry. You can also use the 'enableSec'
element to ensure that Apache Rampart is engaged for the data service.

```xml
<policy key="<sec_policy_path>"/>
<enableSec/>
```

## Sample data service configuration

Given below is a sample data service configuration with queries, resources, etc. for your reference:

```xml
<data name="DSSample" enableBatchRequests="false" enableBoxcarring="true" serviceStatus="active" baseURI="http://ws.wso2.org/dataservice/samples/ds_sample" transports="http https JMS local">
   <config id="default">
      <property name="org.wso2.ws.dataservice.driver">org.h2.Driver</property>
      <property name="org.wso2.ws.dataservice.protocol">jdbc:h2:file:./samples/database/DATA_SERV_SAMP</property>
      <property name="org.wso2.ws.dataservice.user">wso2ds</property>
      <property name="org.wso2.ws.dataservice.password">wso2ds</property>
      <property name="org.wso2.ws.dataservice.minpoolsize">1</property>
      <property name="org.wso2.ws.dataservice.maxpoolsize">10</property>
      <property name="org.wso2.ws.dataservice.validation_query"></property>
   </config>
    <query id="employeesByNumberSQL" useConfig="default">
      <sql>select * from Employees where employeeNumber = ?</sql>
      <result element="employees" rowName="employee">
         <element name="last-name" column="lastName" />
         <element name="first-name" column="firstName" />
         <element name="email" column="email" />
         <element name="salary" column="salary" />
      </result>
       <param name="employeeNumber" paramType="SCALAR" sqlType="INTEGER" type="IN" ordinal="1" >
          <validateLength minimum="3" maximum="20" />
       </param>
   </query>
  <query id="updateProductQuantityQuery" useConfig="default" input-event-trigger="product_stock_low_trigger">
      <sql>update Products set quantityInStock=? where productCode=?</sql>
      <param name="productCode" paramType="SCALAR" sqlType="STRING" type="IN" ordinal="2" />
      <param name="quantityInStock" paramType="SCALAR" sqlType="DOUBLE" type="IN" ordinal="1" />
   </query>
    <query id="createProductQuery" useConfig="default">
      <sql>insert into Products (productCode, productName, productLine, quantityInStock, buyPrice) values (?,?,?,?,?)</sql>
      <param name="productCode" paramType="SCALAR" sqlType="STRING" type="IN" ordinal="1" />
      <param name="productName" paramType="SCALAR" sqlType="STRING" type="IN" ordinal="2" />
      <param name="productLine" paramType="SCALAR" sqlType="STRING" type="IN" ordinal="3" />
      <param name="quantityInStock" paramType="SCALAR" sqlType="INTEGER" type="IN" ordinal="4" />
      <param name="buyPrice" paramType="SCALAR" sqlType="DOUBLE" type="IN" ordinal="5" />
   </query>
  <operation name="employeesByNumber">
      <call-query href="employeesByNumberSQL"           >
         <with-param name="employeeNumber" query-param="employeeNumber" />
      </call-query>
   </operation>
    <resource path="product/{productCode}/{productName}/{productLine}/{quantityInStock}/{buyPrice}" method="POST">
      <call-query href="createProductQuery"          >
         <with-param name="productCode" query-param="productCode" />
         <with-param name="productName" query-param="productName" />
         <with-param name="productLine" query-param="productLine" />
         <with-param name="quantityInStock" query-param="quantityInStock" />
         <with-param name="buyPrice" query-param="buyPrice" />
      </call-query>
   </resource>
   <policy key="conf:repository/components/org.wso2.carbon.security.mgt/policy/scenario1"/>
   <enableSec/>
</data>
```

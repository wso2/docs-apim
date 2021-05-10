# Data Service Call Mediator

The **Data Service Call Mediator** is used to invoke data service operations. It automatically creates a payload and sets up the necessary headers to invoke the data service. Also, it improves the performance by directly calling the data service (without HTTP transport).

!!! Info
    - You need to first have a [Data Service Project]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services) to use the Data Service Call mediator.
    - The Data Service Call mediator is a [content-aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators)  mediator.

## Syntax

``` java
<dataServiceCall serviceName="data-service-name">
   <source [type="inline" | "body"]/>
   <operations [type="single" | "batch" | "request-box"] >
      <operation name="operation-name">
         <param name="param-name" value="param-value"/>
      </operation>
   </operations>
   <target [type="body" | "property"] name="target-property-name"/>
</dataServiceCall>
```

## Configuration

The <strong>Source Configuration</strong> properties of the Data Service Call Mediator are as follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Type</strong></td>
<td><p>The type defines the source for the payload that is required for the data service call. By default, the source type is set to ‘body’. The available values are as follows:</p>
<ul>
<li><strong>INLINE</strong> - The payload should be configured within the mediator configuration.</li>
<li><strong>BODY</strong> - The body of the original message is passed as the payload to the data service.</li>
</ul></td>
</tr>
</tbody>
</table>

The <strong>Operation Configurations</strong> for the Data Source Call mediator are as follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>name</strong></td>
<td>Defines the name of the operation that is to be invoked</td>
</tr>
<tr class="even">
<td><strong>Params Configuration</strong></td>
<td><p>The possible values for this parameter are as follows:</p>
<ul>
<li><strong>Name</strong>: Defines the name of the parameter.
<li><strong>Evaluator</strong>: Only required for json param expressions (json).</li>
<li><p><strong>Value/Expression</strong>: Value of the parameter. If the expression is configured, the parameter value is determined during message mediation by evaluating an expression. The expression should be specified for the Expression parameter.
</tbody>
</table>

The <strong>Target Configuration</strong> properties of the Data Service Call mediator are as follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Type</strong></td>
<td><p>By setting the target type, the response payload of the data service call can be stored in the body or a property. By default, the target type is set to ‘body’. The available values are as follows:</p>
<ul>
<li><strong>BODY</strong>: The response payload is stored in the message body.</li>
<li><strong>PROPERTY</strong>: The response payload is stored in the defined property.</li>
</td>
</tr>
<tr class="even">
<td><strong>Name</strong></td>
<td>Specifies the property name.

You can define dynamic property names when the target type is defined as a property:

```java
<property name="{get-property('propertyName')}" />
<property name="{$ctx:propertyName}" />
<property name="{json-eval(propertyName)}" />
```

</td>
</tr>
</tbody>
</table>

## Examples

Use the following datasource to try out the Data Service Call mediator. Create a new data service configuration and then copy the following content to define the `DSSCallMediatorTest` data service:

**Sample data service to invoke using the Data Service Call mediator**

```xml
<data disableLegacyBoxcarringMode="true" enableBatchRequests="true" enableBoxcarring="true" name="DSSCallMediatorTest" transports="http https local">
   <config enableOData="false" id="01">
      <property name="driverClassName">com.mysql.jdbc.Driver</property>
      <property name="url">jdbc:mysql://localhost:3306/employeeDB</property>
      <property name="username">root</property>
      <property name="password">root</property>
   </config>
   <query id="getEmployeeByNumberQuery" useConfig="01">
      <sql>select EmployeeNumber, FirstName, LastName, Email, Salary from Employees where EmployeeNumber=:EmployeeNumber</sql>
      <result element="Entries" rowName="Entry">
         <element column="EmployeeNumber" name="EmployeeNumber" xsdType="string"/>
         <element column="FirstName" name="FirstName" xsdType="string"/>
         <element column="LastName" name="LastName" xsdType="string"/>
         <element column="Email" name="Email" xsdType="string"/>
         <element column="Salary" name="Salary" xsdType="string"/>
      </result>
      <param name="EmployeeNumber" sqlType="STRING"/>
   </query>
   <query id="addEmployeeQuery" useConfig="01">
      <sql>insert into Employees (EmployeeNumber, FirstName, LastName, Email, Salary) values(:EmployeeNumber,:FirstName,:LastName,:Email,:Salary)</sql>
      <param name="EmployeeNumber" sqlType="STRING"/>
      <param name="FirstName" sqlType="STRING"/>
      <param name="LastName" sqlType="STRING"/>
      <param name="Email" sqlType="STRING"/>
      <param name="Salary" sqlType="STRING"/>
   </query>
   <operation name="addEmployee" returnRequestStatus="true">
      <call-query href="addEmployeeQuery">
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
         <with-param name="FirstName" query-param="FirstName"/>
         <with-param name="LastName" query-param="LastName"/>
         <with-param name="Email" query-param="Email"/>
         <with-param name="Salary" query-param="Salary"/>
      </call-query>
   </operation>
   <operation name="getEmployeeByNumber">
      <call-query href="getEmployeeByNumberQuery">
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
      </call-query>
   </operation>
   <resource method="GET" path="Employee/{EmployeeNumber}">
      <call-query href="getEmployeeByNumberQuery">
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
      </call-query>
   </resource>
   <resource method="POST" path="/Employee">
      <call-query href="addEmployeeQuery">
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
         <with-param name="FirstName" query-param="FirstName"/>
         <with-param name="LastName" query-param="LastName"/>
         <with-param name="Email" query-param="Email"/>
         <with-param name="Salary" query-param="Salary"/>
      </call-query>
   </resource>
</data>
```

### Example 1: Inline single request operation

In this example, an inline single request is configured and sent to the `DSSCallMediatorTest` service.

**Synapse Configuration**

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="dssCallMediatorInlineSingleRequestProxy"
       transports="http https"
       startOnLoad="true">
    <description/>
    <target>
        <inSequence>
            <dataServiceCall serviceName="DSSCallMediatorTest">
                <source type="inline"/>
                <operations type="single">
                    <operation name="addEmployee">
                        <param name="employeeNumber" value="111"/>
                        <param name="firstname" value="Peter"/>
                        <param name="lastName" value="Parker"/>
                        <param name="email" value="peter@wso2.com"/>
                        <param name="salary" value="1000"/>
                    </operation>
                </operations>
                <target type="body"/>
            </dataServiceCall>
            <respond/>
        </inSequence>
    </target>
</proxy>
```

**Sample Request**

Invoke the `dssCallMediatorInlineSingleRequestProxy` proxy service:

```bash
http://localhost:8290/services/dssCallMediatorInlineSingleRequestProxy
```

**Response**

```
<axis2ns3:REQUEST_STATUS xmlns:axis2ns3="http://ws.wso2.org/dataservice">SUCCESSFUL</axis2ns3:REQUEST_STATUS>
```

### Example 2: Inline batch request operation

In this example, an inline batch request is configured and sent to the `DSSCallMediatorTest` service.

**Synapse Configuration**

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="dssCallMediatorInlineBatchRequestProxy"
       transports="http https"
       startOnLoad="true">
    <description/>
    <target>
        <inSequence>
            <dataServiceCall serviceName="DSSCallMediatorTest">
                <source type="inline"/>
                <operations type="batch">
                    <operation name="addEmployee">
                        <param name="employeeNumber" value="222"/>
                        <param name="firstname" value="John"/>
                        <param name="lastName" value="Doe"/>
                        <param name="email" value="john@wso2.com"/>
                        <param name="salary" value="2000"/>
                    </operation>
                    <operation name="addEmployee">
                        <param name="employeeNumber" value="333"/>
                        <param name="firstname" value="Joel"/>
                        <param name="lastName" value="Miller"/>
                        <param name="email" value="joel@wso2.com"/>
                        <param name="salary" value="3000"/>
                    </operation>
                </operations>
                <target type="body"/>
            </dataServiceCall>
            <respond/>
        </inSequence>
    </target>
</proxy>
```

**Sample Request**

Invoke the `dssCallMediatorInlineBatchRequestProxy` proxy service:

```bash
http://localhost:8290/services/dssCallMediatorInlineBatchRequestProxy
```

**Response**

```
<axis2ns3:REQUEST_STATUS xmlns:axis2ns3="http://ws.wso2.org/dataservice">SUCCESSFUL</axis2ns3:REQUEST_STATUS>
```

### Example 3: Inline request box operation

In this example, an inline batch request is configured and sent to the `DSSCallMediatorTest` service.

**Synapse Configuration**

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="dssCallMediatorInlineRequestBoxProxy"
       transports="http https"
       startOnLoad="true">
    <description/>
    <target>
        <inSequence>
            <dataServiceCall serviceName="DSSCallMediatorTest">
                <source type="inline"/>
                <operations type="request-box">
                    <operation name="addEmployee">
                        <param name="employeeNumber" value="444"/>
                        <param name="firstname" value="Ellie"/>
                        <param name="lastName" value="Dina"/>
                        <param name="email" value="dina@wso2.com"/>
                        <param name="salary" value="4000"/>
                    </operation>
                    <operation name="getEmployeeByNumber">
                        <param name="employeeNumber" value="444"/>
                    </operation>
                </operations>
                <target type="body"/>
            </dataServiceCall>
            <respond/>
        </inSequence>
    </target>
</proxy>
```

**Sample Request**

Invoke the `dssCallMediatorInlineRequestBoxProxy` proxy service:

```
http://localhost:8290/services/dssCallMediatorInlineRequestBoxProxy
```

**Response**

```
<axis2ns4:DATA_SERVICE_REQUEST_BOX_RESPONSE xmlns:axis2ns4="http://ws.wso2.org/dataservice"><Entries xmlns="http://ws.wso2.org/dataservice"><Entry><EmployeeNumber>444</EmployeeNumber><FirstName>Ellie</FirstName><LastName>Dina</LastName><Email>dina@wso2.com</Email><Salary>4000</Salary></Entry></Entries></axis2ns4:DATA_SERVICE_REQUEST_BOX_RESPONSE>
```

### Example 4: Single request operation when the source type is set to body

In this example, an inline single request is configured and sent to the `DSSCallMediatorTest` service.

**Synapse Configuration**

```xml 
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="dssCallMediatorSourceTypeBodyProxy"
       transports="http https"
       startOnLoad="true">
    <description/>
    <target>
        <inSequence>
            <dataServiceCall serviceName="DSSCallMediatorTest">
                <source type="body"/>
                <target type="body"/>
            </dataServiceCall>
            <respond/>
        </inSequence>
    </target>
</proxy>
```

**Sample Request**

Invoke the `dssCallMediatorSourceTypeBodyProxy` proxy service with the given payload:

```bash
http://localhost:8290/services/dssCallMediatorSourceTypeBodyProxy
```

```xml
<addEmployee>
    <EmployeeNumber>555</EmployeeNumber>
    <Firstname>Peter</Firstname>
    <LastName>Parker</LastName>
    <Email>peter@wso2.com</Email>
    <Salary>5000</Salary>
</addEmployee>
```

**Response**

```
<axis2ns3:REQUEST_STATUS xmlns:axis2ns3="http://ws.wso2.org/dataservice">SUCCESSFUL</axis2ns3:REQUEST_STATUS>
```

### Example 5: Batch request operation when source type is set to body

In this example, an inline batch request is configured and sent to the `DSSCallMediatorTest` service.

**Synapse Configuration**

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="dssCallMediatorSourceTypeBodyProxy"
       transports="http https"
       startOnLoad="true">
    <description/>
    <target>
        <inSequence>
            <dataServiceCall serviceName="DSSCallMediatorTest">
                <source type="body"/>
                <target type="body"/>
            </dataServiceCall>
            <respond/>
        </inSequence>
    </target>
</proxy>
```

**Sample Request**

Invoke the `dssCallMediatorSourceTypeBodyProxy` proxy service with the given payload.

```bash
http://localhost:8290/services/dssCallMediatorSourceTypeBodyProxy 
```

```xml
<addEmployee_batch_req>
    <addEmployee>
        <EmployeeNumber>666</EmployeeNumber>
        <Firstname>Miles</Firstname>
        <LastName>Jimmy</LastName>
        <Email>jimmy@wso2.com</Email>
        <Salary>2000</Salary>
    </addEmployee>
    <addEmployee>
        <EmployeeNumber>777</EmployeeNumber>
        <Firstname>Dia</Firstname>
        <LastName>Jesse</LastName>
        <Email>jesse@wso2.com</Email>
        <Salary>1500</Salary>
    </addEmployee>
</addEmployee_batch_req>
```

**Response**
```
<axis2ns3:REQUEST_STATUS xmlns:axis2ns3="http://ws.wso2.org/dataservice">SUCCESSFUL</axis2ns3:REQUEST_STATUS>
```

### Example 6: Request box operation when source type is set to body

In this example, an inline request box request is configured and sent to the `DSSCallMediatorTest` service.

**Synapse Configuration**

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="dssCallMediatorSourceTypeBodyProxy"
       transports="http https"
       startOnLoad="true">
    <description/>
    <target>
        <inSequence>
            <dataServiceCall serviceName="DSSCallMediatorTest">
                <source type="body"/>
                <target type="body"/>
            </dataServiceCall>
            <respond/>
        </inSequence>
    </target>
</proxy>
```

**Sample Request**

Invoke the `dssCallMediatorSourceTypeBodyProxy` proxy service with the given payload.

```bash
http://localhost:8290/services/dssCallMediatorSourceTypeBodyProxy
``` 

```xml
<<request_box>
   <addEmployee>
      <EmployeeNumber>888</EmployeeNumber>
      <Firstname>William</Firstname>
      <LastName>Sakai</LastName>
      <Email>sakai@wso2.com</Email>
      <Salary>3000</Salary>
   </addEmployee>
   <getEmployeeByNumber>
      <EmployeeNumber>888</EmployeeNumber>
   </getEmployeeByNumber>
</request_box>
```

**Response**

```
<axis2ns1:DATA_SERVICE_REQUEST_BOX_RESPONSE xmlns:axis2ns1="http://ws.wso2.org/dataservice">
    <Entries xmlns="http://ws.wso2.org/dataservice">
        <Entry>
            <EmployeeNumber>888</EmployeeNumber>
            <FirstName>William</FirstName>
            <LastName>Sakai</LastName>
            <Email>sakai@wso2.com</Email>
            <Salary>3000</Salary>
        </Entry>
    </Entries>
</axis2ns1:DATA_SERVICE_REQUEST_BOX_RESPONSE>
```

### Example 7: Inline single request operation when the target type is set to the property

In this example, an inline single request is configured and sent to the `DSSCallMediatorTest` service and gets the response to a property.

**Synapse Configuration**

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="testDSSResposeTarget"
       transports="http https"
       startOnLoad="true">
    <description/>
    <target>
        <inSequence>
            <dataServiceCall serviceName="DSSCallMediatorSample">
                <source type="inline"/>
                <operations type="single">
                    <operation name="addEmployee">
                        <param name="employeeNumber" value="111"/>
                        <param name="firstname" value="Peter"/>
                        <param name="lastName" value="Parker"/>
                        <param name="email" value="peter@wso2.com"/>
                        <param name="salary" value="1000"/>
                    </operation>
                </operations>
                <target type="property" name="responseValue"/>
            </dataServiceCall>
   <log level="custom">
      <property name="reponseValue" expression="$ctx:responseProperty"/>
   </log>
            <respond/>
        </inSequence>
    </target>
</proxy>
```

**Sample Request**

Invoke the `testDSSResposeTarget` proxy service with the given payload.

```bash
http://localhost:8290/services/testDSSResposeTarget
```

**Response**

The following log will appear in the server console:

```bash
INFO {LogMediator} - {proxy:test} reponseValue = SUCCESSFUL
```

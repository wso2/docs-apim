# PayloadFactory Mediator

The **PayloadFactory Mediator** transforms or replaces the contents of a
message. That is, you can configure the format of the request or response
and also map it with arguments provided in the payloadfactory configuration.

You can use two methods to format the payload using this mediator.

-   Use the **default** template to write the payload in the required format (JSON, XML, or text).
-   Use the **FreeMarker** template to write the payload. This is particularly useful when 
    defining complex JSON payloads.

You can provide arguments in the mediator configuration to pass values to your payload during runtime.
You can specify a static value or use an XPath/JSON expression to pass values dynamically. 
The values passed by the arguments are evaluated against the existing 
message.

!!! Info
    The PayloadFactory mediator is a [content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` java
<payloadFactory media-type="xml | json" template-type="default | freemarker">
    <format ../>
    <args>       
        <arg (value="string" | expression=" {xpath} | {json} | {text} ")/>* 
    </args> 
</payloadFactory>
```

If you want to change the payload type of
the outgoing message, such as to change it to JSON, add the
`         messageType        ` property after the
`         </payloadFactory>        ` tag. For example:

``` 
...
</payloadFactory>
<property name="messageType" value="application/json" scope="axis2"/>
```

## Configuration

Parameters available to configure the PayloadFactory mediator are as follows:

<table>
  <tr>
    <th>
      Parameter Name
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      media-type
    </td>
    <td>
      This parameter is used to specify whether the message payload should be formatted in JSON, XML, or Text. If no media type is specified, the message is formatted in XML.
    </td>
  </tr>
  <tr>
    <td>
      template-type
    </td>
    <td>
      The template type determines how you define a new payload. Select one of the following template types:
      <ul>
                <li>
          <b>default</b>: If you select this template type, you can define the payload using the normal syntax of the specified media type.
        </li>
        <li>
          <b>FreeMarker</b>: If you select this template type, the mediator will accept FreeMarker templates to define the payload.
        </li>
      </ul>
            See the examples given below for details.
    </td>
  </tr>
  <tr>
    <td>
      format
    </td>
    <td>
            Select one of the following values:
      <ul>
        <li>
          <b>Define Inline</b>: If this is selected, the payload format can be defined within the PayloadFactory mediator in the <b>Payload</b> field.
        </li>
        <li>
          <b>Pick from Registry</b>: If this is selected, an existing payload format that is saved in the registry can be selected. Click either <strong>Governance Registry</strong> or <strong>Configuration Registry</strong> as relevant to select the payload format from the resource tree.
        </li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      Payload
    </td>
    <td>
      Define the payload accoding to the template type you selected for the <b>template-type</b> parameter.
    </td>
  </tr>
  <tr>
    <td>
      Arguments
    </td>
    <td>
      This section is used to add an argument that defines the actual value of each variable in the format definition.
    </td>
  </tr>
</table>

You need to specify the payload format and arguments depending on the <b>template-type</b> you specified in the mediator configuration.

### Default Template

If you select **default** as the **template-type**, you can define the payload and arguments as shown below. This example defines an XML payload.

```xml
<payloadFactory description="Construct payload for addition operation" media-type="xml">
    <format>
        <tem:AddInteger xmlns:tem="http://tempuri.org">
            <tem:Arg1>$1</tem:Arg1>
            <tem:Arg2>$2</tem:Arg2>
        </tem:AddInteger>
    </format>
    <args>
        <arg evaluator="json" expression="$.Arg1"/>
        <arg evaluator="json" expression="$.Arg2"/>
    </args>
</payloadFactory>
```

- Payload Format

  As shown above, you can add content to the payload by specifying variables for each value that you want to add. Use the $<em>n</em> format. Start with n=1 and then increment the value for each additional variable as follows: `$1`, `$2`, etc.

- Arguments

  The arguments must be entered in the same order as the variables in the payload. That is, the first argument defines the value for variable $1, the second argument defines the value for variable $2, etc. An argument can specify a literal string (e.g., "John") or an XPath/JSON expression that extracts the value from the content in the incoming payload as shown above.

### FreeMarker Template

The payloadFactory mediator of WSO2 APIM 4.0.0 supports [FreeMarker Templates](https://freemarker.apache.org/docs/). If you select **freemarker** as the **template-type**, you can define the payload as a FreeMarker template. The following example defines a JSON payload.

!!! Note
    -   FreeMarker version 2.3.30 is tested with WSO2 APIM 4.0.0.
    -   You are not required to specify the CDATA tag manually when defining the payload. WSO2 Integration Studio will apply the tag automatically.

```xml
<property name="user_name" scope="default" type="STRING" value="john"/>
<payloadFactory media-type="json" template-type="freemarker">
    <format><![CDATA[{
        "name": "${payload.customer_name}"
        "ctx property" : "${ctx.customer_id}",
        "axis2 property": "${axis2.REST_URL_POSTFIX}",
        "trp property": "${trp.Host}"
        }]]>
    </format>
<args/>
</payloadFactory>
```

When you use the FreeMarker template type as shown above, note that the script is wrapped inside a CDATA tag. This is applicable for all media types when the payload is defined **inline**. If you get the payload from the registry, the CDATA tag does not apply.

The following root variables are available when you format a FreeMarker payload:

<table>
  <tr>
    <th>
      <code>payload</code>
    </th>
    <td>
      This variable represents the current payload in the message context. It can be JSON, XML, or TEXT. Regardless of the payload type, the payload variable is a <a href="https://freemarker.apache.org/docs/pgui_datamodel_parent.html#autoid_32">FreeMarker Hash type container</a>.
    </td>
  </tr>
  <tr>
    <th>
      <code>ctx</code>
    </th>
    <td>
      You can use the ctx variable to access properties with the 'default' scope. For example, if you have a property named 'customer_id' in the default scope, you can get the property in the FreeMarker template by using 'ctx.customer_id'.
    </td>
  </tr>
  <tr>
    <th>
      <code>axis2</code>
    </th>
    <td>
      This represents all the axis2 properties.
    </td>
  </tr>
  <tr>
    <th>
      <code>trp</code>
    </th>
    <td>
      This variable represents transport headers. You can access transport header values in the same way as accessing properties.
    </td>
  </tr>
  <tr>
    <th>
      <code>arg</code>
    </th>
    <td>
      This variable represents the arguments created at the PayloadFactory mediator. You can use 'args.arg#' to get any argument. Replace '#' with the argument index. For example, if you want to access the 1st argument in the FreeMarker template, you can use 'args.arg1'.
    </td>
  </tr>
</table>

See the [Freemarker examples](#examples-using-the-freemarker-template) for details.

## Examples: Using the default template

### Using XML

```xml 
<proxy name="RespondMediatorProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
     <target>
        <inSequence>
            <!-- using payloadFactory mediator to transform the request message -->
            <payloadFactory media-type="xml">
                <format>
                    <m:getQuote xmlns:m="http://services.samples">
                        <m:request>
                            <m:symbol>$1</m:symbol>
                        </m:request>
                    </m:getQuote>
                </format>
                <args>
                    <arg xmlns:m0="http://services.samples" expression="//m0:Code"/>
                </args>
            </payloadFactory>
        </inSequence>
        <outSequence>
            <!-- using payloadFactory mediator to transform the response message -->
            <payloadFactory media-type="xml">
                <format>
                    <m:CheckPriceResponse xmlns:m="http://services.samples/xsd">
                        <m:Code>$1</m:Code>
                        <m:Price>$2</m:Price>
                    </m:CheckPriceResponse>
                </format>
                <args>
                    <arg xmlns:m0="http://services.samples/xsd" expression="//m0:symbol"/>
                    <arg xmlns:m0="http://services.samples/xsd" expression="//m0:last"/>
                </args>
            </payloadFactory>
            <send/>
        </outSequence>          
     </target>
</proxy>
```

### Using JSON

```
<payloadFactory media-type="json">
            <format>
                {
    "coordinates": null,
    "created_at": "Fri Jun 24 17:43:26 +0000 2011",
    "truncated": false,
    "favorited": false,
    "id_str": "$1",
    "entities": {
        "urls": [

        ],
        "hashtags": [
            {
                "text": "$2",
                "indices": [
                    35,
                    45
                ]
            }
        ],
        "user_mentions": [

        ]
    },
    "in_reply_to_user_id_str": null,
    "contributors": null,
    "text": "$3",
    "retweet_count": 0,
    "id": "##",
    "in_reply_to_status_id_str": null,
    "geo": null,
    "retweeted": false,
    "in_reply_to_user_id": null,

    "source": "&lt;a 
href=\"http://sites.google.com/site/yorufukurou/\" 
rel=\"nofollow\"&gt;YoruFukurou&lt;/a&gt;",
    "in_reply_to_screen_name": null,
    "user": {
        "id_str": "##",
        "id": "##"
    },
    "place": null,
    "in_reply_to_status_id": null
}
            </format>
            <args>
               <arg expression="$.entities.hashtags[0].text" evaluator="json"/>
               <arg expression="//entities/hashtags/text"/>
               <arg expression="//user/id"/>
               <arg expression="//user/id_str"/>
               <arg expression="$.user.id" evaluator="json"/>
               <arg expression="$.user.id_str" evaluator="json"/>
            </args>
</payloadFactory>
<property name="messageType" value="application/json" scope="axis2"/>
```

If you specify a JSON expression in the PayloadFactory mediator, you 
must use the `         evaluator        ` attribute to specify that it 
is JSON. You can also use the evaluator to specify that an XPath 
expression is XML, or if you omit the evaluator attribute, XML is 
assumed by default. For example:

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td>XML</td>
<td><p><code>              &lt;arg                             xmlns:m0=                            "                             http://sample                            " expression="//                             m0:symbol                            " evaluator=”xml” /&gt;             </code></p>
<p>or<br />
</p>
<p><code>              &lt;arg                             xmlns:m0=                            "                                             http://sample                                           " expression="//                             m0:symbol                            " /&gt;             </code></p></td>
</tr>
<tr class="even">
<td>JSON</td>
<td><code>             &lt;arg expression="$.user.id" evaluator="json" /&gt;            </code></td>
</tr>
</tbody>
</table>

!!! Note
    To evaluate the json-path against a property, use the following syntax:
    ```xml
    <arg expression="$ctx:property.user.id" evaluator="json" />
    ```
    Learn more about the [json-path syntax]({{base_path}}/integrate/examples/json_examples/json-examples).

### Adding arguments

In the following configuration, the values for format parameters
`         code        ` and `         price        ` will be assigned
with values that are evaluated from arguments given in the specified
order.

```
<payloadFactory media-type="xml">
    <format>
        <m:checkpriceresponse xmlns:m="http://services.samples/xsd">
        <m:code>$1</m:code>
        <m:price>$2</m:price>
    </m:checkpriceresponse>
</format>
<args>
    <arg xmlns:m0="http://services.samples/xsd" expression="//m0:symbol"/>
    <arg xmlns:m0="http://services.samples/xsd" expression="//m0:last"/>
</args>
</payloadFactory>
```

### Suppressing the namespace

To prevent the ESB profile from adding the default Synapse namespace in
an element in the payload format, use `         xmlns=""        ` as
shown in the following example.

``` java
<ser:getPersonByUmid xmlns:ser="http://service.directory.com">
               <umid xmlns="">sagara</umid>
</ser:getPersonByUmid>     
```

### Including a complete SOAP envelope as the format

In the following configuration, an entire SOAP envelope is added as the
format defined inline. This is useful when you want to generate the
result of the PayloadFactory mediator as a complete SOAP message with
SOAP headers.

```
<payloadFactory media-type="xml"> 
<format> 
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"> 
<soapenv:Body> 
<error> 
<mes>$1</mes> 
</error> 
</soapenv:Body> 
</soapenv:Envelope> 
</format> 
<args> 
<arg value=" Your request did not return any results. Please enter a valid EIN and try again"/> 
</args> 
</payloadFactory>
```

### Uploading a file to an HTTP endpoint via a multipart request

The below example configuration uses VFS to upload the file in the
specified location to the given HTTP endpoint via a HTTP multipart
request.

```
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="smooksample"
       startOnLoad="true"
       statistics="disable"
       trace="disable"
       transports="vfs">
   <target>
      <inSequence>
         <enrich>
            <source clone="true" type="body"/>
            <target property="originalBody" type="property"/>
         </enrich>
         <property name="messageType"
                   scope="axis2"
                   type="STRING"
                   value="multipart/form-data"/>
         <payloadFactory media-type="xml">
            <format>
               <root xmlns="">
                  <customFieldOne>$1</customFieldOne>
                  <customFieldTwo>$2</customFieldTwo>
                  <file xmlns="http://org.apache.axis2/xsd/form-data"
                        charset="US-ASCII"
                        content-type="text/plain"
                        filename="$3"
                        name="file1">$4</file>
               </root>
            </format>
            <args>
               <arg value="Some value 1"/>
               <arg value="Some value 2"/>
               <arg evaluator="xml" expression="$trp:FILE_NAME"/>
               <arg evaluator="xml" expression="$ctx:originalBody"/>
            </args>
         </payloadFactory>
         <header name="Content-Type" scope="transport" value="multipart/form-data"/>
         <property name="messageType"
                   scope="axis2"
                   type="STRING"
                   value="multipart/form-data"/>
         <property name="OUT_ONLY" scope="default" type="STRING" value="true"/>
             <send>
            <endpoint>
               <address format="rest" uri="http://localhost:3000/upload/"/>
            </endpoint>
         </send>
      </inSequence>
   </target>
   <parameter name="transport.PollInterval">5</parameter>
   <parameter name="transport.vfs.FileURI">file:///<YOUR_FILE_LOCATION></parameter>
   <parameter name="transport.vfs.ContentType">application/octet-stream</parameter>
   <parameter name="transport.vfs.ActionAfterProcess">DELETE</parameter>
   <parameter name="transport.vfs.FileNamePattern">.*\..*</parameter>
   <description/>
</proxy>
```

In the above example, the following property mediator configuration sets
the message type as `         multipart/form-data        ` .

```
<property name="messageType"
    scope="axis2"
    type="STRING"
    value="multipart/form-data"/>
```

The below `         file        ` parameter of the payload factory
mediator defines the HTTP multipart request.

!!! Tip
    Do not change the `                   http://org.apache.axis2/xsd/form-data                 ` namesapce.

``` xml
<file xmlns="http://org.apache.axis2/xsd/form-data"
   charset="US-ASCII"
   content-type="text/plain"
   filename="$3"
   name="file1">$4</file>
```

Also, the below property mediator configuration sets the content of the
uploaded file.

```
<header name="Content-Type" scope="transport" value="multipart/form-data"/>
  <property name="messageType"
      scope="axis2"
      type="STRING"
      value="multipart/form-data"/>
```

### Adding a literal argument

The following example adds a literal argument to the Payload Factory
mediator, and sets it to true. This allows you to consider the type of
the argument value as String and to stop processing it.

```
<api xmlns="http://ws.apache.org/ns/synapse" name="payload" context="/payload">
   <resource methods="POST">
      <inSequence>
         <property name="getvalue" expression="json-eval($.hello)"/>
         <payloadFactory media-type="json">
            <format>{"newValue" : "$1"}</format>
            <args>
               <arg evaluator="xml" literal="true" expression="get-property('getvalue')"/>
            </args>
         </payloadFactory>
         <respond/>
      </inSequence>
   </resource>
</api>
```

Following is a sample payload (i.e., `         a.json        ` file),
which you can process using the above configuration.

**a.json**

``` js
{"hello" : "<pqr>abc</pqr>"}
```

You can use the below sample cURL command to send the request to the
above configuration.

``` js
curl -d @a.json http://localhost:8280/payload -H "Content-Type: application/json" -v
```

You view the below output:

``` js
{"newValue" : "{"pqr":"abc"}"}
```

!!! Info
    If you do not add the `         literal="true"        ` within the
argument in the Payload Factory mediator of the above configuration, you
view the output as follows:

    {"newValue" : "<pqr>abc</pqr>"}


### Adding a custom SOAP header

You can add custom SOAP headers to a request by using the PayloadFactory
Mediator in a proxy service as shown in the example below.

``` xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="StockQuoteProxy"
transports="https http"
startOnLoad="true"
trace="disable">
<description/>
<target>
<endpoint>
<address uri="http://localhost:9001/services/SimpleStockQuoteService"/>
</endpoint>
<inSequence>
<log level="full"/>
<payloadFactory media-type="xml">
<format>
<soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"
xmlns:xsd="http://services.samples/xsd"
xmlns:ser="http://services.samples">
<soapenv:Header>
<ser:authenticationRequest>
<userName xmlns="">$1</userName>
<password xmlns="">$2</password>
</ser:authenticationRequest>
</soapenv:Header>
<soapenv:Body>
<ser:getQuote>
<ser:request>
<xsd:symbol>$3</xsd:symbol>
</ser:request>
</ser:getQuote>
</soapenv:Body>
</soapenv:Envelope>
</format>
<args>
<arg value="punnadi"/>
<arg value="password"/>
<arg value="hello"/>
</args>
</payloadFactory>
</inSequence>
<outSequence>
<send/>
</outSequence>
<faultSequence>
     <sequence key="errorHandler"/>
</faultSequence>
</target>
<publishWSDL uri="file:repository/samples/resources/proxy/sample_proxy_1.wsdl"/>
</proxy>
<sequence xmlns="http://ws.apache.org/ns/synapse" name="errorHandler">
<log level="full">
<property name="MESSAGE" value="Executing default "fault" sequence"/>
<property name="ERROR_CODE" expression="get-property('ERROR_CODE')"/>
<property name="ERROR_MESSAGE" expression="get-property('ERROR_MESSAGE')"/>
</log>
<drop/>
</sequence>
```

## Examples: Using the FreeMarker template

### XML to JSON Transformation

This example shows how an XML payload can be converted to a JSON payload using a freemarker template.

-   Input Payload
    ```xml
    <user>
        <first_name>John</first_name>
        <last_name>Deo</last_name>
        <age>35</age>
        <location>
            <state code="NY">New York</state>
            <city>Manhattan</city>
        </location>
    </user>
    ```

-   Output Payload
    ```json
    {
        "Name": "John Doe",
        "Age": 35,
        "Address": "Manhattan, NY"
    }
    ```

-   FreeMarker Tamplate
    ```json
    {
    "Name": "${payload.user.first_name} ${payload.user.last_name}",
    "Age": "${payload.user.age}",
    "Address": "${payload.user.location.city},${payload.user.location.state.@code}"
    }
    ```

-   Synapse Code
    ```xml
    <payloadFactory media-type="json" template-type="freemarker">
        <format>
            <![CDATA[{
                "Name": "${payload.user.first_name} ${payload.user.last_name}",
                "Age": ${payload.user.age},
                "Address": "${payload.user.location.city},${payload.user.location.state.@code}"
            }]]>
        </format>
        <args/>
    </payloadFactory>
    ```

You can get more info on how to use XML payloads from [FreeMarker's official documentation](https://freemarker.apache.org/docs/xgui.html).

### JSON to XML Transformation

This example shows how a JSON payload can be converted to an XML payload using a freemarker template.

-   Input Payload
    ```json
    {
    "first_name": "John",
    "last_name": "Deo",
    "age": 35,
        "location": {
            "state": {
                "code": "NY",
                "name": "New York"
            },
            "city": "Manhattan"
        }
    }
    ```

-   Output Payload
    ```xml
    <user>
        <Name>John Deo</Name>
        <Age>35</Age>
        <Address>Manhattan, NY</Address>
    </user>
    ```

-   FreeMarker Tamplate
    ```xml
    <user>
        <Name>${payload.first_name} ${payload.last_name}</Name>
        <Age>${payload.age}</Age>
        <Address>${payload.location.city}, ${payload.location.state.code}</Address>
    </user>
    ```

-   Synapse Code
    ```xml
    <payloadFactory media-type="xml" template-type="freemarker">
        <format><![CDATA[<user>
        <Name>${payload.first_name} ${payload.last_name}</Name>
        <Age>${payload.age}</Age>
        <Address>${payload.location.city}, ${payload.location.state.code}</Address>
        </user>]]>
        </format>
        <args/>
    </payloadFactory>
    ```

### JSON to JSON Transformation

This example shows how a JSON payload is transformed into another JSON format using a freemarker template.

-   Input Payload
    ```json
    {
    "first_name": "John",
    "last_name": "Deo",
    "age": 35,
    "location": {
            "state": {
                "code": "NY",
                "name": "New York"
            },
            "city": "Manhattan"
        }
    }
    ```

-   Output Payload
    ```json
    {
        "Name": "John Doe",
        "Age": 35,
        "Address": "Manhattan, NY"
    }
    ```

-   FreeMarker Tamplate
    ```json
    {
        "Name": "${payload.first_name} ${payload.last_name}",
        "Age": "${payload.age}",
        "Address": "${payload.location.city}, ${payload.location.state.code}"
    }
    ```

-   Synapse Code
    ```xml
    <payloadFactory media-type="json" template-type="freemarker">
        <format>
            <![CDATA[{
                "Name": "${payload.first_name} ${payload.last_name}",
                "Age": ${payload.age},
                "Address": "${payload.location.city}, ${payload.location.state.code}"
            }]]>
        </format>
        <args/>
    </payloadFactory>
    ```

### Handling Arrays

#### XML Arrays

This example shows how to loop through an XML array in the input payload and then transform the data using a freemarker template.

-   Input Payload
    ```xml
    <people>
        <person>
            <id>1</id>
            <first_name>Veronika</first_name>
            <last_name>Lacroux</last_name>
        </person>
        <person>
            <id>2</id>
            <first_name>Trescha</first_name>
            <last_name>Campaigne</last_name>
        </person>
        <person>
            <id>3</id>
            <first_name>Mayor</first_name>
            <last_name>Moscrop</last_name>
        </person>
    </people>
    ```

-   Output Payload
    ```xml
    <people>
        <person>
            <index>1</index>
            <name>Veronika Lacroux</first_name>
        </person>
        <person>
            <index>2</index>
            <name>Trescha Campaigne</name>
        </person>
        <person>
            <index>3</index>
            <name>Mayor Moscrop</name>
        </person>
    </people>
    ```

    Note that, we have looped through the person list in the input XML, and received a person list in the output. However, the name attribute in the output is a combination of the first_name and last_name attributes from the input.

-   FreeMarker Tamplate
    ```xml
    <people>
        <#list payload.people.person as person>
        <person>
            <index>${person.id}</index>
            <name>${person.first_name} ${person.last_name}</name>
        </person>
        </#list>
    </people>
    ```

    In this FreeMarker template, we are using the list directive. This is used to loop through a list in the input and transform it into another structure in the output. You can get more information about the list directive from [FreeMarker documentation](https://freemarker.apache.org/docs/ref_directive_list.html).

-   Synapse Code
    ```xml
    <payloadFactory media-type="xml" template-type="freemarker">
        <format>
            <![CDATA[<people>
            <#list payload.people.person as person>
            <person>
                <index>${person.id}</index>
                <name>${person.first_name} ${person.last_name}</name>
            </person>
            </#list>
            </people>]]>
        </format>
        <args/>
    </payloadFactory>
    ```

#### JSON Arrays

This example shows how to loop through a JSON array in the input payload and then transform the data using a freemarker template.

-   Input Payload
    ```json
    [{
    "id": 1,
    "first_name": "Veronika",
    "last_name": "Lacroux"
    }, {
    "id": 2,
    "first_name": "Trescha",
    "last_name": "Campaigne"
    }, {
    "id": 3,
    "first_name": "Mayor",
    "last_name": "Moscrop"
    }]
    ```

-   FreeMarker Tamplate
    ```xml
    <people>
    <#list payload as person>
    <person>
        <index>${person.id}</index>
        <name>${person.first_name} ${person.last_name}</name>
    </person>
    </#list>
    </people>
    ```

    As you can see here, it is almost the same as the XML list. You have to use an identical syntax to loop through a JSON array.

-   Synapse Code
    ```xml
    <payloadFactory media-type="xml" template-type="freemarker">
        <format>
            <![CDATA[<people>
            <#list payload as person>
            <person>
                <index>${person.id}</index>
                <name>${person.first_name} ${person.last_name}</name>
            </person>
            </#list>
            </people>]]>
        </format>
        <args/>
    </payloadFactory>
    ```

### Generating CSV Payloads

Using FreeMarker templates, it is straightforward to generate text payloads. The payload you generate could be plain text, a CSV, or EDI, and any other text related format. In this example, we are showing how to transform an XML payload into a CSV payload. 

-   Input Payload
    ```xml
    <people>
        <person>
            <id>1</id>
            <first_name>Veronika</first_name>
            <last_name>Lacroux</last_name>
        </person>
        <person>
            <id>2</id>
            <first_name>Trescha</first_name>
            <last_name>Campaigne</last_name>
        </person>
        <person>
            <id>3</id>
            <first_name>Mayor</first_name>
            <last_name>Moscrop</last_name>
        </person>
    </people>
    ```

-   Output Payload
    ```
    ID,First Name, Last Name
    1,Veronika,Lacroux
    2,Trescha,Campaigne
    3,Mayor,Moscrop
    ```

    In this output, we have converted the person list in the XML payload into a CSV payload.

-   FreeMarker Tamplate
    ```
    ID,First Name, Last Name
    <#list payload.people.person as person>
    ${person.id},${person.first_name},${person.last_name}
    </#list>
    ```

    In this template, we define the CSV structure and fill it by looping through the payload list. If the input payload is JSON, there will not be a significant difference in this template. See the example on [Handling Arrays](#handling-arrays) to understand the difference between JSON and XML array traversing.

-   Synapse Code
    ```xml
    <payloadFactory media-type="text" template-type="freemarker">
        <format><![CDATA[ID,First Name, Last Name
                <#list payload.people.person as person>
                ${person.id},${person.first_name},${person.last_name}
                </#list>]]>
        </format>
        <args/>
    </payloadFactory>
    ```

    If you don’t know the CSV column names and the number of columns, you can use a FreeMarker template like the following to generate a CSV for the given XML. 

    ```xml
    <#list payload.people.person[0]?children?filter(c -> c?node_type == 'element') as c>${c?node_name}<#sep>,</#list>
    <#list payload.people.person as person>
    <#list person?children?filter(c -> c?node_type == 'element') as c>${c}<#sep>,</#list>
    </#list>
    ```

### Accessing Properties

This example shows how to access properties using the following variables: `ctx`, `axis2`, and `trp`.

-   FreeMarker Tamplate
    ```json
    {
    "ctx property" : "${ctx.user_name}",
    "axis2 property": "${axis2.REST_URL_POSTFIX}",
    "trp property": "${trp.Host}"
    }
    ```

    In this freemarker template, we have referenced the default scoped property named `user_name`, the axis2 scoped property named `REST_URL_POSTFIX`, and the transport header `Host`. The output is returned as a JSON object.

-   Output Payload
    ```json
    {
    "ctx property": "john",
    "axis2 property": "/demo",
    "trp property": "localhost:8290"
    }
    ```

-   Synapse Code
    ```xml
    <property name="user_name" scope="default" type="STRING" value="john"/>
    <payloadFactory media-type="json" template-type="freemarker">
        <format><![CDATA[{
            "ctx property" : "${ctx.user_name}",
            "axis2 property": "${axis2.REST_URL_POSTFIX}",
            "trp property": "${trp.Host}"
            }]]>
        </format>
    <args/>
    </payloadFactory>
    ```

### Accessing Arguments

This example shows how to use arguments in a freemarker template to pass values to the variables in the payload.

-   FreeMarker Tamplate
    ```json
    {
    "argument one": "${args.arg1}",
    "argument two":  "${args.arg2}"
    }
    ```

-   Output Payload
    ```json
    {
    "argument one": "Value One",
    "argument two": 500
    }
    ```

-   Synapse Code
    ```xml
    <payloadFactory media-type="json" template-type="freemarker">
        <format><![CDATA[{
        "argument one": "${args.arg1}",
        "argument two": ${args.arg2}
            }]]>
        </format>
        <args>
            <arg value="Value One"/>
            <arg value="500"/>
        </args>
    </payloadFactory>
    ```

In this example, the value for the “argument one” key is replaced by the first argument value. The argument for the "argument two" key is replaced by the second argument value.
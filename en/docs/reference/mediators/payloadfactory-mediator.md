# PayloadFactory Mediator

The **PayloadFactory Mediator** transforms or replaces the contents of a
message. Each argument in the mediator configuration can be a static
value, or you can specify an XPath or JSON expression to get the value
at runtime by evaluating the provided expression against the existing
SOAP message. You can configure the format of the request or response
and map it to the arguments provided.

!!! Info
    The PayloadFactory mediator is a [content aware](../../../references/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` java
<payloadFactory media-type="xml | json">
    <format ../>
    <args>       
        <arg (value="string" | expression=" {xpath} | {json} | {text} ")/>* 
    </args> 
</payloadFactory>
```

The `         media-type        ` attribute specifies whether to format
the message in XML, JSON, or text. If no media type is specified, the
message is formatted in XML. If you want to change the payload type of
the outgoing message, such as to change it to JSON, add the
`         messageType        ` property after the
`         </payloadFactory>        ` tag. For example:

``` 
...
</payloadFactory>
<property name="messageType" value="application/json" scope="axis2"/>
```

## Configuration

Parameters available to configure the PayloadFactory mediator are as
follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Payload Media-Type</strong></td>
<td>This parameter is used to specify whether the message payload should be created in JSON, XML, or text.</td>
</tr>
<tr class="even">
<td><strong>Payload Format</strong></td>
<td><p><strong>Define Inline</strong> : If this is selected, the payload format can be defined within the PayloadFactory mediator configuration by entering it in the text field which appears. To add content to the payload, enter variables for each value you want to add using the format $ <em>n</em> (starting with 1 and incrementing with each additional variable, i.e., $1, $2, etc.). You will then create arguments in the same order as the variables to specify each variable's actual value.</p>
<p><strong>Pick from Registry</strong> : If this is selected, an existing payload format which is saved in the Registry can be selected. Click either <strong>Governance Registry</strong> or <strong>Configuration Registry</strong> as relevant to select the payload format from the resource tree.</p></td>
</tr>
<tr class="odd">
<td><strong>Arguments</strong></td>
<td><div class="content-wrapper">
<p>This section is used to add an argument that defines the actual value of each variable in the format definition. The arguments must be entered in the same order as the variables in the format, so that the first argument defines the value for variable $1, the second argument defines the value for variable $2, etc. An argument can specify a literal string (e.g., "John") or an XPath or JSON expression that extracts the value from the content in the incoming payload.</p>
</div></td>
</tr>
</tbody>
</table>

## Examples

This section provides examples of using PayloadFactory mediator to
generate XML and JSON messages.

### Using XML

``` 
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
<ser:getPersonByUmid xmlns:ser="http://service.directory.com>
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

<!--
#### Samples

The following samples demonstrate the use of the PayloadFactory
mediator.

-   [Sample 17: Transforming / Replacing Message Content with
    PayloadFactory
    Mediator](https://docs.wso2.com/pages/viewpage.action?pageId=85369102)
-->

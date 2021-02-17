# Transforming API Message Payload

When a request comes to the API Manager, it sends the response in the same format of the request. For example, 
the API Manager handles JSON to JSON transformations out of the box. If the backend does not accept messages of the 
same content type of the request message, it must be transformed to a different format. The API Gateway of the 
API Manager handles these transformations using message builders and formatters.

When a message comes in to the API Gateway, the receiving transport selects a **message builder** based on the 
message's content type. It uses that builder to process the message's raw payload data and convert it into JSON. 
Conversely, when sending a message out from the Gateway, a **message formatter** is used to build the outgoing stream 
from the message. As with message builders, the message formatter is selected based on the message's content type.

!!! tip
    Note that if you edit an API's synapse configuration as mentioned in this guide and then go back to the API 
    Publisher and save the API, your changes will be overwritten. Therefore, we do not recommend changing the API's 
    synapse configuration directly. The recommended way to extend an API's mediation flow is by 
    [engaging <code>In/Out</code> sequences]({{base_path}}/learn/api-gateway/message-mediation/changing-the-default-mediation-flow-of-api-requests).


!!! info
    Also see the following sections in the WSO2 EI documentation. WSO2 EI is used to implement the API Gateway through which API messages are transformed:

    -   [Accessing content from JSON payloads](https://ei.docs.wso2.com/en/latest/micro-integrator/use-cases/examples/json_examples/json-examples/#accessing-content-from-json-payloads)
    -   [Logging JSON payloads](https://ei.docs.wso2.com/en/latest/micro-integrator/use-cases/examples/json_examples/json-examples/#logging-json-payloads)
    -   [Constructing and transforming JSON payloads](https://ei.docs.wso2.com/en/latest/micro-integrator/use-cases/examples/json_examples/json-examples/#constructing-and-transforming-json-payloads)
    -   [Troubleshooting, debugging, and logging](https://ei.docs.wso2.com/en/latest/micro-integrator/use-cases/examples/json_examples/json-examples/#troubleshooting-debugging-and-logging)

### JSON message builders and formatters

There are two types of message builders and formatters for JSON. The default builder and formatter keep the JSON 
representation intact without converting it to XML. You can access the payload content using the JSON Path or XPath 
and convert the payload to XML at any point in the mediation flow.

- `org.apache.synapse.commons.json.JsonStreamBuilder`

- `org.apache.synapse.commons.json.JsonStreamFormatter`

If you want to convert the JSON representation to XML before the mediation flow begins, use the following builder and 
formatter instead.  
Note that some data loss can occur during the JSON -&gt; XML -&gt; JSON conversion process.

- `org.apache.synapse.commons.json.JsonBuilder`

- `org.apache.synapse.commons.json.JsonFormatter`

The builders and formatters are configured respectively in the `messageBuilders` and `messageFormatters` sections of 
the Axis2 configuration files located in the `<APIM_HOME>/repository/conf/axis2` directory. Both types of JSON 
builders use [StAXON](https://github.com/beckchr/staxon) as the underlying JSON processor.

The following builders and formatters are also included for compatibility with older API Manager versions:

- `org.apache.axis2.json.JSONBuilder/JSONMessageFormatter`
- `org.apache.synapse.commons.json.JsonStreamBuilder/JSONStreamFormatter`
- `org.apache.axis2.json.JSONBadgerfishOMBuilder/JSONBadgerfishMessageFormatter`

!!! note
    Always use the same type of builder and formatter combination. Mixing different builders and formatters will 
    cause errors at runtime.


If you want to handle JSON payloads that are sent using a media type other than `application/json`, you must 
register the JSON builder and formatter for that media type using the `deployment.toml` file found in the 
`<APIM_HOME>/repository/conf` directory):

For example, if the media type is `text/javascript`, register the message builder and formatter as follows:

``` toml
[message_builder]
text_javascript = "org.apache.synapse.commons.json.JsonStreamBuilder"

[message_formatter]
text_javascript = "org.apache.synapse.commons.json.JsonStreamFormatter"
```
    
!!! tip
    To support having spaces inside JSON attributes, change the default JSON builder and formatter to the following 
    pair to the `<APIM_HOME>/repository/conf/deployment.toml` file:
    
    ``` toml
    [message_builder]
    application_json = "org.apache.synapse.commons.json.JsonStreamBuilder"
    
    [message_formatter]
    application_json = "org.apache.synapse.commons.json.JsonStreamFormatter"
    ```

!!! tip
    To support use cases for JSON payloads with arrays, change the default JSON builder and formatter to the following 
    pair to the `<APIM_HOME>/repository/conf/deployment.toml` file:

    ``` toml
    [message_builder]
    application_json = "org.apache.synapse.commons.json.JsonStreamBuilder"
        
    [message_formatter]
    application_json = "org.apache.synapse.commons.json.JsonStreamFormatter"
    ```

    Else, in JSON to XML conversion, there might be issues as below:

    **JSON**

    ``` json
    "phoneNumbers":[
        {
            "phoneNumber":"4027161289",
            "phoneNumberType":"home"
        }
    ]
    ```

    **Converted XML**

    ``` xml
    <?xml-multiple phoneNumbers?>
    <phoneNumbers>
       <phoneNumber>4027161289</phoneNumber>
       <phoneNumberType>home</phoneNumberType>
    </phoneNumbers>
    ```

!!! note
    When you modify the builders/formatters in Axis2 configuration, make sure that you have enabled only one correct 
    message builder/formatter pair for a given media type.


### XML representation of JSON payloads

When building the XML tree, JSON builders attach the converted XML infoset to a special XML element that acts as 
the root element of the final XML tree. If the original JSON payload is of type `object`, the special element is 
`<jsonObject/>`. If it is an `array`, the special element is `<jsonArray/>`. Following are examples of JSON and 
XML representations of various objects and arrays.

#### Null objects

JSON:

``` json
{"object":null}
```

XML:

``` xml
<jsonObject>
    <object></object>
</jsonObject>
```

#### Empty objects

JSON:

``` json
{"object":{}}
```

XML:

``` xml
<jsonObject>
    <object></object>
</jsonObject>
```

#### Empty strings

JSON:

``` json
{"object":""}
```

XML:

``` xml
<jsonObject>
    <object></object>
</jsonObject>
```

#### Empty array

JSON:

``` json
[]
```

XML (JsonStreamBuilder):

``` xml
<jsonArray></jsonArray>
```

XML (JsonBuilder):

``` xml
<jsonArray>
    <?xml-multiple jsonElement?>
</jsonArray>
```

#### Named arrays

JSON:

``` json
{"array":[1,2]}
```

XML (JsonStreamBuilder):

``` xml
<jsonObject>
    <array>1</array>
    <array>2</array>
</jsonObject>
```

XML (JsonBuilder):

``` xml
<jsonObject>
    <?xml-multiple array?>
    <array>1</array>
    <array>2</array>
</jsonObject>
```

JSON:

``` json
{"array":[]}
```

XML (JsonStreamBuilder):

``` xml
<jsonObject></jsonObject>
```

XML (JsonBuilder):

``` xml
<jsonObject>
    <?xml-multiple array?>
</jsonObject>
```

#### Anonymous arrays

JSON:

``` json
[1,2]
```

XML (JsonStreamBuilder):

``` xml
<jsonArray>
    <jsonElement>1</jsonElement>
    <jsonElement>2</jsonElement>
</jsonArray>
```

XML (JsonBuilder):

``` xml
<jsonArray>
    <?xml-multiple jsonElement?>
    <jsonElement>1</jsonElement>
    <jsonElement>2</jsonElement>
</jsonArray>
```

JSON:

``` json
[1, []]
```

XML (JsonStreamBuilder):

``` xml
<jsonArray>
    <jsonElement>1</jsonElement>
    <jsonElement>
        <jsonArray></jsonArray>
    </jsonElement>
</jsonArray>
```

XML (JsonBuilder):

``` xml
<jsonArray>
    <?xml-multiple jsonElement?>
    <jsonElement>1</jsonElement>
    <jsonElement>
        <jsonArray>
            <?xml-multiple jsonElement?>
        </jsonArray>
    </jsonElement>
</jsonArray>
```

#### XML processing instructions (PIs)

Note that the addition of `xml-multiple` processing instructions to the XML payloads whose JSON representations contain 
arrays. `JsonBuilder` (via StAXON) adds these instructions to the XML payload that it builds during the JSON to XML 
conversion so that during the XML to JSON conversion, `JsonFormatter` can reconstruct the arrays that are present in 
the original JSON payload. `JsonFormatter` interprets the elements immediately following a processing instruction to 
construct an array.

#### Special characters

When building XML elements,  the ‘\$’ character and digits are handled in a special manner when they appear as the 
first character of a JSON key. Following are examples of two such occurrences. Note the addition of the 
`_JsonReader_PS_` and `_JsonReader_PD_` prefixes in place of the ‘\$’ and digit characters, respectively.

JSON:

``` json
{"$key":1234}
```

XML:

``` xml
<jsonObject>
    <_JsonReader_PS_key>1234</_JsonReader_PS_key>
</jsonObject>
```

JSON:

``` json
{"32X32":"image_32x32.png"}
```

XML:

``` xml
<jsonObject>
    <_JsonReader_PD_32X32>image_32x32.png</_JsonReader_PD_32X32>
</jsonObject>
```

### Converting a payload between XML and JSON

To convert an XML payload to JSON, set the `messageType` property to `application/json` in the axis2 scope before 
sending message to an endpoint. Similarly, to convert a JSON payload to XML, set the `messageType` property to 
`application/xml` or `text/xml`. For example:

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<api name="admin--TOJSON" context="/tojson" version="1.0" version-type="url">
    <resource methods="POST GET DELETE OPTIONS PUT" url-mapping="/*">
        <inSequence>
            <property name="POST_TO_URI" value="true" scope="axis2" />
            <property name="messageType" value="application/json" scope="axis2" />
            <filter source="$ctx:AM_KEY_TYPE" regex="PRODUCTION">
                <then>
                    <send>
                        <endpoint name="admin--Test_APIproductionEndpoint_0">
                            <http uri-template="http://localhost:9767/services/StudentService">
                                <timeout>
                                    <duration>30000</duration>
                                    <responseAction>fault</responseAction>
                                </timeout>
                                <suspendOnFailure>
                                    <errorCodes>-1</errorCodes>
                                    <initialDuration>0</initialDuration>
                                    <progressionFactor>1.0</progressionFactor>
                                    <maximumDuration>0</maximumDuration>
                                </suspendOnFailure>
                                <markForSuspension>
                                    <errorCodes>-1</errorCodes>
                                </markForSuspension>
                            </http>
                        </endpoint>
                    </send>
                </then>
                <else>
                    <sequence key="_sandbox_key_error_" />
                </else>
            </filter>
        </inSequence>
        <outSequence>
            <send />
        </outSequence>
    </resource>
    <handlers>
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler" />
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.throttling.APIThrottleHandler">
            <property name="id" value="A" />
            <property name="policyKey" value="gov:/apimgt/applicationdata/tiers.xml" />
        </handler>
        <handler class="org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageHandler" />
        <handler class="org.wso2.carbon.apimgt.usage.publisher.APIMgtGoogleAnalyticsTrackingHandler" />
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler" />
    </handlers>
</api>
```

An example command to invoke above API:

``` bash
curl -v -X POST -H "Content-Type:application/xml" -H "Authorization: Bearer xxx" -d@request1.xml "http://10.100.1.110:8280/tojson/1.0"
```

If the request payload is as follows:

```  xml
<?xml version="1.0" encoding="UTF-8"?>
<coordinates>
    <location>
        <name>Bermuda Triangle</name>
        <n>25.0000</n>
        <w>71.0000</w>
    </location>
    <location>
        <name>Eiffel Tower</name>
        <n>48.8582</n>
        <e>2.2945</e>
    </location>
</coordinates>
```

The response payload will look like this:

``` json
{ 
    "coordinates":{ 
        "location":[ 
            { 
                "name":"Bermuda Triangle",
                "n":25.0000,
                "w":71.0000
            },
            { 
                "name":"Eiffel Tower",
                "n":48.8582,
                "e":2.2945
            }
        ]
    }
}
```

Note that we have used the Property mediator to mark the outgoing payload to be formatted as JSON. For more information 
about the Property Mediator, see the 
[Property Mediator](https://ei.docs.wso2.com/en/latest/micro-integrator/references/mediators/property-Mediator/) page 
on WSO2 EI documentation.

``` xml
<property name="messageType" value="application/json" scope="axis2"/>
```

Similarly if the response message needs to be transformed, set the messageType property in the outSequence.

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<api name="admin--TOJSON" context="/tojson" version="1.0" version-type="url">
    <resource methods="POST GET DELETE OPTIONS PUT" url-mapping="/*">
        <inSequence>
            <property name="POST_TO_URI" value="true" scope="axis2" />
            <filter source="$ctx:AM_KEY_TYPE" regex="PRODUCTION">
                <then>
                    <send>
                        <endpoint name="admin--Test_APIproductionEndpoint_0">
                            <http uri-template="http://localhost:9767/services/StudentService">
                                <timeout>
                                    <duration>30000</duration>
                                    <responseAction>fault</responseAction>
                                </timeout>
                                <suspendOnFailure>
                                    <errorCodes>-1</errorCodes>
                                    <initialDuration>0</initialDuration>
                                    <progressionFactor>1.0</progressionFactor>
                                    <maximumDuration>0</maximumDuration>
                                </suspendOnFailure>
                                <markForSuspension>
                                    <errorCodes>-1</errorCodes>
                                </markForSuspension>
                            </http>
                        </endpoint>
                    </send>
                </then>
                <else>
                    <sequence key="_sandbox_key_error_" />
                </else>
            </filter>
        </inSequence>
        <outSequence>
            <property name="messageType" value="application/json" scope="axis2" />
            <send />
        </outSequence>
    </resource>
    <handlers>
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler" />
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.throttling.APIThrottleHandler">
            <property name="id" value="A" />
            <property name="policyKey" value="gov:/apimgt/applicationdata/tiers.xml" />
        </handler>
        <handler class="org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageHandler" />
        <handler class="org.wso2.carbon.apimgt.usage.publisher.APIMgtGoogleAnalyticsTrackingHandler" />
        <handler class="org.wso2.carbon.apimgt.gateway.handlers.ext.APIManagerExtensionHandler" />
    </handlers>
</api>
```

!!! info
    **XML to JSON Transformation Parameters**  
    See [JSON Transformation Parameters](https://ei.docs.wso2.com/en/latest/micro-integrator/use-cases/examples/json_examples/json-examples/#xml-to-json-transformation-parameters) 
    for additional parameters for converting XML to JSON.



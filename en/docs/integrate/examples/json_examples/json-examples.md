# Working with JSON Message Payloads

WSO2 Micro Integrator provides support for [JavaScript Object Notation (JSON)](http://www.json.org/) payloads in messages. The following sections describe how to work with JSON via the Micro Integrator.

## Handling JSON to XML conversion

When building the XML tree, JSON builders attach the converted XML infoset to a special XML element that acts as the root element of the
final XML tree. If the original JSON payload is of type `object` , the special element is `<jsonObject/>`. If it is an `array`, the special element is `<jsonArray/>`. Following are examples of JSON and XML representations of various objects and arrays.

### Empty objects

``` javascript tab='JSON'
{"object":{}}
```

``` html tab='XML'
<jsonObject>
  <object></object>
</jsonObject>
```

### Empty strings

``` javascript tab='JSON'
{"object":""}
```

``` html tab='XML'
<jsonObject>
  <object></object>
</jsonObject>
```

### Empty array

``` javascript tab='JSON'
[]
```

``` html tab='XML (JsonStreamBuilder)'
<jsonArray></jsonArray>
```

``` html tab='XML (JsonBuilder)'
<jsonArray>
  <?xml-multiple jsonElement?>
</jsonArray>
```

### Named arrays

``` javascript tab='JSON'
{"array":[1,2]}
```

``` html tab='XML (JsonStreamBuilder)'
<jsonObject>
  <array>1</array>
  <array>2</array>
</jsonObject>
```

``` html tab='XML (JsonBuilder)'
<jsonObject>
  <?xml-multiple array?>
  <array>1</array>
  <array>2</array>
</jsonObject>
```

``` javascript tab='JSON'
{"array":[]}
```

``` html tab='XML (JsonStreamBuilder)'
<jsonObject></jsonObject>
```

``` html tab='XML (JsonBuilder)'
<jsonObject>
  <?xml-multiple array?>
</jsonObject>
```

### Anonymous arrays

``` javascript tab='JSON'
[1,2]
```

``` html tab='XML (JsonStreamBuilder)'
<jsonArray>
   <jsonElement>1</jsonElement>
   <jsonElement>2</jsonElement>
</jsonArray>
```

``` html tab='XML (JsonBuilder)'
<jsonArray>
  <?xml-multiple jsonElement?>
  <jsonElement>1</jsonElement>
  <jsonElement>2</jsonElement>
</jsonArray>
```

``` javascript tab='JSON'
[1, []]
```

``` html tab='XML (JsonStreamBuilder)'
<jsonArray>
  <jsonElement>1</jsonElement>
  <jsonElement>
     <jsonArray></jsonArray>
  </jsonElement>
</jsonArray>
```

``` html tab='XML (JsonBuilder)'
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

## XML processing instructions (PIs)

Note the addition of `xml-multiple` processing instructions to the XML payloads whose JSON representations contain arrays. `JsonBuilder` (via StAXON) adds these instructions to the XML payload that it builds during the JSON to XML conversion so that during the XML to JSON conversion, `JsonFormatter` can reconstruct the arrays that are present in the original JSON payload. `JsonFormatter` interprets the elements immediately following a processing instruction to construct an array.

## Special characters

When building XML elements, the EI handles the `$` character and digits in a special manner when they appear as the first character of a JSON key. Following are examples of two such occurrences. Note the addition of the `_JsonReader_PS_` and `_JsonReader_PD_` prefixes in place of the `$` and digit characters, respectively.

``` javascript tab='JSON'
{"$key":1234}
```

``` html tab='XML'
<jsonObject>
  <_JsonReader_PS_key>1234</_JsonReader_PS_key>
</jsonObject>
```

``` javascript tab='JSON'
{"32X32":"image_32x32.png"}
```

``` html tab='XML'
<jsonObject>
  <_JsonReader_PD_32X32>image_32x32.png</_JsonReader_PD_32X32>
</jsonObject>
```

## Converting spaces

Although you can have spaces in JSON elements, [you cannot have them when converted to XML](https://www.w3.org/TR/REC-xml/#sec-common-syn). Therefore, you can handle spaces when converting JSON message payloads to XML, by adding the following property to the `MI_HOME/conf/deployment.toml` file in the `[mediation]` section:
`synapse.build_valid_nc_name`

For example, consider the following JSON message:

```json
{
  "abc def" : "this is a sample value"
}
```

The output converted to XML is as follows:

```xml
<abc_jsonreader_32_def>this is a sample value</abc_jsonreader_32_def> 
```

!!! Tip
    The value 32 represents the standard char value of the space. This works other way around as well. When you need to convert XML to JSON, with a JSON element that needs to have a space within it. Then, you use " `         _JsonReader_32_        ` " in the XML element, to get the space in the JSON output. For example, if you consider the following XML payload;

    `<abc_jsonreader_32_def>this is a sample value</abc_jsonreader_32_def>`

    The JSON output will be as follows:

    `{ "abc def" : "this is a sample value"}`

## Handling XML to JSON conversion

When an XML element is converted to JSON, the following rules apply:

### Empty XML elements

Consider the following empty XML elements:

``` html tab='Example 1'
<jsonObject>
  <object></object>
</jsonObject>
```

``` html tab='Example 2'
<jsonObject>
  <object/>
</jsonObject>
```

By default, empty XML elements convert to JSON as null objects as shown below.

``` java
{"object":null}
```

JSON representation of empty XML element will change as below by adding `'synapse.commons.enableXmlNullForEmptyElement' = false` under `[synapse_properties]` section in `MI_HOME/conf/deployment.toml` file.

``` javascript
{"object":""}
```

!!! Info
    `'synapse.commons.enableXmlNullForEmptyElement` property surrounded with single quotation to identify it as whole string rather dot separated toml object.

### Empty XML elements with the 'nil' attribute

Consider the following XML element that has the 'nil' attribute set to true.

```
<jsonObject>
  <object nil=true></object>
</jsonObject>
```

By default, the above XML element converts to JSON as shown below.

``` javascript
{"object":{"@nil":"true"}}
```

If you set the `synapse.enable_xml_nil=true` property in the `deployment.toml` file `[mediation]` section (stored in the `MI_HOME/conf/` directory), XML elements where the 'nil' attribue is set to true will be represented in JSON as null objects as shown below.

``` javascript
{"object":null}
```

### Converting a payload between XML and JSON

To convert an XML payload to JSON, set the `messageType` property to `application/json` in the axis2 scope before sending message to an endpoint. Similarly, to convert a JSON payload to XML, set the `messageType` property to `application/xml` or `text/xml`. For example:

```
<proxy xmlns="http://ws.apache.org/ns/synapse"
          name="tojson"
          transports="https,http"
          statistics="disable"
          trace="disable"
          startOnLoad="true">
  <target>
    <inSequence>
       <property name="messageType" value="application/json" scope="axis2"/>
       <respond/>
    </inSequence>
  </target>
  <description/>
</proxy>
```
If the request payload is as follows:

```
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

Save the payload in request.xml file and use the following command to invoke this proxy service:

```bash
curl -v -X POST -H "Content-Type:application/xml" -d@request.xml "http://localhost:8290/services/tojson"
```

The response payload will look like this:

``` javascript
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

Note that we have used the [Property mediator]({{base_path}}/reference/mediators/property-mediator) to mark the outgoing payload to be formatted as JSON:

```
<property name="messageType" value="application/json" scope="axis2"/>
```

!!! Note
    JSON requests cannot be converted to XML if it contains invalid XML characters.

!!! Info
    If you need to convert complex XML responses (e.g., XML with with `         xsi:type        ` values), you will need to set the message type using the [Property mediator]({{base_path}}/reference/mediators/property-mediator) as follows:
    `<property name="messageType" value="application/json/badgerfish" scope="axis2" type="STRING"/>`
    You will also need to ensure you register the following message builder and formatter as specified in [Message Builders and Formatters](https://ei.docs.wso2.com/en/latest/micro-integrator/setup/message_builders_formatters/message-builders-and-formatters/).
    ```
    <messageBuilder contentType="text/javascript" class="org.apache.axis2.json.JSONBadgerfishOMBuilder"/>
    <messageFormatter contentType="text/javascript" class="org.apache.axis2.json.JSONBadgerfishMessageFormatter"/> 
    ```
    
### Accessing content from JSON payloads

There are two ways to access the content of a JSON payload within the MI.

-   JSONPath expressions (with `json-eval()` method)
-   XPath expressions

JSONPath allows you to access fields of JSON payloads with faster
results and less processing overhead. Although it is possible to
evaluate XPath expressions on JSON payloads by assuming the XML
representation of the JSON payload, we recommend that you use JSONPath
to query JSON payloads. It is also possible to evaluate both JSONPath
and XPath expressions on a payload (XML/JSON) at the same time.

You can use JSON path expressions with following mediators:

<table>
<thead>
<tr class="header">
<th>Mediator</th>
<th>Usage</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="{{base_path}}/reference/mediators/log-mediator/">Log</a></td>
<td><div class="content-wrapper">
<p>As a log property:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="html/xml" data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"><code>&lt;log&gt;
    &lt;property name=&quot;location&quot; 
              expression=&quot;json-eval($.coordinates.location[0].name)&quot;/&gt;
&lt;/log&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td><a href="{{base_path}}/reference/mediators/property-mediator/">Property</a></td>
<td><div class="content-wrapper">
<p>As a standalone property:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="html/xml" data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"><code>&lt;property name=&quot;location&quot; 
              expression=&quot;json-eval($.coordinates.location[0].name)&quot;/&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td><a href="{{base_path}}/reference/mediators/payloadfactory-mediator/">PayloadFactory</a></td>
<td><div class="content-wrapper">
<p>As the payload arguments:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="html/xml" data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"><code>&lt;payloadFactory media-type=&quot;json&quot;&gt;
    &lt;format&gt;{&quot;RESPONSE&quot;:&quot;$1&quot;}&lt;/format&gt;
    &lt;args&gt;
        &lt;arg evaluator=&quot;json&quot; expression=&quot;$.coordinates.location[0].name&quot;/&gt;
    &lt;/args&gt;
&lt;/payloadFactory&gt;</code></pre>
</div>
</div>
<p><strong>IMPORTANT</strong> : You MUST omit the <code>               json-eval()              </code> method within the payload arguments to evaluate JSON paths within the PayloadFactory mediator. Instead, you MUST select the correct expression evaluator ( <code>               xml              </code> or <code>               json              </code> ) for a given argument.</p>
</div></td>
</tr>
<tr class="even">
<td><a href="{{base_path}}/reference/mediators/switch-mediator/">Switch</a></td>
<td><div class="content-wrapper">
<p>As the switch source:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="html/xml" data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"><code>&lt;switch source=&quot;json-eval($.coordinates.location[0].name)&quot;&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td><a href="{{base_path}}/reference/mediators/filter-mediator/">Filter</a></td>
<td><div class="content-wrapper">
<p>As the filter source:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="html/xml" data-syntaxhighlighter-params="brush: html/xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: html/xml; gutter: false; theme: Confluence"><code>&lt;filter source=&quot;json-eval($.coordinates.location[0].name)&quot; 
        regex=&quot;Eiffel.*&quot;&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
</tbody>
</table>

#### JSON path syntax

Suppose we have the following payload:

```
{ 
  "id": 12345,
  "id_str": "12345",
  "array": [ 1, 2, [ [], [{"inner_id": 6789}] ] ],
  "name": null,
  "object": {},
  "$schema_location": "unknown",
  "12X12": "image12x12.png"
}
```

The following table summarizes sample JSONPath expressions and their outputs:

<table>
<thead>
<tr class="header">
<th>Expression</th>
<th>Result</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>$.</code></pre></td>
<td><pre><code>{ &quot;id&quot;:12345, &quot;id_str&quot;:&quot;12345&quot;, &quot;array&quot;:[1, 2, [[],[{&quot;inner_id&quot;:6789}]]], &quot;name&quot;:null, &quot;object&quot;:{}, &quot;$schema_location&quot;:&quot;unknown&quot;, &quot;12X12&quot;:&quot;image12x12.png&quot;}</code></pre></td>
</tr>
<tr class="even">
<td><pre><code>$.id</code></pre></td>
<td><pre><code>12345</code></pre></td>
</tr>
<tr class="odd">
<td><pre><code>$.name</code></pre></td>
<td><pre><code>null</code></pre></td>
</tr>
<tr class="even">
<td><pre><code>$.object</code></pre></td>
<td><pre><code>{}</code></pre></td>
</tr>
<tr class="odd">
<td><pre><code>$.[&#39;$schema_location&#39;]</code></pre></td>
<td><pre><code>unknown</code></pre></td>
</tr>
<tr class="even">
<td><pre><code>$.12X12</code></pre></td>
<td><pre><code>image12x12.png</code></pre></td>
</tr>
<tr class="odd">
<td><pre><code>$.array</code></pre></td>
<td><pre><code>[1, 2, [[],[{&quot;inner_id&quot;:6789}]]]</code></pre></td>
</tr>
<tr class="even">
<td><pre><code>$.array[2][1][0].inner_id</code></pre></td>
<td><pre><code>6789</code></pre></td>
</tr>
</tbody>
</table>

We can also evaluate a JSONPath expression against a property that contains a JSON payload.

To evaluate a JSONPath expression against a  property, use the following syntax.

```json
json-eval(<scope_of_the_property>:<property_name>.<JSONPath_expression>)
```

Example 1: When the property is in the synapse message context.

```json
json-eval($ctx:propertyName.student.name)
```

Example 2: When the property is in the axis2 message context.

```json
json-eval($axis2:propertyName.student.name)
```

Example 3: When the property is in the transport scope.

```json
json-eval($trp:propertyName.student.name)
```

Learn more about [JSONPath syntax](http://goessner.net/articles/JsonPath/).

### Logging JSON payloads

To log JSON payloads as JSON, use the [Log
mediator]({{base_path}}/reference/mediators/log-mediator) as shown
below. The `         json-eval()        ` method returns the
`         java.lang.String        ` representation of the existing JSON
payload.

```
<log>
  <property name="JSON-Payload" expression="json-eval($.)"/>
</log>
```

To log JSON payloads as XML, use the Log mediator as shown below:

```
<log level="full"/>
```

For more information on logging, see [Troubleshooting, debugging, and logging]({{base_path}}/integrate/examples/json_examples/json-examples/#validating-json-messages) below.

### Constructing and transforming JSON payloads

To construct and transform JSON payloads, you can use the PayloadFactory
mediator or Script mediator as described in the rest of this section.

#### PayloadFactory mediator

The [PayloadFactory mediator]({{base_path}}/reference/mediators/payloadfactory-mediator) provides the simplest way to work with JSON payloads. Suppose we have a service that returns the following response for a search query:

``` javascript
{
       "geometry":{
          "location":{
             "lat":-33.867260,
             "lng":151.1958130
          }
       },
       "icon":"bar-71.png",
       "id":"7eaf7",
       "name":"Biaggio Cafe",
       "opening_hours":{
          "open_now":true
       },
       "photos":[
          {
             "height":600,
             "html_attributions":[
             ],
             "photo_reference":"CoQBegAAAI",
             "width":900
          }
       ],
       "price_level":1,
       "reference":"CnRqAAAAtz",
       "types":[
          "bar",
          "restaurant",
          "food",
          "establishment"
       ],
       "vicinity":"48 Pirrama Road, Pyrmont"
}
```

We can create a proxy service that consumes the above response and creates a new response containing the location name and tags associated with the location based on several fields from the above response.

```
<proxy xmlns="http://ws.apache.org/ns/synapse"
         name="singleresponse"
         transports="https,http"
         statistics="disable"
         trace="disable"
         startOnLoad="true">
         <target>
             <inSequence>
                 <payloadFactory media-type="json">
                     <format>{
                                 "location_response" : {
                                     "name" : "$1",
                                     "tags" : "$2"
                             }}
                     </format>
                     <args>
                         <arg evaluator="json" expression="$.name"/>
                         <arg evaluator="json" expression="$.types"/>
                     </args>
                 </payloadFactory>
                 <respond/>
             </inSequence>
         </target>
     <description/>
</proxy>
```

Save the above payload in request.json file and use the following command to invoke this service:

``` bash
curl -v POST -H "Content-Type:application/json" -d@request.json "http://localhost:8290/services/singleresponse"
```

The response payload would look like this:

``` javascript
{
    "location_response":{
      "name":"Biaggio Cafe",
      "tags":["bar", "restaurant", "food", "establishment"]
    }
}
```

Note the following aspects of the proxy service configuration:

-   We use the `          payloadFactory         ` mediator to construct the new JSON payload.
-   The `          media-type         ` attribute is set to `          json         ` .
-   Because JSONPath expressions are used in arguments, the `          json         ` evaluators are specified.

##### Configuring the payload format

The `<format>` section of the proxy service
configuration defines the format of the response. Notice that in the
example above, the name and tags field values are enclosed by double
quotes ("), which creates a string value in the final response. If you
do not use quotes, the value that gets assigned uses the real type
evaluated by the expression (boolean, number, object, array, or null).

It is also possible to instruct the PayloadFactory mediator to load a
payload format definition from the registry. This approach is
particularly useful when using large/complex payload formats in the
definitions. To load a format from the registry, click **Pick From
Registry** instead of **Define inline** when defining the PayloadFactory
mediator.

For example, suppose we have saved the following text content in the
following registry location:
`         conf:/repository/MI/transform.txt        ` .

```
{
    "location_response" : {
        "name" : "$1",
        "tags" : "$2"
    }
}
```

We can now modify the definition of the PayloadFactory mediator to use
this format text saved as a registry resource as the payload format. The
new configuration would look as follows (note that the
`         <format>        ` element now uses the key attribute to point
to the registry resource key):

```
<payloadFactory media-type="json">
  <format key="conf:/repository/MI/transform.txt"/>
  ... 
</payloadFactory>
```

!!! Note
    When saving format text for the PayloadFactory mediator as a registry resource, be sure to save it as text content with the “text/plain” media type.

#### Script mediator

The [Script mediator]({{base_path}}/reference/mediators/script-mediator) in
JavaScript is useful when you need to create payloads that have
recurring structures such as arrays of objects. The Script mediator
defines the following important methods that can be used to manipulate
payloads in many different ways:

-   `getPayloadJSON`
-   `          setPayloadJSON         `
-   `          getPayloadXML         `
-   `          setPayloadXML         `

By combining any of the setters with a getter, we can handle almost any
type of content transformation within the MI. For example, by combining
`         getPayloadXML        ` and `         setPayloadJSON        ` ,
we can easily implement an XML to JSON transformation scenario. In
addition, we can perform various operations (such as deleting individual
keys, modifying selected values, and inserting new objects) on JSON
payloads to transform from one JSON format to another JSON format by
using the `         getPayloadJSON        ` and
`         setPayloadJSON        ` methods. 

!!! Note
    If you are using **nashornJS** as the JavaScript language, and also if you have JSON operations defined in the Script mediator, you need to have JDK version `8u112` or a later version in your environment.
    If your environment has an older JDK version, the Script mediator (that uses nashornJS and JSON operations) will not function properly because of this [JDK bug](https://bugs.openjdk.java.net/browse/JDK-8157160). That is, you will encounter server exceptions in the Micro Integrator.

**Example**

Following is an example of a JSON to JSON transformation performed by the Script mediator. Suppose a second service returns the following response:

```
{
    "results" : [
          {
             "geometry" : {
                "location" : {
                   "lat" : -33.867260,
                   "lng" : 151.1958130
                }
             },
             "icon" : "bar-71.png",
             "id" : "7eaf7",
             "name" : "Biaggio Cafe",
             "opening_hours" : {
                "open_now" : true
             },
             "photos" : [
                {
                   "height" : 600,
                   "html_attributions" : [],
                   "photo_reference" : "CoQBegAAAI",
                   "width" : 900
                }
             ],
             "price_level" : 1,
             "reference" : "CnRqAAAAtz",
             "types" : [ "bar", "restaurant", "food", "establishment" ],
             "vicinity" : "48 Pirrama Road, Pyrmont"
          },
          {
             "geometry" : {
                "location" : {
                   "lat" : -33.8668040,
                   "lng" : 151.1955790
                }
             },
             "icon" : "generic_business-71.png",
             "id" : "3ef98",
             "name" : "Doltone House",
             "photos" : [
                {
                   "height" : 600,
                   "html_attributions" : [],
                   "photo_reference" : "CqQBmgAAAL",
                   "width" : 900
                }
             ],
             "reference" : "CnRrAAAAV",
             "types" : [ "food", "establishment" ],
             "vicinity" : "48 Pirrama Road, Pyrmont"
          }
       ],
       "status" : "OK"
}
```

The following proxy service shows how we can transform the above
response using JavaScript with the Script mediator.

```
<proxy xmlns="http://ws.apache.org/ns/synapse"
           name="locations"
           transports="https,http"
           statistics="disable"
           trace="disable"
           startOnLoad="true">
       <target>
          <inSequence>
             <script language="js"
                     key="conf:/repository/MI/transform.js"
                     function="transform"/>
             <respond/>
          </inSequence>
       </target>
       <description/>
</proxy>
```

The registry resource `         transform.js        ` contains the
JavaScript function that performs the transformation:

```
function transform(mc) {
        payload = mc.getPayloadJSON();
        results = payload.results;
        var response = new Array();
        for (i = 0; i < results.length; ++i) {
            location_object = results[i];
            l = new Object();
            l.name = location_object.name;
            l.tags = location_object.types;
            l.id = "ID:" + (location_object.id);
            response[i] = l;
        }
        mc.setPayloadJSON(response);
}
```

`         mc.getPayloadJSON()        ` returns the current JSON payload
as a JavaScript object. This object can be manipulated as a normal
JavaScript variable within a script as shown in the above JavaScript
code. The `         mc.setPayloadJSON()        ` method can be used to
replace the existing payload with a new payload. In the above script, we
build a new array object by using the fields of the incoming JSON
payload and set that array object as the new payload (see the response
payload returned by the final proxy service below.)  
  
Save the above payload in request.json file and use the following command to invoke the proxy service:

``` bash
curl -v POST -H "Content-Type:application/json" -d@request.json "http://localhost:8290/services/locations"
```

The response payload would look like this:

``` javascript
[
        {
            "id":"ID:7eaf7", 
            "tags":["bar", "restaurant", "food", "establishment"], 
            "name":"Biaggio Cafe"
        }, 
        {
           "id":"ID:3ef98", 
           "tags":["food", "establishment"], 
           "name":"Doltone House"
        }
]
```

If you want to get the response in XML instead of JSON, you would modify
the service by adding the Property mediator as follows:

```
<inSequence>
    <script language="js" 
                key="conf:/repository/MI/transform.js" 
                function="transform"/>
    <property name="messageType" value="application/xml" scope="axis2"/>
    <respond/>
</inSequence>
```

The response will then look like this:

```
<jsonArray>
       <jsonElement>
          <id>ID:7eaf7</id>
          <tags>bar</tags>
          <tags>restaurant</tags>
          <tags>food</tags>
          <tags>establishment</tags>
          <name>Biaggio Cafe</name>
       </jsonElement>
       <jsonElement>
          <id>ID:3ef98</id>
          <tags>food</tags>
          <tags>establishment</tags>
          <name>Doltone House</name>
       </jsonElement>
</jsonArray>
```

If you are not getting the results you want when the Script mediator
converts the JSON payload directly into XML, you can build the XML
payload iteratively with the Script mediator as shown in the following
script.

``` javascript
function transformXML(mc) {
        payload = mc.getPayloadJSON();
        results = payload.results;
        var response = <locations/>;
        for (i = 0; i < results.length; ++i) {
            var elem = results[i];
            response.locations += <location>
                <id>{elem.id}</id>
                <name>{elem.name}</name>
                <tags>{elem.types}</tags>
            </location>
        }
        mc.setPayloadXML(response);
}
```

The response would now look like this:

```
<locations>
       <location>
          <id>7eaf7</id>
          <name>Biaggio Cafe</name>
          <tags>bar,restaurant,food,establishment</tags>
       </location>
       <location>
          <id>3ef98</id>
          <name>Doltone House</name>
          <tags>food,establishment</tags>
       </location>
</locations>
```

Finally, let's look at how you can perform delete, modify, and add field
operations on JSON payloads with the Script mediator in JavaScript.
Let's send the JSON message returned by the `         locations        `
proxy service as the request for the following proxy service,
`         transformjson        ` :

```
<proxy xmlns="http://ws.apache.org/ns/synapse"
           name="transformjson"
           transports="https,http"
           statistics="disable"
           trace="disable"
           startOnLoad="true">
       <target>
          <inSequence>
             <script language="js">
               payload = mc.getPayloadJSON();
               for (i = 0; i &lt; payload.length; ++i) {
                   payload[i].id_str = payload[i].id;
                   delete payload[i].id;
                   payload[i].tags[payload[i].tags.length] = "pub";
               }
               mc.setPayloadJSON(payload);
             </script>
             <log>
                <property name="JSON-Payload" expression="json-eval($.)"/>
             </log>
             <respond/>
          </inSequence>
       </target>
       <description/>
</proxy>
```

The proxy service will convert the request into the following format:

``` javascript
[
       {
          "name":"Biaggio Cafe",
          "tags":["bar", "restaurant", "food", "establishment", "pub"],
          "id_str":"ID:7eaf7"
       },
       {
          "name":"Doltone House",
          "tags":["food", "establishment", "pub"],
          "id_str":"ID:3ef98"
       }
]
```

Note that the transformation (line 9 through 17) has added a new field
`         id_str        ` and removed the old field
`         id        ` from the request, and it has added a new tag
`         pub        ` to the existing tags list of the payload.

<!--
For additional examples that demonstrate different ways to manipulate
JSON payloads within the MI mediation flow, see the following samples:

-   [Sample 440: Converting JSON to XML Using
    XSLT](https://docs.wso2.com/display/ESB500/Sample+440%3A+Converting+JSON+to+XML+Using+XSLT)
-   [Sample 441: Converting JSON to XML Using
    JavaScript](https://docs.wso2.com/display/ESB500/Sample+441%3A+Converting+JSON+to+XML+Using+JavaScript)
-->

### XML to JSON transformation parameters

You can use XML to JSON transformation parameters when you need
to transform XML formatted data into the JSON format.

Following are the XML to JSON transformation parameters and their
descriptions:

<table>
<thead>
<tr class="header">
<th><p>Parameter</p></th>
<th><p>Description</p></th>
<th>Default Value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>              synapse.commons.json.preserve.namespace             </code></p></td>
<td><p>Preserves the namespace declarations in the JSON output in XML to JSON transformations.</p></td>
<td><code>             false            </code></td>
</tr>
<tr class="even">
<td><p><code>              synapse.commons.json.buildValidNCNames             </code></p></td>
<td><p>Builds valid XML NCNames when building XML element names in XML to JSON transformations.</p></td>
<td><code>             false            </code></td>
</tr>
<tr class="odd">
<td><p><code>              synapse.commons.json.output.autoPrimitive             </code></p></td>
<td><p>Allows primitive types in the JSON output in XML to JSON transformations.</p></td>
<td><code>             true            </code></td>
</tr>
<tr class="even">
<td><p><code>              synapse.commons.json.output.namespaceSepChar             </code></p></td>
<td><p>The namespace prefix separation character for the JSON output in XML to JSON transformations.</p></td>
<td>The default separation character is <code>             -            </code></td>
</tr>
<tr class="odd">
<td><p><code>              synapse.commons.json.output.enableNSDeclarations             </code></p></td>
<td><p>Adds XML namespace declarations in the JSON output in XML to JSON transformations.</p></td>
<td><code>             false            </code></td>
</tr>
<tr class="even">
<td><p><code>              synapse.commons.json.output.disableAutoPrimitive.regex             </code></p></td>
<td><p>Disables auto primitive conversion in XML to JSON transformations.</p></td>
<td>null</td>
</tr>
<tr class="odd">
<td><p><code>              synapse.commons.json.output.jsonoutAutoArray             </code></p></td>
<td><p>Sets the JSON output to an array element in XML to JSON transformations.</p></td>
<td><code>             true            </code></td>
</tr>
<tr class="even">
<td><p><code>              synapse.commons.json.output.jsonoutMultiplePI             </code></p></td>
<td><p>Sets the JSON output to an xml multiple processing instruction in XML to JSON transformations.</p></td>
<td><code>             true            </code></td>
</tr>
<tr class="odd">
<td><p><code>              synapse.commons.json.output.xmloutAutoArray             </code></p></td>
<td><p>Sets the XML output to an array element in XML to JSON transformations.</p></td>
<td><code>             true            </code></td>
</tr>
<tr class="even">
<td><p><code>              synapse.commons.json.output.xmloutMultiplePI             </code></p></td>
<td><p>Sets the XML output to an xml multiple processing instruction in XML to JSON transformations.</p></td>
<td><code>             false            </code></td>
</tr>
<tr class="odd">
<td><code>             synapse.commons.enableXmlNilReadWrite            </code></td>
<td>Handles how <a href="#WorkingwithJSONMessagePayloads-EmptyXMLelementswiththe&#39;nil&#39;attribute">empty XML elements with the 'nil' attribute</a> are converted to JSON.</td>
<td><code>             false            </code></td>
</tr>
<tr class="even">
<td><pre><code>synapse.commons.enableXmlNullForEmptyElement</code></pre></td>
<td>Handles how <a href="#WorkingwithJSONMessagePayloads-EmptyXMLelements">empty XML elements</a> are converted to JSON.</td>
<td><code>             true            </code></td>
</tr>
</tbody>
</table>

### Validating JSON messages

You can use the [Validate mediator]({{base_path}}/reference/mediators/validate-mediator)
to validate JSON messages against a specified JSON schema as described
in the rest of this section.

#### Validate mediator

The parameters available in this section are as follows.

| Parameter Name                                | Description                                                                                                                                                              |
|-----------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Schema keys defined for Validate Mediator** | This section is used to specify the key to access the main schema based on which validation is carried out, as well as to specify the JSON, which needs to be validated. |
| **Source**                                    | The JSONPath expression to extract the JSON that needs to be validated. E.g: `             json-eval($.msg)"            `                                                |

Following example use the below sample schema
`         StockQuoteSchema.json        ` file. Add this sample schema
file (i.e. `         StockQuoteSchema.json        ` ) to the following
Registry path:
`                   conf:/schema/StockQuoteSchema                  .        `
json. For instructions on adding the schema file to the Registry path,
see [Adding a Resource]({{base_path}}/integrate/develop/creating-artifacts/registry/creating-local-registry-entries).

!!! Tip
    When adding this sample schema file to the Registry, specify the **Media Type** as application/json.

```
{
  "$schema": "http://json-schema.org/draft-04/schema#",
      "type": "object",
      "properties": {
        "getQuote": {
          "type": "object",
          "properties": {
            "request": {
              "type": "object",
              "properties": {
                "symbol": {
                  "type": "string"
                }
              },
              "required": [
                "symbol"
              ]
            }
          },
          "required": [
            "request"
          ]
        }
      },
      "required": [
        "getQuote"
      ]
}   
```

In this example, the required schema for validating messages going through the Validate mediator is given as a registry key (i.e.
`         schema\StockQuoteSchema.json        ` ). You do not have any source attributes specified. Therefore, the schema will be used to validate the complete JSON body. The mediation logic to follow if the validation fails is defined within the on-fail element. In this example, the [PayloadFactory mediator]({{base_path}}/reference/mediators/payloadfactory-mediator) creates a fault to be sent back to the party, which sends the message.

```
<validate>
  <schema key="conf:/schema/StockQuoteSchema.json"/>
    <on-fail>
            <payloadFactory media-type="json">
                <format>{"Error":"$1"}</format>
                <args>
                    <arg evaluator="xml" expression="$ctx:ERROR_MESSAGE"/>
                </args>
            </payloadFactory>
            <property name="HTTP_SC" value="500" scope="axis2"/>
            <respond/>
    </on-fail>
</validate>
```

An example for a valid JSON payload request is given below.

```
{
  "getQuote": {
   "request": {
      "symbol": "WSO2"
    }
  }
}
```

## Troubleshooting, debugging, and logging

To assist with troubleshooting, you can enable debug logging at several stages of the mediation of a JSON payload by adding one or more of the following loggers to the `MI_HOME/conf/log4j2.properties` file and restarting the MI.

!!! Info
    Be sure to turn off these loggers when running the MI in a production environment, as logging every message will significantly reduce performance.

Following are the available logger components:

Message builders and formatters

- `org.apache.synapse.commons.json.JsonStreamBuilder`
- `org.apache.synapse.commons.json.JsonStreamFormatter`
- `org.apache.synapse.commons.json.JsonBuilder`
- `org.apache.synapse.commons.json.JsonFormatter`

JSON utility class

`org.apache.synapse.commons.json.JsonUtil`

PayloadFactory mediator

`org.apache.synapse.mediators.transform.PayloadFactoryMediator`

JSONPath evaluator

`org.apache.synapse.util.xpath.SynapseJsonPath`

Debug logging for the mediation of a JSON payload can be enabled by adding these loggers in log4j2.properties file.

For example:
```
 logger.JsonStreamBuilder.name = org.apache.synapse.commons.json.JsonStreamBuilder
 logger.JsonStreamBuilder.level = DEBUG
 ```
For more instructions on adding loggers, see [Configuring Log4j Properties]({{base_path}}/install-and-setup/setup/mi-setup/observability/logs/configuring_log4j_properties).

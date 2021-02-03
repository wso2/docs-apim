# JSON Transform Mediator

The **JSON Transform mediator** is used for controlling XML to JSON transformations (possibly with a JSON Schema)  inside a mediation. Normally XML to JSON transformations are controlled by the properties defined in `synapse.properties`. 

Those configurations are applied globally and you cannot have independent configurations for each mediation scenario. 
With JSON Transform mediator you can define the properties inside the mediation and control the transformation independently. 
Also you can have a JSON schema to correct the payload if there are inconsistencies in the transformation.

<img src="{{base_path}}/assets/img/integrate/mediators/json-transform-concept.png"/>

!!! Info
    The JSON Transform mediator is a [content aware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` java
<jsontransform [schema="string"]>
   <property name="string" value="string"/>*
</jsontransform>
```

## Configuration

The general parameters available for configuring the JSON Transform mediator are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Schema</strong></td>
<td><p>This parameter is used for specifying the registry location of the JSON schema file. You can specify a Local Entry as well</p>
</td>
</tr>
</tbody>
</table>

Apart from defining a schema, you can also add properties to control XML to JSON transformation. The parameters available for configuring a property are as follows:

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Schema</strong></td>
<td><p>The name of the property that needs to be overridden in the sequence. The <b>JSON Transform mediator</b> supports only the parameters related to XML to JSON conversion. The list of properties that are supported can be found <a href="{{base_path}}/integrate/examples/json_examples/json-examples/#xml-to-json-transformation-parameters">here</a>.</p>
</td>
</tr>
<tr class="even">
<td><strong>Property Value</strong></td>
<td><p>The value that should be overridden.</p>
</td>
</tr>
</tbody>
</table>

## Challenges when converting XML to JSON

### Converting an array of one from XML to JSON
   
Let's say we do a search and get the results in XML. We want the results to be converted to JSON array when returned to the client. A blind XML to JSON tranformation would look like this.
   
```xml
   <books>
    <book>Harry Potter</book>
    <book>Lord of the Rings</book>
   </books>
```

```json
    {"books" :  { "book" :  ["Harry Potter", "Lord of the Rings"]}}
```
   
Let's say we get only one result. The converted JSON would come out like below.
   
```xml
   <books>
    <book>Harry Potter</book>
   </books>
```

```json
   {"books" :  { "book" :  "Harry Potter"}}
```

Theoretically the above conversion is correct. However, a client might expect an array and not a string.

We can tackle the above issue with a JSON Schema and correct the output to be an JSON Array.

```json
   {
   	"$schema": "http://json-schema.org/draft-04/schema#",
   	"type": "object",
   	"properties": {
   		"books": {
   			"type": "object",
   			"properties": {
   				"book": {
   					"type": "array"
   				}
   			}
   		}
   	}
   }
```

### Losing data type information

Since we cannot differentiate between String, Numeric and Boolean in XML, when we do a conversion from XML to JSON, the data type of value might be not what we expected. 
Look at the following the example.

```xml
   <person>
    <id>56783</id>
    <name>Alice</name>
    <isAdmin>true</isAdmin>
   </person>
```
By default, the JSON output would look like below after the mediation.

```json
{
    "person": {
        "id": 56783,
        "name": "Alice",
        "isAdmin": true
    }
}
```

The field `id` has been converted to number, `name` to String and `isAdmin` to boolean. 

The runtime has automatically detected and parsed the values to native data-types. But there might be a scenario where the client expects a String type for `id`. 

We want the native conversion rules applied to `name` and `isAdmin` fields and not `id`.

With JSON Transform mediator, we can use a JSON schema to tackle this issue.

```json
{
	"$schema": "http://json-schema.org/draft-04/schema#",
	"type": "object",
	"properties": {
		"person": {
			"type": "object",
			"properties": {
				"id": {
					"type": "string"
				}
			}
		}
	}
}
```

With this schema correction, the JSON payload would come out as below. This gives granular level control over individual field datatypes rather than using a global property.

```json
{
    "person": {
        "id": "56783",
        "name": "Alice",
        "isAdmin": true
    }
}
```

## Example 

Given below is a sample schema file (Schema.json) file that you can use for running the examples given below. 
Add this sample schema file (i.e. Schema.json) to the following registry path: conf:/Schema.json. 
For instructions on adding the schema file to the Registry Resources Project, see [Creating Registry Resource]({{base_path}}/integrate/develop/creating-artifacts/creating-registry-resources).

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "fruit": {
      "type": "string",
      "minLength": 4,
      "maxLength": 6,
      "pattern": "^[0-9]{1,45}$"
    },
    "price": {
      "type": "number",
      "minimum": 2,
      "maximum": 20,
      "exclusiveMaximum": 20,
      "multipleOf": 2.5
    }
  },
  "required": [
    "price"
  ]
}
```

Use the following payload to test the examples:

```xml
<jsonObject>
    <fruit>12345</fruit>
    <price>7.5</price>
    <quantity>10</quantity>
</jsonObject>
```

### Example 1 - Overriding global synapse properties

This example will override the XML to JSON transformation properties defined in the **synapse.properies** configuration with the properties given by the JSON transform mediator.

``` xml
    <proxy xmlns="http://ws.apache.org/ns/synapse" name="transformMediatorSimpleAutoPrimitive" startOnLoad="true" transports="https http">
        <description/>
        <target>
            <inSequence>
                <property name="messageType" scope="axis2" value="application/json"/>
                <jsontransform>
                    <property name="synapse.commons.json.output.autoPrimitive" value = "false"/>
                </jsontransform>
                <respond/>
            </inSequence>
        </target>
    </proxy>
```

Output: All the numeric values have been converted to string values since the auto primitive property is defined as false.

```json
{
    "fruit": "12345",
    "price": "7.5",
    "quantity": "10"
}
```

### Example 2 - Using a JSON schema

This will perform the XML to JSON transformation using the global synapse settings and then apply the JSON schema that is added from the JSON transform mediator.

``` xml
    <proxy name="transformMediatorSimpleSchema" startOnLoad="true" transports="https http" xmlns="http://ws.apache.org/ns/synapse">
            <description/>
            <target>
                <inSequence>
    				<property name="messageType" scope="axis2" value="application/json"/>
                    <jsontransform schema="conf:/Schema.json"/>
                    <respond/>
                </inSequence>
            </target>
        </proxy>
```

Output: The 'fruit' value has been converted to string and the 'price' value has been converted to a number according to the schema definition. Please note that 'quantity' has been converted to a number because it is the default property according to the **synapse.properties** file.

``` json
    {
        "fruit": "12345",
        "price": 7.5,
        "quantity": 10
    }
```

### Example 3 - Overriding global synapse properties and applying a JSON schema

This will first override the XML to JSON transformation properties defined in the synapse.properies configuration with the properties given by the JSON transform mediator and also apply the JSON Schema given in the mediator.

``` java
    <proxy xmlns="http://ws.apache.org/ns/synapse" name="transformMediatorPropertyAndSchema" startOnLoad="true" transports="https http">
        <description/>
        <target>
            <inSequence>
                <property name="messageType" scope="axis2" value="application/json"/>
                <jsontransform schema="conf:/Schema.json">
                    <property name="synapse.commons.json.output.autoPrimitive" value = "false"/>
                </jsontransform>
                <respond/>
            </inSequence>
        </target>
    </proxy>
```

Output: The 'fruit' value has been converted to a string and the 'price' value has been converted to a number according to the schema definition. 
Please note that 'quantity' has been converted to a string because we have overridden the global synapse.properties file.

``` json
    {
        "fruit": "12345",
        "price": 7.5,
        "quantity": "10"
    }
```


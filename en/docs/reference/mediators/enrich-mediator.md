# Enrich Mediator

The **Enrich Mediator** can process a message based on a given source configuration and then perform the specified action on the message by using the target configuration. It gets an `         OMElement        ` using the configuration specified in the source and then modifies the message by putting it on the current message using the configuration in the target.

!!! Info
    The Enrich mediator is a [content-aware]({{base_path}}/concepts/message-processing-units/#classification-of-mediators) mediator.

## Syntax

``` java
<enrich>
    <source [clone=true|false] [type=custom|envelope|body|property|inline] xpath | json-eval(JSON-Path)="" property="" />
    <target [action=replace|child|sibiling] [type=custom|envelope|body|property|inline|key] xpath | json-eval(JSON-Path)="" property="" />
</enrich>
```

## Configuration

The main properties of the Enrich Mediator are as follows:

### Source configuration

The following properties are available:

-   **Clone** - By setting the clone configuration, the message can be cloned or used as a reference during enriching. The default value is true.
    -   **True**
    -   **False**
-   **Type** - The type that the mediator uses from the original message to enrich the modified message that passes through the mediator.
    -   **Custom** - Custom XPath value.
    -   **Envelope** - Envelope of the original message used for enriching.
    -   **Body** - Body of the original message used for enriching.
    -   **Property** - Specifies a property. For information on how you can use the Property mediator to specify properties, see [Property Mediator]({{base_path}}/reference/mediators/property-Mediator).
    -   **Key** - Specifies that the target type is key. Specifically used to rename an existing key name in JSON payloads. *(Supported for JSON only)*.
-   **XPath Expression** - This field is used to specify the custom XPath value if you selected **custom** for the **Type** field.

!!! Tip
    You can click the Namespaces link to add namespaces if you are providing an expression. You will be provided another panel named "Namespace Editor" where you can provide any number of namespace prefixes and URL that you have used in the XPath expression.

### Target Configuration

The following properties are available:

-   **Action** - By specifying the action type, the relevant action can be applied to outgoing messages.  
    -   **Replace** - Replace is the default value of *Action* . It will
        be used if a specific value for *Action* is not given. This
        replaces the XML message based on the target type specified on
        the target configuration.
    -   **Child** - Adding as a child of the specified target type.
    -   **Sibling** - Adding as a sibling of the specified target type.
    -   **Remove** - Removing a selected part. *(Supported for JSON only)*.

    !!! Info
        For the target type ' `           envelope          ` ', the action
        type should be `           'replace          ` '. Herein, action
        type ' `           child          ` ' is not acceptable because it
        adds an envelope within an envelope, and action type '
        `           sibling          ` ' is also not acceptable because
        there will be two envelopes in a message if you use it.
  
-   **Type** and **XPath Expression** - Refer the [Source configuration](#source-configuration) above.

    !!! Info
        The target type depends on the source type. For the valid and
        invalid combinations of source and target types, see below table.
        
## Examples
    
### Example 1: Setting the property symbol
    
In this example, you are setting the property symbol. Later, you can log it using the [Log Mediator]({{base_path}}/reference/mediators/log-Mediator) .
    
``` java
<enrich xmlns="http://ws.apache.org/ns/synapse">
    <source clone="false" type="envelope"/>
    <target type="property" property="payload" />
</enrich>
```
    
### Example 2: Adding a child object to a property
    
In this example, you add a child property named Lamborghini to a property named Cars. The configuration for this is as follows:
    
``` 
<proxy xmlns="http://ws.apache.org/ns/synapse" name="_TestEnrich" transports="https,http" statistics="disable" trace="enable" startOnLoad="true"> 
   <target> 
      <inSequence> 
         <enrich> 
            <source type="inline" clone="true"> 
               <Cars/> 
            </source> 
            <target type="property" property="Cars"/> 
         </enrich> 
         <log level="custom"> 
            <property name="PekeCarListBeforeEnrich" expression="get-property('Cars')"/> 
         </log> 
         <enrich> 
            <source type="inline" clone="true"> 
               <Car>Lamborghini</Car> 
            </source> 
            <target action="child" xpath="$ctx:Cars"/> 
         </enrich> 
         <log level="custom"> 
            <property name="PekeCarListAfterEnrich" expression="get-property('Cars')"/> 
         </log> 
      </inSequence> 
      <outSequence/> 
   </target> 
   <description></description> 
</proxy>
```
  
### Example 3: Adding a SOAPEnvelope type object as a property to a message
    
In this example, you add the SOAP envelope in a SOAP request as a property to a message. The Enrich mediator is useful in this scenario since adding the property directly using the [Property mediator]({{base_path}}/reference/mediators/property-Mediator) results in the `          SOAPEnvelope         ` object being created as an `          OM         ` type object. The `          OM         ` type object created cannot be converted back to a `          SOAPEnvelope         ` object.
    
```
<enrich> 
    <source type="envelope" clone="true"/>
    <target type="property" property="ExtractedEnvelope"/>
</enrich>
```
    
### Example 4: Preserving the original payload
    
In this example, you copy the original payload to a property using the Enrich mediator.
    
```
<enrich>
      <source clone="false" type="body"/>
      <target action="replace" type="property" property="ORGINAL_PAYLOAD"/>
</enrich>
```
    
Then whenever you need the original payload, you replace the message body with this property value using the Enrich mediator as follows:
    
``` 
<enrich>
      <source clone="false" type="property" property="ORIGINAL_PAYLOAD"/>
      <target action="replace" type="body"/>
</enrich>
``` 

## Enriching in JSON format - Examples

!!! Info
    In JSON enriching scenarios if the enrich mediator source defined as a property it should contain a json object or json array.

Below is the JSON payload that is sent in the request for the following examples.

**Payload**

```json
{
    "data": {
        "students": [
            {
                "id": "01",
                "name": "Tom",
                "lastName": "Price",
                "modules": ["CS001", "CS002", "CS003"]
            },
            { 
                "id":"02", 
                "name": "Nick", 
                "lastname": "Thameson",
                "modules": ["CS011", "CS012"] 
             } 
        ]
    }
}
```

### Example 1: Extract content from message payload and set to message body

In this example, we will extract the content in the `data` object and set it as the message body.

```xml
<enrich>
    <source clone="false" xpath="json-eval($.data)"/>
    <target type="body"/>
</enrich>
```

#### Response

```json
{
    "students": [
        {
            "id": "01",
            "name": "Tom",
            "lastName": "Price",
            "modules": [ "CS001", "CS002", "CS003"]
        },
        {
            "id": "02",
            "name": "Nick",
            "lastname": "Thameson",
            "modules": ["CS011", "CS012"]
        }
    ]
}
```

### Example 2: Setting a property as a child in the target

In this example, we will enroll the first student in the payload for a new module. The new module is set
in the `NewModule` property.

```xml
<property name="NewModule" scope="default" type="STRING" value="CS004"/>
<enrich>
    <source clone="true" property="NewModule" type="property"/>
    <target action="child" type="custom" xpath="json-eval($.data.students[0].modules)"/>
</enrich>
```

#### Response

```json
{
    "data": {
        "students": [
            {
                "id": "01",
                "name": "Tom",
                "lastName": "Price",
                "modules": ["CS001", "CS002", "CS003", "CS004"]
            },
            {
                "id": "02",
                "name": "Nick",
                "lastname": "Thameson",
                "modules": ["CS011", "CS012"]
            }
        ]
    }
}
```

### Example 3: Setting an inline content as a child in the target

In this example, we will define a new student inline and add it to the `students` array in the payload.

```xml
<enrich>
    <source clone="true" type="inline"> 
    {
        "id": "03",
        "name": "Mary",
        "lastName": "Jane",
        "modules": ["CS001", "CS002", "CS004"]
    } 
    </source>
    <target action="child" type="custom" xpath="json-eval($.data.students)"/>
</enrich>
```

#### Response

```json
{
    "data": {
        "students": [
            {
                "id": "01",
                "name": "Tom",
                "lastName": "Price",
                "modules": ["CS001", "CS002", "CS003"]
            },
            {
                "id": "02",
                "name": "Nick",
                "lastname": "Thameson",
                "modules": ["CS011", "CS012"]
            },
            {
                "id": "03",
                "name": "Mary",
                "lastName": "Jane",
                "modules": ["CS001","CS002","CS004"]
            }
        ]
    }
}
```

### Example 4: Setting a custom path expressions to a property

In this example, we will assign the first student's name to a property called `Name`.

```xml
<enrich>
    <source clone="true" xpath="json-eval($.data.students[0].name)"/>
    <target property="Name" type="property"/>
</enrich>
<log level="custom">
    <property expression="get-property('Name')" name="Student name is : "/>
</log>
```

The following line can be observed in the log.

```text
INFO {LogMediator} - {proxy:TestEnrich} Student name is :  = "Tom"
```

### Example 5: Removing selected parts from a payload

!!! Info
    -   This feature is currently supported only for JSON.
    -   You can provide multiple JSONPath expressions as a comma-separated list for the `remove` operation (as given in the following example).

In this example, we will remove the `modules` from every student and also remove the first student in the array.

```xml
<enrich>
    <source clone="true" xpath="json-eval($.data.students[*].modules, $.data.students[0])"/>
    <target type="body" action="remove"/>
</enrich>
```

#### Response

```json
{
    "data": {
        "students": [
            {
                "id": "02",
                "name": "Nick",
                "lastname": "Thameson"
            }
        ]
    }
}
```

### Example 6: Removing selected parts from a property

As you removed selected parts from a payload, you can also remove selected parts synapse properties.

```xml
 <enrich>
    <source type="body" clone="false"/>
    <target type="property" property="students"/>
 </enrich>
 <enrich>
    <source clone="true"
          xpath="json-eval($.data.students[*].modules,$.data.students[0])"/>
    <target type="property" action="remove" property="students"/>
 </enrich>
<log>
    <property name="result" expression="$ctx:students"/>
</log>
```

Here, in the first Enrich mediator, you are creating a property called `students` with the incoming message payload. 
In the second Enrich mediator, you are removing selected parts from the property, and finally logging the property. 

After invoking we can see the following log appearing in the terminal.

```
result = {"data":{"students":[{"id":"02","name":"Nick","lastname":"Thameson"}]}
```

### Example 7: Updating a value of an existing object

In this example, we will replace the `modules` array of every student with `[]`.

```xml
<enrich>
    <source clone="true" type="inline">[]</source>
    <target action="replace" xpath="json-eval($.data.students[*].modules)"/>
</enrich>
```

#### Response

```json
{
    "data": {
        "students": [
            {
                "id": "01",
                "name": "Tom",
                "lastName": "Price",
                "modules": []
            },
            {
                "id": "02",
                "name": "Nick",
                "lastname": "Thameson",
                "modules": []
            }
        ]
    }
}
```

### Example 8: Updating the key name of an existing object

!!! Info
    This feature is supported only for JSON.

In this example, we will replace the key name `name` of every student with `firstName`.

```xml
<enrich>
    <source clone="true" type="inline"> firstName </source>
    <target xpath="json-eval($.data.students[*].name)" action="replace" type="key"/>
</enrich>
```

!!! Info
    When specifying the json path of the target, it should comply to the below syntax.
    
    ```text
    <json path to locate the key>.<keyname>
    ```
    
    E.g.: 
    In the above configuration, we are trying to replace the `name` key of the student objects and 
    json path to locate the student objects would be `$.data.students[*]`. Therefore json path would look like below.
    
    ```text
    $.data.students[*].name
    ```

#### Response

```json
{
    "data": {
        "students": [
            {
                "id": "01",
                "firstName": "Tom",
                "lastName": "Price",
                "modules": ["CS001","CS002","CS003"]
            },
            {
                "id": "02",
                "firstName": "Nick",
                "lastname": "Thameson",
                "modules": ["CS011","CS012"]
            }
        ]
    }
}
```

### Example 9: Enriching JSON primitive values

You can use Property mediators with `JSON` data type to enrich any JSON primitive, object, or an array to a given target.

!!! Note 
    When we use a Property with `STRING` data type in the Enrich mediator, it supports native JSON capabilities 
    only if the property contains a JSON object or a JSON array. The rest of the values are considered to be XML.

```xml
<property name="NewSubject" value="&quot;CS013 II&quot;" type="JSON"/>	
<enrich>     
    <source type="property" property="NewSubject"/>	    
    <target action="child"  xpath="json-eval(data.students[1].modules)"/>	
</enrich>
```

!!! Note
    When the JSON primitive string contains white spaces, you should enclose them with quotes as shown in the example below. This is due to restrictions enforced by the JSON schema.

#### Response

```json
{
    "data": {
        "students": [
            {
                "id": "01",
                "name": "Tom",
                "lastName": "Price",
                "modules": ["CS001", "CS002", "CS003"]
            },
            {
                "id": "02",
                "name": "Nick",
                "lastname": "Thameson",
                "modules": ["CS011", "CS012", "CS013 II"
                ]
            }
        ]
    }
}
```


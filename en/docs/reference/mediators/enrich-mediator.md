# Enrich Mediator

The **Enrich Mediator** can process a message based on a given source configuration and then perform the specified action on the message by using the target configuration. It gets an `         OMElement        ` using the configuration specified in the source and then modifies the message by putting it on the current message using the configuration in the target.

!!! Info
    The Enrich mediator is a [content-aware](../../../concepts/message-processing-units/#classification-of-mediators) mediator.

## Syntax

``` java
<enrich>
    <source [clone=true|false] [type=custom|envelope|body|property|inline] xpath | json-eval(JSON-Path)="" property="" />
    <target [action=replace|child|sibiling] [type=custom|envelope|body|property|inline] xpath | json-eval(JSON-Path)="" property="" />
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
    -   **Property** - Specifies a property. For information on how you can use the Property mediator to specify properties, see [Property Mediator](property-Mediator.md).
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
    
In this example, you are setting the property symbol. Later, you can log it using the [Log Mediator](log-Mediator.md) .
    
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
    
In this example, you add the SOAP envelope in a SOAP request as a property to a message. The Enrich mediator is useful in this scenario since adding the property directly using the [Property mediator](property-Mediator.md) results in the `          SOAPEnvelope         ` object being created as an `          OM         ` type object. The `          OM         ` type object created cannot be converted back to a `          SOAPEnvelope         ` object.
    
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

<!--
For other example using the Enrich mediator, see [Sample 15: Using the
    Enrich Mediator for Message Copying and Content
    Enrichment](https://docs.wso2.com/display/EI6xx/Sample+15%3A+Using+the+Enrich+Mediator+for+Message+Copying+and+Content+Enrichment)
    and [Sample 440: Converting JSON to XML Using
    XSLT](https://docs.wso2.com/display/EI6xx/Sample+440%3A+Converting+JSON+to+XML+Using+XSLT).
-->

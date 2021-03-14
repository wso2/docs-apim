# Call Template Mediator

The Call Template mediator allows you to construct a sequence by passing values into a **sequence template**.

!!! Info
    This is currently only supported for special types of mediators such as the [Iterator]({{base_path}}/reference/mediators/iterate-mediator) and [Aggregate Mediators]({{base_path}}/reference/mediators/aggregate-mediator), where actual XPath operations are performed on a different SOAP message, and not on the message coming into the mediator.

## Syntax

``` java
<call-template target="string">
   <!-- parameter values will be passed on to a sequence template -->
   (
    <!--passing plain static values -->
   <with-param name="string" value="string" /> |
    <!--passing xpath expressions -->
   <with-param name="string" value="{string}" /> |
    <!--passing dynamic xpath expressions where values will be compiled dynamically-->
   <with-param name="string" value="{{string}}" /> |
   ) *
   <!--this is the in-line sequence of the template    -->
 </call-template>
```

You use the `target` attribute to specify the sequence template you want to use. The `<with-param>` element is used to parse parameter values to the target sequence template. The parameter names should be the same as the names specified in target template. The parameter value can contain a string, an XPath expression (passed in with curly braces { }), or a dynamic XPath expression (passed in with double curly braces) of which the values are compiled dynamically.

## Configuration

The parameters available to configure the Call-Template mediator are as follows.

| Parameter Name      | Description                                                                                                             |
|---------------------|-------------------------------------------------------------------------------------------------------------------------|
| **Target Template** | The sequence template to which values should be passed. You can select a template from the **Available Templates** list |

When a target template is selected, the parameter section will be displayed as shown below if the sequence template selected has any parameters. This enables parameter values to be parsed into the sequence template selected.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Parameter Name</strong></td>
<td>The name of the parameter.</td>
</tr>
<tr class="even">
<td><strong>Parameter Type</strong></td>
<td><p>The type of the parameter. Possible values are as follows.</p>
<ul>
<li><strong>Value</strong>: Select this to define the parameter value as a static value. This value should be entered in the <strong>Value/ Expression</strong> parameter.</li>
<li><strong>Expression</strong>: Select this to define the parameter value as a dynamic value. The XPath expression to calculate the parameter value should be entered in the <strong>Value/Expression</strong> parameter.</li>
</ul></td>
</tr>
<tr class="odd">
<td><strong>Value / Expression</strong></td>
<td>The parameter value. This can be a static value, or an XPath expression to calculate a dynamic value depending on the value you selected for the <strong>Parameter Type</strong> parameter.</td>
</tr>
<tr class="even">
<td><strong>Action</strong></td>
<td>Click <strong>Delete</strong> <strong></strong> to delete a parameter.</td>
</tr>
<tr>
  <td>
    <b>onError</b>
  </td>
  <td>
    Use this parameter to specify the error handling sequence that should be called if there is an error when the Call Template logic is executed.
</tr>
</tbody>
</table>

## Examples

Following examples demonstrate different usecases of the Call Template mediator.

### Example 1

The following four Call Template mediator configurations populate a
sequence template named HelloWorld_Logger with the "hello world" text
in four different languages.

``` xml
<call-template target="HelloWorld_Logger">
    <with-param name="message" value="HELLO WORLD!!!!!!" />
</call-template>
```

``` xml
<call-template target="HelloWorld_Logger">
    <with-param name="message" value="Bonjour tout le monde!!!!!!" />
</call-template>
```

``` xml
<call-template target="HelloWorld_Logger">
    <with-param name="message" value="Ciao a tutti!!!!!!!" />
</call-template>
```

``` xml
<call-template target="HelloWorld_Logger">
    <with-param name="message" value="???????!!!!!!!" />
</call-template>
```

The sequence template can be configured as follows to log any greetings
message passed to it by the Call Template mediator. Thus, due to the
availability of the Call Template mediator, you are not required to have
the message entered in all four languages included in the sequence
template configuration itself.

``` java
<template name="HelloWorld_Logger">
   <parameter name="message"/>
   <sequence>
        <log level="custom">
              <property expression="$func:message" name="GREETING_MESSAGE"/>
    </log>
   </sequence>
</template>
```

### Example 2

The following Call Template mediator configuration populates a sequence template named `Testtemp` with a dynamic XPath expression.

``` xml
<call-template target="Testtemp">
    <with-param name="message_store" value="<MESSAGE_STORE_NAME>" />
</call-template>
```

The following `Testtemp` template includes a dynamic XPath expression to save messages in a message store, which is
dynamically set via the message context.

``` java
<template name="Testtemp">
        <parameter name="message_store"/>
        <sequence>
            <log level="custom">
                <property expression="$func:message_store"
                    name="STORENAME"
                    xmlns:ns="http://org.apache.synapse/xsd"
                    xmlns:ns2="http://org.apache.synapse/xsd" xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"/>
            </log>
            <store messageStore="{$func:message_store}"
                xmlns:ns="http://org.apache.synapse/xsd"
                xmlns:ns2="http://org.apache.synapse/xsd" xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"/>
        </sequence>
    </template>
```

### Example 3

Consider an example where the sequence template is configured to log the greeting message that is passed from the mediation sequence in the REST API. According to the sequence template, a value for the greeting message is mandatory. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<template name="sequence-temp" xmlns="http://ws.apache.org/ns/synapse">
    <parameter isMandatory="true" defaultValue="Welcome" name="greeting_message"/>
    <sequence>
        <log level="custom">
            <property expression="$func:greeting_message" name="greeting"/>
        </log>
    </sequence>
</template>
```

However, in the following example, the Call template mediator in the REST API is not passing a greeting message to the template. Also, a <b>default</b> greeting message is not defined in the template. In this scenario, an error will get triggered when the REST API calls the template. If you need to handle this error, or in general any error that may occur at execution of the mediation logic inside the template, you can add the 'onError' parameter to the Call Template mediator and call an error-handling sequence.

```xml tab="Call Template"
<?xml version="1.0" encoding="UTF-8"?>
<api context="/test" name="test" xmlns="http://ws.apache.org/ns/synapse">
    ......
      <call-template target="sequence-temp" onError="error-handling-sequence" />
    ........
</api>
```

```xml tab="error-handling-sequence"
<?xml version="1.0" encoding="UTF-8"?>
<sequence name="error-handling-sequence" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
    <log level="custom">
        <property name="faultMessage" value="Call Template Error"/>
    </log>
</sequence>
```
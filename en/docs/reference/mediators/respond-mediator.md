# Respond Mediator

The **Respond Mediator** stops the processing on the current message and sends the message back to the client as a response.

## Syntax

The respond token refers to a \< `         respond        ` \> element,
which is used to stop further processing of a message and send the
message back to the client.

``` java
<respond/>
```

## Configuration

As with other mediators, after adding the Respond mediator to a
sequence, you can click its up and down arrows to move its location in
the sequence.

## Example

Assume that you have a configuration that sends the request to the Stock
Quote service and changes the response value when the symbol is WSO2 or
CRF. Also assume that you want to temporarily change the configuration
so that if the symbol is CRF, the ESB profile just sends the message
back to the client without sending it to the Stock Quote service or
performing any additional processing. To achieve this, you can add the
Respond mediator at the beginning of the CRF case as shown below. All
the configuration after the Respond mediator is ignored. As a result,
the rest of the CRF case configuration is left intact, allowing you to
revert to the original behavior in the future by removing the Respond
mediator if required.

```xml
<proxy name="SimpleProxy" transports="http https" startonload="true" trace="disable" xmlns="http://ws.apache.org/ns/synapse">
    <target>
         <inSequence>
      <switch source="//m0:getQuote/m0:request/m0:symbol" xmlns:m0="http://services.samples">
        <case regex="WSO2">
          <property name="symbol" value="Great stock - WSO2"/>
          <send>
            <endpoint>
              <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
            </endpoint>
          </send>
        </case>
        <case regex="CRF">

          <respond/>

          <property name="symbol" value="Are you sure? - CRF"/>
            <send>
              <endpoint>
                <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
              </endpoint>
            </send>
        </case>
        <default>
          <property name="symbol"
            expression="fn:concat('Normal Stock - ', //m0:getQuote/m0:request/m0:symbol)" xmlns:m0="http://services.samples"/>
        </default>
      </switch>
    </inSequence>
    <outSequence>
      <send/>
    </outSequence>
  </target>
</proxy>
```

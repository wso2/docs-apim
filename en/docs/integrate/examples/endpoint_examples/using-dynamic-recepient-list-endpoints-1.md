# Routing Messages to a Dynamic List of Recipients
This example demonstrates message routing to a set of dynamic endpoints.

## Synapse configuration

Following are the integration artifacts you can use to implement this scenario.

```xml tab='Error Handling Sequence'
<sequence name="errorHandler">
  <makefault response="true">
     <code xmlns:tns="http://www.w3.org/2003/05/soap-envelope" value="tns:Receiver" />
     <reason value="COULDN'T SEND THE MESSAGE TO THE SERVER." />
  </makefault>
  <send />
</sequence>
```

```xml tab='Fault Sequence'
<sequence name="fault">
  <log level="full">
     <property name="MESSAGE" value="Executing default &quot;fault&quot; sequence" />
     <property name="ERROR_CODE" expression="get-property('ERROR_CODE')" />
     <property name="ERROR_MESSAGE" expression="get-property('ERROR_MESSAGE')" />
  </log>
  <drop />
</sequence>
```

```xml tab='Proxy Service'
<proxy name="RecipientListProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
   <target>
        <inSequence>
            <header name="Action" value="urn:placeOrder"/>
             <property name="EP_LIST" value="http://localhost:9001/services/SimpleStockQuoteService,http://localhost:9002/services/SimpleStockQuoteService,http://localhost:9003/services/SimpleStockQuoteService"/>  
             <property name="OUT_ONLY" value="true" />
             <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2" />
             <call>
                <endpoint>
                   <recipientlist>
                      <endpoints value="{get-property('EP_LIST')}" max-cache="20" />
                   </recipientlist>
                </endpoint>
             </call>
             <drop/>
        <outSequence>
              <send/>
        </outSequence>
        <faultSequence>
              <sequence key="errorHandler"/>
        </faultSequence
      </target>
  </proxy>
```

<!--
Set up the back-end service.

Invoke the Micro Integrator:

```bash
ant stockquote -Dmode=placeorder -Dtrpurl=http://localhost:8280/
```
-->
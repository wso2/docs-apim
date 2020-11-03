# Routing a Message to a Dynamic List of Recipients and Aggregating Responses
This example demonstrates message routing to a set of dynamic endpoints and aggregate responses. 

The sample configuration routes a cloned copy of a message
to each recipient defined within the dynamic recipient list, and
each recipient responds with a stock quote. When all the responses
reach the Micro Integrator, the responses are aggregated to form the final response,
which will be sent back to the client.

If you sent the client request through a TCP-based conversation
monitoring tool such as TCPMon, you will see the structure of the
aggregated response message.

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
             <send>
                <endpoint>
                   <recipientlist>
                      <endpoints value="{get-property('EP_LIST')}" max-cache="20" />
                   </recipientlist>
                </endpoint>
             </send>
             <drop/>
         </inSequence>
        <outSequence>
            <!--Aggregate responses-->
            <aggregate>
               <onComplete xmlns:m0="http://services.samples"
                              expression="//m0:getQuoteResponse">
                 <log level="full"/>
                 <send/>
               </onComplete>
            </aggregate>
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
ant stockquote -Dtrpurl=http://localhost:8280/
```
-->

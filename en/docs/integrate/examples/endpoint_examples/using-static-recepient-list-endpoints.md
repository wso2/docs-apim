# Routing Messages to a Static List of Recipients
!!! Note
    This documentation is currently under review. You might encounter some errors when trying out this sample in WSO2 Integration Studio. Please refer [this issue](https://github.com/wso2/integration-studio/issues/37) for details.

This example demonstrates how messages can be routed to a list of static endpoints. This configuration routes a cloned copy of a message to each recipient defined within the static recipient list. The Micro Integrator will create cloned copies of the message and route to the three endpoints mentioned in the configuration. The back-end service prints the details of the placed order. 

## Synapse configuration
Following is a sample proxy service configuration and mediation sequence that we can used to implement this scenario.

```xml tab='Proxy Service'
<proxy name="RecipientListProxy" startOnLoad="true" transports="http https" xmlns="http://ws.apache.org/ns/synapse">
   <target>
        <inSequence>
            <header name="Action" value="urn:placeOrder"/>
            <call>
                <endpoint>
                    <!--List of Recipients (static)-->
                    <recipientlist>
                        <endpoint>
                            <address uri="http://localhost:9001/services/SimpleStockQuoteService"/>
                        </endpoint>
                        <endpoint>
                            <address uri="http://localhost:9002/services/SimpleStockQuoteService"/>
                        </endpoint>
                        <endpoint>
                            <address uri="http://localhost:9003/services/SimpleStockQuoteService"/>
                        </endpoint>
                    </recipientlist>
                </endpoint>
            </call>
            <respond/>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
        <faultSequence>
            <sequence key="errorHandler"/>
        </faultSequence
    </target>
</proxy>
```

```xml tab='Error Handling Sequence'
<sequence name="errorHandler">
    <makefault response="true">
        <code xmlns:tns="http://www.w3.org/2003/05/soap-envelope" value="tns:Receiver"/>
        <reason value="COULDN'T SEND THE MESSAGE TO THE SERVER."/>
    </makefault>
    <send/>
</sequence>
```

<!--
Set up the back-end service.

Invoke the Micro Integrator:

To test this, run
the StockQuote client to send an out-only message as follows:

```bash
ant stockquote -Dmode=placeorder -Dtrpurl=http://localhost:8280/
```

If you examine the console output of
each server, you can see that requests are processed by the three
servers as follows:

```bash
Accepted order #1 for : 15738 stocks of IBM at $ 185.51155223506518
```

Now shutdown MyServer1 and resend the request. You will observe that requests are still processed by MyServer2 and MyServer3.
-->

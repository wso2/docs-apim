# Using a WebSocket Endpoint

WebSocket is a protocol that provides full-duplex communication channels over a single TCP connection. This can be used by any client or server application. The Micro Integrator provides WebSocket support via the [WebSocket Transport](../../../../setup/transport_configurations/configuring-transports/#configuring-the-websocket-transport) and the [WebSocket Inbound Protocol]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-secured-websocket).

## Example 1: Sending a Message from a WebSocket Client to a WebSocket Endpoint

If you need to send a message from a WebSocket client to a WebSocket
endpoint via WSO2 MI, you need to establish a
persistent WebSocket connection from the WebSocket client to WSO2 MI as well as from WSO2 MI to the
WebSocket back-end.

To demonstrate this scenario, you need to create two dispatching
sequences. One for the client to back-end mediation, and another for the
back-end to client mediation. Finally you need to configure the
WebSocket inbound endpoint of WSO2 MI to use the
created sequences and listen on port 9092.

For sample synapse configs, see [Websocket Inbound]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-secured-websocket).

If you analyze the log, you will see that a connection from the
WebSocket client to WSO2 MI is established, and the
sequences are executed by the WebSocket inbound endpoint. You will also
see that the message sent to the WebSocket server is not transformed,
and that the response injected to the out sequence is also not
transformed.

## Example 2: Sending a Message from a HTTP Client to a WebSocket Endpoint

If you need to send a message from a HTTP client to a WebSocket endpoint
via the Micro Integrator, you need to establish
a persistent Websocket connection from WSO2 MI to the
WebSocket back-end.

To demonstrate this scenario, you need to create two dispatching
sequences. One for the client to back-end mediation, and another for the
back-end to client mediation. Then you need to create a proxy service to
call the created sequences.

### Synapse configuration
Following is a sample REST API configuration that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

Create the sequence for client to backend mediation, sequence for the backend to client mediation, and a proxy service as to call the sequences.

```xml tab='Sequence (Backend Mediation)'
<sequence name="dispatchSeq" xmlns="http://ws.apache.org/ns/synapse">
    <property name="OUT_ONLY" value="true"/>
    <property name="FORCE_SC_ACCEPTED" scope="axis2" type="STRING" value="true"/>
    <property name="websocket.accept.contentType" scope="axis2" value="text/xml"/>
     <send>
        <endpoint>
             <address uri="ws://localhost:8082/websocket"/>
        </endpoint>
    </send>
</sequence>
```

```xml tab='Sequence (Backend to Client Mediation)'
<sequence name="outDispatchSeq" xmlns="http://ws.apache.org/ns/synapse">
   <log level="full"/>
</sequence>
```

```xml tab='Proxy Service'
<proxy xmlns="http://ws.apache.org/ns/synapse"
                   name="websocketProxy1"
                   transports="http,https"
                   statistics="disable"
                   trace="disable"
                   startOnLoad="true">
    <target inSequence="dispatchSeq" faultSequence="outDispatchSeq"/>
    <description/>
</proxy>
```

### Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).

    !!! Note
        The Websocket sender functionality of the Micro Integrator is disabled by default. To enable the transport, open the `deployment.toml` file from the `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/conf/` directory and add the following: 

        ```toml
        [transport.ws]
        sender.enable = true
        ```
        
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [mediation sequences]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) and the [proxy service]({{base_path}}/integrate/develop/creating-artifacts/creating-a-proxy-service) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Starting the Websocket server:

-  Download the netty artifacts zip file from [here](https://github.com/wso2-docs/ESB) and extract it. The extracted folder will be shown as `ESB`.
-  Open a terminal, navigate to `ESB/ESB-Artifacts/Netty_artifacts_for_WebSocket_samples` and execute the following command to start the WebSocket server on port 8082:
   
   ```bash
    java -cp 'netty-example-4.0.30.Final.jar:lib/*:.' io.netty.example.http.websocketx.server.WebSocketServer
   ```
   
Calling the Proxy service:

-  Execute the following command to call the proxy service:
```bash
curl -v --request POST -d "<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"><soapenv:Body><test>Value</test></soapenv:Body></soapenv:Envelope>" -H Content-Type:"text/xml" http://localhost:8290/services/websocketProxy1
```

If you analyze the log, you will see that an HTTP request is sent to the
Websocket server, and that the Websocket server injects the response to
the out sequence.

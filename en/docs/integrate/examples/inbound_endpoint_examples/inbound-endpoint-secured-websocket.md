# Using the Secure Websocket Inbound Endpoint

If you need to read and transform the content of WebSocket frames, the
information in incoming WebSocket frames is not sufficient because the
WebSocket protocol does not specify any information about the
content-type of frames that flow through WebSocket channels. Hence, the
Micro Integrator supports a WebSocket
subprotocol extension to determine the content type of WebSocket frames.

The **WebSocket inbound endpoint** of the Micro Integrator supports the following Synapse subprotocols by default:

-   `          synapse(contentType='application/json')         `
-   `          synapse(contentType='application/xml')         `
-   `          synapse(contentType='text/xml')         `

Now let's look at a sample scenario that demonstrates WebSocket to
WebSocket integration using subprotocols to support content handling.

## Example use case

Let's say you need to send messages between two WebSocket based systems
using the Micro Integrator as a WebSocket gateway that facilitates
the messaging. Let's also assume that you need to read and transform the
content of WebSocket frames that are sent and received.

The following should take place in this scenario:

-   The WebSocket Client sends WebSocket frames to the Micro Integrator.
-   When the initial handshake happens between the WebSocket client and
    the WebSocket inbound endpoint of the Micro Integrator, the WebSocket client sends a `Sec-WebSockets-Protocol` header
    that specifies the content type of the WebSocket frame. In this sample it is
    `synapse(contentType='application/json')`.
-   The WebSocket inbound endpoint of the Micro Integrator determines the content-type of the incoming WebSocket frame using the subprotocol.
-   Once the handshake is complete, the WebSocket inbound endpoint builds all the subsequent WebSocket frames based on the content-type specified during the initial handshake.
-   The Micro Integrator sends the transformed message in the form of WebSocket frames.

!!! Tip
    If necessary, you can use the [data mapper](../../references/mediators/data-mapper-mediator) to perform data transformation inside the Micro Integrator message flow. For example, you can perform JSON to JSON transformation. To do this, you have to explicitly apply the required data mapping logic for all WebSocket frames.

## Synapse configuration

Following are the integration artifacts that we can used to implement this scenario. See the instructions on how to [build and run](#build-and-run) this example.

Specify the `websocket.accept.contenType` property to inform the WebSocket sender to build the frames with the specified content type, and to include the same subprotocol header that was used to determine the content of the WebSocket frames. In this case it is JSON.

-   Create the sequence for client to back-end mediation as follows:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence name="dispatchSeq" xmlns="http://ws.apache.org/ns/synapse">
        <property name="OUT_ONLY" value="true"/>
        <property name="websocket.accept.contenType" scope="axis2" value="application/json"/>
        <log level="full">
            <property name="LOGGED_MESSAGE" value="LOGGED"/>
        </log>
        <send>
            <endpoint>
                <address uri="ws://localhost:8082/websocket"/>
            </endpoint>
        </send>
    </sequence>
    ```
    
-   Create the sequence for back-end to client mediation as follows:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence name="outDispatchSeq" trace="enable" xmlns="http://ws.apache.org/ns/synapse">
        <log level="full"/>
        <respond/>
    </sequence>
    ```

-   Configure the WebSocket inbound endpoint as follows to use the created sequences and listen on port 9092:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <inboundEndpoint xmlns="http://ws.apache.org/ns/synapse"
                     name="websocket"
                     sequence="dispatchSeq"
                     onError="fault"
                     protocol="ws"
                     suspend="false">
       <parameters>
          <parameter name="inbound.ws.port">9092</parameter>
          <parameter name="ws.client.side.broadcast.level">0</parameter>
          <parameter name="ws.outflow.dispatch.sequence">outDispatchSeq</parameter>
          <parameter name="ws.outflow.dispatch.fault.sequence">fault</parameter>
          <parameter name="ws.use.port.offset">false</parameter>
       </parameters>
    </inboundEndpoint>
    ```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).

    !!! Note
        The Websocket sender functionality of the Micro Integrator is disabled by default. To enable the transport, open the `deployment.toml` file from the `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/conf/` directory and add the following: 

        ```toml
        [transport.ws]
        sender.enable = true
        ```
        
2. [Create an integration project]({{base_path}}/integrate/develop/create-integration-project) with an <b>ESB Configs</b> module and an <b>Composite Exporter</b>.
3. Create the [mediation sequences]({{base_path}}/integrate/develop/creating-artifacts/creating-reusable-sequences) and [inbound endpoint]({{base_path}}/integrate/develop/creating-an-inbound-endpoint) with the configurations given above.
4. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator.

Starting the Websocket client:

-  Download the netty artifacts zip file from [here](https://github.com/wso2-docs/ESB) and extract it. The extracted folder will be shown as `ESB`
-  Open a terminal, navigate to `ESB/ESB-Artifacts/Netty_artifacts_for_WebSocket_samples` and execute the following command to start the WebSocket server on port 8082:
    ```bash
    java -cp netty-example-4.0.30.Final.jar:lib/*:. io.netty.example.http.websocketx.server.WebSocketServer
    ```
-   Open a terminal, navigate to `ESB/ESB-Artifacts/Netty_artifacts_for_WebSocket_samples` and execute the following command to start the WebSocket client:

    ```bash
    java -DsubProtocol="synapse(contentType='application/json')" -DclientPort=9092 -cp netty-example-4.0.30.Final.jar:lib/*:. io.netty.example.http.websocketx.client.WebSocketClient
    ```

    You will see the following message on the client terminal:

    ```bash
    WebSocket Client connected!
    ```

-   Send the following sample JSON payload from the client terminal:

    ```json
    {"sample message":"test"}
    ```
When you send a sample JSON payload from the client, you will see that a connection from the WebSocket client to the Micro Integrator is established, and that the Micro Integrator receives the message.

This shows that the sequences are executed by the WebSocket inbound endpoint.

You will also see that the message sent to the WebSocket server is transformed, and that the response injected to the out sequence is also transformed.

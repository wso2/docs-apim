# About Inbound Endpoints

An inbound endpoint is a message entry point that can inject messages directly from the transport layer to the mediation layer without going through the Axis2 engine. One of the advantages of using Inbound Endpoints is in its ability to create inbound messaging channels dynamically. There are three types of inbound endpoints:

## Listening Inbound Endpoints

A listening inbound endpoint listens on a given port for requests that are coming in. When a request is available, it is injected to a given sequence. Listening inbound endpoints support two-way operations and are synchronous.

-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/http-inbound-endpoint-properties">HTTP/HTTPS Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/hl7-inbound-endpoint-properties">HL7 Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/cxf-ws-rm-inbound-endpoint-properties">CXF WS-RM Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/websocket-inbound-endpoint-properties">Websocket Inbound Protocol</a>

<!--

<table>
    <tr>
        <th>Inbound Protocol</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>HTTP Inbound Protocol</td>
        <td>
            The HTTP inbound protocol is used to separate endpoint listeners for each HTTP inbound endpoint so that messages are handled separately. The HTTP inbound endpoint can bypass the inbound side axis2 layer and directly inject messages to a given sequence or API. For proxy services, messages will be routed through the axis2 transport layer in a manner similar to normal transports. You can start dynamic HTTP inbound endpoints without restarting the server.
        </td>
    </tr>
    <tr>
        <td>HTTPS Inbound Protocol</td>
        <td>
            Similar to the HTTP inbound protocol.
        </td>
    </tr>
    <tr>
        <td>HL7 Inbound Protocol</td>
        <td>
            The HL7 inbound protocol is an alternative to the HL7 transport. The HL7 inbound endpoint implementation is fully asynchronous and is based on the <b>Minimal Lower Layer Protocol(MLLP)</b> implemented on top of event driven I/O.
        </td>
    </tr>
    <tr>
        <td>CXF WS-RM Inbound Protocol</td>
        <td>
            WS­ReliableMessaging allows SOAP messages to be reliably delivered between distributed applications regardless of software or hardware failures. The CXF WS­-RM inbound endpoint allows a client (RM Source) to communicate with the Micro Integrator with a guarantee that a sent message will be delivered.
        </td>
    </tr>
    <tr>
        <td>WebSocket Inbound Protocol</td>
        <td>
            The WebSocket Inbound protocol is based on the <a href="http://tools.ietf.org/html/rfc6455">Websocket protocol</a> and allows full-duplex message mediation.
        </td>
    </tr>
    <tr>
        <td>Secure WebSocket Inbound Protocol</td>
        <td>
           The secure WebSocket inbound protocol is based on the <a href="http://tools.ietf.org/html/rfc6455">Websocket protocol</a> and allows full-duplex, secure message mediation.
        </td>
    </tr>
</table>
-->

## Polling Inbound Endpoints

A polling inbound endpoint polls periodically for data and, when data is available, the data is injected to a given sequence. For example, the JMS inbound endpoint checks the JMS queue periodically for messages and, when a message is available, that message is injected to a specified sequence. Polling inbound endpoints support one way operations and are asynchronous.

-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/file-inbound-endpoint-properties">File Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/jms-inbound-endpoint-properties">JMS Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/kafka-inbound-endpoint-properties">Kafka Inbound Protocol</a>

<!--

<table>
    <tr>
        <th>Inbound Protocol</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>File Inbound Protocol</td>
        <td>
            The file inbound protocol is an alternative to the VFS transport. It uses the <b>VFS</b> transport to process files in a specified source directory. After processing the files, it moves them to a specified location or deletes them. Note that if files remain in the source directory after processing, they will be processed again. Therefore, if you need to maintain these files or keep track of the files that are processed, specify the option to move them instead of deleting them after processing.
        </td>
    </tr>
    <tr>
        <td>JMS Inbound Protocol</td>
        <td>
            The JMS inbound protocol is an alternative to the JMS transport. The JMS inbound protocol implementation requires an active JMS server instance to be able to receive messages, and you need to place the client JARs for your JMS server in the Micro Integrator.
        </td>
    </tr>
    <tr>
        <td>Kafka Inbound Protocol</td>
        <td>
            The Kafka inbound endpoint provides the functionalilties of the <a href="http://kafka.apache.org/documentation.html">Kafka</a> messaging system. Kafka maintains feeds of messages in topics. Producers write data to topics and consumers read from topics. The Kafka inbound endpoint serves as a message consumer by creating a connection to ZooKeeper and requesting messages for a topic, topics, or topic filters.
        </td>
    </tr>
</table>
-->

## Event-based Inbound Endpoints

An event-based inbound endpoint polls only once to establish a connection with the remote server and then consumes events.

-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/event-based-inbound-endpoints/mqtt-inbound-endpoint-properties">MQTT Inbound Protocol</a>
-   <a href="{{base_path}}/reference/synapse-properties/inbound-endpoints/event-based-inbound-endpoints/rabbitmq-inbound-endpoint-properties">RabbitMQ Inbound Protocol</a>

<!--

<table>
    <tr>
        <th>Inbound Protocol</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>RabbitMQ Inbound Protocol</td>
        <td>
            <a href="http://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol">AMQP</a> is a wire-level messaging protocol that describes the format of the data that is sent across the network. If a system or application can read and write AMQP, it can exchange messages with any other system or application that understands AMQP regardless of the implementation language.
        </td>
    </tr>
    <tr>
        <td>MQTT Inbound Protocol</td>
        <td>
            MQ Telemetry Transport (MQTT) is a lightweight broker-based publish/subscribe messaging protocol, designed to be open, simple, lightweight and easy to implement. These characteristics make it ideal for use in constrained environments:
            <ul>
                <li>Where the network is expensive, has low bandwidth, or is unreliable.</li>
                <li>When running on an embedded device with limited processor or memory resources.</li>
            </ul>
        </td>
    </tr>
</table>
-->
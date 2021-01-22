# Integration Overview

## API-led Integration

API Manager enables you to build integration services from the ground up using [Integration Studio](https://wso2.com/integration/integration-studio/) and publish them as managed APIs. WSO2 Integration Studio is used to develop and test these integration services, after which, they can be registered in the Service Catalog at the time of deployment.

<img src="{{base_path}}/assets/img/integrate/intro/api-led-integration.png" width="700">

As indicated in the diagram above, integrations are a building block that enables connectivity with SaaS applications, services and microservices, databases, files, message brokers, and also propriety and legacy systems.

## Integration Use Cases

The following are the main use cases of WSO2 Micro Integrator. These help you understand what you can do with the product.

<table>
    <tr>
        <td>
            <ul>
                <li><a href="{{base_path}}/integrate/integration-use-case/message-routing-overview">Message Routing and Transformation</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/service-orchestration-overview">Service Orchestration</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/asynchronous-message-overview">Asynchronous Message Processing</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/connectors">SaaS and B2B Connectivity</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/data-integration-overview">Data Integration</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/protocol-switching-overview">Protocol Switching</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/gateway-overview">Gateway</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/file-processing-overview">File Processing</a></li>
                <li><a href="{{base_path}}/integrate/integration-use-case/scheduled-task-overview">Periodic Execution of Integration Processes</a></li>
            </ul>
        </td>
    </tr>
</table>

## Tutorials

The integration tutorials will walk you through the main capabilities and features of WSO2 Micro Integrator, and help you understand how to build an integrated system.

<table>
    <tr>
        <td>
            <ul>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-service">Sending a Simple Message to a Service</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/routing-requests-based-on-message-content">Message Routing</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/transforming-message-content">Message Transformation</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/exposing-several-services-as-a-single-service">Service Orchestration</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/storing-and-forwarding-messages">Asynchronous Messaging</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-datasource">Data Integration</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/file-processing">File Processing</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/using-scheduled-tasks">Periodic Execution of Integration Process</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/using-inbound-endpoints">Using Inbound Endpoints</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/using-templates">Reusing Mediation Sequences</a></li>
                <li><a href="{{base_path}}/tutorials/integration-tutorials/sap-integration">Integrating with SAP</a></li>
            </ul>
        </td>
    </tr>
</table>

## Examples

<table>
    <tr>
        <td><b>Message Routing</b> 
            <ul>
                <li><a href="{{base_path}}/integrate/examples/routing-examples/routing_based_on_headers">Routing Based on Message Headers</a></li>
                <li><a href="{{base_path}}/integrate/examples/routing-examples/routing_based_on_payloads">Routing Based on Message Payload</a></li>
                <li><a href="{{base_path}}/integrate/examples/routing-examples/splitting_aggregating_messages">Splitting Messages and Aggregating Responses</a></li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Message Transformation</b> 
            <ul>
                <li><a href="{{base_path}}/integrate/examples/message_transformation_examples/json-to-soap-conversion">Converting JSON Messages to SOAP</a></li>
                <li><a href="{{base_path}}/integrate/examples/message_transformation_examples/pox-to-json-conversion/">Converting POX Messages to JSON</a></li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Asynchronous Messaging</b>
            <li>RabbitMQ Examples
                <ul>
                    <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/point-to-point-rabbitmq">Point to Point</a></li>
                    <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/pub-sub-rabbitmq">Publish/Subscribe</a></li>
                    <li>Guaranteed Delivery 
                        <ul>
                            <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/store-forward-rabbitmq">Message Store and Message Processor</a></li>
                            <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/retry-delay-failed-msgs-rabbitmq">Retry failed messages with a delay</a></li>
                            <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/requeue-msgs-with-errors-rabbitmq">Requeue a message preserving the order</a></li>
                            <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/move-msgs-to-dlq-rabbitmq">Publish messages to DLX</a></li>
                        </ul>
                    </li>
                    <li><a href="{{base_path}}/integrate/examples/rabbitmq_examples/request-response-rabbitmq">Dual Channel</a></li>
                </ul>
            </li>
            <li>JMS Examples
                <ul>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/consuming-jms">Consuming JMS Messages</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/producing-jms">Producing JMS Messages</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/consume-produce-jms">Consuming and Producing JMS Messages</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/dual-channel-http-to-jms">Dual Channel HTTP-to-JMS</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/quad-channel-jms-to-jms">Quad Channel JMS-to-JMS</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/guaranteed-delivery-with-failover">Guaranteed Delivery with Failover</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/publish-subscribe-with-jms">Publish and Subscribe with JMS</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/shared-topic-subscription">Shared Topic Subscription</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/detecting-repeatedly-redelivered-messages">Detecting Repeatedly Redelivered Messages</a></li>
                    <li><a href="{{base_path}}/integrate/examples/jms_examples/specifying-a-delivery-delay-on-messages">Specifying Delivery Delay on Messages</a></li>
                </ul>
            </li>
        </td>
    </tr>
    <tr>
        <td><b>Protocol Switching</b>
            <ul>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_JMS_to_HTTP/">Switching from JMS to HTTP/S</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_HTTPS_to_JMS">Switching from HTTP/S to JMS</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_FTP_listener_to_mail_sender">Switching from FTP Listener to Mail Sender</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_HTTP_to_FIX">Switching from HTTP to FIX</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_FIX_to_HTTP">Switch from FIX to HTTP</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_FIX_to_AMQP">Switch from FIX to AMQP</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_between_FIX_versions">Switching between FIX Versions</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_TCP_to_HTTPS">Switching from TCP to HTTP/S</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_from_UDP_to_HTTPS">Switching from UDP to HTTP/S</a></li>
                <li><a href="{{base_path}}/integrate/examples/protocol-switching/switching_between_HTTP_and_MSMQ">Switching between HTTP to MSMQ</a></li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>File Processing</b> 
            <ul>
                <li><a href="{{base_path}}/integrate/examples/file-processing/vfs-transport-examples">Using VFS for File Transferring</a></li>
                <li><a href="{{base_path}}/integrate/examples/file-processing/Accessing_Windows_Share_Using_VFS_Transport">Accessing a Windows Share Using VFS</a></li>
                <li><a href="{{base_path}}/integrate/examples/file-processing/mailto-transport-examples">Sending and Receiving Emails</a></li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Data Integration</b>
            <ul>
                <li><a href="{{base_path}}/integrate/examples/data_integration/rdbms-data-service">Exposing an RDBMS datasource</a></li>
                <li>Exposing Other Datasources
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/data_integration/csv-data-service">Exposing a CSV datasource</a></li>
                        <li><a href="{{base_path}}/integrate/examples/data_integration/carbon-data-service">Exposing a Carbon datasource</a></li>
                    </ul>
                </li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/json-with-data-service">Exposing Data in JSON Format</a></li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/odata-service">Using an OData Service</a></li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/nested-queries-in-data-service">Using Nested Data Queries</a></li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/batch-requesting">Batch Requesting</a></li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/request-box">Invoking Multiple Operations as a Request Box</a></li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/distributed-trans-data-service">Using Distributed Transactions in Data Services</a></li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/data-input-validator">Validating Data Input</a></li>
                <li><a href="{{base_path}}/integrate/examples/data_integration/swagger-data-services">Swagger Documents of RESTful Data Services</a></li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Examples of Components</b>
            <ul>
                <li>REST APIs 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/introduction-rest-api">Using a Simple REST API</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/setting-query-params-outgoing-messages">Setting Query Parameters on Outgoing Messages</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/enabling-rest-to-soap">Exposing a SOAP Endpoint as a RESTful API</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/configuring-non-http-endpoints">Exposing Non-HTTP Services as RESTful APIs</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/handling-non-matching-resources">Handling Non-Matching Resources</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/setting-https-status-codes">Handling HTTP Status Codes</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/transforming-content-type">Transforming Content Types</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/securing-rest-apis">Securing a REST API</a></li>
                        <li><a href="{{base_path}}/integrate/examples/rest_api_examples/publishing-a-swagger-api">Publishing a Custom Swagger Document</a></li>
                        <li>Handling Special Cases
                            <ul>
                                <li><a href="{{base_path}}/integrate/examples/rest_api_examples/using-get-with-a-body">Using GET with a Message Body</a></li>
                                <li><a href="{{base_path}}/integrate/examples/rest_api_examples/using-post-with-no-body">Using POST with Empty Message Body</a></li>
                                <li><a href="{{base_path}}/integrate/examples/rest_api_examples/using-post-with-query-param">Using POST with Query Parameters</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li>Proxy Services 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/proxy_service_examples/Introduction-to-Proxy-Services">Using a Simple Proxy Service</a></li>
                        <li><a href="{{base_path}}/integrate/examples/proxy_service_examples/publishing-a-custom-wsdl">Publishing a Custom WSDL</a></li>
                        <li><a href="{{base_path}}/integrate/examples/proxy_service_examples/exposing-proxy-via-inbound">Exposing a Proxy Service via Inbound Endpoints</a></li>
                        <li><a href="{{base_path}}/integrate/examples/proxy_service_examples/securing-proxy-services">Securing a Proxy Service</a></li>
                    </ul>
                </li>
                <li>Inbound Endpoints 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-jms-protocol">JMS Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/file-inbound-endpoint">File Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-http-protocol">HTTP Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-https-protocol">HTTPS Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-hl7-protocol-auto-ack">HL7 Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-mqtt-protocol">MQTT Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-rabbitmq-protocol">RabbitMQ Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-kafka">Kafka Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-secured-websocket">Secured WebSocket Inbound Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-with-registry">Using Inbound Endpoints with Registry</a></li>
                    </ul>
                </li>
                <li>Scheduled Tasks 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/scheduled-tasks/task-scheduling-simple-trigger">Task Scheduling using a Simple Trigger</a></li>
                        <li><a href="{{base_path}}/integrate/examples/scheduled-tasks/injecting-messages-to-rest-endpoint">Injecting Messages to a RESTful Endpoint</a></li>
                    </ul>
                </li>
                <li><a href="{{base_path}}/integrate/examples/registry_examples/local-registry-entries">Local Registry Entries</a></li>
                <li>Templates 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/template_examples/using-sequence-templates">Using Sequence Templates</a></li>
                        <li><a href="{{base_path}}/integrate/examples/template_examples/using-endpoint-templates">Using Endpoint Templates</a></li>
                    </ul>
                </li>
                <li>Message Stores & Processors 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/intro-message-stores-processors">Introduction to Message Stores and Processors</a></li>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/using-jdbc-message-store">JDBC Message Store</a></li>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/using-jms-message-stores">JMS Message Store</a></li>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/using-rabbitmq-message-stores">RabbitMQ Message Store</a></li>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/using-message-sampling-processor">Message Sampling Processor</a></li>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/using-message-forwarding-processor">Message Forwarding Processor</a></li>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/securing-message-processor">Securing the Message Forwarding Processor</a></li>
                        <li><a href="{{base_path}}/integrate/examples/message_store_processor_examples/loadbalancing-with-message-processor">Load Balancing with Message Forwarding Processor</a></li>
                    </ul>
                </li>
                <li>Endpoints 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-address-endpoints">Address Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-failover-endpoints">Failover Endpoints</a></li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-http-endpoints">HTTP Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-websocket-endpoints">WebSocket Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-wsdl-endpoints">WSDL Endpoint</a></li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-loadbalancing-endpoints">Load Balance Endpoint</a></li>
                        <li>Recipient List of Endpoints
                            <ul>
                                <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-static-recepient-list-endpoints">Static List of Recepients</a></li>
                                <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-dynamic-recepient-list-endpoints-1">Dynamic List of Recepients</a></li>
                                <li><a href="{{base_path}}/integrate/examples/endpoint_examples/using-dynamic-recepient-list-endpoints-2">Dynamic List of Recepients with Aggregated Responses</a></li>
                            </ul>
                        </li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/reusing-endpoints">Reusing Endpoints</a></li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/endpoint-error-handling">Endpoint Error Handling</a></li>
                        <li><a href="{{base_path}}/integrate/examples/endpoint_examples/mtom-swa-with-endpoints">MTOM and SwA Optimizations</a></li>
                    </ul>
                </li>
                <li>Sequences 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/sequence_examples/using-multiple-sequences">Breaking Complex Flows into Multiple Sequences</a></li>
                        <li><a href="{{base_path}}/integrate/examples/sequence_examples/using-fault-sequences">Using Fault Sequences</a></li>
                        <li><a href="{{base_path}}/integrate/examples/sequence_examples/custom-sequences-with-proxy-services">Reusing Sequences</a></li>
                    </ul>
                </li>
                <li>Transports 
                    <ul>
                        <li><a href="{{base_path}}/integrate/examples/transport_examples/tcp-transport-examples">Using the TCP Transport</a></li>
                        <li><a href="{{base_path}}/integrate/examples/transport_examples/fix-transport-examples">Using the FIX Transport</a></li>
                        <li><a href="{{base_path}}/integrate/examples/transport_examples/Pub_Sub_using_MQTT">Using the MQTT Transport</a></li>
                    </ul>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>
            <ul>
                <li><a href="{{base_path}}/integrate/examples/working-with-transactions">Transactions</a></li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>
            <ul>
                <li><a href="{{base_path}}/integrate/examples/json_examples/json-examples">JSON Examples</a></li>
            </ul>
        </td>
    </tr>
</table>

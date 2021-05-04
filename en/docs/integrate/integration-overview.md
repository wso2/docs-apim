<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

# Integration Overview

WSO2 API Manager 4.0.0 is shipped with an integration runtime (Micro Integrator) with comprehensive enterprise integration capabilities. Therefore, you can now use WSO2 API Manager to develop complex integration services and expose them as managed APIs in an API marketplace. This allows you to enable API-led connectivity across your business using a single platform.

## Get Started with Integration

Let's get started with the integration capabilities and concepts of the Micro Integrator of WSO2 API Manager.

<div>
    <div class="content">
        <!-- card -->
        <div class="card img" onclick="location.href='{{base_path}}/get-started/quick-start-guide/integration-qsg';">
            <div class="line"></div>
            <div class="card-icon">
                <img src='{{base_path}}/assets/img/integrate/quick-start.png' alt="integration quick start" />
            </div>
            <div class="card-content" >
                <p class="title">Quick Start with Integration</p>
                <p class="hint">Try out a simple message mediation using the Micro Integrator.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card img" onclick="location.href='{{base_path}}/integrate/develop/integration-development-kickstart';">
            <div class="line"></div>
            <div class="card-icon">
                <img src='{{base_path}}/assets/img/integrate/first-service.png' alt="develop first integration" />
            </div>
            <div class="card-content">
                <p class="title">Develop your First Integration</p>
                <p class="hint">Build a simple integration scenario using WSO2 Integration Studio.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card img" onclick="location.href='{{base_path}}/integrate/integration-key-concepts';">
            <div class="line"></div>
            <div class="card-icon">
                <img src='{{base_path}}/assets/img/integrate/key-concepts.png' alt="integration key concepts" />
            </div>
            <div class="card-content">
                <p class="title">Key Concepts of Integration</p>
                <p class="hint">Explore the key concepts used by the Micro Integrator.</p>
            </div>
        </div>
        <!-- end card -->
    </div>
</div>

## Integration Strategy

You can now leverage the integration capabilities as well as the API management capabilities of the product to implement any of the following integration strategies.

### API-led Integration

WSO2 API Manager consists of an API management layer as well as an integration layer, which enables API-led integration through a single platform. The integration layer (Micro Integrator) is used for running the integration APIs, which are developed using WSO2 Integration Studio. The API management layer is used for converting the integration APIs into experience APIs and making them discoverable to developers. 

See <a href="{{base_path}}/integrate/api-led-integration">API-led Integration</a> for more information.

### Microservices Integration

The Micro Integrator is lightweight and container friendly. This allows you to leverage the comprehensive enterprise messaging capabilities of the Micro Integrator in your decentralized, cloud-native integrations.

<img src="{{base_path}}/assets/img/integrate/intro/mi-microservices-architecture.png" width="700">

If your organization is running on a decentralized, cloud-native, integration architecture where microservices are used for integrating the various APIs, events, and systems, the Micro Integrator can easily function as your Integration microservices and API microservices.

### Centralized Integration (Enterprise Service Bus)

At the heart of the Micro Integrator server is an event-driven, standards-based messaging engine (the Bus). This ESB supports message routing, message transformations, and other types of messaging use cases. If your organization uses an API-driven, centralized, integration architecture, the Micro Integrator can be used as the central integration layer that implements the message mediation logic connecting all the systems, data, events, APIs, etc. in your integration ecosystem.

<img src="{{base_path}}/assets/img/integrate/intro/mi-esb-architecture.png" width="700">

## Learn Integration

See the topics in the following sections for details and instructions.

### Integration Use Cases

Learn about the main integration capabilities of the Micro Integrator of WSO2 API Manager. You can also follow the [tutorials](#integration-tutorials) on each of these use cases to gain hands-on knowledge.

<div>
    <div class="content">
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/message-routing-overview';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Message Routing</p>
                <p class="hint">Explore how messages are routed to different endpoints.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/message-routing-overview';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Message Transformation</p>
                <p class="hint">Explore how messages are transformed into different formats.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/data-integration-overview';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Data Integration</p>
                <p class="hint">Explore how data from various sources are used during message mediation.</p>
            </div>
        </div>
        <!-- end card -->
    </div>
    <div class="content">
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/file-processing-overview';">
            <div class="line"></div>
            <div class="card-content">
                <p class="title">File Processing</p>
                <p class="hint">Explore how data from file systems are moved and used during message mediation.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/connectors';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">SaaS and B2B Connectivity</p>
                <p class="hint">Explore how to integrate with third-party systems using WSO2 connectors.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/service-orchestration-overview';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Service Orchestration</p>
                <p class="hint">Explore how multiple Restful services are exposed as a single course-grained service.</p>
            </div>
        </div>
        <!-- end card -->
    </div>
    <div class="content">
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/asynchronous-message-overview';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Enterprise Messaging</p>
                <p class="hint">Explore asynchronous messaging patterns using message brokers.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/scheduled-task-overview';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Scheduled Integration Processes</p>
                <p class="hint">Explore how integration processes are scheduled and executed periodically.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/integration-use-case/protocol-switching-overview';">
            <div class="line"></div>
            <div class="card-content">
                <p class="title">Protocol Switching</p>
                <p class="hint">Explore how message protocols are changed during message mediation.</p>
            </div>
        </div>
        <!-- end card -->
    </div>
</div>

### Integration Development

Learn how to set up the development environment and build integration solutions.

<div>
    <div class="content">
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/develop/wso2-integration-studio';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Quick Tour - WSO2 Integration Studio</p>
                <p class="hint">Get an overview of the developer tool that you will use for developing integrations.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/develop/installing-wso2-integration-studio';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Install WSO2 Integration Studio</p>
                <p class="hint">Install and set up WSO2 Integration Studio.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/integrate/develop/intro-integration-development';">
            <div class="line"></div>
            <div class="card-content">
                <p class="title">Development Workflow</p>
                <p class="hint">Get an overview of the integration development workflow.</p>
            </div>
        </div>
        <!-- end card -->
    </div>
</div>

See the **Developing Integrations** section in the left-hand navigator for more topics on working with integrations.

### Management and Observability

Learn about the dashboards, tools, and solutions that are available for managing and monitoring integrations deployed in the Micro Integrator.

<div>
    <div class="content">
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/observe/mi-observe/working-with-monitoring-dashboard';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Micro Integrator Dashboard</p>
                <p class="hint">Dashboard for monitoring integration artifacts in a Micro Integrator cluster.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_bath}}/install-and-setup/setup/api-controller/managing-integrations/managing-integrations-with-ctl';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">APICTL (CLI for Integration)</p>
                <p class="hint">Command-line tool for monitoring integration artifacts in a Micro Integrator instance.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/install-and-setup/setup/mi-setup/observability/observability-deployment-strategy';">
            <div class="line"></div>
            <div class="card-content">
                <p class="title">Observability for Integrations</p>
                <p class="hint">Observability solution for integrations deployed in a Micro Integrator cluster.</p>
            </div>
        </div>
        <!-- end card -->
    </div>
</div>

### DevOps and Administration

Learn how to set up a Micro Integrator deployment and configure the deployment according to your requirements.

<div>
    <div class="content">
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/install-and-setup/install-and-setup-overview/#installing_1';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Installation</p>
                <p class="hint">Install the Micro Integrator in your environment.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_bath}}/install-and-setup/install-and-setup-overview/#deploying_1';">
            <div class="line"></div>
            <div class="card-content">
                <p class="title">Deployment</p>
                <p class="hint">Select a deployment strategy and set up a deployment (on containers or VMs).</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/install-and-setup/install-and-setup-overview/#upgrading_1';">
            <div class="line"></div>
            <div class="card-content">
                <p class="title">Upgrade</p>
                <p class="hint">Upgrade to the latest Micro Integrator from previous product versions.</p>
            </div>
        </div>
        <!-- end card -->
    </div>
    <div class="content">
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/install-and-setup/install-and-setup-overview/#setting-up_1';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">Configuration and Set up</p>
                <p class="hint">Configure Security, Data Stores, Perfomance, Message Brokers, Transports, etc.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_path}}/install-and-setup/setup/mi-setup/user_stores/managing_users';">
            <div class="line"></div>
            <div class="card-content" >
                <p class="title">User Management</p>
                <p class="hint">Configure a user store and manage users and roles in the Micro Integrator.</p>
            </div>
        </div>
        <!-- end card -->
        <!-- card -->
        <div class="card" onclick="location.href='{{base_bath}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller';">
            <div class="line"></div>
            <div class="card-content">
                <p class="title">CICD Pipelines</p>
                <p class="hint">Implement CICD pipelines for your deployment (on containers or VMs).</p>
            </div>
        </div>
        <!-- end card -->
    </div>
</div>

### Integration Tutorials

Learn how to implement various integration use cases, deploy them in the Micro Integrator, and test them locally.

-   API-led Integration tutorials

    <table>
    <tr>
        <td>
            <a href="{{base_path}}/tutorials/integration-tutorials/service-catalog-tutorial">Exposing an Integration Service as a Managed API</a>
        </td>
    </tr>
    </table>

-   Message mediation tutorials

    <table>
        <tr>
            <td>
                <ul>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-service">Sending a Simple Message to a Service</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/routing-requests-based-on-message-content">Routing Requests based on Message Headers</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/transforming-message-content">Translating Message Formats</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/exposing-several-services-as-a-single-service">Exposing Several Services as a Single Service</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/storing-and-forwarding-messages">Store and Forward Messages for Guaranteed Delivery</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-datasource">Exposing Datasources as a Service</a></li>
                </ul>
            </td>
            <td>
                <ul>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/file-processing">File Processing</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/using-scheduled-tasks">Periodic Execution of Integration Process</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/using-inbound-endpoints">Using Inbound Endpoints</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/using-templates">Reusing Mediation Sequences</a></li>
                    <li><a href="{{base_path}}/tutorials/integration-tutorials/sap-integration">Sending Emails from an Integration Service</a></li>
                </ul>
            </td>
        </tr>
    </table>

### Integration Examples

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
                        <li><a href="{{base_path}}/integrate/examples/proxy_service_examples/introduction-to-proxy-services">Using a Simple Proxy Service</a></li>
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
                        <li><a href="{{base_path}}/integrate/examples/transport_examples/pub-sub-using-mqtt">Using the MQTT Transport</a></li>
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
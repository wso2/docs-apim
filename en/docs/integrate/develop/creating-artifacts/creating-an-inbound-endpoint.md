# Creating an Inbound Endpoint

Follow the instructions given below to create a new [Inbound Endpoint]({{base_path}}/reference/synapse-properties/inbound-endpoints/about-inbound-endpoints) artifact in WSO2 Integration Studio.

## Instructions

### Creating the Inbound Endpoint artifact

1. If you have already created an [ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project), right-click the project and go to **New → Inbound Endpoint** to open the **New Inbound Endpoint Artifact**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/select-inbound-endpoint.png" width="500">

2. Select **Create a New Inbound Endpoint** and click **Next**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/new-inbound-endpoint-wizard-1.png" width="500">

3. Enter a unique name for the inbound endpoint, and select an **Inbound Endpoint Creation Type** from the list.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/new-inbound-endpoint-wizard-2-1.png" width="500">

4. Specify values for the required parameter for the selected inbound endpoint type.

    !!! Note
        For certain protocols (HL7, KAFKA, Custom, MQTT, RabbitMq, WSO2_MB, WS, and  WSS) the **main sequence** and **error sequence** are mandatory fields.
        <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/new-inbound-endpoint-wizard-2-2.png" width="500">

        You can select sequences that already exist in the workspace and add them to the **Sequence** and **Error sequence** fields. If you don't have any sequences in the workspace, click **Generate Sequence and Error Sequence** to generate new sequences for the inbound endpoint.

5.	Do one of the following:  
    -   To save the endpoint in an existing ESB Config project in your workspace, click **Browse** and select that project.
    -   To save the endpoint in a new ESB Config project, click **Create new Project** and create the new project.
6.  Click **Finish**. 

The inbound endpoint is created in the `src/main/synapse-config/inbound-endpoint` folder under the ESB Config project you specified.

### Designing the integration

When you open the inbound endpoint from the **Config** project in the project explorer, you will see the default **Design** view.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/inbound-endpoint-design-view.png" width="800">

The integration flow for an inbound endpoint is defined within [named sequences]({{base_path}}/reference/synapse-properties/sequence-properties/#named-sequences). You can drag and drop **sequences** from the **Palette** to the canvas as shown below.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/inbound-graphical-editor.png" width="800">

Double-click the **Sequence** artifact to open the canvas for the sequence. You can now drag and drop the mediation artifacts from the palette and design the integration flow.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/sequence-graphical-editor.png" width="600">

### Updating the properties

To update properties from the **Design** view:

1.  Double-click the **Inbound Endpoint** icon to open the <b>Properties</b> tab.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/inbound-endpoint-properties.png" width="500">

2.  See the following links for the list of parameters for each inbound endpoint type:

    - [HTTP Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/http-inbound-endpoint-properties)
    - [CXF WS RM Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/cxf-ws-rm-inbound-endpoint-properties)
    - [HL7 Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/hl7-inbound-endpoint-properties)
    - [Websocket Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/listening-inbound-endpoints/websocket-inbound-endpoint-properties)
    - [File Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/file-inbound-endpoint-properties)
    - [JMS Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/jms-inbound-endpoint-properties)
    - [Kafka Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/polling-inbound-endpoints/kafka-inbound-endpoint-properties)
    - [RabbitMQ Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/event-based-inbound-endpoints/rabbitmq-inbound-endpoint-properties)
    - [MQTT Inbound Parameters]({{base_path}}/reference/synapse-properties/inbound-endpoints/event-based-inbound-endpoints/mqtt-inbound-endpoint-properties)

!!! Note
    **Redeployment of listening inbound endpoints fail?**

    A **listening inbound endpoint** opens the port for itself during deployment. Therefore, if you are **redeploying** a listening inbound endpoint artifact, the redeployment will not be successful until the port that was previously opened for the inbound endpoint is closed.

    By default, the system will wait for 10 seconds for the previously opened port to close down. If you want to increase this waiting time beyond 10 seconds, be sure to add the following system property in the `deployment.toml` file, which is stored in the `MI_HOME/conf/` directory and restart the server before redeploying the artifacts.

    ```toml
    [system.parameter]
    'synapse.transport.portCloseVerifyTimeout' = 20
    ```
    Note that `synapse.transport.portCloseVerifyTimeout` should be wrapped by single quotes since it contain dots. The TOML format detects the dot as an object separator.
    Also note that this setting may be required in Windows environments as the process of closing a port can sometimes take longer than 10 seconds.

### Using the Source View

Click the **Source** tab to view the XML-based synapse configuration (source code) of the inbound endpoint. You can update the service using this view.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_inbound_endpoint/inbound-source-view.png" width="800">

## Examples

-   [JMS Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-jms-protocol)
-   [File Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/file-inbound-endpoint)
-   [HTTP Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-http-protocol)
-   [HTTPS Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-https-protocol)
-   [HL7 Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-hl7-protocol-auto-ack)
-   [MQTT Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-mqtt-protocol)
-   [RabbitMQ Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-rabbitmq-protocol)
-   [Kafka Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-kafka)
-   [Websocket Inbound Endpoint example]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-secured-websocket)
-   [Using Inbound Endpoints with Registry]({{base_path}}/integrate/examples/inbound_endpoint_examples/inbound-endpoint-with-registry)

## Tutorial

-   See the tutorial on [using inbound endpoints]({{base_path}}/integrate/tutorials/using-inbound-endpoints)

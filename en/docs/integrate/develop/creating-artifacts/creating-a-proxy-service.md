# Creating a Proxy Service

Follow the instructions given below to create a new [Proxy Service](../../../references/synapse-properties/proxy-service-properties) artifact in WSO2 Integration Studio.

## Instructions

### Creating the Proxy Service artifact

1.  Right-click the project in the navigator and go to **New → Proxy Service** to open the **New Proxy Service** dialog box.     
    <img src="../../../assets/img/create_artifacts/new_proxy_service/select-new-proxy.png">

2.  Select **Create New Proxy Service** and click **Next**.

    <img src="../../../assets/img/create_artifacts/new_proxy_service/create-new-proxy-option.png" width="500">

3.  Enter a unique name for the proxy service and select a proxy service template from the list shown below. These templates will automatically generate the mediation flow that is required for each use case.

    <img src="../../../assets/img/create_artifacts/new_proxy_service/new-proxy-artifact-dialog.png" width="500">

    <table>
    <tr class="header">
    <th>Template Type</th>
    <th>Description</th>
    </tr>
    <tbody>
    <tr class="odd">
    <td>Pass-Through proxy</td>
    <td>This template creates a proxy service that forwards messages to the endpoint without performing any processing.</td>
    </tr>
    <tr class="even">
    <td>Transformer proxy</td>
    <td>This template creates a proxy service that transforms all the incoming requests using XSLT and then forwards them to a given endpoint. If required it can also transform responses from the back-end service according to an XSLT that you specify.</td>
    </tr>
    <tr class="odd">
    <td>Log Forward proxy</td>
    <td>This template creates a proxy service that first logs all the incoming requests and passes them to a given endpoint. It can also log responses from the backend service before routing them to the client. You can specify the log level for requests and responses.</td>
    </tr>
    <tr class="even">
    <td>WSDL-Based proxy</td>
    <td>This template generates a proxy service from the remotely hosted WSDL of an existing web service. The endpoint information is extracted from the WSDL you specify.
    </td>
    </tr>
    <tr class="odd">
    <td>Secure proxy</td>
    <td>This template creates a proxy service that uses WS-Security to process incoming requests and forward them to an unsecured backend service. You simply need to provide the policy file that should be used.</td>
    </tr>
    <tr class="even">
    <td>Custom proxy</td>
    <td>This template creates an empty proxy service file, where you can manually create the mediation flow by adding all the sequences, endpoints, transports, and other QoS settings.</td>
    </tr>
    </tbody>
    </table>

4. Do one of the following to save the proxy service:  
    -   To save the proxy service in an existing ESB Config project in your workspace, click **Browse** and select that project.
    -   To save the proxy service in a new ESB Config project, click **Create new Project** and create the new project.
5. Click **Finish**. 

The proxy service is created in the `src/main/synapse-config/proxy-services` folder under the project you specified.

### Designing the integration

When you open the proxy service from the **Config** project in the project explorer, you will see the default **Design** view as shown below.

<img src="../../../assets/img/create_artifacts/new_proxy_service/proxy-service-design-view.png" width="800">

Drag and drop the required integration artifacts from the **Palette** to the canvas and design the integration flow.

<img src="../../../assets/img/create_artifacts/new_proxy_service/proxy-service-graphical-editor.png" width="800">

### Updating the properties

To add service-level properties to the proxy service from the **Design** view:

1.  Double-click the **Proxy Service** icon to open the <b>Properties</b> tab for the service.

    <img src="../../../assets/img/create_artifacts/new_proxy_service/proxy-service-properties.png" width="700">

2.  Expand each section and add the required parameters.

To add service-level transport parameters:

1.  Go to the **Properties** tab and expand the **Parameters** section as shown below.

    <img src="../../../assets/img/create_artifacts/new_proxy_service/service-level-params.png" width="700">

2.  Click the **plus** <img src="../../../assets/img/common/plus-icon.png" width="20"> icon and add the parameter name and value as a key-value pair:

    <img src="../../../assets/img/create_artifacts/new_proxy_service/service-level-params-dialog.png" width="500">

See the following links for the list of transport parameters you can use:

  - [VFS Parameters](../../../references/synapse-properties/transport-parameters/vfs-transport-parameters)
  - [JMS Parameters](../../../references/synapse-properties/transport-parameters/jms-transport-parameters)
  - [FIX Parameters](../../../references/synapse-properties/transport-parameters/fix-transport-parameters)
  - [MailTo Parameters](../../../references/synapse-properties/transport-parameters/mailto-transport-parameters)
  - [MQTT Parameters](../../../references/synapse-properties/transport-parameters/mqtt-transport-parameters)
  - [RabbitMQ Parameters](../../../references/synapse-properties/transport-parameters/rabbitmq-transport-parameters)

3.  See the complete list of [service-level properties and parameters](../../../references/synapse-properties/proxy-service-properties) that you can configure.

### Using the Source View

Click the **Source** tab to view the XML-based synapse configuration (source code) of the proxy service. You can update the service using this view.

<img src="../../../assets/img/create_artifacts/new_proxy_service/proxy-service-source-view.png" width="800">

## Examples

-   [Using a Simple Proxy Service](../../../use-cases/examples/proxy_service_examples/Introduction-to-Proxy-Services)
-   [Publishing a Custom WSDL](../../../use-cases/examples/proxy_service_examples/publishing-a-custom-wsdl)
-   [Exposing a Proxy Service via Inbound Endpoint](../../../use-cases/examples/proxy_service_examples/exposing-proxy-via-inbound)
-   [Securing Proxy Services](../../../use-cases/examples/proxy_service_examples/securing-proxy-services)

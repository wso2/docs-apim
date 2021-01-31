# Creating an Endpoint
Follow the instructions given below to create a new [Endpoint]({{base_path}}/reference/synapse-properties/endpoint-properties) artifact in WSO2 Integration Studio.

## Instructions

### Creating the Endpoint artifact

1.  Right-click the [ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project) and go to **New → Endpoint** to open the **New Endpoint Artifact** dialog box.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/select-endpoint.png">

2.  Select **Create a New Endpoint** and click **Next**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/new-endpoint-wizard-1.png" width="500">

3.  Enter a unique name for the endpoint, and then select the type of endpoint you are creating.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/new-endpoint-wizard-2.png" width="500">

4.  Specify values for the [required parameter]({{base_path}}/reference/synapse-properties/endpoint-properties) for the selected endpoint type.
5.  Specify how you want to save the endpoint:

    - Select **Static Endpoint** to save the endpoint in the current workspace.
    - Select **Dynamic Endpoint** to save the endpoint as a registry resource.

6.  Specify the location to save the endpoint:

    - To save in an existing ([ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project) or [Registry Resource project]({{base_path}}/integrate/develop/create-integration-project/#registry-resource-project)) in your workspace, click **Browse** and select that project.
    - To save in a new project, click **Create new Project** and create the new project.

7.  Click **Finish**. 

The endpoint is created in the `src/main/synapse-config/endpoints` folder under the ESB Config project or [registry resource project]({{base_path}}/integrate/develop/create-integration-project/#registry-resource-project) you specified.

### Designing the integration

To add an endpoint artifact to the integration sequence, use the [Send Mediator]({{base_path}}/reference/mediators/send-mediator) or the [Call Mediator]({{base_path}}/reference/mediators/call-mediator).

1.	Open to the **Design View** of your [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties).
2.  Drag the [Call Mediator]({{base_path}}/reference/mediators/call-mediator) from the **Palette** and drop it to the relevant position in the [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties):

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/endpoint-graphical-editor-1.png" width="700">

    !!! Tip
        Similarly, you can use the [Send Mediator]({{base_path}}/reference/mediators/send-mediator).

3.	Drag the new endpoint artifact from the **Defined Endpoints** section in the **Palette** and drop it to the empty box in the [Call Mediator]({{base_path}}/reference/mediators/call-mediator):

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/endpoint-graphical-editor-2.png" width="700">

The endpoint artifact is now linked to your integration sequence.

### Updating the properties

Open the new endpoint artifact from the project explorer. You can use the **Form** view or the **Source** view to update endpoint properties.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_endpoint/endpoint-form-view.png" width="700">

See the descriptions of all [endpoint properties]({{base_path}}/reference/synapse-properties/endpoint-properties).

## Examples

<ul>
	<li>
		<a href="{{base_path}}/integrate/examples/endpoint_examples/using-address-endpoints">Using Address Endpoints</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/endpoint_examples/using-failover-endpoints">Using Failover Endpoints</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/endpoint_examples/using-http-endpoints">Using HTTP Endpoints</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/endpoint_examples/using-websocket-endpoints">Using a Websocket Endpoint</a>
	</li>
  <li>
		<a href="{{base_path}}/integrate/examples/endpoint_examples/using-wsdl-endpoints">Using WSDL Endpoints</a>
	</li>
	<li>
		<a href="{{base_path}}/integrate/examples/endpoint_examples/using-loadbalancing-endpoints">Using Load Balancing Endpoints</a>
	</li>
</ul>

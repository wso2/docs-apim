# Creating Endpoint Templates

Follow the instructions given below to create a new **Endpoint Template** in WSO2 Integration Studio.

## Instructions

### Creating the Endpoint Template artifact

1.  Right-click the [ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project) and go to **New → Template** to open the **New Template Artifact** dialog box.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/select-template.png">

2.  Select **Create a New Template** and click **Next**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/new-template-wizard-1.png" width="500">

3.  Enter a unique name for the template and select one of the following **Endpoint Template** types.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/new-template-wizard-2-1.png" width="500">

    - <b>Address Endpoint Template</b>
    - <b>Default Endpoint Template</b>
    - <b>HTTP Endpoint Template</b>
    - <b>WSDL Endpoint Template</b>

    Specify values for the [required parameter]({{base_path}}/reference/synapse-properties/template-properties/#endpoint-template-properties) for the selected endpoint type.

5.  Do one of the following to save the artifact:

  	-  To save the template in an existing ESB Config project in your workspace, click **Browse** and select that project.
  	-  To save the template in a new ESB Config project, click **Create new Project** and create the new project.

6.  Click **Finish**. 

    The template is created in the `src/main/synapse-config/templates` folder under the ESB Config project you specified.

7.  To use the endpoint template, [update the properties](#updating-properties).

### Updating properties

1.  Open the template artifact from the project explorer.
2.  First, update the endpoint parameter values with placeholders that are prefixed by `$`.

    For example:

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/endpoint-template-form-view-1.png" width="700">

3.  Then, click **Add Template Parameter** to open the **Parameter Configuration** dialog box and add the endpoint parameter placeholders (that you used above) as parameters:

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/endpoint-template-param-config-dialog.png" width="700">

### Designing the integration

When you have an Endpoint template defined, you can use a **Template Endpoint** in your [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties) to call the parameters in the template.

1.	Open to the **Design View** of your [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties).
2.  Drag the [Call Mediator]({{base_path}}/reference/mediators/call-mediator) from the **Palette** and drop it to the relevant position in the [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties).

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/endpoint-temp-graphical-editor-1.png" width="700">

    !!! Tip
        Similarly, you can use the [Send Mediator]({{base_path}}/reference/mediators/send-mediator).

3.	Drag a [Template Endpoint]({{base_path}}/reference/mediators/send-mediator) from the **Endpoints** section in the **Palette** and drop it to the empty box in the [Call Mediator]({{base_path}}/reference/mediators/call-mediator).

	<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/endpoint-temp-graphical-editor-2.png" width="700">

4.  Open the [Template Endpoint]({{base_path}}/reference/mediators/send-mediator) from the project explorer and click **Add Parameters** to open the **Template Endpoint Parameter Configuration** dialog box.
5.  Specify the parameter values as shown below.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/template-endpoint-properties.png" width="700">

## Examples

- [Using Endpoint Templates]({{base_path}}/integrate/examples/template_examples/using-endpoint-templates)

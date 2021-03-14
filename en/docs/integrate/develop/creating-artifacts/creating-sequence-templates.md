# Creating Sequence Templates

Follow the instructions given below to create a new **Sequence Template** in WSO2 Integration Studio.

## Instructions

### Creating the Sequence Template artifact

1.  Right-click the [ESB Config project]({{base_path}}/integrate/develop/create-integration-project/#esb-config-project) and go to **New → Template** to open the **New Template Artifact** dialog box.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/select-template.png">

2.  Select **Create a New Template** and click **Next**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/new-template-wizard-1.png" width="500">

3.  Enter a unique name for the template and select **Sequence Template** from the list.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/new-template-wizard-2-2.png" width="500">

    Specify values for the [required parameter]({{base_path}}/reference/synapse-properties/template-properties/#endpoint-template-properties) for the selected endpoint type.

5.  Do one of the following to save the artifact:

  	-   To save the template in an existing ESB Config project in your workspace, click **Browse** and select that project.
  	-   To save the template in a new ESB Config project, click **Create new Project** and create the new project.

6.  Click **Finish**. 

    The template is created in the `src/main/synapse-config/templates` folder under the ESB Config project you specified.

7.  To use the sequence template, [update the properties](#updating-properties).

### Updating properties

1.	Open the **Design View** of the sequence template you created.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/sequence-template-design-view-1.png" width="700">

2.  Drag-and-drop the required mediators from the **Palette**.
3.  Specify parameter values as an XPATH.

    In the following example, the `GREETING_MESSAGE` property of the **Log** mediator is specified using the `$func:message` expression.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/sequence-template-design-view-2.png" width="700">

### Designing the integration

When you have a Sequence template defined, you can use a [Call Template Mediator]({{base_path}}/reference/mediators/call-template-mediator) in your [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties).

1.  Open to the **Design View** of your [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties).
2.  Drag the [Call Template Mediator]({{base_path}}/reference/mediators/call-template-mediator) from the **Palette** and drop it to the relevant position in the [mediation sequence]({{base_path}}/reference/synapse-properties/sequence-properties).

	   <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/sequence-temp-graphical-editor-1.png" width="700">

3.   Double-click the [Call Template Mediator]({{base_path}}/reference/mediators/call-template-mediator) icon to open the **Properties** tab.
4.  Select your sequence template from the list in the **Available Templates** field and then add values using the template parameters.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_template/sequence-temp-graphical-editor-2.png" width="500">

## Examples

- [Using Sequence Templates]({{base_path}}/integrate/examples/template_examples/using-sequence-templates)

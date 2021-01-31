# Creating a REST API

Follow the instructions given below to create a new [REST API]({{base_path}}/reference/synapse-properties/rest-api-properties) artifact in WSO2 Integration Studio.

You can refer to the following video to get a quick understanding of how this is done.

<iframe width="560" height="315" src="https://www.youtube.com/embed/yp2fzOgVcIA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Instructions

### Creating the API artifact

1.  Right-click the **Config** project in the project explorer and go to **New → REST API**.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new-artifact.png" width="500">

2.  In the dialog box that opens, select one of the given options for creating the API artifact:

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/create-new-api-option.png" width="500">

    <table>
        <tr>
            <th>
                Create A New API Artifact
            </th>
            <td>
                This option is selected by default. Use this option if you want to create the REST API artifact from scratch.
            </td>
        </tr>
        <tr>
            <th>
                Generate API using Swagger Definition
            </th>
            <td>
                Selet this option if you want to generate the REST API artifact from an existing Swagger definition (YAML/JSON file). That is, the synapse configuration (XML) of the REST API will be generated using the Swagger definition.
            </td>
        </tr>
        <tr>
            <th>
                Import API Artifact
            </th>
            <td>
                Select this option to import an existing REST API configuration (XML definition) that was created using WSO2 Integration Studio.
            </td>
        </tr>
    </table>

3.  Click **Next** to go to the next page and enter the relevant details.

    -   If you selected **Create a New API** in the previous step, enter the basic details that are required for creating the synapse configuration (XML) of the API:

        <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/new-api-artifact-dialog.png" width="500">

        <table>
            <tr>
                <th>
                    Parameter
                </th>
                <th>
                    Description
                </th>
            </tr>
            <tr>
                <td>
                    Name
                </td>
                <td>
                    <b>Required</b>.</br>
                    The name of the REST API.
                </td>
            </tr>
            <tr>
                <td>
                    Context
                </td>
                <td>
                    <b>Required</b>.</br>
                    The context for the REST API. For example, <code>/healthcare</code>.
                </td>
            </tr>
            <tr>
                <td>
                    Path to Swagger Definition
                </td>
                <td>
                    Enter the path to a custom Swagger definition (YAML/JSON file) that is stored in a registry project in your workspace.</br></br>
                    Once this API is created and deployed in the Micro Integrator, users will be able to access this custom Swagger definition and not the default Swagger definition of the API.
                </td>
            </tr>
        </table>

    -   If you selected **Generate API using Swagger Definition** in the previous step, enter the details of your custom Swagger file:

        <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/new-api-swagger-dialog.png" width="500">

        <table>
            <tr>
                <th>
                    Parameter
                </th>
                <th>
                    Description
                </th>
            </tr>
            <tr>
                <td>
                    Swagger Definition File
                </td>
                <td>
                    <b>Required</b>.</br>
                    Click <b>Browse</b> and select the Swagger file.
                </td>
            </tr>
            <tr>
                <td>
                    Swagger Registry Path
                </td>
                <td>
                    Click <b>Browse</b> to select an existing registry project in your workspace. The Swagger definition will be saved to this registry.</br></br>
                    If you don't have an existing registry project, click <b>Create new project</b> to add a new registry project to your workspace.
                </td>
            </tr>
        </table>

    -   If you selected **Import API Artifact** in the previous step, enter the following information:

        <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/import-api-dialog.png" width="500">

        <table>
            <tr>
                <th>
                    Parameter
                </th>
                <th>
                    Description
                </th>
            </tr>
            <tr>
                <td>
                    API Configuration File
                </td>
                <td>
                    <b>Required</b>.</br>
                    Click <b>Browse</b> and select the REST API configuration file.
                </td>
            </tr>
        </table>

4.  Click **Finish**. 
    -   The REST API is created inside the `src/main/synapse-config/api` folder of your **Config** project.
    -   If you provided a custom Swagger definition file (YAML), it is now stored in the registry project.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/project-explorer.png" width="300">

### Designing the integration

When you open the REST API from the **Config** project in the project explorer, you will see the default **Design** view as shown below.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/api-artifact-design-view.png" width="800">

Drag and drop the required integration artifacts from the **Palette** to the API resource and design the integration flow.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/graphical-editor.png" width="800">

You can also use the [**Source** view](#using-the-source-view) or the [**Swagger** editor](#using-the-swagger-editor) to update the API configuration.

### Adding new API resources

When you create the API, an API resource is created by default. If you want to add a new resource, click **API Resource** in the **Pallet** and simply drag and drop the resource to the REST API.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/add-new-api-resource.png" width="500">

!!! Info
    **About the default API Resource**

    Each API can have at most one default resource. Any request received
        by the API but does not match any of the enclosed resource
        definitions will be dispatched to the default resource of the API.
        In the following example, if a DELETE request is received by `SampleAPI` on the `/payments` URL, the request will be
        dispatched to the default resource as none of the resources in SampleAPI are configured to handle DELETE requests.

    ```xml tab='SampleAPI'
    <api name="SampleAPI" context="/payments">
    <resource url-mapping="/list" methods="GET" inSequence="seq7" outSequence="seq8"/>
    <resource uri-template="/edit/{userId}" methods="PUT POST" outSequence="seq9">
        <inSequence>
             <log/>
             <send>
                  <endpoint key="BackendService"/>
             </send>
        </inSequence>
    </resource>
    <resource inSequence="seq10" outSequence="seq11"/>
    </api>
    ```    

### Updating properties

To update API-level properties from the **Design** view:

1.  Double-click the **API** icon to open the <b>Properties</b> tab for the API.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/api-properties.png" width="700">

2.  See the complete list of [optional REST API properties]({{base_path}}/reference/synapse-properties/rest-api-properties/#rest-api-properties-optional) you can configure.

To update API resource properties from the **Design** view:

1.  Double-click the **Resource** icon to enable the <b>Properties</b> tab for the resource.

    <img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/api-resource-properties.png" width="700">

2.  See the complete list of [API Resource properties]({{base_path}}/reference/synapse-properties/rest-api-properties/#rest-api-resource-properties) you can configure.

### Using the Source View

Click the **Source** tab to view the XML-based synapse configuration (source code) of the API. You can update the API using this view.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/api-artifact-source-view.png" width="800">

### Using the Swagger Editor

Click the **Swagger Editor** tab to view the Swagger definition of your API. You can update the API using the Swagger editor (left panel) and also interact with the API using the Swagger UI (right panel).

!!! Note
    If you have added a custom Swagger definition to the API, note that this view displays the API's default Swagger definition and not the custom Swagger definition that you added.

<img src="{{base_path}}/assets/img/integrate/create_artifacts/new_api/api-artifact-swagger-view.png" width="800">

## Examples

-   [Using a Simple Rest API]({{base_path}}/integrate/examples/rest_api_examples/introduction-rest-api)
-   [Working with Query Parameters]({{base_path}}/integrate/examples/rest_api_examples/setting-query-params-outgoing-messages)
-   [Exposing a SOAP Endpoint as a RESTful API]({{base_path}}/integrate/examples/rest_api_examples/enabling-rest-to-soap)
-   [Exposing Non-HTTP Services as RESTful APIs]({{base_path}}/integrate/examples/rest_api_examples/configuring-non-http-endpoints)
-   [Handling Non Matching Resources]({{base_path}}/integrate/examples/rest_api_examples/handling-non-matching-resources)
-   [Handling HTTP Status Codes]({{base_path}}/integrate/examples/rest_api_examples/setting-https-status-codes)
-   [Manipulating Content Types]({{base_path}}/integrate/examples/rest_api_examples/transforming-content-type)
-   [Securing a REST API]({{base_path}}/integrate/examples/rest_api_examples/securing-rest-apis)
-   [Special Cases]({{base_path}}/integrate/examples/rest_api_examples/special-cases)

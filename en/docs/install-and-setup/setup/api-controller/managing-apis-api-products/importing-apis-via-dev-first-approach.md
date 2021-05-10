# Importing APIs Via Dev First Approach

**WSO2 API Controller (apictl)** allows you to create and deploy APIs without using the Publisher Portal of the WSO2 API Manager (WSO2 API-M). You can use this feature to create an API **from scratch** or **using an existing Swagger or Open API specification** and then deploy it to the desired WSO2 API-M environment.

!!! info
    **Before you begin** 

    -   Make sure that the apictl is downloaded and initialized, if not, follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -   Make sure you already have added an environment using the apictl for the WSO2 API-M environment you plan to import the API to. 

        If not, follow the steps in [Add an Environment]({{base_path}}/install-and-setup/setup//api-controller/getting-started-with-wso2-api-controller#add-an-environment).

## Initialize an API project

1. Open a terminal window and navigate to the path you need to create the project.

2. You can follow either of the following ways to generate the project.

    1.   **From Scratch**
        -   Command
            ```bash
            apictl init <Project Path>   
            ```
            ```bash
            apictl init <Project Path> --definition <API definition template file>  --force=<force create project>
            ```

            !!! example
                ```bash
                apictl init SampleAPI                
                ```
                ```bash 
                apictl init SampleAPI --definition definition.yaml --force=true                
                ```
            
            As an example, you can use the [Sample-Api.yaml](https://github.com/wso2/product-apim-tooling/blob/master/import-export-cli/integration/testdata/sample-api.yaml) here to generate an API Project.

        -   Response    
            ```go
            Initializing a new WSO2 API Manager project in /home/user/work/SampleAPI
            Project initialized
            Open README file to learn more
            ```
        
            !!! info
                In this case, the project artifacts are generated according to a set of predefined templates. Therefore, after initializing the project, you need to go and edit the project artifacts manually.     


    2.   **From OpenAPI/Swagger Specification**  
        You can use a Swagger2 and OpenAPI3 specification to generate an API. The file format should be YAML or JSON.

        -   Command
            ```bash
            apictl init <Project Path> --oas <Path to API specification>
            ```
            ```bash
            apictl init <Project Path> --oas <Path to API specification> --definition <API definition template file> --force=<force create project>
            ```

            !!! example
                ```bash
                apictl init Petstore --oas petstore.yaml
                ```
                ```bash
                apictl init Petstore --oas https://petstore.swagger.io/v2/swagger.json
                ```
                ```go
                apictl init Petstore --oas petstore.yaml --definition definition.yaml --force=true
                ```

        -   Response

            ```go
            Initializing a new WSO2 API Manager project in /home/user/work/PetstoreAPI
            Project initialized
            Open README file to learn more
            ```

            !!! info
                When you initialize an API project using an OpenAPI specification, apictl will automatically read the OpenAPI definition and populate a certain set of configs in the API definition file, `api.yaml`.     

            !!! info
                **Flags:**  
                    
                -   Optional :  
                        `--definition` or `-d` : Provide a YAML definition of API  
                        `--oas` : Provide an OpenAPI specification file/URL for the API   
                        `--force` or `-f` : To overwrite the directory and create the project 

        !!! note
            You can define scopes for a resource when defining a Swagger2 or OpenAPI3 specification to generate an API.

            !!! example
                ```yaml
                openapi: 3.0.0
                info:
                title: Online-Store
                version: v1.0.0
                description: This API contains operations related to the online shopping store.
                x-wso2-basePath: /store/{version}
                x-wso2-production-endpoints:
                urls:
                    - http://products
                paths:
                /products:
                    get:
                    responses:
                        "200":
                        description: successful operation
                /products/{productId}:
                    get:
                    parameters:
                        - name: productId
                        in: path
                        required: true
                        schema:
                            type: string
                    security: 
                        - 
                        default: 
                            - "read"
                    responses:
                        "200":
                        description: successful operation
                components: 
                securitySchemes: 
                    default: 
                        type: "oauth2"
                        flows: 
                            implicit: 
                            authorizationUrl: "https://test.com"
                            scopes: 
                                read: ""
                            x-scopes-bindings: 
                                read: "admin"
                ```

            First you need to define the scope name ("read") under `security > default` section inside the required resource and then define the role binding under the `securitySchemes` section. You can use any preferred name as the security scheme.

            Make sure to set the security type as **`oauth2`** when defining the scopes. Also when defining the roles under a particular scope, put them under **x-scopes-bindings:**  as a scope name and roles mapping.        

            
        !!! note
            You can define WSO2 API-M supported open API extensions for an API when defining a Swagger2 or OpenAPI3 specification to generate an API. These extensions can be used to define endpoint configurations, runtime configurations, resource level throttling, and API level throttling, transport-level security, CORS configurations and response cache configurations. The list of APIM supported OpenAPI extensions is as follows.

            <table>
                <tbody>
                    <tr>
                        <td>
                            <p><strong>Extension</strong></p>
                        </td>
                        <td>
                            <p><strong>Description</strong></p>
                        </td>
                        <td>
                            <p><strong>API Level/ Resource Level</strong></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-basePath</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">The base path which gateway exposes the API</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level&nbsp;</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-production-endpoints</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Specify the actual back end of the service</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-sandbox-endpoints</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Specify the sandbox endpoint of the service if available</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-throttling-tier</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Specify the rate-limiting for the API or resource</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level/ Resource level</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-cors</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Specify CORS configuration for the API</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level&nbsp;</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-disable-security</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">When the value of this extension specified as true, the resources can be invoked without any authentication</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level/ Resource level</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-response-cache</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Enable response caching when creating a new API with cache timeout</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-mutual-ssl</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Enable mutual SSL for API (With optional and mandatory keywords as values)</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-auth-header</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Specify the authorization header for the API in which either bearer or basic token is sent</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level&nbsp;</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-transports</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Specify the transport security for the API (HTTP, HTTPS, and Mutual SSL)</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level&nbsp;</span></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><span style="font-weight: 400;">x-wso2-application-security</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">Specify application security (basic_auth, api_key, oauth2)</span></p>
                        </td>
                        <td>
                            <p><span style="font-weight: 400;">API level/ Resource level</span></p>
                        </td>
                    </tr>
                </tbody>
            </table>

            Let's see how these OpenAPI extensions are used in [Open API definition](https://github.com/wso2/product-microgateway/blob/master/samples/endpoint_by_reference_sample.yaml).

     A project folder with the following default structure will be created in the given directory.

    ``` java
    ├── api.yaml
    ├── api_meta.yaml
    ├── deployment_environments.yaml
    ├── Client-certificates
    ├── Definitions
    │   └── swagger.yaml
    ├── Docs
    ├── Endpoint-certificates
    ├── Image
    └── Sequences
        ├── fault-sequence
        ├── in-sequence
        └── out-sequence
    ```

    <table>
        <thead>
            <tr class="header">
                <th>Sub Directory/File</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr class="odd">
                <td><code>api.yaml</code></td>
                <td>The specification of the created API.</td>
            </tr>
            <tr class="even">
                <td><code>api_meta.yaml</code></td>
                <td>The meta-information file of the source artifact (This includes the name and the version of the API).</td>
            </tr>
            <tr class="odd">
                <td><code>deployment_environments.yaml</code></td>
                <td>Specify the gateway environments to which the API should be deployed.</td>
            </tr>
            <tr class="even">
                <td><code>swagger.yaml</code></td>
                <td>The Swagger file that is generated when the API is created.</td>
            </tr>
        <tr class="odd">
            <td><pre><code>Sequences
        ├── fault-sequence
        ├── in-sequence
        └── out-sequence</code></pre>
            </td>
            <td>To add custom sequences, save them in XML format and add them to the corresponding folder. For example, to add a custom in-sequence, save the custom sequence as <code>       SampleSequence.xml</code> and add it to the <code>Sequences/in-sequence/Custom</code>directory.</td>
        </tr>
        <tr class="even">
        <td>Client-certificates</td>
        <td>Contains the client certificates for Mutual SSL enabled APIs.</td>
        </tr>
        <tr class="odd">
        <td>Docs</td>
        <td>Contains the documents.</td>
        </tr>
        <tr class="even">
        <td>Endpoint-certificates</td>
        <td>Contains the endpoint certificates for endpoint security enabled APIs.</td>
        </tr>
        <tr class="odd">
        <td>Image</td>
        <td>Contains the thumbnail image of the API.</td>
        </tr>
        </tbody>
    </table>

    !!! note 
        **Overriding an API with organization-specific details and further finetuning**

        When you create an API Project, APIs are generated using a default template. To further finetune the process of creating the API and to include organization-specific common API related details, you can use a custom API Definition file. 
        For more information, see [Initialize an API project](#initialize-an-api-project).

        **Generate APIs with Dynamic Data**

        When initializing an API Project, apictl is capable of detecting environment variables in the default definition file or in the provided custom definition file. For more information on using dynamic data, see [Initialize API Projects with Dynamic Data]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/using-dynamic-data-in-api-controller-projects/#initialize-api-projects-with-dynamic-data).

4. Open the `<API Project>/api.yaml` file. You can edit the **mandatory configurations** in the field named `data` as listed below.

    | Field                                        | Description                                             |
    |----------------------------------------------|---------------------------------------------------------|
    | `name`| The name of API without spaces.                         |
    | `context`| Context of the API in WSO2 API-M with a leading slash. |
    | `production_endpoints` | Production endpoints for API.                            |
    | `sandbox_endpoints`| Sandbox endpoint for API.                               |

    For more information about the configurations, see the [Sample-Api.yaml](https://github.com/wso2/product-apim-tooling/blob/master/import-export-cli/integration/testdata/sample-api.yaml).

    **api.yaml**

    ``` bash
        type: api
        version: v4.0.0
        data:
            name : SampleAPI
            version: 1.0.0
            context: /sampleapi
            endpointConfig:
                endpoint_type: http
                production_endpoints:
                    url: http://prod.wso2.com
                sandbox_endpoints:
                    url: http://sand.wso2.com
            endpointImplementationType: ENDPOINT
            lifeCycleStatus: CREATED
            policies:
            - Unlimited
            provider: admin
            transport:
            - http
            - https
            type: HTTP
            visibility: PUBLIC
    ```

## Import an API project

!!! info
    **Before you begin...** 

    -   Make sure you have already created an environment to which you are planning to import the API. If not, follow steps in [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
    -   Make sure you have logged-in to the importing environment. If not, follow steps in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment). 


!!! tip
    A user with `Internal/devops` role or `admin` role are allowed to import APIs. To create a custom user who can import APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

After editing the mandatory fields in the API Project, you can import the API to an environment using any of the following commands.  

-   **Command**
    ``` bash
    apictl import api -f <path to API Project> -e <environment> 
    ```
    ``` bash
    apictl import api --file <path to API Project> --environment <environment> --rotate-revision
    ```
    ``` bash
    apictl import api --file <path to API Project> --environment <environment> --params=<environment params file> 
    ```

    !!! info
        **Flags:**  
           
        -   Required :  
            `--file` or `-f` : The file path of the API project to import.  
            `--environment` or `-e` : Environment to which the API should be imported.   
        -   Optional :  
            `--rotate-revision` : If the maximum revision limit reached, delete the oldest revision and create a new revision.  
            `--skip-deployments` : Skip the deployment environments specified in the project and only update the working copy of the API.   
            `--preserve-provider` : Preserve the existing provider of API after importing. The default value is `true`.   
            `--update` : Update an existing API or create a new API in the importing environment.    
            `--params` : Provide a API Manager environment params file. For more information, see [Configuring Environment Specific Parameters]({{base_path}}/install-and-setup/setup/api-controller/advanced-topics/configuring-environment-specific-parameters).    
            `--skip-cleanup` : Leave all temporary files created in apictl during import process. The default value is `false`.    

    !!! example
        ```bash
        apictl import api -f ~/myapi -e production 
        ```
        ```bash
        apictl import api --file ~/myapi --environment production --rotate-revision
        ```    
        ``` go
        apictl import api --file ~/myapi --environment production --params prod/params.yaml  
        ```
        
    !!! tip
        When using the `--update` flag with the `import api` command, apictl will check if the given API exists in the targeted environment. If the API exists, it will update the existing API. If not, it will create a new API in the imported environment. 
        
    !!! note
        **Changes to the import command with the revision support for APIs**  
        
        - From WSO2 API-M 4.0.0 onwards, you have to create a new revision in order to deploy an API in an gateway environment and 
            **only a revision can be deployed in a gateway environment**. 
        - With the import command of the apictl, if the API project has specified the deployment environments, import 
            will first **update the working copy of the API**.
        - If the number of revisions created for that API **does not exceed the max revision limit of 5**, a new revision
            of that API will be created and that revision will be deployed in the specified gateway environments.
        - If the max revision numbers is reached, imported API will **only update the working copy** and not be deployed 
            in the specified gateway environments.
        - You can use `--rotate-revision` flag with the import command and if the max revision limit reached, import
            operation will **delete the earliest revision for that API and create a new revision**. This new revision will be
            deployed in the specified gateway environments.

    !!!note
        `apictl import-api` command has been deprecated from apictl 4.0.0 onwards. Instead use `apictl import api` as shown above.
       
-   **Response**
    ``` bash
    Successfully imported API!
    ```
    

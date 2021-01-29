# Importing APIs Via Dev First Approach

WSO2 API Controller (**apictl**) allows you to create and deploy APIs without using WSO2 API Publisher Portal. You can use this feature to create an API **from scratch** or **using an existing Swagger or Open API specification** and then deploy it to the desired API Manager environment.

!!! info
    **Before you begin** 

    -   Make sure that the WSO2 API Manager CTL Tool is downloaded and initialized, if not, follow the steps in [Download and Initialize the CTL Tool]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool).

    -   Make sure you already have added an environment using the CTL tool for the API Manager environment you plan to import the API to. 

        If not, follow the steps in [Add an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#add-an-environment).

## Initialize an API Project

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
            
            The following is a sample API definition that can be used to generate an API Project.
            
            !!! example
                ```yaml
                type: api
                version: v4
                data:
                  id: 9045413f-109a-4d95-86ab-44a9af028351
                  name: PizzaShackAPI
                  description: This is a simple API for Pizza Shack online pizza delivery store.
                  context: /pizzashack
                  version: 1.0.0
                  provider: admin
                  lifeCycleStatus: PUBLISHED
                  responseCachingEnabled: false
                  cacheTimeout: 300
                  isDefaultVersion: false
                  enableSchemaValidation: false
                  enableStore: true
                  type: HTTP
                  transport:
                   - http
                   - https
                  tags:
                   - pizza
                  policies:
                   - Unlimited
                  authorizationHeader: Authorization
                  securityScheme:
                   - oauth2
                   - oauth_basic_auth_api_key_mandatory
                  visibility: PUBLIC
                  visibleRoles: []
                  visibleTenants: []
                  gatewayEnvironments:
                   - Production and Sandbox
                  deploymentEnvironments: []
                  labels: []
                  mediationPolicies: []
                  subscriptionAvailability: CURRENT_TENANT
                  subscriptionAvailableTenants: []
                  additionalProperties: {}
                  accessControl: NONE
                  accessControlRoles: []
                  businessInformation:
                    businessOwner: Jane Roe
                    businessOwnerEmail: marketing@pizzashack.com
                    technicalOwner: John Doe
                    technicalOwnerEmail: architecture@pizzashack.com
                  corsConfiguration:
                    corsConfigurationEnabled: false
                    accessControlAllowOrigins:
                     - '*'
                    accessControlAllowCredentials: false
                    accessControlAllowHeaders:
                     - authorization
                     - Access-Control-Allow-Origin
                     - Content-Type
                     - SOAPAction
                     - apikey
                     - testKey
                    accessControlAllowMethods:
                     - GET
                     - PUT
                     - POST
                     - DELETE
                     - PATCH
                     - OPTIONS
                  createdTime: Dec 16, 2020 8:58:06 AM
                  lastUpdatedTime: Dec 16, 2020 8:58:35 AM
                  endpointConfig:
                    endpoint_type: http
                    sandbox_endpoints:
                      url: https://localhost:9443/am/sample/pizzashack/v1/api/
                    endpoint_security:
                      production:
                        password: admin
                        customParameters: {}
                        type: BASIC
                        enabled: true
                        username: admin
                      sandbox:
                        customParameters: {}
                        enabled: false
                    production_endpoints:
                      url: https://localhost:9443/am/sample/pizzashack/v1/api/
                  endpointImplementationType: ENDPOINT
                  scopes: []
                  operations:
                   -
                    id: ""
                    target: /order
                    verb: POST
                    authType: Application & Application User
                    throttlingPolicy: Unlimited
                    scopes: []
                    usedProductIds: []
                   -
                    id: ""
                    target: /menu
                    verb: GET
                    authType: Application & Application User
                    throttlingPolicy: Unlimited
                    scopes: []
                    usedProductIds: []
                   -
                    id: ""
                    target: /order/{orderId}
                    verb: GET
                    authType: Application & Application User
                    throttlingPolicy: Unlimited
                    scopes: []
                    usedProductIds: []
                   -
                    id: ""
                    target: /order/{orderId}
                    verb: PUT
                    authType: Application & Application User
                    throttlingPolicy: Unlimited
                    scopes: []
                    usedProductIds: []
                   -
                    id: ""
                    target: /order/{orderId}
                    verb: DELETE
                    authType: Application & Application User
                    throttlingPolicy: Unlimited
                    scopes: []
                    usedProductIds: []
                  categories: []
                  keyManagers:
                   - all
                ```

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
                When you initialize an API project using an OpenAPI specification, the CTL Tool will automatically read the OpenAPI definition and populate a certain set of configs in the API definition file, `api.yaml`.     

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
            You can define WSO2 APIM supported open API extensions for an API when defining a Swagger2 or OpenAPI3 specification to generate an API. These extensions can be used to define endpoint configurations, runtime configurations, resource level throttling, and API level throttling, transport-level security, CORS configurations and response cache configurations. The list of APIM supported OpenAPI extensions is as follows.

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
        <td><Image</td>
        <td>Contains the thumbnail image of the API.</td>
        </tr>
        </tbody>
    </table>

    !!! note 
        **Changing the Default API Template**

        When you create an API Project, APIs are generated using the default template specified in `<USER_HOME>/.wso2apictl/default_api.yaml` file. Following is the default template used to generate API Projects.  

        ```bash
        type: api
        version: v4
        data:
            name : null
            version: 1.0.0
            context: null
            enableStore: true
            endpointConfig:
                endpoint_type: http
                production_endpoints:
                    url: http://localhost:8080
                sandbox_endpoints:
                    url: http://localhost:8081
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

        This file contains the same notation as the `<API-Project>/api.yaml`. Organization-specific common API related details can be put into this template file and shared across developers.

        To further finetune API creation, a custom API Definition file can be used. If you need to use a specific definition file when generating a certain API project, use the `--definition` or `-d` flag along with `apictl init` command. The custom definition file should be in YAML format only.

        **Generate APIs with Dynamic Data**

        When initializing an API Project, the CTL is capable of detecting environment variables in the default definition file or in the provided custom definition file. For more information on using dynamic data, see [Initialize API Projects with Dynamic Data]({{base_path}}/learn/api-controller/advanced-topics/using-dynamic-data-in-api-controller-projects/#initialize-api-projects-with-dynamic-data).

4. Open the `<API Project>/api.yaml` file. You can edit the **mandatory configurations** in the field named `data` as listed below.

    | Field                                        | Description                                             |
    |----------------------------------------------|---------------------------------------------------------|
    | `name`| The name of API without spaces.                         |
    | `context`| Context of the API in API Manager with a leading slash. |
    | `production_endpoints` | Production endpoints for API.                            |
    | `sandbox_endpoints`| Sandbox endpoint for API.                               |

    For more information about the configurations, see the [Sample_Api.yaml](https://github.com/wso2/product-apim-tooling/blob/master/import-export-cli/box/resources/init/sample_api.yaml).

    **api.yaml**

    ``` bash
        type: api
        version: v4
        data:
            name : SampleAPI
            version: 1.0.0
            context: /sampleapi
            enableStore: true
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


## Import an API Project

!!! info
    **Before you begin...** 

    -   Make sure you have already created an environment to which you are planning to import the API. If not, follow steps in [Add an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#add-an-environment).
    
    -   Make sure you have logged-in to the importing environment. If not, follow steps in [Login to an Environment]({{base_path}}/learn/api-controller/getting-started-with-wso2-api-controller#login-to-an-environment). 


!!! tip
    A user with `admin` role is allowed to import APIs. To create a custom user who can import APIs, refer [Steps to Create a Custom User who can Perform API Controller Operations]({{base_path}}/learn/api-controller/advanced-topics/creating-custom-users-to-perform-api-controller-operations/#steps-to-create-a-custom-user-who-can-perform-api-controller-operations).

After editing the mandatory fields in the API Project, you can import the API to an environment using any of the following commands.  

-   **Command**
    ``` bash
    apictl import api -f <path to API Project> -e <environment> -k
    ```
    ``` bash
    apictl import api --file <path to API Project> --environment <environment> -k
    ```
    ``` bash
    apictl import api --file <path to API Project> --environment <environment> --params=<environment params file> -k
    ```

    !!! info
        **Flags:**  
           
        -   Required :  
            `--file` or `-f` : The file path of the API project to import.  
            `--environment` or `-e` : Environment to which the API should be imported.   
        -   Optional :  
            `--preserve-provider` : Preserve the existing provider of API after importing. The default value is `true`. 
            `--update` : Update an existing API or create a new API in the importing environment.  
            `--params` : Provide a API Manager environment params file (The default file is `api_params.yaml`.).   
            For more information, see [Configuring Environment Specific Parameters]({{base_path}}/learn/api-controller/advanced-topics/configuring-environment-specific-parameters).  
            `--skipCleanup` : Leave all temporary files created in the CTL during import process. The default value is `false`.  

    !!! example
        ```bash
        apictl import api -f ~/myapi -e production -k
        ```
        ```bash
        apictl import api --file ~/myapi --environment production -k
        ```    
        ``` go
        apictl import api --file ~/myapi --environment production --params prod/custom_api_params.yaml -k 
        ```
        
    !!! tip
        When using the `--update` flag with the `import api` command, the CTL tool will check if the given API exists in the targeted environment. If the API exists, it will update the existing API. If not, it will create a new API in the imported environment. 

    !!!note
        `apictl import-api` command has been depcrecated from the API Controller 4.0.0 onwards. Instead use `apictl import api` as shown above.
       
-   **Response**
    ``` bash
    Successfully imported API!
    ```
    

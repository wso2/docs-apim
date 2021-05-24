# Exposing an Integration Service as a Managed API

## What you'll build

In this tutorial, you are defining an integration service using WSO2 Integration Studio and exposing it as a managed API to the API marketplace. API consumers then **discover** the API from the marketplace, **subscribe** to it, and **use it** for application development.

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/exposing-servie-as-managed-api.png" alt="exposing integration service as a managed api">

This demonstrates how the integration components and API management components of WSO2 API Manager 4.0.0 work together to enable API-led integration. The following diagram illustrates the various API Manager components and the different user roles that are involved in implementing this process:

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-led-integration-components.png" alt="exposing integration service as a managed api">

1. An **Integration Developer** creates the service using WSO2 Integration Studio and deploys it in the Micro Integrator runtime.

    !!! Note
        The integration service is designed to communicate with a back-end service (representing a Hospital) and get details of available doctors for various specializations.

2. An **API Creator** converts the integration service to a managed API (apply security, rate limiting, etc.).
3. An **API Publisher** publishes the API to the API marketplace (Developer Portal).
4. An **API Consumer** (application developer) discovers and uses this API from the Developer Portal.

### Concepts and artifacts used

The following concepts and artifacts are used in this tutorial:

-   REST API / Integration Service
-   Endpoints
-   Mediators
-   Service Catalog
-   API Publisher
-   API Developer Portal

## Let's get started!

Follow the steps given below to build this use case and try it out.

### Step 1: Develop the integration service

Follow the instructions given in this section to create and configure the required artifacts.

1.  Download the relevant [WSO2 Integration Studio](https://wso2.com/api-management/tooling/) based on your operating system.
2.  Open **WSO2 Integration Studio**.
3.  Click **New Integration Project** in the **Getting Started** tab as shown below.

    <img src="{{base_path}}/assets/img/integrate/create_project/create-integration-project.png" width="700">

    This will open the <b>New Integration Project</b> dialog box.

4.  Enter `ServiceCatalogSample` as the project name and select the following check boxes to create the required modules.
    -   **Create ESB Configs**
    -   **Create Composite Exporter**

5.  Click **Finish**.

    You can see the projects listed in the **Project Explorer** as shown below:

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/project-explorer-service-catalog.png">

    !!! Note
        A **resources** folder is created in the `ServiceCatalogSampleConfigs` project. This folder holds the Swagger and metadata YAML files. These YAML files will be uploaded to the service catalog later in this tutorial.   

6.  Create an **Endpoint** artifact. 

    1. Right-click **ServiceCatalogSampleConfigs** in the project explorer and click **New -> Endpoint**.
    2. Ensure that **Create a New Endpoint** is selected and click **Next**.
    3. Enter the information given below to create the new endpoint.  
        <table>
        <thead>
        <tr class="header">
            <th>Property</th>
            <th>Value</th>
            <th>Description</th>
        </tr>
        </thead>
        <tbody>
        <tr class="odd">
            <td>Endpoint Name</td>
            <td><code>QueryDoctorEP</code></td>
            <td>The name of the endpoint.</td>
        </tr>
        <tr class="even">
            <td>Endpoint Type</td>
            <td><code>HTTP Endpoint</code></td>
            <td>Indicates that the back-end service is HTTP.</td>
        </tr>
        <tr class="odd">
            <td>URI Template</td>
            <td>
                <code>http://localhost:9090/healthcare/{uri.var.category}</code>
            </td>
            <td>The template for the request URL expected by the back-end service. In this case, the variable 'category' that needs to be included in the request for querying doctors is represented as <code>{uri.var.category}</code> in the template.</td>
        </tr>
        <tr class="even">
            <td>Method</td>
            <td><code>GET</code></td>
            <td>Indicates that we are creating this endpoint for GET requests that are sent to the back-end service.</td>
        </tr>
        <tr class="even">
            <td>Save Endpoint in</td>
            <td><code>ServiceCatalogSampleConfigs</code></td>
            <td>This is the <b>ESB Config</b> module where the artifact will be saved.</td>
        </tr>
        </tbody>
        </table>

    4.  Click **Finish**. 

 7. Create a **REST API** artifact.

    1.  In the project explorer, right-click **ServiceCatalogSampleConfigs** and click **New -> REST API**.
    2.  Ensure **Create A New API Artifact** is selected and click **Next**.
    3.  Enter the details given below to create a new REST API.
        <table>
        <tr>
            <th>Property</th>
            <th>Value</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Name</td>
            <td><code>HealthcareAPI</code></td>
            <td>
            The name of the REST API.
            </td>
        </tr>
        <tr>
            <td>Context</td>
            <td><code>/healthcare </code></td>
            <td>
            This anchors the API in the <code>/healthcare </code> context. The context becomes part of the name of the API's URL, which will be used by the client when sending requests to the Healthcare service. For example, setting the context to /healthcare means that the API only handles HTTP requests where the URL path starts with <code>http://host:port/healthcare<code>.
            </td>
        </tr>
        <tr>
            <td>Save location</td>
            <td>
            ServiceCatalogSampleConfigs
            </td>
            <td>
            This is the <b>ESB Config</b> module where the artifact will be saved.
            </td>
        </tr>
        </table>
                                                                      
    4.  Click **Finish**.

8.  Open the **Source** view of the HealthcareAPI that you created and apply the following.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <api context="/healthcare" name="HealthcareAPI" xmlns="http://ws.apache.org/ns/synapse">
        <resource methods="GET" uri-template="/querydoctor/{category}">
            <inSequence>
                <log description="Request Log" level="custom">
                    <property name="Log Property message" value="&quot;Welcome to HealthcareService&quot;"/>
                </log>
                <send>
                    <endpoint key="QueryDoctorEP"/>
                </send>
            </inSequence>
            <outSequence>
                <send/>
            </outSequence>
            <faultSequence/>
        </resource>
    </api>
    ```

When the **HealthcareAPI** is created, the following two new files are created in the metadata folder. 

!!! Tip
    This data is used later in this tutorial by the API management runtime to generate the managed API proxy.

<table>
    <tr>
        <th>
            HealthcareAPI_metadata.yaml
        </th>
        <td>
            This file contains the metadata of the integration service you created in the previous step.
        </td>
    </tr>
    <tr>
        <th>
            HealthcareAPI_swagger.yaml
        </th>
        <td>
            This Swagger file contains the OpenAPI definition of the integration service.
        </td>
    </tr>
</table>

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/metadata-folder-service-catalog.png" width="400">

### Step 2: Configure service metadata

Let's update the metadata of the integration service.

1.  Open the `HealthcareAPI_metadata.yaml` file from the project explorer.
2.  Update the following values in the file.

    <table>
        <tr>
            <th>
                Parameter
            </th>
            <th>
                Value
            </th>
            <th>
                Description
            </th>
        </tr>
        <tr>
            <td>
                description
            </td>
            <td>
                <code>API to fetch doctors for a given category</code>
            </td>
            <td>
                Explain the purpose of the API.
            </td>
        </tr>
        <tr>
            <td>
                serviceUrl
            </td>
            <td>
                <code>http://localhost:8290/healthcare</code>
            </td>
            <td>
                This is the URL of the API when it gets deployed in the Micro Integrator. You (as the integration developer) may not know this URL during development. Therefore, you can parameterize the URL to be resolved later using environment variables. By default, the <code>{MI_HOST}</code> and <code>{MI_PORT}</code> values are parameterized with placeholders.</br></br>
                You can configure the serviceUrl in the following ways:
                <ul>
                    <li>
                        Add the complete URL without parameters. For example: <code>http://localhost:8290/healthcare</code>.</br>
                        <b>Let's use this option for this tutorial.</b>
                    </li>
                    <li>
                        Parameterize using the host and port combination. For example: <code>http://{MI_HOST}:{MI_PORT}/healthcare</code>.
                    </li>
                    <li>
                        Parameterize using a preconfigured URL. For example: <code>http://{MI_URL}/healthcare</code>.
                    </li>
                </ul>
            </td>
        </tr>
    </table>

    !!! Tip
        See the [Service Catalog API documentation]({{base_path}}/reference/product-apis/service-catalog-apis/service-catalog-v1/service-catalog-v1/) for more information on the metadata in the YAML file.

3.  <b>Important</b>: Be sure to change the `serviceUrl` from HTTPS to HTTP. This is required because the HealthcareAPI is not secured.

4.  Leave the default values for the remaining parameters. 

### Step 3: Configure the Micro Integrator 

The Micro Integrator contains a client application, which automatically publishes artifacts to the **Service Catalog** in the **API Publisher** portal. 

Let's enable this client for the embedded Micro Integrator of WSO2 Integration Studio.

1.  Click the <b>Embedded Micro Integrator Configuration</b> (<img src="{{base_path}}/assets/img/integrate/tutorials/common/server-config-64x64.png" width="20">) icon on the upper menu to open the dialog box.
2.  Uncomment the `[[service_catalog]]` section as shown below and change the APIM server configurations accordingly. 

    !!! Tip
        The default username and password for connecting to the API gateway is `admin`.

    ```toml
    [[service_catalog]]
    apim_host = "https://localhost:9443"
    enable = true
    username = "admin"
    password = "admin"
    ```

3.  **Optionally**, you can encrypt the username and password for better security:

    1.  Update the configuration as shown below. 

        ```toml
        [secrets]
        userName = "[admin]"
        password = "[admin]"

        [[service_catalog]]
        apim_host = "https://localhost:9443"
        enable = true
        username = "$secret{username}"
        password = "$secret{password}"
        ```

    2.  Click **Encrypt Secrets**. 
    
    !!! Tip
        See [Encrypt static (embedded) server secrets]({{base_path}}/integrate/develop/using-embedded-micro-integrator/#encrypt-static-embedded-server-secrets) for details.

4.  Save the configurations.

5.  **Optionally**, inject environment variables to your Micro Integrator.

    If you chose to parameterize the `serviceUrl` in the metadata file, you must inject the parameterized values as environment variables. Shown below are example placeholder values that you may have used in the `serviceUrl` followed by the corresponding environment variables. 

    ```bash
    {MI_HOST}  :  localhost
    {MI_PORT}  :  8290
    {MI_URL}   :  localhost:8290
    ```

    !!! Tip
        See the instructions on [injecting environment variables to the embedded Micro Integrator]({{base_path}}/integrate/develop/using-embedded-micro-integrator/#injecting-environment-variables-to-embedded-micro-integrator).

### Step 4: Package the artifacts

Package the artifacts in your composite exporter module to be able to deploy the artifacts in the server.

1.  Open the `pom.xml` file of the **ServiceCatalogSampleCompositeExporter** module.
2.  Ensure that the following artifacts are selected in the POM file.

    -   `HealthcareAPI`
    -   `QueryDoctorEP`

3.  Save the changes.

### Step 5: Start the API Manager runtime

Let's start the API Manager runtime before starting the Micro Integrator.

1.  Download and set up [WSO2 API Manager 4.0.0](https://wso2.com/api-management/).
2.  Start the server.

### Step 6: Build and run the service

Let's deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

!!! Info
    When you do this step: 

    1.  The Micro Integrator first reads the metadata files. 
    2.  If you used placeholders in the metadata file, they are replaced with environment variable values and a ZIP file is created.
    3.  Finally, it uploads the metadata to the API management runtime.

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.
3.  Click **Finish**.

The artifacts are deployed in the embedded Micro Integrator and the Micro Integrator starts. The integration service is also deployed in the **Service Catalog** during server startup. You will see the following in the server start-up log.

```bash
Successfully updated the service catalog
```


### Step 7: Create and Deploy the API

**Create the API**

Let's expose the integration service as a managed API. 

1.  Sign in to the API Publisher portal: `https://localhost:9443/publisher`. 

    !!! Tip
        Use `admin` as the user name and password.

2.  You can also click the **hamburger** icon on the upper-left and click **Services** to see the available services.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/open-service-catalog.png" alt="open service catalag" width="400">

3.  Open HealthcareAPI from the above list.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/new-service-api-view.png" alt="API created from service catalog">

4.  Click **Create API** in the above screen to open the **Create API** dialog box.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/create-api-from-service.png" alt="create api dialog box">

5.  Specify an API name, context, and version, and then click **Create API**.

    !!! Tip
        You will find these values already populated based on the information in the integration service.

You can now see the new API's overview page.

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-overview.png" alt="new api view">

!!! Note
    -   You can use the left-hand navigation to explore the new API.
    -   Click **Endpoints** in the left-hand navigator. You will see that the new API uses the integration service deployed in the Micro Integrator as the endpoint (backend).
        <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/endpoint-config-of-api.png" alt="endpoint view">

**Select business plans**

Let's allocate some business plans for the API.

1.  Go to the API overview and click **Business Plan**.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-overview-business-plan.png" alt="click to add business plan">

3.  Select at least one business plan for the API and save.
 
    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-business-plans.png" alt="add business plans to api">

**Deploy API in the Gateway**

Let's deploy the API in a gateway environment.

1.  Go to the API overview and click **Deploy**.
    
    !!! Tip
        This opens the **Deployment** tab in the left-hand navigator.
    
    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-overview-deployment.png" alt="open the deployment options">

2.  Click **Default** to specify the gateway environment and host.

    !!! Tip
        This setting deploys the API in Production as well as Sandbox gateways. Find out more about [gateway environments]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways).

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-deployment-revision.png" alt="select gateways for the deployment">

3.  **Optionally**, you can add a description.

4.  Click **Deploy**. 

You will now see the deployment as the first revision of the API:

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-gateway-deployment-summary.png" alt="api first revision">

### Step 8: Publish the API

Go to the API overview in the **Publisher** portal and click **Publish** for the `HealthcareAPI` as shown below.

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/api-overview-publish.png">

The API is now available in the **Developer** portal for consumers to access.

### Step 9: Subscribe to the API

Now, let's assume you are an API consumer who wants to use the API. As a consumer, you need to first subscribe to the API.

1.  Sign in to the **Developer** portal: `https://localhost:9443/devportal/apis`. 

    !!! Tip
        Use `admin` as the username and password.

2.  Go to the **API** tab. The `HealthcareAPI` is listed as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-list.png">

3.  Select the `HealthcareAPI` to open the API overview.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-overview.png">

4.  Go to the **Subscriptions** tab and subscribe using the **DefaultApplication** as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-subscription.png">

!!! Tip
    For detailed instructions, see [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/).

### Step 10: Use the API

!!! Info "Before you begin"

    Let's start the back-end hospital service.

    1.  Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
    2.  Open a terminal, navigate to the location where you saved the back-end service.
    3.  Execute the following command to start the service:

        ```bash
        java -jar Hospital-Service-JDK11-2.0.0.jar
        ```

**Generate access token**

When you consume an API from the marketplace, your access to the API is authenticated. Therefore, the **DefaultApplication** that you used for subscribing to the API should get an access token for the gateway environment in which the API is deployed. Since the `HealthcareAPI` is deployed in the Production gateway, you must generate **PROD** keys.

1.  Go to the **Subscriptions** tab for the `HealthcareAPI` in the **Developer** portal.
2.  Click **PROD KEYS** for the **DefaultApplication**.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-generate-keys.png">

3.  Click **Generate Keys** (at the bottom of this view) to apply a consumer key and secret as shown below.

    !!! Note
        The application may already have a consumer key and secret generated. In this case, you can skip this step. 

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-consumer-keys.png">

4.  Click **Generate Access Token** in the above view to generate the access token.

5.  Save the generated token.

**Try out the service**

Now, let's test the use case by sending a simple client request that invokes the service.

1.  Click **Try Out** for the `HealthcareAPI` in the **Developer** portal as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-try-it.png">

2.  Enter the following details.

    <table>
        <tr>
            <th>
                Security Type
            </th>
            <td>
                Select <b>OAuth</b> as the security type.
            </td>
        </tr>
        <tr>
            <th>
                Applications
            </th>
            <td>
                Select <b>DefaultApplication</b> from the list of application.
            </td>
        </tr>
        <tr>
            <th>
                Key Type
            </th>
            <td>
                Select <b>Production</b> as the key type. This means that the production gateway (environment) is used.
            </td>
        </tr>
        <tr>
            <th>
                access.token
            </th>
            <td>
                Add the access token you generated for the <b>DefaultApplication</b>. You can also click <b>GET TEST KEY</b> to generate a test token.
            </td>
        </tr>
        <tr>
            <th>
                Gateway
            </th>
            <td>
                Select <b>Default</b> as the gateway.
            </td>
        </tr>
    </table>

3.  Expand the **/querydoctor/{category}** resource and click **Try it out**.
4.  Let's specify 'surgery' as the doctor category.
5.  Click **Execute**.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/developer-portal-api-try-it-execute.png">

You will get the response message from the Healthcare service, if you send the category as `surgery`:

```json
[
    {
        "name":"thomas collins",
        "hospital":"grand oak community hospital",
        "category":"surgery",
        "availability":"9.00 a.m - 11.00 a.m",
        "fee":7000.0
    },
    {
        "name":"anne clement",
        "hospital":"clemency medical center",
        "category":"surgery",
        "availability":"8.00 a.m - 10.00 a.m",
        "fee":12000.0
    },
    {
        "name":"seth mears",
        "hospital":"pine valley community hospital",
        "category":"surgery",
        "availability":"3.00 p.m - 5.00 p.m",
        "fee":8000.0
    }
]
```

Now, check the **Console** tab of WSO2 Integration Studio and you will see the following message:

```bash
INFO - LogMediator message = "Welcome to HealthcareService"
```

!!! Tip
    For detailed instructions see [Invoke an API using the Integrated API Console]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/).

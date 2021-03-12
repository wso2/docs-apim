# Exposing an Integration Service as a Managed API

## What you'll build

In this tutorial, you are defining an integration service using WSO2 Integration Studio and exposing it as a managed API. The integration service is designed to communicate with a back-end service (representing a Hospital) and get details of available doctors for various specializations.

This tutorial demonstrates how the integration components and API management components of WSO2 API Manager 4.0.0 work together to facilitate API-led integration. The process is as follows:

1.  Integration developer creates the service using WSO2 Integration Studio.
2.  The service is deployed to the Integration runtime and to the API management runtime simultaneously. 
3.  API publishers will control the API (apply rate limiting, security, etc.) and publish it to the Developer Portal. 

    !!! Note
        The integration service is now available as a managed API in the marketplace. 

4.  API consumers (application developers) will discover and use this API from the Developer Portal.

### Concepts and artifacts used

-   REST API
-   HTTP Endpoint
-   Call Mediator
-   Respond Mediator
-   Service Catalog

## Let's get started!

### Step 1: Set up the workspace

Download the relevant [WSO2 Integration Studio](https://wso2.com/integration/tooling/) based on your operating system.

### Step 2: Develop the integration service

Follow the instructions given in this section to create and configure the required artifacts.

1.  Open **WSO2 Integration Studio**.
2.  Click **New Integration Project** in the **Getting Started** tab as shown below.

    <img src="{{base_path}}/assets/img/integrate/create_project/create-integration-project.png" width="700">

    This will open the <b>New Integration Project</b> dialog box.

3.  Enter `ServiceCatalogSample` as the project name and select the following check boxes to create the required 
    modules.
    -   **Create ESB Configs**
    -   **Create Composite Exporter**

4.  Click **Finish**.

    You can see the projects listed in the **Project Explorer** as shown below:

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/project-explorer-service-catalog.PNG">

    !!! Note
        A **resources** folder is created in the `ServiceCatalogSampleConfigs` project. This folder holds the swagger and metadata YAML files. These YAML files will be uploaded to the service catalog in upcoming steps.   

5.  Create an **Endpoint** artifact. 

    1. Right-click **SampleServicesConfigs** in the project explorer and click **New -> Endpoint**.
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
            <td><code>SampleServicesConfigs</code></td>
            <td>This is the <b>ESB Config</b> module where the artifact will be saved.</td>
        </tr>
        </tbody>
        </table>

    4.  Click **Finish**. 

 6. Create a **REST API** artifact.

    1.  In the Project Explorer, right-click **SampleServicesConfigs** and click **New -> REST API**.
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
            Here you are anchoring the API in the <code>/healthcare </code> context. This will become part of the name of the generated URL used by the client when sending requests to the Healthcare service. For example, setting the context to /healthcare means that the API will only handle HTTP requests where the URL path starts with <code>http://host:port/healthcare<code>.
            </td>
        </tr>
        <tr>
            <td>Save location</td>
            <td>
            SampleServicesConfigs
            </td>
            <td>
            This is the <b>ESB Config</b> module where the artifact will be saved.
            </td>
        </tr>
        </table>
                                                                                                                                                    
    4.  Click **Finish**.

7.  Open the Source view of the HealthcareAPI that you created and apply the following.

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
    This data is used later by the API management runtime to generate the managed API proxy later in this tutorial.

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
            This swagger file contains the OpenAPI definition of integration service.
        </td>
    </tr>
</table>

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/metadata-folder-service-catalog.PNG" width="400">

### Step 3: Configure service metadata

Let's update the metadata of the integration service.

1.  Open the `HealthcareAPI_metadata.yaml` file from the project exporer.
2.  Update the following values in the file.

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
                description
            </td>
            <td>
                Explain the purpose of the API. For example, 'API to fetch doctors for a given category'.
            </td>
        </tr>
        <tr>
            <td>
                serviceUrl
            </td>
            <td>
                This is the URL of the API when it gets deployed in the Micro Integrator. You (as the integration developer) may not know this URL during development. Therefore, you can parameterize the URL to be resolved later using environment variables. By default, the <code>{host}</code> and <code>{port}</code> values are parameterized with placeholders.</br></br>
                You can configure the serviceUrl in the following ways:
                <ul>
                    <li>
                        Add the complete URL without parameters. For example: http://localhost:8290/healthcare.
                    </li>
                    <li>
                        Parameterize using the host and port combination. For example: http://{host}:{port}/healthcare.</br></br>
                        Let's use this option for this tutorial.
                    </li>
                    <li>
                        Parameterize using a preconfigured URL. For example: http://{url}/healthcare.
                    </li>
                </ul>
                <b>Note</b>: Be sure to change the serviceUrl from HTTPS to HTTP. This is required because the HealthcareAPI is not secured.
            </td>
        </tr>
    </table>

    !!! Tip
        See the [Service Catalog API documentation]({{base_path}}/reference/product-apis/service-catalog-apis/service-catalog-v1/) for more information on the metadata in the YAML file.

3.  Leave the default values for the remaining parameters. 

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/edit-metadata-service-catalog.PNG">

### Step 4: Configure the Micro Integrator 

#### Service Catalog client

The Micro Integrator contains a client application, which automatically publishes artifacts to the Service Catalog. 

Let's enable this client for the embedded Micro Integrator of WSO2 Integration Studio.

1.  Open the [Embedded Micro Integrator Configuration](#update-embedded-server-configs-and-libraries) dialog box.
2.  Uncomment the `[[service_catalog]]` section as shown below and change the APIM server configurations accordingly. 

    !!! Tip
        The default username and password for connecting to the API gateway is `admin`.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/configure-toml-service-catalog.PNG">

3.  Optionaly, you can encrypt the username and password for better security. 

    1.  Update the configuration as shown below. 

        ```yaml
        [secrets]
        userName = "[admin]"
        password = "[admin]"

        [[service_catalog]]
        apimHost = "https://127.0.0.1:9443"
        enable = true
        userName = "$secret{userName}"
        password = "$secret{password}"
        ```

    2.  Click **Encrypt Secrets**. 
    
    See [Encrypt static (embedded) server secrets]({{base_path}}/integrate/develop/using-embedded-micro-integrator/#encrypt-static-embedded-server-secrets) for details.

4.  Save the configurations.

#### Environment variables

When configuring the metadata YAML file, we used a parameterized serviceUrl (http://{host}:{port}/healthcare). Now, let's inject the
host and port values to the service url by using environment variables. 

The following mapping shows placeholder values and their relevant environment variables. 

```bash
{host}  :  localhost
{port}  :  8290
```

Add the following two environment variables in the Integration Studio run configurations section. Please refer 
[Injecting environment variables to embedded Micro Integrator]({{base_path}}/integrate/develop/using-embedded-micro-integrator#injecting-environment-variables-to-embedded-micro-integrator) for steps to follow. 

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/env-variable-service-catalog.PNG">

### Step 5: Package the artifacts

Package the artifacts in your composite exporter module to be able to deploy the artifacts in the server.

1.  Open the `pom.xml` file of the **SampleServicesCompositeExporter** module.
2.  Ensure that the following artifacts are selected in the POM file.

    -   `HealthcareAPI`
    -   `QueryDoctorEP`

3.  Save the changes.

### Step 6: Start the WSO2 API Management runtime

Start the API Manager runtime before starting the Micro Integrator.

1.  Download [WSO2 API Manager 4.0.0](https://wso2.com/api-management/).
2.  Start the server.

### Step 7: Build and run the service

Let's deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

!!! Info
    When you do this step: 

    1.  The Micro Integrator first reads the metadata files. 
    2.  Then, it replaces the placeholders with environment variable values and creates a ZIP file.
    3.  Finally, it uploads the metadata to the API management runtime.

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.
4.  Click **Finish**.

The artifacts will be deployed in the embedded Micro Integrator and the server will start. The integration servies will be deployed to the Service Catalog during server start up.

### Step 8: Create a Managed API

Let's expose the integration service that we developed as an API in API Manager. 

1.  Sign in to the Publisher portal: `https://{ip-address}:{port}/publisher`. 
2.  Go to the **Service Catalog** in the left-hand navigator. 
3.  See that the healthcare integration service is listed in the service catalog.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/services-listing-page-publisher.png">

4. Click `Create API` for the healthcare service.
5. Provide the mandatory attributes (name, context, and version) and then create the API proxy.

    !!! Tip
        These values are populated based on the information in integration service.

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/create-api-from-service.png">

6. The created API uses the integration service endpoint as the back-end URL:

    <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/endpoint-config-of-api.png">

7. Publish the API.

### Step 9: Subscribe to the Managed API

You can subscribe by following the instructions given in the [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/).

### Step 10: Test the use case

Let's test the use case by sending a simple client request that invokes the service.

#### Start the back-end service

1. Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location where your saved the back-end service.
3. Execute the following command to start the service:

    ```bash
    java -jar Hospital-Service-JDK11-2.0.0.jar
    ```

#### Invoke the API

[Invoke an API using the Integrated API Console]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/).

You will get the response message from the HealthcareService, if you send the category as `surgery`:

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
`INFO - LogMediator message = "Welcome to HealthcareService"`

You have now created and deployed an API in API Manager that exposes the integration service created in the Micro Integrator. This receives requests, logs a message using the Log mediator, sends the request to a back-end service using the Send mediator, and returns a response to the requesting client.

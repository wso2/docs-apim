# Exposing an Integration Service as a Managed API

## What you'll build

In this tutorial we are re-creating the healthcare API we created in the [Sending a Simple Message to a Service]({{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-service) tutorial, and publish that to the Service Catalog.

## Let's get started!

### Step 1: Develop the integration artifacts

Follow the instructions given in this section to create and configure the required artifacts.

#### Create an Integration project

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
    Note that a **resources** folder is created in the ServiceCatalogSampleConfigs project. This folder will be used to hold the swagger and metadata YAML files. These YAML files will be uploaded to the service catalog in upcoming steps.   

#### Creating artifacts

Create **QueryDoctorEP** and **HealthcareAPI** by following the instructions given in [Create an Endpoint](../sending-a-simple-message-to-a-service/#create-an-endpoint) and [Create a REST API](../sending-a-simple-message-to-a-service/#create-a-rest-api) sections of **Sending a Simple Message to a Service** 
tutorial.

Once the **HealthcareAPI** is created, two new files with following names will be added to the metadata directory automatically.

1.  HealthcareAPI_metadata.yaml
2.  HealthcareAPI_swagger.yaml

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/metadata-folder-service-catalog.PNG" width="400">

!!! Note
    When registering a service in the Service Catalog, we need to provide the OpenAPI definition and metadata of the service we are registering. When creating an API, Integration Studio automatically creates these files for the user.

### Step 2: Configuring meta information

Open the HealthcareAPI_metadata.yaml and do the following changes.

1.  Change the **description** to explain what the API does. (e.g., API to fetch doctors of a given category).
2.  Change `serviceUrl` from HTTPS to HTTP (since HealthcareAPI is not secured).

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/edit-metadata-service-catalog.PNG">

**serviceUrl** is the URL of the API when it gets deployed in the Micro Integrator. The API developer might not 
know this information in the development time. So, the URL can be parametrized to be resolved later using environment 
variables. 

We can configure the serviceUrl in following ways.

1.  Add the complete URL without parameters. e.g.: http://localhost:8290/healthcare
2.  Parameterize using the host and port combination. e.g.: http://{host}:{port}/healthcare
3.  Parameterize using a pre-configured URL. e.g.: http://{url}/healthcare

We will configure the environment variables to resolve {host} and {port} configurations in an upcoming step. 

Please refer this [documentation]({{base_path}}/reference/product-apis/service-catalog-apis/service-catalog-v1/) to get more information on the other fields in the metadata YAML file.

### Step 3: Package artifacts and testing

Package the artifacts, publish to Micro Integrator and test the API is working by following the instructions given 
in [Sending a Simple Message to a Service](../sending-a-simple-message-to-a-service/#step-3-package-the-artifacts) 
tutorial.

### Step 4: Enable the Service Catalog client.

Micro Integrator contains a client application which automatically publish artifacts to the Service Catalog. This 
client is disabled by default. We can enable it by configuring the deployment.toml file as follows.

1.  Open the [Embedded Micro Integrator Configuration](#update-embedded-server-configs-and-libraries) dialog box.
2.  Uncomment the [[service_catalog]] section and change APIM server configurations accordingly. 

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/configure-toml-service-catalog.PNG">

In the username and password fields we have to add the credentials of the APIM admin user. We can secure these 
values using ciphertool by modifying the configuration as follows.

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
After adding this configuration we can encrypt the username and password by clicking the **Encrypt Secrets** button. 
For more information on Encrypting secrets, please refer [Encrypt static (embedded) server secrets]({{base_path}}/integrate/develop/using-embedded-micro-integrator/#encrypt-static-embedded-server-secrets)

### Step 5: Configuring environment variables.

When configuring the metadata YAML file, we used a parameterized serviceUrl (http://{host}:{port}/healthcare). Now, 
we should add the relevant environment variables so that the Micro Integrator can inject those values into the 
placeholders. 

The following mapping shows placeholder values and their relevant environment variables. 
```
{host}  :  MI_HOST
{port}  :  MI_PORT
{url}   :  MI_URL
```

Add the following two environment variables in the Integration Studio run configurations section. Please refer 
[Injecting environment variables to embedded Micro Integrator]({{base_path}}/integrate/develop/using-embedded-micro-integrator#injecting-environment-variables-to-embedded-micro-integrator) for steps to follow. 

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/env-variable-service-catalog.PNG">

### Step 6: Publishing to the Service Catalog

Now we have created an API, enabled the Service Catalog client and configured the environment variables, its 
now time to start both servers and test the publishing to Service Catalog feature. 

!!! Note
    When we enable the Service Catalog and start the Micro Integrator server, first it will look for metadata files, then it will read them and replace the placeholders with environment variable values, create a ZIP file and finally, upload it to the APIM Service Catalog endpoint.

Download and start the [API Manager 4.0.0](https://wso2.com/api-management/)

To test the artifacts, deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.
4.  Click **Finish**.

The artifacts will be deployed in the embedded Micro Integrator and the server will start. The integration servies will be deployed to the Service Catalog during server start up.

### Step 7: Deploy the service as API in API Manager

Let's expose the integration service that we developed as an API in API Manager. 

Login to the Publisher portal by browsing `https://{ip-address}:{port}/publisher`. If you navigate to the **Service Catalog** tab from left menu, it will list the services that are deployed in Service Catalog as shown in the screenshot given below:

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/services-listing-page-publisher.png">

#### Create and Deploy the API

1. Select the `Create API` option in the Service Listing page.

2. Provide the mandatory attributes name, context and version and create the API

   <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/create-api-from-service.png">

   As you can see in the image, the name, context and version values will be auto populated based on the integration service that you selected.

3. The created API will have the service endpoint as the backend URL:

   <img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/endpoint-config-of-api.png">

4. Publish the API.

#### Start the back-end service

1. Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location where your saved the back-end service.
3. Execute the following command to start the service:

    ```bash
    java -jar Hospital-Service-JDK11-2.0.0.jar
    ```

#### Subscribe and Invoke the API

You can subscribe and invoke the API by following the instructions given in the [Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/) and [Invoke an API using the Integrated API Console]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/) documentation.

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

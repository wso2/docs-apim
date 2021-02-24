# Publishing a sample API to Service Catalog

## What you'll build

In this tutorial we are re-creating the healthcare API we created in the [Sending a Simple Message to a Service](../sending-a-simple-message-to-a-service) tutorial, and publish that to the Service Catalog.

## Let's get started!

### Step 1: Develop the integration artifacts

Follow the instructions given in this section to create and configure the required artifacts.

#### Create an Integration project

1.  Open **WSO2 Integration Studio**.
2.  Click **New Integration Project** in the **Getting Started** tab as shown below.

    <img src="{{base_path}}/assets/img/create_project/create-integration-project.png" width="700">

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

1.  Change the **description** to explain what the API does. ( Ex API to fetch doctors of a given category )
2.  Change serviceUrl from https to http. ( since HealthcareAPI is not secured )

<img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/edit-metadata-service-catalog.PNG">

**serviceUrl** is the URL of the API when it gets deployed in the Micro Integrator. The API developer might not 
know this information in the development time. So, the URL can be parametrized to be resolved later using environment 
variables. 

We can configure the serviceUrl in following ways.

1.  Add the complete URL without parameters. Ex: http://localhost:8290/healthcare
2.  Parameterize using the host and port combination. Ex: http://{host}:{port}/healthcare
3.  Parameterize using a pre-configured URL. Ex: http://{url}/healthcare

We will configure the environment variables to resolve {host} and {port} configurations in an upcoming step. 

Please [refer](link) to get more information on the other fields in the metadata YAML file.

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

Download and start the version 4.0.0 of WSO2 API Manager[link]




To test the artifacts, deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.
4.  Click **Finish**.

The artifacts will be deployed in the embedded Micro Integrator and the server will start.

- See the startup log in the **Console** tab.
- See the URLs of the deployed services and APIs in the **Runtime Services** tab.

### Step 5: Test the use case

Let's test the use case by sending a simple client request that invokes the service.

#### Start the back-end service

1. Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location where your saved the back-end service.
3. Execute the following command to start the service:

    ```bash
    java -jar Hospital-Service-JDK11-2.0.0.jar
    ```

#### Send the client request

Let's send the request to the API. You can use the embedded <b>HTTP Client</b> of WSO2 Integration Studio as follows:

1. Open the <b>HTTP Client</b> of WSO2 Integration Studio.

   !!! Tip
   If you don't see the <b>HTTP Client</b> pane, go to <b>Window -> Show View - Other</b> and select <b>HTTP Client</b> to enable the client pane.

    <img src="{{base_path}}/assets/img/tutorials/common/http4e-client-empty.png" width="800">

2. Enter the request information as given below and click the <b>Send</b> icon (<img src="{{base_path}}/assets/img/tutorials/common/play-head-icon.png" width="20">).

    <table>
        <tr>
            <th>Method</th>
            <td>
               <code>GET</code> 
            </td>
        </tr>
        <tr>
            <th>URL</th>
            <td>
                <code>http://localhost:8290/healthcare/querydoctor/surgery</code></br></br>
            </td>
        </tr>
     </table>

     <img src="{{base_path}}/assets/img/tutorials/119132413/http4e-config.png" width="800">

If you want to send the client request from your terminal:

1. Install and set up [cURL](https://curl.haxx.se/) as your REST client.
2. Execute the following command.
    ```bash
    curl -v http://localhost:8290/healthcare/querydoctor/surgery
    ```

#### Analyze the response

You will see the response message from the HealthcareService with a list of available doctors and the relevant details.

```json
[
  {"name":"thomas collins",
  "hospital":"grand oak community hospital",
  "category":"surgery",
  "availability":"9.00 a.m - 11.00 a.m",
  "fee":7000.0},
  {"name":"anne clement",
   "hospital":"clemency medical center",
   "category":"surgery",
   "availability":"8.00 a.m - 10.00 a.m",
   "fee":12000.0},
  {"name":"seth mears",
   "hospital":"pine valley community hospital",
   "category":"surgery",
   "availability":"3.00 p.m - 5.00 p.m",
   "fee":8000.0}
]
```

Now, check the **Console** tab of WSO2 Integration Studio and you will see the following message:
`INFO - LogMediator message = "Welcome to HealthcareService"`

You have now created and deployed an API resource in the Micro Integrator, which receives requests, logs a message using the Log mediator, sends the request to a back-end service using the Send mediator, and returns a response to the requesting client.

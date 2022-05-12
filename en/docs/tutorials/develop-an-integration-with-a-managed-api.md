# Develop an Integration From a Managed API

The top down approach of API first integration provides the capability for API developers to start creating a managed REST API first in WSO2 API Manager. Then the integration developer can use the same API in the WSO2 Integration Studio to develop the integration later on and expose it to WSO2 API Manager. Thereafter, the API consumers can discover the API from the marketplace, subscribe to it, and use it for application development.

The following stakeholders will be involved in implementing this process:

**Stakeholders**

- API Creator
- Integration developer
- API Publisher
- API Consumer

## What you'll build

Let's work with the following user story in this tutorial.

The API developer needs to create an API first and managed it before adding the backend server implementation. The API developer creates an API via the Control Plane (Publisher Portal), creates mock implementations, and tests the API. The integration developer picks up the API definition, implements the integrations and deploys it in the Micro Integrator server. Thereafter, the API developer adds the service endpoint using API Manager and publishes the created API.

Let's get started!

## Step 1 - Create an API

Let’s create an API in WSO2 API Manager.

1. Sign in to the API Publisher portal. 
 
     `https://localhost:9443/publisher`

2. Click **Create API** and then click **Start from Scratch**.
   
     You can use any option to create the REST API.
	 
	 [![API from scratch menu]({{base_path}}/assets/img/tutorials/api-from-scratch-menu.png)]({{base_path}}/assets/img/tutorials/api-from-scratch-menu.png)

1. Enter the details of the API and click **Create** to create the REST API.
    
     As the backend is not implemented yet, do not enter a value as the endpoint.

    <table>
      <tr>
      <th><b>Field</b></th>
      <th><b>Value</b></th>
      </tr>
      <tr>
        <td>API name</td>
      <td>HealthcareAPI</td>
      </tr>
      <tr>
      <td>Context
      <td>/healthcare</td>
      </tr>
      <tr>
      <td>Version</td>
      <td>1.0.0</td>
      </tr>
    </table>

	 [![Create Healthcare API]({{base_path}}/assets/img/tutorials/create-healthcare-api.png){: style=width:80%}]({{base_path}}/assets/img/tutorials/create-healthcare-api.png)

4.	Let’s add a new GET resource named `/queryDocter/{category}` to the REST API.

	 [![Add GET resource]({{base_path}}/assets/img/tutorials/querydocter-resource.png)]({{base_path}}/assets/img/tutorials/querydocter-resource.png)

5.	You can manage the API the way you want and test out the resource by adding a [Mock Implementation]({{base_path}}/design/prototype-api/create-mocked-js-api).

## Step 2 - Develop the integration service

Let’s start implementing the integration for the created `Healthcare` REST API.

1. Download the relevant [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/) based on your operating system.
   
2. Open WSO2 Integration Studio.

3. Click **New Integration Project** in the **Getting Started** tab as shown below.

4. Enter **ServiceCatalogSample** as the project name and select the following checkboxes to create the required modules.
   
     - Create ESB Configs.

     - Create Composite Exporter.

5. Click **Finish**.

     You will see the projects listed in the **Project Explorer** as shown below:

6.	Create an Endpoint artifact.

	 1.	Right-click on **ServiceCatalogSampleConfigs** in the project explorer, click **New** and click **Endpoint**.

	 2.	Ensure that **Create a New Endpoint** is selected and click **Next**.

	 3.	Enter the information given below to create the new endpoint.

         <table>
         <tr>
         <th><b>Property</b></th>
         <th><b>Value</b></th>
         <th><b>Description</b></th>
         </tr>
         <tr>
         <td>Endpoint Name</td>
         <td>QueryDoctorEP</td>
         <td>The name of the endpoint.</td>
         </tr>
         <tr>
         <td>Endpoint Type</td>
         <td>HTTP Endpoint</td>
         <td>Indicates that the back-end service is HTTP.</td>
         </tr>
         <tr>
         <td>URI Template</td>
         <td><code>http://localhost:9090/healthcare/{uri.var.category}</code></td>
         <td>The template for the request URL expected by the backend service. In this case, the variable <code>category</code> that needs to be included in the request for querying doctors is represented as <code>{uri.var.category}</code> in the template.</td>
         </tr>
         <tr>
         <td>Method</td>
         <td>GET</td>
         <td>This indicates that you are creating this endpoint for GET requests that are sent to the back end service.</td>
         </tr>
         <tr>
         <td>Save Endpoint in</td>
         <td>ServiceCatalogSampleConfigs</td>
         <td>This is the ESB configuration module where the artifact will be saved.</td>
         </tr>
         </table>

	 4.	Click Finish.

7. Create a REST API artifact for the previously created API in the API Publisher.

     1.	In the project explorer, right-click on **ServiceCatalogSampleConfigs**, click **New** and click **REST API**.

     2.	Select **Import API from API Manager**.
	 
	     [![New Synapse API options]({{base_path}}/assets/img/tutorials/new-synapse-api-options.png)]({{base_path}}/assets/img/tutorials/new-synapse-api-options.png)

     3.	Enter the credentials of the API Manager user and API Manager host URl. 
	 
	     For this tutorial let's use the WSO2 API Manager admin credentials.
         
   		!!! note
	        - WSO2 API Manager has introduced a new role named `Internal/integration_dev` for this particular task, which can be assigned to the integration developer who will be using the Integration Studio to carryout this task. 
			- You can create a new user and assign the `Internal/integration_dev` role to the user via the carbon console in WSO2 API Manager.

         <table>
		 <tr>
         <th><b>Property</b></th>
         <th><b>Value</b></th>
         <th><b>Description</b></th>
         </tr>
         <tr>
         <td>Username</td>
         <td>admin</td>
         <td>Username of the API Manager user.</td>
         </tr>
		          <tr>
         <td>Password</td>
         <td>admin</td>
         <td>Password of the API Manager user.</td>
         </tr>
		          <tr>
         <td>API Manager host</td>
         <td><code>https://localhost:9443</code></td>
         <td>Host Url of the API Manager.</td>
         </tr>
         </table>

	4.	Click **List APIs**.

	     [![Import API from API-M]({{base_path}}/assets/img/tutorials/import-api-from-apim.png)]({{base_path}}/assets/img/tutorials/import-api-from-apim.png)

	5.	Click **HealthcareAPI** and click **Finish**. 
	
		 This pulls the Swagger/OpenAPI definition file that corresponds to the API that was created in WSO2 API Manager.

8. Implement the integration solution. 
   
     Let's add a log mediator as well to the integration apart from the created endpoint.

     Open the Source view of the **HealthcareAPI** REST API that you created and delete the existing `<inSequence >` code snippet and apply the following `<inSequence>`.

	```
	 <inSequence>
		<log description="Request Log" level="custom">
			<property name="Log Property message" value="&quot;Welcome to HealthcareService&quot;"/>
		</log>
		<send>
			<endpoint key="QueryDoctorEP"/>
		</send>
	 </inSequence>
    ```

	 The code in the final file should be as follows:

    ```
      <?xml version="1.0" encoding="UTF-8"?>
      <api context="/healthcare" name="HealthcareAPI" version="1.0.0" version-type="context" xmlns="http://ws.apache.org/ns/synapse">
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
      			<respond/>
      		</outSequence>
      		<faultSequence/>
      	</resource>
      </api>
    ```

	 When the HealthcareAPI is created, the following two new files are created in the metadata folder.

    <table>
      <tr>
      <th><b>HealthcareAPI_metadata.yaml</b></th>
      <td>This file contains the metadata of the integration service you created in the previous step.</td>
      </tr>
      <tr>
      <th><b>HealthcareAPI_swagger.yaml</b></th>
      <td>This Swagger file contains the OpenAPI definition of the integration service.</td>
      </tr>
    </table>

	 [![Project explorer]({{base_path}}/assets/img/tutorials/project-explorer.png)]({{base_path}}/assets/img/tutorials/project-explorer.png)

## Step 3 - Configure service metadata

Let's update the metadata of the integration service.

1. Open the `HealthcareAPI_metadata.yaml` file from the project explorer.

2. Update the following values in the file.

    <table>
      <tr>
      <th><b>Property</b></th>
      <th><b>Value</b></th>
      <th><b>Description</b></th>
      </tr>
      <tr>
      <td>description</td>
      <td>API to fetch doctors for a given category.</td>
      <td>Explain the purpose of the API.</td>
      </tr>
      <tr>
      <td>serviceUrl</td>
      <td><code>http://localhost:8290/healthcare</code></td>
      <td>This is the URL of the API when it gets deployed in the Micro Integrator. You (as the integration developer) may not know this URL during development. Therefore, you can parameterize the URL to be resolved later using environment variables. By default, the <code>{MI_HOST}</code> and <code>{MI_PORT}</code> values are parameterized with placeholders.
      <br>
      You can configure the serviceUrl using the following methods:
      <ul>
      <li>
      Add the complete URL without parameters. For example: <code>http://localhost:8290/healthcare</code>. <br/>Let's use this option for this tutorial.</li>
      <li>Parameterize using the host and port combination. <br/>Example: <code>http://{MI_HOST}:{MI_PORT}/healthcare</code>.</li>
      <li>Parameterize using a preconfigured URL. <br/>Example: <code>http://{MI_URL}/healthcare</code>.</li>
      </ul></td>
      </tr>
    </table>

3. Make sure to change the `serviceUrl` from `HTTPS` to `HTTP`. 

	 This is required because the HealthcareAPI is not secured.

4. Leave the default values for the remaining parameters.

## Step 4 - Configure the Micro Integrator

The Micro Integrator contains a client application, which automatically publishes artifacts to the Service Catalog in the API Publisher Portal.

Let's enable this client for the embedded Micro Integrator of WSO2 Integration Studio.

1. Click the Embedded Micro Integrator Configuration icon on the upper menu to open the dialog box.

	 [![Micro Integrator Configuration icon]({{base_path}}/assets/img/tutorials/mi-config-icon.png){: style=width:5%}]({{base_path}}/assets/img/tutorials/mi-config-icon.png)

2. Uncomment the `[[service_catalog]]` section as shown below and change the API-M server configurations accordingly.

    ``` 
 	 [[service_catalog]]
     apim_host = "https://localhost:9443"
     enable = true
     username = "admin"
     password = "admin"
	```

3. Optionally, you can encrypt the username and password for better security:

     1. Update the configuration as shown below.

	    ```
         [secrets]
         userName = "[admin]"
         password = "[admin]"

         [[service_catalog]]
         apim_host = "https://localhost:9443"
         enable = true
         username = "$secret{username}"
         password = "$secret{password}"
        ```

   	 2. Click **Encrypt Secrets**.

4. Save the configurations.

5.	Optionally, inject environment variables to your Micro Integrator.
   
     If you need to parameterize the serviceUrl in the metadata file, you must inject the parameterized values as environment variables. 
	 
	 The following are example placeholder values that you may have used in the serviceUrl followed by the corresponding environment variables.

	 ```
     {MI_HOST}  :  localhost
     {MI_PORT}  :  8290
     {MI_URL}   :  localhost:8290
	 ```

## Step 5 - Package the artifacts

Package the artifacts in your composite exporter module to be able to deploy the artifacts in the server.

1.	Open the `pom.xml` file of the `ServiceCatalogSampleCompositeExporter` module.

2.	Ensure that the following artifacts are selected in the POM file.

     - HealthcareAPI
     - QueryDoctorEP
  
3.	Save the changes.

## Step 6 - Build and run the service

Deploy the packaged artifacts in the embedded Micro Integrator:

1.	Right-click on the composite exporter module and click **Export Project Artifacts and Run**.
2.	Confirm that the required artifacts from the composite exporter module are selected.
3.	Click **Finish**.

	 - The artifacts are deployed in the embedded Micro Integrator and the Micro Integrator starts. 
	 
	 - The integration service is also deployed in the Service Catalog during server startup. 
	 
	 - You will see the following in the server start-up log.

	 	 ```
		 Successfully updated the service catalog
		 ```

## Step 7 - Add the service endpoint to the API

Now let’s add the developed backend service to the API.

1.	Sign in to the Publisher in WSO2 API Manager.

	 ```https://localhost:9443/publisher```

2.	Select the previously created HealthcareAPI.

3.	Click **Endpoint** and then click **Service Endpoint Type**.

4.	Add the production and/or sandbox endpoint.

	 For this tutorial let's only add the production endpoint.

	 1. Click the production endpoint.
	 2. Add the production endpoint using service endpoints.
	 3. Select the `HealthcareAPI` service endpoint from the dropdown.

   [![Service endpoint dropdown]({{base_path}}/assets/img/tutorials/service-endpoint-dropdown.png)]({{base_path}}/assets/img/tutorials/service-endpoint-dropdown.png)

5.	Click **Save**.

## Step 8 - Deploy the API

Depoly the `HealthcareAPI` REST API in the Gateway. For more information, see [Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/#deploy-an-api).

## Step 9 - Start the backend service

Let's start the back-end hospital service.

1. Download the JAR file of the backend service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).

2. Open a terminal, navigate to the location where you saved the backend service.

3. Execute the following command to start the service.

     ```java -jar Hospital-Service-JDK11-2.0.0.jar```


## Step 10 - Subscribe to the API and test it

Subscribe to the `HealthcareAPI` REST API and invoke it. For more information, see [Test a REST API Using the Integrated API Console]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console).

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

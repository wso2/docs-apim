# Using Inbound Endpoints

## What you'll build

In this sample scenario, you will use an **Inbound Endpoint** to expose an already defined REST API through a different port. You can reuse the REST API that was defined in the [Sending a Simple Message to a Service]({{base_path}}/tutorials/integration-tutorials/sending-a-simple-message-to-a-service) tutorial. See [Creating an Inbound Endpoint]({{base_path}}/integrate/develop/creating-artifacts/creating-an-inbound-endpoint) for details on how to work with inbound endpoints using WSO2 Integration Studio.

## Let's get started!

### Step 1: Set up the workspace

Set up WSO2 Integration Studio as follows:

1.  Download the relevant [WSO2 Integration Studio](https://wso2.com/api-management/tooling/) based on your operating system.
2.  Set up the project from the [Sending a Simple Message to a Service](sending-a-simple-message-to-a-service) tutorial:

    !!! Note
        This tutorial is a continuation of the [Sending a Simple Message to a Service](sending-a-simple-message-to-a-service) tutorial.

    1.  Download the [pre-packaged project](https://github.com/wso2-docs/WSO2_EI/blob/master/Integration-Tutorial-Artifacts/Integration-Tutorial-Artifacts-EI7.1.0/sending-simple-message-tutorial.zip).
    2.  Open WSO2 Integration Studio and go to **File -> Import**. 
    3.  Select **Existing WSO2 Projects into workspace** under the **WSO2** category, click **Next**, and then upload the **prepackaged project**.

### Step 2: Develop the Inbound Endpoint

1.  Once you have exported the integration project as described in above, the
    project directory will appear with the artifacts as shown below.
    Note the 'HealthcareAPI' that is already included.

    <img src="{{base_path}}/assets/img/integrate/tutorials/inbound-project-explorer.png" width="400">

2.  Right-click on **SampleServicesConfigs** and navigate to **New -> Inbound
    Endpoint**. Select **Create A New Inbound Endpoint** and click
    **Next**.

3.  Enter the following details and click **Finish**.
    
    <table>
        <tr>
            <th>Parameter</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Inbound Endpoint Name</td>
            <td>
                QueryDoctorInboundEndpoint
            </td>
        </tr>
        <tr>
            <td>Inbound Endpoint Creation Type</td>
            <td>
                HTTP 
            </td>
        </tr>
    </table>

    <img src="{{base_path}}/assets/img/integrate/tutorials/using-inbound-endpoint/create-inbound-dialog-box.png" width="500">

4.  Go to the **Properties** tab in the **Design** view and enter the following:

    <table>
        <tr>
            <th>Parameter</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Inbound HTTP port</td>
            <td>
                8285
            </td>
        </tr>
        <tr>
            <td>Dispatch Filter Pattern</td>
            <td>
                /healthcare/querydoctor/.\*
            </td>
        </tr>
    </table>

    <img src="{{base_path}}/assets/img/integrate/tutorials/using-inbound-endpoint/configure-inbound-endpoint.png">

The endpoint will now get mapped to any URL that matches the above pattern provided. You will be exposing the health care API on a new port through this inbound endpoint.

### Step 3: Package the artifacts

Package the artifacts in your composite exporter module (SampleServicesCompositeExporter) to be able to deploy the artifacts in the server.

1.  Open the `pom.xml` file in the composite exporter module.
2.  Ensure that the following artifacts are selected in the POM file.

    -   `HealthcareAPI`
    -   `QueryDoctorEP`
    -   `QueryDoctorInboundEndpoint`

3.  Save the changes.

### Step 4: Build and run the artifacts

To test the artifacts, deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.     
4.  Click **Finish**. 

The artifacts will be deployed in the embedded Micro Integrator and the server will start.

- See the startup log in the **Console** tab.
- See the URLs of the deployed services and APIs in the **Runtime Services** tab.

### Step 5: Test the use case

Let's test the use case by sending a simple client request that invokes the service.

#### Start the backend service

1. Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location where your saved the back-end service.
3. Execute the following command to start the service:

    ```bash
    java -jar Hospital-Service-JDK11-2.0.0.jar
    ```

#### Send the client request

Let's send a message to the **healthcare** REST API (through the inbound endpoint) on port 8285. You can use the embedded <b>HTTP Client</b> of WSO2 Integration Studio as follows:

1. Open the <b>HTTP Client</b> of WSO2 Integration Studio.

    !!! Tip
        If you don't see the <b>HTTP Client</b> pane, go to <b>Window -> Show View - Other</b> and select <b>HTTP Client</b> to enable the client pane.

    <img src="{{base_path}}/assets/img/integrate/tutorials/common/http4e-client-empty.png" width="800">
    
2. Enter the request information as given below and click the <b>Send</b> icon (<img src="{{base_path}}/assets/img/integrate/tutorials/common/play-head-icon.png" width="20">).
    
    <table>
        <tr>
            <th>Method</th>
            <td>
               <code>GET</code> 
            </td>
        </tr>
        <tr>
            <th>URL</th>
            <td><code>http://localhost:8285/healthcare/querydoctor/surgery</code></br></br>
            </td>
        </tr>
     </table>
     
If you want to send the client request from your terminal:

1.  Install and set up [cURL](https://curl.haxx.se/) as your REST client.
2.  Open a command line terminal and execute the following command:

    ```bash
    curl -v http://localhost:8285/healthcare/querydoctor/surgery
    ```

You will get the response shown below. The inbound endpoint has successfully invoked the REST API, and further, the response received by the REST API has been routed back to the client through the inbound endpoint.

```json
[{"name":"thomas collins","hospital":"grand oak community 
hospital","category":"surgery","availability":"9.00 a.m - 11.00 a.m","fee":7000.0},
{"name":"anne clement","hospital":"clemency medical center","category":"surgery","availability":"8.00 a.m - 10.00 A.m","fee":12000.0},
{"name":"seth mears","hospital":"pine valley community hospital","category":"surgery","availability":"3.00 p.m - 5.00 p.m","fee":8000.0}]
```

# Message Transformation

## What you'll build

Message transformation is necessary when the message format sent by the client is different from the message format expected by the back-end service. The **Message Translator** architectural pattern in WSO2 Micro Integrator describes how to translate from one data format to another.

**In this tutorial**, you send a request message to a back-end service where the format of the request payload is different to what is expected by the back-end service. The **Data Mapper** mediator is used to transform the request message payload to the format expected by the back-end service.

Let’s assume this is the format of the request sent by the client:

```json
{
  "name": "John Doe",
  "dob": "1940-03-19",
  "ssn": "234-23-525",
  "address": "California",
  "phone": "8770586755",
  "email": "johndoe@gmail.com",
  "doctor": "thomas collins",
  "hospital": "grand oak community hospital",
  "cardNo": "7844481124110331",
  "appointment_date": "2017-04-02"
}
```

However, the format of the message compatible with the back-end service is as follows:

```json
{
  "patient": {
    "name": "John Doe",
    "dob": "1990-03-19",
    "ssn": "234-23-525",
    "address": "California",
    "phone": "8770586755",
    "email": "johndoe@gmail.com",
    "cardNo": "7844481124110331"
    },
  "doctor": "thomas collins",
  "hospital": "grand oak community hospital",
  "appointment_date": "2017-04-02"
}
```

The client message format must be transformed to the back-end service message format within the In sequence.

## Let's get started!

### Step 1: Set up the workspace

Set up WSO2 Integration Studio as follows:

1.  Download the relevant [WSO2 Integration Studio](https://wso2.com/integration/tooling/) based on your operating system.
2.  Set up the project from the [Routing Requests Based on Message Content](routing-requests-based-on-message-content) tutorial:

    !!! Note
        This tutorial is a continuation of the [Routing Requests Based on Message Content](routing-requests-based-on-message-content) tutorial.

    1.  Download the [pre-packaged project](https://github.com/wso2-docs/WSO2_EI/blob/master/Integration-Tutorial-Artifacts/Integration-Tutorial-Artifacts-EI7.1.0/message-routing-tutorial.zip).
    2.  Open WSO2 Integration Studio and go to **File -> Import**. 
    3.  Select **Existing WSO2 Projects into workspace** under the **WSO2** category, click **Next**, and then upload the **prepackaged project**.

### Step 2: Develop the integration artifacts

Let's update the API resource that was used in the [previous tutorial](routing-requests-based-on-message-content) by adding a **Data Mapper** mediator to configure the data transforrmation logic.

1.  In WSO2 Integration Studio, add a **Data Mapper** mediator just after
    the Property mediator in the In Sequence of the API resource.

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132205.png">

2.  Double-click the Data Mapper mediator icon and specify the following details:
    <table>
      <tr>
        <th>Property</th>
        <th>Description</th>
      </tr>
      <tr>
        <td>Configuration Name</td>
        <td>Enter <code>RequestMapping</code> as the name.</td>
      </tr>
      <tr>
        <td>Save in project</td>
        <td>Specify the <b>Registry Resource module</b> where the data mapper configuration should be saved. The <b>SampleServicesRegistryResources</b> module created at the time of creating the integration project will selected by default.
      </td>
      </tr>
    </table>

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132224.png" width="500">


    Click **OK**. You can view the data mapping editor.  

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132204.png">

3.  Create a JSON file (e.g., `input.json`) by copying the following sample content of the request message sent to the API resource and save it in your local file system.

    ```json
    { "name": "John Doe",
      "dob": "1990-03-19",
      "ssn": "234-23-525",
      "address": "California",
      "phone": "8770586755",
      "email": "johndoe@gmail.com",
      "doctor": "thomas collins",
      "hospital": "grand oak community hospital",
      "cardNo": "7844481124110331",
      "appointment_date": "2025-04-02"
    }
    ```

    !!! Info
        You can create a JSON schema manually for input and output using the **Data Mapper Diagram** editor.

4.  Right-click on the upper title bar of the **Input** box and click **Load Input** as shown below.

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132200.png" width="300">

5.  Select **JSON** as the **Resource Type** as shown below.

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132203.png" width="300">

6.  Click the **file system** link in **Select resource from**, select the JSON file (i.e., `input.json` ) you saved in your local file system, and click **Open**. You can view the input format loaded in the **Input** box of the editor as shown below.

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132211.png" width="300">

7.  Create another JSON file (e.g., `output.json`) by copying the following sample content of the request message expected by the back-end service and save it in your local file system.

    ```json
    {
      "patient": {
        "name": "John Doe",
        "dob": "1990-03-19",
        "ssn": "234-23-525",
        "address": "California",
        "phone": "8770586755",
        "email": "johndoe@gmail.com"
      },
      "doctor": "thomas collins",
      "hospital": "grand oak community hospital",
      "appointment_date": "2025-04-02"
    }
    ```

8.  Right-click on the top title bar of the **Output** box and click **Load Output** as shown below.  

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132202.png" width="300">

9.  Select **JSON** as the resource type.
10. Click the **file system** link in **Select resource from**, select the JSON file you saved in your local file system, and click **Open**. You can view the input format loaded in the **Output** box in the editor as shown below. 

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132201.png" width="300"> 

    !!! Info
        Check the **Input** and **Output** boxes with the sample messages to see if the element types (i.e. Arrays, Objects and Primitive values) are correctly identified. The following symbols will help you identify them correctly.
    
        -  {} : represents object elements
        -  [] : represents array elements
        -  <> : represents primitive field values
        -  A : represents XML attribute value

11. Now, you need to map the input message with the output message. There are two ways to do the mapping:
    - If you click **Apply**, the mapping will be generated by the **AI Data Mapper**. You have the option to manually change the mapping after it is generated.
    - You can also manually draw the mapping by dragging arrows from the values in the **Input** box to the relevant values in the **Output** box.  

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132199.png">

    The completed mapping will look as follows:

    <img src="{{base_path}}/assets/img/tutorials/119132196/data-mapping.png">

12. Save and close the configuration.

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132197.png">

13. Go back to the **Design View** of the API Resource and select the **Data Mapper** mediator and edit the following in the **Properties** tab:
    <table>
      <tr>
        <th>Property</th>
        <th>Description</th>
      </tr>
      <tr>
        <td>Input Type</td>
        <td>
          Select <b>JSON</b>.
        </td>
      </tr>
      <tr>
        <td>Output Type</td>
        <td>
          Select <b>JSON</b>.
        </td>
      </tr>
    </table>

    <img src="{{base_path}}/assets/img/tutorials/119132196/119132198.png">
    
14. Save the REST API configuration.

You have successfully created all the artifacts that are required for this use case. 

### Step 3: Package the artifacts

Package the artifacts in your composite exporter module (SampleServicesCompositeExporter) to be able to deploy the artifacts in the server.

1.  Open the `          pom.xml         ` file in the composite exporter module.
2.  Ensure that the following projects and artifacts are selected in the POM file.

    -   SampleServicesCompositeExporter
        -   `HealthcareAPI`
        -   `ClemencyEP`
        -   `GrandOakEP`
        -   `PineValleyEP`
    -   SampleServicesRegistryResources

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

#### Start the back-end service

1. Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location where your saved the back-end service.
3. Execute the following command to start the service:

    ```bash
    java -jar Hospital-Service-JDK11-2.0.0.jar
    ```

#### Send the client request

Let's send a request to the API resource to make a reservation. You can use the embedded <b>HTTP Client</b> of WSO2 Integration Studio as follows:

1. Open the <b>HTTP Client</b> of WSO2 Integration Studio.

    !!! Tip
        If you don't see the <b>HTTP Client</b> pane, go to <b>Window -> Show View - Other</b> and select <b>HTTP Client</b> to enable the client pane.

    <img src="{{base_path}}/assets/img/tutorials/common/http4e-client-empty.png" width="800">

2. Enter the request information as given below and click the <b>Send</b> icon (<img src="{{base_path}}/assets/img/tutorials/common/play-head-icon.png" width="20">).
    
    <table>
        <tr>
            <th>Method</th>
            <td>
               <code>POST</code> 
            </td>
        </tr>
        <tr>
            <th>Headers</th>
            <td>
              <code>Content-Type=application/json</code>
            </td>
        </tr>
        <tr>
            <th>URL</th>
            <td><code>http://localhost:8290/healthcare/categories/surgery/reserve</code></br></br>
              <ul>
                <li>
                  The URI-Template format that is used in this URL was defined when creating the API resource:
          <code>http://host:port/categories/{category}/reserve</code>.
                </li>
              </ul>
            </td>
        </tr>
        <tr>
            <th>Body</th>
            <td>
            <div>
              <code>
                {
                  "name": "John Doe",
                  "dob": "1990-03-19",
                  "ssn": "234-23-525",
                  "address": "California",
                  "phone": "8770586755",
                  "email": "johndoe@gmail.com",
                  "doctor": "thomas collins",
                  "hospital": "grand oak community hospital",
                  "cardNo": "7844481124110331",
                  "appointment_date": "2025-04-02"
                }
              </code>
            </div></br>
            <ul>
              <li>
                This JSON payload contains details of the appointment reservation, which includes patient details, doctor, hospital, and data of appointment.
              </li>
            </ul>
        </tr>
     </table>
     
     <img src="{{base_path}}/assets/img/tutorials/119132196/http4e-client-message-transformation.png" width="800">

If you want to send the client request from your terminal:

1. Install and set up [cURL](https://curl.haxx.se/) as your REST client.
2. Create a JSON file named `request.json` with the following request payload.
    ```json
    {
      "name": "John Doe",
      "dob": "1990-03-19",
      "ssn": "234-23-525",
      "address": "California",
      "phone": "8770586755",
      "email": "johndoe@gmail.com",
      "doctor": "thomas collins",
      "hospital": "grand oak community hospital",
      "cardNo": "7844481124110331",
      "appointment_date": "2025-04-02"
    }
    ```
3. Open a terminal and navigate to the directory where you have saved the `request.json` file.
4. Execute the following command.
    ```json
    curl -v -X POST --data @request.json http://localhost:8290/healthcare/categories/surgery/reserve --header "Content-Type:application/json"
    ```
    
#### Analyze the response

You will see the following response received to your <b>HTTP Client</b>:

```json
{"appointmentNumber":1,
    "doctor":
          {"name":"thomas collins",
           "hospital":"grand oak community hospital",
           "category":"surgery","availability":"9.00 a.m - 11.00 a.m",
                "fee":7000.0},
    "patient":
      {"name":"John Doe",
       "dob":"1990-03-19",
       "ssn":"234-23-525",
       "address":"California",
       "phone":"8770586755",
       "email":"johndoe@gmail.com"},
  "fee":7000.0,
  "confirmed":false,
  "appointmentDate":"2025-04-02"
}
```

You have now explored how the Micro Integrator can receive a message in one format and transform it into the format expected by the back-end service using the Data Mapper mediator.

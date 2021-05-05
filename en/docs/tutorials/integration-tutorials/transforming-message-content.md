# Translating Message Formats

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
  "hospital_id": "grandoaks",
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
  "hospital_id": "grandoaks",
  "hospital": "grand oak community hospital",
  "appointment_date": "2017-04-02"
}
```

The client message format must be transformed to the back-end service message format within the In sequence.

## Let's get started!

### Step 1: Set up the workspace

Download the relevant [WSO2 Integration Studio](https://wso2.com/api-management/tooling/) based on your operating system.

### Step 2: Develop the integration artifacts

#### Create an Integration project

An Integration project is a maven multi module project, which will contain all the required modules for the integration solution.

1.  Open **WSO2 Integration Studio**.
2.  Click **New Integration Project** in the **Getting Started** tab as shown below. 

    <img src="{{base_path}}/assets/img/integrate/tutorials/common/create-integration-project.png" width="700">

    This will open the <b>New Integration Project</b> dialog box.

    <img src="{{base_path}}/assets/img/integrate/tutorials/common/create-simple-message-project.png" width="500">

3.  Enter `SampleServices` as the project name and select the following check boxes to create the required modules.
    -   **Create ESB Configs**
    -   **Create Composite Exporter**
    -   **Create Registry Resources**

4.  Click **Finish**. 

You will now see the projects listed in the **Project Explorer**.

#### Create a REST API

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

4.  Click the default API Resource to access the **Properties** tab and enter the following details:

    <table>
    <tr>
        <th>Property</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Url Style</td>
        <td>
            Click in the <b>Value</b> field, click the down arrow, and select <b>URI_TEMPLATE</b> from the list.
        </td>
    </tr>
    <tr>
        <td>URI-Template</td>
        <td>
            Enter <code>/categories/{category}/reserve</code>.
        </td>
    </tr>
    <tr>
        <td>Methods</td>
        <td>
            From the list of methods, select <b>POST</b>.
        </td>
    </tr>
    </table>

    <img src="{{base_path}}/assets/img/integrate/tutorials/119132155/119132164.png">

#### Create new Endpoint

Let's create an Endpoint to represent the Hospital Service back-end service.

1.  Right click **SampleServicesConfigs** in the project explorer and click **New -> Endpoint**. 
2.  Ensure **Create a New Endpoint** is selected and click **Next**.
3.  Let's create the hospital service endpoint (**HospitalServicesEP**) using the following values:

    <table>
        <tr>
            <th>Property</th>
            <th>Value</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Endpoint Name </td>
            <td>
                <code>HospitalServicesEP</code>
            </td>
            <td>
                This is a single endpoint configured to forward requests to the relevant hospital by reading the hospital specified in the request payload.
            </td>
        </tr>
        <tr>
            <td>Endpoint Type </td>
            <td>
                <code>HTTP Endpoint</code>
            </td>
            <td>
                Indicates that the back-end service is HTTP.
            </td>
        </tr>
        <tr>
            <td>URI Template</td>
            <td>
                <code>http://localhost:9090/{uri.var.hospital}/categories/{uri.var.category}/reserve</code>
            </td>
            <td>
                The template for the request URL expected by the back-end service. The following two variables will be replaced by the corresponding values in the request message:
                <ul>
                  <li>{uri.var.hospital}</li>
                  <li>{uri.var.category}</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Method</td>
            <td>
                <code>POST</code>
            </td>
            <td>
                Endpoint HTTP REST Method.
            </td>
        </tr>
      <tr>
         <td>Save Endpoint in</td>
         <td><code>               SampleServicesConfigs              </code></td>
         <td>This is the ESB Config module we created in the last section.</td>
      </tr>
    </table>

4.  Click **Finish**.

#### Define the mediation flow

Let's configure the API resource with the data transforrmation logic.

1.  Drag a **Property** mediator from the **Mediators** palette to the In Sequence of the API resource and name it **Get Hospital**. 

    !!! Info
        This is used to extract the hospital name that is sent in the request payload. 

2.  With the **Property** mediator selected, access the **Properties** tab and give the following details:

    <table>
      <tr>
        <th>Property</th>
        <th>Value</th>
        <th>Description</th>
      </tr>
      <tr>
        <td>Property Name</td>
        <td><code>New Property...</code></td>
        <td>Specifies that a new property is created.</td>
      </tr>
      <tr>
        <td>New Property Name</td>
        <td><code>uri.var.hospital</code></td>
        <td>The name that will be used to refer this property's values.</td>
      </tr>
      <tr>
        <td>Property Action</td>
        <td><code>set</code></td>
        <td>The property action.</td>
      </tr>
      <tr>
        <td>Property Scope</td>
        <td><code>default</code></td>
        <td>The scope of the property.</td>
      </tr>
      <tr>
        <td>Value (Expression)</td>
        <td><code>json-eval(&#36;.hospital_id)</code></td>
        <td>
          <div class="content-wrapper">
            <p>Follow the steps given below to specify the expression value:</p>
            <img src="{{base_path}}/assets/img/integrate/tutorials/119132155/expression-value.png">
          <ol>
              <li>
                Click the <strong>Ex</strong> button before the <b>Value</b> field. This specifies the value type as <i>expression</i>.
              </li>
              <li>
                Now, click the <strong>f</strong> button to open the <b>Expression Selector</b> dialog box.
              </li>
              <li>
                Enter <code>json-eval($.hospital_id)</code> as the expression value.
              </li>
          </ol>
              <b>Note</b>:
              This is the JSONPath expression that will extract the hospital from the request payload.
          </div>
        </td>
      </tr>
    </table>

3.  Add a **Data Mapper** mediator just after
    the Property mediator in the In Sequence of the API resource.

    <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/add-data-mapper.png">

4.  Double-click the Data Mapper mediator icon and specify the following details:
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

    <img src="{{base_path}}/assets/img/integrate/tutorials/119132196/119132224.png" width="500">

    Click **OK**. You can view the data mapping editor.  

    <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/data-mapper-canvas.png">

5.  Create a JSON file (e.g., `input.json`) by copying the following sample content of the request message sent to the API resource and save it in your local file system.

    ```json
    { "name": "John Doe",
      "dob": "1990-03-19",
      "ssn": "234-23-525",
      "address": "California",
      "phone": "8770586755",
      "email": "johndoe@gmail.com",
      "doctor": "thomas collins",
      "hospital_id": "grandoaks",
      "hospital": "grand oak community hospital",
      "cardNo": "7844481124110331",
      "appointment_date": "2025-04-02"
    }
    ```

    !!! Info
        You can create a JSON schema manually for input and output using the **Data Mapper Diagram** editor.

6.  Click **Load Input File** in the **Input** box to open the **Load Input** dialog box.

7.  Select **JSON** as the **Resource Type**.

8.  Click **file system** link in **Select resource from**, select the JSON file (i.e., `input.json` ) you saved in your local file system, and click **Open**. You can view the input format loaded in the **Input** box of the editor as shown below.

    <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/load-data-input-data-mapper.png" width="300">

9.  Create another JSON file (e.g., `output.json`) by copying the following sample content of the request message expected by the back-end service and save it in your local file system.

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
      "hospital_id": "grandoaks",
      "hospital": "grand oak community hospital",
      "appointment_date": "2025-04-02"
    }
    ```
    
10. Click **Load Output File** in the **Output** box to open the **Load Output** dialog box.

11. Select **JSON** as the **Resource Type**.

12. Click the **file system** link in **Select resource from**, select the JSON file you saved in your local file system, and click **Open**. You can view the input format loaded in the **Output** box in the editor as shown below. 

    <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/load-data-output-data-mapper.png" width="300">

    !!! Info
        Check the **Input** and **Output** boxes with the sample messages to see if the element types (i.e. Arrays, Objects and Primitive values) are correctly identified. The following symbols will help you identify them correctly.
      
          -  {} : represents object elements
          -  [] : represents array elements
          -  <> : represents primitive field values
          -  A : represents XML attribute value

13. Now, you need to map the input message with the output message. There are two ways to do the mapping:
    - If you click **Apply**, the mapping will be generated by the **AI Data Mapper**. You have the option to manually change the mapping after it is generated.
    - You can also manually draw the mapping by dragging arrows from the values in the **Input** box to the relevant values in the **Output** box.  

    <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/input-output-data-mapper.png">

    The completed mapping will look as follows:

    <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/mapping-data-input-output.png">

14. Save and close the configuration.

15. Go back to the **Design View** of the API Resource and select the **Data Mapper** mediator and edit the following in the **Properties** tab:
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

    <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/data-mapper-properties.png">

16.  Add a Call mediator from the **Mediators** palette and add the HospitalServicesEP endpont from the **Defined Endpoints** palette to the empty box adjoining the Call mediator.

      <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/add-call-mediator-for-transformation.png">

17. Add a **Respond mediator** next to the **Call** mediator to return the response from the health care service back to the client.

      <img src="{{base_path}}/assets/img/integrate/tutorials/message-transformation/add-respond-mediator-for-transformation.png">
    
18. Save the REST API configuration.

You have successfully created all the artifacts that are required for this use case. 

### Step 3: Package the artifacts

Package the artifacts in your composite exporter module (SampleServicesCompositeExporter) to be able to deploy the artifacts in the server.

1.  Open the `          pom.xml         ` file in the composite exporter module.
2.  Ensure that the following projects and artifacts are selected in the POM file.

    -   SampleServicesCompositeExporter
        -   `HealthcareAPI`
        -   `HospitalServicesEP`
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

    <img src="{{base_path}}/assets/img/integrate/tutorials/common/http4e-client-empty.png" width="800">

2. Enter the request information as given below and click the <b>Send</b> icon (<img src="{{base_path}}/assets/img/integrate/tutorials/common/play-head-icon.png" width="20">).
    
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
                  "hospital_id": "grandoaks",
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
      "hospital_id": "grandoaks",
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

# Connecting Web APIs/Cloud Services

## What you'll build

When you integrate the systems in your organizaion, it is also necessary to integrate with third-party systems and its capabilities to enhance your services. WSO2 Micro Integrator uses **Connectors** for the purpose of referring the APIs of third-party systems.

**In this tutorial**, when a client sends an appointment reservation request to the Micro Integrator, the client should receive an email confirming the appointment reservation details. To build this use case, you can add an Email connector to the mediation flow.

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
    -   **Create Connector Exporter**

4.  Click **Finish**. 

You will now see the projects listed in the **Project Explorer**.

#### Create the REST API

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

4.  Click the new API Resource to access the **Properties** tab and enter the following details:

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
    
#### Create an Endpoint

Let's create an HTTP endpoint to represent the Hospital Service.

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
         <td>Static Endpoint</td>
         <td><br/>
         </td>
         <td>Select this option because we are going to use this endpoint only in this ESB Config module and will not reuse it in other projects.</br/></br/> <b>Note</b>: If you need to create a reusable endpoint, save it as a Dynamic Endpoint in either the Configuration or Governance Registry.</td>
      </tr>
      <tr>
         <td>Save Endpoint in</td>
         <td><code>               SampleServicesConfigs              </code></td>
         <td>This is the ESB Config module we created in the last section.</td>
      </tr>
    </table>

4.  Click **Finish**

#### Importing the Email Connector into WSO2 Integration Studio

1. Right click on **Sample Services Configs** module in the Project Explorer and select **Add or Remove Connector/Module**.
2. Select **Add Connector/module** and click **Next**. You are now connected to the [WSO2 Connector store](https://store.wso2.com).
3. Find **Email** from the list of connectors and click the **Download** button (for the Email connector). 
    <img src="{{base_path}}/assets/img/integrate/tutorials/119132294/import-gmail-connector.png" width="500">

4. Click **Finish**.
   The connector is now downloaded to your workspace in WSO2 Integration Studio and the connector operations are available in the Email Connector palette.  
    <img src="{{base_path}}/assets/img/integrate/tutorials/119132294/select-connector-dialog.png" width="300">

Let's use these connector operations in the configuration.

#### Update the message flow

You can now start updating the API resource with the mediation flow.

1.  Open the REST API resource. You will see the canvas for the in sequence and out sequence as shown below.
2.  Drag a **Property** mediator from the **Mediators** palette to the In Sequence of the API resource and name it **Get Hospital**. This is used to extract the hospital name that is sent in the request payload. 
3.  With the **Property** mediator selected, access the **Properties** tab and give the following details:

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

2.  Add a Property Mediator to retrieve and store the patient's email address.
3.  With the Property mediator selected, access the **Property** tab of the mediator and fill in the information in the following table:

    <table>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
      <tr class="odd">
         <td>Property Name</td>
         <td>Enter <code>               New Property...              </code>.</td>
      </tr>
      <tr class="even">
         <td>New Property Name</td>
         <td>Enter <code>email_id</code>.</td>
      </tr>
      <tr class="odd">
         <td>Property Action</td>
         <td>Enter <code>               set              </code>.</td>
      </tr>
      <tr class="even">
         <td>Value Type</td>
         <td>Enter <code>               EXPRESSION              </code>.</td>
      </tr>
      <tr class="even">
         <td>Value Expression</td>
         <td>
            <div class="content-wrapper">
              <p>Follow the steps given below to specify the expression:</p>
            <ol>
                <li>Click the text box for the <strong>Value Expression</strong> field. This opens the <b>Expression Selector</b> dialog box.</li>
               <li>Select <strong>Expression</strong> from the list.
                </li>
               <li>Enter <code>json-eval($.patient.email)</code> to overwrite the default expression.</li>
               <li>Click <strong>OK</strong>.<br />
               </li>
            </ol>
            </div>
         </td>
      </tr>
      <tr>
          <td>Description</td>
          <td>Get Email ID</td>
      </tr>
    </table>

4.  Add a Call mediator from the **Mediators** palette and add the HospitalServicesEP endpont from the **Defined Endpoints** palette to the empty box adjoining the Call mediator.

    !!! Info
        Using the Call mediator allows us to define other service invocations following this mediator.

    !!! Note
        The following response will be returend from GrandOakEP, ClemencyEP, or PineValleyEP:
        ```json
        {"appointmentNumber":1,   "doctor":
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
               "confirmed":false}
        ```

3.  Add another Property mediator just after the Call mediator to retrieve and store the response sent from HospitalServiceEP. This will be used within the body of the email.

4.  With the Property mediator selected, access the **Property** tab and specify the details given below.

    | Property            | Value                   |
    |-------------------|-------------------------|
    | Property Name     | Select **New Property** |
    | New Property Name | hospital_response        |
    | Property Action   | Select **Set**          |
    | Value Type        | Select **Expression**   |
    | Value Expression  | json-eval($.)           |
    | Description       | Get Hospital Response    |

5.  Drag and drop the <i>send</i> operation from the **Email Connector** palette adjoining the Property mediator you added in the previous step.
6.  With the <i>send</i> operation selected, access the Property tab and create a connection by clicking on the '+' icon.
        
    In the pop up window, following parameters must be provided.

    !!! Tip
        If you have enabled 2-factor authentication, an app password should be obtained as instructed [here](https://support.google.com/accounts/answer/185833?hl=en).


    | Property               | Value                                                                                                   |
    |-----------------------|---------------------------------------------------------------------------------------------------------|
    | Connection Name       | smtpconnection                                                                                       |
    | Connection Type       | Select **SMTP Secured Connection**                           |
    | Host                  | smtp.gmail.com                           |
    | Port                  | 465                                                                      |
    | Username              | Your email address                                               |
    | Password              | Your email password                          |

7.  After the connection is successfully created, select the created connection as 'Connection' from the drop down in the properties window.
8.  Specify the following details in the Properties tab;

    <table>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>From</td>
            <td>
              Enter your email address as the value. This will be account from which the email is sent.
            </td>
        </tr>
        <tr>
            <td>To</td>
            <td>
              Enter `$ctx:email_id` as the value. This retrieves the patient email address that was stored in the relevant Property mediator.  
            </td>
        </tr>
        <tr>
            <td>Subject</td>
            <td>
                Enter `Appointment Status` as the value. This is the subject line in the email that is sent out.
            </td>
        </tr>
        <tr>
            <td>Content</td>
            <td>
                Enter `$ctx:hospital_response` as the value. This retrieves the payment response that was stored in the relevant Property mediator.
            </td>
        </tr>
    </table>

8.  Save the updated sequence configuration.

9.  Drag a **Drop** mediator to end the sequence processing.

10.  Right click on **SampleServicesConnectorExporter** and navigate to **New →  Add/Remove Connectors** and select **Add connector/module** and click on **Next** . Select **Workspace** to list down the connectors that were added.  

    <img src="{{base_path}}/assets/img/integrate/tutorials/119132294/add-remove-connectors.png" width="500">

    <img src="{{base_path}}/assets/img/integrate/tutorials/119132294/connector-select-dialog.png" width="500">

11. Select the Email connector from the list and click **OK** and then **Finish**.

### Step 3: Package the artifacts

Package the artifacts in your composite exporter module (SampleServicesCompositeExporter) and the Connector project (SampleServicesConnectorExporter) to be able to deploy the artifacts in the server.

1.  Open the `          pom.xml         ` file in the composite exporter module.
2.  Ensure that the following modules and artifacts are selected in the POM file.

    -   SampleServicesConfigs
        -   `HealthcareAPI`
        -   `HospitalServiceEP`
        -   `Smptpsconnection`
    -   SampleServicesConnectorExporter

3.  Save the file.

### Step 4: Build and run the artifacts

To test the artifacts, deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

1.  Right-click the Composite Exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog that opens, make sure all the artifacts of the project are selected.  
4.  Click **Finish**. The artifacts will be deployed in the embedded Micro Integrator and the server will start. See the startup log in the **Console** tab.

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

Let's send a request to the API resource. You can use the embedded <b>HTTP Client</b> of WSO2 Integration Studio as follows:

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
          <code>http://<host>:<port>/categories/{category}/reserve</code>.
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
                  "patient": {
                  "name": "John Doe",
                  "dob": "1940-03-19",
                  "ssn": "234-23-525",
                  "address": "California",
                  "phone": "8770586755",
                  "email": "johndoe@gmail.com",
                  "cardNo": "7844481124110331"
                  },
                  "doctor": "thomas collins",
                  "hospital_id": "grandoaks",
                  "hospital": "grand oak community hospital",
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

1.  Install and set up [cURL](https://curl.haxx.se/) as your REST client.
2.  Create a JSON file names `request.json` with the following request payload. Make sure you provide a valid email address so that you can test the email being sent to the patient.

    ```json
    {
      "patient": {
      "name": "John Doe",
      "dob": "1940-03-19",
      "ssn": "234-23-525",
      "address": "California",
      "phone": "8770586755",
      "email": "johndoe@gmail.com",
      "cardNo": "7844481124110331"
      },
      "doctor": "thomas collins",
      "hospital_id": "grandoaks",
      "hospital": "grand oak community hospital",
      "appointment_date": "2025-04-02"
    }
    ```

3.  Open a command line terminal and execute the following command from the location where the `request.json` file you created is saved:

    ```bash
    curl -v -X POST --data @request.json http://localhost:8290/healthcare/categories/surgery/reserve --header 
    "Content-Type:application/json"
    ```
   
#### Analyze the response

An email will be sent to the provided patient email address with the following details:

```bash
Subject: Payment Status
             
Message:
    {"appointmentNo":2,"doctorName":"thomas collins","patient":"John
    Doe","actualFee":7000.0,"discount":20,"discounted":5600.0,"paymentID":"8458c75a-c8e0-4d49-8da4-5e56043b1a20","status":"Settled"}
```

You have now explored how to import the Email connector to the Micro Integrator and then use the connector operations to send emails.

# Connecting Web APIs/Cloud Services

## What you'll build

When you integrate the systems in your organizaion, it is also necessary to integrate with third-party systems and its capabilities to enhance your services. WSO2 Micro Integrator uses **Connectors** for the purpose of referring the APIs of third-party systems.

**In this tutorial**, when a client sends an appointment reservation request to the Micro Integrator, the client should receive an email confirming the appointment reservation details. To build this use case, you can add an Email connector to the mediation flow of the REST resource that you defined in the [previous tutorial](storing-and-forwarding-messages).

## Let's get started!

### Step 1: Set up the workspace

Set up WSO2 Integration Studio as follows:

1.  Download the relevant [WSO2 Integration Studio](https://wso2.com/integration/tooling/) based on your operating system. The path to the extracted/installed folder is referred to as `MI_TOOLING_HOME` throughout this tutorial.
2.   If you did not try the [asynchronous messaging](storing-and-forwarding-messages) tutorial yet:
    1.  Open WSO2 Integration Studio and go to **File -> Import**. 
    2.  Select **Existing WSO2 Projects into workspace** under the **WSO2** category, click **Next**, and then upload the [pre-packaged project](https://github.com/wso2-docs/WSO2_EI/blob/master/Integration-Tutorial-Artifacts/Integration-Tutorial-Artifacts-EI7.1.0/StoreAndForwardTutorial.zip).

### Step 2: Develop the integration artifacts

#### Importing the Email Connector into WSO2 Integration Studio

1. Right click on **Sample Services Configs** module in the Project Explorer and select **Add or Remove Connector/Module**.
2. Select **Add Connector/module** and click **Next**. You are now connected to the [WSO2 Connector store](https://store.wso2.com).
3. Find **Email** from the list of connectors and click the **Download** button (for the Email connector). 
    <img src="{{base_path}}/assets/img/tutorials/119132294/import-gmail-connector.png" width="500">

4. Click **Finish**.
   The connector is now downloaded to your workspace in WSO2 Integration Studio and the connector operations are available in the Email Connector palette.  
    <img src="{{base_path}}/assets/img/tutorials/119132294/select-connector-dialog.png" width="300">

Let's use these connector operations in the configuration.

#### Update the message flow

The connector operations are used in the sequence named **PaymentRequestProcessingSequence**. Select this sequence and do the following updates:

1.  Add a Property Mediator just before the Call mediator to retrieve and store the patient's email address.

    <img src="{{base_path}}/assets/img/tutorials/119132294/119132299.png">

2.  With the Property mediator selected, access the **Property** tab of the mediator and fill in the information in the following table:

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

3.  Add another Property mediator just after the Log mediator to retrieve and store the response sent from SettlePaymentEP. This will be used within the body of the email.

    <img src="{{base_path}}/assets/img/tutorials/119132294/119132298.png">

4.  With the Property mediator selected, access the **Property** tab and specify the details given below.

    | Property            | Value                   |
    |-------------------|-------------------------|
    | Property Name     | Select **New Property** |
    | New Property Name | payment_response        |
    | Property Action   | Select **Set**          |
    | Value Type        | Select **Expression**   |
    | Value Expression  | json-eval($.)           |
    | Description       | Get Payment Response    |

5.  Drag and drop the <i>send</i> operation from the **Email Connector** palette adjoining the Property mediator you added in the previous step.

    <img src="{{base_path}}/assets/img/tutorials/119132294/119132297.png">

6.  With the <i>send</i> operation selected, access the Property tab and create a connection by clicking on the '+' icon.
    
    <img src="{{base_path}}/assets/img/tutorials/119132294/create-email-connection.png" width="500">
    
    In the pop up window, following parameters must be provided.

    | Property               | Value                                                                                                   |
    |-----------------------|---------------------------------------------------------------------------------------------------------|
    | Connection Name       | smtpconnection                                                                                       |
    | Connection Type       | Select **SMTP Secured Connection**                           |
    | Host                  | smtp.gmail.com                           |
    | Port                  | 465                                                                      |
    | Username              | Your email address                                               |
    | Password              | Your email password                          |

    !!! Tip
        If you have enabled 2-factor authentication, an app password should be obtained as instructed [here](https://support.google.com/accounts/answer/185833?hl=en).

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
                Enter `Payment Status` as the value. This is the subject line in the email that is sent out.
            </td>
        </tr>
        <tr>
            <td>Content</td>
            <td>
                Enter `$ctx:payment_response` as the value. This retrieves the payment response that was stored in the relevant Property mediator.
            </td>
        </tr>
    </table>

    The updated **PaymentRequestProcessingSequence** should now look like this:  

    <img src="{{base_path}}/assets/img/tutorials/119132294/119132296.png">

8.  Save the updated sequence configuration.
9.  Right click on **SampleServicesConnectorExporter** and navigate to **New →  Add/Remove Connectors** and select **Add connector/module** and click on **Next** . Select **Workspace** to list down the connectors that were added.  

    <img src="{{base_path}}/assets/img/tutorials/119132294/add-remove-connectors.png" width="500">

    <img src="{{base_path}}/assets/img/tutorials/119132294/connector-select-dialog.png" width="500">

10. Select the Email connector from the list and click **OK** and then **Finish**.

### Step 3: Package the artifacts

Package the artifacts in your composite exporter module (SampleServicesCompositeExporter), the registry resource project (SampleRegistryResource project), and the Connector project (SampleServicesConnectorExporter) to be able to deploy the artifacts in the server.

1.  Open the `          pom.xml         ` file in the composite exporter module.
2.  Ensure that the following modules and artifacts are selected in the POM file.

    -   SampleServicesConfigs
        -   `HealthcareAPI`
        -   `ClemencyEP`
        -   `GrandOakEP`
        -   `PineValleyEP`
        -   `ChannelingFeeEP`
        -   `SettlePaymentEP`
        -   `PaymentRequestMessageStore`
        -   `PaymentRequestProcessingSequence`
        -   `PaymentRequestProcessor`
        -   `Smptpsconnection`
    -   SampleServicesRegistryResources
    -   SampleServicesConnectorExporter

3.  Save the file.

### Step 4: Build and run the artifacts

To test the artifacts, deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

1.  Right-click the Composite Exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog that opens, make sure all the artifacts of the project are selected.  
4.  Click **Finish**. The artifacts will be deployed in the embedded Micro Integrator and the server will start. See the startup log in the **Console** tab.

!!! Warning
    Stop the Micro Integrator before proceeding to test. This is because you need to start the broker profile before starting the Micro Integrator.

### Step 5: Test the use case

Let's test the use case by sending a simple client request that invokes the service.

#### Start the back-end service

1. Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location where your saved the back-end service.
3. Execute the following command to start the service:

    ```bash
    java -jar Hospital-Service-JDK11-2.0.0.jar
    ```

#### Start the RabbitMQ Broker
    
Make sure that you have installed and started a RabbitMQ server instance for the Micro-Integrator to communicate with.

See the [RabbitMQ documentation](https://www.rabbitmq.com/download.html) for more information on how to install and run the product.

#### Restart the Micro Integrator

Let's restart the Micro Integrator with the deployed artifacts:

Right-click the composite exporter module and click **Export Project Artifacts and Run** as shown below.

<img src="{{base_path}}/assets/img/tutorials/119132294/restart_server.png" width="400">

The artifacts will be deployed in the embedded Micro Integrator and the server will start.

- See the startup log in the **Console** tab.
- See the URLs of the deployed services and APIs in the **Runtime Services** tab.

#### Send the client request

Let's send a request to the API resource. You can use the embedded <b>HTTP Client</b> of WSO2 Integration Studio as follows:

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
                 "name": "John Doe",
                 "dob": "1940-03-19",
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
     
     <img src="{{base_path}}/assets/img/tutorials/119132294/http-client-request-config.png" width="800">

If you want to send the client request from your terminal:

1.  Install and set up [cURL](https://curl.haxx.se/) as your REST client.

2.  Create a JSON file names `request.json` with the following request payload. Make sure you provide a valid email address so that you can test the email being sent to the patient.

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
    "appointment_date": "2025-04-02"
    }
    ```

3.  Open a command line terminal and execute the following command from the location where the `request.json` file you created is saved:

    ```bash
    curl -v -X POST --data @request.json http://localhost:8290/healthcare/categories/surgery/reserve --header 
    "Content-Type:application/json"
    ```
   
#### Analyze the response

You will see the response as follows:

```
{"message":"Payment request successfully submitted. Payment confirmation will be sent via email."}
```

An email will be sent to the provided patient email address with the following details:

```bash
Subject: Payment Status
             
Message:
    {"appointmentNo":2,"doctorName":"thomas collins","patient":"John
    Doe","actualFee":7000.0,"discount":20,"discounted":5600.0,"paymentID":"8458c75a-c8e0-4d49-8da4-5e56043b1a20","status":"Settled"}
```

You have now explored how to import the Email connector to the Micro Integrator and then use the connector operations to send emails.

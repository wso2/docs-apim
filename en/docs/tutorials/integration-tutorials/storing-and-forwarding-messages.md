# Store and Forward Messages for Guaranteed Delivery

## What you'll build
Store and forward messaging is used for serving traffic to back-end services that can only accept request messages at a given rate. This is also used to ensure guaranteed delivery of messages. Messages never get lost since they are stored in the message store and available for future reference.

**In this tutorial**, instead of sending the request directly to the back-end service, you store the request message in the RabbitMQ broker. You will then use a **Message Processor** to retrieve the message from the store before delivering it to the back-end service.

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

4.  Click **Finish**. 

You will now see the projects listed in the **Project Explorer**.

#### Create a REST API

1.  In the Project Explorer, right-click **SampleServicesConfigs** and go to **New -> REST API**.
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

#### Create the Message Store

Now, let's create a message store artifact to represent the broker.

1.  Right-click **SampleServices** in the project explorer and navigate to **New->Message Store**.
2.  Select **Create a new message-store artifact** and specify the following details:

    <table>
    <tr>
        <th>Property</th>
        <th>Value</th>
        <th>Description</th>
    </tr>
    <tr>
    <td>Message Store Name</td>
    <td><code>HospitalServiceMessageStore</code></td>
    <td>The name of the message store.</td>
    </tr>
    <tr>
    <td>Message Store Type</td>
    <td>RabbitMQ Message Store</td>
    <td>An instance of RabbitMQ server will be used as the broker.</td>
    </tr>
    <tr>
    <td>RabbitMQ Server Host Name</td>
    <td><code>localhost</code></td>
    <td>The address of the RabbitMQ broker</td>
    </tr>
    <tr>
    <td>RabbitMQ Server Port</td>
    <td><code>5672</code></td>
    <td>The port number of the RabbitMQ message broker.</td>
    </tr>
    <tr>
    <td>RabbitMQ Queue Name</td>
    <td>HospitalServiceMessageStoreQueue</td>
    <td>The queue to which the subscription is created.</td>
    </tr>
    <tr>
    <td>RabbitMQ Exchange Name</td>
    <td>exchange</td>
    <td>The name of the RabbitMQ exchange to which the queue is bound.</td>
    </tr>
    <tr>
    <td>Routing Key</td>
    <td>key</td>
    <td>The exchange and queue binding value.</td>
    </tr>
    <tr>
    <td>User Name</td>
    <td>user name</td>
    <td>The user name to connect to the broker.</td>
    <tr>
    <td>Password</td>
    <td>password</td>
    <td>The password to connect to the broker.</td>
    </tr>
    </table>

3.  Click **Finish**.

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

#### Create a Sequence

Let's create a Sequence that uses the message in the message store to send the request to hospital service endpoint.

1.  Right click the **SampleServices** project in the Project Explorer and click **New -> Sequence**. 
2.  Select **Create New Sequence** and give **HospitalServiceSequence** as the name.
3.  Click **Finish**.
4.  In the sequence you have created (in the previous step), drag and drop a Call mediator from the **Mediators** palette and add HospitalServicesEP from the **Defined Endpoints** palette to the empty box adjoining the Call mediator.
5.  Drag and drop a Log mediator from the **Mediators** palette to log the response from HospitalServicesEP. Access the **Property** tab and specify the following details:

    | Field        | Value           |
    |--------------|-----------------|
    | Log Category | INFO |
    | Log Level    | FULL |

6.  Add a Drop mediator from the **Mediators** palette.
7.  Save the updated sequence configuration.

#### Create the Message Processor

Let's create a **Message Sampling Processor** to dispatch the request message from the **Message Store** to the **HospitalServiceSequence**.

!!! Info
    You can also use the **Scheduled Message Forwarding Processor** here and define the endpoint within the processor. The Message Sampling Processor is used because you need to perform mediation on the request message in the next tutorial.

1.  Right-click the **SampleServices** project in the project explorer and click **New -> Message Processor**. Select **create a new message-processor artifact** and specify the details shown below:
    <table>
        <tr class="header">
        <th>Property</th>
        <th>Value</th>
        <th>Description</th>
        </tr>
        <tr class="odd">
        <td>Message Processor Type</td>
        <td>Message Sampling Processor</td>
        <td><p>This processor takes the message from the store and puts it into a sequence.</p></td>
        </tr>
        <tr class="even">
        <td>Message Processor Name</td>
        <td>HospitalServiceMessageProcessor</td>
        <td>The name of the scheduled message forwarding processor.</td>
        </tr>
        <tr class="odd">
        <td>Message Store</td>
        <td>HospitalServiceMessageStore</td>
        <td>The message store from which the scheduled message forwarding processor consumes messages.</td>
        </tr>
        <tr class="even">
        <td>Processor State</td>
        <td>Activate</td>
        <td>Whether the processor needs to be activated or deactivated.</td>
        </tr>
        <tr class="odd">
        <td>Sequence</td>
        <td><div class="content-wrapper">
        <p>Follow the steps given below:</p>
        <ol>
        <li>Click <strong>Browse.</strong></li>
        <li>Click the <strong>workspace</strong> link.</li>
        <li>Click <strong>Carbon Application Sequences &gt; SampleServices</strong> .</li>
        <li>Select <strong>HospitalServiceSequence</strong> and click <strong>OK</strong>.</li>
        </ol>
        </div></td>
        <td>The name of the sequence to which the message from the store needs to be sent.</td>
        </tr>
    </table>

2.  Click **Finish**.

#### Update the mediation flow

Let's update the REST API so that the client request is forwarded to the message store we created above.

1.  Drag a **Property** mediator from the **Mediators** palette to the In Sequence of the API resource and name it **Get Hospital**. 

    !!! Info
        This is used to extract the hospital name that is sent in the request payload. 

2.  With the **Property** mediator selected, access the **Properties** tab and give the following details:

    <table>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
      <tr class="odd">
         <td>Property Name</td>
         <td>Enter <code>New Property...</code>.</td>
      </tr>
      <tr class="even">
         <td>New Property Name</td>
         <td>Enter <code>uri.var.hospital</code>.</td>
      </tr>
      <tr class="odd">
         <td>Property Action</td>
         <td>Enter <code>set</code>.</td>
      </tr>
      <tr class="even">
         <td>Property Scope</td>
         <td>Enter <code>default</code>.</td>
      </tr>
      <tr class="odd">
         <td>Value</td>
         <td>
            <div class="content-wrapper">
              <p>Follow the steps given below to specify the expression value:</p>
              <img src="{{base_path}}/assets/img/integrate/tutorials/119132155/expression-value.png">
            <ol>
                <li>Click the <strong>Ex</strong> button before the <b>Value</b> field. This specifies the value type as <i>expression</i>.</li>
                <li>
                  Now, click the <strong>f</strong> button to open the <b>Expression Selector</b> dialog box.
                </li>
               <li>Enter <code>json-eval($.hospital_id)</code> as the expression value.</li>
            </ol>
               <b>Note</b>:
               This is the JSONPath expression that will extract the hospital from the request payload.
            </div>
         </td>
      </tr>
    </table>

3.  Drag and add a **Store** mediator from the mediators palette after the Property mediator.

4.  With the Store mediator selected, access the **Property** tab and specify the following details:

    | Field                   | Description                                                       |
    |-------------------------|-------------------------------------------------------------------|
    | Available Message Store | Select **HospitalServiceMessageStore**                             |
    | Message Store           | Double click to populate the value **HospitalServiceMessageStore** |
    | Description             | Hospital Service Store                                                    |

5.  Drag a **Respond mediator** to return the response from the health care service back to the client.

We have now finished creating all the required artifacts.

### Step 3: Package the artifacts

Package the artifacts in your composite application project (SampleServicesCompositeExporter module) to be able to deploy the artifacts in the server.

1.  Open the `          pom.xml         ` file in the composite application project POM editor.
2.  Ensure that the following projects and artifacts are selected in the POM file.

    -   SampleServicesCompositeExporter
        -   `HealthcareAPI`
        -   `HospitalServicesEP`
        -   `HospitalServiceMessageStore`
        -   `HospitalServiceMessageProcessor`
        -   `HospitalServiceSequence`

3.  Save the project.

### Step 4: Start the RabbitMQ Broker
    
Be sure to install and start a RabbitMQ server instance before starting the Micro-Integrator.

See the [RabbitMQ documentation](https://www.rabbitmq.com/download.html) for more information on how to install and run the product.

### Step 5: Build and run the artifacts

To test the artifacts, deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.     
4.  Click **Finish**. 

The artifacts will be deployed in the embedded Micro Integrator and the server will start.

- See the startup log in the **Console** tab.
- See the URLs of the deployed services and APIs in the **Runtime Services** tab.

### Step 6: Test the use case

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
                  The URI-Template format that is used in this URL was defined when creating the API resource QueryDoctorAPI:
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
                    "email": "johndoe@gmail.com"
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

2.  Create a JSON file names `request.json` with the following request payload.

    ```json
    {
        "patient": {
        "name": "John Doe",
        "dob": "1940-03-19",
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

3.  Open a command line terminal and execute the following command from the location where the `request.json` file you created is saved:

    ```bash
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
"appointmentDate":"2025-04-02"}
```

Now check the **Console** tab of WSO2 Integration Studio and you will see the following message: `INFO - LogMediator message = Routing to grand oak community hospital`.

```bash
[2017-04-30 14:33:48,578] [EI-Core]  INFO - LogMediator message = Routing to grand oak community hospital
        
[2017-04-30 14:33:48,598] [EI-Core]  INFO - TimeoutHandler This engine will expire all callbacks after GLOBAL_TIMEOUT: 120 seconds, irrespective of the timeout action, after the specified or optional timeout
        
2017-04-30 14:33:53,464] [EI-Core]  INFO - LogMediator To: http://www.w3.org/2005/08/addressing/anonymous, WSAction: , SOAPAction: , MessageID: urn:uuid:a2cf1fd2-7a89-44b6-9571-990bbdfbd289, Direction: request, Payload: {"appointmentNo":1,"doctorName":"thomas collins","patient":"John Doe","actualFee":7000.0,"discount":20,"discounted":5600.0,"paymentID":"a77038e9-3e42-46f7-ac97-11e1b3a50018","status":"Settled"}
```

You have now explored how the Micro Integratorr can be used to implement store and forward messaging using a **Message Store**, **Message Processors**, and the **Store Mediator**.

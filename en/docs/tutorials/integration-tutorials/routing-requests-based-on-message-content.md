# Message Routing

## What you'll build

In the [Sending a Simple Message to a Service](sending-a-simple-message-to-a-service) tutorial, we routed a
simple message to a single endpoint in the back-end service. In this tutorial, we are building on the same sequence by creating the mediation artifacts that can route a message to the relevant endpoint depending on the content of the message payload.

When the client sends the appointment reservation request to the Micro Integrator, the message payload of the request contains the name of the hospital where the appointment needs to be confirmed. The HTTP request method that is used for this is POST. Based on the hospital name sent in the request message, the Micro Integrator should route the appointment reservation to the relevant hospital's back-end service.

To implement this use case, you will add a new REST resource to the existing REST API and define the new content-based mediation logic.

## Let's get started!

### Step 1: Set up the workspace

Set up WSO2 Integration Studio as follows:

1.  Download the relevant [WSO2 Integration Studio](https://wso2.com/integration/tooling/) based on your operating system.
2.  Set up the project from the [Sending a Simple Message to a Service](sending-a-simple-message-to-a-service) tutorial:

    !!! Note
        This tutorial is a continuation of the [Sending a Simple Message to a Service](sending-a-simple-message-to-a-service) tutorial.

    1.  Download the [pre-packaged project](https://github.com/wso2-docs/WSO2_EI/blob/master/Integration-Tutorial-Artifacts/Integration-Tutorial-Artifacts-EI7.1.0/sending-simple-message-tutorial.zip).
    2.  Open WSO2 Integration Studio and go to **File -> Import**. 
    3.  Select **Existing WSO2 Projects into workspace** under the **WSO2** category, click **Next**, and then upload the **prepackaged project**.

### Step 2: Develop the integration artifacts

Follow the instructions given in this section to create and configure the required artifacts.

#### Create Endpoints

In this tutorial, we have three hospital services hosted as the backend:

-   Grand Oak Community Hospital: `http://localhost:9090/grandoaks/`
-   Clemency Medical Center: `http://localhost:9090/clemency/`
-   Pine Valley Community Hospital: `http://localhost:9090/pinevalley/`

The request method is POST and the format of the request URL expected by the back-end services is
`http://localhost:9090/grandoaks/categories/{category}/reserve`.

Let's create three different HTTP endpoints for the above services.

1.  Right-click **SampleServicesConfigs** in the Project Explorer and navigate to **New -> Endpoint**. 
2.  Ensure **Create a New Endpoint** is selected and click **Next**.
3.  Enter the information given below to create the new endpoint.
    <table>
        <tr>
            <th>Property</th>
            <th>Value</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Endpoint Name </td>
            <td>
                <code>GrandOakEP</code>
            </td>
            <td>
                The name of the endpoint representing the Grand Oaks Hospital service.
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
                <code>http://localhost:9090/grandoaks/categories/{uri.var.category}/reserve</code>
            </td>
            <td>
                The template for the request URL expected by the back-end service.
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

    <img src="{{base_path}}/assets/img/tutorials/119132155/119132166.png" width="500">

4.  Click **Finish**.
5.  Similarly, create the HTTP endpoints for the other two hospital services using the URI Templates given below:
    -   ClemencyEP: `http://localhost:9090/clemency/categories/{uri.var.category}/reserve`
    -   PineValleyEP: `http://localhost:9090/pinevalley/categories/{uri.var.category}/reserve`

You have now created the three endpoints for the hospital back-end services that will be used to make appointment reservations.

!!! Tip
    You can also create a single endpoint where the differentiation of the hospital name can be handled using a variable in the URI template. See the tutorial on [Exposing Several Services as a Single Service](exposing-several-services-as-a-single-service).

    Using three different endpoints is advantageous when the back-end services are very different from one another and/or when there is a requirement to configure error handling differently for each of them.

#### Add a REST resource

To implement the routing scenario, let's add a new API resource to the REST API we created in the [previous tutorial](sending-a-simple-message-to-a-service).

1.  Select **API Resource** in the API palette of the REST API and drag it to the canvas just below the previous API resource that was created.  

    <img src="{{base_path}}/assets/img/tutorials/119132155/119132165.png">

2.  Click the new API Resource to access the **Properties** tab and enter the following details:
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

    <img src="{{base_path}}/assets/img/tutorials/119132155/119132164.png">

#### Define the mediation flow 

You can now start configuring the API resource.

1.  Drag a **Property** mediator from the **Mediators** palette to the In Sequence of the API resource and name it **Get Hospital**. This is used to extract the hospital name that is sent in the request payload. 
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
         <td>Enter <code>Hospital</code>.</td>
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
              <img src="{{base_path}}/assets/img/tutorials/119132155/expression-value.png">
            <ol>
                <li>Click the <strong>Ex</strong> button before the <b>Value</b> field. This specifies the value type as <i>expression</i>.</li>
                <li>
                  Now, click the <strong>f</strong> button to open the <b>Expression Selector</b> dialog box.
                </li>
               <li>Enter <code>json-eval($.hospital)</code> as the expression value.</li>
            </ol>
               <b>Note</b>:
               This is the JSONPath expression that will extract the hospital from the request payload.
            </div>
         </td>
      </tr>
    </table>

3.  Add a **Switch** mediator from the **Mediator** palette just after the Property Mediator.
4.  Right-click the Switch mediator you just added and select **Add/Remove Case** to add the number of cases you want to specify.  

    <img src="{{base_path}}/assets/img/tutorials/119132155/119132163.png">

    We have three different hospital endpoints, which corresponds to three switch cases. Enter 3 for **Number of branches** and click **OK**.  

    <img src="{{base_path}}/assets/img/tutorials/119132155/switch-cases-dialog.png">

5.  With the Switch mediator selected, go to the **Properties** tab and give the following details:
    <table>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
   <tr class="odd">
      <td><strong>Source XPath</strong></td>
      <td>
         <div class="content-wrapper">
            <p>The <strong>Source XPath</strong> field is where we specify the XPath expression, which obtains the value of the Hospital that we stored in the Property mediator.</p>
            <p>Follow the steps given below to specify the expression:</p>
            <ol>
                <li>Click the text box of the <strong>Source XPath</strong> property. This opens the <b>Expression Selector</b> dialog box.</li>
               <li>Select <strong>Expression</strong> from the list.
                </li>
               <li>Enter <code>                  get-property('Hospital')                 </code> to overwrite the default expression.</li>
               <li>Click <strong>OK.</strong> <strong><br />
                  </strong>
               </li>
            </ol>
         </div>
      </td>
   </tr>
   <tr class="even">
      <td><strong>Case Branches</strong></td>
      <td>
         <div class="content-wrapper">
            <p>Follow the steps given below to add the case branches:</p>
            <ol>
                <li>Double click each <b>case regex</b> (corresponding to each branch) that is listed. This will open the <b>SwitchCaseBranchOutputConnector</b> dialog box.</li>
               <li>
                  Change the RegEx values for the switch cases as follows:
                  <ul>
                     <li>Case 1: grand oak community hospital</li>
                     <li>Case 2:  clemency medical center</li>
                     <li>Case 3:  pine valley community hospital</li>
                  </ul>
               </li>
               <li>Click <strong>OK</strong> .</li>
            </ol>
         </div>
      </td>
   </tr>
    </table>

6.  Let's add a **Log** mediator to print a message indicating to which hospital the request message is being routed. Drag a Log mediator to the first Case box of the Switch mediator and name it **Grand Oak Log**.  
7.  With the Log mediator selected, access the **Properties** tab and give the following details:
    <table>
    <tr>
        <th>Property</th>
        <th>Value</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Log Category</td>
        <td>
           <code>INFO</code> 
        </td>
        <td>
            Indicates that the log contains an informational message.
        </td>
    </tr>
    <tr>
        <td>Log Level</td>
        <td>
            <code>CUSTOM</code>
        </td>
        <td>
            Only specified properties will be logged by this mediator.
        </td>
    </tr>
    <tr>
        <td>Log Separator</td>
        <td>(blank)</td>
        <td>
           Since there is only one property that is being logged, we do not require a separator. Therefore, this field can be left blank. 
        </td>
    </tr>
    <tr>
        <td>Properties</td>
        <td colspan="2">
            Follow the steps given below to extract the stock symbol from the request and print a welcome message in the log:
            <ol>
                <li>
                    Click the <b>plus</b> icon (<img src="{{base_path}}/assets/img/tutorials/common/plus-icon.png" width="30">)
    to start defining a property. This opens the <b>LogProperty</b> dialog box.
                </li>
                <li>
                    Add the following values in the <b>LogProperty</b> dialog box:
                    <ul>
                        <li>
                            <b>Name</b> : `message`
                        </li>
                        <li> 
                            <b>Type</b> : `EXPRESSION`. (We select `EXPRESSION`
        because the required properties for the log message must be
        extracted from the request, which we can do using an XPath
        expression.)    </li>
                        <li>
                            <b>Property Expression</b> : Click <b>browse (...)</b> in the
                            <b>Property Expression</b> field and enter
        `fn:concat('Routing to ', get-property('Hospital'))`.
                        </li>
                    </ul>
                <b>Note</b>: This XPath expression value gets the value stored in the Property mediator and concatenates the two strings to display the log message: `Routing to <hospital name>`.
                </li>
                <li>
                    Click <b>OK</b>.
                </li>
            </ol>
        </td>
    </tr>
    </table>

8.  Add a **Send** mediator adjoining the Log mediator and add the **GrandOakEP endpoint** from **Defined Endpoints** palette to the empty box adjoining the Send mediator.  

    <img src="{{base_path}}/assets/img/tutorials/119132155/119132159.png">

9.  Add **Log mediators** in the other two **Case boxes** in the Switch mediator and then enter the same properties. Make sure to name the two Log mediators as follows:

    -   `Clemency Log`
    -   `Pine Valley Log`

10. Add **Send** mediators adjoining these log mediators and add the **ClemencyEP** and **PineValleyEP** endpoints respectively from the **Defined Endpoints** palette.

    !!! Info
        You have now configured the Switch mediator to log the `Routing to <Hospital Name>` message when a request is sent to this API resource. The request message will then be routed to the relevant hospital back-end service based on the hospital name that is sent in the request payload.

11. Add a **Log mediator** to the **Default** (the bottom box) of the Switch mediator and configure it the same way as the previous Log mediators.

    !!! Note
        Make sure to name this **Fault Log** and change its <b>Property Expression</b> as follows:`fn:concat('Invalid hospital - ', get-property('Hospital'))`

    The default case of the Switch mediator handles the invalid hospital requests that are sent to the request payload. This logs the message (`Invalid hospital - <Hospital Name>`) for requests that have the invalid hospital name.

12. Drag a **Respond mediator** next to the Log mediator you just added. This ensures that there is no further processing of the current message and returns the request message back to the client.  

13. Drag a **Send** mediator to the **Out sequence** of the API resource to send the response back to the client.

The In Sequence of the API resource configuration should now look like this:  

<img src="{{base_path}}/assets/img/tutorials/119132155/119132158.png?effects=drop-shadow">

You have successfully created all the artifacts that are required for routing messages to a back-end service depending on the content in the request payload. 

### Step 3: Package the artifacts

Package the artifacts in your composite application module (SampleServicesCompositeExporter) to be able to deploy the artifacts in the server.

1.  Open the `          pom.xml         ` file in the composite exporter module.
2.  Ensure that the following artifacts are selected in the POM file.

    -   `HealthcareAPI`
    -   `ClemencyEP`
    -   `GrandOakEP`
    -   `PineValleyEP`

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
                    "patient": {
                    "name": "John Doe",
                    "dob": "1940-03-19",
                    "ssn": "234-23-525",
                    "address": "California",
                    "phone": "8770586755",
                    "email": "johndoe@gmail.com"
                    },
                    "doctor": "thomas collins",
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
     
     <img src="{{base_path}}/assets/img/tutorials/119132155/http4e-client.png" width="800">

If you want to send the client request from your terminal:

1. Install and set up [cURL](https://curl.haxx.se/) as your REST client.
2. Create a JSON file named `request.json` with the following request payload.
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
        "hospital": "grand oak community hospital",
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
"appointmentDate":"2025-04-02"}
```

Now check the **Console** tab of WSO2 Integration Studio and you will see the following message: `INFO - LogMediator message = Routing to grand oak community hospital`
    
This is the message printed by the Log mediator when the message from the client is routed to the relevant endpoint in the Switch mediator.

You have successfully completed this tutorial and have seen how the requests received by the Micro Integrator can be routed to the relevant endpoint using the Switch mediator.

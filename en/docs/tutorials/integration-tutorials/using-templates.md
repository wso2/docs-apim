# Reusing Mediation Sequences

## What you'll build

In this sample scenario, you will use a **Sequence Template**
and reuse it in multiple places of the medation flow.

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

1.  In the Project Explorer, right-click **SampleServicesConfigs** and navigate to **New -> REST API**.
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

    <img src="{{base_path}}/assets/img/integrate/tutorials/119132155/119132166.png" width="500">

4.  Click **Finish**.
5.  Similarly, create the HTTP endpoints for the other two hospital services using the URI Templates given below:
    -   ClemencyEP: `http://localhost:9090/clemency/categories/{uri.var.category}/reserve`
    -   PineValleyEP: `http://localhost:9090/pinevalley/categories/{uri.var.category}/reserve`

#### Create a Sequence Template

1.  Right-click on **SampleServicesConfigs** and navigate to **New -> Template** . The **New Template Artifact** dialog box will open.
2.  Select the **Create a New Template** and click **Next**.
3.  Enter the following details and click **Finish**.
    <table>
        <tr>
            <th>Parameter</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Template Name</td>
            <td>HospitalRoutingSeq</td>
        </tr>
        <tr>
            <td>Template Type</td>
            <td>Sequence Template</td>
        </tr>
    </table>

    <img src="{{base_path}}/assets/img/integrate/tutorials/using-templates/create-sequence-temp-dialog-box.png" width="500">

4.  The template artifact will open in the canvas as shown below.

5.  Open the **Properties** tab of the sequence template by clicking on
    the canvas (outside the sequence box).  

6.  Click the <img src="{{base_path}}/assets/img/integrate/tutorials/plus-icon.png" width="20"> icon
    to start adding parameters .

    ![]({{base_path}}/assets/img/integrate/tutorials/sequence-canvas-2.png) 

7.  In the **Template Parameter** dialog box that opens, enter 'sethospital' as the parameter name and click **Finish**.

8.  Add a **Log** mediator to the sequence template as shown below. This
    will print a message indicating to which hospital a requested
    message is routed.

    ![]({{base_path}}/assets/img/integrate/tutorials/log-mediator-in-sequence.png) 

9. Open the **Properties** tab of the log mediator and specify the
    following:

    <table>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Log Category</td>
            <td>INFO</td>
        </tr>
        <tr>
            <td>Log Level</td>
            <td>CUSTOM</td>
        </tr>
    </table>

10. Click the <img src="{{base_path}}/assets/img/integrate/tutorials/plus-icon.png" width="20"> icon
    to start defining a property. Then add the following details for the
    property:

    <table>
        <tr>
            <th>Property Name</th>
            <th>Description</th>
        </tr>
        <tr>
            <td> Name</td>
            <td>message</td>
        </tr>
        <tr>
            <td>Type</td>
            <td>EXPRESSION</td>
        </tr>
        <tr>
            <td>Property Expression</td>
            <td><code>fn:concat('Routing to ', get-property('Hospital')) </code></td>
        </tr>
    </table>

    We select EXPRESSION because the required properties for the log
    message must be extracted from the request, which we can do using an
    XPath expression.  

11. Add a **Property** mediator just after the **Log** mediator to store
    the value for uri.var.hospital.

    ![]({{base_path}}/assets/img/integrate/tutorials/using-templates/property-mediator-in-sequence.png) 

12. With the **Property** mediator selected, access the **Properties**
    tab and enter the information given below:
    <table>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Property Name</td>
            <td>Select New Property</td>
        </tr>
        <tr>
            <td>New Property Name</td>
            <td>uri.var.hospital  </td>
        </tr>
        <tr>
            <td>URI Template</td>
            <td>Select set </td>
        </tr>
        <tr>
            <td>Property Data Type</td>
            <td>Select STRING</td>
        </tr>
        <tr>
            <td>Value</td>
            <td><code>Click on the <b>Ex</b> button in front of the label value and add this <code>$func:sethospital</code> as the expression.</td>
        </tr>
        <tr>
            <td>Description</td>
            <td>Set Hospital Variable</td>
        </tr>
    </table>

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
              <img src="{{base_path}}/assets/img/integrate/tutorials/119132155/expression-value.png">
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

    <img src="{{base_path}}/assets/img/integrate/tutorials/119132155/119132163.png">

    We have three different hospital endpoints, which corresponds to three switch cases. Enter 3 for **Number of branches** and click **OK**.  

    <img src="{{base_path}}/assets/img/integrate/tutorials/119132155/switch-cases-dialog.png">

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

6.  Add a **Call Template** mediator to the first switch case sequence.  
7.  Open the **Properties** tab of the **Call Template** mediator and
    select ' HospitalRoutingSeq' from the list of available templates.

8.  Click the <img src="{{base_path}}/assets/img/integrate/tutorials/plus-icon.png" width="20"> icon
    to start adding parameters. Enter the following parameter details
    and click **Finish** .

    <table>
        <tr>
            <th>Parameter</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Parameter Name</td>
            <td>sethospital</td>
        </tr>
        <tr>
            <td>Parameter Type</td>
            <td>value</td>
        </tr>
        <tr>
            <td>Value/Expression</td>
            <td>grandoaks</td>
        </tr>
    </table>

9.  Repeat the above steps to add **Call Templates** for 'Clemency' and
    'Pine Valley' hospitals. Add **clemency** and **pinevalley** as the
    respective parameter values.

10. Drag a **Call** mediators from the **Mediators** pallete after the **Call Template** mediators in each switch sequence. 

11. Then, add the **GrandOakEP**, **ClemencyEP**, and **PineValleyEP** endpoints from the **Defined Endpoints** palette to the empty boxes adjoining the Call mediator. 

12.  Drag a **Respond mediator** to return the response from the health care service back to the client.

13.  Save the configuration.

### Step 3: Package the artifacts

Package the artifacts in your composite exporter module (SampleServicesCompositeExporter) to be able to deploy the artifacts in the server.

1.  Open the `pom.xml` file in the composite exporter module.
2.  Ensure that the following artifacts are selected in the POM file.

    -   `HealthcareAPI`
    -   `HospitalRoutingSeq`

3.  Save the changes.

### Step 4: Build and run the artifacts

To test the artifacts, deploy the [packaged artifacts](#step-3-package-the-artifacts) in the embedded Micro Integrator:

1.  Right-click the composite exporter module and click **Export Project Artifacts and Run**.
2.  In the dialog box that opens, confirm that the required artifacts from the composite exporter module are selected.     
4.  Click **Finish**. 

The artifacts will be deployed in the embedded Micro Integrator and the server will start.

- See the startup log in the **Console** tab.
- See the URLs of the deployed services and APIs in the **Runtime Services** tab. 

### Step 5: Testing the use case

Let's test the use case by sending a simple client request that invokes the service.

#### Start the back-end service

1. Download the JAR file of the back-end service from [here](https://github.com/wso2-docs/WSO2_EI/blob/master/Back-End-Service/Hospital-Service-JDK11-2.0.0.jar).
2. Open a terminal, navigate to the location where your saved the back-end service.
3. Execute the following command to start the service:

    ```bash
    java -jar Hospital-Service-JDK11-2.0.0.jar
    ```

#### Send the client request

Let's send a simple request to invoke the service. You can use the embedded <b>HTTP Client</b> of WSO2 Integration Studio as follows:

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

1.  Install and set up [cURL](https://curl.haxx.se/) as your REST client.
2.  Create a JSON file names `request.json` with the following request payload.

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
     "appointment_date": "2025-04-02"
    }
    ```

3.  Open a command line terminal and execute the following command from
    the location where the request.json file you created is saved:

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

Now check the **Console** tab of WSO2 Integration Studio and you will see the following message: `INFO - LogMediator message = Routing to grand oak community hospital`
    
This is the message printed by the Log mediator when the message from the client is routed to the relevant endpoint in the Switch mediator.

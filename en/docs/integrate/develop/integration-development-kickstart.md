# Developing Your First Integration Solution

Integration developers need efficient tools to build and test all the integration use cases required by the enterprise before pushing them into a production environment. 
The following topics will guide you through the process of building and running an example 
integration use case using WSO2 Integration Studio. 
This tool contains an embedded WSO2 Micro Integrator instance as well as other capabilities 
that allows you to conveniently design, develop, and test your integration artifacts before 
deploying them in your production environment.

## Use case

We are going to use the same use case we considered in the [Quick Start Guide](../../overview/quick-start-guide). 
In the quick start guide, we just executed the already-built integration scenario. 
Here, we are going to build the integration scenario from scratch. Let’s recall the 
business scenario:

![Integration Scenario]({{base_path}}/assets/img/integrate/developing-first-integration/dev-first-integration-0.png)

The scenario is about a basic healthcare system where WSO2 Micro Integrator is used as the integration middleware. Most healthcare centers use a system to help patients book doctor appointments. To check the availability of doctors, patients will typically use each and every online system that is dedicated for a particular healthcare center or personally visit the healthcare centers. 

We will simplify this process of booking doctor appointments by building an integration solution that orchestrates the isolated systems in each healthcare provider and exposes a single interface to the users. 

Both the Grand Oak service and Pine Valley service are exposed over the HTTP protocol. 

- The Grand Oak service accept GET requests in the following service endpoint url:
  ```bash
  http://<HOST_NAME>:<PORT>/grandOak/doctors/<DOCTOR_TYPE>
  ```

- The Pine Vallery service accepts POST requests in the following service endpoint url:
  ```bash
  http://<HOST_NAME>:<PORT>/pineValley/doctors
  ```

    The expected payload should be in the following JSON format:
    ```bash
    {
            "doctorType": "<DOCTOR_TYPE>"
    }
    ```

Let’s implement a simple Rest API that can be used to query the availability of doctors for a particular category 
from all the available healthcare centers.

## Set up the workspace

Download the relevant [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/) based on your operating system. For more information, see [Installing WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).

## Develop the integration artifacts

### Step 1: Create the integration project
 
Let's create an integration project with the required modules (to store artifacts) in WSO2 Integration Studio.

1.  Open WSO2 Integration Studio and click **New Integration Project** in the **Getting Started** view as shown below.
    <img src="{{base_path}}/assets/img/integrate/new-project/new-integration-project.png" title="New Integration Project" width="700" alt="New Integration Project"/>

3.  In the **New Integration Project** dialog box that opens, enter `Healthcare` for your integration project. This is a <b>maven multi module</b> project.

    Be sure to leave the <b>Create ESB Configs</b> and <b>Create Composite Exporter</b> check boxes selected as shown below.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/2-dev-get-started-integration-proj.png" width="500">

3. Click **Finish**. 

	The integration project with the ESB Config module (`HealthcareConfigs`) and Composite Exporter module (`HealthcareCompositeExporter`) are created as shown below.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/3-dev-get-started-proj-explorer.png" width="300">

### Step 2: Create Endpoints

The actual back-end services (healthcare services) are logically represented in the integration solution as **Endpiont** artifacts. 

Let's create two Endpoint artifacts for the two healthcare services:

1.  Right-click `HealthcareConfigs` and go to **New** → **Endpoint** to open the **New Endpoint Artifact** dialog box.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/4-dev-get-started-select-endpoint.png" width="500">
    
2.  In the <b>New Endpoint Artifact</b> dialog box that opens, select **Create a New Endpoint** and click **Next**.
3.  For the ‘Grand Oak hospital service’, let’s use the following values:

    <table>
      <tr>
         <th>Parameter</th>
         <th>Value</th>
      </tr>
      <tr>
        <td>Endpoint Name</td>
        <td>GrandOakEndpoint</td>
      </tr>
      <tr>
        <td>Endpoint Type</td>
        <td>HTTP Endpoint</td>
      </tr>
      <tr>
        <td>URI Template</td>
        <td>http://localhost:9090/grandOak/doctors/{uri.var.doctorType}</td>
      </tr>
      <tr>
        <td>Method</td>
        <td>GET</td>
      </tr>
    </table>
   
    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/5-dev-get-started-grandoaks-endpoint.png" width="500">

4.  Click **Finish** to save the endpoint configuration.
5.  Follow the same steps to create an endpoint for ‘Pine Valley Hospital’. Use the following parameter values:
   
    <table>
      <tr>
         <th>Parameter</th>
         <th>Value</th>
      </tr>
    
      <tr>
        <td>Endpoint Name</td>
        <td>PineValleyEndpoint</td>
      </tr>
    
      <tr>
        <td>Endpoint Type</td>
        <td>HTTP Endpoint</td>
      </tr>
    
      <tr>
        <td>URI Template</td>
        <td>http://localhost:9091/pineValley/doctors</td>
      </tr>
    
      <tr>
        <td>Method</td>
        <td>POST</td>
      </tr>
    </table>  
    
### Step 3: Create the REST API

We are orchestrating multiple services and exposing a single API to the clients. The main integration artifact is going to be a REST API. 

1. Right-click `HealthcareConfigs` in the project explorer and 
go to **New** → **REST API** to open the **API Artifact Creation Options** dialog box.
2. Select **Create A New API Artifact** and click **Next**.
3. Specify values for the required REST API properties:

    <table>
      <tr>
         <th>Parameter</th>
         <th>Value</th>
      </tr>
      <tr>
        <td>Name</td>
        <td>HealthcareAPI</td>
      </tr>
      <tr>
        <td>Context</td>
        <td>/healthcare</td>
      </tr>
    </table> 

     <img src="{{base_path}}/assets/img/integrate/developing-first-integration/6-dev-get-started-rest-api.png" width="500">
        
4. Click **Finish**. The REST API is created in the `src/main/synapse-config/api` folder under `HealthcareConfigs`.
5. Open the new artifact from the project explorer. You will see the graphical view of the `HealthcareAPI` with its default **API Resource**.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/7-dev-get-started-api-canvas.png" width="700">
    
    To the right of the editor, you will see the **Mediators** palette containing various mediators 
    that can be dragged and dropped into the canvas of the **API Resource**. 

6. Double-click the API resource to open the **Properties** view:

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/8-dev-get-started-api-properties-view.png" width="700">
    
    Specify values for the required resource properties:

    <table>
      <tr>
         <th>Parameter</th>
         <th>Value</th>
      </tr>
      <tr>
        <td>Url Style</td>
        <td>URL_TEMPLATE</td>
      </tr>
      <tr>
        <td>Uri Template</td>
        <td>
          <code>/doctor/{doctorType}</code></br></br>
          <b>Note</b> that '{doctorType}' is a uri variable that gets resolved to the path parameter value in the runtime. We can access the value of the uri variable in the mediation flow using the variable (property) called ‘uri.var.doctorType’.
        </td>
      </tr>
      <tr>
        <td>Methods</td>
        <td>Get</td>
      </tr>
    </table>     

### Step 4: Create the mediation logic

1. Create two parallel message flows:
    
    In this scenario, the Healthcare API receives an HTTP GET request, which should be delivered to two different back-end services. That is, we need to clone the message into two branches and process them in parallel. 
    To do that, we can use the **Clone Mediator**.

    Drag the **Clone** mediator from the mediator palette and drop it into the request path (inSequence) of the API Resource canvas. 

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/9-dev-get-started-clone-mediator.png" width="700">

    Right-click the Clone mediator and select **Add/Remove Target..**. 
    In the **Add Target Branches** window, set the number of branches to 2. 
    You will now see two branches inside the **Clone** mediator.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/10-dev-get-started-clone-mediator-branches.png" width="300">

2. Invoke the GrandOak Endpoint:

    The **Call** mediator is used to invoke a back-end service. In [Step 2](#step-2-create-endpoints), we have already created an Endpoint to represent the GrandOak endpoint.

    Drag the Call mediator from the mediator palette into one branch of the Clone mediator. 

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/11-dev-get-started-call-mediator.png" width="700">
   
    Then, drag the already-defined GrandOak endpoint artifact, which is available under the **Defined Endpoints** section of the palette, into the Call mediator.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/12-dev-get-started-call-grandoaks.png" width="700">
       
3. Construct message payload for the PineValley Endpoint:

    Unlike the GrandOAK endpoint, which accepts a simple GET request, the PineValley endpoint requires a POST request with the following JSON message:

    ```bash
    {
        "doctorType": "<DOCTOR_TYPE>"
    }
    ```

    Therefore, we need to first construct the required message payload. There are several 
    Transformation mediators available for constructing messages. Let's use the **PayloadFactory** mediator.
    Drag the PayloadFactory mediator into the 2nd branch of the **Clone** mediator as shown below.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/13-dev-get-started-payloadfactory-mediator.png" width="700">
    
    Specify values for the required PayloadFactory properties:

    <table>
      <tr>
         <th>Parameter</th>
         <th>Value</th>
      </tr>
    
      <tr>
        <td>Payload Format</td>
        <td>Inline</td>
      </tr>
    
      <tr>
        <td>Media Type</td>
        <td>json</td>
      </tr>
      
      <tr>
        <td>Payload</td>
        <td>{
                  "doctorType": "$1"
            }
        </td>
      </tr>
      
      <tr>
        <td>Args</td>
        <td>$ctx:uri.var.doctorType</td>
      </tr>
    </table>

    Note the `$1` in the Payload format. It denotes a parameter that can get a value assigned dynamically. The value for the parameters need to be assigned using Arguments **(Args)**. 
    **Args** can be added using the **PayloadFactoryArgument** dialog box, which appears when you click the (<img src="{{base_path}}/assets/img/integrate/tutorials/common/plus-icon.png" width="20">) sign.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/14-dev-get-started-payloadfactory-expression.png" width="700">
        
    In the `PayloadFactoryArgument` dialog box, select **Expression** as the **Argument Type**, and click **Argument Expression**. You will then see the **Expression Selector** dialog box. Enter **$ctx:uri.var.doctorType** as the value for the expression.
    
4. Invoke the PineValley Endpoint:
    
    Use the Call mediator to invoke the PineVallery Endpoint. Follow the same steps you used under ‘Invoke GrandOak Endpoint’. 
    
5. Aggregating response messages:
    
    Since we are cloning the messages and delivering into two different services, we will receive two responses. 
    So we need to aggregate those two responses and construct a single response. To do that, we can use the **Aggregate** mediator.
    
    Drag the Aggregate mediator and drop it next to the Clone mediator as shown below.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/15-dev-get-started-aggregate-mediator.png">
   
    Specify values for the required Aggregate mediator properties.

    <table>
      <tr>
         <th>Parameter</th>
         <th>Value</th>
      </tr>
    
      <tr>
        <td>Aggregation Expression</td>
        <td>json-eval($.doctors.doctor)</td>
      </tr>
    
    </table>

6. Send a response back to the client :

    To send the response back to the client, we can use the **Respond** mediator. Remove the <b>Drop</b> mediator (which comes with the Aggregate mediator by default) and add the Respond mediator as shown below.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/16-dev-get-started-drop-mediator.png" width="700">
    
The final mediation configuration looks similar to the above diagram.     
Following is what you will see in the **Source View** of WSO2 Integration Studio.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<api context="/healthcare" name="HealthcareAPI" xmlns="http://ws.apache.org/ns/synapse">
<resource methods="GET" uri-template="/doctor/{doctorType}">
    <inSequence>
	<clone>
	    <target>
		<sequence>
		    <call>
			<endpoint key="GrandOakEndpoint"/>
		    </call>
		</sequence>
	    </target>
	    <target>
		<sequence>
		    <payloadFactory media-type="json">
			<format>{
					  "doctorType": "$1"
				       }
			</format>
			<args>
			    <arg evaluator="xml" expression="$ctx:uri.var.doctorType"/>
			</args>
		    </payloadFactory>
		    <call>
			<endpoint key="PineValleyEndpoint"/>
		    </call>
		</sequence>
	    </target>
	</clone>
	<aggregate>
	    <completeCondition>
		<messageCount max="-1" min="-1"/>
	    </completeCondition>
	    <onComplete expression="json-eval($.doctors.doctor)">
		<respond/>
	    </onComplete>
	</aggregate>
    </inSequence>
    <outSequence/>
    <faultSequence/>
</resource>
</api>
```

## Build and run the artifacts

There are several ways to deploy and run the integration scenario. 

### Option 1: Using WSO2 Integration Studio

1. Right-click `HealthcareCompositeExporter` and click **Export Project Artifacts and Run**.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/17-dev-get-started-build-and-run-1.png" width="500">

2. You will see the following dialog box. Select the `HealthcareConfigs` folder in the artifact list and click **Finish**.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/18-dev-get-started-build-and-run-2.png" width="700">

The embedded Micro Integrator starts with the deployed artifacts. You will see the server startup log in the <b>Console</b> tab, and the endpoints of the deployed services in the <b>Runtime Services</b> tab as shown below.

<img src="{{base_path}}/assets/img/integrate/developing-first-integration/19-dev-get-started-embedded-server-startup.png">
  
### Option 2: Using a local Micro Integrator instance

**Before you begin**, be sure to install the Micro Integrator on your machine:

1.  Go to the [website](https://wso2.com/integration/#) to download the Micro Integrator. 
2.  Click **Download** and see that the installation options are listed. You can either download and run the **installer**, or use the **binary** file. The home directory of your Micro Integrator installation will be referred to as `<MI_HOME>` from hereon.

Once you have downloaded and set up the Micro Integrator locally, follow the steps given below.

1.  **Export the artifacts as a deployable CAR file**: Right-click `HealthcareCompositeExporter` in WSO2 Integration Studio and select **Export Composite Application Project**.
   
2.  **Deploy the Healthcare service**: Copy the exported CAR file of the Healthcare service to the `MI_HOME/repository/deployment/server/carbonapps` directory.

3.  **Start the Micro Integrator**:
    
    If you set up the product using the **installer**, follow the steps relevant to your OS as shown below.

    -   On **MacOS/Linux/CentOS**, open a terminal and execute the following command:
        ```bash
        sudo wso2mi
        ```
    -   On **Windows**, go to **Start Menu -> Programs -> WSO2 -> Micro Integrator**. This will open a terminal and start the Micro Integrator.

    If you set up the product using the **binary** distribution, open a terminal, navigate to the `<MI_HOME>/bin` directory, and execute the command relevant to your OS as shown below.

    ```bash tab='On MacOS/Linux/CentOS'
    sh micro-integrator.sh
    ```

    ```bash tab='On Windows'
    micro-integrator.bat
    ```

## Observe deployed artifacts

Once you have deployed the artifacts and started the Micro Integrator server, you can start the <b>Dashboard</b> to observe details of the deployed artifacts.

If you are running the embedded Micro Integrator, click <b>Open Monitoring Dashboard</b> in the <b>Runtime Services</b> tab as shown below.

<img src="{{base_path}}/assets/img/integrate/developing-first-integration/20-dev-get-started-open-dashboard.png" width="500">

You will be directed to the log in screen of the Dashboard from your default browser as shown below. Log in using `admin` as the user name and password.

<img src="{{base_path}}/assets/img/integrate/developing-first-integration/21-dev-get-started-dashboard-login.png" width="500">

Once you are logged in, click the required artifact type to view details.

<img src="{{base_path}}/assets/img/integrate/developing-first-integration/22-dev-get-started-dashboard-artifact-view.png">

## Start back-end services

Let's start the mock back-end services for this use case:

1.  Download the [`DoctorInfo-JDK11.jar` file](https://ei.docs.wso2.com/en/7.1.0/micro-integrator{{base_path}}/assets/attach/developing-first-integration/DoctorInfo-JDK11.jar). This contains two healthcare services.
2.  Open a terminal, navigate to the location of the downloaded `DoctorInfo-JDK11.jar` file, and execute the following command to start the services:

    ```bash
    java -jar DoctorInfo-JDK11.jar
    ```
   
## Invoke the Healthcare service

There are two ways to invoke the service:

### Option 1: Using WSO2 Integration Studio

Let's invoke the API from the embedded <b>HTTP Client</b> of WSO2 Integration Studio as follows:

1.  Open the <b>HTTP Client</b> of WSO2 Integration Studio.

    !!! Tip
        If you don't see the <b>HTTP Client</b> tab, go to <b>Window -> Show View - Other</b> and select <b>HTTP Client</b> to enable the client tab.

    <img src="{{base_path}}/assets/img/integrate/developing-first-integration/http4e-client-empty.png" width="800">
    
2.  Enter the request information as given below and click the <b>Send</b> icon (<img src="{{base_path}}/assets/img/integrate/tutorials/common/play-head-icon.png" width="20">).
    
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
                <code>http://localhost:8290/healthcare/doctor/Ophthalmologist</code></br></br>
            </td>
        </tr>
     </table>
     
The response is printed in the **HTTP Response** section.

### Option 2: Using your terminal

If you want to send the client request from your terminal:

1.  Install and set up [cURL](https://curl.haxx.se/) as your REST client.
2.  Open a terminal and execute the following curl command to invoke the service:

    ```bash
    curl -v http://localhost:8290/healthcare/doctor/Ophthalmologist
    ```

You will receive the following response:

```bash
[
    [
        {
            "name": "John Mathew",
            "time": "03:30 PM",
            "hospital": "Grand Oak"
        },
        {
            "name": "Allan Silvester",
            "time": "04:30 PM",
            "hospital": "Grand Oak"
        }
    ],
    [
        {
            "name": "John Mathew",
            "time": "07:30 AM",
            "hospital": "pineValley"
        },
        {
            "name": "Roma Katherine",
            "time": "04:30 PM",
            "hospital": "pineValley"
        }
    ]
]
```

## What's Next?

- [Running the Micro Integrator on Containers](../../setup/installation/run_in_containers).
- [Writing a unit test for integration artifacts]({{base_path}}/integrate/develop/creating-unit-test-suite).
- [Developing Your First Siddhi Application](https://ei.docs.wso2.com/en/7.1.0/streaming-integrator/quick-start-guide/getting-started/getting-started-guide-overview/).

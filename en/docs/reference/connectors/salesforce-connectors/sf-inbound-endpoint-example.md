# Salesforce Inbound Endpoint Example

The Salesforce streaming Inbound Endpoint allows you to perform various operations on Salesforce streaming data.

The [Salesforce streaming API](https://developer.salesforce.com/docs/atlas.en-us.api_streaming.meta/api_streaming/intro_stream.htm) receives notifications based on the changes that happen to Salesforce data with respect to an SQQL (Salesforce Object Query Language) query you define, in a secured and scalable way. For more information, navigate to [Salesforce streaming documentation](https://developer.salesforce.com/docs/atlas.en-us.202.0.api_streaming.meta/api_streaming/quick_start_workbench.htm).

## What you'll build

The Salesforce inbound endpoint is a listening inbound endpoint that can consume messages from Salesforce. This injects messages to an integration sequence. However, for simplicity of this example, we will just log the message. You can extend the sample as required using WSO2 [mediators]({{base_path}}/reference/mediators/about-mediators/). 

In this exmple we can trigger the notifications to the Salesforce Inbound Endpoint via creating the `Platform events` or `PushTopic` methods. Please note that our example configurations are based on creating the `PushTopic` method. You can use the instructions given in the [sf-rest inbound endpoint configuration]({{base_path}}/reference/connectors/salesforce-connectors/sf-rest inbound endpoint configuration/) documentation.

The following diagram illustrates all the required functionality of the Salesforce inbound operations that you are going to build. 

For example, we are building an integrated example driven through the [Salesforce connector]({{base_path}}/reference/salesforce-connectors/sf-rest-connector-example/) and Salesforce Inbound Endpoint. The user calls the Salesforce REST API. It invokes the **create** sequence and creates a new account in Salesforce. Then, through the **retrieve** sequence, it displays all the existing account details to the user. 

Now that you have configured the Salesforce Inbound Endpoint, use the following Inbound Endpoint configuration to retrieve account details from your Salesforce account. The Salesforce inbound endpoint acts as a message receiver. You can inject that message into the mediation flow for getting the required output.

<img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-example.png" title="Salesforce Inbound Endpoint" width="800" alt="Salesforce Inbound Endpoint"/>

## Configure inbound endpoint using WSO2 Integration Studio

1. Download [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/). Create an **Integration Project** as below. 
   <img src="{{base_path}}/assets/img/integrate/connectors/integration-project.png" title="Creating a new Integration Project" width="800" alt="Creating a new Integration Project" />

2. Right click on **Created Integration Project** -> **New** -> **Inbound Endpoint** -> **Create A New Inbound Endpoint** -> **Inbound Endpoint Creation Type**and select as **custom** -> Click **Next**.
   <img src="{{base_path}}/assets/img/integrate/connectors/salesforce-inboundep-create-new-ie.png" title="Creating inbound endpoint" width="400" alt="Creating inbound endpoint" style="border:1px solid black"/>

3. Click on **Inbound Endpoint** in design view and under `properties` tab, update class name to `org.wso2.carbon.inbound.salesforce.poll.SalesforceStreamData`. 

4. Navigate to the source view and update it with the following configuration as required. 

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <inboundEndpoint xmlns="http://ws.apache.org/ns/synapse"
                    name="SaleforceInboundEP"
                    sequence="test"
                    onError="fault"
                    class="org.wso2.carbon.inbound.salesforce.poll.SalesforceStreamData"
                    suspend="false">
      <parameters>
         <parameter name="inbound.behavior">polling</parameter>
         <parameter name="interval">100</parameter>
         <parameter name="sequential">true</parameter>
         <parameter name="coordination">true</parameter>
         <parameter name="connection.salesforce.replay">false</parameter>
         <parameter name="connection.salesforce.EventIDStoredFilePath">/home/kasun/Documents/SalesForceConnector/a.txt</parameter>
         <parameter name="connection.salesforce.packageVersion">37.0</parameter>
         <parameter name="connection.salesforce.salesforceObject">/topic/Account</parameter>
         <parameter name="connection.salesforce.loginEndpoint">https://login.salesforce.com</parameter>
         <parameter name="connection.salesforce.userName">Username</parameter>
         <parameter name="connection.salesforce.password">test123XXXXXXXXXX</parameter>
         <parameter name="connection.salesforce.waitTime">5000</parameter>
         <parameter name="connection.salesforce.connectionTimeout">20000</parameter>
         <parameter name="connection.salesforce.soapApiVersion">22.0</parameter>
      </parameters>
   </inboundEndpoint>
   ```
   Sequence to process the message.
   
   In this example for simplicity we will just log the message, but in a real world use case, this can be any type of message mediation.
 
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <sequence name="test" onError="fault" xmlns="http://ws.apache.org/ns/synapse">
       <log level="full"/>
       <drop/>
   </sequence>
   ```
> **Note**: To configure the `connection.salesforce.password` parameter value, please use the steps given under the topic `Reset Security Token` in the [Salesforce inbound endpoint configuration]({{base_path}}/reference/connectors/salesforce-connectors/sf-inbound-endpoint-configuration/) document.
   
## Exporting Integration Logic as a CApp

**CApp (Carbon Application)** is the deployable artefact on the integration runtime. Let us see how we can export integration logic we developed into a CApp. To export the `Solution Project` as a CApp, a `Composite Application Project` needs to be created. Usually, when a solution project is created, this project is automatically created by Integration Studio. If not, you can specifically create it by navigating to  **File** -> **New** -> **Other** -> **WSO2** -> **Distribution** -> **Composite Application Project**. 

1. Right click on Composite Application Project and click on **Export Composite Application Project**.</br> 
  <img src="{{base_path}}/assets/img/integrate/connectors/capp-project1.png" title="Export as a Carbon Application" width="300" alt="Export as a Carbon Application" />

2. Select an **Export Destination** where you want to save the .car file. 

3. In the next **Create a deployable CAR file** screen, select inbound endpoint and sequence artifacts and click **Finish**. The CApp will get created at the specified location provided in the previous step. 

## Deployment

1. Navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for `SalesforceRest`. Click on `Salesforce Inbound Endpoint` and download the .jar file by clicking on `Download Inbound Endpoint`. Copy this .jar file into  <PRODUCT-HOME>/lib folder. 

2. Copy the exported carbon application to the <PRODUCT-HOME>/repository/deployment/server/carbonapps folder. 

4. Start the integration server. 

## Testing  

> **Note**: If you want to test this scenario by inserting data manually into the created object records, please follow the steps given under topic `Testing the PushTopic Channel` in the [Salesforce inbound endpoint configuration document]({{base_path}}/reference/connectors/salesforce-connectors/sf-inbound-endpoint-configuration/).

   Please use the [Salesforce REST Connector example]({{base_path}}/reference/connectors/salesforce-connectors//sf-rest-connector-example/) testing steps to test this Inbound Endpoint scenario;
   
   Save a file called data.json with the following payload (change the value of `Name` field as `Manager`).
   ```
   {
   	"sObject":"Account",
   	"fieldAndValue": {
       "name": "Manager",
       "description":"This Account belongs to WSO2"
     }
   }
   ``` 
   Invoke the API as shown below using the curl command. Curl application can be downloaded from [here](https://curl.haxx.se/download.html).   
   
   ```
   curl -X POST -d @data.json http://localhost:8280/salesforcerest --header "Content-Type:application/json"
   ```
   You will get a set of account names and the respective IDs as the output. At the same time, in the server console, you can see the following message.
   
   **Expected respons**
   
   ```   
   To: , MessageID: urn:uuid:2D8F9AFA30E66278831587368713372, Direction: request, Payload: {"event":{"createdDate":"2020-04-20T07:45:12.686Z","replayId":4,"type":"created"},"sobject":{"Id":"0012x0000048j9mAAA","Name":"Manager"}}
   ```   
## What's next
   
* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [Salesforce Inbound Endpoint Reference]({{base_path}}/reference/connectors/salesforce-connectors/sf-inbound-endpoint-reference-configuration/) documentation for all operation details of the connector.
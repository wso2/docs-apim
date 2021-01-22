# ISO8583 Inbound Endpoint Example

In the real world, financial scenarios are happening among thousands of banking systems and networks. In this situation, one system needs to act as a message publisher and another system needs to be capable of receiving messages. Once the message is received, further processing actions are performed based on the logic that is implemented in the internal system.

The ISO8583 inbound endpoint of WSO2 EI acts as a message consumer. The ISO8583 inbound endpoint supported via the WSO2 EI is a listening inbound endpoint that can consume ISO8583 standard messages. It then converts the messages to XML format and injects messages to a sequence in WSO2 EI.

## What you'll build

This scenario demonstrates how the ISO8583 inbound endpoint works as an ISO8583 message consumer. In this scenario, to generate ISO8583 messages we use a sample Java client program.In here inside the banking network functionality simulates using the test client program.

The ISO8583 inbound endpoint listens on port 5000 and acts as a ISO8583 standard message consumer. When a sample Java client connects on port 5000, the ISO8583 inbound endpoint consumes ISO8583 standard messages, converts the messages to XML format, and then injects messages to a sequence into WSO2 EI.

See [ISO8583 connector configuration]({{base_path}}/reference/connectors/ISO8583-connector/ISO8583-connector-configuration/) for more information. However, for simplicity of this example, we will just log the message. You can extend the sample as required using WSO2 [EI mediators](https://docs.wso2.com/display/EI660/ESB+Mediators). 

The following diagram illustrates all the required functionality of the ISO8583 inbound operations that you are going to build. 

For example, while transferring bank and financial sector information using the ISO85883 message format among the banking networks, the message receiving can be done by using inbound endpoints. The ISO8583 inbound endpoint of WSO2 EI acts as an ISO8583 message receiver. You can inject that message into the mediation flow for getting the required output.

<img src="{{base_path}}/assets/img/integrate/connectors/iso8583-inbound-operations.png" title="ISO8583 inbound operations" width="800" alt="ISO8583 inbound operations"/>

## Configure inbound endpoint using WSO2 Integration Studio

1. Download [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/). Create an **Integration Project** as below. 
<img src="{{base_path}}/assets/img/integrate/connectors/integration-project.png" title="Creating a new Integration Project" width="800" alt="Creating a new Integration Project" />

2. Right click on **Source** -> **main** -> **synapse-config** -> **inbound-endpoints** and add a new **custom inbound endpoint**.</br> 
<img src="{{base_path}}/assets/img/integrate/connectors/db-event-inbound-ep.png" title="Creating inbound endpoint" width="400" alt="Creating inbound endpoint" style="border:1px solid black"/>

3. Click on **Inbound Endpoint** in design view and under `properties` tab, update class name to `org.wso2.carbon.inbound.iso8583.listening.ISO8583MessageConsumer`. 

4. Navigate to the source view and update it with the following configuration as required. 

   ```xml
   <?xml version="1.0" encoding="UTF-8"?><inboundEndpoint xmlns="http://ws.apache.org/ns/synapse" name="custom_listener" sequence="requestISO" onError="fault" class="org.wso2.carbon.inbound.iso8583.listening.ISO8583MessageConsumer" suspend="false">
       <parameters>
           <parameter name="inbound.behavior">listening</parameter>
           <parameter name="sequential">true</parameter>
           <parameter name="coordination">true</parameter>
           <parameter name="port">5000</parameter>
           <parameter name="headerLength">2</parameter>
           <parameter name="isProxy">false</parameter>
       </parameters>
   </inboundEndpoint>
   ```
   Sequence to process the message.
   
   In this example for simplicity we will just log the message, but in a real world use case, this can be any type of message mediation.
 
   ```xml
   <?xml version="1.0" encoding="UTF-8"?><sequence xmlns="http://ws.apache.org/ns/synapse" name="requestISO" onError="fault">
       <log level="full">
           <property name="Log_Message for ISO8583 Inbound Endpoint" value="Message received from sample1-source"/>
       </log>
   </sequence>
   ```
## Exporting Integration Logic as a CApp

**CApp (Carbon Application)** is the deployable artefact on the Enterprise Integrator runtime. Let us see how we can export integration logic we developed into a CApp. To export the `Solution Project` as a CApp, a `Composite Application Project` needs to be created. Usually, when a solution project is created, this project is automatically created by Integration Studio. If not, you can specifically create it by navigating to  **File** -> **New** -> **Other** -> **WSO2** -> **Distribution** -> **Composite Application Project**. 

1. Right click on Composite Application Project and click on **Export Composite Application Project**.</br> 
  <img src="{{base_path}}/assets/img/integrate/connectors/capp-project1.png" title="Export as a Carbon Application" width="300" alt="Export as a Carbon Application" />

2. Select an **Export Destination** where you want to save the .car file. 

3. In the next **Create a deployable CAR file** screen, select inbound endpoint and sequence artifacts and click **Finish**. The CApp will get created at the specified location provided in the previous step. 

## Deployment

1. Navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for `ISO8583`. Click on `ISO8583 Inbound Endpoint` and download the .jar file by clicking on `Download Inbound Endpoint`. Copy this .jar file into  <PRODUCT-HOME>/lib folder. 

2. Download [jpos-1.9.4.jar](http://mvnrepository.com/artifact/org.jpos/jpos/1.9.4), [jdom-1.1.3.jar](http://mvnrepository.com/artifact/org.jdom/jdom/1.1.3), and [commons-cli-1.3.1.jar](http://mvnrepository.com/artifact/commons-cli/commons-cli/1.3.1) and add it to <PRODUCT-HOME>/lib folder.

3. Copy the exported carbon application to the <PRODUCT-HOME>/repository/deployment/server/carbonapps folder. 

4. Start the WSO2 EI server. 

## Testing  

1. Run Test Client programme. Use a ISO8583 standard message as input;

   ```
   0200B220000100100000000000000002000020134500000050000001115221801234890610000914XYRTUI5269TYUI021ABCDEFGHIJ 1234567890 
   ```
   
   **Expected respons**
   
   ```   
   [2020-03-26 15:47:26,003]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - To: , MessageID: urn:uuid:FB34DB1FB26FB57D561585217845823, Direction: request, Log_Message for ISO8583 Inbound Endpoint = Message received from sample1-source, Envelope: 
   <?xml version="1.0" encoding="UTF-8"?>
   <soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">
      <soapenv:Body>
         <ISOMessage>
            <header>AHc=</header>
            <data>
               <field id="0">0200</field>
               <field id="3">201345</field>
               <field id="4">000000500000</field>
               <field id="7">0111522180</field>
               <field id="11">123489</field>
               <field id="32">100009</field>
               <field id="44">XYRTUI5269TYUI</field>
               <field id="111">ABCDEFGHIJ 1234567890</field>
            </data>
         </ISOMessage>
      </soapenv:Body>
   </soapenv:Envelope>  
   ```   
## What's next
   
* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
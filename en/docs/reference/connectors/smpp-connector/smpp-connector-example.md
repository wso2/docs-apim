# SMPP Connector Example

SMPP (Short Message Peer-to-Peer Protocol) Connector allows you to send an SMS through the WSO2 EI. It uses the [jsmpp API](https://jsmpp.org/) to communicate with an SMSC (Short Message Service Center), which is used to store, forward, convert, and deliver Short Message Service (SMS) messages. jsmpp is a Java implementation of the SMPP protocol.

## What you'll build

Given below is a sample scenario that demonstrates how to work with the WSO2 EI SMPP Connector and send SMS messages via the SMPP protocol.

The SMPP server in SMSC have all the ESME (External Short Messaging Entity) addresses. This is an external application that connects to a SMSC and the active connection. When you send an SMS to a destination, it comes to the SMSC. Then one of the modules in SMSC checks if the destination address is available or not. If it is available, it creates a connection object that is responsible for sending the SMS message.
There are many SMPP gateways available in the world and now almost all the message centers support SMPP. It is not practical always to connect with real SMSC. However, in this scenario we will try it with **SMSC simulator**. Please refer the [Setting up the SMPP Connector]({{base_path}}/reference/connectors/smpp-connector/smpp-connector-configuration/) documentation.

The following `sendSMS`operation is exposed via an API. The API with the context `/send` has one resource.

* `/send` : Used to send SMS Message to the Short Message Service Center.

The following diagram shows the overall solution. There is an HTTP API that you can invoke with an HTTP call with JSON. The API is able to send a SMS for the request number in a JSON request with the message in JSON. 

<img src="{{base_path}}/assets/img/integrate/connectors/smpp-connector-example.png" title="SMPP connector example" width="800" alt="smpp connector example"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/), which is the tooling component of WSO2 EI. Once added, the operations of the connector can be dragged onto your canvas and added to your resources.

### Import the connector

Follow these steps to set up the ESB Solution Project and the Connector Exporter Project. 

{!reference/connectors/importing-connector-to-integration-studio.md!} 

### Add integration logic

First create an API, which will be where we configure the integration logic. Right click on the created Integration Project and select, **New** -> **Rest API** to create the REST API. Specify the API name as `SmppTestApi` and API context as `/send`.
    
<img src="{{base_path}}/assets/img/integrate/connectors/adding-an-api.png" title="Adding a Rest API" width="800" alt="Adding a Rest API"/>

#### Configuring the API

Create a resource to send an SMS to the Short Message Service Center.

1. Initialize the connector.
    
    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **SMPP Connector** section. Then drag and drop the `init` operation into the Design pane.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-drag-and-drop-init.png" title="Drag and drop init operation" width="500" alt="Drag and drop init operation"/>   
    
    2. Add the property values into the `init` operation as shown below. Replace the `host`, `port`, `systemId`, `password` with your values.
        
        - **host** : IP address of the SMSC. 
        - **port** : Port to access the SMSC.
        - **systemId** : username to access the SMSC.
        - **password** : password to access the SMSC. 
        - **systemType [Optional]** : It is used to categorize the type of ESME that is binding to the SMSC. Examples include “CP” (Content providers), “VMS” (voice mail system) and “OTA” (over-the-air activation system).
        - **addressTon [Optional]** : Indicates Type of Number of the ESME address.  
        - **addressNpi [Optional]** : Numbering Plan Indicator for ESME address.  
    
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-api-init-operation.png" title="Add values to the init operation" width="800" alt="Add values to the init operation"/>

2. Set up the sendSMS operation.

    1. Navigate into the **Palette** pane and select the graphical operations icons listed under **SMPP Connector** section. Then drag and drop the `sendSMS` operation into the Design pane.
           
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-drag-and-drop-sendSMS.png" title="Drag and drop send operation" width="500" alt="Drag and drop send operation"/>    

    2. In this operation we are going to send a SMS messages peer to peer using SMPP protocol. It provides a flexible data communications interface for transfer of short message data between a Message Centers, such as a Short Message Service Centre (SMSC), GSM Unstructured Supplementary Services Data (USSD) Server or other type of Message Center and a SMS application system, such as a WAP Proxy Server, EMail Gateway or other Messaging Gateway. Please find the `send` operation parameters listed here.
               
        - **sourceAddress** : Source address of the SMS message. 
        - **destinationAddress** : Destination address of the SMS message. 
        - **message** : Content of the SMS message.
        
        While invoking the API, the above three parameters values come as a user input.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-drag-and-drop-sendSMS-parameters.png" title="Drag and drop send operation" width="500" alt="Drag and drop send operation"/> 
    
    3. To get the input values in to the API we can use the [property mediator]({{base_path}}/reference/mediators/property-mediator). Navigate into the **Palette** pane and select the graphical mediators icons listed under **Mediators** section. Then drag and drop the `Property` mediators into the Design pane as shown bellow.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-api-drag-and-drop-property-mediator.png" title="Add property mediators" width="800" alt="Add property mediators"/>

        The parameters available for configuring the Property mediator are as follows:
    
        > **Note**: That the properties should be add to the pallet before create the operation.
    
    4. Add the property mediator to capture the `sourceAddress` value. The sourceAddress contains Source address of the SMS message. 
   
        - **name** : sourceAddress
        - **expression** : json-eval($.sourceAddress)
   
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-api-property-mediator-property1-value1.png" title="Add property mediators sourceAddress" width="600" alt="Add property mediators sourceAddress"/>
    
    5. Add the property mediator to capture the `message` values. The message contains content of the SMS message.                  
   
        - **name** : message
        - **expression** : json-eval($.message)
     
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-api-property-mediator-property2-value2.png" title="Add values to capture message" width="600" alt="Add values to capture message"/>  
      
    6. Add the property mediator to capture the `distinationAddress` values. The message contains content of the SMS message.                  
       
        - **name** : distinationAddress
        - **expression** : json-eval($.distinationAddress)
         
        <img src="{{base_path}}/assets/img/integrate/connectors/smpp-api-property-mediator-property3-value3.png" title="Add values to capture distinationAddress" width="600" alt="Add values to capture distinationAddress"/>  
        
3. Get a response from the user.
    
    When you are invoking the created API, the request of the message is going through the `/send` resource. Finally, it is passed to the [Respond mediator]({{base_path}}/reference/mediators/respond-mediator/). The Respond Mediator stops the processing on the current message and sends the message back to the client as a response.            
    
    1. Drag and drop **respond mediator** to the **Design view**. 
    
         <img src="{{base_path}}/assets/img/integrate/connectors/smpp-drag-and-drop-respond-mediator.png" title="Add Respond mediator" width="800" alt="Add Respond mediator"/> 

    2. Once you have setup the sequences and API, you can see the `salesforcerest` API as shown below.
    
         <img src="{{base_path}}/assets/img/integrate/connectors/smpp-api-design-view.png" title="API Design view" width="600" alt="API Design view"/>
        
    > **Note**: The properties should be added to the pallet before creating the operation.
       
4.  Now you can switch into the Source view and check the XML configuration files of the created API and sequences. 
    
    ??? note "SmppTestApi.xml"
        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <api context="/send" name="SmppTestApi" xmlns="http://ws.apache.org/ns/synapse">
            <resource methods="POST">
                <inSequence>
                    <property expression="json-eval($.distinationAddress)" name="distinationAddress" scope="default" type="STRING"/>
                    <property expression="json-eval($.message)" name="message" scope="default" type="STRING"/>
                    <property expression="json-eval($.sourceAddress)" name="sourceAddress" scope="default" type="STRING"/>
                    <SMPP.init>
                        <host>localhost</host>
                        <port>10003</port>
                        <systemId>kasun</systemId>
                        <password>kasun</password>
                        <systemType>SMS1009</systemType>
                        <addressTon>INTERNATIONAL</addressTon>
                        <addressNpi>ISDN</addressNpi>
                    </SMPP.init>
                    <SMPP.sendSMS>
                        <sourceAddress>{$ctx:sourceAddress}</sourceAddress>
                        <distinationAddress>{$ctx:distinationAddress}</distinationAddress>
                        <message>{$ctx:message}</message>
                    </SMPP.sendSMS>
                    <log level="full">
                        <property name="Message delivered sucessfully" value="Message delivered sucessfully"/>
                    </log>
                    <respond/>
                </inSequence>
                <outSequence/>
                <faultSequence/>
            </resource>
        </api>
        ``` 
## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/smpp-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the simulator details and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the Enterprise Integrator Runtime. 

{!reference/connectors/deploy-capp.md!}   

## Testing

Invoke the API as shown below using the curl command. Curl Application can be downloaded from [here](https://curl.haxx.se/download.html).

**Sample request**

  ```
  curl -v POST -d '{"sourceAddress":"16111", "message":"Hi! This is the first test SMS message.","distinationAddress":"071XXXXXXX"}' "http://172.17.0.1:8290/send" -H "Content-Type:application/json"
  ```
**You will receive the `messageId` as expected response**

  ```
  {"messageId":"Smsc2001"}
  ```
**Expected Response in SMSC simulator console**
    
  ```
  06:33:09 [sys] new connection accepted
  06:33:09 [] client request: (bindreq: (pdu: 40 2 0 1) kasun kasun SMS1009 52 (addrrang: 1 1 ) ) 
  06:33:09 [kasun] authenticated kasun
  06:33:09 [kasun] server response: (bindresp: (pdu: 0 80000002 0 1) Smsc Simulator) 
  06:33:09 [kasun] client request: (submit: (pdu: 106 4 0 2) (addr: 1 1 16111)  (addr: 1 1 071XXXXXXX)  (sm: msg: Hi! This is the first test SMS message.)  (opt: ) ) 
  06:33:09 [kasun] putting message into message store
  06:33:09 [kasun] server response: (submit_resp: (pdu: 0 80000004 0 2) Smsc2001 ) 
  06:33:59 [kasun] client request: (enquirelink: (pdu: 16 15 0 3) ) 
  06:33:59 [kasun] server response: (enquirelink_resp: (pdu: 0 80000015 0 3) ) 
  06:34:49 [kasun] client request: (enquirelink: (pdu: 16 15 0 4) ) 
  06:34:49 [kasun] server response: (enquirelink_resp: (pdu: 0 80000015 0 4) )
  ```
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
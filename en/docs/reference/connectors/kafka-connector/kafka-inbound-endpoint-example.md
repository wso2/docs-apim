# Kafka Inbound Endpoint Example

The Kafka inbound endpoint of WSO2 EI acts as a message consumer. It creates a connection to ZooKeeper and requests messages for either a topic/s or topic filters.

## What you'll build
This sample demonstrates how one way message bridging from Kafka to HTTP can be done using the inbound Kafka endpoint.
See [Configuring kafka connector]({{base_path}}/reference/connectors/kafka-connector/kafka-connector-config/) for more information.

The following diagram illustrates all the required functionality of the Kafka service that you are going to build. In this example, you only need to consider about the scenario of message consuming.

<img src="{{base_path}}/assets/img/integrate/connectors/kafkainboundendpoint.png" title="Kafka inbound endpoint" width="800" alt="Kafka inbound endpoint"/>

If you do not want to configure this yourself, you can simply [get the project](#get-the-project) and run it.

## Set up Kafka

Before you begin, set up Kafka by following the instructions in [Setting up Kafka]({{base_path}}/reference/connectors/kafka-connector/setting-up-kafka/).

## Configure inbound endpoint using WSO2 Integration Studio

1. Download [WSO2 Integration Studio](https://wso2.com/integration/integration-studio/). Create an **Integration Project** as below. 
<img src="{{base_path}}/assets/img/integrate/connectors/solution-project.png" title="Creating a new Integration Project" width="800" alt="Creating a new Integration Project" />

2. Right click on **Source** -> **main** -> **synapse-config** -> **inbound-endpoints** and add a new **custom inbound endpoint**.</br> 
<img src="{{base_path}}/assets/img/integrate/connectors/db-event-inbound-ep.png" title="Creating inbound endpoint" width="400" alt="Creating inbound endpoint" style="border:1px solid black"/>

3. Click on **Inbound Endpoint** in the design view and under the `properties` tab, update the class name to `org.wso2.carbon.inbound.kafka.KafkaMessageConsumer`.

4. Navigate to the source view and update it with the following configuration as required.  

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <inboundEndpoint name="KAFKAListenerEP" sequence="kafka_process_seq" onError="fault" class="org.wso2.carbon.inbound.kafka.KafkaMessageConsumer" suspend="false" xmlns="http://ws.apache.org/ns/synapse">
      <parameters>
        <parameter name="sequential">true</parameter>
        <parameter name="interval">10</parameter>
        <parameter name="coordination">true</parameter>
        <parameter name="inbound.behavior">polling</parameter>
        <parameter name="value.deserializer">org.apache.kafka.common.serialization.StringDeserializer</parameter>
        <parameter name="topic.name">test</parameter>
        <parameter name="poll.timeout">100</parameter>
        <parameter name="bootstrap.servers">localhost:9092</parameter>
        <parameter name="group.id">hello</parameter>
        <parameter name="contentType">application/json</parameter>
        <parameter name="key.deserializer">org.apache.kafka.common.serialization.StringDeserializer</parameter>
      </parameters>
   </inboundEndpoint>
   ```
   Sequence to process the message:
   
   In this example for simplicity we will just log the message, but in a real world use case, this can be any type of message mediation.

   ```xml
   <?xml version="1.0" encoding="ISO-8859-1"?>
      <sequence xmlns="http://ws.apache.org/ns/synapse" name="kafka_process_seq">
         <log level="full"/>
         <log level="custom">
            <property xmlns:ns="http://org.apache.synapse/xsd" name="partitionNo" expression="get-property('partitionNo')"/>
         </log>
         <log level="custom">
            <property xmlns:ns="http://org.apache.synapse/xsd" name="messageValue" expression="get-property('messageValue')"/>
         </log>
         <log level="custom">
            <property xmlns:ns="http://org.apache.synapse/xsd" name="offset" expression="get-property('offset')"/>
         </log>
      </sequence>
   ```

## Exporting Integration Logic as a CApp

**CApp (Carbon Application)** is the deployable artefact on the Enterprise Integrator runtime. Let us see how we can export integration logic we developed into a CApp. To export the `Solution Project` as a CApp, a `Composite Application Project` needs to be created. Usually, when a solution project is created, this project is automatically created by Integration Studio. If not, you can specifically create it by navigating to  **File** -> **New** -> **Other** -> **WSO2** -> **Distribution** -> **Composite Application Project**. 

1. Right click on Composite Application Project and click on **Export Composite Application Project**.</br> 
  <img src="{{base_path}}/assets/img/integrate/connectors/capp-project1.png" title="Export as a Carbon Application" width="300" alt="Export as a Carbon Application" />

2. Select an **Export Destination** where you want to save the .car file. 

3. In the next **Create a deployable CAR file** screen, select inbound endpoint and sequence artifacts and click **Finish**. The CApp will get created at the specified location provided in the previous step.   

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/kafka-connector.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

## Deployment

1. Navigate to the [connector store](https://store.wso2.com/store/assets/esbconnector/list) and search for `Kafka`. Click on `Kafka Inbound Endpoint` and download the .jar file by clicking on `Download Inbound Endpoint`. Copy this .jar file into  <PRODUCT-HOME>/lib folder. 

2. Copy the exported carbon application to the <PRODUCT-HOME>/repository/deployment/server/carbonapps folder. 

3. Start the WSO2 EI server.

## Testing  
   
   **Sample request**
   
   Run the following on the Kafka command line to create a topic named test with a single partition and only one replica:
   ```
   bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
   ```           
   Run the following on the Kafka command line to send a message to the Kafka brokers. You can also use the WSO2 Kafka Producer connector to send the message to the Kafka brokers.
   ```
   bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
   ```   
   Executing the above command will open up the console producer. Send the following message using the console: 
   ```
   {"test":"wso2"}
   ```
   **Expected respons**
   
   You can see the following Message content in the Micro Integrator:
   
   ```  
   [2020-02-19 12:39:59,331]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - To: , MessageID: d130fb8f-5d77-43f8-b6e0-85b98bf0f8c1, Direction: request, Payload: {"test":"wso2"}
   [2020-02-19 12:39:59,335]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - partitionNo = 0
   [2020-02-19 12:39:59,336]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - messageValue = {"test":"wso2"}
   [2020-02-19 12:39:59,336]  INFO {org.apache.synapse.mediators.builtin.LogMediator} - offset = 6  
   ```
   The Kafka inbound endpoint gets the messages from the Kafka brokers and logs the messages in the Micro Integrator.
   
## What's next

* You can deploy and run your project on Docker or Kubernetes. See the instructions in [Running the Micro Integrator on Containers]({{base_path}}/install-and-setup/installation/run_in_containers).
* To customize this example for your own scenario, see [kafka Connector Configuration]({{base_path}}/reference/connectors/kafka-connector/kafka-connector-config/) documentation.
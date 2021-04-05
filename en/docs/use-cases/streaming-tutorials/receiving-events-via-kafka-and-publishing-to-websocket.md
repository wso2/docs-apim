# Receiving XML events via Kafka, Publishing to WebSocket and Generation of Asynchronous API and Deployment

## Introduction

The Streaming Integrator can consume events from a Kafka topic and publish those events to a WebSocket in a streaming manner when a stream of events are received by the Kafka source and they are published to the WebSocket sink simultaneously.

As the Siddhi application contains a WebSocket source, this can be exposed as an API in the API Manager. Here this documentation will provide an overview of generating an Async API, viewing it in Streaming Integrator Tooling and how to export the Async API specification into the Service Catalogue during the Siddhi application deployment in the WSO2 Streaming Integrator.

## Purpose

This application demonstrates how to configure WSO2 Streaming Integrator Tooling to receive events to the `SweetProductionStream` via Kafka transport in XML format and send sweet production events via WebSocket transport in XML format and log the events in `LowProductionAlertStream` to the output console.

## Prerequisites

Prepare the server to consume from  Kafka, follow the steps below:

1. Download the Kafka broker from [the Apache site](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.3.0/kafka_2.12-2.3.0.tgz) and extract it.
From here onwards, this directory is referred to as `<KAFKA_HOME>`.

2. Create a directory named `Source` in a preferred location in your machine and copy the following JARs to the `Source` directory from the `<KAFKA_HOME>/libs` directory.

    - `kafka_2.12-2.3.0.jar`

    - `kafka-clients-2.3.0.jar`

    - `metrics-core-2.2.0.jar`

    - `scala-library-2.12.8.jar`

    - `zkclient-0.11.jar`

    - `zookeeper-3.4.14.jar`
  
3. Create another directory named `Destination` in a preferred location in your machine.

4. To convert the Kafka JARS you copied to the `Source` directory, issue the following command:

    - For Windows:
    ```
    {WSO2SIHome}/bin/jartobundle.bat <{Source} Directory Path> <{Destination} Directory Path>
    ```
    - For Linux:
    ```
    sh {WSO2SIHome}/bin/jartobundle.sh <{Source} Directory Path> <{Destination} Directory Path>
    ```

5. Add the OSGI converted Kafka libs from the `Destination` directory to the `<SI_HOME>/lib` directory.

6. Add the original Kafka libs from `Source` to `<SI_Home>/samples/sample-clients/lib`.

## Consuming data from Kafka

### Step 1: Start Kafka

1. Navigate to the `<KAFKA_HOME>` directory and start a Zookeeper node by issuing the following command.

    `sh bin/zookeeper-server-start.sh config/zookeeper.properties`

2. Navigate to the `<KAFKA_HOME>` directory and start the Kafka server node by issuing the following command.

    `sh bin/kafka-server-start.sh config/server.properties`

### Step 2: Start the Streaming Integrator

Navigate to the `<SI_HOME>/bin` directory and issue the following command. 

`sh server.sh`

The following log appears on the SI console when the server is started successfully.

```
INFO {org.wso2.carbon.kernel.internal.CarbonStartupHandler} - WSO2 Streaming Integrator started in 4.240 sec
```

### Step 3: Consume from a Kafka topic and Publish to WebSocket

1. Let's create a basic Siddhi application to consume messages from a Kafka topic and publish to WebSocket in XML format.

```
@App:name("RecieveKafkaPublishWebSocket")
@App:description("Description of the plan")

@source(type='kafka',
        topic.list='kafka_sample_topic',
        partition.no.list='0',
        threading.option='single.thread',
        group.id='group',
        bootstrap.servers='localhost:9092',
@map(type='xml'))
define stream SweetProductionStream(name string, amount double);

@sink(type='websocket', 
      url='ws://localhost:8025/abc',
@map(type='xml'))
define stream LowProductionAlertStream (name string, amount double);

@info(name='query1')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```

2. Save the sample. If there is no syntax error in the Siddhi Application, the following message is shown on the console:

```
Siddhi App RecieveKafkaPublishWebSocket.siddhi successfully deployed. 
```

#### Executing the Sample

1. Open a terminal and navigate to `<SIHome>/samples/sample-clients/kafka-producer` and run "ant" command as follows:
```
ant -Dtype=xml -DtopicName=kafka_sample_topic
```

You can limit the number of events as follows as well,
```
ant -Dtype=xml -DnoOfEventsToSend=5 -DtopicName=kafka_sample_topic
```

2. Open a terminal and navigate to the `<SIHome>/samples/sample-clients/websocket-receiver` directory and run the `ant` command.

    If you use the default host 'localhost' and port '8025' in your program use `ant` command without any arguments.
    However, if you use different host or port, run the ant command with appropriate arguments.
    e.g., `ant -Dport=9025`
 
3. Start the Siddhi application by clicking on 'Run'.

4. If the Siddhi application starts successfully, the following messages would be shown on the console.
        ```
        * RecieveKafkaPublishWebSocket.siddhi -  Started Successfully!
        ```

#### Notes

If you edit this application while it's running, stop the application -> Save -> Start.

## Viewing the Results

Check the output in the terminal of <SI_Home>/samples/sample-clients/websocket-receiver. You will see output similar to the following: 
```
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341745974, data=[Jelly Bean, 6559.3817149644165], isExpired=false}
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341746974, data=[KitKat, 292.1776931457968], isExpired=false}
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341739972, data=[Cream Sandwich, 9850.605768948268], isExpired=false}
[java] [io.siddhi.core.stream.output.sink.LogSink] : WebSocketSample : logStream : Event{timestamp=1617341737970, data=[Éclair, 2183.9079927424236], isExpired=false}
```

### Step 4: Generate an Async API

1. After saving the Siddhi file, click **Async API View** button to open the Async API Generation form.

![Async API View button](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)

Since there are no Async API content with the @App:asyncAPI annotation, the Async API generation form opens as shown in the figure below.

It consists of set of fields such as,

- Title
- Version
- Description
- Server Name
- Source/ Sink to generate Async API
- Sources

to be filled in order to generate the Async API spec for the selected source.
The fields can be populated as follows in the given figure.

![Design View of Async API](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/async-api-form.png)

2. To view the generated Async API specification, click on the **Generate Async API** Button.

![Generate Async API button](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/generate-async-api-view-button.png)

### Step 5: View the Async API in Streaming Integrator Tooling

1. After the Async API is generated as described above, the Async API specifications will be visible in the **Async API View** as follows.

   ![Async API view](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/async-api-spec-view.png)

2. Click on the **Add Async API** button to add the generated Async API to the Siddhi application.

   ![Add Async API](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/add-async-api-button.png)

3. Click on the **Code View** button to view the updated Siddhi application with the Async API that was generated.

   ![Code view](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/async-api-form.png)

### Step 6: Export the Siddhi Application to Service Catalogue in SI Server

Then our next step will be to export this Async API definition that we created to the Service Catalogue of the WSO2 API Manager.

1. For this we should deploy the Siddhi Application to the WSO2 Streaming Integrator Server. This can be done via the tooling distribution. There's an option as `Deploy to server` under `Deploy` menu to deploy one or more Siddhi applications and deploy them to one or more Streaming Integrator servers. 

![Deploy To Server](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/async-api-deploy-to-server.png)

2. After selecting the particular Siddhi Application and by adding the relevant WSO2 Streaming Integrator server information as shown in the following diagram, Click on `Deploy` button.

![Deploy Button](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/async-api-deploy.png)

3. When the Siddhi Application get deployed in the WSO2 Streaming Integrator server, the generated Async API definition will be exported to the Service Catalogue. This can be confirmed using the following logs in the WSO2 Streaming Integrator server.

```
Siddhi App AsyncAPIDef deployed successfully
Async API: SweetProdApp-1.0.0 uploaded to the service catalogue
```

The following log can be seen in the API Manager
```
CommonUtil Creation of folder is successful. Directory Name : SweetProdApp-1.0.0
```

### Step 7: View the Async API in API Manager

To view the Async API in the API Manager Service Catalogue, access the API Manager Publisher's Service Catalogue. via the `https://localhost:9448/publisher/service-catalog`. For this let's get logged in to the WSO2 API Manager.

1. Sign in to the WSO2 API **Publisher Portal**.

`https://<hostname>:9443/publisher` (e.g. `https://localhost:9443/publisher`)

2. Click on the **Hamburger Icon** on the top left corner of the page in the Publisher Portal.

3. Select the **Service Catalogue** Menu as shown in the following figure.

![Service Catalog Menu](https://github.com/wso2/docs-apim/tree/master/en/docs/assets/img/integrate/service-catalog/go-to-service-catalog.png)

Here you can view and search for all the deployed services from this interface of the Service Catalogue. To search for services, click on the search icon on the top right corner of the listing table shown in the diagram below.
 
The `SweetProdApp` that was deployed will be shown in this interface as follows.

![Service Catalogue Entry in API Manager](https://github.com/wso2/docs-apim/blob/master/en/docs/assets/img/streaming/working-with-async-api/service-catalogue-entry.png)

### Step 8: Manage Services in the Service Catalogue

View information of a specific Service in the Service Catalogue by clicking on the name of the **Service** from the listing page.

Click on **Hamburger Icon** -> Select **Service Catalog** -> Click on the **Service name**

You will be directed to the **Service Overview** page as follows where you can view service information such as,

- Service name 
- Version
- Description
- Usages in APIs
- Other important metadata.

### Step 9: Creation of an API

Create an API from a deployed service by clicking on the **Create API** button in the services listing page.

Provide the details in there for API Name, Context and Version where all fields are mandatory, and click on the **Create API** button. 
Then you will then be directed to the overview page of the API created from the deployed service.

## Additional Information

For more information on deploying Siddhi Applications, see [Deploying Siddhi Applications](https://github.com/wso2/docs-apim/blob/master/en/docs/develop/streaming-apps/deploying-streaming-applications.md).

For more information on [Publishing Async API Specifications to API Manager](https://github.com/wso2/docs-apim/blob/4d68b4d29927cd249ae1209b2a80207f5b953bb7/en/docs/use-cases/streaming-usecase/exposing-stream-as-managed-api-in-service-catalogue.md) 
to check on how WSO2 Streaming Integrator deploys the Async API specification into Service Catalogue of the WSO2 API Manager.

## Note

- Stop this Siddhi application, once you are done with the execution.
- Stop Kafka server and Zookeeper server individually by executing Ctrl+C.

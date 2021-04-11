# Expose a Kafka Topic as a Managed WebSocket API

The Streaming Integrator (SI) component in WSO2 API Manager (WSO2 API-M) can consume events from a third-party streaming provider topic (e.g., Kafka topic) and publish those events to a Streaming Backend (e.g., WebSocket Streaming Backend) in a streaming manner. When a stream of events are received by the third-party streaming provider source (e.g., Kafka source), they are published to the Streaming Backend simultaneously. 

In this tutorial, let's use the Streaming Integrator Tooling component in WSO2 API-M to receive events to the stream named `SweetProductionStream` via the Kafka transport in XML format. Thereafter, let's send the sweet production events via the WebSocket transport in XML format and log the events in the stream named `LowProductionAlertStream` to the output console. Thereafter, let's generate AsyncAPI definition for the WebSocket Streaming API and publish it to the WSO2 API Manager Service Catalog. Using the service in the Service Catalog, let's create a Streaming API, publish it, and invoke the API.

Follow the instructions below to expose a third-party Service Provider stream as a managed API:

## Prerequisites

??? note " 1. Configure the Streaming Integrator"

    Follow the steps below to configure the Streaming Integrator to consume the stream from Kafka:

    1. Download the [Kafka broker](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.3.0/kafka_2.12-2.3.0.tgz), which is available on the Apache site and extract it.

        Let's refer to this directory as `<KAFKA_HOME>`.

    2. Copy the required JAR files.

        1. Create a directory named `Source` in a preferred location in your machine.
        
        2. Navigate to the `<KAFKA_HOME>/libs` directory and copy the following JARs to the `Source` directory.

            - `kafka_2.12-2.3.0.jar`

            - `kafka-clients-2.3.0.jar`

            - `metrics-core-2.2.0.jar`

            - `scala-library-2.12.8.jar`

            - `zkclient-0.11.jar`

            - `zookeeper-3.4.14.jar`

    3. Create another directory named `Destination` in a preferred location in your machine.

    4. Convert the Kafka JARS into OSGi bundles.

        Execute the following command to convert the Kafka JARS, which are in the `Source` directory.

        ``` bash tab="Windows"
        <SI_HOME>/bin/jartobundle.bat <source-directory-path> <destination-directory-path>
        ```

        ``` bash tab="Linux"
        sh <SI_HOME>/bin/jartobundle.sh <source-directory-path> <destination-directory-path>
        ```

    5. Add the **OSGi converted Kafka libs** from the `Destination` directory to the `<SI_HOME>/lib` directory.

    6. Add the **original Kafka libs** from `Source` to the `<SI_HOME>/samples/sample-clients/lib` directory.

??? note "2. Start Kafka"

    1.Navigate to the `<KAFKA_HOME>` directory and start a Zookeeper node.

        ```
        sh bin/zookeeper-server-start.sh config/zookeeper.properties
        ```

    2. Navigate to the `<KAFKA_HOME>` directory and start the Kafka server node.

        ```
        sh bin/kafka-server-start.sh config/server.properties
        ```

??? note "3. Install Apache Ant"

    Download and install [Apache Ant](https://ant.apache.org/).

## Step 1 - Enable publishing to the service catalog

Follow the instructions below to enable publishing the AsyncAPI definition to the service catalog in WSO2 API Manager:

1. Configure the API Manager port.

     You have to define the port to which the Streaming Integrator publishes the AsyncAPI definition.

     1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file.

     2. Uncomment `offset` in the `[server]` section and set it to `5` as shown below.

         ```
         [server]
         offset=5
         ```
   
2. Configure the basic details needed to publish to the service catalog.

     1. Open the `<SI_HOME>/conf/server/deployment.yaml` file. 
     
     2. Update the `async.api.configs:` section as follows:

        ```
        async.api.configs:
            enabled: true
            hostname: localhost
            port: 9448
            username: admin
            password: admin
        ```
         In the above configuration -
         
           - You are enabling the AsyncAPI generation functionality by setting the `enabled` parameter to `true`. 
            
           - You are specifying `9448` as the port because you configured a port offset of 5 in the previous step. The default port of the API Manager is `9443`.

## Step 2 - Start the Streaming Integrator

1. Navigate to the `<SI_HOME>/bin` directory 

2. [Start the Streaming Integrator]({{base_path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-si-binary/#starting-the-si-server).

     The following log appears on the SI console when the server is started successfully.

    ```
    INFO {org.wso2.carbon.kernel.internal.CarbonStartupHandler} - WSO2 Streaming Integrator started in 4.240 sec
    ```

## Step 3 - Create a Streaming Backend

The default Streaming Integrator component is powered by [Siddhi](https://siddhi.io/). Therefore, you need to create a Siddhi application as the Streaming Backend.
     
Let's create a basic Siddhi application that can consume messages from a Kafka topic and publish it to the WebSocket-based event sink in XML format.

Follow the instructions below to create a Streaming Backend server:

1. [Start Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

2. Click **New** to open a new file.

3. Define your Siddhi application.

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

        @sink(type='websocket-server', 
        url='ws://localhost:8025/abc',
        @map(type='xml'))
        define stream LowProductionAlertStream (name string, amount double);

        @info(name='query1')
        from SweetProductionStream
        select *
        insert into LowProductionAlertStream;
    ```

4. Save the file. 

     If there is no syntax error in the Siddhi application, the following message appears in the console:

     ```
     Siddhi App RecieveKafkaPublishWebSocket.siddhi successfully deployed. 
     ```

## Step 4 - Generate an AsyncAPI Definition

Follow the instructions below to generate an AsyncAPI Definition via the Streaming Integrator Tooling Component:

1. Click **Async API View**.

     The AsyncAPI Generation form appears.

     [![Async API View button]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)

2. Enter the WebSocket Streaming API related details.
    
     The AsyncAPI generation form appears because you did not provide any Streaming API related content for the `@App:asyncAPI` annotation when defining the Siddhi application.

     Let's add the following Streaming API information to create a WebSocket API based AsyncAPI definition.

     | **Field**                                            | **Value**                             |
     |------------------------------------------------------|---------------------------------------|
     | **Title**                                            | `SweetProdApp`                  |
     | **Version**                                          | `1.0.0`                               |
     | **Description**                                      | `Consumes events of sweets production` |
     | **Select Source or Sink type to Generate Async API** | Select **websocket-server**           |
     | **Sources**                                          | Select **SweetProductionStream**      |

     [![Design View of Async API]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)

3. Click **Generate Async API** to generate the AsyncAPI definition.

     ![Generate Async API button]({{base_path}}/assets/img/streaming/working-with-async-api/generate-async-api-view-button.png)

     After the Async API is generated as described above, the Async API specifications will be visible in the **Async API View**.

     ![Async API view]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-spec-view.png)

4. Add the generated AsynAPI definition to the Streaming backend.

     Click **Add Async API** to add the generated AsyncAPI definition to the Siddhi application.

     <a href="{{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png"><img src="{{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png" width="20%" alt="Add Async API"></a>

3. Click **Code View** to view the Siddhi application with the AsyncAPI definition that was generated and to edit it if required.

## Step 5 - Publish the AsyncAPI definition

You need to deploy your Streaming backend, which contains the AsycAPI definition, to the Streaming Integrator server in order to export the AsyncAPI definition that you generated to the service catalog in WSO2 API Manager.

Follow the instructions below to publish the AsyncAPI definition to the service catalog:

1. Click **Deploy**, and then click **Deploy to Server** in Streaming Integrator Tooling. 

     [![Deploy To Server]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy-to-server.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy-to-server.png)

     This opens the **Deploy Siddhi Apps to Server** dialog box. 

2. Select the relevant check box for your Siddhi application, which contains the AsyncAPI definition, and for the server in which you want to deploy it. 

3. Click **Deploy**.

     [![Deploy Button]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy.png)

     After the Siddhi application is successfully deployed, the following log messages appear in the Streaming Integrator and API Manager server logs to indicate that the AsyncAPI definition is successfully published in the Service Catalog.

    ```bash tab="Streaming Integrator server logs"
    Siddhi App AsyncAPIDef deployed successfully
    Async API: SweetProdApp-1.0.0 uploaded to the service catalogue
    ```

    ```bash tab="API Manager server logs"
    CommonUtil Creation of folder is successful. Directory Name : SweetProdApp-1.0.0
    ```

## Step 6 - View the service catalog entry in WSO2 API-M

Follow the instructions below to view the service catalog entry in WSO2 API Manager:

1. Sign in to the Publisher.

     `https://<hostname>:9448/publisher`
     
     For testing purposes, you can use `https://localhost:9448/publisher` and `admin` as the username and password.

     [![Open Service Catalog]({{base_path}}/assets/img/integrate/tutorials/service-catalog/open-service-catalog.png)]({{base_path}}/assets/img/integrate/tutorials/service-catalog/open-service-catalog.png)
     
2. Click **Service Catalog**.

     The services, which include the `SweetProdApp` service, appear.

3. Click on the respective service (`SweetProdApp`) to view details of the managed service.

## Step 7 - Create an API

Follow the instructions below to create an API from the deployed managed service via the WSO2 API Manager Publisher.

1. Click **Create API** in the Service Catalog page, which is in the Publisher.

2. Enter all the Streaming API details.

    | Field   | Value         |
    |---------|---------------|
    | Name    | SweetProdApp  |
    | Context | /SweetProdApp |
    | Version | 1.0.0         |

3. Click **Create API**.

    [![Create API from Service]({{base_path}}/assets/img/integrate/service-catalog/create-api-from-service.png)]({{base_path}}/assets/img/integrate/service-catalog/create-api-from-service.png)

     The API overview page appears.

## Step 8 - Publish the API

Follow the instructions below to publish the API via the WSO2 API Manager Publisher.

1. Click **Lifecycle** to navigate to the API lifecycle.

2. Click **Publish** to publish the API to the API Developer Portal.

     If the API is published successfully, the lifecycle state will shift to **PUBLISHED**.

     [![Publish API]({{base_path}}/assets/img/learn/publish-api.png)]({{base_path}}/assets/img/learn/publish-api.png)

## Step 9 - Invoke the published API

1. View the published API.
    
     Navigate to the Developer Portal.

    `https://<hostname>:9448/devportal`
     
     For testing purposes, you can use `https://localhost:9448/devportal` and `admin` as the username and password.

     The API that you published is visible in the API listing page.

2. Subscribe to the API.

3. Click **Subscriptions** and thereafter click **SUBSCRIPTION & KEY GENERATION WIZARD**.

    1. Navigate through the SUBSCRIPTION & KEY GENERATION WIZARD.
    
         This wizard takes you through the steps of creating a new application, subscribing, generating keys, and generating an access token to invoke the API.

         [![Subscription & Key Generation Wizard]({{base_path}}/assets/img/learn/key-generation-wizard.png)]({{base_path}}/assets/img/learn/key-generation-wizard.png)

    2. Copy the authorization token that appears in here.

         <a href="{{base_path}}/assets/img/learn/generate-access-token-popup.jpg"><img src="{{base_path}}/assets/img/learn/generate-access-token-popup.jpg" width="55%" alt="Authorization token"></a>

4. Try out the operations.

     1. Install wscat client.

         ```
         npm install -g wscat
         ```

     2. Invoke the API by using an authorization header by executing the following command.
        
         ``` java tab="WS"
         wscat -c ws://localhost:9099/sweetProdApp/1.0.0 -H "Authorization: Bearer [accesstoken]" 
         ```

         ``` java tab="WSS"
         wscat -n -c wss://localhost:8099/sweetProdApp/1.0.0 -H "Authorization: Bearer [accesstoken]"
         ```

        <html>
        <div class="admonition note">
        <p class="admonition-title">Note</p>
        <p>
        There are clients (especially browsers) that do not allow to add headers. In such cases, you can send the access token for the API invocation as a query parameter named `access_token` by using the command below:</p>
           
        ``` java tab="WS"
        wscat -c "ws://localhost:9099/sweetProdApp/1.0.0?access_token=[accesstoken]" 
        ```

        ``` java tab="WSS"
        wscat -n -c "wss://localhost:8099/sweetProdApp/1.0.0?access_token=[accesstoken]"
        ```

        </div>
        </html>  

## Step 10 - Pass the streaming event to the broker

Let's execute the following Kafka client producer sample to pass the streaming event to Kafka.

1. Open a terminal and navigate to `<SI_HOME>/samples/sample-clients/kafka-producer` file.

2. Receive XML events via Kafka.

     Execute the following Apache Ant command.

     ```
     ant -Dtype=xml -DtopicName=kafka_sample_topic
     ```

    !!! info
        In addition, you can also limit the number of events as follows:

         ```
         ant -Dtype=xml -DnoOfEventsToSend=5 -DtopicName=kafka_sample_topic
         ```
 
5. Start the Streaming Backend.

     Click **Run** in the Streaming Integrator Tooling component to start the Siddhi application, which is the Streaming Backend.

     [![Run menu]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/run-menu-option.png)]({{base_path}}/assets/img/streaming/streaming-integrator-studio-overview/run-menu-option.png)

     If the Siddhi application starts successfully, the following messages appear on the console.
        
    ```
    * RecieveKafkaPublishWebSocket.siddhi -  Started Successfully!
    ```

    !!! note
        If you edit the Siddhi application while it is running, stop the application, save it, and start the application.

Now, you have successfully created and published the API that corresponds to the WebSocket service in the Service Catalog. In addition, you have subscribed to it, obtained an access token for testing, and tested the API with the access token generated.

!!! note

    - Stop this Siddhi application after you are done with the execution.
    - Stop Kafka server and Zookeeper server individually by executing Ctrl+C.

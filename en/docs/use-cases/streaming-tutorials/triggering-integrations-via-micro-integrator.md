# Triggering Integration Flows via the Micro Integrator

## Introduction

In this tutorial, lets look at how the Streaming Integrator generates an alert based on the events received, and how that particular alert can trigger an integration flow in the Micro Integrator, and get a response back to the Streaming Integrator for further processing.

To understand this, consider a scenario where the Streaming Integrator receives production data from a factory, and triggers an integration flow if it detects a per minute production average that exceeds 100.

## Before you begin

- [Start WSO2 Streaming Integrator server]({{base_path}}/setup/installing-si#starting-the-si-server).

- [Start Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview#starting-streaming-integrator-tooling).

- Install the `grpc` Siddhi extension in Streaming Integrator Tooling. To do this, access Streaming Integrator Tooling, click **Tools** -> **Extension Installer** to open the **Extension Installer** dialog box, and then click **Install** for the **gRPC** extension. Restart Streaming Integrator Tooling for the installation to be effective. For detailed instructions, see [Installing Siddhi Extensions]({{base_path}}/develop/streaming-apps/installing-siddhi-extensions/).

- To install the `grpc` Siddhi extension in WSO2 Streaming Integrator, navigate to the `<SI_HOME>/bin` directory and issue the appropriate command based on your operating system.

    - **For Windows**     : `extension-installer.bat install grpc`
    - **For Linux/MacOS** : `./extension-installer.sh install grpc`
    
   Then restart WSO2 Streaming Integrator for the installation to be effective. For detailed instructions to install a Siddhi extension, see [Downloading and Installing Siddhi Extensions]({{base_path}}/streaming/connectors/downloading-and-installing-siddhi-extensions).


## Step 1: Configure the Streaming Integrator

Let's design a Siddhi application that triggers an integration flow and deploy it by following the procedure below:


1. Start and access the Streaming Integrator Tooling. Then click **New** to open a new application.


2. Add a name and a description for your new Siddhi application as follows:

    ```
    @App:name("grpc-call-response")
    @App:description("This application triggers integration process in the micro integrator using gRPC calls")
    ```


3. Let's add an input stream to define the schema of input production events, and connect a source of the `http` type to to receive those events.

    ```
    @source(type = 'http',
            receiver.url='http://localhost:8006/InputStream',
            basic.auth.enabled='false',
            @map(type='json'))
    define stream InputStream(symbol string, amount double);
    ```

    Here, the Streaming Integrator receives events to the `http://localhost:8006/InputStream` in the JSON format. Each event reports the product name (via the `symbol` attribute) and the amount produced.


4. Now, let's add the configurations to publish an alert in the Micro Integrator to trigger an integration flow, and then receive a response back into the Streaming Integrator.

    ```
    @sink(
            type='grpc-call',
            publisher.url = 'grpc://localhost:8888/org.wso2.grpc.EventService/process/inSeq',
            sink.id= '1', headers='Content-Type:json',
            @map(type='json', @payload("""{"symbol":"{{symbol}}","avgAmount":{{avgAmount}}}"""))
        )
    define stream FooStream (symbol string, avgAmount double);

    @source(type='grpc-call-response', sink.id= '1', @map(type='json'))
    define stream BarStream (symbol string, avgAmount double);
    ```

    Note the following in the above configuration:

    - Each output event that represents an alert that is published to the Micro Integrator reports the product name and the average production (as per the schema of the `FooStream` stream.

    - The `grpc-call` sink connected to the `FooStream` stream gets the two attributes from the stream and generates the output events as JSON messages before they are published to the Micro Integrator.  The value for the `publisher.url` parameter in the sink configuration contains `process` and `inSeq` which means that the Streaming Integrator calls the process method of the gRPC Listener server in the Micro Integrator, and injects the message to the `inSeq` which then sends a response back to the client.

    - The `grpc-call-response source` connected to the `BarStream` input stream retrieves a response from the Micro Integrator and publishes it as a JSON message in the Streaming Integrator. As specified via the schema of the `BarStream` input stream, this response comprises of a single JSON message.


5. To publish the messages received from the Micro Integrator as logs in the terminal, let's define an output stream named `LogStream`, and connect a sink of the `log` type to it as shown below.

    ```
    @sink(type='log', prefix='response_from_mi: ')
    define stream LogStream (symbol string, avgAmount double);
    ```

6. Let's define Siddhi queries to calculate the average production per minute, filter production runs where the average production per minute is greater than 100, and direct the logs to be published to the output stream.

    a. To calculate the average per minute, add a Siddi query named `CalculateAverageProductionPerMinute` as follows:

        ```
        @info(name = 'CalculateAverageProductionPerMinute')
        from InputStream#window.timeBatch(1 min)
        select avg(amount) as avgAmount, symbol
        group by symbol
        insert into AVGStream;
        ```

     This query applies a time batch window to the `InputStream` stream so that events within each minute is considered a separate subset to be calculations in the query are applied. The minutes are considered in a tumbling manner because it is a batch window. Then the `avg()` function is applied to the `amount` attribute of the input stream to derive the average production amount. The results are then inserted into an inferred stream named `AVGStream`.

    b. To filter events from the `AVGStream` stream where the average production is greater then 100, add a query named `FilterExcessProduction` as follows.

        ```
        @info(name = 'FilterExcessProduction')
        from AVGStream[avgAmount > 100]
        select symbol, avgAmount
        insert into FooStream;
        ```

      Here, the `avgAmount > 100` filter is applied to filter only events that report an average production amount greater than 100. The filtered events are inserted into the `FooStream` stream.

    c. To select all the responses from the Micro Integrator to be logged, add a new query named `LogResponseEvents`

        ```
        @info(name = 'LogResponseEvents')
        from BarStream
        select *
        insert into LogStream;
        ```

      The responses received from the Micro Integrator are directed to the `BarStream` input stream. This query gets them all these events from the `BarStream` stream and inserts them into the `LogStream` stream that is connected to a `log` stream so that they can be published as logs in the terminal.

      The Siddhi application is now complete.

    ???info "Click here to view the complete Siddhi application."
        ```
        @App:name("grpc-call-response")
        @App:description("This application triggers integration process in the micro integrator using gRPC calls")

        @source(type = 'http',
                    receiver.url='http://localhost:8006/InputStream',
                    basic.auth.enabled='false',
                    @map(type='json'))
        define stream InputStream(symbol string, amount double);

        @sink(
            type='grpc-call',
            publisher.url = 'grpc://localhost:8888/org.wso2.grpc.EventService/process/inSeq',
            sink.id= '1', headers='Content-Type:json',
            @map(type='json', @payload("""{"symbol":"{{symbol}}","avgAmount":{{avgAmount}}}"""))
        )
        @sink(type='log')
        define stream FooStream (symbol string, avgAmount double);

        @source(type='grpc-call-response', sink.id= '1', @map(type='json'))
        define stream BarStream (symbol string, avgAmount double);

        @sink(type='log', prefix='response_from_mi: ')
        define stream LogStream (symbol string, avgAmount double);

        @info(name = 'CalculateAverageProductionPerMinute')
        from InputStream#window.timeBatch(5 sec)
        select avg(amount) as avgAmount, symbol
        group by symbol
        insert into AVGStream;

        @info(name = 'FilterExcessProduction')
        from AVGStream[avgAmount > 100]
        select symbol, avgAmount
        insert into FooStream;

        @info(name = 'LogResponseEvents')
        from BarStream
        select *
        insert into LogStream;
        ```

7. Save the Siddhi application. As a result, it is saved in the `<SI_TOOLING_HOME>/wso2/server/deployment/workspace` directory.

8. Click the **Deploy** menu option and then click **Deploy to Server**. The **Deploy Siddhi Apps to Server** dialog box opens as shown in the example below.

    ![Deploy to Server dialog box]({{base_path}}/assets/img/streaming/getting-si-run-with-mi/deploy-to-server-dialog-box.png)

    1. In the **Add New Server** section, enter information as follows:

           | Field           | Value                            |
           |-----------------|----------------------------------|
           | **Host**        | Your host                        |
           | **Port**        | `9443`                           |
           | **User Name**   | `admin`                          |
           | **Password**    | `admin`                          |

        ![Add New Server]({{base_path}}/assets/img/streaming/getting-si-run-with-mi/add-new-server.png)

        Then click **Add**.

    2. Select the check boxes for the **grpc-call-response.siddhi** Siddhi application and the server you added as shown below.

        ![Deploy Siddhi Apps to Server]({{base_path}}/assets/img/streaming/getting-si-run-with-mi/select-siddhi-app-and-server.png)

    3. Click **Deploy**.

        When the Siddhi application is successfully deployed, the following message appears in the **Deploy Siddhi Apps to Server** dialog box.

        ![Deployment Status]({{base_path}}/assets/img/streaming/getting-si-run-with-mi/siddhi-application-deployment-status.png)

    As a result, the `grpc-call-response.siddhi` Siddhi application is saved in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.



## Step 2: Configure Micro Integrator

After doing the required configurations in the Streaming Integrator, let's configure the Micro Integrator to receive the excess production alert from the Streaming Integrator as a gRPC event and send back a response.

1. Start the gRPC server in the Micro Integrator server to receive the Streaming Integrator event. To do this, save the following inbound endpoint configuration as `GrpcInboundEndpoint.xml` in the `<MI_Home>/repository/deployment/server/synapse-configs/default/inbound-endpoints` directory.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <inboundEndpoint xmlns="http://ws.apache.org/ns/synapse" name="GrpcInboundEndpoint" sequence="inSeq" onError="fault" protocol="grpc" suspend="false">
        <parameters>
            <parameter name="inbound.grpc.port">8888</parameter>
        </parameters>
    </inboundEndpoint>
    ```

    This configuration has a configuration parameter to start the gRPC server, and specifies the default sequence to inject messages accordingly.
    
    !!! info
        Currently, WSO2 Integration Studio does not support GRPC Inbound Endpoint. This capability will be available in a future [release](https://github.com/wso2/devstudio-tooling-ei/issues/1238). 
        For now, you need to create the inbound endpoint manually as an XML file.


2. Deploy the following sequence by saving it as `inSeq.xml` file in the `<MI_Home>/repository/deployment/server/synapse-configs/default/sequences` directory.

    !!!info
        Note that the name of the sequence is `inSeq`. This is referred to in the `gRPC` sink configuration in the `grpc-call-response` Siddhi application you previously created in the Streaming Integrator.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <sequence xmlns="http://ws.apache.org/ns/synapse" name="inSeq">
       <log level="full"/>
       <respond/>
    </sequence>
    ```

   This sequence does the following:

   - Calls the REST endpoint that returns a JSON object.

   - Logs the response.

   - Sends the response back to the gRPC client.


## Step 3: Send events and generate results

To send an event to the defines `http` source hosted in `http://localhost:8006/InputStream`, issue the following sample CURL command.

`curl -X POST -d "{\"event\":{\"symbol\":\"soap\",\"amount\":110.23}}" http://localhost:8006/InputStream --header "Content-Type:application/json"`

In the SI console an output similar to following will be printed after 1 minute (if the average of the amount is larger than 100)

`INFO {io.siddhi.core.stream.output.sink.LogSink} - response_from_mi:  : Event{timestamp=1573711436547, data=[soap, 110.23], isExpired=false}
`


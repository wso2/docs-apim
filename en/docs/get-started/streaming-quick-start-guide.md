# Quick Start Guide - Streaming Integration

Let's get started with WSO2 Streaming Integrator(SI) by running a simple streaming use case in your local environment. 

### Before you begin...

1. Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 11 or 1.8 and set the `JAVA_HOME` environment variable.
   For more information on setting the `JAVA_HOME` environment variable for different operating systems, see [Setup and Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/).
2. Download the Streaming Integrator and Streaming Integrator Tooling distributions from the [WSO2 Streaming Integrator site](https://wso2.com/integration/streaming-integrator/) and extract them to a location of your choice. Hereafter, the extracted location is referred to as `<SI_HOME>` and `<SIT_HOME>` respectively.<br/><br/>

### What you'll build
In this sample scenario, you will aggregate the data relating to the raw material purchases of a sweet production factory and publishers the data to a WebSocket receiver.
                                

### Step 1: Start the Streaming Integrator

To start WSO2 Streaming Integrator, navigate to the `<SI_HOME>/bin` directory from the CLI, and issue the appropriate command based on your operating system:

- **For Linux**: `./server.sh`
- **For Windows**: `server.bat --run`

### Step 2: Start the Streaming Integrator Tooling
To start WSO2 Streaming Integrator Tooling, navigate to the `<SIT_HOME>/samples/sample-clients/websocket-receiver` directory from the CLI, and issue `ant`.
This will 

- **For Linux**: `./server.sh`
- **For Windows**: `server.bat --run`

### Step 3: Create and deploy a simple Siddhi application

Let's create a simple Siddhi application that reads data from a XML file, does a simple transformation to the data, and then writes the results to the WebSocket receiver running.

1. Download `sampledata.xml` file from [here]({{base_path}}/assets/attachments/quick-start-guide/sampledata.xml) and save it in a location of your choice.

    !!! info
        In this example, the file is located in the `/Users/foo` directory.

2. Open a text file and copy-paste the following Siddhi application into it.

    !!! tip
        Here, a sample Siddhi application is provided to minimize the time spend following this guide. But we recommend using Streaming Integration Tooling that offers features such as syntax checking, event simulation for testing purposes, reformatting code, the option to design applications in a graphical interface or by writing code, and many more. For more information to design the Siddhi applications, see [Streaming Integrator Tooling Overview]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview).

    ```
    @App:name('ManageStats')
    @App:description('Receive events via a xml file and write sum of the amount to websocket')

    @source(type = 'file', mode = "TEXT.FULL", file.uri = "file:/Users/foo/sampledata.xml",
    @map(type = 'xml'), enclosing.element='/events/event',enable.streaming.xml.content='true',
    @attributes(name = "name", amount = "amount"))
    define stream TestProductionStream (name string, amount double);

    @sink(type='websocket', url='ws://localhost:8025/abc',
    @map(type='xml'))
    @sink(type='log')
    define stream ProductionSumAlertStream (name string, amount double);


    -- Simple Siddhi query to calculate production totals.
    @info(name = 'query1')
    from TestProductionStream
    select name, sum(amount) as the amount
    group by name
    insert into ProductionSumAlertStream;
    ```

3. Save this file as `ManageStats.siddhi` in the `<SI_HOME>/wso2/server/deployment/siddhi-files` directory.

    This deploys the `ManageStats` in the Streaming Integrator. The following message appears to indicate that the Siddhi application installed successfully.

    `INFO {org.wso2.carbon.siddhi.editor.core.internal.WorkspaceDeployer} - Siddhi App ManageStats.siddhi successfully deployed.`


## Step 4: Test your Siddhi application

To test the `ManageStats` Siddhi application you created, follow the steps below.

1. Open the `/Users/foo/sampledata.xml` file and add rows in it as follows:

    `    
    <event>
        <name>Almond cookie</name>
        <amount>70</amount>
    </event>
    <event>
        <name>Baked alaska</name>
        <amount>30</amount>
    </event>
    <event>
        <name>Toffee</name>
        <amount>60</amount>
    </event>`

    Save your changes.

2. To observe the MI console output.


You can see the following message in the SI console log.

![]({{base_path}}/assets/img/streaming/qsg/gsg-streaming-output.png)

!!! tip "What's Next?"
    Once you try out this quick start guide, you can proceed to one of the following sections.

    - Learn more about the Streaming Integrator by trying out [Streaming Integrator Tutorials]({{base_path}}/use-cases/streaming-tutorials/tutorials-overview).
    - Start using the Streaming Integrator. For more information and instructions about Streaming Integration functionality, see [Streaming Integrator Use Cases]({{base_path}}/use-cases/streaming-usecase/use-cases).
    - Manage and expose streaming backends via [Streaming APIs]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/streaming-api-overview).


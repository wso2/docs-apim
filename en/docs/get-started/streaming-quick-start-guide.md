# Quick Start Guide - Streaming Integration

Let's get started with WSO2 Streaming Integrator(SI) by running a simple streaming use case in your local environment. 

## Before you begin...

1. Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 11 and set the `JAVA_HOME` environment variable.
   For more information on setting the `JAVA_HOME` environment variable for different operating systems, see [Setup and Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/).
2. Download the Streaming Integrator and Streaming Integrator Tooling distributions from the [WSO2 Streaming Integrator site](https://wso2.com/integration/streaming-integrator/) and extract them to a location of your choice. Hereafter, the extracted location is referred to as `<SI_HOME>` and `<SIT_HOME>` respectively.<br/><br/>
3. Optionally, go to the [WSO2 API Manager website](https://wso2.com/api-management/), click **TRY IT NOW**, and then click **Zip Archive** to download the API Manager distribution as a ZIP file.
   
## What you'll build
In this sample scenario, you aggregate the data relating to the raw material purchases of a sweet production factory and publish the data to a WebSocket server.
                                
![Scenario]({{base_path}}/assets/img/streaming/qsg/streaming-integration-qsg-diagram.png)

### Step 1: Start the Streaming Integrator

To start WSO2 Streaming Integrator, navigate to the `<SI_HOME>/bin` directory from the CLI, and issue the appropriate command based on your operating system:

- **For Linux**: `./server.sh`
- **For Windows**: `server.bat --run`

### Step 2: Start the Streaming Integrator Tooling 
Here, we are going to use the sample Websocket Receiver shipped with the Streaming Integrator Tooling.
To start the sample, navigate to the `<SIT_HOME>/bin` directory from the CLI, and issue the appropriate command based on your operating system:

- **For Linux**: `./tooling.sh`
- **For Windows**: `tooling.bat --run`

### Step 3: Create and deploy a sample Siddhi application

Let's create a simple Siddhi application that reads data from a XML file, does a simple transformation to the data, and then writes the results to the WebSocket receiver running.

1. Download `sampledata.xml` file from [here]({{base_path}}/assets/attachments/quick-start-guide/sampledata.xml) and save it in a location of your choice.

    !!! info
        In this example, the file is located in the `/Users/foo` directory.

2. Navigate to `http://localhost:9390/editor`, 

    !!! Tip
        Use `admin` as the username and password.
        
3. Click on `New`, and copy and paste the content given below.
    
    !!! tip
        Here, a sample Siddhi application is provided to minimize the time spent following this guide. However, WSO2 recommends that you use the Streaming Integration Tooling that offers features such as syntax checking, event simulation for testing purposes, reformatting code, the option to design applications in a graphical interface or by writing code, and many more. For more information on designing Siddhi applications, see [Streaming Integrator Tooling Overview]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview).

    ```
    @App:name('ManageProductionStats')

    @App:description('Receive events via an xml file located in a given directory and write sum of the amount to websocket server as a json event')

     @source(type = 'file', mode = "TEXT.FULL", dir.uri = 'file:/Users/foo/files', enclosing.element = "/events/event", enable.streaming.xml.content = "true", 
    	@attributes(name = "name", amount = "amount"),
	    @map(type = 'xml'))
     @sink(type = 'log')
    define stream SweetsProductionStream (name string, amount double);

    @sink(type = 'websocket-server', host = "localhost", port = "8025",
	    @map(type = 'json'))
    define stream ProductionAlertStream (name string, amount double);

    @sink(type = 'log')
    define stream LowProductionAlertStream (name string, amount double);

     -- Simple Siddhi query to calculate production totals.
     @info(name = 'query1')
    from SweetsProductionStream
    select name, sum(amount) as amount 
	    group by name 
    insert into ProductionAlertStream;
    ```
    
4. Save this file as `ManageProductionStats.siddhi`.

5. Click on **Deploy** and then **Deploy To Server** to deploy the Siddhi Application in Streaming Integrator.

6. Add Streaming Integrator server details by clicking on `Add New Server`

    Specify the Streaming Integrator host `localhost` and port `9443`.
    
7. Select the `ManageProductionStats` and the `Server` and **Deploy**.
The following message appears to indicate that the Siddhi application deployed successfully in the Streaming Integrator console.

    ```INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App ManageProductionStats1 deployed successfully```

 **Voila!!!** You can now test the **SweetProductionApplication** service that you just generated.


### Step 4: Test your Siddhi application

To test the `ManageProductionStats` Siddhi application created above, follow the steps below.

1. Copy the `sampledata.xml` file in the `/Users/foo/files` directory. 

2. Observe the SI console output.

You can see the following message in the SI console log.

```jvm
    INFO {io.siddhi.core.stream.output.sink.LogSink} - ManageProductionStats1 : ProductionAlertStream : [Event{timestamp=1630491334294, data=[Almond cookie, 170.0], isExpired=false}, Event{timestamp=1630491334294, data=[Baked alaska, 100.0], isExpired=false}, Event{timestamp=1630491334294, data=[Toffee, 100.0], isExpired=false}] 
```

</br>
 **Congratulations!**
 Now, you have created your first Streaming service. Optionally, you can follow the steps given below to expose the service as a Managed API in API Manager.
      
## Exposing an Streaming Service as a Managed API

The `ManageProductionStats` Siddhi Application you deployed in the Micro Integrator is a **streaming service** for the API Manager. Now, let's look at how you can expose the streaming service to the API Management layer and generate a managed API by using the service.

### Step 1 - Expose as a service 

1. Start the API Manager runtime:

    1.  Extract the API Manager ZIP file.
    2.  Start WSO2 API Manager:
    
        Open a terminal, navigate to the `<API-M_HOME>/bin` directory and execute the relevant command. 
   
        
        ```bash tab="On MacOS/Linux"
        ./api-manager.sh
        ```
        
        ```bash tab="On Windows"
        api-manager.bat
        ```

2. Update and start the Streaming Integrator runtime:

    1. Stop the Streaming Integrator.

    2. Add the following configuration to the `<SI_HOME>/conf/server/deployment.toml` file of the Streaming Integrator.

        !!! Tip
            The default username and password for connecting to the API Gateway is `admin:admin`.


         ```toml
         service.catalog.configs:
         enabled: true
         hostname: localhost
         port: 9444
         username: admin
         password: admin
         ```
    
    3.  Start the Streaming Integrator again.

3. Access the streaming service from the **API Publisher**:

    1.  Sign in to the API Publisher portal: `https://localhost:9443/publisher`. 

        !!! Tip
            Use `admin` as the username and password.

    2.  You can also click the **hamburger** icon on the upper-left and click **Services** to see the available services.

        <img src="{{base_path}}/assets/img/streaming/qsg/streaming-service-catalog.png" width="400">
  
    3. See that the `SweetProductionApplication` is listed as a service.

### Step 2 - Create a managed API using the Streaming Service

1.  Click on the `SweetProductionApplication` service.

2.  Click **Create API**.

     This opens the **Create API** dialog box with the API details that are generated based on the service.

    <a href="{{base_path}}/assets/img/streaming/qsg/create-api-from-streaming-service.png"><img src="{{base_path}}/assets/img/streaming/qsg/create-api-from-streaming-service.png" width="800"></a>

3.  Update the API name, context, and version if required, and click **Create API**. 

    The overview page of the API that you just created appears. 

4. Optionally, update the portal configurations and API configurations as required.

     Now, you have successfully created a Web Socket API using the service.

### Step 3 - Publish the managed API

1. Navigate to **Deployments** and click **Deploy** to create a revision to deploy in the default Gateway environment. 

2. Navigate to **Lifecycle** and click **Publish** to publish the API in the Gateway environment.
    
    If the API is published successfully, the lifecycle state will shift to **PUBLISHED**. 

### Step 4 - Invoke the Managed API via Developer Portal

1. Navigate to the **Developer Portal** by clicking on `View In Dev Portal` at the top menu.

2. Sign in using the default username/password `admin/admin`. You will be redirected to the **APIs**.

3. Under **APIs**, you will see the published `SweetProductionApplication`. Click on it to navigate to the Overview of the API.

4. Click `Subscriptions` on the left menu and click `SUBSCRIBE` This creates a subscription to the API using the `DefaultApplication`.

    <a href="{{base_path}}/assets/img/streaming/qsg/streaming-api-subscribe.png"><img src="{{base_path}}/assets/img/streaming/qsg/streaming-api-subscribe.png.png" size="800"></a>

5. Click `PROD KEYS` to generate keys for the application and click `GENERATE  KEYS`.
    
    <a href="{{base_path}}/assets/img/streaming/qsg/streaming-api-subscribe.png"><img src="{{base_path}}/assets/img/streaming/qsg/streaming-api-subscribe.png" size="800"></a>

6. Copy the generated access token for future use. Alternatively, you can generate a new access token by using `GENERATE ACCESS TOKEN`.

7. Click `Try Out` on the left menu Click on the **SUB** topic.
  You can see the sample command to access the API.
  
  ```jvm
     wscat -c 'ws://localhost:9099/sweets/1.0.0/' -H 'Authorization: Bearer <access token>'
  ```
  
  Execute the command in Command Line.
  
6. Now, you can remove existing `sampledata.xml` in `/Users/foo/files` and rename the downloaded file as `sampledata1.xml` and copy to the directory.
You can see the below in the Command Line.

```jvm
     < [{"event":{"name":"Butter cookie","amount":50.0}},{"event":{"name":"Almond cookie","amount":271.0}},{"event":{"name":"Baked alaska","amount":150.0}}]
     > %     
```
          
!!! tip "What's Next?"
    Once you try out this quick start guide, you can proceed to one of the following sections.

    - Learn more about the Streaming Integrator by trying out [Streaming Integrator Tutorials]({{base_path}}/use-cases/streaming-tutorials/tutorials-overview).
    - Start using the Streaming Integrator. For more information and instructions about Streaming Integration functionality, see [Streaming Integrator Use Cases]({{base_path}}/use-cases/streaming-usecase/use-cases).
    - Manage and expose streaming backends via [Streaming APIs]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/streaming-api-overview).


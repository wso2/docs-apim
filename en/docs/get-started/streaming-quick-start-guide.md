# Quick Start Guide - Streaming Integration

Let's get started with WSO2 Streaming Integrator(SI) by running a simple streaming use case in your local environment. 

## Before you begin...

1. Install [Oracle Java SE Development Kit (JDK)](http://java.sun.com/javase/downloads/index.jsp) version 11 and set the `JAVA_HOME` environment variable.

     For more information on setting the `JAVA_HOME` environment variable for different operating systems, see [Setup and Install]({{base_path}}/install-and-setup/install/installing-the-product/installing-si/).

2. Download the [Streaming Integrator and Streaming Integrator Tooling distributions](https://wso2.com/integration/streaming-integrator/) and extract them to a location of your choice. 

    !!! Tip
          You can download Streaming Integrator Tooling from the Tooling link in the OTHER RESOURCES section of the above download page.
   
     Hereafter, the extracted location is referred to as `<SI_HOME>` and `<SIT_HOME>` respectively.

3. Optionally, download the API Manager distribution as a ZIP file by navigating to the [WSO2 API Manager product page](https://wso2.com/api-management/), clicking **TRY IT NOW**, and then clicking **Zip Archive**.
   
## What you'll build

In this sample scenario, you aggregate the data relating to the raw material purchases of a sweet production factory and publish the data to a WebSocket server.
                                
[![Scenario]({{base_path}}/assets/img/streaming/qsg/streaming-integration-qsg-diagram.png){: style="width:70%"}]({{base_path}}/assets/img/streaming/qsg/streaming-integration-qsg-diagram.png)

### Step 1 - Start the Streaming Integrator

To start WSO2 Streaming Integrator, navigate to the `<SI_HOME>/bin` directory from the CLI, and issue the appropriate command based on your operating system:

- **For Linux**: `./server.sh`
- **For Windows**: `server.bat --run`

### Step 2 - Start the Streaming Integrator Tooling 

Let's use the sample WebSocket Receiver that is shipped with the Streaming Integrator Tooling.

To start the sample, navigate to the `<SIT_HOME>/bin` directory from the CLI, and issue the appropriate command based on your operating system:

- **For Linux**: `./tooling.sh`
- **For Windows**: `tooling.bat --run`

### Step 3 - Create and deploy a sample Siddhi application

Let's create a simple Siddhi application that reads data from an XML file, does a simple transformation to the data, and then writes the results to the WebSocket receiver running.

1. Download `sampledata.xml` file from [here]({{base_path}}/assets/attachments/quick-start-guide/sampledata.xml) and save it in a location of your choice.

2. Navigate to `http://localhost:9390/editor`.
        
3. Click on **New**, and copy and paste the content given below.

    !!! Note
        The Siddhi application given below listens to the `/Users/foo/files` directory. You will be copying files to this directory in the upcoming steps. Create this directory if you haven't done it, or use another directory by specifying it in the `dir.uri = 'file:/Users/foo/files'` parameter in the Siddhi application.
    
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

5. To deploy the Siddhi application in the Streaming Integrator, click **Deploy** and then click **Deploy to Server**.

6. Add the Streaming Integrator server details under `Add New Server` section and then click **Add**.

     For this example, specify the Streaming Integrator host as `localhost` and port as `9443`.
    
7. Select the `ManageProductionStats` and the `Server` and then click **Deploy**.
 
     The following message appears to indicate that the Siddhi application was deployed successfully in the Streaming Integrator console.

    ```
    INFO {org.wso2.carbon.streaming.integrator.core.internal.StreamProcessorService} - Siddhi App ManageProductionStats deployed successfully
    ```

 You can now test the **SweetProductionApplication** service that you just generated.

### Step 4 - Test your Siddhi application

Follow the instructions below to test the `ManageProductionStats` Siddhi application that you created above.

1. Copy the `sampledata.xml` file downloaded in step 3.1 to the `/Users/foo/files` directory (or the directory that was specified in step 3.3).

2. Observe the SI console output.

     You can see the following message in the SI console log.

     ```jvm
     INFO {io.siddhi.core.stream.output.sink.LogSink} - ManageProductionStats : ProductionAlertStream : [Event{timestamp=1630491334294, data=[Almond cookie, 170.0], isExpired=false}, Event{timestamp=1630491334294, data=[Baked alaska, 100.0], isExpired=false}, Event{timestamp=1630491334294, data=[Toffee, 100.0], isExpired=false}] 
     ```

 **Congratulations!**

 Now, you have created your first Streaming service. Optionally, you can follow the steps given below to expose the service as a Managed API in API Manager.
      
## Exposing a Streaming Service as a Managed API

The `ManageProductionStats` Siddhi Application you deployed in the Streaming Integrator is a **streaming service** for the API Manager. Now, let's look at how you can expose the streaming service to the API Management layer and generate a managed API by using the service.

### Step 1 - Expose as a service 

#### Step 1.1 - Start WSO2 API Manager 

Start the API Manager runtime:

1. Extract the API Manager ZIP file.

2. Start WSO2 API Manager.
     
    !!! Note
          If you are running both APIM and SI in the same JVM, start APIM with a port offset.

     Open a terminal, navigate to the `<API-M_HOME>/bin` directory and execute the relevant command. 

  
     ```bash tab="On MacOS/Linux"
     ./api-manager.sh -DportOffset=1
     ```
  
     ```bash tab="On Windows"
     api-manager.bat -DportOffset=1
     ```

#### Step 1.2 - Start WSO2 Streaming Integrator 

Update and start the Streaming Integrator runtime:

1. Stop the Streaming Integrator.

2. Add the following configuration to the `<SI_HOME>/conf/server/deployment.yaml` file of the Streaming Integrator.

    !!! Tip
        - The default username and password for connecting to the API Gateway is `admin:admin`.
        - The `9444` port shown above is the port of API Manager, to which, the service catalog listens.

     ```toml
     service.catalog.configs:
        enabled: true
        hostname: localhost
        port: 9444
        username: admin
        password: admin
     ```

3.  Start the Streaming Integrator again.

#### Step 1.3 - Generate an AsyncAPI Definition

Follow the instructions below to generate an AsyncAPI Definition via the Streaming Integrator Tooling Component:

1. Click **Async API View**.

     The AsyncAPI Generation form appears.

     [![Async API View button]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)

2. Enter the WebSocket Streaming API related details.
    
     The AsyncAPI generation form appears because you did not provide any Streaming API related content for the `@App:asyncAPI` annotation when defining the Siddhi application.

     Let's add the following Streaming API information to create a WebSocket API based AsyncAPI definition.

     | **Field**                                            | **Value**                             |
     |------------------------------------------------------|---------------------------------------|
     | **Title**                                            | `SweetProductionApplication`                  |
     | **Version**                                          | `1.0.0`                               |
     | **Description**                                      | `Consumes events of sweets production` |
     | **Select Source or Sink type to Generate Async API** | Select **websocket-server**           |
     | **Sources**                                          | Select **ProductionAlertStream**      |

     [![Design View of Async API]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png){: style="width:80%"}]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)

3. Click **Generate Async API** to generate the AsyncAPI definition.

     [![Generate AsyncAPI button]({{base_path}}/assets/img/streaming/working-with-async-api/generate-async-api-view-button.png)]({{base_path}}/assets/img/streaming/working-with-async-api/generate-async-api-view-button.png)

     After the AsyncAPI is generated as described above, the Async API specifications will be visible in the **Async API View**.

     [![Async API view]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-spec-view.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-spec-view.png)

4. Add the generated AsyncAPI definition to the Streaming backend.

     Click **Add Async API** to add the generated AsyncAPI definition to the Siddhi application.

     <a href="{{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png"><img src="{{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png" width="20%" alt="Add Async API"></a>

5. Click **Code View** to view the Siddhi application with the AsyncAPI definition that was generated and save it so that it can be deployed on SI server.

#### Step 1.4 - Publish the AsyncAPI definition

!!! Note
     **Before you begin:**

     - You need to import the public certificate of the API Manager to the truststore of the Streaming Integrator. For information on importing the certificates, see the [Importing certificates to the truststore]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-3-importing-certificates-to-the-truststore) guide.

     - For testing purposes, you can skip the above and simply copy the keystore and the truststore of WSO2 APIM (`wso2carbon.jks` and `client-truststore.jks` files located in the `<WSO2_APIM_HOME>/repository/resources/security/` directory) to the `resources/security` directory of **both** SI and SI Tooling.
     - Restart SI and SI Tooling.

You need to deploy your Streaming backend, which contains the AsyncAPI definition, to the Streaming Integrator server in order to export the AsyncAPI definition that you generated to the services in WSO2 API Manager.

Follow the instructions below to publish the AsyncAPI definition to the service catalog:

1. Click **Deploy**, and then click **Deploy to Server** in Streaming Integrator Tooling. 

     [![Deploy To Server]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy-to-server.png){: style="width:80%"}]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy-to-server.png)

     This opens the **Deploy Siddhi Apps to Server** dialog box. 

2. Add the SI server host and port (default 9443) and select the relevant check box for your Siddhi application, which contains the AsyncAPI definition, and for the server in which you want to deploy it. 

3. Click **Deploy**.

     [![Deploy Button]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy.png){: style="width:80%"}]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-deploy.png)

     After the Siddhi application is successfully deployed, the following log messages appear in the Streaming Integrator and API Manager server logs to indicate that the AsyncAPI definition is successfully published in the Service Catalog.

    ```bash tab="Streaming Integrator server logs"
    Siddhi App ManageProductionStats deployed successfully
    ```

    ```bash tab="API Manager server logs"
    CommonUtil Creation of folder is successful. Directory Name : SweetProdApp-1.0.0
    ```

#### Step 1.5 - Access the streaming service

Access the streaming service via the **API Publisher** as follows:

1. Sign in to the API Publisher portal: `https://localhost:9443/publisher`. 

    !!! Tip
        Use `admin` as the username and password.

2. You can also click the **hamburger** icon on the upper-left and click **Services** to see the available services.

     <a href="{{base_path}}/assets/img/streaming/qsg/streaming-service-catalog.png"><img src="{{base_path}}/assets/img/streaming/qsg/streaming-service-catalog.png" width="40%"></a>

3. See that the `SweetProductionApplication` is listed as a service.

### Step 2 - Create a managed API using the Streaming Service

1. Click on the **SweetProductionApplication** service.

2. Click **Create API**.

     This opens the **Create API** dialog box with the API details that are generated based on the service.

     <a href="{{base_path}}/assets/img/streaming/qsg/create-api-from-streaming-service.png"><img src="{{base_path}}/assets/img/streaming/qsg/create-api-from-streaming-service.png" width="80%"></a>

3. Update the API name, context, and version if required, and click **Create API**. 

     The overview page of the API that you just created appears. 

4. Optionally, update the portal configurations and API configurations as required.

     Now, you have successfully created a WebSocket API using the service.

### Step 3 - Publish the managed API

1. Navigate to **Deployments** and click **Deploy** to create a revision to deploy in the default Gateway environment. 

2. Navigate to **Lifecycle** and click **Publish** to publish the API in the Gateway environment.
    
     If the API is published successfully, the lifecycle state will shift to **PUBLISHED**. 

### Step 4 - Invoke the managed API via Developer Portal

1. Navigate to the **Developer Portal** by clicking on **View In Dev Portal** at the top menu.

2. Sign in using the default username/password `admin/admin`. You will be redirected to the **APIs**.

3. Under **APIs**, you will see the published `SweetProductionApplication`. Click on it to navigate to the Overview of the API.

4. Click **Subscriptions** on the left menu and click **SUBSCRIBE**.

     This creates a subscription to the API using the `DefaultApplication`.

     <a href="{{base_path}}/assets/img/streaming/qsg/streaming-api-subscribe.png"><img src="{{base_path}}/assets/img/streaming/qsg/streaming-api-subscribe.png" size="70%"></a>

5. Click **PROD KEYS** to generate keys for the application and click **GENERATE  KEYS**.

6. Copy the generated access token for future use. Alternatively, you can generate a new access token by using `GENERATE ACCESS TOKEN`.

7. Click **Try Out** on the left menu and click on the **SUB** topic.
  
     You can see the sample command to access the API.

    !!! Tip
        - If `wscat` is not already installed, use the following command to install it:
          ```jvm
          npm install -g wscat
          ```
        - Change the below mentioned default port `9099` according to the port offset of APIM.
  
     ```jvm
     wscat -c 'ws://localhost:9099/sweets/1.0.0/' -H 'Authorization: Bearer <access token>'
     ```
  
     Execute the command in Command Line.
  
8. Remove the existing `sampledata.xml` file in the `/Users/foo/files` directory and rename the downloaded file as `sampledata1.xml` and copy to the directory.

     The following message appears in the Command Line.

     ```jvm
     < [{"event":{"name":"Butter cookie","amount":50.0}},{"event":{"name":"Almond cookie","amount":271.0}},{"event":{"name":"Baked alaska","amount":150.0}}]
        > %     
     ```
          
!!! tip "What's Next?"
    Once you try out this quick start guide, you can proceed to one of the following sections.

    - Learn more about the Streaming Integrator by trying out [Streaming Integrator Tutorials]({{base_path}}/use-cases/streaming-tutorials/tutorials-overview).

    - Start using the Streaming Integrator. For more information and instructions about Streaming Integration functionality, see [Streaming Integrator Use Cases]({{base_path}}/use-cases/streaming-usecase/use-cases).

    - Manage and expose streaming backends via [Streaming APIs]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/streaming-api-overview).


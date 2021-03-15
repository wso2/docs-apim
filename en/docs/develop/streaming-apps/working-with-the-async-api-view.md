# Working with the Async API Spec Generation and Viewing

When a Siddhi application contains one or more sources of the Webaocket, Webhooks or SSE type, those can be exposed as APIs in the API Manager.

This section provides an overview of the Async API specification generation and viewing in the Streaming Integrator Tooling.
    
## Accessing the Async API View

### Generating the Async API
To generate an Async API Spec for a Siddhi app in Streaming Integrator Tooling:

1.  Start the Streaming Integrator Tooling and log in with your credentials. For detailed instructions, see 
    [Streaming Integrator Tooling Overview - Starting Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview#starting-streaming-integration-studio).

2.  Click **New** and open a new Siddhi file and copy-paste following application to it and save.
    
        @App:name('AsyncAPIDef')
        @App:description('Receive events via WebSockettransport in XML format')
        
        @source(type='websocket-server',host = "localhost",port = "8025",keystore.path = "/user/ramindu/wso2carbon.jks",
            @map(type='xml'))
        define stream SweetProductionStream (name string,amount double);
        
        @sink(type='log')
        define stream LowProductionAlertStream (name string,amount double);
        
        @info(name='query1')
        from SweetProductionStream 
        select * 
        insert  into LowProductionAlertStream;
    
    In this example, you are generating an Async API for the websocket-server source.
    
        @source(type='websocket-server',host = "localhost",port = "8025",keystore.path = "/user/ramindu/wso2carbon.jks",
            @map(type='xml'))
        define stream SweetProductionStream (name string,amount double);

3.  Click **Async API View** to open the Async API Generation Form.  
    ![Async API View button]({{base_path}}/assets/img/streaming/working-with-async-api/open-async-api-view-button.png)  
    
    Since there are no Async API content with the `@App:asyncAPI` annotation, the Async API generation form opens as shown in the example below. 
    
    It consists of set of fields and to be filled in order to generate the Async API spec for the selected source or sink from the list.
    The fields can be populated as follows.
    ![Design View]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)
    
4. Click **Generate Async API** to view the generated the Async API Specification.  
   ![Generate Async API button]({{base_path}}/assets/img/streaming/working-with-async-api/generate-async-api-view-button.png)    

### View the Async API

1. After the Async API is generated, the Async API spec will be visible in the `Async API View`
   ![Async API view]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-spec-view.png)

2. Click **Add Async API** to add the generated Async API to the Siddhi application. 
   ![Async API view]({{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png)

3. Click **Code View** to view the uodated Siddhi application with the Async API. 
   ![Async API view]({{base_path}}/assets/img/streaming/working-with-async-api/add-async-api-button.png)
   
## Exporting Siddhi App to SI Server
   
In order to export the Async API definition to te service catalogue of the WSO2 API Manager, the Siddhi app should get deployed in the WSO2 SI server.
The tooling distribution has an `Deploy Siddhi apps to server` option to deploy the siddhi apps directly to the WSO2 SI, using its Siddhi app API.
![ToDeployToServer]({{base_path}}/assets/img/streaming/async-api/async-api-deploy-to-server.png)

After selecting the Siddhi apps and by adding the relevant WSO2 SI server information, Click on `Deploy`
![DeployToServer]({{base_path}}/assets/img/streaming/async-api/async-api-deploy.png)

For more information on deploying, see [Deploying Siddhi Applications]({{base_path}}/develop/streaming-apps/deploying-streaming-applications).

See [Publishing Async API Specifications to API Manager]({{base_path}}/streaming-usecase/async-api-spec-publishing-to-service-catalogue) 
to check on how WSO2 SI deploys the specification into API Manager's service catalogue.


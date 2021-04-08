# Exposing a Stream as a Managed API

Managed APIs refer to the APIs that are managed using WSO2 API Manager, namely REST APIs, GraphQL APIs, SOAP APIs, and Streaming APIs. This guide explains how to create a Streaming backend for a [Streaming API]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/streaming-api-overview), generate an AsyncAPI definition for the corresponding Streaming API, and then publish the AsyncAPI definition in the WSO2 API Manager Service Catalog. 

This involves enabling the AsyncAPI functionality in the Streaming Integrator component. As a result, when you deploy a Siddhi application with an AsyncAPI definition in the Streaming Integrator server, the Streaming Integrator exposes it as an API in WSO2 API Manager's service catalog.

## Before you begin

1. [Start the Streaming Integrator server]({{base_path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-si-binary/#starting-the-si-server).
2. [Start the API Manager server]({{base_path}}/install-and-setup/install/installing-the-product/installing-the-binary/installing-on-linux-or-os-x/).

## Step 1 - Enable AsyncAPI generation

Follow the instructions below to enable AsyncAPI generation in the Streaming Integrator:

1. Configure the API Manager port.

     You have to define the port to which the Streaming Integrator publishes the AsyncAPI definition.

     1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file.

     2. Uncomment `offset` in the `[server]` section and set it to `5` as shown below.

         ```
         [server]
         offset=5
         ```
   
2. Configure the basic details needed for AsyncAPI generation.

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
   
## Step 2 - Create a Streaming Backend

The default WSO2 Streaming Integrator, which WSO2 API Manager uses, is powered by [Siddhi](https://siddhi.io/). Therefore, you need to create a Siddhi application that has one or more sources, namely of the types `websocket-server`, `webhooks`, or `sse`, as the streaming backend.

Follow the instructions below to create a Streaming Backend server:

1. [Start Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview/#starting-streaming-integrator-tooling).

2. Click **New** to open a new file.

3. Define your Siddhi application.

     Let's add the following Siddhi application configurations.

     ```
     @App:name('AsyncAPIDef')
     @App:description('Receive events via WebSockettransport in XML format')

     @source(type='websocket-server',host = "localhost",port = "8025",keystore.path = "/user/foo/wso2carbon.jks",
        @map(type='xml'))
     define stream SweetProductionStream (name string,amount double);

     @sink(type='log')
     define stream LowProductionAlertStream (name string,amount double);

     @info(name='query1')
     from SweetProductionStream 
     select * 
     insert  into LowProductionAlertStream;   
     ```
   
3. Save the file.
    
    The Siddhi application that you configured includes a `websocket-server` type source. This Streaming backend is used to generate an AsyncAPI definition for your WebSocket Streaming API.

## Step 3 - Generate the AsyncAPI definition

Follow the instructions below to generate an AsyncAPI definition based on the Streaming Backend server details using the Streaming Integrator Tooling:

1. Click **Async API View** to open the **Generating Async API for Sinks and Sources** dialog box in the Streaming Integrator Tooling Console.

     [![Design View]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)

2. Enter the Streaming API related information.

     Let's add the following Streaming API information to create a WebSocket API.
      
     | **Field**                                            | **Value**                             |
     |------------------------------------------------------|---------------------------------------|
     | **Title**                                            | `SweetProductionApp`                  |
     | **Version**                                          | `1.0.0`                               |
     | **Description**                                      | `Consumes events of sweet production` |
     | **Select Source or Sink type to Generate Async API** | Select **websocket-server**           |
     | **Sources**                                          | Select **SweetProductionStream**      |
      
     Here, you are enabling the API that you generate to consume events asynchronously from the `SweetProductionStream` stream that is connected to the **websocket-server** source.
    
3. Click **Generate Async API** to generate the AsyncAPI definition. 

     The AsyncAPI definition generated is shown in the AsyncAPI view.

4. Click **Code View**. 

     The API definition appears as follows:

    ```
    @App:asyncAPI("""asyncapi: 2.0.0
    info:
      title: SweetProductionApp
      version: 1.0.0
      description: Consumes  events of sweet production
    servers:
      production:
        url: 'localhost:8025'
        protocol: ws
        security:
          - keystore.file: []
    channels:
      /:
        publish:
          message:
            $ref: '#/components/messages/SweetProductionStreamPayload'
    components:
      messages:
        SweetProductionStreamPayload:
          payload:
            type: object
            properties:
              name:
                $ref: '#/components/schemas/name'
              amount:
                $ref: '#/components/schemas/amount'
      schemas:
        name:
          type: string
        amount:
          type: number
      securitySchemes:
        keystore.file:
          type: X509
    """)
    ```
   
## Step 4 - Publish the AsyncAPI definition 

You need to deploy your Streaming backend, which contains the AsycAPI definition, to the Streaming Integrator server in order to export the AsyncAPI definition that you generated to the service catalog in WSO2 API Manager.

Follow the instructions below to publish the AsyncAPI definition in the service catalog:

Let's deploy the `AsyncAPIDef` Siddhi application, which is the Streaming backend, into the Streaming Integrator server as follows:

1. Click **Deploy**, and then click **Deploy to Server** in Streaming Integrator Tooling. 

     This opens the **Deploy Siddhi Apps to Server** dialog box. 

2. Select the relevant check box for your Siddhi application, which contains the AsyncAPI definition, and for the server in which you want to deploy it. 

3. Click **Deploy**. 

     For detailed instructions, see [Deploying Siddhi Applications]({{base_path}}/develop/streaming-apps/deploying-streaming-applications).

     After the Siddhi application is successfully deployed, the following log messages appear in the Streaming Integrator and API Manager server logs to indicate that the API definition is successfully published in the Service Catalog.

    - Streaming Integrator server:

         ```
         Siddhi App AsyncAPIDef deployed successfully
         ```
      
         ```
         Async API: SweetProdApp-1.0.0 uploaded to the service catalogue
         ```

    - API Manager server:

         ```
         CommonUtil Creation of folder is successful. Directory Name : SweetProdApp-1.0.0`
         ```
  
## Step 5 - View the Streaming API

Follow the instructions below to view the Streaming API in the API Manager Service Catalog:

1. Sign in to the Publisher.

     `https://<hostname>:9448/publisher`
     
     For testing purposes, you can use `https://localhost:9448/publisher` and `admin` as the username and password.
     
2. Click **Service Catalog**.

     <a href="{{base_path}}/assets/img/streaming/working-with-async-api/access-service-catalog.png"><img src="{{base_path}}/assets/img/streaming/working-with-async-api/access-service-catalog.png" width="30%" alt="streaming menu"></a>

     The `SweetProdApp` WebSocket Streaming API appears Service Catalog.

     ![Service Catalogue Entry]({{base_path}}/assets/img/streaming/working-with-async-api/service-catalogue-entry.png)
   
## What's Next?

- [Learn more on the available Streaming APIs]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/streaming-api-overview.md). 

- [Learn how you can use a **third-party Streaming Provider** as opposed to WSO2 Streaming Integrator, which is used by default, to create a Streaming API]({{base_path}}/get-started/quick-start-guide/streaming-qsg).

# Creating and Publishing Asynchronous APIs

This guide explains how to generate an asynchronous API definition and then publish it as an API in the Service Catalogue of the API Manager. This involves enabling the Async API functionality in the Streaming Integrator component. As a result, when you deploy a Siddhi application with an Async API definition in the Streaming Integrator server, the Streaming Integrator exposes it as an API in the API Manager's service catalogue.

## Before you begin

1. Start the Streaming Integrator server.
2. Start the API Manager server.

## Step 1: Enable the Streaming Integrator to publish asynchronous APIs

To enable the Streaming Integrator to publish asynchronous APIs, follow thge steps below:

1. To configure the API Manager port to which the Streaming Integrator publishes the Async API definition, open the `<AM_HOME>/repository/conf/deployment.toml` file, uncomment `offset` in the `[server]` section and set it to `5` as shown below.

    ```
    [server]
    offset=5
    ```
   
2. To enable the Async API functionality, open the `<SI_HOME>/conf/server/deployment.yaml` file and update the `async.api.configs:` section as follows:

    ```
    async.api.configs:
        enabled: true
        hostname: localhost
        port: 9448
        username: admin
        password: admin
    ```
   
   Here, you are enabling the asynchronous API functionality by setting the `enabled` parameter to `true`. You are specifying `9448` as the port because you configured a port offset of 5 in the previous step (whereas the default port of the API Manager is `9443`).
   
## Step 2: Generate the Asynchronous API definition

To generate an Async API Spec for a Siddhi app in Streaming Integrator Tooling, you need to create a Siddhi application that has one or more sources of the `websocket-server`, `webhooks`, or `sse` type, and then generate an API definition for the selected source(s). To further understand this with an example, follow the steps below:

1. Start Streaming Integrator Tooling. For instructions, see [Streaming Integrator Tooling Overview - Starting Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview#starting-streaming-integration-studio).

2. Click **New** to open a new file, and add the following Siddhi application configuration to it.

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
   
    Save the file.
    
    This Siddhi application includes a source of the `websocket-server` type. You are generating an asynchronous API for this source.
    
3. Click **Async API View** to open the **Generating Async API for Sinks and Sources** dialog box. Then enter information in the dialog box as follows:

    ![Design View]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-form.png)
    
    | **Field**                                            | **Value**                             |
    |------------------------------------------------------|---------------------------------------|
    | **Title**                                            | `SweetProductionApp`                  |
    | **Version**                                          | `1.0.0`                               |
    | **Description**                                      | `Consumes events of sweet production` |
    | **Select Source or Sink type to Generate Async API** | Select **websocket-server**           |
    | **Sources**                                          | Select **SweetProductionStream**      |
    
    Here, you are enabling the API you generate to consume events asynchronously from the `SweetProductionStream` stream which is connected to the **websocket-server** source.
    
4. Click **Generate Async API**. The API definition generated is shown in the Async API view

5. Click **Code View**. The API definition appears as follows:

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
   
## Step 3: Publish the Asynchronous API definition 

To export an Async API definition that you generated to the service catalogue of the API Manager, the Siddhi application that contains it needs to be deployed in the Streaming Integrator server. Therefore, let's deploy the `AsyncAPIDef` Siddhi application you created into the Streaming Integrator server as follows:

1. In Streaming Integrator Tooling, click the **Deploy** menu item, and then click **Deploy to Server**. This opens the **Deploy Siddhi Apps to Server** dialog box. 

2. In the **Deploy Siddhi Apps to Server** dialog box, select the relevant check box for your Siddhi application (with the async API definition) and for the server in which you want to deploy it, and then click **Deploy**. For detailed instructions, see [Deploying Siddhi Applications]({{base_path}}/develop/streaming-apps/deploying-streaming-applications).

Once the Siddhi application is successfully deployed, the following appears in the Streaming Integrator and API Manager server logs to indicate that the API definition is successfully published in the Service Catalogue.

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
  
## Step 4: View the Async API in the API Manager Service Catalogue

Access the API Manager Publisher catalogue via the `https://localhost:9448/publisher/service-catalog`

The `SweetProdApp` API can be viewed in the Service Catalogue as shown below.

![Service Catalogue Entry]({{base_path}}/assets/img/streaming/working-with-async-api/service-catalogue-entry.png)
   
   
   
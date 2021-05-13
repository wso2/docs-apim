# Exposing a Stream as a Managed API

Managed APIs refer to the APIs that are managed using WSO2 API Manager, namely REST APIs, GraphQL APIs, SOAP APIs, and Streaming APIs. This guide explains how to create a Streaming backend for a [Streaming API]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/streaming-api-overview), generate an AsyncAPI definition for the corresponding Streaming API, and then publish the AsyncAPI definition in the WSO2 API Manager Service Catalog. 

This involves enabling the AsyncAPI functionality in the Streaming Integrator component. As a result, when you deploy a Siddhi application with an AsyncAPI definition in the Streaming Integrator server, the Streaming Integrator exposes it as an API in WSO2 API Manager's services.

## Step 1 - Enable publishing to the services

{!includes/streaming/enable-publishing.md!}
   
## Step 2 - Start Streaming Integrator and WSO2 API Manager

[Start the Streaming Integrator server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-si/#starting-the-si-server) and the [API Manager server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/) based on the instructions in the install and setup section.

## Step 3 - Create a Streaming Backend

The Streaming Integrator component in WSO2 API Manager is powered by [Siddhi](https://siddhi.io/). Therefore, you need to create a Siddhi application that has one or more sources, namely of the types `websocket-server`, `webhooks`, or `sse`, as the streaming backend.

[Create a Siddhi application]({{base_path}}/develop/streaming-apps/creating-a-siddhi-application/) with the following Siddhi application configurations.

```
@App:name('AsyncAPIDef')
@App:description('Receive events via WebSockettransport in XML format')

@source(type='websocket-server',host = "localhost",port = "8025",
  @map(type='xml'))
define stream SweetProductionStream (name string,amount double);

@sink(type='log')
define stream LowProductionAlertStream (name string,amount double);

@info(name='query1')
from SweetProductionStream 
select * 
insert  into LowProductionAlertStream;   
```

## Step 4 - Generate the AsyncAPI definition

Enter the following Streaming API related details to generate an AsyncAPI definition based on the Streaming Backend server details, and add the AsyncAPI definition to the Siddhi application. For more information, see [Generating and Viewing AsyncAPI Definitions]({{base_path}}/develop/streaming-apps/working-with-the-async-api-view).
      
| **Field**                                            | **Value**                             |
|------------------------------------------------------|---------------------------------------|
| **Title**                                            | `SweetProductionApp`                  |
| **Version**                                          | `1.0.0`                               |
| **Description**                                      | `Consumes events of sweet production` |
| **Select Source or Sink type to Generate Async API** | Select **websocket-server**           |
| **Sources**                                          | Select **SweetProductionStream**      |

The followinh is the AsyncAPI definition that gets generated.

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

## Step 5 - Publish the AsyncAPI definition 

You need to deploy your Streaming backend, which contains the AsycAPI definition, to the Streaming Integrator server in order to export the AsyncAPI definition that you generated to the services in WSO2 API Manager.

Follow the instructions below to publish the AsyncAPI definition to the service catalog:

Let's deploy the `AsyncAPIDef` Siddhi application, which is the Streaming backend, into the Streaming Integrator server as follows:

1. Click **Deploy**, and then click **Deploy to Server** in Streaming Integrator Tooling. 

     [![Deploy To Server]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-websocket-deploy-to-server.png)]({{base_path}}/assets/img/streaming/working-with-async-api/async-api-websocket-deploy-to-server.png)

     This opens the **Deploy Siddhi Apps to Server** dialog box. 

2. Select the relevant check box for your Siddhi application, which contains the AsyncAPI definition, and for the server in which you want to deploy it. 

3. Click **Deploy**. 

     For detailed instructions, see [Deploying Siddhi Applications]({{base_path}}/develop/streaming-apps/deploying-streaming-applications).

     After the Siddhi application is successfully deployed, the following log messages appear in the Streaming Integrator and API Manager server logs to indicate that the AsyncAPI definition is successfully published in the Service Catalog.

    ```bash tab="Streaming Integrator server logs"
    Siddhi App AsyncAPIDef deployed successfully
    Async API: SweetProdApp-1.0.0 uploaded to the service catalogue
    ```

    ```bash tab="API Manager server logs"
    CommonUtil Creation of folder is successful. Directory Name : SweetProdApp-1.0.0`
    ```
  
## Step 6 - View the service catalog entry in WSO2 API-M

Follow the instructions below to view the service catalog entry in WSO2 API Manager:

1. Sign in to the Publisher.

     `https://<hostname>:9448/publisher`
     
     For testing purposes, you can use `https://localhost:9448/publisher` and `admin` as the username and password.

     [![Open Service Catalog]({{base_path}}/assets/img/integrate/tutorials/service-catalog/open-service-catalog.png)]({{base_path}}/assets/img/integrate/tutorials/service-catalog/open-service-catalog.png)
     
2. Click the hamburger icon and then click **Services**.

     The services, which includes the `SweetProdApp` service, appears.

3. Click on the respective service (`SweetProdApp`) to view details of the managed service.
   
## What's Next?

- [Learn more on the available Streaming APIs]({{base_path}}/use-cases/streaming-usecase/create-streaming-api/streaming-api-overview). 

- [Learn how you can use a **third-party Streaming Provider** together with the Streaming Integrator in WSO2 API-M to create a Streaming API]({{base_path}}/get-started/quick-start-guide/streaming-qsg).

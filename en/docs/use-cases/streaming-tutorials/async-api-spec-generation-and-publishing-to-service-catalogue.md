# Async API Specification Generation and publishing into WSO2 API Manager Service Catalogue

## Introduction

When the Siddhi application contains sources or sinks of the type Websocket, Webhooks, and SSE, those can be exposed as APIs in the API Manager.

This tutorial demonstrates how to use the WSO2 SI Tooling to Generate an Async API specification and export the specification into the service catalogue during the Siddhi app deployment in the WSO2 SI. 

## Before you begin
    1. Uncomment `offset` and set to `5` in the wso2am-4.0.0 in wso2am-4.0.0/repository/conf/deployment.toml in the `[server]` section.<br/>
    2. Enable `async.api.configs` in wso2si-4.0.0/conf/server/deployment.yaml and set `port` as `9448`
    3. Unzip WSO2 SI, WSO2 Tooling and WSO2 API Manager servers and start

## Step 1: Create a Siddhi application

In this example, you are generating an Async API for the websocket-server source.

    ```
    @source(type='websocket-server',host = "localhost",port = "8025",keystore.path = "/user/ramindu/wso2carbon.jks",
        @map(type='xml'))
    define stream SweetProductionStream (name string,amount double);
    ```

Navigate to http://localhost:9390/editor and create a new Siddhi application and copy-paste following application to it and save.    

    ```
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
    ```
    
## Step 2: Generating Async API

Async APIs can be generated for the sinks and sources types of WebSockets, SSE and WebHooks.
In the Siddhi app, clicking on the Async API View button will navigate you to the Async API generation form
![AsyncAPISiddhiApp]({{base_path}}/assets/img/streaming/async-api/async-api-siddhi-app.png)

Enter the following information and click on `Generate Async API`
![AsyncAPIGeneration]({{base_path}}/assets/img/streaming/async-api/async-api-form.png)

When clicking on `Add Async API`, the siddhi app will get populated with the async api definition.
![AsyncAPISpec]({{base_path}}/assets/img/streaming/async-api/async-api-spec-view.png)

By clicking on the `Code View`, it will navigate back to the updated source code with the async API definition.
![AsyncAPISpec]({{base_path}}/assets/img/streaming/async-api/async-api-in-siddhi.png)

## Step 3:  Exporting Siddhi App to SI Server

In order to export the Async API definition to te service catalogue of the WSO2 API Manager, the Siddhi app should get deployed in the WSO2 SI server.
The tooling distribution has an `Deploy Siddhi apps to server` option to deploy the siddhi apps directly to the WSO2 SI, using its Siddhi app API.
![ToDeployToServer]({{base_path}}/assets/img/streaming/async-api/async-api-deploy-to-server.png)

After selecting the Siddhi apps and by adding the relevant WSO2 SI server information, Click on `Deploy`
![DeployToServer]({{base_path}}/assets/img/streaming/async-api/async-api-deploy.png)

## Step 4:  Exporting Async API spec to service catalogue in WSO2 API Manager from SI Server

When the Siddhi app gets deployed in the WSO2 SI server, the Async API definition will be exported to the service catalogue.
It can be confirmed using the following logs in the WSO2 SI server.
`
Siddhi App AsyncAPIDef deployed successfully
Async API: SweetProdApp-1.0.0 uploaded to the service catalogue
`
The following log can be seen in the API Manager
`CommonUtil Creation of folder is successful. Directory Name : SweetProdApp-1.0.0`

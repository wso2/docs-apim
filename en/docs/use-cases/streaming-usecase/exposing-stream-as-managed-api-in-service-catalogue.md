# Async API Specification publishing into WSO2 API Manager Service Catalogue

## Introduction

This section provides an overview on how to export the Async API specification into the service catalogue during the Siddhi app deployment in the WSO2 SI.

When the Siddhi application contains `@App:asyncAPI`, this specification will be exposed as APIs in the API Manager's service catalogue.

## Before you begin

Note: Please follow the steps in [Working with Async API View in Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/working-with-the-async-api-view) before you 
continue on the following steps unless, the Siddhi application has a valid Async API definition.

    1. Unzip API Manager server and in the <AM_HOME>/repository/conf/deployment.toml file, uncomment offset in the [server] section and set it to `5'.<br/>
          [server]
          offset=5
    2. Unzip Streaming Integrator and enable `async.api.configs` in <SI_HOME>/conf/server/deployment.yaml and set `port` as `9448`
          async.api.configs:
            enabled: true
            hostname: localhost
            port: 9448
            username: admin
            password: admin
    3. Start the Streaming Integrator, Streaming Integrator Tooling, and API Manager servers.

## Exporting Async API spec to service catalogue in WSO2 API Manager from SI Server

When the Siddhi app gets deployed in the WSO2 SI server, the Async API definition will be exported to the service catalogue.
It can be confirmed using the following logs in the WSO2 SI server.
`
Siddhi App AsyncAPIDef deployed successfully
Async API: SweetProdApp-1.0.0 uploaded to the service catalogue
`
The following log can be seen in the API Manager
`CommonUtil Creation of folder is successful. Directory Name : SweetProdApp-1.0.0`

## View the Async API in the API Manager Service Catalogue

Access the Api Manager Publisher's catalogue via the `https://localhost:9448/publisher/service-catalog`

The `SweetProdApp` will be shown in the service catalogue as follows.
![Service Catalogue Entry]({{base_path}}/assets/img/streaming/working-with-async-api/service-catalogue-entry.png)

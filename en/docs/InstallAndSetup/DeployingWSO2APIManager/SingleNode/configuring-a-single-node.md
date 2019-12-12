# Configuring a Single Node

This page walks you through how to manually configure and deploy WSO2 API Manager in a standalone single instance, without using a distributed or HA deployment patterns. For an overview of Single Node and Active-Active deployments, please see \_Deploying API Manager using Single Node Instances .

The page: **\_Deploying API Manager using Single Node Instances** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

Follow the instructions below to configure and deploy API-M using a single node:

-   [Step 1 - Create a SSL certificate](#ConfiguringaSingleNode-Step1-CreateaSSLcertificate)
-   [Step 2 - Configure the load balancer](#ConfiguringaSingleNode-Step2-Configuretheloadbalancer)
-   [Step 3 - Configure the databases](#ConfiguringaSingleNode-Step3-Configurethedatabases)
-   [Step 4 - Configure hostnames that are used to expose APIs](#ConfiguringaSingleNode-Step4-ConfigurehostnamesthatareusedtoexposeAPIs)
-   [Step 5 - Configure your deployment with production hardening](#ConfiguringaSingleNode-Step5-Configureyourdeploymentwithproductionhardening)
-   [Step 6 - Configure API-M Analytics](#ConfiguringaSingleNode-Step6-ConfigureAPI-MAnalytics)
-   [Step 7 - Start the WSO2 API-M server](#ConfiguringaSingleNode-Step7-StarttheWSO2API-Mserver)

### Step 1 - Create a SSL certificate

!!! note
This step is optional based on the setup that you configure. All WSO2 products are by default shipped with a keystore file and truststore file (stored in the `<PRODUCT_HOME>/repository/resources/security/` directory). The default keystore that is shipped with a WSO2 product ( `wso2carbon.jks)` is by default configured for all of the following purposes.

-   Authenticating the communication over Secure Sockets Layer (SSL)/Transport Layer Security (TLS) protocols.
-   Encrypting sensitive data such as plain-text passwords found in both product-level and product feature-level configurations/configuration files using [secure vault](https://docs.wso2.com/display/ADMIN44x/Carbon+Secure+Vault+Implementation) .

-   Encrypting and signing SOAP messages using WS-Security.

However, in a production environment, it is advised to set up several different keystores with separate trust chains for the above use cases. For more information, see [Recommendations for setting up keystores in WSO2 products](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption#UsingAsymmetricEncryption-recommendations) in the Administration Guide.


Create a SSL certificate on the WSO2 API Manager node. For more information, see [Creating SSL Certificates](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) in the Administration Guide.

### Step 2 - Configure the load balancer

For information on configuring the load balancer see \_Configuring the Proxy Server and the Load Balancer .

### Step 3 - Configure the databases

For information on configuring the databases, see \_Installing and Configuring the Databases .

### Step 4 - Configure hostnames that are used to expose APIs

!!! note
    This step is only required if you are using a hostname to expose APIs.


??? info "Click here for more information."
    Add this hostname when you configure environments in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the endpoints with your chosen hostname as shown below. In this case we are using `localhost` as the hostname:

    ``` java
        [[apim.gateway.environment]]
        name = "Production and Sandbox"
        type = "hybrid"
        display_in_api_console = true
        description = "This is a hybrid gateway that handles both production and sandbox token traffic."
        show_as_token_endpoint_url = true
        service_url = "https://localhost:${mgt.transport.https.port}/services/"
        username= "${admin.username}"
        password= "${admin.password}"
        ws_endpoint = "ws://localhost:9099"
        wss_endpoint = "wss://localhost:8099"
        http_endpoint = "http://localhost:${http.nio.port}"
        https_endpoint = "https://localhost:${https.nio.port}"
    ```

### Step 5 - Configure your deployment with production hardening

Ensure that you have taken into account the respective security hardening factors (e.g., changing and encrypting the default passwords, configuring JVM security etc.) before deploying WSO2 API-M. For more information, see the [Production Deployment Guidelines](https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines#ProductionDeploymentGuidelines-Commonguidelinesandchecklist) in the Administration Guide.

### Step 6 - Configure API-M Analytics

If you wish to view reports, statistics, and graphs related to the APIs deployed in the Store, you need to configure API-M Analytics. Follow the [standard setup](https://docs.wso2.com/display/AM260/Configuring+APIM+Analytics#StandardSetup) to configure API-M Analytics in a production setup, and follow the [quick setup](https://docs.wso2.com/display/AM260/Configuring+APIM+Analytics#Quick-Setup) to configure API-M Analytics in a development setup.

### Step 7 - Start the WSO2 API-M server

!!! note
Before you start the server

If you want to deploy WSO2 API-M using a hybrid single node deployment, where WSO2 Identity Server is used as the Key Manager while the rest of the WSO2 API-M components are all in one node, configure and start the Key Manager (e.g., configure and start WSO2 Identity Server as the Key Manager ) before starting the API-M server.


Start the server using the following standard start-up script. For more information, see [Starting the server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) .

-   [**Linux/Mac OS**](#Linux-Mac)
-   [**Windows**](#windows)

``` java
    cd <API-M_HOME>/bin/
    sh wso2server.sh
```

``` java
    cd <API-M_HOME>\bin\
    wso2server.bat --run
```

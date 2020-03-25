# Configuring a Single Node

This page walks you through how to manually configure and deploy WSO2 API Manager in a single standalone instance, without using a distributed or HA deployment patterns. 

[![Single node deployment]({{base_path}}/assets/img/setup-and-install/single-node-deployment.png)]({{base_path}}/assets/img/setup-and-install/single-node-deployment.png)

Follow the instructions below to configure and deploy API-M using a single node:

-   [Step 1 - Create a SSL Certificate](#step-1-create-a-ssl-certificate)
-   [Step 2 - Configure the Load Balancer](#step-2-configure-the-load-balancer)
-   [Step 3 - Configure the Databases](#step-3-configure-the-databases)
-   [Step 4 - Configure URLs that are used to expose APIs](#step-4-configure-urls-that-are-used-to-expose-apis)
-   [Step 5 - Configure API-M Analytics](#step-5-configure-api-m-analytics)
-   [Step 6 - Configure Production Hardening](#step-6-configure-production-hardening)
-   [Step 7 - Start the WSO2 API-M server](#step-7-start-the-wso2-api-m-server)

----------------------------

## Step 1 - Create a SSL Certificate

!!! note
    This step is **optional** based on the setup that you configure. If you are trying out in a **development setup**, 
    you may **skip this step**, as all WSO2 products are by default shipped with a 
    keystore file and truststore file stored in the `<PRODUCT_HOME>/repository/resources/security/ directory`. 

The default keystore that is shipped with a WSO2 product, `wso2carbon.jks` is configured with
private key and self signed public key pair for all purposes, such as encrypting sensitive information, communicating over SSL etc. 
   
However, in a **production setup**, it is advised to set up several different keystores with separate trust chains for the above use cases. For more information, see [Recommendations for setting up keystores in WSO2 products]({{base_path}}/administer/product-security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#recommendations-for-setting-up-keystores).

To create an all purpose keystore or multiple keystores for authentication and protection of data, follow the steps in [Creating New Keystores]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/creating-new-keystores/).

## Step 2 - Configure the Load Balancer

Follow the steps in [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-the-proxy-server-and-the-load-balancer) to configure the load balancer/reverse proxy which is fronting the API-M instance in the demiliterized zone (DMZ).

## Step 3 - Configure the Databases

WSO2 API-M is shipped with H2 databases by default. However, in a **production setup**, it is recommended to use an industry-standard RDBMS databases. For more information on default databases and changing them into RDBMS databases, see [Working with Databases]({{base_path}}/install-and-setup/setting-up-databases/overview/).

## Step 4 - Configure URLs that are used to expose APIs

Add this hostname when you configure environments in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the endpoints with your chosen hostname as shown below. 
In this case, let's use `gw.wso2.com` as the hostname:
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
    ws_endpoint = "ws://gw.wso2.com:9099"
    wss_endpoint = "wss://gw.wso2.com:8099"
    http_endpoint = "http://gw.wso2.com:${http.nio.port}"
    https_endpoint = "https://gw.wso2.com:${https.nio.port}"
    ```    
## Step 5 - Configure API-M Analytics

If you wish to view reports, statistics, and graphs related to the APIs deployed in the WSO2 API Manager, you need to 
configure API-M Analytics. If not, you can **skip this step**.

Follow the [Configuring API-M Anlaytics - Quick Setup]({{base_path}}/learn/analytics/configuring-apim-analytics/#quick-setup) to configure API-M Analytics in a development setup and, follow 
[Configuring API-M Analytics - Standard Setup]({{base_path}}/learn/analytics/configuring-apim-analytics/#standard-setup) 
to configure API-M Analytics in a production setup.

## Step 6 - Configure Production Hardening

In a **production setup**, ensure that you have taken into account the respective security hardening factors (e.g., changing and encrypting the default passwords, configuring JVM security etc.) before deploying WSO2 API-M. For more information, see 
[Security Guidelines for Production Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/security-guidelines-for-production-deployment/).
  
## Step 7 - Start the WSO2 API-M server

If you want to deploy WSO2 API-M using a hybrid single node deployment, where WSO2 Identity Server is used as the Key Manager while the rest of the WSO2 API-M components are all in one node, configure and start the Key Manager (e.g., configure and start WSO2 Identity Server as the Key Manager) before starting the WSO2 API-M server.


Start the WSO2 API-M servers using the standard start-up script. For more information, see [Starting the server](https://apim.docs.wso2.com/en/latest/install-and-setup/installation-guide/running-the-product/#starting-the-server).

```tab="Linux/Mac OS"
cd <API-M_HOME>/bin/
sh wso2server.sh
```

```tab="Windows"
cd <API-M_HOME>\bin\
wso2server.bat --run 
```

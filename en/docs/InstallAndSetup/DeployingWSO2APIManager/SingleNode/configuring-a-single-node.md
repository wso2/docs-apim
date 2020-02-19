# Configuring a Single Node

This page walks you through how to manually configure and deploy WSO2 API Manager in a standalone single instance, without using a distributed or HA deployment patterns. 

[![Single node deployment]({{base_path}}/assets/img/setup-and-install/single-node-deployment.png)]({{base_path}}/assets/img/setup-and-install/single-node-deployment.png)

Follow the instructions below to configure and deploy API-M using a single node:

-   [Step 1 - Create a SSL certificate]({{base_path}}/Administer/ProductSecurity/ConfiguringKeystores/KeystoreBasics/creating-new-keystores)
-   [Step 2 - Configure the load balancer]({{base_path}}/InstallAndSetup/DeployingWSO2APIManager/configuring-the-proxy-server-and-the-load-balancer)
-   [Step 3 - Configure the databases]({{base_path}}/InstallAndSetup/SettingUpDatabases/overview)
-   [Step 4 - Configure your deployment with production hardening]({{base_path}}/InstallAndSetup/DeployingWSO2APIManager/production-deployment-guidelines)
-   [Step 5 - Configure API-M Analytics - Optional]({{base_path}}/Learn/Analytics/configuring-apim-analytics/)
-   [Step 6 - Configure URLs that are used to expose APIs](#configure-urls-that-are-used-to-expose-apis)
-   [Step 7 - Start the WSO2 API-M server](#start-the-wso2-api-m-server)

----------------------------

## Configure URLs that are used to expose APIs

Add this hostname when you configure environments in the `<API-M_HOME>/repository/conf/deployment.toml` file. Update the endpoints with your chosen hostname as shown below. 
In this case let's use `gw.wso2.com` as the hostname:
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
    
### Start the WSO2 API-M server

If you want to deploy WSO2 API-M using a hybrid single node deployment, where WSO2 Identity Server is used as the Key Manager while the rest of the WSO2 API-M components are all in one node, configure and start the Key Manager (e.g., configure and start WSO2 Identity Server as the Key Manager) before starting the WSO2 API-M server.


Start the WSO2 API-M servers using the standard start-up script. For more information, see [Starting the server](https://apim.docs.wso2.com/en/latest/InstallAndSetup/InstallationGuide/running-the-product/#starting-the-server).

```tab="Linux/Mac OS"
cd <API-M_HOME>/bin/
sh wso2server.sh
```

```tab="Windows"
cd <API-M_HOME>\bin\
wso2server.bat --run 
```

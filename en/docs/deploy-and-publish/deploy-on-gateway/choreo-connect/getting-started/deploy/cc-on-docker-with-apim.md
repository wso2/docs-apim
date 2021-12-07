# Using Choreo Connect Deployed on Docker with WSO2 API Manager

Let's deploy an API via the WSO2 API Manager Publisher Portal on a Choreo Connect Docker deployment.

!!! info
    **Before you begin**

    - Make sure you have installed Docker and Docker Compose on your machine.

    - Download the latest [Choreo Connect release](https://github.com/wso2/product-microgateway/releases) and extract it to a folder of your choice. The extracted folder will be referred to as `CHOREO-CONNECT_HOME` here onwards.

    - This guide assumes that you have already started the WSO2 API Manager instance. If not, download the latest [release](https://github.com/wso2/product-apim/releases) and follow the steps [here](https://github.com/wso2/product-apim#installation--running).

## Step 1 - Find the APIM IP Address

In order to tell Choreo Connect where API Manager (APIM) is located, find out the IP that can be used to access the API Manager instance. If you are trying out WSO2 API Manager locally, the private IP retrieved using `hostname -I` or `ipconfig` would do.

## Step 2 - Update the Choreo Connect Configuration File

Open the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/config.toml` file in a text editor and update it as follows.

In the `[controlPlane]` section,

 - Set `enabled` to true
 - Update `serviceURL` and `brokerConnectionParameters` with the IP of API Manager. (Search for `apim` and replace them with the IP. Alternatively, add an entry to the `/etc/hosts` file as `<ip-of-apim> apim`)
 - If you want to use a Gateway Environment other than the default, update `environmentLabels` with the name of the new Gateway Environment. If not, leave the value `"Default"` as it is.

 Example
 ``` toml
 [controlPlane]
  enabled = true
  serviceURL = "https://<apim-ip>:9443/"
  username="admin"
  password="$env{cp_admin_pwd}"
  environmentLabels = ["Default"]
  retryInterval = 5
  skipSSLVerification=true

  [controlPlane.brokerConnectionParameters]
    eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@<apim-ip>:5672?retries='10'&connectdelay='30'"]
    reconnectInterval = 5000
    reconnectRetryCount = 60

  [controlPlane.httpClient] 
    requestTimeOut = 30
 ``` 

!!! tip

    In API Manager, a new Gateway Environment can be created from the Admin Portal (available at `https:<apim-host>:<apim-port>/admin`) **Gateways** tab.

## Step 3 - Start Choreo Connect

Now, let's start Choreo Connect. Navigate to `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect` and execute the following command.

``` bash
docker-compose up -d
```

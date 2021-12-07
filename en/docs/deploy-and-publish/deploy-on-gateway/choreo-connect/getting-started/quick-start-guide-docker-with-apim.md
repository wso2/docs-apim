# Quick Start Guide

This is a step-by-step guide on how to quickly deploy an API using WSO2 API Manager (WSO2 API-M) as the Control Plane and invoke it via Choreo Connect.

## Before you begin...

Install and set up [Docker](https://www.docker.com).

### Step 1 - Download and extract Choreo Connect distribution .zip file

The latest Choreo Connect distribution can be downloaded from the [GitHub repository](https://github.com/wso2/product-microgateway/releases). Extract the Choreo Connect distribution .zip file. The extracted folder will be referred to as `CHOREO-CONNECT_HOME` hereafter.

### Step 2 - Start Choreo Connect and API Manager

Add the host entry to `/etc/hosts` file as shown below in order to access the API Manager Publisher and Developer Portal.

``` java
127.0.0.1   apim
```

Start Choreo Connect and API Manager on Docker by executing the Docker Compose script inside the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect-with-apim` folder.

``` java
docker-compose up -d
```

Once the containers are up and running, you can monitor the status of the containers using the following command.

``` java
docker ps | grep choreo-connect-
```

!!! info
    Note that the Docker Compose script deploys WSO2 API Manager with basic configurations. In order to deploy WSO2 API Manager in production grade, use the Docker setup artifacts from [APIM page](https://wso2.com/api-management/). The Docker Compose scripts are provided only for the purpose of trying it out.

### Step 3 - Create and publish an API from API Manager

1. Navigate to the Publisher Portal.

    [https://apim:9443/publisher/](https://apim:9443/publisher/)

2. Sign in with **`admin/admin`** as the credentials.

    [![Publisher portal home page]({{base_path}}/assets/img/get_started/api-publisher-home.png)]({{base_path}}/assets/img/get_started/api-publisher-home.png)

3. Create an API.

     Let's use a mock REST service to create a REST API from scratch.
 
     A mock service with a JSON response `{"hello": "world"}` is provided by default when you use the service URL as `http://run.mocky.io/v2/5185415ba171ea3a00704eed`, which appears in the [https://designer.mocky.io/](https://designer.mocky.io/) mock service. Let's use the HTTP protocol instead of the HTTPS protocol for this guide.

    !!! tip
        Optionally, to test this service, copy the service URL [http://run.mocky.io/v2/5185415ba171ea3a00704eed](http://run.mocky.io/v2/5185415ba171ea3a00704eed) and navigate to it on a new browser. You should see the following JSON message.
            
         `{"hello": "world"}`

4. Select **REST API** from the home screen and then click **Start From Scratch**.
   
    [![Design a new REST API]({{base_path}}/assets/img/get_started/design-new-rest-api.png)]({{base_path}}/assets/img/get_started/design-new-rest-api.png)

5. Enter the API details.
     
     [![Create an API]({{base_path}}/assets/img/get_started/api-create.png){: style="width:60%"}]({{base_path}}/assets/img/get_started/api-create.png)

6. Click **Create & Publish**.

     This will publish your first API on the Developer Portal as well as deploy it on Choreo Connect. You now have an OAuth 2.0 secured REST API that is ready to be consumed.

### Step 4 - Subscribing to API and Get a Token

1. Navigate to the Developer Portal and and click an API (e.g., `HelloWorld`).

    [https://apim:9443/devportal/](https://apim:9443/devportal/)

2. Subscribe to the API (e.g., `HelloWorld` 1.0.0) using an application and an available throttling policy.

    [![Subscribe to an API]({{base_path}}/assets/img/deploy/mgw/subscribe-to-api.png)]({{base_path}}/assets/img/deploy/mgw/subscribe-to-api.png)

3. Click **Applications** and then click on the application that you used to subscribe to the API. Click **Production Keys** and click **Generate keys** to generate a production key.

    [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

!!! tip
    **Production and Sandbox Tokens**:
    To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

!!! tip
    **JWT tokens**:
    As the application is self-contained (JWT), **copy the generated access token** before proceeding to the next step.

### Step 5 - Invoke the API via Choreo Connect

Follow the instructions below to invoke the previously created API with the generated keys.

1. Click **Try Out** on the left menu bar.

     The resources of the API will be listed.

2. Paste the access token that you previously copied in the **Access Token** field.

    [![Paste the access token]({{base_path}}/assets/img/deploy/mgw/invoke-api.png)]({{base_path}}/assets/img/deploy/mgw/invoke-api.png)

3. **If this is the first time you are using the API test console** from your browser,  open a new tab and navigate to the [https://localhost:9095/](https://localhost:9095/) URL.

     This will prompt your browser to accept the certificate used by Choreo Connect. This is required because, by default, Choreo Connect uses a self-signed certificate that is not trusted by web browsers.
    
    !!! note

        This certificate that is used by Choreo Connect is replaced when deploying the system in production.

4. Click on the `GET` resource of the API to expand the resource and click **Try It Out**.
   
     [![GET resource]({{base_path}}/assets/img/deploy/mgw/expanded-get-resource.png)]({{base_path}}/assets/img/deploy/mgw/expanded-get-resource.png)

5. Click **Execute**.

     [![GET resource]({{base_path}}/assets/img/deploy/mgw/try-api.png)]({{base_path}}/assets/img/deploy/mgw/try-api.png)

     You should see the `{"hello" : "world"}` response from the API. 

     [![Successful response]({{base_path}}/assets/img/deploy/mgw/try-it-success.png)]({{base_path}}/assets/img/deploy/mgw/try-it-success.png)

__Congratulations!__ You have successfully created your first API, subscribed to it through an OAuth 2.0 application, obtained an access token for testing, and invoked your API with Choreo Connect.

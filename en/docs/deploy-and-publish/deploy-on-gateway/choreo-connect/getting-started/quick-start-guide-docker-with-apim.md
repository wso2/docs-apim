# Quick Start Guide

This is a step-by-step guide on how to quickly deploy an API using WSO2 API Manager (WSO2 API-M) as the Control Plane and invoke it via Choreo Connect.

## Before you begin...

Install and set up [Docker](https://www.docker.com).

### Step 1 - Download and extract Choreo Connect distribution .zip file

The latest Choreo Connect distribution can be downloaded from the [GitHub repository](https://github.com/wso2/product-microgateway/releases). Extract the Choreo Connect distribution .zip file. The extracted folder will be referred to as `CHOREO-CONNECT_HOME` hereafter.

### Step 2 - Configure Choreo Connect to connect to API Manager

Enable the `[controlPlane.eventHub]` in the `config.toml` file found in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect-with-apim/conf` directory. To enable the event hub, do the following configurations in the `config.toml` file as indicated below.

``` java
[controlPlane.eventHub]
  enabled = true
```

### Step 3 - Start Choreo Connect and API Manager

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

### Step 4 - Deploy a sample API in API Manager

1. First sign in to the API Manager Publisher Portal by accessing the URL: https://apim:9443/publisher/

2. Click on the REST API card and then click on the `Deploy Sample API` button. This will deploy the sample PizzaShack API.
    [![]({{base_path}}/assets/img/deploy/mgw/deploy-sample-api.png)]({{base_path}}/assets/img/deploy/mgw/deploy-sample-api.png)

3. Click on `Endpoints` from the left menu inside the PizzaShackAPI. Change the production endpoint and
sandbox endpoint URL to `http://apim:9763/am/sample/pizzashack/v1/api/`. Save the changes by clicking the **Save** button.
    [![]({{base_path}}/assets/img/deploy/mgw/endpoint-tab.png)]({{base_path}}/assets/img/deploy/mgw/endpoint-tab.png)
    [![]({{base_path}}/assets/img/deploy/mgw/endpoint-edit.png)]({{base_path}}/assets/img/deploy/mgw/endpoint-edit.png)

4. Follow the [documentation on deploying an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) to deploy 
the changes done to the API into Choreo Connect.

### Step 5 - Subscribing to an API and getting a token

1. Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`) and click an API (e.g., `PizzaShack`).

2. Subscribe to the API (e.g., `PizzaShack` 1.0.0) using an application and an available throttling policy.
    [![Subscribe to an API]({{base_path}}/assets/img/learn/subscribe-to-api.png)]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3. Click **Applications** and then click on the application that you used to subscribe to the API. Click **Production Keys** and click **Generate keys** to generate a production key.

    [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

!!! tip
    **Production and Sandbox Tokens**:
    To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

!!! tip
    **JWT tokens**:
    As the application is self-contained (JWT), **copy the generated access token** before proceeding to the next step.

### Step 6 - Invoke the API via Choreo Connect

Use the below curl command to invoke the `/menu` resource of the PizzaShackAPI

``` java
curl -k -X GET "https://localhost:9095/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer <COPIED_TOKEN>"
```

!!! info
    Note that the port 9095 in the above cURL command is the Choreo Connect port. Hence, it can be inferred that you are invoking the API
    via Choreo Connect.

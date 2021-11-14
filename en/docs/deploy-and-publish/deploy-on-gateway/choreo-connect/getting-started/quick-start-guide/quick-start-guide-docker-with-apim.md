# Quick Start Guide with API Manager - Docker

Lets' deploy an API from API Manager (control plane) and invoke via the Choreo Connect.

## Before you begin...

Make sure to install and set up [Docker](https://www.docker.com).

### Step 1 - Download and setup Choreo Connect distribution zip

Latest Choreo Connect distribution can be downloaded from the [page](https://github.com/wso2/product-microgateway/releases). Extract the Choreo Connect distribution zip. Extracted folder will be called as `CHOREO-CONNECT_HOME` hereafter.

### Step 2 - Configure Choreo Connect to Connect to API Manager

We have to enable the `[controlPlane.eventHub]` in the `config.toml` file in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect-with-apim/conf` directory.
Let's edit the `config.toml` like below to enable the event hub.

``` java
[controlPlane.eventHub]
  enabled = true
```

### Step 3 - Start Choreo Connect and API Manager

First we need to add the host entry to `/etc/hosts` file in order to access the API Manager publisher and Developer Portal.
Add the following entry to `/etc/hosts` file

``` java
127.0.0.1   apim
```

Start the Choreo Connect and API Manager on docker by executing the docker compose script inside the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect-with-apim` folder.

``` java
docker-compose up -d
```

Once containers are up and running, we can monitor the status of the containers using the following command

``` java
docker ps | grep choreo-connect-
```

!!! info
    Note that the docker-compose deploys the API Manager with basic configurations. In order to deploy API Manager in a production grade Docker, setup artifacts from the [API Manager page](https://wso2.com/api-management/). The docker-compose scripts are provided for the purpose of trying it out only.

### Step 4 - Deploy Sample API from API Manager

1. First log in to the API Manager Publisher Portal by accessing the URL: https://apim:9443/publisher/.

2. Click on the REST API card and then click on the `Deploy Sample API` button. This will deploy the sample PizzaShack API.

    [![]({{base_path}}/assets/img/deploy/mgw/deploy-sample-api.png)]({{base_path}}/assets/img/deploy/mgw/deploy-sample-api.png)

3. Then click on the `Endpoints` from the left-hand side menu inside the PizzaShackAPI. Change the production endpoint and
sandbox endpoint URL as `http://apim:9763/am/sample/pizzashack/v1/api/`. Then save the changes by clicking save button.

    [![]({{base_path}}/assets/img/deploy/mgw/endpoint-tab.png)]({{base_path}}/assets/img/deploy/mgw/endpoint-tab.png)

    [![]({{base_path}}/assets/img/deploy/mgw/endpoint-edit.png)]({{base_path}}/assets/img/deploy/mgw/endpoint-edit.png)

4. Follow the [deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) guide to deploy 
the changes done to the API in to the Choreo Connect.

### Step 5 - Subscribing to API and Get a Token

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
    Note that the port 9095 in the above curl command is the Choreo Connect port. Hence, it can be inferred that you are invoking the API
    via Choreo Connect.

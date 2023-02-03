# Quick Start Guide

This is a step-by-step guide on how to quickly deploy an API using WSO2 API Manager (WSO2 API-M) as the Control Plane and invoke it via Choreo Connect.

## Before you begin...

Install and set up [Docker](https://www.docker.com) and allocate the following resources for Docker.

  - Minimum CPU : 4vCPU
  - Minimum Memory : 4GB

!!! important

    **Production Deployments - Choreo Connect**

    The Docker Compose based deployment option explained here is ***only for tryout purposes.*** This method is ***not recommended for production deployments***. For production deployments, you can use the following.

    - Kubernetes based Choreo Connect deployment with [Helm artifacts]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-kubernetes-with-apim-as-control-plane-helm-artifacts/) or [YAML artifacts]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-kubernetes-with-apim-as-control-plane/)
    - [Production Deployment Guideline]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/production-deployment-guideline/) for Choreo Connect 

    **Production Deployments - API Manager**

    The Docker Compose files referred in this guide are to deploy API Manager with ***basic configurations***. They are the docker-compose scripts ***provided with the Choreo Connect distribution*** and are only meant for tryout purposes. In order to deploy WSO2 API Manager in production grade, you can use the following. 

    - Docker setup artifacts from the [API Manager page](https://wso2.com/api-management/)
    - [Production Deployment Guideline]({{base_path}}/install-and-setup/setup/deployment-best-practices/production-deployment-guidelines/#common-guidelines-and-checklist) for API Manager

### Step 1 - Download and extract Choreo Connect distribution .zip file

The latest Choreo Connect distribution can be downloaded from [https://wso2.com/choreo/choreo-connect/](https://wso2.com/choreo/choreo-connect/). Extract the Choreo Connect distribution .zip file. The extracted folder will be referred to as `CHOREO-CONNECT_HOME` hereafter.

### Step 2 - Start Choreo Connect and API Manager

Add the host entry to `/etc/hosts` file as shown below in order to access the API Manager Publisher and Developer Portal.

``` java
127.0.0.1   apim
```

Start Choreo Connect and API Manager on Docker Compose by executing the Docker Compose script inside the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect-with-apim` folder.

``` java
docker-compose up -d
```

Once the containers are up and running, you can monitor the status of the containers using the following command.

``` java
docker ps | grep choreo-connect-
```

{!includes/deploy/cc-tryout-in-arm64-docker-note.md!}

### Step 3 - Create and publish an API via API Manager

1. Navigate to the Publisher Portal.

    [https://apim:9443/publisher/](https://apim:9443/publisher/)

2. Sign in with **`admin/admin`** as the credentials.

    [![Publisher portal home page]({{base_path}}/assets/img/get_started/api-publisher-home.png)]({{base_path}}/assets/img/get_started/api-publisher-home.png)

3. Select **REST API** from the home screen and then click **Start From Scratch**.
   
    [![Design a new REST API]({{base_path}}/assets/img/get_started/design-new-rest-api.png)]({{base_path}}/assets/img/get_started/design-new-rest-api.png)

4. Enter the following API details.

    | **Field**    | **Value**                        |
    |----------|-------------------------------------|
    | Name     | HelloWorld                     |
    | Context  | /hello                                 |
    | Version  | 1.0.6                               |
    | Endpoint | https://run.mocky.io/v2/5185415ba171ea3a00704eed |

    !!! note
        We are using a mock service from [https://designer.mocky.io/](https://designer.mocky.io/) as the endpoint to test the API. The above endpoint returns the json payload `{"hello": "world"}`.
     
    [![Create an API]({{base_path}}/assets/img/get_started/api-create.png){: style="width:60%"}]({{base_path}}/assets/img/get_started/api-create.png)

6. Click **Create & Publish**.

    This will publish your first API on the Developer Portal as well as deploy it on Choreo Connect. You now have an OAuth 2.0 secured REST API that is ready to be consumed.

    !!! tip   
        If you are further updating the API, remember to create a new revision using the **Deployments** tab and deploy the newly created revision to the Gateway, for the changes to be reflected in Choreo Connect.

### Step 4 - Invoke the API from Publisher

1. Open **Try Out** from the left menu bar.

<a href="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-leftpane.png"><img src="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-leftpane.png" width="20%" alt="Try out menu option in the left panel"></a>

2. In the Try Out page, you will find an Internal Key that has already been generated for you. You can click the button **Generate Key** whenever you need a new token.

    <a href="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-generatekey.png"><img src="{{base_path}}/assets/img/design/create-api/test-api/publisher-testconsole-generatekey.png" width="80%" alt="Generate key"></a>

    !!! tip

        When invoking the API, this [Internal Key]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/internal-key-authentication/) authentication token will be included in the header `Internal-Key`. 

3. Select one of the listed HTTP methods. Click **Try it out** and then click **Execute** to invoke the API.

    <a href="{{base_path}}/assets/img/deploy/mgw/expanded-get-resource.png"><img src="{{base_path}}/assets/img/deploy/mgw/expanded-get-resource.png" width="80%" alt="Try it out"></a>

    <a href="{{base_path}}/assets/img/deploy/mgw/try-api.png"><img src="{{base_path}}/assets/img/deploy/mgw/try-api.png" width="80%" alt="Execute"></a>

**That's it!** You have successfully invoked an API deployed in Choreo Connect.

You can follow the next few steps to get an idea about API Subscriptions, Application Rate limiting and Production Access Tokens.

### Step 5 - Subscribe to the API and generate a token

1. Navigate to the Developer Portal and select the newly created API.

    [https://apim:9443/devportal/](https://apim:9443/devportal/)

2. Navigate to the **Subscriptions** page. 

3. Subscribe the API to the default application visible as **DefaultApplication** with an available Rate Limiting Policy.

    [![Subscribe to an API]({{base_path}}/assets/img/deploy/mgw/subscribe-to-api.png)]({{base_path}}/assets/img/deploy/mgw/subscribe-to-api.png)

4. Navigate to the **Applications** tab. 

5. Click on **DefaultApplication**, navigate to **Production Keys** page and click **Generate keys** to generate a production key.

    [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

    !!! tip
    
        To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

6. Copy the generated access token before proceeding to the next step.

### Step 6 - Invoke the API via Choreo Connect

Follow the instructions below to invoke the previously created API with the generated token.

1. Click **Try Out** on the left menu bar.

     The resources of the API will be listed.

2. Paste the access token that you previously copied in the **Access Token** field.

    [![Paste the access token]({{base_path}}/assets/img/deploy/mgw/invoke-api.png)]({{base_path}}/assets/img/deploy/mgw/invoke-api.png)

3. **If this is the first time you are using the API test console** from your browser, open a new tab and navigate to the [https://localhost:9095/](https://localhost:9095/) URL.

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

## See also

- [Choreo Connect Overview]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview/)
- [Supported Features]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/supported-features/)
- [Deployment Options]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-deploy-overview/)
- [Production Deployment Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/production-deployment-guideline/)

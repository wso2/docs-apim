# Quick Start Guide with API Manager - Kubernetes

Let's host your first API on Choreo Connect using Kubernetes.

## Before you begin

1.  Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
2.  Set up a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.14 or above.
      - Minimum CPU : 2vCPU
      - Minimum Memory : 2GB
3.  Deploy an ingress controller - [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) for this sample.

## Objectives

1.  Create and deploy an API project.
2.  Invoke the API using a generated key.

Let's get started...

## Step 1 - Setup Choreo Connect in Kubernetes

1.  Download and extract Choreo Connect distribution .zip file

    Latest Choreo Connect distribution can be downloaded from the [GitHub repository](https://github.com/wso2/product-microgateway/releases). Extract the Choreo Connect distribution .zip file. The extracted folder will be called as `CHOREO-CONNECT_HOME` hereafter.

2.  Add the Kubernetes configurations for Choreo Connect and API Manager using the kubectl tool.

    ```bash
    kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/apim
    ```
    
    Apply Kubernetes configurations for Choreo Connect after successfully started the API Manager instance.
    ```bash
    kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/choreo-connect
    ```
    
3.  Add the host entry to the `/etc/hosts` file. 
    
    Add the following entry to `/etc/hosts` file in order to access the Choreo Connect Router, API Manager publisher and Developer Portal.

    ```sh
    <ingress_address>    gw.wso2.com    apim.wso2.com
    ```

## Step 2 - Deploy Sample API from API Manager

1. First log in to the API Manager Publisher Portal by accessing the URL: [https://apim.wso2.com/publisher/](https://apim.wso2.com/publisher/).

2. Click on the REST API card and then click on the `Deploy Sample API` button. This will deploy the sample PizzaShack API.
   [![]({{base_path}}/assets/img/deploy/mgw/deploy-sample-api.png)]({{base_path}}/assets/img/deploy/mgw/deploy-sample-api.png)

3. Then click on the `Endpoints` from the left-hand side menu inside the PizzaShackAPI. Change the production endpoint and
   sandbox endpoint URL as `http://wso2apim:9763/am/sample/pizzashack/v1/api/`. Then save the changes by clicking save button.
   Here `wso2apim` is the kubernetes service name of the API-M instance.
   [![]({{base_path}}/assets/img/deploy/mgw/endpoint-tab.png)]({{base_path}}/assets/img/deploy/mgw/endpoint-tab.png)
   [![]({{base_path}}/assets/img/deploy/mgw/endpoint-edit-k8s.png)]({{base_path}}/assets/img/deploy/mgw/endpoint-edit-k8s.png)

5. Follow the [deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) guide to deploy
   the changes done to the API in to the Choreo Connect.

## Step 3 - Subscribing to API and Get a Token

1. Sign in to the WSO2 Developer Portal [https://apim.wso2.com/devportal/](https://apim.wso2.com/devportal) and click `PizzaShack` API.

2. Subscribe to the API using an application and an available throttling policy.
   [![Subscribe to an API]({{base_path}}/assets/img/learn/subscribe-to-api.png)]({{base_path}}/assets/img/learn/subscribe-to-api.png)

3. Click **Applications** and then click on the application that you used to subscribe to the API. Click **Production Keys** and click **Generate keys** to generate a production key.
   [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

!!! tip
    **Production and Sandbox Tokens**:
    To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

!!! tip
    **JWT tokens**:
    As the application is self-contained (JWT), **copy the generated access token** before proceeding to the next step.

## Step 4 - Invoke the API via Choreo Connect

Use the below curl command to invoke the `/menu` resource of the PizzaShackAPI

``` shell
curl -k -X GET "https://gw.wso2.com/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer <COPIED_TOKEN>"
```

!!! info
    Note that the ingress host `gw.wso2.com` in the above curl command is the host of Choreo Connect. Hence, it can be inferred that you are invoking the API
    via Choreo Connect.

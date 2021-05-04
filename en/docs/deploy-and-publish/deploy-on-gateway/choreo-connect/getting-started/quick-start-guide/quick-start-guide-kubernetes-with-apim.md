# Quick Start Guide with API Manager - Kubernetes

Let's host your first API on Choreo Connect using Kubernetes.

## Before you begin

1.  Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
2.  Setup a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.14 or above.
      - Minimum CPU : 2vCPU
      - Minimum Memory : 2GB
3.  Deploy an ingress controller - [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) for this sample.

## Objectives

1.  Setup K8s API Operator in Kubernetes.
2.  Create and deploy an API project.
3.  Invoke the API using a generated key.

Let's get started...

## Step 1 - Setup Choreo Connect and K8s API Operator in Kubernetes

1.  Download the Choreo Connect v0.9.0 from
    [GitHub release page's](https://github.com/wso2/product-microgateway/releases/tag/v0.9.0) assets section and extract it
    to a folder of your choice. Let's refer to this folder as `<CHOREO-CONNECT_HOME>`.

2.  Add the Kubernetes configurations for Choreo Connect and API Manager using the kubectl tool.

    ```bash
    kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/apim
    ```
    
    Apply Kubernetes configurations for Choreo Connect after successfully started the API Manager instance.
    ```bash
    kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/choreo-connect
    ```
    
3.  Install the K8s API Operator.

    ```bash
    kubectl apply -f https://github.com/wso2/k8s-api-operator/releases/download/v2.0.0/api-operator-configs.yaml
    ```

    For more information, see [Installing the API K8s Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install/)

4.  Configure the K8s API Operator to export APIs to API Manager.
   
    ```bash
    kubectl patch configmap api-controller-config \
       -p '{"data":{"deployAPIToMicrogateway":"false", "deployAPIToAPIManager":"true"}}'
    ```

5.  Add the host entry to the `/etc/hosts` file. 
    
    Add the following entry to `/etc/hosts` file in order to access the Choreo Connect Router, API Manager publisher and Developer Portal.

    ```sh
    <ingress_address>    gw.wso2.com    apim.wso2.com
    ```

## Step 2 - Create and deploy an API project

Let's create our first project with the name "petstore" by adding the [OpenAPI definition](https://petstore.swagger.io/v2/swagger.json) of the petstore.

1.  Create a Kubernetes `ConfigMap` with the API-CTL project.
    
    1. Download the API Controller (apictl) from the [GitHub release page's](https://github.com/wso2/product-apim-tooling/releases/tag/v4.0.0) assets section and extract them to a folder of your choice.

          ```bash tab="Format"
          export PATH=$PATH:<cli_tool_extracted_location>
          ```

          ```bash tab="Example"
          apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
          ```

          The project is now initialized. You should notice a directory with the name "petstore" being created in the location
       where you executed the command.
    
    2. Update endpoints as `https://petstore.swagger.io/v2` of the API by editing the `petstore/api.yaml` file.
   
          ```yaml
          endpointConfig:
            endpoint_type: http
            production_endpoints:
              url: https://petstore.swagger.io/v2
            sandbox_endpoints:
              url: https://petstore.swagger.io/v2
          ```
    
    2. Zip the created "petstore"` directory and create a Kubernetes Config Map.

          ```bash
          zip -r petstore.zip petstore/
          kubectl create cm petstore-cm --from-file petstore.zip
          ```

        !!! info
            You can also create a Kubernetes configmap directly from the OpenAPI definition.
           
            ```bash
            kubectl create cm petstore-cm --from-literal=swagger="$(curl -k https://petstore.swagger.io/v2/swagger.json)"
            ```

2.  Deploy your first API by creating an API resource in Kubernetes.

    ```bash
    cat <<EOF | kubectl apply -f -
    apiVersion: wso2.com/v1alpha2
    kind: API
    metadata:
        name: petstore-api
    spec:
        swaggerConfigMapName: petstore-cm
    EOF
    ```

3.  Publish the API.

    1. Access the Publisher in WSO2 API Manager.
    
         [https://apim.wso2.com/publisher/apis](https://apim.wso2.com/publisher/apis)
    
         You can see the **SwaggerPetstore** API is created. 
         
    2. Sign in to the Publisher.
    
         Use `admin` as username and password when signing in to the Publisher.

         [![Created SwaggerPetstore API]({{base_path}}/assets/img/deploy/mgw/swagger-petstore-in-publisher-portal.png)]({{base_path}}/assets/img/deploy/mgw/swagger-petstore-in-publisher-portal.png)
    
    3. Publish the API via the **Lifecycle** tab of the Publisher.
    
        !!! note
            If you deployed an API directly using the OpenAPI definition in the step 1, you do need to set endpoints, business plans, create a revision and deploy to the gateway.
          
## Step 3 - Subscribe to API and get a token

1.  Sign in to the WSO2 Developer Portal.
     
     [https://apim.wso2.com/devportal](https://apim.wso2.com/devportal)
    
2.  Click on the API that you published (e.g., `SwaggerPetstore`).

3.  Subscribe to the API (e.g., `SwaggerPetstore` 1.0.5) using an application and an available throttling policy.
   
     [![Subscribe to an API]({{base_path}}/assets/img/learn/subscribe-to-api.png)]({{base_path}}/assets/img/learn/subscribe-to-api.png)

4.  Click **Applications** and then click on the application that you used to subscribe to the API.

    [![Generate production keys]({{base_path}}/assets/img/learn/generate-keys-production.png)]({{base_path}}/assets/img/learn/generate-keys-production.png)

5.  Click **Production Keys** and click **Generate keys** to generate a production key.

!!! tip
    - **Production and Sandbox Tokens**:
    To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. </br>For more information, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).
    - **JWT tokens**:
    As the application is self-contained (JWT), **copy the generated access token** before proceeding to the next step.

## Step 4 - Invoke the API via Choreo Connect

Invoke the API running on Choreo Connect using the following cURL command.

```bash
TOKEN=<copied_token>
```

```bas
curl -X GET "https://gw.wso2.com/v2/1.0.5/pet/findByStatus?status=sold" \
    -H "accept: application/json" \
    -H "Authorization: Bearer $TOKEN" -k
```

You have successfully created your first API on the Choreo Connect and invoked it.

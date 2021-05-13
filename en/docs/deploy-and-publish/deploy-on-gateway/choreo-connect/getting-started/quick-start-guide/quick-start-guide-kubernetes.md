# Quick Start Guide - Kubernetes

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
    [github release page's](https://github.com/wso2/product-microgateway/releases/tag/v0.9.0) assets and extract them
    to a folder of your choice. We will refer to this folder as the `CHOREO-CONNECT_HOME`.

2.  Apply the Kubernetes configurations for Choreo Connect using the kubectl tool.

    ```bash
    kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect
    ```

3.  Install K8s API Operator by executing the following command.

    ```bash
    kubectl apply -f https://github.com/wso2/k8s-api-operator/releases/download/v2.0.0/api-operator-configs.yaml
    ```
    !!!info
        For more information, see [Installing the API K8s Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install/)

4.  Add the host entry to `/etc/hosts` file.

    Add the following entry to `/etc/hosts` file in order to access the Choreo Connect Router and Adapter.

    ```sh
    <INGRESS_ADDRESS>    gw.wso2.com    adapter.wso2.com
    ```

## Step 2 - Create and deploy an API project

Let's create our first project with the name "petstore" by adding the [OpenAPI definition](https://petstore.swagger.io/v2/swagger.json) of the petstore.

1.  Create a Kubernetes ConfigMap with the API-CTL project.
    
    Download the api controller (apictl) from the 
    [github release page's](https://github.com/wso2/product-apim-tooling/releases/tag/v4.0.0) assets and 
    extract them to a folder of your choice.

    ```bash
    export PATH=$PATH:<CLI_TOOL_EXTRACTED_LOCATION>
    ```

    ```bash
    apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
    ```

    The project is now initialized. You should notice a directory with the name "petstore" being created in the location
    where you executed the command.
    
    Let's update endpoints as `https://petstore.swagger.io/v2` of the API by editing the `petstore/api.yaml` file.

    ```yaml
    endpointConfig:
      endpoint_type: http
      production_endpoints:
        url: https://petstore.swagger.io/v2
      sandbox_endpoints:
        url: https://petstore.swagger.io/v2
    ```
    
    Let's zip the created "petstore"` directory and create a Kubernetes Config Map.

    ```bash
    zip -r petstore.zip petstore/
    kubectl create cm petstore-cm --from-file petstore.zip
    ```

    !!! info
        You can also create a Kubernetes configmap directly from the swagger definition.
        
        ```bash
        kubectl create cm petstore-cm --from-literal=swagger="$(curl -k https://petstore.swagger.io/v2/swagger.json)"
        ```

2.  Now let's deploy our first API by creating an API resource in Kubernetes.

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

## Step 3 - Invoke the API

1.  The next step would be to invoke the API using a REST tool. Since APIs on the Choreo Connect are by default secured, 
    we need a valid token in order to invoke the API.
    Use the following sample token accepted by Choreo Connect to access the API. 
    Let's set the token to the command line as a variable.

    ```bash
    TOKEN=$(curl -X POST "https://gw.wso2.com/testkey" -d "scope=read:pets" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
    ```

2.  We can now invoke the API running on the Choreo Connect using cURL as below.

    ```bash
    curl -X GET "https://gw.wso2.com/v2/pet/findByStatus?status=available" -H "accept: application/json" -H "Authorization:Bearer $TOKEN" -k
    ```

You have successfully created your first API on the Choreo Connect and invoked it.

# Get Started with Kubernetes for Microgateway

## Design Your First API

This section is a step-by-step guide to create, publish, and invoke an API in the WSO2 API Microgateway.

### Before you begin...

1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
2. Setup a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.14 or above.
      - Minimum CPU : 2vCPU
      - Minimum Memory : 2GB

### Objectives

1. Setup K8s API Operator in Kubernetes.
2. Create and deploy an API project.
3. Invoke the API using a generated key.

Let's get started...

### Step 1 - Setup Microgateway and K8s API Operator in Kubernetes

1.  Download the WSO2 API Microgateway v4.0.0-m3 from
    [github release page's](https://github.com/wso2/product-microgateway/releases/tag/v4.0.0-m3) assets and extract them
    to a folder of your choice. We will refer to this folder as the `MG_HOME`.

2.  Using the kubectl tool, apply Kubernetes configurations for Microgateway.
    ```bash
    kubectl apply -Rf <MG_HOME>/resources/k8s-artifacts
    ```

3.  Let's create a namespace and install K8s API Operator by executing the following command.
    ```bash
    kubectl create ns wso2-system;
    kubectl apply -n wso2-system -f https://github.com/wso2/k8s-api-operator/releases/download/v2.0.0-m3/api-operator-configs.yaml
    ```

### Step 2 - Create and deploy an API project

Let's create our first project with the name "petstore" by adding the
[open API definition](https://petstore.swagger.io/v2/swagger.json) of the petstore.

1.  First we need to create a Kubernetes ConfigMap with the swagger definition.

    ```bash
    kubectl create cm petstore-cm --from-literal=swagger="$(curl -k https://petstore.swagger.io/v2/swagger.json)"
    ```

    !!! note
        You can also create a Kubernetes configmap with a zipped apictl project to deploy an API.

        Download the api controller (apictl) and the microgateway distribution from the 
        [github release page's](https://github.com/wso2/product-microgateway/releases) assets and 
        extract them to a folder of your choice.
        ```bash
        export PATH=$PATH:<CLI_TOOL_EXTRACTED_LOCATION>
        ```

        ```bash
        apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
        ```

        The project is now initialized. You should notice a directory with the name "petstore" being created in the location 
        where you executed the command. Let's zip the created "petstore"` directory and create a Kubernetes condfigmap.
        You can also use this Kubernetes configmap to deploy APIs.

        ```bash
        zip -r petstore.zip petstore/
        kubectl create cm petstore-cm --from-file petstore.zip
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

    Or else execute the following command

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/wso2/k8s-api-operator/v2.0.0-m3/scenarios/scenario-2/petstore-api.yaml
    ```

### Step 3 - Invoke the API

1.  The next step would be to invoke the API using a REST tool. Since APIs on the Microgateway are by default secured, 
    we need a valid token in order to invoke the API.
    Use the following sample token accepted by the microgateway to access the API. 
    Lets set the token to the command line as a variable.

    ```bash
    TOKEN=eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ==.eyJhdWQiOiJBT2syNFF6WndRXzYyb2QyNDdXQnVtd0VFZndhIiwic3ViIjoiYWRtaW5AY2FyYm9uLnN1cGVyIiwibmJmIjoxNTk2MDA5NTU2LCJhenAiOiJBT2syNFF6WndRXzYyb2QyNDdXQnVtd0VFZndhIiwic2NvcGUiOiJhbV9hcHBsaWNhdGlvbl9zY29wZSBkZWZhdWx0IiwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6OTQ0My9vYXV0aDIvdG9rZW4iLCJrZXl0eXBlIjoiUFJPRFVDVElPTiIsImV4cCI6MTYyNzU0NTU1NiwiaWF0IjoxNTk2MDA5NTU2LCJqdGkiOiIyN2ZkMWY4Ny01ZTI1LTQ1NjktYTJkYi04MDA3MTFlZTJjZWMifQ==.otDREOsUUmXuSbIVII7FR59HAWqtXh6WWCSX6NDylVIFfED3GbLkopo6rwCh2EX6yiP-vGTqX8sB9Zfn784cIfD3jz2hCZqOqNzSUrzamZrWui4hlYC6qt4YviMbR9LNtxxu7uQD7QMbpZQiJ5owslaASWQvFTJgBmss5t7cnurrfkatj5AkzVdKOTGxcZZPX8WrV_Mo2-rLbYMslgb2jCptgvi29VMPo9GlAFecoMsSwywL8sMyf7AJ3y4XW5Uzq7vDGxojDam7jI5W8uLVVolZPDstqqZYzxpPJ2hBFC_OZgWG3LqhUgsYNReDKKeWUIEieK7QPgjetOZ5Geb1mA==
    ``` 
    
    !!! note
        You can use the above token to test the API. Follow the documentation
        [Secure APIs using JWT (Self Contained) Access Token]({{base_path}}/design/api-security/oauth2/access-token-types/jwt-tokens)
        if you want to generate an access token.

2.  We can now invoke the API running on the microgateway using cURL as below. Replace "<NODE_IP>" with one of Kubernetes worker nodes before
    executing the command.

    ```bash
    curl -X GET "https://<NODE_IP>:30201/v2/pet/findByStatus?status=available" -H "accept: application/json" -H "Authorization:Bearer $TOKEN" -k
    ```

You have successfully created your first API on the API Microgateway and invoked it.
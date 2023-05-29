# Deploying Choreo Connect as a Standalone Gateway on Kubernetes

Let's deploy an API in Choreo Connect running on Kubernetes as a Standalone Gateway. We can use [WSO2 API Controller (apictl)]({{base_path}}/reference/apictl/wso2-api-controller/) the Command Line Tool to deploy the API.

!!! info "Before you begin"

    1.  Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
    2.  Setup a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.20 or above.
        - Minimum CPU : 3vCPU
        - Minimum Memory : 2GB
    3.  Deploy an ingress controller - [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) for this sample.

{!includes/deploy/k8s-setup-note.md!}

## Step 1 - Setup Choreo Connect in Kubernetes

1.  Download and extract the Choreo Connect distribution .zip file

    The latest Choreo Connect distribution can be downloaded from [https://wso2.com/choreo/choreo-connect/](https://wso2.com/choreo/choreo-connect/). Extract the Choreo Connect distribution .zip file. The extracted folder will be called as `CHOREO-CONNECT_HOME` hereafter.

2.  Apply the Kubernetes configurations for Choreo Connect using the kubectl tool.

     ```bash
     kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect
     ```

3.  Add the host entry to the `/etc/hosts` file.

    Add the following entry to the `/etc/hosts` file in order to access the Choreo Connect Router and Adapter.

    ```sh
    <INGRESS_ADDRESS>    gw.wso2.com    adapter.wso2.com
    ```

## Step 2 - Initialize an API Project

Let's create our first project with the name "petstore" based on the [OpenAPI definition](https://petstore.swagger.io/v2/swagger.json) of the petstore.

1. Download and install apictl

    apictl is a CLI tool that can be used to deploy and undeploy APIs in the Choreo Connect clusters.
    Refer [Download and initialize the CTL Tool]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool)
    to set up the apictl in your development environment.
    
2. Now let's create our first API project to deploy on Choreo Connect that is set up on Kubernetes

    Navigate to a preferred workspace folder using the command line. Run the following command to create an API project named "petstore". This creates the folder structure for the artifacts to be included. Use the --oas option as given below to create an API project based on an OpenAPI definition.

    ```shell
    apictl init petstore --oas <api definition path>
    ```
    
    Let's use the [Petstore sample OpenAPI definition](https://petstore.swagger.io/)
    
    ```shell
    apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
    ```
    
    The project is now initialized. A directory with the name "petstore" has been created.

!!! info
    For more information on the API project directory that gets created, see [Getting Started with apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller).

## Step 3 - Deploy the API Project

1. Add the Choreo Connect Cluster as an Environment to apictl

    To use apictl with Choreo Connect, we need to add the Choreo Connect cluster as an environment in apictl.
    Basically, the adapter URL will be added as the Gateway environment, and the added environment can be used in the subsequent commands.

    ``` shell tab="Format"
    apictl mg add env <ENVIRONMENT_NAME> --adapter <ADAPTER_URL>
    ```

    ``` shell tab="Example"
    apictl mg add env k8s --adapter https://adapter.wso2.com
    ```

2. Log in to the Choreo Connect Cluster

    Next you need to log in to the Choreo Connect environment (log in to the adapter) in order to deploy the API in Choreo Connect.

    ``` shell tab="Format"
    apictl mg login <ENVIRONMENT_NAME> -u <AUTHORIZED_USER_USERNAME> -p <USER_PASSWORD> -k
    ```

    ``` shell tab="Example"
    apictl mg login k8s -u admin -p admin -k
    ```

    !!! info
        The following apictl commands are executed with the flag `-k` to avoid the SSL verification with Choreo Connect. To communicate via https without skipping the SSL verification (without -k flag), add the cert of Choreo Connect into `/home/<your-pc-username>/.wso2apictl/certs`.

3. Deploy the API in Choreo Connect

    Now let's deploy our first API to Choreo Connect using the project created in the step 3.
    Navigate to the location where the petstore project was initialized. Execute the following command to deploy the API in Choreo Connect.

    ``` shell tab="Format"
    apictl mg deploy api -f <PROJRECT_NAME> -e <ENVIRONMENT_NAME> -k
    ```

    ``` shell tab="Example"
    apictl mg deploy api -f petstore -e k8s -k
    ```

## Step 4 - Invoke the sample API

1. Obtain a token

    After the APIs are exposed via WSO2 Choreo Connect, you can invoke an API with a valid access token (JWT) or using a test key. Let's use WSO2 Choreo Connect's test key endpoint to obtain a test key in order to access the API. Refer [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt) for more details.

    ``` shell tab="Sample Token"
    TOKEN=$(curl -X POST "https://gw.wso2.com/testkey" -d "scope=read:pets" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
    ```

    !!! info
        You can obtain a JWT token from any third-party secure token service or via WSO2 API Manager, that is configured as an issuer in Choreo Connect.

2. Invoke the API

    Execute the following command to invoke the API using the test key. You can now invoke the API running on Choreo Connect using the following cURL command.

    ``` shell tab="Format"
    curl -X GET "<hostname>:<port>/<API-context>/<API-resource>" -H "Authorization: Bearer $TOKEN" -k
    ```

    ``` shell tab="Example"
    curl -X GET "https://gw.wso2.com/v2/pet/findByStatus?status=available" -H "accept: application/json" -H "Authorization:Bearer $TOKEN" -k
    ```

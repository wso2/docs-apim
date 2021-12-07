# Using Choreo Connect Deployed on Kubernetes with WSO2 API Controller

Let's deploy an API using WSO2 API Controller (apictl), which is the CLI Tool, on a Choreo Connect Kubernetes deployment.

## Before you begin

1.  Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
2.  Setup a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.14 or above.
      - Minimum CPU : 3vCPU
      - Minimum Memory : 2GB
3.  Deploy an ingress controller - [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) for this sample.

## Objectives

1.  Create and deploy an API project.
2.  Invoke the API using a generated key.

Let's get started...

## Step 1 - Setup Choreo Connect in Kubernetes

1.  Download and extract Choreo Connect distribution .zip file

    Latest Choreo Connect distribution can be downloaded from the [GitHub repository](https://github.com/wso2/product-microgateway/releases). Extract the Choreo Connect distribution .zip file. The extracted folder will be called as `CHOREO-CONNECT_HOME` hereafter.

2.  Apply the Kubernetes configurations for Choreo Connect using the kubectl tool.

    {!includes/deploy/cc-tryout-in-arm64-note.md!}

    ```bash
    kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect
    ```

3.  Add the host entry to `/etc/hosts` file.

    Add the following entry to `/etc/hosts` file in order to access the Choreo Connect Router and Adapter.

    ```sh
    <INGRESS_ADDRESS>    gw.wso2.com    adapter.wso2.com
    ```

## Step 2 - Initialize an API Project

Let's create our first project with the name "petstore" by adding the [OpenAPI definition](https://petstore.swagger.io/v2/swagger.json) of the petstore.

1. Download and install APICTL

    APICTL is a CLI tool that can be used to deploy undeploy APIs into Choreo Connect clusters.
    Refer [Download and initialize the CTL Tool]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool)
    to set up the APICTL in your development environment.
    
2. Now let's deploy our first API by creating an API resource in Kubernetes.

    Navigate to a preferred workspace folder using the command line. This is the location that is used to store the Choreo Connect project.
    Run the following command to create a project named "petstore". This creates the folder structure for the artifacts to be included. Use the --oas option to include the API definition to the project as follows.

    ```shell
    apictl init petstore --oas <api definition path>
    ```
    
    Let's use the [Petstore sample open API definition](https://petstore.swagger.io/)
    
    ```shell
    apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
    ```
    
    The project is now initialized. A directory with the name "petstore" has been created.

!!! info
    -   For more information on the API project directory that gets created, see [APICTL Getting Started]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller).

## Step 3 - Deploy the API Project

### Step 3.1 - Add Choreo Connect Cluster as Environment to APICTL

To use APICTL with Choreo Connect, we need to add the Choreo Connect cluster as an environment in the APICTL.
Basically, the adapter URL will be added as the Gateway environment, and the added environment can be used in the subsequent commands.

``` shell tab="Format"
apictl mg add env <ENVIRONMENT_NAME> --adapter <ADAPTER_URL>
```

``` shell tab="Example"
apictl mg add env k8s --adapter https://adapter.wso2.com
```

### Step 3.2 - Log in to the Choreo Connect Cluster

Next you need to log in to the Choreo Connect environment (log in to the adapter) in order to deploy the API in Choreo Connect.

``` shell tab="Format"
apictl mg login <ENVIRONMENT_NAME> -u <AUTHORIZED_USER_USERNAME> -p <USER_PASSWORD> -k
```

``` shell tab="Example"
apictl mg login k8s -u admin -p admin -k
```

!!! info
    Following APICTL commands are being executed with -k flag to avoid SSL verification with the Choreo Connect.
    To communicate via HTTPS without skipping SSL verification (without -k flag), add the cert of Choreo Connect into `/home/<your-pc-username>/.wso2apictl/certs`.

### Step 3.3 - Deploy the API in Choreo Connect

Now let's deploy our first API to Choreo Connect using the project created in the step 3.
Navigate to the location where the petstore project was initialized. Execute the following command to deploy the API in the Choreo Connect.

``` shell tab="Format"
apictl mg deploy api -f <PROJRECT_NAME> -e <ENVIRONMENT_NAME> -k
```

``` shell tab="Example"
apictl mg deploy api -f petstore -e k8s -k
```

## Step 4 - Invoke the sample API

### Step 4.1 - Obtain a token

After the APIs are exposed via WSO2 Choreo Connect, you can invoke an API with a valid token(JWT) or using a test key.  
Let's use WSO2 Choreo Connect's test key endpoint to obtain a test key in order to access the API. Refer [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt) for more details.

``` shell tab="Sample Token"
TOKEN=$(curl -X POST "https://gw.wso2.com/testkey" -d "scope=read:pets" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
```

!!! info
    More information
    -   You can obtain a JWT token from any third-party secure token service or via the WSO2 API Manager.

### Step 4.2 - Invoke the API

Execute the following command to invoke the API using the test key: You can now invoke the API running on WSO2 Choreo Connect using the following cURL command.

``` shell tab="Format"
curl -X GET "<hostname>:<port>/<API-context>/<API-resource>" -H "Authorization: Bearer $TOKEN" -k
```

``` shell tab="Example"
curl -X GET "https://gw.wso2.com/v2/pet/findByStatus?status=available" -H "accept: application/json" -H "Authorization:Bearer $TOKEN" -k
```

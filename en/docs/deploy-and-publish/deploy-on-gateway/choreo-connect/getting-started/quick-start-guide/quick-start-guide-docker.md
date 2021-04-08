# Quick Start Guide - Docker

Let's host your first API on  Choreo Connect using Docker.

## Before you begin...

Make sure to install and set up [Docker](https://www.docker.com).

### Step 1 - Download and setup Choreo Connect distribution zip and APICTL (Command Line Tool)

#### Step 1.1 - Download and Install APICTL

APICTL is a CLI tool which can be used to deploy undeploy APIs into Choreo Connect clusters.
Refer [Download and initialize the CTL Tool]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-ctl-tool)
to setup the APICTL in your development environment.

#### Step 1.2 - Download and Extract Choreo Connect distribution zip

Latest Choreo Connect distribution can be downloaded from the [page](https://wso2.com/api-management/api-microgateway/).
Extract the Choreo Connect distribution zip. Extracted folder will be called as `MG_HOME` hereafter.

### Step 2 - Initialize an API project

Navigate to a preferred workspace folder using the command line. This is the location that is used to store the Choreo Connect project.
Run the following command to create a project named "petstore".  This will create the folder structure for the artifacts to be included. Use the -oas option to include the API definition to the project as follows.

``` java
apictl init petstore --oas <api definition path>
```

Let's use the [Petstore sample open API definition](https://petstore.swagger.io/)

``` java
apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
```

The project is now initialized. A directory with the name "petstore" has been created.

!!! note
        The folder structure is similar to the following.

    ```java
    petstore
    ├── Client-certificates
    ├── Definitions
    │   └── swagger.yaml
    ├── Docs
    ├── Endpoint-certificates
    ├── Image
    ├── Interceptors
    ├── README.md
    ├── Sequences
    │   ├── fault-sequence
    │   ├── in-sequence
    │   └── out-sequence
    ├── api.yaml
    ├── api_meta.yaml
    └── libs
    ```

!!! info
    -   For more information on the API project directory that gets created, see [APICTL Getting Sterted]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller).

### Step 3 - Start Choreo Connect

Start the Choreo Connect on docker by executing the docker compose script inside the `CHOREO-CONNECT_HOME`. Navigate to `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/` and execute the following command.

``` java
docker-compose up -d
```

Once containers are up and running, we can monitor the status of the containers using the following command
    ``` java
    docker ps | grep choreo-connect-
    ```

### Step 4 - Deploy the API Project

#### Step 4.1 - Add Choreo Connect Cluster as Environment to APICTL

To use APICTL with Choreo Connect, we need to add the Choreo Connect cluster as an environment in the APICTL.
Basically the adapter url will be added as the gateway environment, and the added environment can be used in the subsequent commands.

``` java tab="Format"
apictl mg add env <ENVIRONMENT_NAME> --adapter <ADAPTER_URL>
```

``` java tab="Example"
apictl mg add env dev --adapter https://localhost:9843
```

#### Step 4.2 - Login to Choreo Connect Cluster

Next we need to login to the Choreo Connect environment(login to the adpater) in order
deploy the API in Choreo Connect.

``` java tab="Format"
apictl mg login dev -u <AUTHORIZED_USER_USERNAME> -p <USER_PASSWORD> -k
```

``` java tab="Example"
apictl mg login dev -u admin -p admin -k
```

!!! info
    Following apictl commands are being executed with -k flag to avoid SSL verification with the Choreo Connect.
    To communicate via https without skipping SSL verification (without -k flag), add the cert of Choreo Connect into `/home/<your-pc-username>/.wso2apictl/certs`.

#### Step 4.3 - Deploy the API in Choreo Connect

Now let's deploy our first API to Choreo Connect using the project created in the step 3.
   Navigate to the location where the petstore project was initialized. Execute the following command to deploy the API in the Choreo Connect.

``` java tab="Format"
apictl mg deploy api -f <PROJRECT_NAME> -e <ENVIRONMENT_NAME> -k
```

``` java tab="Example"
apictl mg deploy api -f petstore -e dev -k
```

### Step 5 - Invoke the sample API

#### Step 5.1 - Obtain a token

After the APIs are exposed via WSO2 Choreo Connect, you can invoke an API with a valid token(JWT) or using a test key.  
Let's use WSO2 Choreo Connect's test key endpoint to obtain an test key in order to access the API. Refer [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-Choreo Connect/security/generate-a-test-jwt.md) for more details.

``` java tab="Sample Token"
    TOKEN=$(curl -X POST "https://localhost:9095/testkey" -d "scope=read:pets" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
```

!!! info
    More information
    -   You can obtain a JWT token from any third-party secure token service or via the WSO2 API Manager.

#### Step 5.2 - Invoke the API

Execute the following command to Invoke the API using the test key: You can now invoke the API running on the WSO2 Choreo Connect using the following cURL command.

``` java tab="Format"
curl -X GET "<Docker-hostname>:<Docker-port>/<API-context>/<API-resource>" -H "Authorization: Bearer $TOKEN" -k
```

``` java tab="Example"
curl -X GET "https://localhost:9095/v2/pet/findByStatus?status=available" -H "accept: application/json" -H "Authorization:Bearer $TOKEN" -k
```

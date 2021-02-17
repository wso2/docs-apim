# Quick Start Guide - Docker

Let's host your first API on WSO2 API Microgateway using Docker.

### Before you begin..

Make sure to install and set up [Docker](https://www.docker.com) and the [installation prerequisites for the Microgateway Toolkit]({{base_path}}/install-and-setup/install-on-vm/#microgateway-toolkit).

### Step 1 - Generate an executable using WSO2 API Microgateway Toolkit

##### Step 1.1 - Initialize a project

1.  Navigate to a preferred workspace folder using the command line. This is the location that is used to store the Microgateway project.
2.  Run the following command to create a project named "petstore".  This will create the folder structure for the artifacts to be included. Use the -a option to include the API definition to the project as follows.

    ``` java
    micro-gw init petstore -a <api definition path>
    ```

    Let's use the [Petstore sample open API definition](https://petstore.swagger.io/)

    ``` java
    micro-gw init petstore -a https://raw.githubusercontent.com/wso2/product-microgateway/master/samples/petstore_v3.yaml
    ```

    The project is now initialized. A directory with the name "petstore" has been created.

    !!! note
        The folder structure is similar to the following.
    ``` java
    petstore
    ├── api_definitions
    └── swagger.json
    ├── conf
    │   └── deployment-config.toml
    ├── extensions
    │   ├── extension_filter.bal
    │   ├── startup_extension.bal
    │   └── token_revocation_extension.bal
    ├── grpc_definitions
    ├── interceptors
    ├── lib
    ├── policies.yaml
    ```

!!! info
    -   For more information on the MGW project directory that gets created, see [Project Directory]({{base_path}}/reference/project-directory/).
    -   Check out the [troubleshooting]({{base_path}}/troubleshooting/troubleshooting/) guide if you run into an issue.

##### Step 1.2 - Build the project and the docker image

1.  Use the command-line tool to navigate to where the project directory ("petstore") was created. Execute the following command to build the project and to create the docker image.
    An executable jar file (`petstore/target/petstore.jar`) is created to expose the API via WSO2 API Microgateway.

    ``` java
    micro-gw build petstore --docker --docker-image petstore:v1 --docker-base-image wso2/wso2micro-gw:3.2.0
    ```

    !!! info
        More information
        Here are [FAQs]({{base_path}}/faqs/).

### Step 2 - Expose the sample API via WSO2 API Microgateway Docker image

Run the docker image in order to expose the API via WSO2 API Microgateway. The following command exposes the API https endpoint on port 9095. The context of the API is "/petstore/v1".

  `<project_target_path>` -  The path of the target directory created inside the project directory.

``` java tab="Format"
docker run -d -p <host-HTTPS-port>:<container-HTTPS-port> -p <host-HTTP-port>:<container-HTTP-port> <MGW-Docker-image-name>
```

``` java tab="Example"
docker run -d -p 9095:9095 -p 9090:9090 petstore:v1
```

### Step 3 - Invoke the sample API
##### Step 3.1 - Obtain a token

Once the APIs are exposed via WSO2 API Microgateway, you can invoke an API with a valid token(JWT or opaque access token) or an API key.  Let's use WSO2 API Microgateway's API key endpoint to get an API key. The following command will retrieve a token and set it to the shell variable TOKEN.

``` java tab="Sample Token"
TOKEN=$(curl -X get "https://localhost:9095/apikey" -H "Authorization:Basic YWRtaW46YWRtaW4=" -k)
```

!!! info
    More information
    -   You can obtain a JWT token from any third-party secure token service or via the WSO2 API Manager.
    -   You can obtain an API Key easily from WSO2 API Microgateway. Follow the documentation to [Obtain an API Key]({{base_path}}/publish/security/api-key-security-token-service/) .
    -   Alternatively, you can also use an opaque token to invoke the API.
    For more information, see the FAQs on [Working with Tokens]({{base_path}}/references/faqs/#WorkingwithTokens) .

##### Step 3.2 - Invoke the API

Execute the following command to Invoke the API using the API key: You can now invoke the API running on the WSO2 API Microgateway using the following cURL command.

``` java tab="Format"
curl -X GET "<Docker-hostname>:<Docker-port>/<API-context>/<API-resource>" -H "accept: application/xml" -H "api_key:$TOKEN" -k
```

``` java tab="Example"
curl -X GET "https://localhost:9095/api/v3/pet/findByStatus?status=available" -H "accept: application/json" -H "api_key:$TOKEN" -k
```

!!! note
    You were able to invoke the API resource `pet/findByStatus` using an API Key in `api_key` header because the resource is secured with API Key in API definition as follows. For more information, please refer to the documentation on [API Key Authentication]({{base_path}}/deploy/api-security/api-authentication/api-key-authentication/).
    ```yml
    "paths": {
      "/pet/findByStatus": {
        "get": {
          "security": [
            {
              "api_key": []
            }
          ]
        }
      }
    },
    "securityDefinitions": {
      "api_key": {
        "type": "apiKey",
        "name": "api_key",
        "in": "header"
      }
    }
    ```



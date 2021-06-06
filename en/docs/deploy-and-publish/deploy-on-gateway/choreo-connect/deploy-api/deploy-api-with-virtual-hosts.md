# Deploy API to Choreo Connect with Virtual Hosts

There are two ways to add an API to Choreo Connect. For more info refer {{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/overview/

1. [Via API Manager](#via-api-manager)
2. [Via the API Controller (apictl)](#via-the-api-controller-apictl)

!!! info
    **Before you begin**

    This guide assumes that you already have a Choreo Connect instance that is up and running.
    If not, refer to the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-with-apim)
    on how to install and run Choreo Connect. To learn more about Choreo Connect, have a look at the
    [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview). 

## Via API Manager

### Step 1 - Define Virtual Hosts

Let's define virtual hosts (VHosts) in API Manager server instance by editing the `deployment.toml`.

!!! info
    Refer [Define Custom Hostnames]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/exposing-apis-via-custom-hostnames/#step-1-define-the-custom-hostnames)
    for more information.

1. Open `<APIM-HOME>/repository/conf/deployment.toml` file.
2. Add the following config under the **Default** `[[apim.gateway.environment]]` to define the VHost `us.wso2.com`.
    ```toml
    [[apim.gateway.environment.virtual_host]]
    ws_endpoint = "ws://us.wso2.com:9099"
    wss_endpoint = "wss://us.wso2.com:8099"
    http_endpoint = "http://us.wso2.com/gateway"
    https_endpoint = "https://us.wso2.com/gateway"
    websub_event_receiver_http_endpoint = "http://us.wso2.com:9021"
    websub_event_receiver_https_endpoint = "https://us.wso2.com:8021"
    ``` 
### Step 2 - Configure Choreo Connect with API Manager

Refer to [documentation on how to configure Choreo Connect with API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/#configure-choreo-connect-with-api-manager).

### Step 3 - Create an API in API Manager

Follow the steps [here]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api-from-an-openapi-definition/).

### Step 4 - Deploy the API in API Manager

The guide [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) will explain how you can easily deploy the API you just created.
When deploying the API, select the Virtual Host you defined earlier (i.e. `us.wso2.com`).

You have successfully deployed the API to Choreo Connect with the VHost `us.wso2.com`.

To invoke the API, skip to the steps [here](#invoke-the-api).

## Via the API Controller (apictl)

Follow the all steps except **Deploy API** in the (Deploy an API via apictl documentation)[{{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-via-apictl/].

Before deploying the API project, edit the file `deployment_environments.yaml`.

```yaml
type: deployment_environments
version: v4.0.0
data:
 -
   displayOnDevportal: true
   deploymentEnvironment: Default
   deploymentVhost: us.wso2.com
```

!!! info
    When configuring multiple Choreo Connect Gateway environments, you have to configure the default VHost of the particular environment.
    
    ```toml tab="Format"
    # default vhosts mapping for standalone mode
    [[adapter.vhostMapping]]
      environment = <ENVIRONMENT_NAME>
      vhost = <DEFAULT_VHOST_OF_ENVIRONMENT>
    ```
    
    ```toml tab="Example"
    # default vhosts mapping for standalone mode
    [[adapter.vhostMapping]]
      environment = "Default"
      vhost = "localhost"
    [[adapter.vhostMapping]]
      environment = "sg-region"
      vhost = "sg.wso2.com"
    ```
    
    If the VHost is not declared in the API project, the API is deployed with the default VHost of the environment.
    For exammple, an API project with following `deployment_environments.yaml` will be deployed to the following.
    - Environment: Default - Vhost: us.wso2.com
    - Environment: sg-region - Vhost: sg.wso2.com
    - Environment: uk-region - API is not deployed to this environment becuase it is not configured in `[[adapter.vhostMapping]]`.
    
    ```yaml
    type: deployment_environments
    version: v4.0.0
    data:
     -
       displayOnDevportal: true
       deploymentEnvironment: Default
       deploymentVhost: us.wso2.com
     -
       displayOnDevportal: true
       deploymentEnvironment: sg-region
     -
       displayOnDevportal: true
       deploymentEnvironment: uk-region
    ```

Let's invoke the API.

## Invoke the API

First we need to add the host entry to `/etc/hosts` file in order to access the API Manager publisher and dev portal.
Add the following entry to `/etc/hosts` file

```sh
127.0.0.1   us.wso2.com
```

{! ./includes/obtain-jwt.md !}

Execute the following cURL command to Invoke the API using the JWT.

```sh
curl -X GET "https://us.wso2.com:9095/v2/pet/findByStatus?status=available" -H "accept: application/xml" -H "Authorization:Bearer $TOKEN" -k
```

!!! note
    You can also use header to specify the VHost to invoke the API.
    ```sh
    curl -X GET "https://localhost:9095/v2/pet/findByStatus?status=available" \
        -H "Host: us.wso2.com"
        -H "accept: application/xml" \
        -H "Authorization:Bearer $TOKEN" -k
    ```

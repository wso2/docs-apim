# Deploying a REST API in Choreo Connect

You can deploy a REST API in the following ways depending on the Choreo Connect **mode** you have chosen.


|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Publisher Portal](#via-wso2-api-manager-publisher-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[Via apictl for Standalone Mode](#via-apictl-for-standalone-mode) |


## Via WSO2 API Manager Publisher Portal

Follow the instructions below to deploy a REST API in a Choreo Connect instance run with WSO2 API Manager as the Control Plane.

!!! info "Before you begin"

    This guide assumes that you already have a Choreo Connect instance configured to run with API Manager. If not,

    - To start Choreo Connect with an existing API Manager instance, follow the steps mentioned in the [Using Choreo Connect Deployed on Docker with WSO2 API Manager Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-docker-with-apim-as-control-plane)

    - To start a complete deployment setup that includes a WSO2 API Manager instance and a Choreo Connect instance already configured to work with API Manager, follow the steps in the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim).

### Step 1 - Create an API in API Manager

Create a REST type API using one of the following methods:

- [Create a REST API via the WSO2 API Manager Publsiher Portal]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/)
- [Import a REST API to WSO2 API Manager using WSO2 API Controller (apiclt)]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/)
     
     You need to initially initialize the API project and thereafter import the API project in order to be able to import the API to WSO2 API Manager using the apiclt.

For this example, let's create an API via the WSO2 API Manager Publsiher Portal.

### Step 2 - Deploy the API in API Manager

 The guide [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) will explain how you could easily deploy the API you just created.

That's it! To invoke the API follow the steps [here](#step-4-invoke-the-api).

!!! info

    During the startup, Choreo Connect will check the `config.toml` to see if the `controlPlane` configuration has been enabled. If so, it will start fetching all the necessary artifacts that belong to the Gateway environment given in `environmentLabels`. These artifacts include deployed APIs, Applications, Subscriptions, Policies, information related to Key Managers, etc.

    Whenever a new event occurs in API Manager such as an API being deployed, API Manager will notify Choreo Connect via Event Hub. Choreo Connect will then start fetching all the new artifacts related to its environment. 

!!! Tip
    To be able to invoke an API via the Developer Portal TryOut Console, make sure at least one of the certificates used by the enforcer is same as the certificate used by the Key Manager configured in API-M. In Choreo Connect, the certs for enforcer are located at `<CHOREO-CONNECT_HOME>/docker-compose/resources/enforcer/security/truststore`. In API-M, Key Managers can be configured from the API-M Admin Portal.


###  Step 3 - Invoke the API

{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

<!-- brought the following here because the path becomes relative when included in the includes folder -->
Refer to [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt) for more details.

## Via apictl for Standalone Mode

Follow the instructions below to deploy a REST API via WSO2 API Controller (apictl), which is a CLI Tool used when Choreo Connect is run as a Standalone Gateway.

!!! info "Before you begin"

    This guide assumes that you already have a Choreo Connect instance that is up and running. If not, checkout the [Using Choreo Connect Deployed on Docker with WSO2 API Controller Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-docker) on how to install and run Choreo Connect. To learn more about Choreo Connect, have a look at the [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview). 

### Step 1 - Download apictl and Set the Path Variable 

First download [apictl](https://github.com/wso2/product-apim-tooling/releases) locally and extract it into a folder of your choice. Then, add its location to your PATH variable.

```
export PATH=$PATH:<directory-of-the-apictl-executable>
```

### Step 2 - Create an API Project using apictl

Let's create your first project "petstore" using an OpenAPI definition. The following `apictl init` command will generate a project folder containing all the necessary files.

!!! warning

    If you have used a previous version of apictl before, remember to delete the directories `.wso2apictl` and `.wso2apictl.local` that are located in your home directory. Deleting them will make the newer apictl create them again, with content compatible with the current version.

``` bash
apictl init petstore --oas https://petstore.swagger.io/v2/swagger.json
```

{! ./includes/deploy/cc-deploy-api-standalone-mode.md !}

###  Step 6 - Invoke the API

{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

!!! info 

    Refer to the following content to learn more,

    - [Managing Choreo Connect with apictl]({{base_path}}/install-and-setup/setup/api-controller/managing-choreo-connect/managing-choreo-connect-with-ctl)
    - [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway)
    - [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt)

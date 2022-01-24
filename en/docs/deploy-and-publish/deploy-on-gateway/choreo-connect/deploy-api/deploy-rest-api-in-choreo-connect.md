# Deploying a REST API in Choreo Connect

You can deploy a REST type API in Choreo Connect using either one of the following Choreo Connect modes:

- [Choreo Connect with WSO2 API Manager as a Control Plane](#choreo-connect-with-wso2-api-manager-as-a-control-plane)
- [Choreo Connect as a Standalone Gateway](#choreo-connect-as-a-standalone-gateway)

## Choreo Connect with WSO2 API Manager as a Control Plane

Follow the instructions below to use Choreo Connect with WSO2 API Manager as the Control Plane to deploy a REST type API via the Publisher Portal in WSO2 API Manager:

### Step 1 - Configure Choreo Connect with API Manager

- To start Choreo Connect with an existing API Manager instance, follow the steps mentioned in the [Using Choreo Connect Deployed on Docker with WSO2 API Manager Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-docker-with-apim-as-control-plane)

- To start a complete deployment setup that includes a WSO2 API Manager instance and a Choreo Connect instance already configured to work with API Manager, follow the steps in the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim).

### Step 2 - Create an API in API Manager

Create a REST type API using one of the following methods:

- [Create a REST API via the WSO2 API Manager Publsiher Portal]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/)
- [Import a REST API to WSO2 API Manager using WSO2 API Controller (apiclt)]({{base_path}}/install-and-setup/setup/api-controller/managing-apis-api-products/importing-apis-via-dev-first-approach/)
     
     You need to initially initialize the API project and thereafter import the API project in order to be able to import the API to WSO2 API Manager using the apiclt.

For this example, let's create an API via the WSO2 API Manager Publsiher Portal.

### Step 3 - Deploy the API in API Manager

 The guide [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) will explain how you could easily deploy the API you just created.

That's it! To invoke the API follow the steps [here](#step-4-invoke-the-api).

During the startup, Choreo Connect will check the `config.toml` to see if the `controlPlane` configuration has been enabled. If so, it will start fetching all the necessary artifacts that belongs to the gateway environment given in `environmentLabels`. These artifacts include deployed APIs, Applications, Subscriptions, Polices, information related to Key Managers, etc.

Whenever a new event occurs in API Manager such as an API being deployed, API Manager will notify Choreo Connect via Event Hub. Choreo Connect will then start fetching all the new artifacts related to its environment. 

!!! Tip
    To be able to invoke an API via the Developer Portal TryOut Console, make sure at least one of the certificates used by the enforcer is same as the certificate used by the Key Manager configured in API-M. In Choreo Connect, the certs for enforcer are located at `<CHOREO-CONNECT_HOME>/docker-compose/resources/enforcer/security/truststore`. In API-M, Key Managers can be configured from the API-M Admin Portal.

!!! Note 

    You might find the following content useful here onwards,

    - [Choreo Connect with API Manager as Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane) 
    - [Publish an API on the Developer Portal]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api)

###  Step 4 - Invoke the API

{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

<!-- brought the following here because the path becomes relative when included in the includes folder -->
Refer to [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt) for more details.

## Choreo Connect as a Standalone Gateway

Follow the instructions below to use Choreo Connect as a Standalone Gateway to deploy a REST type API via WSO2 API Controller (apictl), which is a CLI Tool:

!!! info
    **Before you begin**

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

### Step 3 - Add an Choreo Connect Environment to apictl

To use apictl for Choreo Connect, a Choreo Connect environment needs to be added to apictl. This environment will hold the adapter URL for further commands.

``` bash
apictl mg add env dev --adapter https://localhost:9843
```

!!! info

    Note `mg` in the above command. The apictl commands that starts as `apictl mg` are Choreo Connect specific. If a command does not have `mg` after `apictl` then the command could probably be common to both Choreo Connect and API Manager, but it could also be API Manager specific. 

!!! tip

    The apictl commands here onwards are executed with the -k flag to avoid SSL verification with the Choreo Connect.

    To communicate via https without skipping SSL verification (without -k flag), add the cert in the Choreo Connect truststore into the `<USER_HOME>/.wso2apictl/certs` folder.

### Step 4 - Log in to the Choreo Connect Environment in apictl

You can use the following command to log in to the above Choreo Connect cluster (in other words log in to the Choreo Connect adapter). By logging in, an access token will be retrieved from Choreo Connect and saved in apictl.

``` bash
apictl mg login dev -k
```

or

``` bash
apictl mg login dev -u admin -p admin -k
```

### Step 5 - Deploy the API

Now let's deploy the API to Choreo Connect by executing the following command.

``` bash
apictl mg deploy api -f <path_to_the_API_project_just_created>/petstore -e dev -k
```

!!! Note 

    Refer to the following content to learn more,

    - [Managing Choreo Connect with apictl]({{base_path}}/install-and-setup/setup/api-controller/managing-choreo-connect/managing-choreo-connect-with-ctl)
    - [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway)

###  Step 6 - Invoke the API

{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

<!-- brought the following here because the path becomes relative when included in the includes folder -->
Refer to [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt) for more details.

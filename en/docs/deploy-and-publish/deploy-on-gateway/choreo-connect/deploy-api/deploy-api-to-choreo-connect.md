# Deploy an API to Choreo Connect

There are two ways to add an API to the Choreo Connect.

1. [Via API Manager](#via-api-manager)

    By enabling the Control Plane Event Hub in the Choreo Connect configuration file, the APIs deployed in API Manager will automatically be available in Choreo Connect. 

2. [Via the CLI tool (apictl)](#via-the-cli-tool-apictl)

    If you are not using WSO2 API Manager yet, or only want to try out Choreo Connect (as a standalone gateway), simply use the CLI tool [apictl](https://github.com/wso2/product-apim-tooling/releases) to host your API.

## Via API Manager

### Step 1 - Configure Choreo Connect with API Manager

Please refer [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/#configure-choreo-connect-with-api-manager).

### Step 2 - Create an API in API Manager

Follow the steps [here]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).

### Step 3 - Deploy the API in API Manager

 The guide [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) will explain how you could easily deploy the API you just created.

That's it! To invoke the API follow the steps [here](#invoke-the-api).


During the startup, Choreo Connect will check the `config.toml` to see if the `controlPlane.eventHub` configuration has been enabled. If so, it will start fetching all the necessary artifacts that belongs to the gateway environment given in `environmentLabels`. These artifacts include deployed APIs, Applications, Subscriptions, Polices, information related to Key Managers, etc.

Whenever a new event occurs in API Manager such as an API being deployed, API Manager will notify Choreo Connect via Event Hub. Choreo Connect will then start fetching all the new artifacts related to its environment. 

!!! Note 

    You might find the following content useful here onwards,

    - [API Manager as Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane) 
    - [Publish an API on the Developer Portal]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api)


## Via the CLI tool (apictl) 

!!! info
    **Before you begin**

    This guide assumes that you already have a Choreo Connect instance that is up and running. If not, checkout the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-overview) on how to install and run Choreo Connect. To learn more about Choreo Connect, have a look at the [Overview of Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview). 

### Step 1 - Download apictl and Set the Path Variable 

First download [apictl](https://github.com/wso2/product-apim-tooling/releases) locally and extract it into a folder of your choice. Then, add its location to your PATH variable.

```
export PATH=$PATH:<directory-of-the-apictl-executable>
```

### Step 2 - Create an API Project using apictl

Let's create your first project "petstore" using an open API definition. The following `apictl init` command will generate a project folder containing all the necessary files.

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

## Invoke the API
{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

<!-- brought the following here because the path becomes relative when included in the includes folder -->
Refer to [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/generate-a-test-jwt.md) for more details.

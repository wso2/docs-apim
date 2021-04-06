# Deploy an API to Microgateway

There are two ways to add an API to the Microgateway.

1. [Via API Manager](#via-api-manager)

    By enabling the Control Plane Event Hub in the Microgateway configuration file, the APIs deployed in API Manager will automatically be available in Microgateway. 

2. [Via the CLI tool (apictl)](#via-the-cli-tool-apictl)

    If you are not using WSO2 API Manager yet, or only want to try out Microgateway (as a standalone gateway), simply use the CLI tool [apictl](https://github.com/wso2/product-apim-tooling/releases) to host your API.

## Via API Manager

!!! info
    **Before you begin**

    - Make sure you have installed Docker and Docker Compose on your machine.

    - Download the latest [Microgateway 4.0.0 release](https://github.com/wso2/product-microgateway/releases)and extract it to a folder of your choice. The extracted folder will be referred to as `MG_HOME` here onwards.

    - This guide assumes that you have already started the WSO2 API Manager instance. If not, download the latest [release](https://github.com/wso2/product-apim/releases) and follow the steps [here](https://github.com/wso2/product-apim#installation--running).

### Step 1 - Find the APIM IP Address

In order to tell Microgateway where API Manager (APIM) is located, find out the IP that can be used to access the API Manager instance. If you are trying out WSO2 API Manager locally, the private IP retrived using `hostname -I` or `ipconfig` would do.

### Step 2 - Update the Microgateway Config File

Open the `<MGW_HOME>/resources/conf/config.toml` file in a text editor and update it as follows.

In the `[controlPlane.eventHub]` section,

 - set `enabled` to true
 - update `serviceUrl` with the IP and the port of API Manager
 - if you want to use a Gateway Environment other than the default, update `environmentLabels` with the name of the new Gateway Environment. If not, leave the default value `"Production and Sandbox"` as it is.

 Example
 ``` yaml
 [controlPlane.eventHub]
  enabled = true
  serviceUrl = "https://192.168.1.94:9443/"
  username="admin"
  password="$env{cp_admin_pwd}"
  environmentLabels = ["Production and Sandbox"]
  retryInterval = 5
  skipSSLVerification=true
  # Message broker connection URL of the control plane
  [controlPlane.eventHub.jmsConnectionParameters]
    eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'"]
 ``` 

!!! tip

    In API Manager, a new Gateway Environment can be created from the Admin Portal (available at `https:<apim-host>:<apim-port>/admin`) **Gateways** tab.

### Step 3 - Start the Microgateway

Now, let's start the microgateway. Navigate to `MG_HOME` and execute the following command.
    
``` bash
docker-compose up -d
```

### Step 4 - Create an API in API Manager

Follow the steps [here]({{base_path}}/design/create-api/create-a-rest-api/).

### Step 5 - Deploy the API in API Manager

 The guide [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api) will explain how you could easily deploy the API you just created.

That's it! To invoke the API follow the steps [here](#invoke-the-api).


During the startup, Microgateway will check the `config.toml` to see if the `controlPlane.eventHub` configuration has been enabled. If so, it will start fetching all the necessary artifacts that belongs to the gateway environment given in `environmentLabels`. These artifacts include deployed APIs, Applications, Subscriptions, Polices, information related to Key Managers, etc.

Whenever a new event occurs in API Manager such as an API being deployed, API Manager will notify Microgateway via Event Hub. Microgateway will then start fetching all the new artifacts related to its environment. 

!!! Note 

    You might find the following content useful here onwards,

    - [API Manager as Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/concepts/apim-as-control-plane) 
    - [Publish an API on the Developer Portal]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api)


## Via the CLI tool (apictl) 

!!! info
    **Before you begin**

    This guide assumes that you already have a Microgateway instance that is up and running. If not, checkout the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/getting-started/quick-start-guide/quick-start-guide-overview) on how to install and run Microgateway. To learn more about Microgateway, have a look at the [Overview of Microgateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/getting-started/api-microgateway-overview). 

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

### Step 3 - Add an Mcrogateway Environment to apictl

To use apictl for Microgateway, a Microgateway environment needs to be added to apictl. This environment will hold the adapter URL for further commands.

``` bash
apictl mg add env dev --adapter https://localhost:9843
```

!!! info

    Note `mg` in the above command. The apictl commands that starts as `apictl mg` are Microgateway specific. If a command does not have `mg` after `apictl` then the command could probably be common to both Microgateway and API Manager, but it could also be API Manager specific. 

!!! tip

    The apictl commands here onwards are executed with the -k flag to avoid SSL verification with the microgateway.

    To communicate via https without skipping SSL verification (without -k flag), add the cert in the Microgateway truststore into the `<USER_HOME>/.wso2apictl/certs` folder.

### Step 4 - Log in to the Microgateway Environment in apictl

You can use the following command to log in to the above Microgateway cluster (in other words log in to the Microgateway adapter). By logging in, an access token will be retrieved from Microgateway and saved in apictl.

``` bash
apictl mg login dev -k
```

or

``` bash
apictl mg login dev -u admin -p admin -k
```

### Step 5 - Deploy the API

Now let's deploy the API to Microgateway by executing the following command.

``` bash
apictl mg deploy api -f <path_to_the_API_project_just_created>/petstore -e dev -k
```

That's it!

!!! Note 

    Refer to the following content to learn more,

    - [Managing Microgateway with apictl]({{base_path}}/install-and-setup/setup/api-controller/managing-microgateways/managing-microgateways-with-ctl)
    - [API Microgateway as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/concepts/as-a-standalone-gateway)

## Invoke the API
{! ./includes/obtain-jwt.md !}
{! ./includes/invoke-api-with-jwt.md !}

<!-- brought the following here because the path becomes relative when included in the includes folder -->
Refer to [Generate a Test JWT]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/security/generate-a-test-jwt.md) for more details.

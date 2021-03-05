# Exposing APIs via Custom Hostnames

Virtual hosts (VHosts) enable you to expose APIs using specific hostnames that correspond to a Gateway environment. Each Gateway environment will have a minimum of one VHost. Admin users can manage Gateways by creating, updating, and deleting Gateway environments via the Admin Portal. Each Gateway environment will contain the details of each of the VHosts, which are the custom hostnames, that are applicable to that Gateway environment. As a result, API publishers can use the VHosts to group their APIs by selecting a virtual host when deploying an API to Gateway environment(s). In addition, application developers can access APIs by using the defined access URLs of the virtual host.

## Prerequisites

[Download and install WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/installing-the-product/).

## Step 1 - Create a Gateway environment

Each Gateway environment definition contains details related to a specific Gateway. You can create a Gateway environment that includes VHosts using either one of the following methods. 

!!! info
    The VHost does not have to be unique. Therefore, you can have multiple Gateway environments that have the same VHost.

### Create a Gateway environment via the Admin Portal

1. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/running-the-product/#starting-the-server).

2.  Sign in to the Admin Portal.
     
     `https://<hostname>:9443/admin` 
   
     Example: `https://localhost:9443/admin`

     Let's use `admin` as your username and password to sign in.

3.  Add a new Gateway Environment.

     1. Click **Gateways**, and then click **Add Gateway Environment**.

         [![Menu to add Microgateway label]({{base_path}}/assets/img/learn/add-gateway-environment-menu.png)]({{base_path}}/assets/img/learn/add-gateway-environment-menu.png)

     2. Enter a name, display name, description, and a virtual host.

         The virtual hosts will define each of the custom hostnames. It is mandatory to specify a VHost when you create a Gateway environment.

          | **Environment** | **Display Name** | **Description**                               | **Virtual Host** |
          |-------------|--------------|-------------------------------------------|--------------|
          | us-region   | US Region    | Gateway environment deployed in the US region. | us.wso2.com  |

          <a href="{{base_path}}/assets/img/learn/add-gateway-environment.png">
              <img src="{{base_path}}/assets/img/learn/add-gateway-environment.png" alt="Add a Gateway Environment"
              title="Add a Gateway Environment" width="500px" />
          </a>

     3. Optionally, click **Advanced Settings** to add a HTTP(S) context and custom ports.

         Let's add `food` as the HTTP(S) context for the `us-region` Gateway environment.

          Add another virtual host `foods.com` by clicking **New VHost** and click **Save** to save the environment.

### Create a Gateway environment using the configuration file

Follow the instructions below to use the `deployment.toml` file, which is the central configuration file, to configure a Gateway environment that consists of virtual hosts:

1. Open to the `<APIM-HOME>/repository/conf/deployment.toml` file.

2. Create a Gateway environment.

     Create a Gateway environment with the following Gateway configurations, which include `us.wso2.com` and `foods.com` as the custom VHosts and `food` as the custom context.

    !!! note

        - When the WSO2 API Manager server is running, the Gateway environments, which you added via the `deployment.toml` file, are displayed in the Gateway environments list page in the Admin Portal in read-only mode. 
        - Therefore, ensure to add the VHosts that correspond to the Gateway at the time of adding the Gateway environment itself.
        - If a VHost is not defined, the default VHost details are assigned to the Gateway environment.
        - It is not mandatory to specify a context for the VHost.

    ```toml
    [[apim.gateway.environment]]
    name = "us-region"
    display_name = "US Region"
    type = "hybrid"
    display_in_api_console = true
    description = "Gateway environment deployed in the US region."
    show_as_token_endpoint_url = true
    service_url = "https://localhost:${mgt.transport.https.port}/services/"
    username= "${admin.username}"
    password= "${admin.password}"
    ws_endpoint = "ws://localhost:9099"
    wss_endpoint = "wss://localhost:8099"
    http_endpoint = "http://localhost:${http.nio.port}/gateway"
    https_endpoint = "https://localhost:${https.nio.port}/gateway"

    [[apim.gateway.environment.virtual_host]]
    ws_endpoint = "ws://us.wso2.com:9099"
    wss_endpoint = "wss://us.wso2.com:8099"
    http_endpoint = "http://us.wso2.com/food"
    https_endpoint = "https://us.wso2.com/food"

    [[apim.gateway.environment.virtual_host]]
    ws_endpoint = "ws://foods.com:9099"
    wss_endpoint = "wss://foods.com:8099"
    http_endpoint = "http://foods.com"
    https_endpoint = "https://foods.com"
    ```

3. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/running-the-product/#starting-the-server).

## Step 2 - Assign the custom hostname to an API

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Repeat this step if you wish to add multiple APIs to the API group.</p>
</div> 
</html>

1.  Sign in to the API Publisher using `admin` as the username and password.

     `https://<hostname>:9443/publisher` 
   
     Example: `https://localhost:9443/publisher`

2.  Create a new API or skip this step if you wish to use an existing API.
     
     Let's deploy the sample Pizzashack API by clicking **Deploy Sample API** (If you have not done so already).

3.  Click on the API to edit its configurations.

     [![Edit the API]({{base_path}}/assets/img/learn/select-api.png)]({{base_path}}/assets/img/learn/select-api.png)

4.  Click **Deployments**.

5.  Select the newly created Gateway environment, Virtual Host, and a Revision.

     [Create a new revision]({{base_path}}/design/create-api/create-api-revisions/) if no revisions exist.

     [![Deploy API with Virtual Host in the Publisher]({{base_path}}/assets/img/learn/deploy-api-with-vhost.png)]({{base_path}}/assets/img/learn/deploy-api-with-vhost.png)

6. Click **Deploy** to attach the Virtual Host to the Pizzashack API.
   
    !!! info
        Similarly, you can assign the same Virtual Host to other APIs as well.

## Step 3 - View the custom hostnames

Follow the instructions below to view the custom endpoint URLs of the API, which consists of the custom hostnames:

1. Sign in to the Developer Portal using `admin` as the username and password.

     `https://<hostname>:9443/devportal` 
   
     Example: `https://localhost:9443/devportal`

2. Click on the specific API.

3. Click **Overview**.

     The custom endpoint URLs of the API, which include the custom hostnames, appear.

     [![Virtual host in the Developer Portal]({{base_path}}/assets/img/learn/virtual-host-in-devportal.png)]({{base_path}}/assets/img/learn/virtual-host-in-devportal.png)

## See Also

- [Publish through Multiple API Gateways]({{base_path}}/deploy/deploy-api/publish-through-multiple-api-gateways/) to understand how to work with multiple Gateway environments that use custom hostnames. 

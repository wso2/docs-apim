# Exposing APIs via Custom Hostnames

Virtual hosts (VHosts) enable you to expose APIs using specific hostnames that correspond to a Gateway environment. Each Gateway environment will have a minimum of one VHost. Admin users can manage Gateways by creating, updating, and deleting Gateway environments via the Admin Portal. Each Gateway environment will contain the details of each of the VHosts, which are the custom hostnames, that are applicable to that Gateway environment. As a result, API publishers can use the VHosts to group their APIs by selecting a virtual host when deploying an API to Gateway environment(s). In addition, application developers can access APIs by using the defined access URLs of the virtual host.

## Using an existing Gateway environment to expose APIs via custom hostnames

Follow the instructions below to use the default Gateway environment to expose APIs via custom hostnames:

### Step 1 - Define the custom hostnames

Each Gateway environment definition contains details related to a specific Gateway. Define the VHosts, which contain the custom hostnames in the `deployment.toml` file, which is the central configuration file.

1. Open to the `<APIM-HOME>/repository/conf/deployment.toml` file.

2. Define the VHosts.

     Let's add `us.wso2.com` and `foods.com` as the custom VHosts and `food` as the custom context.

    !!! note

        - When the WSO2 API Manager server is running, the default Gateway environment and also the Gateway environments that you added via the `deployment.toml` file are displayed in the Gateway environments list page in the Admin Portal in read-only mode.
        - If a VHost is not defined, the default VHost details are assigned to the Gateway environment.
        - It is not mandatory to specify a context for the VHost.

    ```toml
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    ...
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
    http_endpoint = "http://localhost:${http.nio.port}"
    https_endpoint = "https://localhost:${https.nio.port}"

    [[apim.gateway.environment.virtual_host]]
    ws_endpoint = "ws://us.wso2.com:9099"
    wss_endpoint = "wss://us.wso2.com:8099"
    http_endpoint = "http://us.wso2.com/gateway"
    https_endpoint = "https://us.wso2.com/gateway"

    [[apim.gateway.environment.virtual_host]]
    ws_endpoint = "ws://foods.com:9099"
    wss_endpoint = "wss://foods.com:8099"
    http_endpoint = "http://foods.com:8280"
    https_endpoint = "https://foods.com:8243"
    ```

3. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

      This will start WSO2 API Manager in the all-in-one mode, which includes the default Gateway as well.

### Step 2 - Assign the custom hostname to an API

{!includes/deploy/assign-custom-hostname.md!}

[![Deploy API with Virtual Host in the Publisher]({{base_path}}/assets/img/deploy/deploy-api-with-vhost.png)]({{base_path}}/assets/img/deploy/deploy-api-with-vhost.png)


### Step 3 - View the custom hostnames

{!includes/deploy/view-custom-hostname.md!}

[![Virtual host in the Developer Portal]({{base_path}}/assets/img/deploy/virtual-host-in-devportal.png)]({{base_path}}/assets/img/deploy/virtual-host-in-devportal.png)


## Using a new Gateway environment to expose APIs via custom hostnames

Follow the instructions below to use a new custom Gateway environment to expose APIs via custom hostnames:

### Step 1 - Create a Gateway environment

Each Gateway environment definition contains details related to a specific Gateway. You can create a Gateway environment that includes VHosts using either one of the following methods.

#### Create a Gateway environment via the Admin Portal

1. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

      This will start WSO2 API Manager in the all-in-one mode, which includes the default Gateway as well.

2.  Sign in to the Admin Portal.
     
     `https://<hostname>:9443/admin` 
   
     Example: `https://localhost:9443/admin`

     Let's use `admin` as your username and password to sign in.

3.  Add a new Gateway Environment.

     1. Click **Gateways**, and then click **Add Gateway Environment**.

         [![Menu to add Gateway environment]({{base_path}}/assets/img/deploy/add-gateway-environment-menu.png)]({{base_path}}/assets/img/deploy/add-gateway-environment-menu.png)

     2. Enter a name, display name, description, and a virtual host.

         The virtual hosts will define each of the custom hostnames. It is mandatory to specify a VHost when you create a Gateway environment.

          | **Environment** | **Display Name** | **Description**                               | **Virtual Host** |
          |-------------|--------------|-------------------------------------------|--------------|
          | us-region   | US Region    | Gateway environment deployed in the US region. | us.wso2.com  |

          <a href="{{base_path}}/assets/img/deploy/add-gateway-environment.png">
              <img src="{{base_path}}/assets/img/deploy/add-gateway-environment.png" alt="Add a Gateway Environment"
              title="Add a Gateway Environment" width="500px" />
          </a>
          
     3. Optionally, click **Advanced Settings** to add a HTTP(S) context and custom ports.

          <a href="{{base_path}}/assets/img/deploy/vhost-advanced-settings.png">
              <img src="{{base_path}}/assets/img/deploy/vhost-advanced-settings.png" alt="Advanced VHost settings"
              title="Advanced VHost settings" width="500px" />
          </a>

        !!! note
            You can change the ports of each protocol of the Virtual Host and add an optional HTTP(s) context.

        Let's add `gateway` as the HTTP(S) context for the Virtual Host `us.wso2.com`.

        Add another virtual host `foods.com` by clicking **New VHost** and click **Save** to save the environment.

#### Create a Gateway environment using the configuration file

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
    http_endpoint = "http://localhost:${http.nio.port}"
    https_endpoint = "https://localhost:${https.nio.port}"

    [[apim.gateway.environment.virtual_host]]
    ws_endpoint = "ws://us.wso2.com:9099"
    wss_endpoint = "wss://us.wso2.com:8099"
    http_endpoint = "http://us.wso2.com/gateway"
    https_endpoint = "https://us.wso2.com/gateway"

    [[apim.gateway.environment.virtual_host]]
    ws_endpoint = "ws://foods.com:9099"
    wss_endpoint = "wss://foods.com:8099"
    http_endpoint = "http://foods.com:8280"
    https_endpoint = "https://foods.com:8243"
    ```

3. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

      This will start WSO2 API Manager in the all-in-one mode, which includes the default Gateway as well.

### Step 2 - Start the second Gateway

Extract WSO2 API Manager to a new directory. Let's refer to this directory as `APIM-HOME-2`.

1. Open the `<APIM-HOME-2>/repository/conf/deployment.toml` file.

2. Set the port offset in the `server` section.

    ```toml
    [server]
    hostname = "localhost"
    node_ip = "127.0.0.1"
    offset = 3
    ```

2. Assign the Gateway environment label `us-region`, which is the name of the Gateway environment that you previously created.

    ```toml
    [apim.sync_runtime_artifacts.gateway]
    gateway_labels = ["us-region"]
    ```

3. Update the Traffic Manager configurations of the second server to connect to the Traffic Manager deployed with the first server. 

    ```toml
    [apim.throttling]
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://localhost:9443/services/"
    throttle_decision_endpoints = ["tcp://localhost:5672","tcp://localhost:5672"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://localhost:9611"]
    traffic_manager_auth_urls = ["ssl://localhost:9711"]
    ```

4. Save and close the `<APIM-HOME-2>/repository/conf/deployment.toml` file. 

5. [Start the second WSO2 API Manager server](({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server)).

### Step 3 - Assign the custom hostname to an API

{!includes/deploy/assign-custom-hostname.md!}

[![Deploy API with Virtual Host in the Publisher]({{base_path}}/assets/img/deploy/deploy-api-with-vhost.png)]({{base_path}}/assets/img/deploy/deploy-api-with-vhost.png)

### Step 4 - View the custom hostnames

{!./includes/deploy/view-custom-hostname.md!}

[![Virtual host in the Developer Portal]({{base_path}}/assets/img/deploy/virtual-host-in-devportal.png)]({{base_path}}/assets/img/deploy/virtual-host-in-devportal.png)

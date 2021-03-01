# Grouping APIs with Virtual Hosts

Virtual hosts enables you to expose APIs using different host names while serving a gateway on a single server
(or pool of servers). This enables publishers to group your APIs by selecting a virtual host. Application developers
can access APIs by using the defined access URLs of the virtual host.

## Step 1 - Create an Environment and a Virtual Host

1.  Sign in to the Admin Portal.
     
     `https://<hostname>:9443/admin` 
   
     Example: `https://localhost:9443/admin`

     Let's use `admin` as your username and password to sign in.

2.  Add a new Gateway Environment.

     1. Click **Gateways**, and then click **Add Gateway Environment**.
         [![Menu to add Microgateway label]({{base_path}}/assets/img/learn/add-gateway-environment-menu.png)]({{base_path}}/assets/img/learn/add-gateway-environment-menu.png)

         Environments configured in `<APIM-HOME>/repository/conf/deployment.toml` are also displayed in this page with
         read only mode while the server is running. Virtual hosts can be configured for these environments with adding
         the configuration `apim.gateway.environment.virtual_host` for the environment configured with
         `apim.gateway.environment` in the `<APIM-HOME>/repository/conf/deployment.toml` as follows.

         ```toml
          [[apim.gateway.environment]]
          name = "Production and Sandbox"
          ...
          [[apim.gateway.environment.virtual_host]]
          ws_endpoint = "ws://mg.wso2.com:9099"
          wss_endpoint = "wss://mg.wso2.com:8099"
          http_endpoint = "http://mg.wso2.com/gateway"
          https_endpoint = "https://mg.wso2.com/gateway"
         ```

     2. Enter a name, display name, description and a virtual host.

          | Environment | Display Name | Description                               | Virtual Host |
          |-------------|--------------|-------------------------------------------|--------------|
          | us-region   | US Region    | Gateway environment deployed in US region | us.wso2.com  |

          <a href="{{base_path}}/assets/img/learn/add-gateway-environment.png">
              <img src="{{base_path}}/assets/img/learn/add-gateway-environment.png" alt="Add a Gateway Environment"
              title="Add a Gateway Environment" width="500px" />
          </a>

          Add another virtual host `foods.com` by clicking **New VHost** and save the environment by clicking **Save** button.

## Step 2 - Assign the Virtual Host to an API

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

5.  Select the newly created Gateway environment, Virtual Host and a Revision (create a new revision if there are no revisions).

     [![Deploy API with Virtual Host in the Publisher]({{base_path}}/assets/img/learn/deploy-api-with-vhost.png)]({{base_path}}/assets/img/learn/deploy-api-with-vhost.png)

6. Click **Deploy** to attach Virtual Host to the Pizzashack API.
   
     Similarly, you can assign the same Virtual Host for other APIs as well.

## Step 3 - View the Virtual Host

1. Sign in to the Developer Portal using `admin` as the username and password.

     `https://<hostname>:9443/devportal` 
   
     Example: `https://localhost:9443/devportal`

2. Click on the specific API.

3. Click **Overview**.

     The Virtual Hosts, which are attached to the API, appear.

     [![Virtual host in the Developer Portal]({{base_path}}/assets/img/learn/virtual-host-in-devportal.png)]({{base_path}}/assets/img/learn/virtual-host-in-devportal.png)

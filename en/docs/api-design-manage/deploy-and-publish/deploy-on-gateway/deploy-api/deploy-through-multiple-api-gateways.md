# Publish Through Multiple API Gateways

If you need to distribute the Gateway load that comes in, you can configure multiple API Gateway environments in WSO2 API Manager to publish to a single Developer Portal. This helps you to distribute the API Gateway load to multiple nodes and also gives you some logical separation (e.g., production vs. sandbox) between the APIs in the Developer Portal. When you publish an API through multiple Gateway environments, the APIs in the API Developer Portal will have different server hosts and ports.

In the following guide, let's set up three (3) WSO2 API Manager (WSO2 API-M) instances on the same server. 

-   **Instance 1** : Acts as the node that provides the Control Plane functionality, such as the Publisher, Developer Portal, and the Key Manager functionality.
-   **Instance 2** : Acts as a production Gateway node.
-   **Instance 3** : Acts as a sandbox Gateway node.

!!! note

    In a typical production environment, the Gateways will ideally be in separate servers.

## Step 1 - Configure the Control Plane

Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the **first** API Manager instance, add two API Gateway environments by adding two `[[apim.gateway.environment]]` sections and comment out the `[[apim.gateway.environment]]` section that comes by default.
     
 This is done to point to the two API Gateway instances from the first instance.

!!! note

    -   There can be different types of environments, and the allowed values are `hybrid`,`production`, and `sandbox`.

    -   An API deployed on a `production` type Gateway will only support production keys.
    -   An API deployed on a `sandbox` type Gateway will only support sandbox keys.
    -   An API deployed on a `hybrid` type Gateway will support both production and sandbox keys.
    -   The `api-console` element specifies whether the environment should be listed in API Console or not.
    -   The Gateway environment names must be unique.

**Example**

```toml
[[apim.gateway.environment]]
name = "Production Gateway"
type = "production"
display_in_api_console = true
description = "Production Gateway Environment"
show_as_token_endpoint_url = true
service_url = "https://localhost:9444/services/"
username= "admin"
password= "admin"
http_endpoint = "http://localhost:8281"
https_endpoint = "https://localhost:8244"

[[apim.gateway.environment]]
name = "Default"
type = "hybrid"
display_in_api_console = true
description = "Hybrid Gateway Environment"
show_as_token_endpoint_url = true
service_url = "https://localhost:9445/services/"
username= "admin"
password= "admin"
http_endpoint = "http://localhost:8282"
https_endpoint = "https://localhost:8245"
```

!!! tip
        If you have multiple Gateways that support one type of key (e.g., when there are two Gateways that support the production keys, as seen in the above code snippet), the environments you add via the `<API-M_HOME>/repository/conf/deployment.toml` file will be visible in a drop-down list of the API **Try Out** tab, which is in the Developer Portal of instance 1. This allows subscribers to send API requests to any selected Gateway.

[![API tryout tab]({{base_path}}/assets/img/learn/devportal-tryout-multiple-gateways.png)]({{base_path}}/assets/img/learn/devportal-tryout-multiple-gateways.png)

!!! note
    To stop a given Gateway environment from being displayed in the API Try Out tab, you can set the `display_in_api_console` attribute to `false` in the `apim.gateway.environment` element, which is in the `deployment.toml` file.

    **Example**

    ``` toml
    [[apim.gateway.environment]]
    display_in_api_console = false
    ```

## Step 2 - Configure the two Gateway nodes

As mentioned above, the **second and the third** instances will serve as the Gateway instances.

### Step 2.1 - Configure port offset

!!! note
    This is only applicable when all three instances are running on the same server.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the **second** API Manager instance, and add an offset of 1 to its default port. 
     This increments its default server port, which is 9443, by 1.

    ``` toml
    [server]
    offset=1
    ```

2.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the **third** API Manager instance and add an offset of 2 to its default port. 

     This increments its default server port, which is 9443, by 2.

    ``` toml
    [server]
    offset=2
    ```

### Step 2.1 - Configure the Gateway instances

Carry out the following instructions in the **second** and the **third** instances to configure the Gateway instances so that it can communicate with the Control Plane node:

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway node.

2.  Add the following configurations to the `deployment.toml` file.

    -   Connecting the Gateway to the Key Manager component in the Control Plane:

        === "Control Plane with HA"
            ``` toml
            [apim.key_manager]
            service_url = "https://[control-plane-LB-host]/services/"
            username = "$ref{super_admin.username}"
            password = "$ref{super_admin.password}"                
            ```
        
        === "Single Control Plane"
            ``` toml
            [apim.key_manager]
            service_url = "https://[control-plane-host]:${mgt.transport.https.port}/services/"
            username = "$ref{super_admin.username}"
            password = "$ref{super_admin.password}"
            ```

    -   Connecting the Gateway to the Traffic Manager component in the Control Plane:

        === "Control Plane with HA"
            ``` toml
            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://control-plane-1-host:9611"]
            traffic_manager_auth_urls = ["ssl://control-plane-1-host:9711"]
            
            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://control-plane-2-host:9611"]
            traffic_manager_auth_urls = ["ssl://control-plane-2-host:9711"]
            
            [apim.throttling]
            service_url = "https://[Traffic-Manager-LB-Host]/services/"
            throttle_decision_endpoints = ["tcp://control-plane-1-host:5672", "tcp://control-plane-2-host:5672"]
            ```
            
        === "Single Control Plane"
            ``` toml
            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://control-plane-host:9611"]
            traffic_manager_auth_urls = ["ssl://control-plane-host:9711"]
            
            [apim.throttling]
            service_url = "https://control-plane-host:${mgt.transport.https.port}/services/"
            throttle_decision_endpoints = ["tcp://control-plane-host:5672"]
            ```     

3.  Add the following configurations to the `deployment.toml` file to configure the Gateway environment.

     Change the `gateway_labels` property based on your Gateway environment.
   
     ```toml
     [apim.sync_runtime_artifacts.gateway]
     gateway_labels =["Default"]
     ```  

4.  Enable JSON Web Token (JWT) if required.

     For instructions, see [Generating JSON Web Token]({{base_path}}/manage-apis/deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway/).   
     
5.  Add the public certificate of the private key (that is used for signing the tokens) to the truststore under the `"gateway_certificate_alias"` alias. 
    
    For instructions, see [Create and import SSL certificates]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores).

     <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>This is not applicable if you use the default certificates, which are the certificates that are shipped with the product itself. </p>
      </div> 
     </html>
     
6.  Follow the steps given below to configure High Availability (HA) for the API-M Gateway:

    1.  Create a copy of the API-M Gateway node that you just configured. This is the second node of the API-M Gateway cluster.
    2.  Configure a load balancer fronting the two Gateway nodes in your deployment.
                
        For instructions, see [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer/).

        !!! Note
        
            To keep custom runtime artifacts deployed in the Gateway, add the following configuration in the <API-M_HOME>/repository/conf/deployment.toml file of the Gateway nodes.  

            ```toml
            [apim.sync_runtime_artifacts.gateway.skip_list]
            apis = ["api1.xml","api2.xml"]
            endpoints = ["endpoint1.xml"]
            sequences = ["post_with_nobody.xml"]
            local-entries = ["file.xml"]
            ```

    3.  Open the `deployment.toml` files of each Gateway node and add the cluster hostname. 
          
          For example, if the hostname is `gw.am.wso2.com`:
    
          ``` toml
          [server]
          hostname = "gw.wso2.com"
          ```
          
    4.  Specify the following incoming connection configurations in the `deployment.toml` files of both nodes.
      
          ``` toml
          [transport.http]
          properties.port = 9763
          properties.proxyPort = 80
          
          [transport.https]
          properties.port = 9443
          properties.proxyPort = 443
          ```
      
    5.  Open the server's `/etc/hosts` file and map the hostnames to IPs.
    
        === "Format"
            ```java
            <GATEWAY-IP> gw.wso2.com
            ```
    
        === "Example"
            ``` java
            xxx.xxx.xxx.xx4 gw.wso2.com
            ``` 

??? info "Sample configuration for the Gateway"
    ```toml
    [server]
    hostname = "gw.wso2.com"
    node_ip = "127.0.0.1"
    server_role = "gateway-worker"
    offset=4
    
    [user_store]
    type = "database_unique_id"
            
    [super_admin]
    username = "admin"
    password = "admin"
    create_admin_account = true
    
    [database.shared_db]
    type = "mysql"
    hostname = "db.wso2.com"
    name = "shared_db"
    port = "3306"
    username = "root"
    password = "root"
    
    [keystore.tls]
    file_name =  "wso2carbon.jks"
    type =  "JKS"
    password =  "wso2carbon"
    alias =  "wso2carbon"
    key_password =  "wso2carbon"
    
    [truststore]
    file_name = "client-truststore.jks"
    type = "JKS"
    password = "wso2carbon"
    
    [apim.key_manager]
    service_url = "https://km.wso2.com:9443/services/"
    
    [apim.throttling]
    service_url = "https://tm.wso2.com:9446/services/"
    throttle_decision_endpoints = ["tcp://tm.wso2.com:5675"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm.wso2.com:9614"]
    traffic_manager_auth_urls=["ssl://tm.wso2.com:9714"]
    
    [apim.cors]
    allow_origins = "*"
    allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
    allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction"]
    allow_credentials = false

    [apim.sync_runtime_artifacts.gateway]
    gateway_labels =["Default"]
    ```

## Step 3 - Start the instances

Start all the WSO2 API-M instances.

Make sure to start instance 1 first before starting the other two instances.

## Step 4 - Publish an API via Multiple API Gateways

1.  Sign in to the API Publisher in the **first** WSO2 API-M instance and click to edit an API.

2.  Click **Deployments** and click **Deploy New Revision**.

    <a href="{{base_path}}/assets/img/learn/api-revisions-mutiple-gateways.png"><img src="{{base_path}}/assets/img/learn/api-revisions-mutiple-gateways.png" title="API Revisions Multiple Gateways" width="80%" alt="API Revisions Multiple Gateways"/></a>
    
    Note that the two Gateway environments are listed there.

    <a href="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog.png"><img src="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog.png" title="Multiple Gateways Dialog" width="40%" alt="Multiple Gateways Dialog"/></a>

    Here you have the option to view the visibility permissions set for each Gateway environment. Click on the permission type to view the allowed/denied roles.

    <a href="{{base_path}}/assets/img/learn/api-gateway-visibility-permissions.png"><img src="{{base_path}}/assets/img/learn/api-gateway-visibility-permissions.png" title="API Gateway Visibility Permissions" width="80%" alt="API Gateway Visibility Permissions"/></a>

3.  Select both Gateways and click deploy.

    <a href="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog-filled.png"><img src="{{base_path}}/assets/img/learn/multiple-gateways-revision-dialog-filled.png" title="Filled Multiple Gateways Dialog" width="40%" alt="Filled Multiple Gateways Dialog"/></a>

4.  Sign in to the Developer Portal (of the **first** instance) and click on the respective API to open it.

    In the **Overview** tab that corresponds to the API, note that it has two sets of URLs for the two Gateway instances:

    <a href="{{base_path}}/assets/img/learn/multiple-gateways-devportal-overview.png"><img src="{{base_path}}/assets/img/learn/multiple-gateways-devportal-overview.png" title="Multiple Gateways Deploy Overview" width="50%" alt="Multiple Gateways Deploy Overview"/></a>

You have successfully published an API to the API Developer Portals through multiple Gateway environments.

## Step 5 - Generated the keys for the applications

Use the following sample cURL command to generate an access token for the Gateway URL of the initially published Gateway Environments, which was listed in API Publisher in step 10, using the Password Grant type.

<a href="{{base_path}}/assets/img/learn/generate-access-tokens.png"><img src="{{base_path}}/assets/img/learn/generate-access-tokens.png" title="Generate Access Token" width="55%" alt="Generate Access Token"/></a>

Change the Gateway URL based on the Gateway that you need to publish the API.


!!! note
    If you wish to use the API-M pack that you used as the first instance to try-out other tutorials, please ensure to delete the API Gateway configurations that you added in step 2.1, and uncomment the default `[[apim.gateway.environment]]` configurations in the `<API-M_HOME>/repository/conf/deployment.toml` file.

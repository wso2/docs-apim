# Configuring a Distributed API-M Deployment

Follow the instructions below to set up a distributed API-M deployment. You can use this set up for for simple scalable deployment of WSO2 API Manager. 

API-M nodes in a distributed deployment:

<table>
    <tr>
        <th>
            API-M Node (Profile)
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            Gateway Worker Nodes
        </td>
        <td>
            Two API-M nodes running the Gateway profile.
        </td>
    </tr>
    <tr>
        <td>
            Control Plane Nodes
        </td>
        <td>
            Two API-M nodes running the Control Plane profile. The control plan includes the Traffic Manager, Key Manager, Publisher, and Developer Portal components.
        </td>
    </tr>
    <tr>
        <td>
            Traffic Manager Node (Optional)
        </td>
        <td>
            If required you can configure a separate API-M node as to run the Traffic Manager component. That is, the control plane nodes will run the Key Manager, Publisher, and Developer Portal, while the Traffic Manager runs on a separate node.
        </td>
    </tr>
</table>

## Step 1 - Install and configure WSO2 API-M

1.  Download the [WSO2 API Manager](http://wso2.com/products/api-manager/).
2.  Create copies of the API-M distribution and name them by profile name.

## Step 2 - Install and configure the databases

You can create the required databases for the API-M deployment in a separate server and point to the databases from the respective nodes. For information on configuring the databases, see [Installing and Configuring the Databases]({{base_path}}/install-and-setup/setting-up-databases/overview/).

## Step 3 - Configure your deployment with production hardening

Ensure that you have taken into account the respective security hardening factors (e.g., changing and encrypting the default passwords, configuring JVM security, etc.) before deploying WSO2 API-M. For more information, see [Production Deployment Guidelines]({{base_path}}/install-and-setup/deploying-wso2-api-manager/production-deployment-guidelines/#common-guidelines-and-checklist).

## Step 4 - Create and import SSL certificates

Create an SSL certificate for each of the WSO2 API-M nodes and import them to the keystore and the truststore. This ensures that hostname mismatch issues in the certificates will not occur. 

For more information, see [Creating SSL Certificates]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/creating-new-keystores/).

!!! Note
    The same primary keystore should be used for all API Manager instances in order to decrypt the registry resources. For more information, see [Configuring the Primary Keystore]({{base_path}}/administer/product-security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#configuring-the-primary-keystore).

## Step 5 - Configure API-M Analytics

API Manager Analytics is delivered via the API Manager Analytics cloud solution. You need to configure the API Manager Gateway to publish analytics data to the cloud.

See the instructions on [configuring the API Gateway]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-synapse-gateway) with the cloud-based analytics solution.

## Step 6 - Configure and start the profiles

Let's configure the API-M nodes in the deployment.

### Configure the Gateway nodes

Follow the steps given below to configure the Gateway nodes to communicate with the Control Plane nodes.

<a href="{{base_path}}/assets/img/setup-and-install/gateway-connections.png"><img src="{{base_path}}/assets/img/setup-and-install/gateway-connections.png" width=600></a>

1.  **If you need to configure High Availability (HA) for the Gateway nodes**, follow the instructions given below.

      1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file and locate the `<HostName>` tag to add the cluster hostname. 
          
          For example, if the hostname is `gw.am.wso2.com` -
    
          ``` toml
          [server]
          hostname = "gw.wso2.com"
          ```
          
      2.  Specify the following incoming connection configurations in the same `deployment.toml` file.
      
          ``` toml
          [transport.http]
          properties.port = 9763
          properties.proxyPort = 80
          
          [transport.https]
          properties.port = 9443
          properties.proxyPort = 443
          ```
      
      3.  Open the server's `/etc/hosts` file and map the hostnames to IPs.
      
          ```java tab="Format"
          <GATEWAY-IP> gw.wso2.com
          ```
      
          ``` java tab="Example"
          xxx.xxx.xxx.xx4 gw.wso2.com
          ```   
                                                                
2.  Modify the `<API-M_HOME>/repository/conf/deployment.toml` file in the Gateway node to configure the connection to the Key Manager component in the Control Plane profile.

    -   Connecting the Gateway to the Key Manager component

        ``` toml tab="Key Managers with HA"
        [apim.key_manager]
        service_url = "https://[Key-Manager-LB-host]/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"                
        ```
        
        ``` toml tab="Single Key Manager"
        [apim.key_manager]
        service_url = "https://[Key-Manager-host]:${mgt.transport.https.port}/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"
        ```

    -   Connecting the Gateway to the Traffic Manager component

        ``` toml tab="Traffic Manager with HA"
        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://Traffic-Manager-1-host:9611"]
        traffic_manager_auth_urls = ["ssl://Traffic-Manager-1-host:9711"]
        
        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://Traffic-Manager-2-host:9611"]
        traffic_manager_auth_urls = ["ssl://Traffic-Manager-2-host:9711"]
        
        [apim.throttling]
        service_url = "https://[Traffic-Manager-LB-Host]/services/"
        throttle_decision_endpoints = ["tcp://Traffic-Manager-1-host:5672", "tcp://Traffic-Manager-2-host:5672"]
        ```
        
        ``` toml tab="Single Traffic Manager"
        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://Traffic-Manager-host:9611"]
        traffic_manager_auth_urls = ["ssl://Traffic-Manager-host:9711"]
        
        [apim.throttling]
        service_url = "https://Traffic-Manager-host:${mgt.transport.https.port}/services/"
        throttle_decision_endpoints = ["tcp://Traffic-Manager-host:5672"]
        ```     

3.  Modify the `<API-M_HOME>/repository/conf/deployment.toml` file in the Gateway node to setup the environment name.
   
     ``` toml tab="Single Traffic Manager"
     [apim.sync_runtime_artifacts.gateway]
     gateway_labels =["Production and Sandbox"]
     ```  

4.  If you need to enable JSON Web Token (JWT), you have to enable it in all the Gateway nodes.

     For more information on configuring JWT, see [Generating JSON Web Token]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/passing-end-user-attributes-to-the-backend/passing-enduser-attributes-to-the-backend-using-jwt/).   
     
5.  The public certificate of the private key that is used to sign the tokens should be added to the trust store under the `"gateway_certificate_alias"` alias. For more information on importing certificates, see [Create and import SSL certificates](#step-4-create-and-import-ssl-certificates).

     <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>This is not applicable if you use the default certificates, which are the certificates that are shipped with the product itself. </p>
      </div> 
     </html>
     
6.  If Gateways are configured for High Availability (HA), use a copy of the active instance configured above as the second active Gateway instance and configure a load balancer fronting the two Gateway instances.
                
    For information on configuring the load balancer, see [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-the-proxy-server-and-the-load-balancer/)

    !!! note
    
        In order to keep custom runtime artifacts deployed in the Gateway, add the following configuration in the <API-M_HOME>/repository/conf/deployment.toml file of the Gateway node.  

        ```toml
        [apim.sync_runtime_artifacts.gateway.skip_list]
        apis = ["api1.xml","api2.xml"]
        endpoints = ["endpoint1.xml"]
        sequences = ["post_with_nobody.xml"]
        local-entries = ["file.xml"]
        ```

7.  Start the Gateway node(s) by running the following command in the command prompt. 
    
     For more information on starting a WSO2 server, see [Starting the server]({{base_path}}/install-and-setup/installation-guide/running-the-product/#starting-the-server).

    ``` java tab="Linux/Mac OS"
    cd <API-M_HOME>/bin/
    sh api-manager.sh -Dprofile=gateway-worker
    ```
    
    ``` java tab="Windows"
    cd <API-M_HOME>\bin\
    api-manager.bat --run -Dprofile=gateway-worker
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
    gateway_labels =["Production and Sandbox"]
    ```

### Configure the Control Plane profile

1.  This configuration enables API publishing to the Gateway environments.

    ``` toml
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    type = "hybrid"
    display_in_api_console = true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    show_as_token_endpoint_url = true
    ```

2.  Configure the Developer Portal with the Gateway.  
           
    ``` toml tab="Gateway with HA"
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    type = "hybrid"
    display_in_api_console = true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    show_as_token_endpoint_url = true
    ws_endpoint = "ws://[API-Gateway-LB-Host-or-IP]:9099"
    wss_endpoint = "wss://[API-Gateway-LB-Host-or-IP]:8099"
    http_endpoint = "http://[API-Gateway-LB-Host]"
    https_endpoint = "https://[API-Gateway-LB]"
    ```

    ``` toml tab="Single Gateway"
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    type = "hybrid"
    display_in_api_console = true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    show_as_token_endpoint_url = true
    ws_endpoint = "ws://[API-Gateway-host-or-IP]:9099"
    wss_endpoint = "wss://[API-Gateway-host-or-IP]:8099"
    http_endpoint = "http://[API-Gateway-host-or-IP]:${http.nio.port}"
    https_endpoint = "https://[API-Gateway-host-or-IP]:${https.nio.port}"
    ```

3.  Optionally, add the following configuration to enable distributed cache invalidation within the Publisher nodes.

    ``` toml
    [apim.cache_invalidation]
    enabled = true
    domain = "publisher-domain"
    ```

4.  Configure the Control Plane nodes in the deployment to the load balancer.
                
    See [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-the-proxy-server-and-the-load-balancer/) for instructions.

### Configure a separate Traffic Manager profile (Optional)

Optionally, you can separate the Traffic Manager from the Control Plane. In this scenario, you need to apply the following configurations:

-   The Traffic Manager nodes should communicate with the Control Plane nodes.
-   The Key Manager, Publisher, and Developer Portal components in the Control Plane should communicate with the Traffic Manager.

<a href="{{base_path}}/assets/img/setup-and-install/traffic-manager-connections.png"><img src="{{base_path}}/assets/img/setup-and-install/traffic-manager-connections.png" width="500"></a>

-   Configure the Traffic Manager nodes

    1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Traffic Manager node and change as following to point to Key Manager node in the Control Plane.

        ``` toml tab="Key Manager with HA"
        [apim.key_manager]
        service_url = "https://[Key-Manager-LB-host]/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"
        ```
            
        ``` toml tab="Single Key Manager"
        [apim.key_manager]
        service_url = "https://[Key-Manager-host]:${mgt.transport.https.port}/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"
        ```

    2.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Traffic Manager node and change the following to configure the Gateway Environments.

        ``` toml
        [[apim.gateway.environment]]
        name = "Production and Sandbox"
        type = "hybrid"
        ```

    3. Optionally, configure High Availability (HA) for the Traffic Manager.

        1.  Use a copy of the existing Traffic Manager instance as the second Traffic Manager active instance and configure a load balancer fronting the two Traffic Manager instances.

        2.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Traffic Manager node and add the following configuration to publish events to the other node.

    
            ``` toml tab="Node1"
            [apim.throttling]
            event_duplicate_url = ["tcp://Traffic-Manager-2-host:5672"]
            ```
            
            ``` toml tab="Node2"
            [apim.throttling]
            event_duplicate_url = ["tcp://Traffic-Manager-1-host:5672"]
            ```
            
        !!! note
            In each startup of a Traffic Manager node, the rate limiting policies are redeployed by retrieving the latest policy details from the database. This maintains the consistency between the Traffic Manager nodes. If you need to avoid redeploying certain rate limiting policies, add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file in the Traffic Manager node.  
                
            ```toml
            [apim.throttling]
            skip_redeploying_policies = ["throttle_policy_1","throttle_policy_2"]
            ```                   

    3.  Start the WSO2 API-M Traffic Manager node(s) by running the following command in the command prompt. 

        For more information on starting a WSO2 server, see [Starting the server]({{base_path}}/install-and-setup/installation-guide/running-the-product/#starting-the-server).

        ``` java tab="Linux/Mac OS"
        cd <API-M_HOME>/bin/
        sh api-manager.sh -Dprofile=traffic-manager
        ```

        ``` java tab="Windows"
        cd <API-M_HOME>\bin\
        api-manager.bat --run -Dprofile=traffic-manager
        ```

    ??? info "Sample configuration for the Traffic Manager"
        ``` toml
        [server]
        hostname = "tm.wso2.com"
        node_ip = "127.0.0.1"
        server_role = "traffic-manager"
        offset=3
        
        [user_store]    
        type = "database"
        
        [super_admin]
        username = "admin"
        password = "admin"
        create_admin_account = true
        
        [database.apim_db]
        type = "mysql"
        hostname = "db.wso2.com"
        name = "apim_db"
        port = "3306"
        username = "root"
        password = "root"

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
        username= "$ref{super_admin.username}"
        password= "$ref{super_admin.password}"

        [[apim.gateway.environment]]
        name = "Production and Sandbox"
        type = "hybrid"
        ```

-   Control Plane configs

    Key Manager configs

    1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Key Manager node and make the following changes to point to the Traffic Manager nodes.
 
 
     ``` toml tab="Traffic Manager with HA"
     [apim.throttling]
     throttle_decision_endpoints = ["tcp://Traffic-Manager-1-host:5672","tcp://Traffic-Manager-2-host:5672"]
     
     [[apim.throttling.url_group]]
     traffic_manager_urls = ["tcp://Traffic-Manager-1-host:9611"]
     traffic_manager_auth_urls = ["ssl://Traffic-Manager-1-host:9711"]
     
     [[apim.throttling.url_group]]
     traffic_manager_urls = ["tcp://Traffic-Manager-2-host:9611"]
     traffic_manager_auth_urls = ["ssl://Traffic-Manager-2-host:9711"]

     [[event_listener]]
     id = "token_revocation"
     type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
     name = "org.wso2.is.notification.ApimOauthEventInterceptor"
     order = 1

     [event_listener.properties]
     notification_endpoint = "https://[Traffic-Manager-LB-Host]/internal/data/v1/notify"
     username = "${admin.username}"
     password = "${admin.password}"
     'header.X-WSO2-KEY-MANAGER' = "default"
     ```

     ``` toml tab="Single Traffic Manager"
     [apim.throttling]
     throttle_decision_endpoints = ["tcp://Traffic-Manager-host:5672"]
          
     [[apim.throttling.url_group]]
     traffic_manager_urls = ["tcp://Traffic-Manager-host:9611"]
     traffic_manager_auth_urls = ["ssl://Traffic-Manager-host:9711"]

     [[event_listener]]
     id = "token_revocation"
     type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
     name = "org.wso2.is.notification.ApimOauthEventInterceptor"
     order = 1

     [event_listener.properties]
     notification_endpoint = "https://Traffic-Manager-host:${mgt.transport.https.port}/internal/data/v1/notify"
     username = "${admin.username}"
     password = "${admin.password}"
     'header.X-WSO2-KEY-MANAGER' = "default"
     ```

    2.  If you wish to encrypt the Auth Keys (access tokens, client secrets, and authorization codes), see [Encrypting OAuth Keys]({{base_path}}/design/api-security/oauth2/encrypting-oauth2-tokens/).


    3. Optionally, add the following configuration to enable distributed cache invalidation within the Key Manager nodes.

        ``` toml
        [apim.cache_invalidation]
        enabled = true
        domain = "km-domain"
        ```

-   Publisher configs

    Configure the Publisher with the Traffic Manager.
    This configuration enables the publishing of throttling policies, custom templates, block conditions, API events to the Traffic Manager node.

    ``` toml tab="Traffic Manager with HA"
    [apim.throttling]
    service_url = "https://[Traffic-Manager-LB-Host]/services/"
    throttle_decision_endpoints = ["tcp://Traffic-Manager-1-host:5672","tcp://Traffic-Manager-2-host:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://Traffic-Manager-1-host:9611"]
    traffic_manager_auth_urls = ["ssl://Traffic-Manager-1-host:9711"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://Traffic-Manager-2-host:9611"]
    traffic_manager_auth_urls = ["ssl://Traffic-Manager-2-host:9711"]
    ```
    
    ``` toml tab="Single Traffic Manager"
    [apim.throttling]
    service_url = "https://Traffic-Manager-host:${mgt.transport.https.port}/services/"
    throttle_decision_endpoints = ["tcp://Traffic-Manager-host:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://Traffic-Manager-host:9611"]
    traffic_manager_auth_urls = ["ssl://Traffic-Manager-host:9711"]
    ```

-   Developer Portal configs

    Configure the Developer Portal with the Traffic Manager.

    ``` toml tab="Traffic Manager with HA"
    [apim.throttling]
    throttle_decision_endpoints = ["tcp://Traffic-Manager-1-host:5672","tcp://Traffic-Manager-2-host:5672"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://Traffic-Manager-1-host:9611"]
    traffic_manager_auth_urls = ["ssl://Traffic-Manager-1-host:9711"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://Traffic-Manager-2-host:9611"]
    traffic_manager_auth_urls = ["ssl://Traffic-Manager-2-host:9711"]
    ```
    
    ``` toml tab="Single Traffic Manager"
    [apim.throttling]
    throttle_decision_endpoints = ["tcp://Traffic-Manager-host:5672"]
            
    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://Traffic-Manager-host:9611"]
    traffic_manager_auth_urls = ["ssl://Traffic-Manager-host:9711"]
    ```

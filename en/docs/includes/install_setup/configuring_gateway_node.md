
1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway node.

2.  Add the following configurations to the `deployment.toml` file.

    -   Connecting the Gateway to the Key Manager component in the Control Plane:

        ``` toml tab="Control Plane with HA"
        [apim.key_manager]
        service_url = "https://[control-plane-LB-host]/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"                
        ```
        
        ``` toml tab="Single Control Plane"
        [apim.key_manager]
        service_url = "https://[control-plane-host]:${mgt.transport.https.port}/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"
        ```

    -   Connecting the Gateway to the Traffic Manager component in the Control Plane:

        ``` toml tab="Control Plane with HA"
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
        
        ``` toml tab="Single Control Plane"
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

     For instructions, see [Generating JSON Web Token](../../../../deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway/).   
     
5.  Add the public certificate of the private key (that is used for signing the tokens) to the truststore under the `"gateway_certificate_alias"` alias. 
    
    For instructions, see [Create and import SSL certificates](../../../../install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores).

     <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>This is not applicable if you use the default certificates, which are the certificates that are shipped with the product itself. </p>
      </div> 
     </html>
     
6.  Follow the steps given below to configure High Availability (HA) for the API-M Gateway:

    1.  Create a copy of the API-M Gateway node that you just configured. This is the second node of the API-M Gateway cluster.
    2.  Configure a load balancer fronting the two Gateway nodes in your deployment.
                
        For instructions, see [Configuring the Proxy Server and the Load Balancer](../../../../install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer/).

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
    
        ```java tab="Format"
        <GATEWAY-IP> gw.wso2.com
        ```
    
        ``` java tab="Example"
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

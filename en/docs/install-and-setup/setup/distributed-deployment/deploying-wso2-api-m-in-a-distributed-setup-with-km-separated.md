# Configuring a Distributed API-M Deployment with Key Manager and Traffic Manager Separation

This document describes how to configure a distributed WSO2 API Manager deployment with the Key Manager and Traffic Manager separated from the Control Plane for migrated environments using Opaque tokens.

The following diagram shows the communications between the Control Plane, Gateway, Key Manager and the Traffic Manager nodes in the distributed deployment of API Manager for a migrated environment using Opaque (Reference) tokens.

<a href="{{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png"><img src="{{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png" width="100%"></a>

For more information on the distributed deployment patterns, refer to the [Understanding Distributed Deployment of WSO2 API Manager]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m) page.

## Configuring the Gateway Nodes

Configure the Gateway to communicate with the Key Manager, Control Plane and the Traffic Manager.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway node.

2. Add the following configurations to the deployment.toml file.

    **Connecting the Gateway to the Key Manager node**:

    ```toml tab="Key Manager with HA"

    # Key Manager configuration
    [apim.key_manager]
    service_url = "https://[key-manager-LB-host]/services/"
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"

    ```

    ```toml tab="Single Key Manager"

    # Key Manager configuration
    [apim.key_manager]
    service_url = "https://[key-manager-host]:${mgt.transport.https.port}/services/"
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"

    ```

    **Connecting the Gateway to the Control Plane node**:

    ```toml tab="Control Plane with HA"

    # Event Listener configurations
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://[control-plane-LB-host]/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://[control-plane-LB-host]/services/"
    event_listening_endpoints = ["tcp://control-plane-1-host:5672", "tcp://control-plane-2-host:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-1-host:9611"]
    auth_urls = ["ssl://control-plane-1-host:9711"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-2-host:9611"]
    auth_urls = ["ssl://control-plane-2-host:9711"]            

    ```

    ```toml tab="Single Control Plane"

    # Event Listener configurations
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://[control-plane-host]:${mgt.transport.https.port}/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://[control-plane-host]:${mgt.transport.https.port}/services/"
    event_listening_endpoints = ["tcp://control-plane-host:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-host:9611"]
    auth_urls = ["ssl://control-plane-host:9711"]

    ```

    **Connecting the Gateway to the Traffic Manager node**:

    ```toml tab="Traffic Manager with HA"

    [apim.throttling]
    service_url = "https://[traffic-manager-LB-host]/services/"
    throttle_decision_endpoints = ["tcp://traffic-manager-1-host:5672", "tcp://Traffic-Manager-2-host:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-1-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-1-host:9711"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-2-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-2-host:9711"]

    ```

    ```toml tab="Single Control Plane"

    [apim.throttling]
    service_url = "https://[traffic-manager-host]:${mgt.transport.https.port}/services/"
    throttle_decision_endpoints = ["tcp://traffic-manager-host:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-host:9711"]

    ```


3. Add the following configurations to the deployment.toml file to configure the Gateway environment. Change the `gateway_labels` property based on your Gateway environment.

    ```toml

    [apim.sync_runtime_artifacts.gateway]
    gateway_labels =["Default"]
    
    ```

4. Enable JSON Web Token (JWT) if required. For instructions, see [Generating JSON Web Token]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway).

5. Add the public certificate of the private key (that is used for signing the tokens) to the truststore under the "gateway_certificate_alias" alias. For instructions, see [Create and import SSL certificates]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores).

    !!! Note
        This is not applicable if you use the default certificates, which are the certificates that are shipped with the product itself.

6. Follow the steps given below to configure High Availability (HA) for the API-M Gateway:

    1. Create a copy of the API-M Gateway node that you just configured. This is the second node of the API-M Gateway cluster.

    2. Configure a load balancer fronting the two Gateway nodes in your deployment. For instructions, see [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer).

        !!! Note
            To keep custom runtime artifacts deployed in the Gateway, add the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway nodes.

            ```toml

            [apim.sync_runtime_artifacts.gateway.skip_list]
            apis = ["api1.xml","api2.xml"]
            endpoints = ["endpoint1.xml"]
            sequences = ["post_with_nobody.xml"]
            local-entries = ["file.xml"]

            ```

    3. Open the deployment.toml files of each Gateway node and add the cluster hostname. For example, if the hostname is `gw.am.wso2.com`, the following is the configuration value you need to provide:

        ```toml

        [server]
        hostname = "gw.wso2.com"

        ```

    4. Specify the following incoming connection configurations in the deployment.toml files of both nodes.

        ```toml

        [transport.http]
        properties.port = 9763
        properties.proxyPort = 80

        [transport.https]
        properties.port = 9443
        properties.proxyPort = 443

        ```

    5. Open the server's `/etc/hosts` file and map the hostnames to IPs.

        Format:

        ```toml
        
        <GATEWAY-IP> gw.wso2.com
        
        ```
 
        Example:

        ```toml

        xxx.xxx.xxx.xx4 gw.wso2.com

        ```

### Sample configuration for the Gateway

```toml

[server]
hostname = "gw.wso2.com"
node_ip = "127.0.0.1"
server_role = "gateway-worker"
offset=0

[user_store]
type = "database_unique_id"

[super_admin]
username = "admin"
password = "admin"
create_admin_account = true

[database.shared_db]
type = "h2"
url = "jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE"
username = "wso2carbon"
password = "wso2carbon"

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

# Key Manager configuration
[apim.key_manager]
service_url = "https://km.wso2.com:9443/services/"
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"

# Traffic Manager configurations
[apim.throttling]
service_url = "https://tm.wso2.com:9443/services/"
throttle_decision_endpoints = ["tcp://tm.wso2.com:5672"]

[[apim.throttling.url_group]]
traffic_manager_urls=["tcp://tm.wso2.com:9611"]
traffic_manager_auth_urls=["ssl://tm.wso2.com:9711"]

# Event Listener configurations
[[event_listener]]
id = "token_revocation"
type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
name = "org.wso2.is.notification.ApimOauthEventInterceptor"
order = 1

[event_listener.properties]
notification_endpoint = "https://cp.wso2.com:9443/internal/data/v1/notify"
username = "${admin.username}"
password = "${admin.password}"
'header.X-WSO2-KEY-MANAGER' = "default"

# Event Hub configurations
[apim.event_hub]
enable = true
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"
service_url = "https://cp.wso2.com:9443/services/"
event_listening_endpoints = ["tcp://cp.wso2.com:5672"]

[[apim.event_hub.publish.url_group]]
urls = ["tcp://cp.wso2.com:9611"]
auth_urls = ["ssl://cp.wso2.com:9711"]

[apim.cors]
allow_origins = "*"
allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction"]
allow_credentials = false

[apim.sync_runtime_artifacts.gateway]
gateway_labels =["Default"]

```

## Configuring the Control Plane Nodes

Configure the Control Plane to communicate with the Key Manager, Gateway and the Traffic Manager.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Control Plane node.

2. Add the following configurations to the deployment.toml file.

    **Connecting the Control Plane to the Key Manager node**:

    ```toml tab="Key Manager with HA"

    # Key Manager configuration
    [apim.key_manager]
    service_url = "https://[key-manager-LB-host]/services/"
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"

    ```

    ```toml tab="Single Key Manager"

    # Key Manager configuration
    [apim.key_manager]
    service_url = "https://[key-manager-host]:${mgt.transport.https.port}/services/"
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"

    ```

    **Connecting the Control Plane to the Gateway node**:

    !!! Info
        This configuration is used for publishing APIs to the Gateway and for connecting the Developer Portal component to the Gateway.	

    ```toml tab="Gateway with HA"

    [[apim.gateway.environment]]
    name = "Default"
    type = "hybrid"
    display_in_api_console = true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    show_as_token_endpoint_url = true
    service_url = "https://[api-gateway-LB-host]/services/"
    ws_endpoint = "ws://[api-gateway-LB-host-or-ip]:9099"
    wss_endpoint = "wss://[api-gateway-LB-host-or-ip]:8099"
    http_endpoint = "http://[api-gateway-LB-host]"
    https_endpoint = "https://[api-gateway-LB-host]"

    ```

    ```toml tab="Single Gateway"

    [[apim.gateway.environment]]
    name = "Default"
    type = "hybrid"
    display_in_api_console = true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    show_as_token_endpoint_url = true
    service_url = "https://[api-gateway-host]:9443/services/"
    ws_endpoint = "ws://[api-gateway-host]:9099"
    wss_endpoint = "wss://[api-gateway-host]:8099"
    http_endpoint = "http://[api-gateway-host]:${http.nio.port}"
    https_endpoint = "https://[api-gateway-host]:${https.nio.port}"

    ```

    **Connecting the Control Plane to the Traffic Manager node**:

    !!! Info
        This configuration enables the publishing of throttling policies, custom templates, block conditions, and API events to the Traffic Manager node.

    ```toml tab="Traffic Manager with HA"

    [apim.throttling]
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    enable_data_publishing = true
    service_url = "https://[traffic-manager-LB-host]/services/"
    event_duplicate_url = ["tcp://control-plane-2-host:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-1-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-1-host:9711"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-2-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-2-host:9711"]

    ```

    ```toml tab="Single Traffic Manager"

    [apim.throttling]
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    enable_data_publishing = true
    service_url = "https://[traffic-manager-host]:${mgt.transport.https.port}/services/"

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-host:9711"]

    ```

    !!! Note
        Configure the `event_duplicate_url` if the Control Plane is configured for High Availability (HA). 


    **Add Event Listener and Event Hub Configurations**:

    ```toml tab="Control Plane with HA"

    # Event Listener configurations
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://[control-plane-LB-host]/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username= "$ref{super_admin.username}"
    password= "$ref{super_admin.password}"
    service_url = "https://localhost:${mgt.transport.https.port}/services/"
    event_listening_endpoints = ["tcp://localhost:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-1-host:9611"]
    auth_urls = ["ssl://control-plane-1-host:9711"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-2-host:9611"]
    auth_urls = ["ssl://control-plane-2-host:9711"]

    ```

    ```toml tab="Single Control Plane"

    # Event Listener configurations
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://[control-plane-host]:${mgt.transport.https.port}/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username= "$ref{super_admin.username}"
    password= "$ref{super_admin.password}"
    service_url = "https://localhost:${mgt.transport.https.port}/services/"
    event_listening_endpoints = ["tcp://localhost:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-host:9611"]
    auth_urls = ["ssl://control-plane-host:9711"]

    ```

3. If required, encrypt the Auth Keys (access tokens, client secrets, and authorization codes), see [Encrypting OAuth Keys]({{base_path}}/design/api-security/oauth2/encrypting-oauth2-tokens).

4. Optionally, add the following configuration to enable distributed cache invalidation within the Control Plane nodes.

    ```toml

    [apim.cache_invalidation]
    enabled = true
    domain = "control-plane-domain"

    ```

5. Follow the steps given below to configure High Availability (HA) for the Control Plane:

    1. Create a copy of the API-M Control Plane node that you just configured. This is the second node of the API-M Control Plane cluster.

    2. Configure a load balancer fronting the two Control Plane nodes in your deployment. For instructions, see [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer).

### Sample configuration for the Control Plane

```toml

[server]
hostname = "cp.wso2.com"
node_ip = "127.0.0.1"
server_role = "control-plane"
offset=0

[user_store]
type = "database_unique_id"

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

# Key Manager configuration
[apim.key_manager]
service_url = "https://km.wso2.com:9443/services/"
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"

# Gateway configuration
[[apim.gateway.environment]]
name = "Default"
type = "hybrid"
display_in_api_console = true
description = "This is a hybrid gateway that handles both production and sandbox token traffic."
show_as_token_endpoint_url = true
service_url = "https://gw.wso2.com:9443/services/"
username= "${admin.username}"
password= "${admin.password}"
ws_endpoint = "ws://gw.wso2.com:9099"
wss_endpoint = "wss://gw.wso2.com:8099"
http_endpoint = "http://gw.wso2.com:8280"
https_endpoint = "https://gw.wso2.com:8243"

# Traffic Manager configurations
[apim.throttling]
username= "$ref{super_admin.username}"
password= "$ref{super_admin.password}"
enable_data_publishing = true
service_url = "https://tm.wso2.com:9443/services/"
throttle_decision_endpoints = ["tcp://tm.wso2.com:5672"]

[[apim.throttling.url_group]]
traffic_manager_urls=["tcp://tm.wso2.com:9611"]
traffic_manager_auth_urls=["ssl://tm.wso2.com:9711"]

# Event Listener configurations
[[event_listener]]
id = "token_revocation"
type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
name = "org.wso2.is.notification.ApimOauthEventInterceptor"
order = 1

[event_listener.properties]
notification_endpoint = "https://cp.wso2.com:9443/internal/data/v1/notify"
username = "${admin.username}"
password = "${admin.password}"
'header.X-WSO2-KEY-MANAGER' = "default"

# Event Hub configurations
[apim.event_hub]
enable = true
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"
service_url = "https://cp.wso2.com:9443/services/"
event_listening_endpoints = ["tcp://cp.wso2.com:5672"]

[[apim.event_hub.publish.url_group]]
urls = ["tcp://cp.wso2.com:9611"]
auth_urls = ["ssl://cp.wso2.com:9711"]

[apim.cors]
allow_origins = "*"
allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction"]
allow_credentials = false

```

## Configure the Traffic Manager Nodes

In a typical distributed deployment, all WSO2 APi Manager components (excluding the API-M Gateway) run in the Control Plane. However, you have the option of separating the Traffic Manager from the Control Plane.

Configure the Traffic Manager to communicate with the Control Plane.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Traffic Manager node.

2. Add the following configurations to the deployment.toml file.

    **Connecting the Traffic Manager to the Control Plane node**:

    ```toml tab="Control Plane with HA"
 
    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://[control-plane-LB-host]/services/"
    event_listening_endpoints = ["tcp://control-plane-1-host:5672", "tcp://control-plane-2-host:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-1-host:9611"]
    auth_urls = ["ssl://control-plane-1-host:9711"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-2-host:9611"]
    auth_urls = ["ssl://control-plane-2-host:9711"] 

    ```
 
    ```toml tab="Single Control Plane"
 
    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://[control-plane-host]/services/"
    event_listening_endpoints = ["tcp://control-plane-host:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-host:9611"]
    auth_urls = ["ssl://control-plane-host:9711"]

    ```

    **If the Traffic Manager node is configured with High Availability (HA), configure throttling as follows**.

    ```toml

    [apim.throttling]
    event_duplicate_url = ["tcp://traffic-manager-2-host:5672"]
    service_url = "https://[traffic-manager-LB-host]/services/"
    throttle_decision_endpoints = ["tcp://localhost:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-1-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-1-host:9711"]

    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tcp://traffic-manager-2-host:9611"]
    traffic_manager_auth_urls = ["ssl://traffic-manager-2-host:9711"]

    ```

    !!! Note
        The `event_duplicate_url` should be added in order to publish events to the other node.

3. Follow the steps given below to configure High Availability (HA) for the Traffic Manager:

    1. Create a copy of the Traffic Manager node that you just configured. This is the second node of the Traffic Manager cluster.

    2. Configure a load balancer fronting the two Traffic Manager nodes in your deployment.

        !!! Note
            In each startup of a Traffic Manager node, the rate-limiting policies are redeployed by retrieving the latest policy details from the database. This maintains the consistency between the Traffic Manager nodes. If you need to avoid redeploying certain rate-limiting policies, add the following configuration to the <API-M_HOME>/repository/conf/deployment.toml file in the Traffic Manager node.

            ```toml

            [apim.throttling]
            skip_redeploying_policies = ["throttle_policy_1","throttle_policy_2"]

            ```

### Sample configuration for the Traffic Manager

```toml

[server]
hostname = "tm.wso2.com"
node_ip = "127.0.0.1"
server_role = "traffic-manager"
offset=0

[user_store]
type = "database_unique_id"

[super_admin]
username = "admin"
password = "admin"
create_admin_account = true

[database.apim_db]
type = "h2"
url = "jdbc:h2:./repository/database/WSO2AM_DB;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE"
username = "wso2carbon"
password = "wso2carbon"

[database.shared_db]
type = "h2"
url = "jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE"
username = "wso2carbon"
password = "wso2carbon"

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

# Event Hub configurations
[apim.event_hub]
enable = true
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"
service_url = "https://cp.wso2.com:9443/services/"
event_listening_endpoints = ["tcp://cp.wso2.com:5672"]

[[apim.event_hub.publish.url_group]]
urls = ["tcp://cp.wso2.com:9611"]
auth_urls = ["ssl://cp.wso2.com:9711"]

```

## Configure the Key Manager Nodes

The Key Manager profile is deprecated from WSO2 API Manager 4.0.0 onwards. Hence this is applicable and useful only if you are migrating from a previous version of WSO2 API Manager and if you are using Opaque Tokens for API Invocation. The `WSO2AM_DB` and `WSO2SHARED_DB` are shared between the Key Manager node and the Control Plane node.

!!! Note
    The profile name for the deprecated Key Manager profile is “api-key-manager-deprecated”. For example, when performing profile optimization or profile startup, use the command option with profile name as `-Dprofile=api-key-manager-deprecated`.

Follow the steps below to configure the Key Manager to communicate with the Control Plane.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Control Plane node.

2. Add the following configurations to the deployment.toml file.

    **Connecting the Key Manager to the Control Plane node**:

    ```toml tab="Control Plane with HA"

    # Event Listener configurations
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://[control-plane-LB-host]/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username= "$ref{super_admin.username}"
    password= "$ref{super_admin.password}"
    service_url = "https://localhost:${mgt.transport.https.port}/services/"
    event_listening_endpoints = ["tcp://localhost:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-1-host:9611"]
    auth_urls = ["ssl://control-plane-1-host:9711"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-2-host:9611"]
    auth_urls = ["ssl://control-plane-2-host:9711"]

    ```

    ```toml tab="Single Control Plane"

    # Event Listener configurations
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://[control-plane-host]:${mgt.transport.https.port}/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username= "$ref{super_admin.username}"
    password= "$ref{super_admin.password}"
    service_url = "https://localhost:${mgt.transport.https.port}/services/"
    event_listening_endpoints = ["tcp://localhost:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://control-plane-host:9611"]
    auth_urls = ["ssl://control-plane-host:9711"]

    ```

3. If required, encrypt the Auth Keys (access tokens, client secrets, and authorization codes), see [Encrypting OAuth Keys]({{base_path}}/design/api-security/oauth2/encrypting-oauth2-tokens).

4. Optionally, add the following configuration to enable distributed cache invalidation within the Control Plane nodes.

    ```toml

    [apim.cache_invalidation]
    enabled = true
    domain = "control-plane-domain"

    ```

5. Follow the steps given below to configure High Availability (HA) for the Key Manager:

    1. Create a copy of the API-M Key Manager node that you just configured. This is the second node of the API-M Key Manager cluster.

    2. Configure a load balancer fronting the two Key Manager nodes in your deployment. For instructions, see [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer).

### Sample configuration for the Key Manager

```toml

[server]
hostname = "km.wso2.com"
node_ip = "127.0.0.1"
server_role = "api-key-manager-deprecated"
offset=0

[user_store]
type = "database_unique_id"

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

[[event_handler]]
name="userPostSelfRegistration"
subscriptions=["POST_ADD_USER"]

[service_provider]
sp_name_regex = "^[\\sa-zA-Z0-9._-]*$"

# Event Listener configurations
[[event_listener]]
id = "token_revocation"
type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
name = "org.wso2.is.notification.ApimOauthEventInterceptor"
order = 1

[event_listener.properties]
notification_endpoint = "https://cp.wso2.com:9443/internal/data/v1/notify"
username = "${admin.username}"
password = "${admin.password}"
'header.X-WSO2-KEY-MANAGER' = "default"

# Event Hub configurations
[apim.event_hub]
enable = true
username = "$ref{super_admin.username}"
password = "$ref{super_admin.password}"
service_url = "https://cp.wso2.com:9443/services/"
event_listening_endpoints = ["tcp://cp.wso2.com:5672"]

[[apim.event_hub.publish.url_group]]
urls = ["tcp://cp.wso2.com:9611"]
auth_urls = ["ssl://cp.wso2.com:9711"]

```
# Configuring a Distributed API-M Deployment

WSO2 API-M can be deployed as an [all-in-one deployment]({{base_path}}/install-and-setup/setup/single-node/all-in-one-deployment-overview) or as a distributed deployment. In the distributed setup, the respective component distributions, namely WSO2 API Manager All-in-One, and WSO2 Universal Gateway are deployed as separate nodes.

Given below are the API-M nodes you can have in a distributed deployment by default.

!!! Tip
    To enable high availability, you need a minimum of two nodes running each component distribution.

<table>
    <tr>
        <th>
            API-M Component Distribution
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            WSO2 API Manager All-in-One
        </td>
        <td>
            API-M All-in-One nodes facilitate as Control plain, traffic manager and Key Manager which includes the Publisher Portal, Developer Portal and Admin Portal components.
        </td>
    </tr>
    <tr>
        <td>
            WSO2 Universal Gateway
        </td>
        <td>
            API-M nodes running the Gateway component.
        </td>
    </tr>
</table>

<a href="{{base_path}}/assets/img/setup-and-install/simple-distributed.png"><img src="{{base_path}}/assets/img/setup-and-install/simple-distributed.png" width="100%"></a>

### Step 1 - Install WSO2 API-M

To install and set up the API-M servers:

1.  Download the WSO2 API Manager All-in-One and WSO2 Universal Gateway component distributions from the [WSO2 API Manager website](https://wso2.com/api-manager/).

### Step 2 - Install and configure the databases

You can create the required databases for the API-M deployment in a separate server and point to the databases from the respective nodes.

For information, see [Installing and Configuring the Databases](../../../../install-and-setup/setup/setting-up-databases/overview/).

### Step 3 - Configure your deployment with production hardening

Ensure that you have taken into account the respective security hardening factors (e.g., changing and encrypting the default passwords, configuring JVM security, etc.) before deploying WSO2 API-M.

For more information, see [Production Deployment Guidelines](../../../../install-and-setup/deploying-wso2-api-manager/production-deployment-guidelines/#common-guidelines-and-checklist).

### Step 4 - Create and import SSL certificates

Create an SSL certificate for each of the WSO2 API-M nodes and import them to the keystore and the truststore. This ensures that hostname mismatch issues in the certificates will not occur.

!!! Note
    The same primary keystore should be used for all API Manager instances to decrypt the registry resources. For more information, see [Configuring the Primary Keystore](../../../../install-and-setup/setup/security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#configuring-the-primary-keystore).

For more information, see [Creating SSL Certificates](../../../../install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/).

### Step 5 - Configure API-M Analytics

API Manager Analytics is delivered via the API Manager Analytics cloud solution. You need to configure the WSO2 Universal Gateway distribution to publish analytics data to the cloud.

See the instructions on [configuring the Gateway](../../../../monitoring/api-analytics/choreo-analytics/getting-started-guide/) with the cloud-based analytics solution.

### Step 6 - Configure and start the component nodes

Let's configure the API-M nodes in the deployment.

#### Configure the Gateway nodes

Configure the Gateway to communicate with the API Manager All-in-One node.

Follow the instructions given below to configure the Gateway node so that it can communicate with the API Manager All-in-One node:

1. Open the `<UNIVERSAL-GW_HOME>/repository/conf/deployment.toml` file of the Gateway node.

2. Add the following configurations to the deployment.toml file.

    === "All-in-One with High Availability"
        ```toml
        # Key Manager configuration
        [apim.key_manager]
        service_url = "https://[all-in-one-LB-host]/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"

        # Event Hub configurations
        [apim.event_hub]
        enable = true
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"
        service_url = "https://[all-in-one-LB-host]/services/"
        event_listening_endpoints = ["tcp://all-in-one-1-host:5672", "tcp://all-in-one-2-host:5672"]
        
        # Traffic Manager configurations
        [apim.throttling]
        throttle_decision_endpoints = ["tcp://all-in-one-1-host:5672", "tcp://Tall-in-one-2-host:5672"]

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://all-in-one-1-host:9611"]
        traffic_manager_auth_urls = ["ssl://all-in-one-1-host:9711"]

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://all-in-one-2-host:9611"]
        traffic_manager_auth_urls = ["ssl://all-in-one-2-host:9711"]
 
        ```

    === "Single All-in-One node"
        ```toml
        # Key Manager configuration
        [apim.key_manager]
        service_url = "https://[all-in-one-host]:${mgt.transport.https.port}/services/"
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"

        # Event Hub configurations
        [apim.event_hub]
        enable = true
        username = "$ref{super_admin.username}"
        password = "$ref{super_admin.password}"
        service_url = "https://[all-in-one-host]:${mgt.transport.https.port}/services/"
        event_listening_endpoints = ["tcp://all-in-one-host:5672"]
        # Traffic Manager configurations
        [apim.throttling]
        throttle_decision_endpoints = ["tcp://all-in-one-host:5672"]

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://all-in-one-host:9611"]
        traffic_manager_auth_urls = ["ssl://all-in-one-host:9711"]
        ```

    !!! Info
        Event hub configuration is used to retrieve Gateway artifacts. Using `event_listening_endpoints`, the Gateway will create a JMS connection with the event hub that is then used to subscribe for API/Application/Subscription and Key Manager operations-related events. The `service_url` points to the internal API that resides in the event hub that is used to pull artifacts and information from the database.
        
        Rate limiting configurations are used by the Gateway to connect with the All-in-One node. The Gateway will publish Gateway invocation-related events to the All-in-One node using the `apim.throttling.url_group`. All-in-One node will receive these events and rate limiting decisions will be published to the Gateway. To receive these rate limiting decisions, the Gateway has to create a JMS connection using `throttle_decision_endpoints` and listen.
        
        **Enabling TLS/SSL for event hub JMS communications**

        If required, you can enable TLS/SSL for the JMS communications of event hub. Update your event hub configurations to include the following for this purpose.

        ```
        [apim.event_hub]
        enable = true
        jms.username = "<username>"
        jms.password = "<password>"
        jms.ssl = "true'&amp;ssl_cert_alias='<certificate_alias_in_truststore>'&amp;trust_store='<path_to_trust_store>'&amp;trust_store_password='<truststore_password>'&amp;key_store='<path_to_key_store>'&amp;key_store_password='<keystore_password>"
        ssl = "true'&amp;ssl_cert_alias='<certificate_alias_in_truststore>'&amp;trust_store='<path_to_trust_store>'&amp;trust_store_password='<truststore_password>'&amp;key_store='<path_to_key_store>'&amp;key_store_password='<keystore_password>"
        event_listening_endpoints = ["tcp://all-in-one:8672"]
        ```
        To enable secure broker connections add the following configuration to the Control Plane node.

        ```
        [broker.transport.amqp.ssl_connection]
        enabled = true
        port = 8672
        ssl_enabled_protocols = "TLSv1,TLSv1.2"
        ciphers = "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"

        [broker.transport.amqp.ssl_connection.keystore]
        location = "repository/resources/security/wso2carbon.jks"
        password = "wso2carbon"
        cert_type = "SunX509"

        [broker.transport.amqp.ssl_connection.truststore]
        location = "repository/resources/security/client-truststore.jks"
        password = "wso2carbon"
        cert_type = "SunX509"
        ``` 

3. Add the following configurations to the deployment.toml file to configure the Gateway environment. Change the `gateway_labels` property based on your Gateway environment.

    ```toml
    [apim.sync_runtime_artifacts.gateway]
    gateway_labels =["Default"]
    ```

    !!! Info
        Once an API is deployed/undeployed, the All-in-One node will send a deploy/undeploy event to the Gateways. Using this configuration, the Gateway will filter out its relevant deploy/undeploy events and retrieve the artifacts.

4. Enable JSON Web Token (JWT) if required. For instructions, see [Generating JSON Web Token](../../../../manage-apis/deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway).

5. Add the public certificate of the private key (that is used for signing the tokens) to the truststore under the "gateway_certificate_alias" alias. For instructions, see [Create and import SSL certificates](../../../../install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores).

    !!! Note
        This is not applicable if you use the default certificates, which are the certificates that are shipped with the product itself.

6. Follow the steps given below to configure High Availability (HA) for the Universal Gateway:

    1. Create a copy of the WSO2 Universal Gateway node that you just configured. This is the second node of the Gateway cluster.

    2. Configure a load balancer fronting the two Gateway nodes in your deployment. For instructions, see [Configuring the Proxy Server and the Load Balancer](../../../../install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer).

        !!! Note
            To keep custom runtime artifacts deployed in the Gateway, add the following configuration in the `<UNIVERSAL-GW_HOME>/repository/conf/deployment.toml` file of the Gateway nodes.

            ```toml
            [apim.sync_runtime_artifacts.gateway.skip_list]
            apis = ["api1.xml","api2.xml"]
            endpoints = ["endpoint1.xml"]
            sequences = ["post_with_nobody.xml"]
            local_entries = ["file.xml"]

            ```

    3. Open the `deployment.toml` files of each Gateway node and add the cluster hostname. For example, if the hostname is `gw.am.wso2.com` the configuration will be:

        ```toml
        [server]
        hostname = "gw.wso2.com"

        ```

    4. Specify the following incoming connection configurations in the `deployment.toml` files of both nodes.

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
        
        ```
        <GATEWAY-IP> gw.wso2.com
        ```
 
        Example:
        
        ```
        xxx.xxx.xxx.xx4 gw.wso2.com
        ```

###### Sample configuration for the Gateway

=== "HA Cluster"
    ```toml
    [server]
    hostname = "gw.wso2.com"
    node_ip = "127.0.0.1"
    server_role = "default"
    
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
    username = "sharedadmin"
    password = "sharedadmin"
    
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
    
    [transport.http]
    properties.port = 9763
    properties.proxyPort = 80
    
    [transport.https]
    properties.port = 9443
    properties.proxyPort = 443
    
    # key manager implementation
    [apim.key_manager]
    service_url = "https://api.am.wso2.com/services/"
    
    [apim.sync_runtime_artifacts.gateway]
    gateway_labels =["Default"]
    
    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}" 
    event_listening_endpoints = ["tcp://all-in-one-1:5672", "tcp://all-in-one-2:5672"]
    
    # Traffic Manager configurations
    [apim.throttling]
    throttle_decision_endpoints = ["tcp://all-in-one-1:5672", "tcp://all-in-one-2:5672"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://all-in-one-1:9611"]
    traffic_manager_auth_urls=["ssl://all-in-one-1:9711"]
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://all-in-one-2:9611"]
    traffic_manager_auth_urls=["ssl://all-in-one-2:9711"]
    ```

=== "Single Node"
    ```toml
    [server]
    hostname = "gw.wso2.com"
    node_ip = "127.0.0.1"
    server_role = "default"
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
    service_url = "https://api.am.wso2.com:9443/services/"
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"

    # Traffic Manager configurations
    [apim.throttling]
    throttle_decision_endpoints = ["tcp://api.am.wso2.com:5672"]

    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://api.am.wso2.com:9611"]
    traffic_manager_auth_urls=["ssl:/api.am.wso2.com:9711"]

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://api.am.wso2.com:9443/services/"
    event_listening_endpoints = ["tcp://api.am.wso2.com:5672"]

    [apim.sync_runtime_artifacts.gateway]
    gateway_labels =["Default"]

    ```

#### Configure the API Manager All-in-One nodes

Follow the steps given below to configure the All-in-One nodes to communicate with the Universal Gateway.

1. Open the `<APIM_HOME>/repository/conf/deployment.toml` file of the All-in-One node.

2. Add the following configurations to the deployment.toml file.

    === "Gateway with High Availability"
        ```toml
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

    === "Single gateway"
        ```toml
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

    !!! Info
        This configuration is used for deploying APIs to the Gateway and for connecting the Developer Portal component to the Gateway if the Gateway is shared across tenants. If the Gateway is not used in multiple tenants, you can create a [Gateway Environment using the Admin Portal](../../../../manage-apis/deploy-and-publish/deploy-on-gateway/deploy-api/exposing-apis-via-custom-hostnames/#using-a-new-gateway-environment-to-expose-apis-via-custom-hostnames).
        Note that in the above configurations, the `service_url` points to the `9443` port of the Gateway node, while `http_endpoint` and `https_endpoint` points to the `http` and `https nio ports` (8280 and 8243).
   
    **Add Event Hub Configurations**

    !!! Info
        {!includes/deploy/enable-jms-ssl-for-eventhub.md!}

    === "All-in-One with High Availability"
        ```toml
        # Event Hub configurations
        [apim.event_hub]
        enable = true
        username= "$ref{super_admin.username}"
        password= "$ref{super_admin.password}"
        service_url = "https://localhost:${mgt.transport.https.port}/services/"
        event_listening_endpoints = ["tcp://localhost:5672"]
        event_duplicate_url = ["tcp://all-in-one-2:5672"]

        [[apim.event_hub.publish.url_group]]
        urls = ["tcp://all-in-one-1-host:9611"]
        auth_urls = ["ssl://all-in-one-1-host:9711"]

        [[apim.event_hub.publish.url_group]]
        urls = ["tcp://all-in-one-2-host:9611"]
        auth_urls = ["ssl://all-in-one-2-host:9711"]

        ```

    === "Single All-in-One"
        ```toml
        # Event Hub configurations
        [apim.event_hub]
        enable = true
        username= "$ref{super_admin.username}"
        password= "$ref{super_admin.password}"
        service_url = "https://localhost:${mgt.transport.https.port}/services/"
        event_listening_endpoints = ["tcp://localhost:5672"]

        [[apim.event_hub.publish.url_group]]
        urls = ["tcp://api.am.wso2.com:9611"]
        auth_urls = ["ssl://api.am.wso2.com:9711"]

        ```

    !!! Info
        As there are two event hubs in a HA setup, each event hub has to publish events to both event streams. This will be done through the event streams created with `apim.event_hub.publish.url_group`. The token revocation events that are received to an event hub will be duplicated to the other event hub using `event_duplicate_url`.

    **Add Event Listener Configurations**:

    The below configurations are only added to the All-in-One nodes if you are using the Resident Key Manager (resides in the All-in-One node). If you are using WSO2 IS as Key Manager, you need to add these in the IS node. Once you add the below configurations, the All-in-One node or Identity Server will listen to token revocation events and invoke the `notification_endpoint` regarding the revoked token.

    === "All-in-One with High Availability"
        ```toml
        # Event Listener configurations
        [[event_listener]]
        id = "token_revocation"
        type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
        name = "org.wso2.is.notification.ApimOauthEventInterceptor"
        order = 1

        [event_listener.properties]
        notification_endpoint = "https://[all-in-one-LB-host]/internal/data/v1/notify"
        username = "${admin.username}"
        password = "${admin.password}"
        'header.X-WSO2-KEY-MANAGER' = "default"
        ```

    === "Single All-in-One node"
        ```toml
        # Event Listener configurations
        [[event_listener]]
        id = "token_revocation"
        type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
        name = "org.wso2.is.notification.ApimOauthEventInterceptor"
        order = 1

        [event_listener.properties]
        notification_endpoint = "https://[all-in-one-host]:${mgt.transport.https.port}/internal/data/v1/notify"
        username = "${admin.username}"
        password = "${admin.password}"
        'header.X-WSO2-KEY-MANAGER' = "default"
        ```

3. If required, encrypt the Auth Keys (access tokens, client secrets, and authorization codes), see [Encrypting OAuth Keys](../../../../manage-apis/design/api-security/oauth2/encrypting-oauth2-tokens).

4. Optionally, add the following configuration to enable distributed cache invalidation within the All-in-One nodes.

    ```toml
    [apim.cache_invalidation]
    enabled = true
    domain = "all-in-one-domain"

    ```

5. Follow the steps given below to configure High Availability (HA) for the All-in-One node:

    1. Create a copy of the All-in-One node that you just configured. This is the second node of the All-in-One cluster.

    2. Configure a load balancer fronting the two All-in-One nodes in your deployment. For instructions, see [Configuring the Proxy Server and the Load Balancer](../../../../install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer).

6. Configure Traffic Management capabilities on All-in-One node 

    !!! Info
        With `event_listening_endpoints`, the Traffic Manager is subscribed to the JMS stream of both event hubs. Once a policy-related event is received, it will pull the execution plans from the `service_url`.

    If the All-in-One node is configured with High Availability (HA), configure rate limiting as follows.

    ```toml
    [apim.throttling]
    event_duplicate_url = ["tcp://traffic-manager-2-host:5672"]
    throttle_decision_endpoints = ["tcp://localhost:5672"]
    ```

    !!! Info
        The `event_duplicate_url` will publish rate limiting decisions to the other Traffic Manager node to maintain consistency.

###### Sample configuration for the All-in-One nodes

=== "HA Cluster"
    ```toml
    [server]
    hostname = "api.am.wso2.com"
    node_ip = "127.0.0.1"
    server_role="default"
    base_path = "${carbon.protocol}://${carbon.host}:${carbon.management.port}"

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
    username = "apimadmin"
    password = "apimadmin"

    [database.shared_db]
    type = "mysql"
    hostname = "db.wso2.com"
    name = "shared_db"
    port = "3306"
    username = "sharedadmin"
    password = "sharedadmin"

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

    [[apim.gateway.environment]]
    name = "Default"
    type = "hybrid"
    display_in_api_console = true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    show_as_token_endpoint_url = true
    service_url = "https://[api-gateway-LB-host]/services/"
    ws_endpoint = "ws://[api-gateway-LB-host]:9099"
    wss_endpoint = "wss://[api-gateway-LB-host]:8099"
    http_endpoint = "http://[api-gateway-LB-host]"
    https_endpoint = "https://[api-gateway-LB-host]"

    [apim.devportal]
    url = "https://api.am.wso2.com/devportal"

    [transport.https.properties]
    proxyPort = 443

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://api.am.wso2.com/services/"
    event_listening_endpoints = ["tcp://localhost:5672"]
    event_duplicate_url = ["tcp://all-in-one-2:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://all-in-one-1:9611"]
    auth_urls = ["ssl://all-in-one-1:9711"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://all-in-one-2:9611"]
    auth_urls = ["ssl://all-in-one-2:9711"]

    [apim.throttling]
    event_duplicate_url = ["tcp://all-in-one-2:5672"]
    throttle_decision_endpoints = ["tcp://localhost:5672"]

    # key manager implementation
    [apim.key_manager]
    service_url = "https://api.am.wso2.com/services/"
    username= "$ref{super_admin.username}"
    password= "$ref{super_admin.password}"
    type = "default"

    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://api.am.wso2.com/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"
    ```

=== "Single Node"
    ```toml
    [server]
    hostname = "api.am.wso2.com"
    node_ip = "127.0.0.1"
    server_role = "default"
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
    username = "apimadmin"
    password = "apimadmin"

    [database.shared_db]
    type = "mysql"
    hostname = "db.wso2.com"
    name = "shared_db"
    port = "3306"
    username = "sharedadmin"
    password = "sharedadmin"

    [keystore.tls]
    file_name =  "wso2carbon.jks"
    type =  "JKS"
    password =  "wso2carbon"
    alias =  "wso2carbon"
    key_password =  "wso2carbon"

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

    # Event Listener configurations
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1

    [event_listener.properties]
    notification_endpoint = "https://api.am.wso2.com:9443/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "default"

    # Event Hub configurations
    [apim.event_hub]
    enable = true
    username = "$ref{super_admin.username}"
    password = "$ref{super_admin.password}"
    service_url = "https://api.am.wso2.com:9443/services/"
    event_listening_endpoints = ["tcp://api.am.wso2.com:5672"]

    [[apim.event_hub.publish.url_group]]
    urls = ["tcp://api.am.wso2.com:9611"]
    auth_urls = ["ssl://api.am.wso2.com:9711"]
    ```


### Step 7 - Start the API-M nodes

Once you have successfully configured all the API-M nodes in the deployment, you can start the servers.

-   Starting the Gateway nodes

    Open a terminal, navigate to the `<UNIVERSAL-GW_HOME>/bin` folder, and execute the following command:

    === "Linux/Mac OS"
    ``` java
    cd <UNIVERSAL-GW_HOME>/bin/
    sh gateway.sh
    ```

    === "Windows"
    ``` java
    cd <UNIVERSAL-GW_HOME>\bin\
    gateway.bat --run
    ```

-   Start the All-in-One nodes

    Open a terminal, navigate to the `<APIM_HOME>/bin` folder, and execute the following command:

    === "Linux/Mac OS"
    ``` java
    cd <APIM_HOME>/bin/
    sh api-manager.sh
    ```

    === "Windows"
    ``` java
    cd <APIM_HOME>\bin\
    api-manager.bat --run
    ```
    
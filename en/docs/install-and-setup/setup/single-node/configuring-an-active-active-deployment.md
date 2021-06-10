# Configuring an Active-Active Deployment

This page walks you through how to manually configure WSO2 API Manager (WSO2 API-M) with two active nodes that each has all the components of the API-M together in one instance (all-in-one instance).

<a href="{{base_path}}/assets/img/setup-and-install/gateway-connections.png"><img src="{{base_path}}/assets/img/setup-and-install/gateway-connections.png" width=600></a>

Follow the instructions below to configure and deploy API-M by using an Active-Active deployment:

-   [Step 1 - Create a SSL Certificate](#step-1-create-a-ssl-certificate)
-   [Step 2 - Configure the Load Balancer](#step-2-configure-the-load-balancer)
-   [Step 3 - Configure the Databases](#step-3-configure-the-databases)
-   [Step 4 - Configure the Second WSO2 API-M Node](#step-4-configure-the-second-wso2-api-m-node)
-   [Step 5 - Configure Publisher with the Gateway](#step-5-configure-publisher-with-the-gateway)
-   [Step 6 - Configure Gateway URLs to Expose APIs](#step-6-configure-gateway-urls-to-expose-apis)
-   [Step 7 - Configure Throttling](#step-7-configure-throttling)
-   [Step 8 - Optionally, enable distributed cache invalidation](#step-8-optionally-enable-distributed-cache-invalidation)  
-   [Step 9 - Configure API-M Analytics](#step-9-configure-api-m-analytics)
-   [Step 10 - Configure Production Hardening](#step-10-configure-production-hardening)
-   [Step 11 - Start the WSO2 API-M Servers](#step-11-start-the-wso2-api-m-servers)

___________________________________

## Step 1 - Create a SSL Certificate

!!! info   
    All WSO2 products are by default shipped with a keystore file and truststore file stored in the 
    `<PRODUCT_HOME>/repository/resources/security/` directory. The default keystore that is shipped with a WSO2 product, 
    `wso2carbon.jks` is configured with private key and self signed public key pair for all purposes, such as encrypting 
    sensitive information, communicating over SSL etc. 
    
    In a **production setup**, it is advised to set up several different keystores with separate trust chains for different use cases. For more information, see [Recommendations for setting up keystores in WSO2 products]({{base_path}}/administer/product-security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#recommendations-for-setting-up-keystores).

To create an all purpose keystore or multiple keystores for authentication and protection of data, follow the steps in [Creating New Keystores]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/creating-new-keystores/). 

!!! tip
    You should use the same keystore and trusstore for SSL in both WSO2 API-M instances.

## Step 2 - Configure the Load Balancer

In order to access the WSO2 API-M Portals and Gateway, you need to front the system with a load balancer. You can use any 
load balancer that is available to your system.

Follow the steps in [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-the-proxy-server-and-the-load-balancer) to configure the load balancer/reverse proxy which is fronting the API-M nodes
in the demiliterized zone (DMZ).

??? tip
    For example, if you are using the hostname `api.am.wso2.com` is used to access all portals (publisher, store, admin, and carbon) and `gw.am.wso2.com` is used to invoke APIs, the `deployment.toml` in `<API-M_HOME>/repository/conf` directory of both
    nodes, should have the following reverse proxy configurations.

    **NOTE** : Following is a sample configuration. Therefore parameter values might be different.
    ```toml
    [server]
    hostname = "api.am.wso2.com"
    [transport.https.properties]
    proxyPort = 443
    ```

## Step 3 - Configure the Databases

The `WSO2AM_DB` and `WSO2SHARED_DB` databases need to be shared between the two API-M nodes. It is recommended to use an
industry-standard RDBMS databases for this purpose. For more 
information on default databases and changing them into RDBMS databases, see [Working with Databases]({{base_path}}/install-and-setup/setting-up-databases/overview/).

??? tip
    If you have configured the apim and shared databases correctly, the `deployment.toml` in `<API-M_HOME>/repository/conf` 
    directory, should have the following configurations.

    **NOTE** : Following is a sample configuration for MySQL 8.0. Therefore parameter values might be different.

    ```toml
    [database.apim_db]
    type = "mysql"
    url = "jdbc:mysql://mysql.wso2.com:3306/WSO2AM_DB?useSSL=false"
    username = "wso2carbon"
    password = "wso2carbon"
    driver="com.mysql.cj.jdbc.Driver"

    [database.shared_db]
    type = "mysql"
    url = "jdbc:mysql://mysql.wso2.com:3306/WSO2SHARED_DB?useSSL=false"
    username = "wso2carbon"
    password = "wso2carbon"
    driver="com.mysql.cj.jdbc.Driver"
    ```

## Step 4 - Configure the Second WSO2 API-M Node

Make a copy of the active instance configured above and use this copy as the second active instance.

!!! info
    When making a copy of the node, you need to also make a copy of the SSL certificate that you created for node 1 
    in [step 1]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/creating-new-keystores).

    
## Step 5 - Configure Publisher with the Gateway

When **underlined file system is shared**, the artifacts are available to both Gateway nodes. Therefore, a single node 
can publish the API artifacts to their own nodes. Therefore, you can point the `service_url` to `localhost` in the
`deployment.toml` of both nodes.

``` toml
[[apim.gateway.environment]]
...
service_url = "https://localhost:${mgt.transport.https.port}/services/"
...
```

??? info "If you are using RSYNC for artifact synchronization"  

    The API artifacts will be synchronized in one direction. The synchronization will take place from manager to the worker as explained in the [Configuring rsync for Deployment 
    Synchronization]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-rsync-for-deployment-synchronization) section. Therefore, the API artifact should be only created on one node that acts as a manager node 
    for the purpose of artifact synchronization. Follow the instructions below to configure the manager node:

    Let's assume that `node-1` is the manager node for artifact synchronization.

    1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in `node-1`.
    2.  Configure the Gateway Service URL to point to it's self (localhost):
        ``` toml
        [[apim.gateway.environment]]
        ...
        service_url = "https://localhost:${mgt.transport.https.port}/services/"
        ...
        ```

    3.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in `node-2`.
    4.  Configure the Gateway Service URL to point to `node-1`:
        ``` toml
        [[apim.gateway.environment]]
        ...
        service_url = "https://<node1-hostname>:<node-1-mgt-transport-port>/services/"
        ...
        ```
        Note that `<node-1-mgt-transport-port>` is the management transport port, which is by default 9443.

## Step 6 - Configure Gateway URLs to Expose APIs

You need to configure the environment URLs which are used to expose the deployed APIs in the Gateways of both nodes. 
Add the Gateway hostname when you configure environments in the `<API-M_HOME>/repository/conf/deployment.toml` file in both
API-M nodes. 

Update the endpoints with your chosen hostname for Gateways as shown below. 
In this case, let's use `gw.am.wso2.com` as the hostname.
    ``` java
    [[apim.gateway.environment]]
    ...
    ws_endpoint = "ws://gw.am.wso2.com:9099"
    wss_endpoint = "wss://gw.am.wso2.com:8099"
    http_endpoint = "http://gw.am.wso2.com:${http.nio.port}"
    https_endpoint = "https://gw.am.wso2.com:${https.nio.port}"
    ebsub_event_receiver_http_endpoint = "http://gw.am.wso2.com:9021"
    websub_event_receiver_https_endpoint = "https://gw.am.wso2.com:8021"
    ```            

## Step 7 - Configure Throttling

1.  Configure the Traffic Manager nodes should communicate with the Control Plane.
2.  Configure the Key Manager, Publisher, and Developer Portal components in the Control Plane to communicate with the Traffic Manager.

Follow the steps given below.

1.  Configuring the Traffic Manager nodes:

    1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Traffic Manager node.
    2.  Apply the following configurations to point to Key Manager node in the Control Plane.

        -   Connecting the Traffic Manager to the Key Manager component of the Control Plane:

            ``` toml tab="Control Plane with HA"
            [apim.key_manager]
            service_url = "https://[control-plane-LB-host]/services/"
            username = "$ref{super_admin.username}"
            password = "$ref{super_admin.password}"
            ```

            ``` toml tab="Single Key Manager"
            [apim.key_manager]
            service_url = "https://[control-plane-host]:${mgt.transport.https.port}/services/"
            username = "$ref{super_admin.username}"
            password = "$ref{super_admin.password}"
            ```

        -   Connecting the Traffic Manager to the Gateway:

            ``` toml
            [[apim.gateway.environment]]
            name = "Production and Sandbox"
            type = "hybrid"
            ```

    3. Follow the steps given below to configure High Availability (HA) for the Traffic Manager:

        1.  Create a copy of the Traffic Manager node that you just configured. This is the second node of the Traffic Manager cluster.
        2.  Configure a load balancer fronting the two Traffic Manager nodes in your deployment.
        2.  Open the `deployment.toml` file in the Traffic Manager node and add the following configuration to publish events to the other node.


            ``` toml tab="Node1"
            [apim.throttling]
            event_duplicate_url = ["tcp://Traffic-Manager-2-host:5672"]
            ```
            
            ``` toml tab="Node2"
            [apim.throttling]
            event_duplicate_url = ["tcp://Traffic-Manager-1-host:5672"]
            ```
            
        !!! Note
            In each startup of a Traffic Manager node, the rate-limiting policies are redeployed by retrieving the latest policy details from the database. This maintains the consistency between the Traffic Manager nodes. If you need to avoid redeploying certain rate-limiting policies, add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file in the Traffic Manager node.  
                
            ```toml
            [apim.throttling]
            skip_redeploying_policies = ["throttle_policy_1","throttle_policy_2"]
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

2.  Configuring the Control Plane nodes:

    !!! Note
        The following configurations connect the Control Plane to the Traffic Manager node. Note that you must also [configure the Control Plane with the Gateway](#configure-the-control-plane-nodes).

    1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Control Plane node.
    2.  Apply the following configurations to the `deployment.toml` file.

        -   Connecting the Key Manager component in the Control Plane to the Traffic Manager.

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

        -   Connecting the Publisher component in the Control Plane with the Traffic Manager.

            !!! Info
                This configuration enables the publishing of throttling policies, custom templates, block conditions, and API events to the Traffic Manager node.

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

        -   Connecting the Developer Portal component of the Control Plane with the Traffic Manager.

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

    3.  If required, encrypt the Auth Keys (access tokens, client secrets, and authorization codes), see [Encrypting OAuth Keys]({{base_path}}/design/api-security/oauth2/encrypting-oauth2-tokens/).

    4. Optionally, add the following configuration to enable distributed cache invalidation within the Control Plane nodes.

        ``` toml
        [apim.cache_invalidation]
        enabled = true
        domain = "control-plane-domain"
        ```
       
## Step 8 - Optionally, enable distributed cache invalidation

Add following configuration block in the `<API-M_HOME>/repository/conf/deployment.toml` file of both the nodes.

``` toml
[apim.cache_invalidation]
enabled = true
domain = "control-plane-domain"
```

## Step 9 - Configure API-M Analytics

API Manager Analytics is delivered via the API Manager Analytics cloud solution. You need to configure the API Manager Gateway to publish analytics data into the cloud.

See the instructions on [configuring the API Gateway]({{base_path}}/observe/api-manager-analytics/configure-analytics/configure-synapse-gateway) with the cloud-based analytics solution.

## Step 10 - Configure Production Hardening

In a **production setup**, ensure that you have taken into account the respective security hardening factors 
(e.g., changing and encrypting the default passwords, configuring JVM security etc.) and other production deployment 
guidelines (e.g., tuning parameters, backup and recovery remmendations etc.) before deploying WSO2 API-M nodes. 

For more information on security hardening guidelines, see [Security Guidelines for Production Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/security-guidelines-for-production-deployment/).

For more information on other production deployment guidelines, see [Production Deployment Guidelines]({{base_path}}/install-and-setup/deploying-wso2-api-manager/production-deployment-guidelines/#common-guidelines-and-checklist).

## Step 11 - Start the WSO2 API-M Servers

Start the WSO2 API-M servers using the standard start-up script. For more information, see [Starting the server]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

```tab="Linux/Mac OS"
cd <API-M_HOME>/bin/
sh api-manager.sh
```

```tab="Windows"
cd <API-M_HOME>\bin\
api-manager.bat --run 
```

!!! info
    If you want to deploy WSO2 API-M using a hybrid active-active deployment pattern, where WSO2 Identity Server is used 
    as the Key Manager in high availability mode while the rest of the WSO2 API-M components are all in one node, 
    configure and start the Key Manager (e.g., configure and start WSO2 Identity Server as the Key Manager) before 
    starting the API-M servers.

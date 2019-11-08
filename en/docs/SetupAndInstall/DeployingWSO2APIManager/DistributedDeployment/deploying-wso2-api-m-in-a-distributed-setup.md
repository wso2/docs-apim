# Deploying WSO2 API-M in a Distributed Setup

Follow the instructions below to deploy WSO2 API Manager (WSO2 API-M) in a distributed environment, as depicted in the following deployment diagram:

-   [Step 1 - Install and configure WSO2 API-M](#step-1-install-and-configure-wso2-api-m)
-   [Step 2 - Install and configure the databases](#step-2-install-and-configure-the-databases)
-   [Step 3 - Configure your deployment with production hardening](#step-3-configure-your-deployment-with-production-hardening)
-   [Step 4 - Create and import SSL certificates](#step-4-create-and-import-ssl-certificates)
-   [Step 5 - Configure API-M Analytics](#step-5-configure-api-m-analytics)
-   [Step 6 - Configure the connections among the components and start the servers](#step-6-configure-the-connections-among-the-components-and-start-the-servers)

![]({{base_path}}/assets/attachments/103334487/103334488.png)
### Step 1 - Install and configure WSO2 API-M

??? info "Click here for information on installing and configuring WSO2 API-M."

    The following steps describe how to download, install, and configure WSO2 API Manager, with five instances.
    
    1.  Download the [WSO2 API Manager](http://wso2.com/products/api-manager/) in each of the five servers in the cluster for distributed deployment.
    2.  Unzip the WSO2 API Manager zipped archive, and rename each of those directories respectively as Key Manager, Gateway, Publisher, Store, and Traffic Manager.
        These five directories are located in a server of their own and are used for each component of WSO2 API-M. Each of these unzipped directories are referred to as `<API-M_HOME>` or `<PRODUCT_HOME>` in this document.
    
    3.  In each of the five servers, replace the default certificates (where `CN=localhost` ) with new certificates generated with proper common name (CN) values.
        You need to do this in order to avoid getting an error with regard to the fact that the hostname in the certificate did not match.
    
        !!! note
            Note that you should use the same primary keystore for all the API Manager instances here in order to decrypt the registry resources. For more information, see [Configuring Primary Keystores](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products#ConfiguringKeystoresinWSO2Products-ConfiguringtheprimarykeystoreConfiguringtheprimarykeystore(forinternaldataencryption)) in the Administration Guide. When creating the keystore, always use a longer validity period so that it will avoid the need of migration on the registry data when shifting to a new keystore.


### Step 2 - Install and configure the databases

You can create the required databases for the API-M deployment in a separate server and point to the databases from the respective nodes. For information on configuring the databases, see [Installing and Configuring the Databases](../../SettingUpDatabases/overview.md).

### Step 3 - Configure your deployment with production hardening

Ensure that you have taken into account the respective security hardening factors (e.g., changing and encrypting the default passwords, configuring JVM security, etc.) before deploying WSO2 API-M. For more information, see the [Production Deployment Guidelines](https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines#ProductionDeploymentGuidelines-Commonguidelinesandchecklist) in the Administration Guide.

### Step 4 - Create and import SSL certificates

Create a SSL certificate for each of the WSO2 API-M nodes (e.g., Publisher, Store, Key Manager, Gateway, and Traffic Manager ) and import them to the keyStore and the trustStore. For more information, see [Creating SSL Certificates](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) in the Administration Guide.

!!! note
    When maintaining high availability (HA) i n the WSO2 API-M distributed set up , you need to create and import a SSL certificate for each of the WSO2 API-M HA nodes.


### Step 5 - Configure API-M Analytics

If you wish to view reports, statistics, and graphs related to the APIs deployed in the Store, you need to configure API-M Analytics. Follow the [standard setup](../../../../Learn/Analytics/configuring-apim-analytics/#standard-setup) to configure API-M Analytics in a production setup, and follow the [quick setup](../../../../Learn/Analytics/configuring-apim-analytics/#quick-setup) to configure API-M Analytics in a development setup.

### Step 6 - Configure the connections among the components and start the servers

You will now configure the inter-component relationships of the distributed setup by modifying their `<API-M_HOME>/repository/conf/deployment.toml` files. It is recommended to start the components in the following order: Key Manager, Traffic Manager, Publisher, Store and Gateway.

!!! note
    In a clustered environment, you use session affinity ( sticky sessions ) to ensure that requests from the same client always get routed to the same server.
    
    It is **mandatory** to set up Session Affinity in the load balancers that front the **Publisher** and **Store** clusters, and it is **optional** in the load balancer (if any) that fronts a **Key Manager** cluster or **Gateway** Cluster. However, you need to enable Session Affinity if you are working with multiple Gateway Managers in a Gateway High Availability (HA) deployment.

    However, authentication via session ID fails when session affinity is disabled in the load balancer.

    First time authentication happens via Basic Auth and the Gateway gets a cookie. This cookie is used in every consequent request along with the Basic Auth credentials. The admin service validates the cookie and if the validation fails it re-authenticates it using Basic Auth and issues a new cookie.


-   [Step 6.1 - Configure the common configurations](#step-61-configure-the-common-configurations)
-   [Step 6.2 - Configure and start the Key Manager](#step-62-configure-and-start-the-key-manager)
-   [Step 6.3 - Configure and start the API Publisher](#step-63-configure-and-start-the-api-publisher)
-   [Step 6.4 - Configure and start the API Store](#step-64-configure-and-start-the-api-store)
-   [Step 6.5 - Configure and start the Traffic Manager](#step-65-configure-and-start-the-traffic-manager)
-   [Step 6.6 - Configure and start the Gateway](#step-66-configure-and-start-the-gateway)

#### Step 6.1 - Configure the common configurations

The common configurations can be done automatically when starting up the server. For instructions, see [Starting an API-M profile](../product-profiles) .

!!! tip
    When a node starts, it starts all the components and featured bundled with it. If you are concerned about resource utilization, you can run the product on a specific profile, so that only the components and features that are required for that node and common features start up.

**Example**

``` java
    sh <PRODUCT_HOME>/bin/wso2server.sh -Dprofile=api-store
```

For more information on using multi-profile support, see [Product Profiles](../product-profiles) .

#### Step 6.2 - Configure and start the Key Manager

This section involves setting up the Key Manager node and enabling it to work with the other components in a distributed deployment .

!!! warning
    **Skip** this step if you are using **WSO2 Identity Server as the Key Manager** and follow the instructions mentioned in [Configuring WSO2 Identity Server as a Key Manager](../../ThirdPartyKeyManager/configuring-wso2-identity-server-as-a-key-manager/) to configure and start the Key Manager.
1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Key Manager node and change the `apim.gateway.environment` section, so that it points to the API Manager Gateway.
    You need to add these configurations so that when a user is deleted or when the role of a user is updated in the Key Manager, it will update the Gateway cache by clearing the cache entries of a particular user.
    -   If you are working with a **single Gateway** in distributed set up, you need to replace \[ `GATEWAY_SERVER_HOST]` with the host of the **Gateway** node.
    -   If you are working with **Gateways** in a **High Availability (HA)** setup, you need to replace \[ `GATEWAY_SERVER_HOST]` with the host of the **Gateway load balancer** node.
    -   You need to replace `[port]` with the management transport port. For more information, see [Default Product Ports](../../../../Administer/ProductAdministration/admin-default-ports-of-wso2-products/) .

        ``` toml
            [[apim.gateway.environment]]
            name = "Production and Sandbox"
            type = "hybrid"
            description = "This is a hybrid gateway that handles both production and sandbox token traffic."
            service_url = "https://$[GATEWAY_SERVER_HOST]:[port]/services/"
            ...
        ```

2.  If you wish to encrypt the Auth Keys (access tokens, client secrets, and authorization codes), see [Encrypting OAuth Keys](../../../../Learn/APISecurity/OAuth2DeepDive/encrypting-oauth-keys/) .


3.  Optionally, configure High Availability (HA) for the Key Manager.

    !!! warning
        These steps are **ONLY applicable** if you need to configure **HA for the Key Manager.**    
    
        1.  Make a copy of the active instance configured above and use this copy as the second Key Manager active instance.
        2.  Configure a load balancer to front the two Key Manager nodes.
        
        For information on configuring the load balancer, see [Configuring the Proxy Server and the Load Balancer](../../configuring-the-proxy-server-and-the-load-balancer/).

4.  Start the WSO2 API-M Key Manager node(s) by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](../../../InstallationGuide/running-the-product/) .


!!! note
    It is not recommended to share the Solr directory between the Store and Publisher servers. You need to have separate Solr directories for each of the latter mentioned servers so that they will perform Solr indexing separately.
!!! warning
    If you get an error similar to the following in both or one of the nodes, check whether you have shared the Solr directory.
    ``` java
        org.apache.solr.common.SolrException: 
        SolrCore 'registry-indexing' is not available due to init failure: Index locked for write for core registry-indexing
    ```

??? info "Click here to view sample configuration for the key manager"
    ``` toml
    [server]
    server_role = "api-key-manager"
    hostname = "km.wso2.com"
    node_ip = "127.0.0.1"
    offset=0
    
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
    
    [[apim.gateway.environment]]
    name = "Production and Sandbox"
    type = "hybrid"
    display_in_api_console= true
    description = "This is a hybrid gateway that handles both production and sandbox token traffic."
    service_url = "https://gw.wso2.com:9447/services/"
    username= "${admin.username}"
    password= "${admin.password}"
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm.wso2.com:9614"]
    traffic_manager_auth_urls=["ssl://tm.wso2.com:9714"]

    ```
#### Step 6.5 - Configure and start the Traffic Manager

This section involves setting up the Traffic Manager node(s) and enabling it to work with the other components in a distributed deployment.

3.  **Optionally** , mount the `<API-M_HOME>/repository/deployment/server` directory of all the Traffic Manager nodes to the shared file system.

    !!! warning
        This step is **ONLY applicable** if you are configuring the **Traffic Manager with HA** and **shared file system** as the content synchronization mechanism.

    You need to do this to share all the Throttling policies between traffic management nodes.


5.  Optionally, configure High Availability (HA) for the Traffic Manager.

    !!! warning
        This is **ONLY applicable** if you need to configure **HA for the Traffic Manager.**

    Make a copy of the active instance configured above and use this copy as the second active Traffic Manager instance.

6.  Start the WSO2 API-M Traffic Manager node(s) by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](../../../InstallationGuide/running-the-product/) .

    -   [**Linux/Mac OS**](#Linux-Mac)
    -   [**Windows**](#windows)

    ``` java
        cd <API-M_HOME>/bin/
        sh wso2server.sh -Dprofile=traffic-manager
    ```

    ``` java
        cd <API-M_HOME>\bin\
        wso2server.bat --run -Dprofile=traffic-manager
    ```

    !!! note
        Always start the Traffic Manager using the `-Dprofile=traffic-manager` profile **** to avoid FATAL errors such as the following.

    ``` java
        FATAL - ServiceBusInitializer Couldn't initialize the ESB...
        org.apache.synapse.SynapseException: The synapse.xml location ././
                ./repository/deployment/server/synapse-configs
            /default doesn't exist
    ```


    !!! note
        Troubleshooting
        If you have a firewall between the Traffic Manager and the Gateway, you need to configure the heartbeat value to keep the JMS connection alive. To configure this, open the `<APIM_HOME>/repository/conf/advanced/qpid-config.xml` file and set the heartbeat to a non-zero value as shown below.

        ``` java
            <heartbeat>    
                <delay>60</delay>
                <timeoutFactor>2.0</timeoutFactor>
            </heartbeat>
        ```

    ??? info "Click here to view sample configuration for the traffic manager"
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
        ```



#### Step 6.3 - Configure and start the API Publisher

This section involves setting up the API Publisher node and enabling it to work with the other components in the distributed deployment .

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the API Publisher node and make the following changes.

    1.  Configure the **Publisher with** the **Traffic Manager** .
        This configuration enables the publishing of throttling policies, custom templates, and block conditions to the Gateway node.

        -   [**Single Traffic Manager**](#single-TM-Publisher)
        -   [**Traffic Manager with HA**](#HA-TM-Publisher)

        Configure the **Publisher with** a **single Traffic Manager** as follows:

        ``` toml
            [apim.throttling]
            service_url = https://Traffic-Manager-host:${mgt.transport.https.port}/services/
            throttle_decision_endpoints = ["tcp://Traffic-Manager-host:5672"]

            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://Traffic-Manager-host:9611"]
            traffic_manager_auth_urls = ["ssl://Traffic-Manager-host:9711"]
        ```

        Configure the **Publisher with multiple Traffic Managers** that are fronted by a load balancer as follows:

        ``` toml
            [apim.throttling]
            service_url = https://[Traffic-Manager-LB-Host]:${mgt.transport.https.port}/services/
            throttle_decision_endpoints = ["tcp://Traffic-Manager-1-host:5672","tcp://Traffic-Manager-2-host:5672"]

            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://Traffic-Manager-1-host:9611"]
            traffic_manager_auth_urls = ["ssl://Traffic-Manager-1-host:9711"]
            
            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://Traffic-Manager-2-host:9611"]
            traffic_manager_auth_urls = ["ssl://Traffic-Manager-2-host:9711"]
        ```

    2.  Configure the **Publisher with the Gateway** .
        You need to add these configurations, because when creating an API, it calls the Gateway endpoint to create the actual Synapse file.

        -   If you are using a single Gateway node, configure the **Publisher** with the **Gateway** as follows:

            ``` toml
                [[apim.gateway.environment]]
                name = "Production and Sandbox"
                type = "hybrid"
                display_in_api_console = true
                description = "This is a hybrid gateway that handles both production and sandbox token traffic."
                show_as_token_endpoint_url = true
                service_url = "https://[API-Gateway-Host-or-IP]:${mgt.transport.https.port}/services/"
                username= "${admin.username}"
                password= "${admin.password}"
                ws_endpoint = "ws://[API-Gateway-Host-or-IP]:9099"
                wss_endpoint = "wss://[API-Gateway-Host-or-IP]:8099"
                http_endpoint = "http://[API-Gateway-Host-or-IP]:${http.nio.port}"
                https_endpoint = "https://[API-Gateway-Host-or-IP]:${https.nio.port}"
            ```

        -   If you are using **multiple Gateway nodes** , configure the **Publisher** with the **Gateway nodes** as follows:

            -   [**Gateway with Shared File System**](#gateway-with-NFS-Publisher)
            -   [**Gateway with rsync**](#gateway-with-rsync-Publisher)

            Configure the **Publisher when working with multiple Gateways** that are fronted by a load balancer when using a **shared file system** (e.g., NFS), to synchronize the data between your Gateway nodes as follows:

            ``` toml
                [[apim.gateway.environment]]
                name = "Production and Sandbox"
                type = "hybrid"
                display_in_api_console = true
                description = "This is a hybrid gateway that handles both production and sandbox token traffic."
                show_as_token_endpoint_url = true
                service_url = "https://[API-Gateway-LB-Host-or-IP]:${mgt.transport.https.port}/services/"
                username= "${admin.username}"
                password= "${admin.password}"
                ws_endpoint = "ws://[API-Gateway-LB-Host-or-IP]:9099"
                wss_endpoint = "wss://[API-Gateway-LB-Host-or-IP]:8099"
                http_endpoint = "http://[API-Gateway-LB-Host-or-IP]:${http.nio.port}"
                https_endpoint = "https://[API-Gateway-LB-Host-or-IP]:${https.nio.port}"
            ```

            Configure the **Publisher with a multiple Gateways** that are fronted by a load balancer when using Remote Synchronization ( **rsync),** to synchronize the data between your Gateway nodes as follows:

            ``` toml
                [[apim.gateway.environment]]
                name = "Production and Sandbox"
                type = "hybrid"
                display_in_api_console = true
                description = "This is a hybrid gateway that handles both production and sandbox token traffic."
                show_as_token_endpoint_url = true
                service_url = "https://[API-Gateway-Manager-Host]:${mgt.transport.https.port}/services/"
                username= "${admin.username}"
                password= "${admin.password}"
                ws_endpoint = "ws://[API-Gateway-Manager-Host]:9099"
                wss_endpoint = "wss://[API-Gateway-Manager-Host]:8099"
                http_endpoint = "http://[API-Gateway-Manager-Host]:${http.nio.port}"
                https_endpoint = "https://[API-Gateway-Manager-Host]:${https.nio.port}"
            ```

    3.  Configure the Dev portal URL to appear in the Publisher UI.

        -   [**Single Store**](#single-Store-Publisher)
        -   [**Store with HA**](#HA-Store-Publisher)

        Configure the **Publisher with a single API Dev portal** as follows:

        **Example**

        ``` toml
            [apim.devportal]
            url = "https://[devportal-hostname]:${mgt.transport.https.port}/devportal"
        ```

        Configure the **Publisher with multiple API Dev portals** that are fronted by a load balancer as follows:

        **Example**

        ``` toml
            [apim.devportal]
            url = "https://[devportal-LB-hostname]:${mgt.transport.https.port}/devportal"        
        ```

4.  Optionally, configure High Availability (HA) for the Publisher.

    !!! warning
        These instructions are **ONLY applicable** if you need to configure **HA for the Publisher.**

        1.  Make a copy of the active Publisher instance configured above and use this copy as the second active Publisher instance.
        2.  Configure a load balancer to front the two Publisher nodes.
        
        For information on configuring the load balancer, see [Configuring the Proxy Server and the Load Balancer](../../configuring-the-proxy-server-and-the-load-balancer/).

5.  Start the WSO2 API-M Publisher node(s) by typing the following command in the command prompt.
    For more information on starting a WSO2 server, see [Starting the server](../../../InstallationGuide/running-the-product/) .

??? info "Click here to view sample configuration for the publisher"
    ``` toml
    [server]
    hostname = "pub.wso2.com"
    node_ip = "127.0.0.1"
    server_role = "api-publisher"
    offset=1
    
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
    
    [[apim.gateway.environment]]
    name= "Production and Sandbox"
    type= "hybrid"
    display_in_api_console= true
    description= "This is a hybrid gateway that handles both production and sandbox token traffic."
    service_url= "https://gw.wso2.com:9447/services/"
    http_endpoint = "http://gw.wso2.com:8284"
    https_endpoint = "https://gw.wso2.com:8247"
    username= "${admin.username}"
    password= "${admin.password}"
    
    [apim.throttling]
    service_url = "https://tm.wso2.com:9446/services/"
    throttle_decision_endpoints = ["tcp://tm.wso2.com:5675"]
    username= "$ref{super_admin.username}"
    password= "$ref{super_admin.password}"
    
    [[apim.throttling.url_group]]
    traffic_manager_urls=["tcp://tm.wso2.com:9614"]
    traffic_manager_auth_urls=["ssl://tm.wso2.com:9714"]
    
    [apim.devportal]
    url = "https://store.wso2.com:9445/devportal"

    ```
#### Step 6.4 - Configure and start the API Store

This section involves setting up the API Store node and enabling it to work with the other components in the distributed deployment .

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the API Store node and make the following changes.

    1.  Configure the **API Store with the Key Manager.**

        -   [**Single Key Manager**](#single-Key-Manager-Store)
        -   [**Key Manager with HA**](#HA-Key-Manager-Store)

        Configure the **API Store with a single Key Manager** as follows:

        1.  Configure the API key validator.

            ``` toml
                [apim.key_manager]
                service_url = "https://[Key-Manager-host]:${mgt.transport.https.port}/services/"
                username = "$ref{super_admin.username}"
                password = "$ref{super_admin.password}"
            ```

        Configure the **Store with multiple Key Managers** that are fronted by a load balancer as follows:

        1.  Configure the API key validator.

            ``` toml
                [apim.key_manager]
                service_url = "https://[Key-Manager-LB-host]:${mgt.transport.https.port}/services/"
                username = "$ref{super_admin.username}"
                password = "$ref{super_admin.password}"
            ```

    3.  Configure the **Store with** the **Gateway** .

        -   If you are using a single Gateway node, configure the **Store** with the **Gateway** as follows:

            ``` toml
                [[apim.gateway.environment]]
                name = "Production and Sandbox"
                type = "hybrid"
                display_in_api_console = true
                description = "This is a hybrid gateway that handles both production and sandbox token traffic."
                show_as_token_endpoint_url = true
                service_url = "https://[API-Gateway-host-or-IP]:${mgt.transport.https.port}/services/"
                username= "${admin.username}"
                password= "${admin.password}"
                ws_endpoint = "ws://[API-Gateway-host-or-IP]:9099"
                wss_endpoint = "wss://[API-Gateway-host-or-IP]:8099"
                http_endpoint = "http://[API-Gateway-host-or-IP]:${http.nio.port}"
                https_endpoint = "https://[API-Gateway-host-or-IP]:${https.nio.port}"
            ```

        -   If you are using **multiple Gateway nodes** , configure the **Store** with the **Gateway nodes** as follows:

            Configure the **Store when working with multiple Gateways** that are fronted by a load balancer as follows:

            ``` toml
                [[apim.gateway.environment]]
                name = "Production and Sandbox"
                type = "hybrid"
                display_in_api_console = true
                description = "This is a hybrid gateway that handles both production and sandbox token traffic."
                show_as_token_endpoint_url = true
                service_url = "https://[API-Gateway-LB-Host-or-IP]:${mgt.transport.https.port}/services/"
                username= "${admin.username}"
                password= "${admin.password}"
                ws_endpoint = "ws://[API-Gateway-LB-Host-or-IP]:9099"
                wss_endpoint = "wss://[API-Gateway-LB-Host-or-IP]:8099"
                http_endpoint = "http://[API-Gateway-LB-Host-or-IP]:${http.nio.port}"
                https_endpoint = "https://[API-Gateway-LB-Host-or-IP]:${https.nio.port}"
                            
            ```

    4.  Configure the Token Revoke endpoint to point to Gateway.

        -   [**Single Gateway**](#tokenRevoke-GW)
        -   [**Gateway with HA**](#tokenRevoke-2GW)

        Configure the **Token Revoke endpoint with a single Gateway** as follows:

        ``` toml
            [apim.oauth_config]
            revoke_endpoint = "https://[API-Gateway-host-or-IP]:${https.nio.port}/revoke"
        ```

        Configure the **Token Revoke endpoint with multiple Gateways** , which are fronted by a load balancer as follows:

        ``` toml
            [apim.oauth_config]
            revoke_endpoint = "https://[API-Gateway-LB-Host-or-IP]:${https.nio.port}/revoke"
        ```

3.  Optionally, configure High Availability (HA) for the Store.

    !!! warning
        This is **ONLY applicable** if you need to configure **HA for the Store.**

    Make a copy of the active instance configured above and use this copy as the second API Store active instance.

4.  Start the API Store node(s) by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](../../../InstallationGuide/running-the-product/) .

    ??? info "Click here to view sample configuration for the dev portal"
        ``` toml
        [server]
        hostname = "store.wso2.com"
        node_ip = "127.0.0.1"
        server_role="api-store"
        offset=2
        
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
        
        [[apim.gateway.environment]]
        name= "Production and Sandbox"
        type= "hybrid"
        display_in_api_console= true
        description= "This is a hybrid gateway that handles both production and sandbox token traffic."
        service_url= "https://gw.wso2.com:9447/services/"
        username= "${admin.username}"
        password= "${admin.password}"
        ws_endpoint= "ws://gw.wso2.com:9099"
        http_endpoint = "http://gw.wso2.com:8284"
        https_endpoint = "https://gw.wso2.com:8247"
        show_as_token_endpoint_url = true
        
        [apim.key_manager]
        service_url = "https://km.wso2.com:9443/services/"
        username= "$ref{super_admin.username}"
        password= "$ref{super_admin.password}"
        
        [apim.oauth_config]
        revoke_endpoint = "https://gw.wso2.com:8247/revoke"
        
        ```

#### Step 6.6 - Configure and start the Gateway

This section involves setting up the Gateway node and enabling it to work with the other components in the distributed deployment .

!!! note
    **Steps 1 to 5** in the following section are **common** irrespective of your API-M deployment, such as deploying a single Gateway node or deploying multiple Gateway nodes for High Availability (HA). However, if you are using two Gateway nodes for high availability (HA), first follow the instructions that is available in the \_Distributed Deployment of the Gateway document, and then carry out the following steps to configure the connections from Gateway(s) to other components.
1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file in the Gateway node.
2.  Modify the `deployment.toml` file as follows. This configures the connection to the Key Manager component.

    -   [**Single Key Manager**](#single-Key-Manager-GW)
    -   [**Key Managers with HA**](#HA-Key-Manager-GW)

    Configure the **Gateway with a single Key Manager** as follows:

    1.  Configure the API Key Validator.

        ``` toml
            [apim.key_manager]
            service_url = "https://[Key-Manager-host]:${mgt.transport.https.port}/services/"
            username = "$ref{super_admin.username}"
            password = "$ref{super_admin.password}"
        ```
    `[Key-Manager-host]` - If you have a single Key Manager node, this should be the host of the Key Manager (i.e., the host of the WSO2 Identity Server).

    Configure the **Gateway with multiple Key Managers** , which are fronted by a load balancer as follows:

    1.  Configure the `Key Manager` as follows:

        ``` toml
                [apim.key_manager]
                service_url = "https://[Key-Manager-LB-host]:${mgt.transport.https.port}/services/"
                username = "$ref{super_admin.username}"
                password = "$ref{super_admin.password}"                
        ```

        -`[Key-Manager-LB-host]` - If there are multiple Key Managers (i.e., Multiple WSO2 Identity Servers as the Key Manager) fronted by a load balancer, this should be the host of the Key Manager's load balancer. For example, in the configuration we have defined `key-manager` as the load balancer host in the Key Manager section.

3.  If you need to enable JSON Web Token (JWT),  you have to enable it in all Gateway and Key Manager components.
    For more information on configuring JWT, see [Generating JSON Web Token](../../../../Learn/APIGateway/PassingEndUserAttributesToTheBackend/passing-enduser-attributes-to-the-backend-using-jwt/) .

4.  Configure the Gateway to communicate with the Traffic Manager.
    You need to do this to enable Throttling for the Traffic Manager node(s).

    !!! warning
        These configurations vary based on whether you have a single Traffic Manager node or multiple Traffic Manager nodes.

    -   [**Single Traffic Manager**](#single-TM-GW)
    -   [**HA of Traffic Manager**](#TM-HA-GW)

    Configure the **Gateway with a single Traffic Manager** as follows:

    !!! Info
        9611 and 9711 are the Traffic Manager receiver ports for the binary type.
    1.  Update the Throttling configurations as follows:

        ``` toml
            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://Traffic-Manager-host:9611"]
            traffic_manager_auth_urls = ["ssl://Traffic-Manager-host:9711"]
            
            [apim.throttling]
            throttle_decision_endpoints = ["tcp://Traffic-Manager-host:5672"]
        ```

    Configure the **Gateway with multiple Traffic Managers** , which are fronted by a load balancer as follows:
    
    The Gateway publishes all Throttling events to the two Traffic Manager instances, and it fetches the throttle decisions from the Traffic Manager instances. Follow the instructions below to configure the API Gateway worker to communicate with the Traffic Managers and to push throttle events to both Traffic Manager instances.

    1.  Configure the receiver URL group `traffic_manager_urls` and Authentication URL Group `traffic_manager_auth_urls` values, which are under the `[[apim.throttling.url_group]]` element in the `<API-M_HOME>/repository/conf/deployment.toml` file, in order to contain all the Traffic Manager receiver URLs.
        This is required when you have more than one Traffic Manager instance, and you are publishing to both as per the deployment pattern selected. As an example, if you are using two Traffic Manager instances and data should be published to both of them, the `traffic_manager_urls` and `traffic_manager_auth_urls` should be configured as follows:

        **Example**

        ``` toml
            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://Traffic-Manager-1-host:9611"]
            traffic_manager_auth_urls = ["ssl://Traffic-Manager-1-host:9711"]
            
            [[apim.throttling.url_group]]
            traffic_manager_urls = ["tcp://Traffic-Manager-2-host:9611"]
            traffic_manager_auth_urls = ["ssl://Traffic-Manager-2-host:9711"]
            
            [apim.throttling]
            throttle_decision_endpoints = ["tcp://Traffic-Manager-1-host:5672", "tcp://Traffic-Manager-2-host:5672"]
        ```

    `[Traffic-Manager-1-host]` and \[ `Traffic-Manager-2-host]` are the IPs/hostnames of two Traffic Manager nodes.

    Based on the above configuration, the API Gateway publishes events to both the Traffic Managers.

    !!! info
        By default, WSO2 API Manager is shipped with a keystore ( `wso2carbon.jks` ) and a trust store ( `client-truststore.jks` ). For more information on how to create a new key store and a trust store with a private key and a self-signed certificate, see Configuring Keystore and Truststore and also see the [Administration guide](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption#UsingAsymmetricEncryption-RecommendationsforsettingupkeystoresinWSO2products) for r ecommendations on setting up keystores in WSO2 products.


5.  Start the WSO2 API-M Gateway node by typing the following command in the command prompt. For more information on starting a WSO2 server, see [Starting the server](../../../InstallationGuide/running-the-product/) .

    ??? info "Click here to view sample configuration for the gateway"
        ``` toml
        [server]
        hostname = "gw.wso2.com"
        node_ip = "127.0.0.1"
        server_role = "gateway-worker"
        offset=4
        
        [user_store]
        type = "database"
        
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
        throttle_decision_endpoints = ["tcp://tm.wso2.com:5675"]
        
        [[apim.throttling.url_group]]
        traffic_manager_urls=["tcp://tm.wso2.com:9614"]
        traffic_manager_auth_urls=["ssl://tm.wso2.com:9714"]
        
        [apim.cors]
        allow_origins = "*"
        allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
        allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction"]
        allow_credentials = false
        
        
        ```




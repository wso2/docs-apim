# Configuring an Active-Active Deployment

This page walks you through how to manually configure WSO2 API Manager (WSO2 API-M) with two active nodes that each has all the components of the API-M together in one instance (all-in-one instance).

[![Active active deployment]({{base_path}}/assets/img/setup-and-install/active-active-deployment.png)]({{base_path}}/assets/img/setup-and-install/active-active-deployment.png)

Follow the instructions below to configure and deploy API-M by using an Active-Active deployment:

-   [Step 1 - Create a SSL Certificate](#step-1-create-a-ssl-certificate)
-   [Step 2 - Configure the Load Balancer](#step-2-configure-the-load-balancer)
-   [Step 3 - Configure the Databases](#step-3-configure-the-databases)
-   [Step 4 - Configure the Second WSO2 API-M Node](#step-4-configure-the-second-wso2-api-m-node)
-   [Step 5 - Configure the Artifact Synchronization](#step-5-configure-the-artifact-synchronization)
-   [Step 6 - Configure Publisher with the Gateway](#step-6-configure-publisher-with-the-gateway)
-   [Step 7 - Configure Gateway URLs to Expose APIs](#step-7-configure-gateway-urls-to-expose-apis)
-   [Step 8 - Configure Throttling](#step-8-configure-throttling)
-   [Step 9 - Optionally, enable distributed cache invalidation](#step-9-optionally-enable-distributed-cache-invalidation)  
-   [Step 10 - Configure API-M Analytics](#step-9-configure-api-m-analytics)
-   [Step 11 - Configure Production Hardening](#step-10-configure-production-hardening)
-   [Step 12 - Start the WSO2 API-M Servers](#step-11-start-the-wso2-api-m-servers)

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


## Step 5 - Configure the Artifact Synchronization 

To enable synchronization for runtime artifacts of the two all in one WSO2 API-M instances, it is recommended to have a
shared file system. Configure a shared file system as the content synchronization mechanism. You can use a common shared file 
system such as Network File System (NFS) or any other shared file system that is available. 

You need to mount the following folders of the two nodes to the shared file system, in order to share the resources between all the nodes.

1.  `<APIM_HOME>/repository/deployment/server/userstores` -  If a secondary user store has been configured in the super tenant, this folder needs to be backed up.
2.  `<APIM_HOME>/repository/deployment/server/executionplans` - Includes siddhi queries related to event processing logic.
3.  `<APIM_HOME>/repository/deployment/server/synapse-configs` - Includes API gateway configuration files.
4.  `<APIM_HOME>/repository/tenants` - If tenancy is been used.

??? note "NFS configuration"
    For more information on setting up NFS on Ubuntu, see [Network File System (NFS)](https://ubuntu.com/server/docs/service-nfs).
    Note that these configurations may change depending on the OS.

??? info "If you are unable to maintain a shared file system"

    However, if you are unable to maintain a shared file system, you can synchronize content using rsync. For 
    information on setting up a rsync based deployment synchronization, see [Configuring rsync for Deployment 
    Synchronization]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-rsync-for-deployment-synchronization).

    !!! warning
        **Shared file system** is the **first preference** that WSO2 recommends to synchronize the artifacts among the nodes, 
        because APIs and throttling decisions can be published to any of the nodes; thereby, avoiding the  vulnerability 
        of a single point of failure that is present when using remote synchronization (rsync).
    
## Step 6 - Configure Publisher with the Gateway

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

## Step 7 - Configure Gateway URLs to Expose APIs

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
    ```            

## Step 8 - Configure Throttling

1.  Configure the data publisher in the `apim.throttling.url_group` section which comes under the `apim.throttling.url_group` block in the `<API-M_HOME>/repository/conf/deployment.toml` file of both nodes.
    
    1.  You need to update these configurations so that the Gateway can publish data to the Traffic Manager in its own node and the Traffic Manager in the other node, so that the same event is sent to both servers at the same time. 

        The WSO2 Complex Event Processor (WSO2 CEP) component that lies within the Traffic Manager acts as the data receiver and processes the data to come up with Throttling decisions.

        Node1

        ``` tab="Format"
        [apim.throttling]
        event_duplicate_url = ["tcp://<node2-hostname>:<node2-port>"]

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://<node1-hostname>:<node1-port>"]
        traffic_manager_auth_urls = ["ssl://<node1-hostname>:<node1-port>"]
        type = "loadbalance"

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://<node2-hostname>:<node2-port>"]
        traffic_manager_auth_urls = ["ssl://<node2-hostname>:<node2-port>"]
        type = "loadbalance"
        ```

        ``` tab="Example"
        [apim.throttling]
        event_duplicate_url = ["tcp://127.0.0.1:5673"]

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://127.0.0.1:9611"]
        traffic_manager_auth_urls = ["ssl://127.0.0.1:9711"]
        type = "loadbalance"

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://127.0.0.1:9612"]
        traffic_manager_auth_urls = ["ssl://127.0.0.1:9712"]
        type = "loadbalance"
        ```

        Node2
        
        ``` tab="Format"
        [apim.throttling]
        event_duplicate_url = ["tcp://<node1-hostname>:<node1-port>"]

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://<node1-hostname>:<node1-port>"]
        traffic_manager_auth_urls = ["ssl://<node1-hostname>:<node1-port>"]
        type = "loadbalance"

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://<node2-hostname>:<node2-port>"]
        traffic_manager_auth_urls = ["ssl://<node2-hostname>:<node2-port>"]
        type = "loadbalance"
        ```

        ``` tab="Example"
        [apim.throttling]
        event_duplicate_url = ["tcp://127.0.0.1:5672"]

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://127.0.0.1:9611"]
        traffic_manager_auth_urls = ["ssl://127.0.0.1:9711"]
        type = "loadbalance"

        [[apim.throttling.url_group]]
        traffic_manager_urls = ["tcp://127.0.0.1:9612"]
        traffic_manager_auth_urls = ["ssl://127.0.0.1:9712"]
        type = "loadbalance"
        ```

    2.  Save your changes.

## Step 9 - Optionally, enable distributed cache invalidation

Add following configuration block in the `<API-M_HOME>/repository/conf/deployment.toml` file of both the nodes.

``` toml
[apim.cache_invalidation]
enabled = true
```

## Step 10 - Configure API-M Analytics

If you wish to view reports, statistics, and graphs related to the APIs deployed in the WSO2 API Manager, you need to 
configure API-M Analytics. If not, you can **skip this step**.

Follow the [Configuring API-M Anlaytics - Quick Setup]({{base_path}}/learn/analytics/configuring-apim-analytics/#quick-setup) to configure API-M Analytics in a development setup and, follow 
[Configuring API-M Analytics - Standard Setup]({{base_path}}/learn/analytics/configuring-apim-analytics/#standard-setup) 
to configure API-M Analytics in a production setup.

## Step 11 - Configure Production Hardening

In a **production setup**, ensure that you have taken into account the respective security hardening factors 
(e.g., changing and encrypting the default passwords, configuring JVM security etc.) and other production deployment 
guidelines (e.g., tuning parameters, backup and recovery remmendations etc.) before deploying WSO2 API-M nodes. 

For more information on security hardening guidelines, see [Security Guidelines for Production Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/security-guidelines-for-production-deployment/).

For more information on other production deployment guidelines, see [Production Deployment Guidelines]({{base_path}}/install-and-setup/deploying-wso2-api-manager/production-deployment-guidelines/#common-guidelines-and-checklist).

## Step 12 - Start the WSO2 API-M Servers

Start the WSO2 API-M servers using the standard start-up script. For more information, see [Starting the server]({{base_path}}/install-and-setup/installation-guide/running-the-product/#starting-the-server).

```tab="Linux/Mac OS"
cd <API-M_HOME>/bin/
sh wso2server.sh
```

```tab="Windows"
cd <API-M_HOME>\bin\
wso2server.bat --run 
```

!!! info
    If you want to deploy WSO2 API-M using a hybrid active-active deployment pattern, where WSO2 Identity Server is used 
    as the Key Manager in high availability mode while the rest of the WSO2 API-M components are all in one node, 
    configure and start the Key Manager (e.g., configure and start WSO2 Identity Server as the Key Manager) before 
    starting the API-M servers.

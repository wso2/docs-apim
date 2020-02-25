# Configuring an Active-Active Deployment

This page walks you through how to manually configure WSO2 API Manager (WSO2 API-M) with two active nodes that each have all the components of the API-M together in one instance (all-in-one instance).

<a href="{{base_path}}/assets/img/setup-and-install/active-active-deployment.png" ><img src="{{base_path}}/assets/img/setup-and-install/active-active-deployment.png" alt="Active active deployment" title="Active active deployment" width="100%" /></a>

Follow the instructions below to configure and deploy API-M by using an Active-Active deployment:

-   [Step 1 - Create a SSL certificate](#step-1-create-a-ssl-certificate)
-   [Step 2 - Configure the load balancer](#step-2-configure-the-load-balancer)
-   [Step 3 - Configure the databases](#step-3-configure-the-databases)
-   [Step 4 - Configure the Publisher with the Gateway](#step-4-configure-the-publisher-with-the-gateway)
-   [Step 5 - Configure the content synchronization mechanism](#step-5-configure-the-content-synchronization-mechanism)
-   [Step 6 - Configure Throttling](#step-6-configure-throttling)
-   [Step 7 - Configure the second WSO2 API-M node](#step-7-configure-the-second-wso2-api-m-node)
-   [Step 8 - Configure your deployment with production hardening](#step-8-configure-your-deployment-with-production-hardening)
-   [Step 9 - Configure Analytics](#step-9-configure-analytics)
-   [Step 10 - Start the WSO2 API-M servers](#step-10-start-the-wso2-api-m-servers)

### Step 1 - Create a SSL certificate

Create a SSL certificate on the first WSO2 API-M all-in-one active node. For more information, see [Creating SSL Certificates](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) in the Administration Guide.

### Step 2 - Configure the load balancer

For information on configuring the load balancer, see [Configuring the Proxy Server and the Load Balancer](../configuring-the-proxy-server-and-the-load-balancer.md).

### Step 3 - Configure the databases

For information on configuring the databases, see [Installing and Configuring the Databases](../../setting-up-databases/overview.md).

### Step 4 - Configure the Publisher with the Gateway

!!! note
    This step is required **only** if you are using rsync to share files.

    !!! info
        When you use rsync the file synchronization will happen in only one direction. Therefore, use the following configuration to enable synchronization in both directions between two nodes.

    For more details, see the [next step](#step-5-configure-the-content-synchronization-mechanism).

Configure the API Publisher in both nodes to be able to publish to the API-M Gateway of one of the nodes. Do this by pointing the `service_url` to the same Gateway node.

You need to configure this in the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` java
[[apim.gateway.environment]]
...
service_url = "https://localhost:${mgt.transport.https.port}/services/"
...
```

### Step 5 - Configure the content synchronization mechanism

Configure a shared file system as the content synchronization mechanism. You can use a common shared file system such as Network File System (NFS) or any other shared file system that is available. You need to mount the `<API-M_HOME>/repository/deployment/server` directory of the two nodes to the shared file system, in order to share all APIs and throttling policies between all the nodes.

!!! info
    Shared file system is the first preference that WSO2 recommends to synchronize the artifacts among the nodes, because APIs and throttling decisions can be published to any of the nodes; thereby, avoiding the vulnerability of a single point of failure that is present when using remote synchronization (rsync). However, if you are unable to maintain a shared file system, you can synchronize content using rsync. For information on setting up a rsync based deployment synchronization, see [Configuring rsync for Deployment Synchronization](../configuring-rsync-for-deployment-synchronization.md).

    #### Using Rsync for deployment synchronization

    If you are using rsync, the API artifacts will be synchronized to one direction. As explained in [Configuring rsync for Deployment Synchronization](../configuring-rsync-for-deployment-synchronization.md) section, the synchronization will happen from manager to worker. Hence, The API artifact should be created on one node only, which acts like a manager node for artifact synchronization purpose. Please follow the steps below to configure this:
    Assuming node-1 is the manager node for artifact synchronization,

    1.  Open `<API-M_HOME>/repository/conf/deployment.toml` file in node-1.
    2.  Configure Gateway Service URL to point to its own (localhost):

        ``` java
        [[apim.gateway.environment]]
        ...
        service_url = "https://localhost:${mgt.transport.https.port}/services/"
        ...
        ```

    3.  Open `<API-M_HOME>/repository/conf/deployment.toml` file in node-2.
    4.  Configure Gateway Service URL to point to the node-1:

        ``` java
        [[apim.gateway.environment]]
        ...
        service_url = "https://<node1-hostname>:<node-1-mgt-transport-port>/services/"
        ...
        ```
        Note that `<node-1-mgt-transport-port>` is the management transport port, which is by default 9443.

### Step 6 - Configure Throttling

1.  Configure the data publisher in the `apim.throttling.url_group` section which comes under the `apim.throttling.url_group` block in the `<API-M_HOME>/repository/conf/deployment.toml` file.
    
    You need to update these configurations so that the Gateway can publish data to the Traffic Manager in its own node and the Traffic Manager in the other node, so that the same event is sent to both servers at the same time. The WSO2 Complex Event Processor (WSO2 CEP) component that lies within the Traffic Manager acts as the data receiver and process the data to come up with the Throttling decisions.

    ``` tab="Format"
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

### Step 7 - Configure the second WSO2 API-M node

Make a copy of the active instance configured above and use this copy as the second active instance.

!!! info
    When making a copy of the node, you need to also make a copy of the SSL certificate that you created for node 1 in [step 1](#step-1-create-a-ssl-certificate).


### Step 8 - Configure your deployment with production hardening

Ensure that you have taken into account the respective security hardening factors (e.g., changing and encrypting the default passwords, configuring JVM security etc.) before deploying WSO2 API-M. For more information, see the [Production Deployment Guidelines](https://docs.wso2.com/display/ADMIN44x/Production+Deployment+Guidelines#ProductionDeploymentGuidelines) in the Administration Guide.

### Step 9 - Configure Analytics

If you wish to view reports, statistics, and graphs related to the APIs deployed in the Developer Portal, you need to configure API-M Analytics. Follow the [standard setup](https://apim.docs.wso2.com/en/latest/learn/analytics/configuring-apim-analytics/#standard-setup) to configure API-M Analytics in a production setup, and follow the [quick setup](https://apim.docs.wso2.com/en/latest/learn/analytics/configuring-apim-analytics/#quick-setup) to configure API-M Analytics in a development setup.

### Step 10 - Start the WSO2 API-M servers

!!! note
    Before you start the servers;

    If you want to deploy WSO2 API-M using a hybrid active-active deployment pattern, where WSO2 Identity Server is used as the Key Manager in high availability mode while the rest of the WSO2 API-M components are all in one node, configure and start the Key Manager (e.g., configure and start WSO2 Identity Server as the Key Manager) before starting the API-M servers.

Start the WSO2 API-M servers using the standard start-up script. For more information, see [Starting the server](https://apim.docs.wso2.com/en/latest/install-and-setup/installation-guide/running-the-product/#starting-the-server).

```tab="Linux/Mac OS"
cd <API-M_HOME>/bin/
sh wso2server.sh
```

```tab="Windows"
cd <API-M_HOME>\bin\
wso2server.bat --run 
```

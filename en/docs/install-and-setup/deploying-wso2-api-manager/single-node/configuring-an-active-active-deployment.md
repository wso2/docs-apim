# Configuring an Active-Active Deployment

This page walks you through how to manually configure WSO2 API Manager (WSO2 API-M) with two active nodes that each has all the components of the API-M together in one instance (all-in-one instance).

[![Active active deployment]({{base_path}}/assets/img/setup-and-install/active-active-deployment.png)]({{base_path}}/assets/img/setup-and-install/active-active-deployment.png)

Follow the instructions below to configure and deploy API-M by using an Active-Active deployment:

-   [Step 1 - Create a SSL Certificate](#step-1-create-a-ssl-certificate)
-   [Step 2 - Configure the Load Balancer](#step-2-configure-the-load-balancer)
-   [Step 3 - Configure the Databases](#step-3-configure-the-databases)
-   [Step 4 - Configure the Artifact Synchronization](#step-4-configure-the-artifact-synchronization)
-   [Step 5 - Configure the Publisher with the Gateway](#step-5-configure-the-publisher-with-the-gateway)
-   [Step 6 - Configure Throttling](#step-6-configure-throttling)
-   [Step 7 - Configure the Second WSO2 API-M Node](#step-7-configure-the-second-wso2-api-m-node)
-   [Step 8 - Configure API-M Analytics](#step-8-configure-api-m-analytics)
-   [Step 9 - Configure Production Hardening](#step-9-configure-production-hardening)
-   [Step 10 - Start the WSO2 API-M Servers](#step-10-start-the-wso2-api-m-servers)

___________________________________

## Step 1 - Create a SSL Certificate

!!! note
    This step is **optional** based on the setup that you configure. If you are trying out in a **development setup**, 
    you may **skip this step**, as all WSO2 products are by default shipped with a 
    keystore file and truststore file stored in the `<PRODUCT_HOME>/repository/resources/security/ directory`. 

The default keystore that is shipped with a WSO2 product, `wso2carbon.jks` is configured with
private key and self signed public key pair for all purposes, such as encrypting sensitive information, communicating over SSL etc. 
   
However, in a **production setup**, it is advised to set up several different keystores with separate trust chains for the above use cases. For more information, see [Recommendations for setting up keystores in WSO2 products]({{base_path}}/administer/product-security/configuring-keystores/configuring-keystores-in-wso2-api-manager/#recommendations-for-setting-up-keystores).

To create an all purpose keystore or multiple keystores for authentication and protection of data, follow the steps in [Creating New Keystores]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/creating-new-keystores/). 

If you are creating new keystores, first create for first WSO2 API-M all in one node and copy to the second WSO2 API-M all 
in one node.

## Step 2 - Configure the Load Balancer

Follow the steps in [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-the-proxy-server-and-the-load-balancer) to configure the load balancer/reverse proxy which is fronting the API-M nodes
in the demiliterized zone (DMZ).

## Step 3 - Configure the Databases

WSO2 API-M is shipped with H2 databases by default. However, in a **production setup**, it is recommended to use an industry-standard RDBMS databases. For more information on default databases and changing them into RDBMS databases, see [Working with Databases]({{base_path}}/install-and-setup/setting-up-databases/overview/).

## Step 4 - Configure the Artifact Synchronization 

To enable synchronization for runtime artifacts of the two all in one WSO2 API-M instances, it is recommended to have a
shared file system. Configure a shared file system as the content synchronization mechanism. You can use a common shared file 
system such as Network File System (NFS) or any other shared file system that is available. 

You need to mount the `<API-M_HOME>/repository/deployment/server` directory of the two nodes to the shared file system, 
in order to share all APIs and throttling policies between all the nodes.

??? info "If you are unable to maintain a shared file system"

    However, if you are unable to maintain a shared file system, you can synchronize content using rsync. For 
    information on setting up a rsync based deployment synchronization, see [Configuring rsync for Deployment 
    Synchronization]({{base_path}}/install-and-setup/deploying-wso2-api-manager/configuring-rsync-for-deployment-synchronization).

    !!! warning
        **Shared file system** is the **first preference** that WSO2 recommends to synchronize the artifacts among the nodes, 
        because APIs and throttling decisions can be published to any of the nodes; thereby, avoiding the  vulnerability 
        of a single point of failure that is present when using remote synchronization (rsync).
    
## Step 5 - Configure the Publisher with the Gateway

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

## Step 6 - Configure Throttling

1.  Configure the data publisher in the `apim.throttling.url_group` section which comes under the `apim.throttling.url_group` block in the `<API-M_HOME>/repository/conf/deployment.toml` file.
    
    You need to update these configurations so that the Gateway can publish data to the Traffic Manager in its own node 
    and the Traffic Manager in the other node, so that the same event is sent to both servers at the same time. 
    The WSO2 Complex Event Processor (WSO2 CEP) component that lies within the Traffic Manager acts as the data receiver 
    and processes the data to come up with Throttling decisions.

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

## Step 7 - Configure the Second WSO2 API-M Node

Make a copy of the active instance configured above and use this copy as the second active instance.

!!! info
    When making a copy of the node, you need to also make a copy of the SSL certificate that you created for node 1 
    in [step 1]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/creating-new-keystores).

## Step 8 - Configure API-M Analytics

If you wish to view reports, statistics, and graphs related to the APIs deployed in the WSO2 API Manager, you need to 
configure API-M Analytics. If not, you can **skip this step**.

Follow the [Configuring API-M Anlaytics - Quick Setup]({{base_path}}/learn/analytics/configuring-apim-analytics/#quick-setup) to configure API-M Analytics in a development setup and, follow 
[Configuring API-M Analytics - Standard Setup]({{base_path}}/learn/analytics/configuring-apim-analytics/#standard-setup) 
to configure API-M Analytics in a production setup.

## Step 9 - Configure Production Hardening

In a **production setup**, ensure that you have taken into account the respective security hardening factors 
(e.g., changing and encrypting the default passwords, configuring JVM security etc.) before deploying WSO2 API-M. 
For more information, see [Security Guidelines for Production Deployment]({{base_path}}/install-and-setup/deploying-wso2-api-manager/security-guidelines-for-production-deployment/).

## Step 10 - Start the WSO2 API-M Servers

Start the WSO2 API-M servers using the standard start-up script. For more information, see [Starting the server](https://apim.docs.wso2.com/en/latest/install-and-setup/installation-guide/running-the-product/#starting-the-server).

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

# Configuring an Active-Active Deployment

This page walks you through how to manually configure WSO2 API Manager (WSO2 API-M) with two active nodes that each have all the components of the API-M together in one instance (all-in-one instance).

The page: **\_Deploying API Manager using Single Node Instances** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

Follow the instructions below to configure and deploy API-M by using an Active-Active deployment :

-   [Step 1 - Create a SSL certificate](#ConfiguringanActive-ActiveDeployment-step1Step1-CreateaSSLcertificate)
-   [Step 2 - Configure the load balancer](#ConfiguringanActive-ActiveDeployment-Step2-Configuretheloadbalancer)
-   [Step 3 - Configure the databases](#ConfiguringanActive-ActiveDeployment-Step3-Configurethedatabases)
-   [Step 4 - Configure the Publisher with the Gateway](#ConfiguringanActive-ActiveDeployment-Step4-ConfigurethePublisherwiththeGateway)
-   [Step 5 - Configure the content synchronization mechanism](#ConfiguringanActive-ActiveDeployment-Step5-ConfigurethecontentsynchronizationmechanismStep5)
-   [Step 6 - Configure Throttling](#ConfiguringanActive-ActiveDeployment-Step6-ConfigureThrottling)
-   [Step 7 - Configure the second WSO2 API-M node](#ConfiguringanActive-ActiveDeployment-Step7-ConfigurethesecondWSO2API-Mnode)
-   [Step 8 - Configure your deployment with production hardening](#ConfiguringanActive-ActiveDeployment-Step8-Configureyourdeploymentwithproductionhardening)
-   [Step 9 - Configure Analytics](#ConfiguringanActive-ActiveDeployment-Step9-ConfigureAnalytics)
-   [Step 10 - Start the WSO2 API-M servers](#ConfiguringanActive-ActiveDeployment-Step10-StarttheWSO2API-Mservers)

### Step 1 - Create a SSL certificate

Create a SSL certificate on the first WSO2 API-M all-in-one active node. For more information, see [Creating SSL Certificates](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) in the Administration Guide.

### Step 2 - Configure the load balancer

For information on configuring the load balancer, see \_Configuring the Proxy Server and the Load Balancer .

### Step 3 - Configure the databases

For information on configuring the databases, see \_Installing and Configuring the Databases .

### Step 4 - Configure the Publisher with the Gateway

!!! note
This step is required **only** if you are using rsync to share files.

!!! info
When you use rsync the file synchronization will happen in only one direction. Therefore, use the following configuration to enable synchronization in both directions between two nodes.


For more details, see the [next step](#ConfiguringanActive-ActiveDeployment-Step5) .


Configure the API Publisher in both nodes to be able to publish to the API-M Gateway of one of the nodes. Do this by pointing the `<ServerURL>` to the same Gateway node.

You need to configure this in the `<API-M_HOME>/repository/conf/api-manager.xml` file.

``` java
    <APIGateway>
        <ServerURL>https://localhost:${mgt.transport.https.port}${carbon.context}services/</ServerURL>
    </APIGateway>
```

### 
Step 5 - Configure the content synchronization mechanism

Configure a shared file system as the content synchronization mechanism. You can use a common shared file system such as Network File System (NFS) or any other shared file system that is available. You need to mount the `<API-M_HOME>/repository/deployment/server` directory of the two nodes to the shared file system, in order to share all APIs and throttling policies between all the nodes.

!!! info
Shared file system is the first preference that WSO2 recommends to synchronize the artifacts among the nodes, because APIs and throttling decisions can be published to any of the nodes; thereby, avoiding the vulnerability of a single point of failure that is present when using remote synchronization (rsync). However, if you are unable to maintain a shared file system, you can synchronize content using rsync. For information on setting up a rsync based deployment synchronization, see \_Configuring rsync for Deployment Synchronization .

#### Using Rsync for deployment synchronization

If you are using rsync, the API artifacts will be synchronized to one direction. As explained in \_Configuring rsync for Deployment Synchronization section, the synchronization will happen from manager to worker. Hence, The API artifact should be created on one node only, which acts like a manager node for artifact synchronization purpose. Please follow the steps below to configure this:
Assuming node-1 is the manager node for artifact synchronization,

1.  Open `<API-M_HOME>/repository/conf/api-manager.xml` file in node-1.
2.  Configure Gateway Server URL to point to its own (localhost):

    ``` java
        <APIGateway>
            <ServerURL>https://localhost:${mgt.transport.https.port}${carbon.context}services/</ServerURL>
        </APIGateway>
    ```

3.  Open `<API-M_HOME>/repository/conf/api-manager.xml` file in node-2.
4.  Configure Gateway Server URL to point to the node-1:

    ``` java
            <APIGateway>
                <ServerURL>https://<node1-hostname>:<node-1-mgt-transport-port>/services/</ServerURL>
            </APIGateway>
    ```

    Note that `<node-1-mgt-transport-port>` is the management transport port, which is by default 9443.


### Step 6 - Configure Throttling

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on configuring Throttling.

1.  Configure the data publisher in the `<DataPublisher>` section which comes under the `<ThrottlingConfigurations>` section in the `<API-M_HOME>/repository/conf/api-manager.xml` file.
    You need to update these configurations so that the Gateway can publish data to the Traffic Manager in its own node and the Traffic Manager in the other node, so that the same event is sent to both servers at the same time. The WSO2 Complex Event Processor (WSO2 CEP) component that lies within the Traffic Manager acts as the data receiver and process the data to come up with the Throttling decisions.

    -   [**Format**](#53cf34bc662d4c73926c25ba40effaf4)
    -   [**Example**](#9421b17e6719406ebb30ccc667049b27)

    ``` java
        <DataPublisher>
                <Enabled>true</Enabled>
                <Type>Binary</Type>
        <ReceiverUrlGroup>{tcp://<node1-hostname>:<node1-port>},{tcp://<node2-hostname>:<node2-port>} </ReceiverUrlGroup>
        <AuthUrlGroup>{ssl://<node1-hostname>:<node1-port>},{ssl://<node2-hostname>:<node2-port>}</AuthUrlGroup>
        ………………….
           </DataPublisher>
    ```

    ``` java
            <DataPublisher>
                    <Enabled>true</Enabled>
                    <Type>Binary</Type>
            <ReceiverUrlGroup>{tcp://127.0.0.1:9612},{tcp://127.0.0.1:9613} </ReceiverUrlGroup>
            <AuthUrlGroup>{ssl://127.0.0.1:9712},{ssl://127.0.0.1:9713}</AuthUrlGroup>
            ………………….
               </DataPublisher>
    ```

2.  Save your changes.

### Step 7 - Configure the second WSO2 API-M node

Make a copy of the active instance configured above and use this copy as the second active instance.

!!! info
When making a copy of the node, you need to also make a copy of the SSL certificate that you created for node 1 in [step 1](#ConfiguringanActive-ActiveDeployment-step1) .


### Step 8 - Configure your deployment with production hardening

The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

### Step 9 - Configure Analytics

The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

### Step 10 - Start the WSO2 API-M servers

!!! note
Before you start the servers

If you want to deploy WSO2 API-M using a hybrid active-active deployment pattern, where WSO2 Identity Server is used as the Key Manager in high availability mode while the rest of the WSO2 API-M components are all in one node , configure and start the Key Manager (e.g., configure and start WSO2 Identity Server as the Key Manager ) before starting the API-M servers .


Start the WSO2 API-M servers using the standard start-up script. For more information, see [Starting the server](https://docs.wso2.com/display/AM260/Running+the+Product#RunningtheProduct-Startingtheserver) .

The page: **\_Configuring a Single Node** was not found. Please check/update the page name used in the 'multiexcerpt-include macro.

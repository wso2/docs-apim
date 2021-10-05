# Configuring the Gateway in a Distributed Environment with rsync

!!! note
As the first preference WSO2 recommends using a shared file system over rsync as the content synchronization mechanism. For more information, see [Distributed Deployment of the Gateway](../distributed-deployment-of-the-gateway/).


You need to use remote synchronization (rsync) only if you are unable to have a shared file system, because when using rsync it needs one node to act as the Gateway Manager as it only provides write permission to one node. Thereby, when using rsync there is the vulnerability of a single point of failure.

Follow the instructions below to configure the API-M Gateway in a distributed environment when using rsync as a content synchronization mechanism:

-   [Step 1 - Configure the load balancer](#step-1-configure-the-load-balancer)
-   [Step 2 - Configure the Gateway Manager](#step-2-configure-the-gateway-manager)
-   [Step 3 - Configure the Gateway Worker](#step-3-configure-the-gateway-worker)
-   [Step 4 - Optionally configure Hazelcast](#step-4-optionally-configure-hazelcast)
-   [Step 5 - Start the Gateway Nodes](#step-5-start-the-gateway-nodes)

Note that the configurations in this topic are done based on the following pattern. This pattern is used as a basic Gateway cluster where the worker nodes and manager nodes are separated.
![]({{base_path}}/assets/attachments/103334495/103334496.png)

### Step 1 - Configure the load balancer

For more information, see [Configuring the Proxy Server and the Load Balancer](../../configuring-the-proxy-server-and-the-load-balancer/).

### Step 2 - Configure the Gateway Manager

These nodes refer to the management nodes that specialize in the management of the setup. Only management nodes are authorized to add new artifacts into the system or make configuration changes. Management nodes are usually behind an internal firewall and are exposed to clients running within the organization only. This section involves setting up the Gateway node and enabling it to work with the other components in the distributed setup.

??? Info "Click here for information on configuring the Gateway Manager"

    1.  Configure the `deployment.toml` file.
        1.  Open `<API-M_GATEWAY_MANAGER_HOME>/repository/conf/deployment.toml` file on the management node and add the cluster hostname.
            ``` toml
                [server]
                hostname = "mgt.am.wso2.com"
            ```
    
    2.  Specify the following incoming connection configurations 
    
        ```
            [transport.http]
            properties.port = 9763
            properties.proxyPort = 80
            
            [transport.https]
            properties.port = 9443
            properties.proxyPort = 443
        ```
    
        The TCP `port` number is the value that this `Connector` uses to create a server socket and await incoming connections. The operating system will allow only one server application to listen to a particular port number on a particular IP address.
    
    3.  Map the hostnames to IPs.
        Open the server's `/etc/hosts` file and add the following.
    
        ``` plain
            <GATEWAY-WORKER-IP> am.wso2.com
        ```
    
        **Example Format**
    
        ``` java
            xxx.xxx.xxx.xx4 am.wso2.com
        ```
    
        Once you replicate these configurations for all the manager nodes, your Gateway manager is configured.

### Step 3 - Configure the Gateway Worker

Worker nodes specialize in serving requests to deployment artifacts and reading them. They can be exposed to external clients.

??? Info "Click here for information on configuring the Gateway Worker"

    1.  Configure the `carbon.xml` file.
        1.  Open `<API-M_GATEWAY_MANAGER_HOME>/repository/conf/deployment.toml` file on the management node and add the cluster hostname.
            ``` toml
                [server]
                hostname = "am.wso2.com"
            ```
    
    2.  Specify the following incoming connection configurations
        
        ``` toml
            [transport.http]
            properties.port = 9763
            properties.proxyPort = 80
            
            [transport.https]
            properties.port = 9443
            properties.proxyPort = 443
        ```
    
    3.  Map the hostnames to IPs.
        Open the server's `/etc/hosts` file and add the following in order to map the hostnames with the specified real IPs.
    
        ``` plain
            <GATEWAY-MANAGER-IP> mgt.am.wso2.com
        ```
    
    4.  Configure rsync. 
        For information on configuring rsync, see [Configuring rsync for Deployment Synchronization](../../configuring-rsync-for-deployment-synchronization/).

### Step 4 - Optionally configure Hazelcast

You can seamlessly deploy WSO2 API Manager using local caching in a clustered setup without Hazelcast clustering. However, there are edge case scenarios where you need to enable Hazelcast clustering. For more information, see [Working with Hazelcast Clustering](../working-with-hazelcast-clustering/) to identify whether you need Hazelcast clustering and to configure it.

### Step 5 - Start the Gateway Nodes

Start the Gateway Manager and then the Gateway Worker nodes

??? Info "Click here for information on starting the Gateway nodes"

    #### Step 5.1 - Start the Gateway Manager
    
    Start the Gateway Manager by typing the following command in the command prompt.
    
    ``` java
        sh <API-M_GATEWAY_MANAGER_HOME>/bin/api-manager.sh
    ```
    
    #### Step 5.2 - Start the Gateway Worker
    
    !!! tip
    It is recommendation to delete the `<API-M_HOME>/repository/deployment/server` directory and create an empty server directory in the worker node. This is done to avoid any SVN conflicts that may arise. Note that when you do this, you have to restart the worker node after you start it in order to avoid any errors from occurring .
    Start the Gateway Worker by typing the following command in the command prompt.
    
    ``` java
        sh <GATEWAY_WORKER_HOME>/bin/api-manager.sh -Dprofile=gateway-worker
    ```
    
    The additional `-Dprofile=gateway-worker` argument indicates that this is a worker node specific to the Gateway. You need to use this parameter to make a server read-only. Changes (i.e., writing or making modifications to the deployment repository, etc.) can not be made in the Gateway worker nodes. Furthermore, starting a node as a Gateway worker ensures that the Developer Portal and Publisher related functions are disabled in the respective node. This parameter also ensures that the node starts in the worker profile, where the UI bundles are not activated and only the backend bundles are activated when the server starts up. For more information on the various product profiles available in WSO2 API Manager, see [API Manager product profiles](../product-profiles/) .

# Distributed Deployment of the Gateway

This topic provides instructions on how to configure the multiple Gateways in WSO2 API Manager (WSO2 API-M) in a distributed deployment to facilitate high availability (HA). The instructions in this topic are based on the [Distributed Deployment of API Manager](../deploying-wso2-api-m-in-a-distributed-setup) and these configurations will only work if the configurations in that topic are done correctly

Furthermore, these instructions use a shared file system as the content synchronization mechanism.

!!! info
    Why use a shared file system?

    WSO2 recommends using a shared file system as the content synchronization mechanism to synchronize the artifacts among the WSO2 API-M Gateway nodes, because a shared file system does not require a specific node to act as a Gateway Manager, instead all the nodes have the worker manager capabilities. As a result, this helps to share all the APIs with any of the nodes; thereby, avoiding the vulnerability of a single point of failure. For this purpose you can use a common shared file system such as Network File System ( [NFS](https://en.wikipedia.org/wiki/Network_File_System) ) or any other shared file system.


Follow the instructions below to configure the API-M Gateway in a distributed environment:

-   [Step 1 - Configure the load balancer](#step-1-configure-the-load-balancer)
-   [Step 2 - Configure the Gateway](#step-2-configure-the-gateway)
-   [Step 3 - Optionally, configure Hazelcast](#step-3-optionally-configure-hazelcast)
-   [Step 4 - Start the Gateway Nodes](#step-4-start-the-gateway-nodes)

Note that the configurations in this topic are done based on the following pattern.
![]({{base_path}}/assets/attachments/103334491/103334492.png)
### Step 1 - Configure the load balancer

For more information see, [Configuring the Proxy Server and the Load Balancer](../../configuring-the-proxy-server-and-the-load-balancer/).

### Step 2 - Configure the Gateway

When using the shared file system, all nodes have the manager worker capability. Therefore, there is no need of having a separate manager node. Follow the instructions below to set up the Gateway nodes and enable it to work with the other components in the distributed setup.

??? note "Click here for information on configuring the Gateway"

    1.  Configure the `deployment.toml` file.
        1.  Open `<API-M_GATEWAY_HOME>/repository/conf/deployment.toml`.
        2.  Locate the `<HostName>` tag and add the cluster hostname. For an example, if the hostname is `gw.am.wso2.com` :
    
            ``` toml
                [server]
                hostname = "gw.am.wso2.com"

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
    
        The TCP `port` number is the value that this `Connector` uses to create a server socket and waits for incoming connections. In your operating system, only one server application can listen to a particular port number on a particular IP address.
    
    3.  Map the hostnames to IPs.
        Open the server's `/etc/hosts` file and add the following.
    
        ``` plain
                <GATEWAY-IP> gw.am.wso2.com
        ```
    
        **Example Format**
    
        ``` java
                xxx.xxx.xxx.xx4 gw.am.wso2.com
        ```
    
        !!! note
            **Replicate the configurations** in all the other Gateway nodes.


    4.  Mount the directory required for the shared file system.
        Mount the `<API-M_HOME>/repository/deployment/server` directory of all the Gateway nodes to the shared file system to share all APIs between all the Gateway nodes.

### Step 3 - Optionally, configure Hazelcast

You can seamlessly deploy WSO2 API Manager using local caching in a clustered setup without Hazelcast clustering. However, there are edge case scenarios where you need to enable Hazelcast clustering. For more information, see [Working with Hazelcast Clustering](../working-with-hazelcast-clustering/) to identify whether you need Hazelcast clustering and to configure it.

### Step 4 - Start the Gateway Nodes

Start the WSO2 API-M Gateway node by typing the following command in the command prompt.

``` java
    sh <API-M_GATEWAY_HOME>/bin/wso2server.sh
```

!!! note
    **What if I am unable to use a shared file system?**
    
    If you are unable to have a shared file system, you can use remote synchronization (rsync) instead, but note that when using rsync there is the vulnerability of a single point of failure, because rsync needs one node to act as the Gateway Manager as it only provides write permission to one node. For more information, see \_Configuring the Gateway in a Distributed Environment with rsync .
    
    **Why can't I use SVN based deployment synchronization (Dep Sync)?**
    
    WSO2 has identified some inconsistencies when using Hazelcast clustering. As a result, from API-M 2.1.0 onward WSO2 API-M has been designed so that it is possible to deploy API-M in a clustered setup without using Hazelcast clustering, so that users can use Hazelcast clustering only when necessary . However, if you use deployment synchronization as a content synchronization mechanism, you are compelled to use Hazelcast clustering. Therefore, WSO2 does not recommend using SVN based deployment synchronization.



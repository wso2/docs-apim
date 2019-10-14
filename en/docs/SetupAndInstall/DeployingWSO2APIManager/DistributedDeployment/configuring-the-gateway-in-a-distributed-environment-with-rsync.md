# Configuring the Gateway in a Distributed Environment with rsync

!!! note
As the first preference WSO2 recommends using a shared file system over rsync as the content synchronization mechanism. For more information, see \_Distributed Deployment of the Gateway .


You need to use remote synchronization (rsync) only if you are unable to have a shared file system, because when using rsync it needs one node to act as the Gateway Manager as it only provides write permission to one node. Thereby, when using rsync there is the vulnerability of a single point of failure.

Follow the instructions below to configure the API-M Gateway in a distributed environment when using rsync as a content synchronization mechanism:

-   [Step 1 - Configure the load balancer](#ConfiguringtheGatewayinaDistributedEnvironmentwithrsync-Step1-Configuretheloadbalancer)
-   [Step 2 - Configure the Gateway Manager](#ConfiguringtheGatewayinaDistributedEnvironmentwithrsync-Step2-ConfiguretheGatewayManager)
-   [Step 3 - Configure the Gateway Worker](#ConfiguringtheGatewayinaDistributedEnvironmentwithrsync-Step3-ConfiguretheGatewayWorker)
-   [Step 4 - Optionally configure Hazelcast](#ConfiguringtheGatewayinaDistributedEnvironmentwithrsync-Step4-OptionallyconfigureHazelcast)
-   [Step 5 - Start the Gateway Nodes](#ConfiguringtheGatewayinaDistributedEnvironmentwithrsync-Step5-StarttheGatewayNodes)

Note that the configurations in this topic are done based on the following pattern. This pattern is used as a basic Gateway cluster where the worker nodes and manager nodes are separated.
![]({{base_path}}/assets/attachments/103334495/103334496.png)

### Step 1 - Configure the load balancer

For more information, see \_Configuring the Proxy Server and the Load Balancer .

### Step 2 - Configure the Gateway Manager

These nodes refer to the management nodes that specialize in the management of the setup. Only management nodes are authorized to add new artifacts into the system or make configuration changes. Management nodes are usually behind an internal firewall and are exposed to clients running within the organization only. This section involves setting up the Gateway node and enabling it to work with the other components in the distributed setup.

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on configuring the Gateway Manager.

1.  Configure the `carbon.xml` file.
    The following configurations are done in the `<API-M_GATEWAY_MANAGER_HOME>/repository/conf/carbon.xml` file.
    1.  Open `<API-M_GATEWAY_MANAGER_HOME>/repository/conf/carbon.xml` file on the management node.
    2.  Locate the `<HostName>` tag and add the cluster hostname.

        ``` java
                <HostName>am.wso2.com</HostName>
        ```

``

    3.  Locate the `<MgtHostName>` tag and uncomment it. Make sure that the management hostname is defined as follows:

        ``` java
                    <MgtHostName> mgt.am.wso2.com </MgtHostName>
        ```

2.  Configure the `catalina-server.xml` file.
    Specify the following configurations in the `<API-M_GATEWAY_MANAGER_HOME>/repository/conf/tomcat/catalina-server.xml` file.

    ``` html/xml
            <Connector  protocol="org.apache.coyote.http11.Http11NioProtocol"
                            port="9763"
                            proxyPort="80"
            --------
            />
            <Connector  protocol="org.apache.coyote.http11.Http11NioProtocol"
                            port="9443"
                            proxyPort="443"
            --------
            />
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

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on configuring the Gateway Worker.

1.  Configure the `carbon.xml` file.
    1.  Open `<GATEWAY_WORKER_HOME>/repository/conf/carbon.xml` file on each worker node.
    2.  Specify the hostname as follows:

        ``` java
                    <HostName>am.wso2.com</HostName>
        ```

2.  Configure the `catalina-server.xml` file.
    Make the following configuration changes in the `<API-M_GATEWAY_WORKER_HOME>/repository/conf/tomcat/catalina-server.xml` file.

    ``` html/xml
            <Connector  protocol="org.apache.coyote.http11.Http11NioProtocol"
                            port="9763"
                            proxyPort="80"
            --------
            />
            <Connector  protocol="org.apache.coyote.http11.Http11NioProtocol"
                            port="9443"
                            proxyPort="443"
            --------
            />
    ```

3.  Map the hostnames to IPs.
    Open the server's `/etc/hosts` file and add the following in order to map the hostnames with the specified real IPs.

    ``` plain
            <GATEWAY-MANAGER-IP> mgt.am.wso2.com
    ```

4.  Configure rsync.
    For information on configuring rsync, see \_Configuring rsync for Deployment Synchronization .

### Step 4 - Optionally configure Hazelcast

You can seamlessly deploy WSO2 API Manager using local caching in a clustered setup without Hazelcast clustering. However, there are edge case scenarios where you need to enable Hazelcast clustering. For more information, see \_Working with Hazelcast Clustering to identify whether you need Hazelcast clustering and to configure it.

### Step 5 - Start the Gateway Nodes

Start the Gateway Manager and then the Gateway Worker nodes.

![](images/icons/grey_arrow_down.png){.expand-control-image} Click here for information on starting the Gateway nodes.

#### Step 5.1 - Start the Gateway Manager

Start the Gateway Manager by typing the following command in the command prompt.

``` java
    sh <API-M_GATEWAY_MANAGER_HOME>/bin/wso2server.sh
```

#### Step 5.2 - Start the Gateway Worker

!!! tip
It is recommendation to delete the `<API-M_HOME>/repository/deployment/server` directory and create an empty server directory in the worker node. This is done to avoid any SVN conflicts that may arise. Note that when you do this, you have to restart the worker node after you start it in order to avoid any errors from occurring .
Start the Gateway Worker by typing the following command in the command prompt.

``` java
    sh <GATEWAY_WORKER_HOME>/bin/wso2server.sh -Dprofile=gateway-worker
```

The additional `-Dprofile=gateway-worker` argument indicates that this is a worker node specific to the Gateway. You need to use this parameter to make a server read-only. Changes (i.e., writing or making modifications to the deployment repository, etc.) can not be made in the Gateway worker nodes. Furthermore, starting a node as a Gateway worker ensures that the Store and Publisher related functions are disabled in the respective node. This parameter also ensures that the node starts in the worker profile, where the UI bundles are not activated and only the backend bundles are activated when the server starts up. For more information on the various product profiles available in WSO2 API Manager, see [API Manager product profiles](https://docs.wso2.com/display/AM260/Product+Profiles) .

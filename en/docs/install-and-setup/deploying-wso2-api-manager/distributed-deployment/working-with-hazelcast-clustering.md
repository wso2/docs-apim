# Working with Hazelcast Clustering

Hazelcast is an in-memory data grid, which is used in clustering and distributed shared memory. When using Hazelcast as a clustering implementation, data is evenly distributed among the nodes in a cluster. Hazelcast clustering is disabled in WSO2 API Manager (WSO2 APIM) by default, because you can successfully deploy WSO2 API-M without Hazelcast. The following subsections explain as to when you need Hazelcast clustering with WSO2 API Manager (WSO2 APIM) and how you can configure it.

-   [When to use Hazelcast](#when-to-use-hazelcast)
-   [Deploying WSO2 API-M Manager with Hazelcast clustering](#deploying-wso2-api-m-manager-with-hazelcast-clustering)
-   [Enabling Hazelcast clustering](#enabling-hazelcast-clustering)
-   [Configuring Hazelcast properties](#configuring-hazelcast-properties)

### When to use Hazelcast

You can seamlessly deploy WSO2 API Manager using local caching in a clustered setup without Hazelcast clustering. However, the following are the edge case scenarios where you need to enable Hazelcast clustering.

-   **Immediate revocation of tokens among the gateways**
    If you deploy WSO2 API-M without Hazelcast clustering, you can set the time-to-live (TTL) value in secs in order to define the period after which the token will automatically be revoked in the other gateways. However, if you want the token in all the gateways to be immediately revoked, then you need to enable Hazelcast clustering.
-   **Backend service throttling**
    The endpoint throttling limits and the spike arrest throttling limits will not be shared across the cluster when Hazelcast clustering is disabled.

### Deploying WSO2 API-M Manager with Hazelcast clustering

Follow the instructions below to deploy WSO2 API-M with Hazelcast clustering:

1.  Carryout the instructions related to deploying WSO2 API-M.
2.  Carryout the instructions to [enable Hazelcast clustering](#enabling-hazelcast-clustering).
3.  Start the WSO2 API-M servers.

### Enabling Hazelcast clustering

1.  Open the `<GATEWAY_MANAGER_HOME>/repository/conf/deployment.toml` file.
2.  Locate the clustering section and verify or configure the properties as follows (some of these properties are already set correctly by default).
    
    1.  Set the membership scheme to `wka` to enable the well-known address registration method (this node will send cluster initiation messages to WKA members that we will define later):

        ``` java
            [clustering]
            membership_scheme = "wka"
                    
        ```

    2.  Specify the name of the cluster this node will join by appending to `[clustering]` category

        ``` toml
           domain = "wso2.am.domain"
        ```

    3.  Specify the host used to communicate cluster messages by appending to `[clustering]` category. This is the IP of the Gateway manager node.

        ``` toml
            local_member_host = "xxx.xxx.xxx.xx3"
        ```

    4.  Specify the port used to communicate cluster messages by appending to `[clustering]` category:

        ``` toml
            local_member_port = 4500
        ```

        !!! info
            This port number will not be affected by the port offset in `deployment.toml`. If this port number is already assigned to another server, the clustering framework will automatically increment this port number. However, if two servers are running on the same machine, you must ensure that a unique port is set for each server.

  
    6.  Change the members listed in the `<members>` element by appending to `[clustering]` category. This defines the WKA members.

        ``` toml
            members = ["127.0.0.1:4500", "127.0.0.1:4501"]
        ```

        Here we configure the manager node and worker node as the well-known members.
        
    7. Here the sample configuration
        ``` toml
            [clustering]
            membership_scheme = "wka"
            domain = "wso2.am.domain"
            local_member_host = "127.0.0.1"
            local_member_port = 4500
            members = ["127.0.0.1:4500", "127.0.0.1:4501"]
        ```

    8. Similarly config the remaining gateway workers with same configurations. Sample configuration for a second gateway worker is as follows.
        ``` toml
            [clustering]
            membership_scheme = "wka"
            domain = "wso2.am.domain"
            local_member_host = "127.0.0.1"
            local_member_port = 4501
            members = ["127.0.0.1:4500", "127.0.0.1:4501"]
        ```
     
    9.  See the instructions on [configuring hazelcast properties](#WorkingwithHazelcastClustering-ConfiguringHazelcastproperties) given below.

### Configuring Hazelcast properties

You can configure the hazelcast properties for the product nodes by following the steps given below.

1.  Add the follwing configuration to deployment.toml under the `[clustering]` category

    ``` toml
        #Disabling the hazelcast shutdown hook
        shutdown_hook_enable = false
        #Setting the hazelcast logging type to log4j
        logging_type = "log4j"
    ```

    The above configurations are explained below.

    -   **Hazelcast shutdown hook:** This configuration disables the shutdown hook in hazelcast, which ensures that the hazelcast instance shuts down gracefully whenever the product node shuts down. If the hazelcast shutdown hook is enabled (which is the default behavior of a product), you will see errors such as " *Hazelcast instance is not active!* " at the time of shutting down the product node: This is because the hazelcast instance shuts down too early when the shutdown hook is enabled.
    -   **Hazelcast logging type:** This configuration sets the hazelcast logging type to log4j, which allows hazelcast logs to be written to the `wso2carbon.log` file.

2.  If you have enabled log4j for hazelcast logging as shown above, be sure to enter the configuration shown below in the `log4j2.properties` file (stored in the `<GATEWAY_HOME>/repository/conf/` directory ). This can be used to configure the log level for hazelcast logging. For a clustered production environment, it is recommended to use INFO as the log level as shown below.

    ``` toml
        logger.com-hazelcast.name = com.hazelcast
        logger.com-hazelcast.level = INFO
    ```



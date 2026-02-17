# Configure Distributed Throttling for API Manager

In a distributed deployment of WSO2 API Manager with multiple Traffic Manager nodes, it is essential to maintain traffic counts at a global level to ensure all nodes have a consistent view of the current usage. This is achieved by connecting API Manager to a Redis or Valkey cluster, which is used to store and synchronize distributed counters across all Traffic Manager nodes.

!!! important
    Ensure that the Redis or Valkey cluster is configured in replication mode. Sharded clusters are not supported for distributed throttling.

### Configuring a Redis cluster with API Manager to enable distributed counter for throttling

Follow the instructions below to configure a Redis cluster with API Manager:

#### Step 1 - Setup and start the Redis server

Refer to the [official Redis documentation](https://redis.io/docs/latest/operate/rc/rc-quickstart/) to set up and start the Redis server.

#### Step 2 - Configure the Redis server with WSO2 API-M

Follow the instructions below to configure the Redis server with WSO2 API Manager.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file for both the control plane and traffic-manager components.

2.  Add the following configurations to the `deployment.toml` file.

    ``` toml
    [apim.distributed_throttling]
    enable = true
    type = "redis"
    sync_interval = 1
    core_pool_size = 5


    [apim.distributed_throttling.keyvalue_store]
    host = "<kvstore_host>"
    port = "<kvstore_port>"
    user = "username"
    password = "password"
    max_total = 20
    max_idle = 20
    min_idle = 4
    block_when_exhausted = true
    test_while_idle = true
    min_evictable_idle_time_millis = 3000
    time_between_eviction_runs_millis = 1200

    ```

3.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the gateway component.

4.  Add the following configurations to the `deployment.toml` file.

    ``` toml
    [[apim.throttling.url_group]]
    traffic_manager_urls = ["tm1_url","tm2_url", ...]
    traffic_manager_auth_urls = ["tm1_auth_url","tm2_auth_url", ...]
    type = "loadbalance"

    ```
#### Step 3 - Start the WSO2 API-M server

For more information, see [Running the API Manager Runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

In this setup, every TM node maintains its local counter and an unsynced counter. Instead of sending every increment/decrement to the Redis/Valkey store immediately, changes are accumulated locally. A scheduled background task periodically synchronizes the local counter with the Valkey/Redis store counter to keep the distributed state consistent across nodes. The accuracy of the counter value in each node can be fine tuned by adjusting the configs `sync_interval` and `core_pool_size`.

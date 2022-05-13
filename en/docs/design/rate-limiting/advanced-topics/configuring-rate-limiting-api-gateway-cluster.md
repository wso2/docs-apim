# Configuring Rate Limiting for an API Gateway Cluster

Typically, you need to have more than one Gateway node in your WSO2 API Manager (WSO2 API-M) deployment when either having an all-in-one set up in a high availability (HA) deployment (i.e., 2 nodes) or when having a distributed set up with multiple Gateways. In such scenarios, for features such as [burst control]({{base_path}}/design/rate-limiting/setting-throttling-limits/#burst-control) and [backend rate limiting]({{base_path}}/design/rate-limiting/setting-maximum-backend-throughput-limits) to work properly, it requires maintaining distributed request counters across all gateway nodes.

WSO2 API-M supports the facility to maintain these counters in a distributed Redis cluster. You can simply connect API-M to a Redis cluster, and then the API-M Gateway nodes will take care of keeping distributed counters in it.

!!! note
    If you are unable to use a Redis cluster in your deployment, the fallback option is to have node-local counters. For that, you have to define rate limit policies based on the number of gateway nodes that are in the cluster. For example, if you have 3 gateway nodes, and you want to have a rate-limiting policy with 300req/s, you have to create a policy that only allows 100req/s. Then each node will allow 100req/s and in total, you will get 300req/s assuming the requests are distributed equally across all nodes. However, this option has its own limitations and is hence not an ideal solution.

## Configuring a Redis cluster with API Manager

Follow the instructions below to configure a Redis cluster with API Manager:

### Step 1 - Setup and start the Redis server

Refer to the [official Redis documentation](https://redis.com/) to set up and start the Redis server.

### Step 2 - Configure the Redis server with WSO2 API-M

Follow the instructions below to configure the Redis server with WSO2 API Manager.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway node.

2.  Add the following configurations to the `deployment.toml` file.

    ``` toml
    [apim.redis_config]
    host = "<Redis-host>"
    port = "<Redis-port>"
    user = "<Redis-username>"
    password = "<Redis-password>"

    [throttle_properties]
    'throttling.distributed.counter.type' = "redis"
    ```

### Step 3 - Start the WSO2 API-M server

For more information, see [Running the API Manager Runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

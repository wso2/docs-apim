# Configuring Rate Limiting for an API Gateway Cluster

You will need to have more than one Gateway in your WSO2 API Manager deployment when having an all-in-one set up in a high availability (HA) deployment or when having a distributed set up with scaled Gateways. In such scenarios, when using more than one API Gateway in your WSO2 API Manager deployment, you need to maintain a distributed counter to keep track of the request count for rate-limiting to function correctly at the node level. 

If you are using a clustered deployment, the counters are replicated across the cluster, and it is applied across all users using any application that accesses that particular API. However, **when a clustered setup is not used**, WSO2 recommends defining a distributed counter that allows you to maintain global counters for [burst control]({{base_path}}/design/rate-limiting/setting-throttling-limits/#burst-control) and [backend rate limiting]({{base_path}}/design/rate-limiting/setting-maximum-backend-throughput-limits). The updated distributed counters will be maintained across the Gateway nodes. 

You can define these distributed counters in the Redis server, which is an in-memory database/data structure server. Thereafter, you can configure the Redis server with WSO2 API Manager (WSO2 API-M) to ensure that distributed rate limiting works seamlessly.

## Step 1 - Setup and start the Redis server

Refer to the [official Redis documentation](https://redis.com/) to set up and start the Redis server.

## Step 2 - Configure the Redis server with WSO2 API-M

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

## Step 3 - Start the WSO2 API-M server

For more information, see [Running the API Manager Runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

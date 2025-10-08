# Configure Distributed Burst Control, Backend Rate Limiting for an API Gateway Cluster

Typically, you need to have more than one Gateway node in your WSO2 API Manager (WSO2 API-M) deployment when either
having an all-in-one setup in a high availability (HA) deployment (i.e., 2 nodes) or when having a distributed setup
with multiple Gateways. In such scenarios, for [Burst Control]({{base_path}}
/design/rate-limiting/setting-throttling-limits/#burst-control) and [Backend Rate Limiting]({{base_path}}
/design/rate-limiting/setting-maximum-backend-throughput-limits) to work properly, it requires maintaining
distributed request counters across all gateway nodes.

WSO2 API-M supports the facility to maintain these counters in a distributed Redis cluster. You can simply connect
API-M to a Redis cluster, and then the API-M Gateway nodes will take care of keeping distributed counters in it.

!!! note
    If you are unable to use a Redis cluster in your deployment, the fallback option is to have node-local counters.
    For that, you have to define rate limit policies based on the number of gateway nodes that are in the cluster. For
    example, if you have 3 gateway nodes, and you want to have a rate-limiting policy with 300req/s, you have to create
    a policy that only allows 100req/s. Then each node will allow 100req/s and in total, you will get 300req/s assuming
    the requests are distributed equally across all nodes. However, this option has its own limitations and is hence
    not an ideal solution.

This Redis based implementation is done via two approaches based on how the throttling related counters and
timestamps are synced in-between gateway nodes and the Redis server.

1. [Asynchronous Mode](#1-asynchronous-mode)
2. [Async-Sync Hybrid Mode](#2-async-sync-hybrid-mode)

Below we have described on each of the modes with how to configure them.

## 1. Asynchronous Mode

In this mode, throttling related counters and timestamps are synced in-between gateway nodes and the Redis server
asynchronously. This is the default mode of operation.

### Configuring a Redis cluster with API Manager to enable asynchronous mode

Follow the instructions below to configure a Redis cluster with API Manager:

#### Step 1 - Setup and start the Redis server

Refer to the [official Redis documentation](https://redis.com/) to set up and start the Redis server.

#### Step 2 - Configure the Redis server with WSO2 API-M

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

#### Step 3 - Start the WSO2 API-M server

For more information, see [Running the API Manager Runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).

## 2. Async-Sync Hybrid Mode

In this mode, throttling related parameters (counters and timestamps) are synced in-between gateway nodes and the Redis
server both asynchronous and synchronous mode. Within a time window, up until an evenly allocated local quota of
requests, throttle parameters are evaluated and processed locally only, which demonstrates an asynchronous behaviour.

When running these throttle-param processing tasks, local quota value is calculated as below.
> Local Quota (LQ) = (T - X%) / GW  
<small>_T :  Throttle Limit (i.e. 100 tps)     
X : Percentage of the buffer quota    
GW : Count of gateway nodes active_</small>

Active gateway count of the gateway cluster is counted by each of the gateway nodes using the redis server once per
each 10 seconds of duration.

So a local quota of API requests is evenly distributed among the active gateway nodes. After the local quota is
exhausted in any gateway node, the throttle-param syncing of succeeding requests on any of the gateway nodes in the
cluster will be processed in a synchronous behaviour. So when the local quota value determined is less, the API requests will
start to process in a synchronous behaviour sooner.

This mode is recommended over the [Asynchronous Mode](#1-asynchronous-mode) if you need to have a better throttle processing precession.
But it is important to note that, it is not possible to achieve 100% precision with rate limiting implementations for
small time windows (i.e. 1 second) when the traffic is high. There is always a trade-off between accuracy and latency,
which are taken into consideration. There might be a positive or negative spill-over percentage of requests. And also
this spill-over percentage will be dependent on the various factors i.e. infrastructure, network latency, performance of
redis server, etc.

As mentioned regarding the latency, once you enable this feature, there will be an impact on the latency of API requests.
This latency impact here will generally be hit only when there is a high load of API requests on to the gateway
cluster. Normally, after the local quota is exceeded in any of the gateway nodes, this latency impact will be observable,
hence there won't be a considerable latency impact at normal low-traffic situations. However, it is recommended to test
the performance impact, before applying this feature in production, if the API latency is a highly sensitive parameter.

### Configuring a Redis cluster with API Manager to enable hybrid mode

Follow the instructions below to configure a Redis cluster with API Manager:

#### Step 1 - Setup and start the Redis server

Refer to the [official Redis documentation](https://redis.com/) to set up and start the Redis server.

#### Step 2 - Configure the Redis server with WSO2 API-M

Follow the instructions below to configure the Redis server with WSO2 API Manager.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway node.

2. Add the following configurations to the `deployment.toml` file.

    === "Format"
        ```toml
        [apim.redis_config]
        host = "<Redis-host>"
        port = "<Redis-Port>"
        user = "<Redis-User-Name>"
        password = "<Redis-Password>"
        gateway_id = "<ID Of the Gateway Node>"

        [throttle_properties]
        'throttling.distributed.counter.type' = "<counter type>"
        'throttling.sync-async_hybrid_mode.enable' = <enable/disable the hybrid Mode>
        'throttling.local_quota_buffer_percentage' = <local quota buffer value>
        ```

    === "Example"
        ```toml
        [apim.redis_config]
        host = "localhost"
        port = 6379
        user = "root"
        password = "root"
        gateway_id = "gw1"
        
        [throttle_properties]
        'throttling.distributed.counter.type' = "redis"
        'throttling.sync-async_hybrid_mode.enable' = true
        'throttling.local_quota_buffer_percentage' = 30
        ```

Please note that the above set of configurations are the minimum required configurations to enable the hybrid mode. For advanced configurations, please refer the below tables.

**Details on configurations under `[apim.redis_config]`** are as follows.

| **Config**                 | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | **Mandatory/Optional** | **Sample values** | **Default Value** | 
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------|-------------------|
| host                       | Host name of the Redis server.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Mandatory              | localhost         | N/A               |
| port                       | Port of the Redis server.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Mandatory              | 6379              | N/A               |
| user                       | Username of the Redis server. <br/>If the Redis server is configured in NOAUTH mode, this is not required. This depends on the Redis server. In Azure Cache for Redis by default 'user' is not required and only the password (access key) is required.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Optional               | root              | N/A               |
| password                   | Password of the Redis server. If the Redis server is configured in NOAUTH mode, this is not required.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Optional               | root              | N/A               |
| gateway_id                 | ID of the gateway node. This is used to identify the gateway node, hence should be a unique  value for each gateway node.<br/> **TIP:** In [WSO2 APIM K8s Helm charts]({{base_path}}/manage-apis/design/install-and-setup/install/installation-options/#1-kubernetes-helm), you can use the {NODE_IP} environment variable which is derived from podIP variable, hence it differs from node to node. i.e. `gateway_id = "$env{NODE_IP}"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Mandatory              | gw1               | N/A               |
| min_gateway_count          | This is used to define the minimum number of gateway nodes in the cluster if required. <br/><br/> Gateway count of the cluster is calculated by each of the gateway nodes using the redis server and this gateway count is used to calculate the local quota of API requests in the throttling calculations. Local quota is inversely proportional to the gateway count determined. So, at certain point of time, when the gateway count is much low, the local quota value calculated will be much higher. Local quota value has some impact on the api request processing latency and throttling accuracy too, hence it is important to have control over it. <br/> This minimum gateway count definition will ensure, the considered gateway count will not be less than this value. So if this minimum gateway count is defined, the local quota of API requests will be always less than a particular value. | Optional               | 3                 | 1                 |
| key_lock_retrieval_timeout | This timeout value defines the timeout value (in ms) that the gateway will wait to acquire the required lock in Redis. <br/>This lock is required for gateways to perform syncing of throttle parameters in-between gateway nodes and the Redis server. Optimal default value observed for this is 50ms, and this can be tuned based on the deployment. Higher this value, higher the throttling accuracy, but lower the latency.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Optional               | 50                | 50                |


**Details on configurations under `[throttle_properties]`** are as follows.

| **Config**                                 | **Description**                                                                                                                                                                                                          | **Mandatory/Optional** | **Sample values** | **Default Value** | 
|--------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------|-------------------|
| 'throttling.distributed.counter.type'      | Distributed counter type. This should be set  to "redis" since only the Redis based distributed counter is implemented as of now                                                                                         | Mandatory              | "redis"           | N/A               |
| 'throttling.sync-async_hybrid_mode.enable' | Enable/Disable the Hybrid Mode. **This should be set to "true" to enable the Hybrid Mode.** If this is not set, the "Async-Sync Hybrid Mode" will not be enabled and so the default "Asynchronous Mode" will be enabled. | Optional               | true              | false             |
| 'throttling.local_quota_buffer_percentage' | Buffer percentage allocated from the policy limit so that rest of the quota only will be allocated to all the gateway nodes evenly.                                                                                      | Optional               | 30                | 20                |


#### Step 3 - Start the WSO2 API-M server

For more information, see [Running the API Manager Runtime]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/).
If there is a cluster of gateway nodes, start all of them.

Once configurations are done, you can follow the docs for [Burst Control]({{base_path}}
/design/rate-limiting/setting-throttling-limits/#burst-control) and [Backend Rate Limiting]({{base_path}}
/design/rate-limiting/setting-maximum-backend-throughput-limits) and test the functionality with the Hybrid Mode enabled. 

# Distributed Counter update using redis

Distributed counter allows you to maintain the global counters for burst control and backend rate limiting.This allows you to configure it through the Redis server to keep the updated counters across gateway clusters.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file of the Gateway node.

2.  Add the following configurations to the `deployment.toml` file.

    ``` toml
    [apim.redis_config]
    host = "<Redis Host>"
    port = "<Redis Port>"
    user = "<Redis username>"
    password = "<Redis password>"

    [throttle_properties]
    'throttling.distributed.counter.type' = "redis" 
 
 
    ```            

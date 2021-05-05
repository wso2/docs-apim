# Analytics Configurations in config.toml
The following are the configurations with regard to Analytics. The configuration file ( `config.toml` ) for the Choreo Connect is located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory.

To learn about the concepts of Analytics in Choreo Connect, please follow the [Choreo Connect Analytics]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/)

|Heading|Description|
|---------------------------------------|-----------------------------|
|`enabled`  | The configurations required to either enable or disable Analytics Event publishing to Choreo and is used by both `enforcer` and `router`|
|`analytics.adapter`| The configurations that would be applied into the `router`'s [gRPC Access Logger]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/#grpc-access-logger). The events will be published to the [gRPC Event Listener]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/#grpc-event-listener) once `bufferFlushInterval` passes or buffer size exceeds the `bufferSizeBytes`. `gRPCRequestTimeout` is the timeout for the gRPC call from [gRPC Access Logger]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/#grpc-access-logger).|
|`analytics.enforcer`| The configurations which should flow to the enforcer in order to publish analytics Events. |
| `analytics.enforcer.configProperties` | AuthURL and authToken to publish analytics events. By default this will be obtained from the environment variables of `enforcer` |
|`analytics.enforcer.LogReceiver`| The configurations for the [gRPC Event Listener]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/#grpc-event-listener) server. |
| `analytics.enforcer.LogReceiver.threadPool` | Configurations for the thread pool that the [gRPC Event Listener]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/choreo-connect-analytics/#grpc-event-listener) is running on. |


### Sample

The following is a sample Analytics configuration for Choreo Connect.

``` java
[analytics]
  enabled = true
  [analytics.adapter]
    bufferFlushInterval = "1s"
    bufferSizeBytes = 16384
    gRPCRequestTimeout = "20s"
  [analytics.enforcer]
    [analytics.enforcer.configProperties]
      authURL = "$env{analytics_authURL}"
      authToken = "$env{analytics_authToken}"

    [analytics.enforcer.LogReceiver]
      port = 18090
      maxMessageSize = 1000000000
      maxHeaderLimit = 8192
      #keep alive time of the external authz connection
      keepAliveTime = 600

      [analytics.enforcer.LogReceiver.threadPool]
        coreSize = 10
        maxSize = 100
        #keep alive time of threads in seconds
        keepAliveTime = 600
        queueSize = 1000
```

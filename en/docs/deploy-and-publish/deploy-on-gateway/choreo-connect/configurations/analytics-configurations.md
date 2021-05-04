# Analytics Configurations in config.toml
The following are the configurations with regard to Analytics. The configuration file ( `config.toml` ) for the Choreo Connect is located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory.

|Heading|Description|
|-----------|-----------|
|`enabled`  | The configurations required to either enable or disable Analytics Event publishing to Choreo.|
|`analytics.adapter`  | |
|`analytics.enforcer`| The configurations which should be flows to enforcer in order to publish analytics Events. |
| `analytics.enforcer.configProperties` | AuthURL and authToken to pulish analytics events. This can be obtained from `Choreo` portal. |
|`analytics.enforcer.LogReceiver`| The configurations for SSL configuration related to the backend connection in Choreo Connect. |


### Sample

The following is a sample Analytics configurations for Choreo Connect.

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
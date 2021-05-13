# Distributed throttling

To learn about the concepts of throttling in Choreo Connect, please follow the [APIM As Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/#rate-limiting).

## Enable Distributed Throttling

Throttling (Rate Limiting) in Choreo Connect works with API Manager (Traffic Manager).

To enable distributed throttling, change the below configs in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/config.toml` file as required.

``` toml
  # Throttling configurations
  [enforcer.throttling]
    # Connect with the central traffic manager
    enableGlobalEventPublishing = false
    # Enable global advanced throttling based on request header conditions
    enableHeaderConditions = false
    # Enable global advanced throttling based on request query parameter conditions
    enableQueryParamConditions = false
    # Enable global advanced throttling based on jwt claim conditions
    enableJwtClaimConditions = false
    # The message broker context factory
    jmsConnectionInitialContextFactory = "org.wso2.andes.jndi.PropertiesFileInitialContextFactory"
    # The message broker connection URL
    jmsConnectionProviderUrl = "amqp://admin:$env{tm_admin_pwd}@carbon/carbon?brokerlist='tcp://{API-M_HOST/TM_HOST}:5672'"
    # Throttling configurations related to event publishing using a binary connection
    [enforcer.throttling.publisher]
      # Credentials required to establish connection between Traffic Manager
      username = "admin"
      password = "$env{tm_admin_pwd}"
      # Receiver URL and the authentication URL of the Traffic manager node/nodes
      [[enforcer.throttling.publisher.urlGroup]]
        receiverURLs = ["tcp://{API-M_HOST/TM_HOST}:9611"]
        authURLs = ["ssl://{API-M_HOST/TM_HOST}:9711"]
      # Data publisher object pool configurations
      [enforcer.throttling.publisher.pool]
        maxIdleDataPublishingAgents = 1000
        initIdleObjectDataPublishingAgents = 200
        # Data publisher thread pool configurations
        publisherThreadPoolCoreSize = 200
        publisherThreadPoolMaximumSize = 1000
        publisherThreadPoolKeepAliveTime = 200
      [enforcer.throttling.publisher.agent]
        # SSL Protocols
        sslEnabledProtocols = "TLSv1.2"
        # ciphers
        ciphers="TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA256, TLS_ECDH_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_RSA_WITH_AES_128_CBC_SHA256,TLS_DHE_DSS_WITH_AES_128_CBC_SHA256, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA, TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDH_RSA_WITH_AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_128_CBC_SHA, TLS_DHE_DSS_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256  ,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDH_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDH_RSA_WITH_AES_128_GCM_SHA256, TLS_DHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_RSA_WITH_AES_128_GCM_SHA256,TLS_DHE_DSS_WITH_AES_128_GCM_SHA256  ,TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA,SSL_RSA_WITH_3DES_EDE_CBC_SHA, TLS_ECDH_ECDSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDH_RSA_WITH_3DES_EDE_CBC_SHA,SSL_DHE_RSA_WITH_3DES_EDE_CBC_SHA, SSL_DHE_DSS_WITH_3DES_EDE_CBC_SHA,TLS_EMPTY_RENEGOTIATION_INFO_SCSV"
        # The size of the queue event disruptor which handles events before they are published.
        # The value specified should always be the result of an exponent with 2 as the base.
        queueSize = 32768
        # The maximum number of events in a batch sent to the queue event disruptor at a given time
        batchSize = 200
        # The number of threads that will be reserved to handle events at the time you start
        corePoolSize = 1
        # Socket timeout
        socketTimeoutMS = 30000
        # The maximum number of threads that should be reserved at any given time to handle events
        maxPoolSize = 1
        # The amount of time which threads in excess of the core pool size may remain idle before being terminated.
        keepAliveTimeInPool = 20
        # The time interval between reconnection
        reconnectionInterval = 30
        # TCP connection pool configurations (for data publishing)
        maxTransportPoolSize = 250
        maxIdleConnections = 250
        evictionTimePeriod = 5500
        minIdleTimeInPool = 5000
        # SSL connection pool configurations (for authentication)
        secureMaxTransportPoolSize = 250
        secureMaxIdleConnections = 250
        secureEvictionTimePeriod = 5500
        secureMinIdleTimeInPool = 5000
```
### Conditional throttling

There can be situations where certain APIs require more granular level of throttling. Assume you want to provide limited access to a certain IP range or a type of client application (identified by User-Agent header). For these scenarios, a simple throttle policy with API/resource level limits is not sufficient. To address complex throttling requirements as above, Choreo Connect is capable of throttling requests based on several conditions. The following types of conditions are supported.

1. Specific IP or IP range conditions. 
   This condition can be used to provide specific limits to a certain IP address or a range of IP addresses.

2. Header conditions.
   This condition can be used to set specific limits to a certain header value.
  
3. Query parameter conditions.
   Same as the header conditions, this allows applying a specific limit to a certain query parameter value.

4. JWT claim conditions.
   This type of condition will evaluate the [backend jwt]({{base_path}}/deploy/api-microgateway/passing-enduser-attributes-to-the-backend-using-jwt) and check if it has a specific claim value in it to set the throttle limit.

#### Configure and enable conditional throttling
Conditional throttling is done via the Advanced throttling policies in API Manager.

1. Open `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/config.toml` file
2. Add/Enable below configurations to enable the required condition type.

    ```toml
      [enforcer.throttling]
        # Connect with the central traffic manager
        enableGlobalEventPublishing = false
        # Enable global advanced throttling based on request header conditions
        enableHeaderConditions = false
        # Enable global advanced throttling based on request query parameter conditions
        enableQueryParamConditions = false
        # Enable global advanced throttling based on jwt claim conditions
        enableJwtClaimConditions = false
    ```

3. Define the Advance Throttle Policy containing the required conditions in WSO2 API Manager. To do this follow [Adding a new advanced throttling policy]({{apim_path}}/design/rate-limiting/adding-new-throttling-policies/#adding-a-new-advanced-throttling-policy)
4. Create an API in API Publisher and assign the created Advanced Thorttling policy to the API. [Advanced throttling (API publisher)]({{base_path}}/design/rate-limiting/setting-throttling-limits/#advanced-throttling-api-publisher)
5. Deploy the API in Choreo-Connect ([Deploy an API via API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/#via-api-manager)).

# Enforcer configurations in config.toml

The following are the configurations with regard to Enforcer. The configuration file ( `config.toml` ) of the Choreo Connect is located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory. 

|Heading|Description|
|-----------|-----------|
|`authService`  | The configurations of gRPC netty based server that handles the incoming requests in the Choreo Connect.|
|`apimCredentials`  | The configurations of apim credentials which is required to connect with APIM services.|
|`cache`| The configurations of token caching in the Choreo Connect.|
|`jwtGenerator` | The configuration of the backend jwt generation in the Choreo Connect. |
|`jwtIssuer`  | The issuer configuration required to generate token at Choreo Connect.|
|`throttling` | The throttling related configurations to publish events to Traffic Manager.|

### Sample

The following is a sample enforcer configurations in Choreo Connect.

``` java
[enforcer]
[enforcer.authService]
  port = 8081
  maxMessageSize = 1000000000
  maxHeaderLimit = 8192
  #keep alive time of the external authz connection
  keepAliveTime = 600
  
[enforcer.authService.threadPool]
  coreSize = 400
  maxSize = 500
  #keep alive time of threads in seconds
  keepAliveTime = 600
  queueSize = 1000

[enforcer.apimCredentials]
  username="admin"
  password="$env{apim_admin_pwd}"

[enforcer.cache]
  enabled = true
  maximumSize = 10000
  expiryTime = 15

[enforcer.jwtGenerator]
  enable = false
  encoding = "base64" # base64,base64url
  claimDialect = "http://wso2.org/claims"
  convertDialect = false
  header = "X-JWT-Assertion"
  signingAlgorithm = "SHA256withRSA"
  enableUserClaims = false
  gatewayGeneratorImpl = "org.wso2.carbon.apimgt.common.gateway.jwtgenerator.APIMgtGatewayJWTGeneratorImpl"
  claimsExtractorImpl = "org.wso2.carbon.apimgt.impl.token.ExtendedDefaultClaimsRetriever"
  publicCertificatePath = "/home/wso2/security/truststore/mg.pem"
  privateKeyPath = "/home/wso2/security/keystore/mg.key"

[enforcer.jwtIssuer]
  enabled = true
  issuer = "https://localhost:9095/testkey"
  encoding = "base64" # base64,base64url
  claimDialect = ""
  signingAlgorithm = "SHA256withRSA"
  publicCertificatePath = "/home/wso2/security/truststore/mg.pem"
  privateKeyPath = "/home/wso2/security/keystore/mg.key"
  validityPeriod = 3600 # seconds
  [[enforcer.jwtIssuer.jwtUser]]
    username = "admin"
    password = "$env{enforcer_admin_pwd}"

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
  jmsConnectionProviderUrl = "amqp://admin:$env{tm_admin_pwd}@carbon/carbon?brokerlist='tcp://localhost:5672'"
  # Throttling configurations related to event publishing using a binary connection
  [enforcer.throttling.publisher]
    # Credentials required to establish connection between Traffic Manager
    username = "admin"
    password = "$env{tm_admin_pwd}"
    # Receiver URL and the authentication URL of the Traffic manager node/nodes
    [[enforcer.throttling.publisher.urlGroup]]
      receiverURLs = ["tcp://localhost:9611"]
      authURLs = ["ssl://localhost:9711"]
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

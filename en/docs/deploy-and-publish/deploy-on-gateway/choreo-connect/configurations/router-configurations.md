# Router configurations in config.toml

The following are the configurations with regard to Router. The configuration file ( `config.toml` ) for the Choreo Connect is located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory.

|Heading|Description|
|-----------|-----------|
|`router`  | The configurations required for router to route the traffic from different clients to services.|
|`keystore`  | The configurations of apim credentials which is required to connect with APIM services.|
|`cors`| The CORS configurations of the Choreo Connect.|
|`upstream` | The configurations for SSL configuration related to the backend connection in Choreo Connect. |

### Sample

The following is a sample router configurations.

``` java
[router]
  listenerHost = "0.0.0.0"
  listenerPort = 9090
  securedListenerHost = "0.0.0.0"
  securedListenerPort = 9095
  clusterTimeoutInSeconds = 20
  # system hostname for system API resources (eg: /testkey and /health)
  systemHost = "localhost"

[router.keystore]
  certPath = "/home/wso2/security/keystore/mg.pem"
  keyPath = "/home/wso2/security/keystore/mg.key"

[router.cors]
 enabled = false
 allowOrigins = ["*"]
 allowMethods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
 allowHeaders = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction","apikey", "testKey", "Internal-Key"]
 exposeHeaders = []
 allowCredentials = false

[router.upstream]
[router.upstream.tls]
  minimumProtocolVersion = "TLS1_1"
  maximumProtocolVersion = "TLS1_2"
  ciphers = "ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, ECDHE-ECDSA-AES128-SHA, ECDHE-RSA-AES128-SHA, AES128-GCM-SHA256, AES128-SHA, ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES256-SHA, ECDHE-RSA-AES256-SHA, AES256-GCM-SHA384, AES256-SHA"  
  # the default endpoint certificates
  trustedCertPath = "/etc/ssl/certs/ca-certificates.crt"
  verifyHostName = true
  disableSslVerification = false
```

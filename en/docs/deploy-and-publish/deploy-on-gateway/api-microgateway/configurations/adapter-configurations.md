# Adapter configurations in config.toml

The following are the configurations with regard to Adapter. The configuration file ( `config.toml` ) for the Choreo Connect is located in the `<MGW_HOME>/resources/conf` directory.

|Heading|Description|
|-----------|-----------|
|`server`  | The configurations  to REST API of adapter.|
|`keystore`  | The configurations of Key store used in Choreo Connect.|
|`truststore`| The configurations of trust store used in in the Choreo Connect.|
|`consul` | The configuration of the consul service in the Choreo Connect. |

### Sample

The following is a sample Microgateway adapter configurations.

``` java
[adapter]
[adapter.server]
  host = "0.0.0.0"
  port = "9843"
  tokenTTL = "1h"
  tokenPrivateKeyPath = "/home/wso2/security/keystore/mg.key"
  [[adapter.server.users]]
    username = "admin"
    password = "$env{adapter_admin_pwd}"

[adapter.keystore]
  certPath = "/home/wso2/security/keystore/mg.pem"
  keyPath = "/home/wso2/security/keystore/mg.key"

[adapter.truststore]
  location = "/home/wso2/security/truststore"

[adapter.consul]
  enable = false
  url = "https://169.254.1.1:8501" # scheme + host ip + port
  pollInterval = 5 # seconds
  aclToken = "d3a2a719-4221-8c65-5212-58d4727427ac"
  mgwServiceName = "wso2"
  serviceMeshEnabled = false
  # certs for tls
  caCertFile = "/home/wso2/security/truststore/consul/consul-agent-ca.pem"
  certFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0.pem"
  keyFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0-key.pem"

```

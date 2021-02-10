# Consul Service Discovery

WSO2 Envoy based Microgateway supports [Consul](https://www.hashicorp.com/products/consul) service discovery to read from the Consul service catalog and discover upstreams automatically.

#### Enabling Consul service discovery

Add the following configuration under the Adapter section to the config.toml file

``` java
[adapter.consul]
enable = true
url = "https://169.254.1.1:8501"
pollInterval = 5
aclToken = "4f295904-1b7f-8abd-3058-cecb06ee3338"
caFile = "/home/wso2/security/truststore/consul/ca.pem"
certFile = "/home/wso2/security/truststore/consul/cert.pem"
keyFile = "/home/wso2/security/truststore/consul/key.pem"
```

The configurations are described in the table below.

|<div style="width:100px">Property</div>| Description                                                                    |
|---------------------------------------|--------------------------------------------------------------------------------|
| `enable`                              | Set this to true to enable Consul service discovery. |
| `url`                                 | The `URL` of the [Consul HTTP API](https://www.consul.io/api-docs#http-api-structure).|
| `pollInterval`                        | The time interval (in seconds) which the Microgateway should fetch updates from Consul service catalog.|
| `aclToken`                            | [ACL Token](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production) generated using Consul.|
| `caFile`                              | CaFile is the optional path to the CA certificate used for Consul communication, defaults to the system bundle if not specified.|
| `certFile`                            | CertFile is the optional path to the certificate for Consul communication. If this is set then you need to also set `keyFile`.|
| `keyFile`                             | KeyFile is the optional path to the private key for Consul communication. If this is set then you need to also set `certFile`.|


!!! note
`caFile`, `certFile`, and `keyFile` are optional and needed and only when you need to override the Adapter's default CA, certificate, and private key.<br>
If Consul agent's [verify_incoming](https://www.consul.io/docs/agent/options#verify_incoming) configuration is set to true, the certificate and private key has to be signed by the same
CA which the Consul agents' certificates are signed.


#### Deploy an API that contains services registered with Consul service catalog

You can set the Consul upstreams using the service name as the key and providing a default host.

Example 1:

```java tab="Format"
x-wso2-production-endpoints:
  urls:
    - consul(<service_name>,<default_host>)
  type: loadbalance
```

```java tab="Example"
x-wso2-production-endpoints:
  urls:
    - consul(pizza,https://10.10.1.5:5000)
  type: loadbalance
```

Example 2:<br>
If you want more fine-grained access to your Consul services, you can limit the access to the upstream services by providing
the `datacenters` and `tags`

```java tab="Format"
x-wso2-production-endpoints:
  urls:
    - consul([<datacenter_1>,<datacenter_2>].<service_name>.[tag_1,tag_2],<default_host>)
  type: loadbalance
```

```java tab="Example"
x-wso2-production-endpoints:
  urls:
    - consul([aws-east,gcp-west].pizza.[prod],https://10.10.1.5:5000)
  type: loadbalance
```

<!-- todo rumesh check the keyword for loadbalance once implemented -->

Consul upstreams can be set both on `x-wso2-production-endpoints` and `x-wso2-sandbox-endpoints`.<br>
Both API level and Resource level endpoints are supported.<br>
Type should always be `loadbalance`.<br>

Upon deploying your API, the Adapter will poll the Consul HTTP API for any changes regarding the service.
If a change occurs, or a health check fails, the Adapter will update the relevant cluster accordingly.

       

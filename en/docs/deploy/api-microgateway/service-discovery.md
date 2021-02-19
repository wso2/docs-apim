# Service Discovery

The following section provides information on the use of using the Consul service registry for service discovery and also how you can deploy an API with Consul service catalog-based services.

## Overview

In a microservices environment, the running service endpoints are not static. A service usually has multiple endpoints. Therefore, a proper mechanism for service discovery is needed for services in order to identify which endpoints run which services. 

A service mesh is used when services want to communicate with each other enforcing authorization and encryption. [Consul](https://www.hashicorp.com/products/consul)  is a service mesh solution, which has been developed by HashiCorp. It solves the following three problems that occur in microservice environments:

- Service Discovery -  through a centralized service registry.
     The service registry is accessed via the HTTP interface or DNS interface. 
- Access control - through Intentions, ACL
- Configuration Management

WSO2 API Microgateway can be used as an ingress gateway in an environment that uses Consul as a service registry so that the APIs or services can be exposed to developers or API consumers while providing security, rate limiting, and other QoS.

Therefore, WSO2 Microgateway supports service discovery using the Consul service registry so that upstream services can be discovered automatically.

## Deploying an API with Consul service catalog based services

Follow the instructions below to deploy an API that contains services registered with the Consul service catalog.

### Prerequistes

Set up Consul securely. 

For more instructions, see the [Consul official documentation](https://www.consul.io/docs).

### Step 1 - Enable Consul service discovery

Add the following configuration under the adapter section in the `config.toml` file.

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

The above configurations are described in the following table.

|<div style="width:100px"><b>Property</b></div>| <b>Description</b>                                                                    |
|---------------------------------------|--------------------------------------------------------------------------------|
| `enable`                              | Set this to `true` to enable Consul service discovery. |
| `url`                                 | The `URL` of the [Consul HTTP API](https://www.consul.io/api-docs#http-api-structure).|
| `pollInterval`                        | The time interval (in seconds) in which the Microgateway should fetch updates from the Consul service catalog.|
| `aclToken`                            | [ACL Token](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production) generated using Consul.|
| `caFile`                              | CaFile is the optional path to the CA certificate used for Consul communication, defaults to the system bundle if not specified.|
| `certFile`                            | CertFile is the optional path to the certificate for Consul communication. If this is set, then you need to also set the `keyFile`.|
| `keyFile`                             | KeyFile is the optional path to the private key for Consul communication. If this is set, then you need to also set the `certFile`.|

!!! note
        - `caFile`, `certFile`, and `keyFile` are optional and needed when you need to override the Adapter's default CA, certificate, and private key.<br>
        
        - If the Consul agent's [verify_incoming](https://www.consul.io/docs/agent/options#verify_incoming) configuration is set to `true`, the certificate and private key have to be signed by the same CA that the Consul agents' certificates are signed.

### Step 2 - Deploy the API

You can set the Consul upstreams using the service name as the key and provide a default host.

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

!!! info
        - The Adapter takes one `pollInterval` amount of time to update the upstreams' data to the Router.
        The requests that come to the Microgateway during that time are served via the
        `default_host`. <br>
        - The Consul upstreams can be set both on `x-wso2-production-endpoints` and `x-wso2-sandbox-endpoints`.<br>
        - The WSO2 API Microgateway supports both API level and Resource level endpoints for Consul service discovery.<br>
        - The `type` under the vendor extension (e.g., `x-wso2-production-endpoints` or `x-wso2-sandbox-endpoints`) should be `loadbalance`.
        <br>
        - Upon successfully [deploying your API]({{base_path}}/get-started/quick-start-guide/quick-start-guide/#step-2-publish-the-api), the Adapter will poll the Consul HTTP API for changes concerning the services.
        If a change occurs or a health check fails, the Adapter will update the relevant cluster accordingly.

# Service Discovery

The following section provides information on the use of using the Consul service registry for service discovery and also how you can deploy an API with Consul service catalog-based services.

## Overview

In a microservice environment, usually the running service endpoints are not static. A service may have multiple upstream endpoints. Therefore, a service discovery mechanism is required for services to locate other services' upstream endpoints.

A service mesh is deployed when services want to communicate with each other with zero trust. Consul is a service mesh solution, which has been developed by HashiCorp. It solves the following problems that occur in microservice environments:

- Service Discovery - through a centralized service registry.
- Access control - through Intentions, and ACL
- Configuration Management

WSO2 Choreo Connect can be used as an ingress gateway in an environment that uses Consul as a service mesh so that the APIs or services can be exposed to developers or API consumers while providing security, rate limiting, and other QoS.

Therefore, WSO2 Choreo Connect supports service discovery using the Consul so that upstream services can be discovered automatically. WSO2 Choreo Connect supports service discovery by connecting to [Consul service registry](https://www.hashicorp.com/products/consul) and discover upstream services automatically.

## Configure Choreo Connect with Consul

Add the following configuration under the Adapter section to the main configuration file of Choreo Connect (`config.toml` file).

``` 
[adapter.consul]
  enable = true
  url = "https://169.254.1.1:8501"
  pollInterval = 5
  aclToken = "d3a2a719-4221-8c65-5212-58d4727427ac"
  mgwServiceName = "choreo-connect"
  serviceMeshEnabled = true
  caCertFile = "/home/wso2/security/truststore/consul/consul-agent-ca.pem"
  certFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0.pem"
  keyFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0-key.pem"
```

The following table describes above configuration.

|<div style="width:100px">Property</div>| Description                                                                    |
|---------------------------------------|--------------------------------------------------------------------------------|
| `enable`                              | Set this to `true` to enable Consul service discovery. |
| `url`                                 | The `URL` of the [Consul HTTP API](https://www.consul.io/api-docs#http-api-structure).|
| `pollInterval`                        | The time interval (in seconds) in which the Choreo Connect should fetch updates from the Consul service catalog.|
| `aclToken`                            | [Access Control Token](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production) generated using Consul. You should grant read access to services when creating the token|
| `mgwServiceName`                      | Choreo Connect natively integrates with Consul service mesh. Therefore a service name is required to be defined inorder to grant access to other services in mesh. |
| `serviceMeshEnabled`                  | Set this to `true` if service mesh is enabled in Consul |
| `caFile`                              | CaFile is the optional path to the CA certificate used for Consul communication, defaults to the system bundle if not specified.|
| `certFile`                            | CertFile is the optional path to the certificate for Consul communication. If this is set, then you need to also set `keyFile`.|
| `keyFile`                             | KeyFile is the optional path to the private key for Consul communication. If this is set, then you need to also set `certFile`.|


!!! note
        - `mgwServiceName` only need to be defined if service mesh enabled in Consul.
        - `caFile`, `certFile`, and `keyFile` are optional and needed when you need to override the Adapter's default CA, certificate, and private key.<br>
        
        - If Consul agent's [verify_incoming](https://www.consul.io/docs/agent/options#verify_incoming) configuration is set to `true`, the certificate and private key have to be signed by the same CA that the Consul agents' certificates are signed.


## How to define the endpoints

### Syntax for defining the Consul upstream endpoints

You can define the Consul upstream endpoints by using the following syntax:

Example 1:

```java tab="Format"
consul(<service_name>,<default_host>)
```

```java tab="Example"
consul(pet,https://10.10.1.5:5000)'
```

Example 2:<br>
If you want more fine-grained access to your Consul services, you can limit the access to the upstream services by providing
the `datacenters` and `tags`


```java tab="Format"
consul([<datacenter_1>,<datacenter_2>].<service_name>.[tag_1,tag_2],<default_host>)
```

```java tab="Example"
consul([aws-east,gcp-west].pet.[prod],https://10.10.1.5:5000)
```

Define the upstream endpoints to the Consul service catalog based services using one of the following methods.

- Use WSO2 API Manager
- Manually editing the Open API definition(when using APICTL)

### Define Consul service catalog based services in WSO2 API Manager

Define the upstream endpoints to the Consul service catalog based services in WSO2 API Manager using the syntax described above via the WSO2 API Manger publisher portal.<br>
You have to define the service using the above mentioned syntax and put it in the Production endpoint ot Sandbox endpoint or both.<br>
[![reference]({{base_path}}/assets/img/deploy/consul-apim.png)]({{base_path}}/assets/img/deploy/consul-apim.png)

### Define Consul service catalog based services in an Open API definition (when using APICTL)

Define the upstream endpoints to the Consul service catalog based services directly in the OpenAPI definition file using the syntax explained above. <br>
The definition should go under the `urls` section of `x-wso2-production-endpoints` or `x-wso2-sandbox-endpoints` (or both).


```yaml tab="Format"
x-wso2-production-endpoints:
  urls:
    - consul(<service_name>,<default_host>)
  type: load_balance
```

```yaml tab="Example"
paths:
  /pet:
    x-wso2-production-endpoints:
      urls:
        - consul(pet,https://10.10.1.5:5000)
      type: load_balance
    post:
      consumes:
        - application/json
        - application/xml
      description: ""
      operationId: addPet
      parameters:
        - description: Pet object that needs to be added to the store
          in: body
          name: body
          required: true
          schema:
            $ref: '#/definitions/Pet'
```

!!! info
        - Choreo Connect takes one `pollInterval` amount of time to update the upstreams' configuration after being updated in Consul service catalog.<br>
        - At the initial start of the Adapter component, the requests that come to the Choreo Connect during are served via the `default_host` until the Adapter gets configuration from a Consul client. <br>
        - Choreo Connect supports both API level and Resource level endpoints for Consul service discovery.<br>
        - If multiple upstreams are discovered through Consul for the same service name, requests are ***Load Balanced*** to the upstreams.
        <br>

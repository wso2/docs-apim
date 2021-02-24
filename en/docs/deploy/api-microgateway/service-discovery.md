# Service Discovery

The following section provides information on the use of using the Consul service registry for service discovery and also how you can deploy an API with Consul service catalog-based services.

## Overview

In a microservice environment, usually the running service endpoints are not static. A service may have multiple upstream endpoints. Therefore, service discovery mechanism is required for services to locate other services' upstream endpoints.

A service mesh deployed when services want to communicate with each other with zero trust. Consul is a service mesh solution, which has been developed by HashiCorp. It solves the following problems that occur in microservice environments:

- Service Discovery - through a centralized service registry.
- Access control - through Intentions, and ACL
- Configuration Management

WSO2 API Microgateway can be used as an ingress gateway in an environment that uses Consul as a service mesh so that the APIs or services can be exposed to developers or API consumers while providing security, rate limiting, and other QoS.

Therefore, WSO2 Microgateway supports service discovery using the Consul so that upstream services can be discovered automatically.
WSO2 Microgateway supports service discovery by connecting to [Consul service registry](https://www.hashicorp.com/products/consul) and discover upstream services automatically.
![reference](../../assets/img/deploy/consul-reference-with-mesh.jpeg)

## Deploying an API with Consul service catalog based services

Follow the instructions below to deploy an API that contains services registered with the Consul service catalog.

### Prerequisites

Set up Consul securely.

For more instructions, see the [Consul official documentation](https://www.consul.io/docs).

### Step 1 - Enable Consul service discovery

Add the following configuration under the Adapter section to the configuration file of the Microgateway (`config.toml` file)

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
| `pollInterval`                        | The time interval (in seconds) in which the Microgateway should fetch updates from Consul service catalog.|
| `aclToken`                            | [ACL Token](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production) generated using Consul.|
| `caFile`                              | CaFile is the optional path to the CA certificate used for Consul communication, defaults to the system bundle if not specified.|
| `certFile`                            | CertFile is the optional path to the certificate for Consul communication. If this is set then you need to also set `keyFile`.|
| `keyFile`                             | KeyFile is the optional path to the private key for Consul communication. If this is set then you need to also set `certFile`.|


!!! note
        - `caFile`, `certFile`, and `keyFile` are optional and needed when you need to override the Adapter's default CA, certificate, and private key.<br>
        - If Consul agent's [verify_incoming](https://www.consul.io/docs/agent/options#verify_incoming) configuration is set to true, the certificate and private key has to be signed by the same
        CA that the Consul agents' certificates are signed.


### Step 2 - Deploy the API

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

You can use either WSO2 API Manager to define upstream endpoints, or you can directly edit the Open API definition file.

#### Define Consul service catalog based services in WSO2 API Manager

Using the above syntax you can define the endpoints to the Consul service catalog based services in WSO2 API Manager.

![reference](../../assets/img/deploy/consul-apim.png)

#### Define Consul service catalog based services using the Open API definition

Refer to section [defining endpoints in an openapi definition](endpoints/defining-endpoints-in-an-openapi-definition.md) 
for more information.



```java tab="Format"
        x-wso2-production-endpoints:
          urls:
            - consul(<service_name>,<default_host>)
          type: load_balance
```

```java tab="Example"
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


<!-- todo add info about cert rotation once implemented -->


!!! info
        - The adapter takes one `pollInterval` amount of time to update the upstreams' data to the Router.
        During that time requests that arrive at the Microgateway are served from the
        `default_host`. <br>
        - Consul upstreams are supported both on ***Production Endpoint*** and ***Sandbox Endpoint***.<br>
        - Microgateway supports both API level and Resource level endpoints for Consul service discovery.<br>
        - Upstreams discovered through Consul are configured as ***Load Balanced*** clusters.
        <br>
        - Upon successfully [deploying your API](../api-microgateway/getting-started/quick-start-guide/quick-start-guide-overview.md), the Adapter will poll the Consul HTTP API for changes concerning the services.
        If a change occurs, or a health check fails, the Adapter will update the relevant cluster accordingly.

       

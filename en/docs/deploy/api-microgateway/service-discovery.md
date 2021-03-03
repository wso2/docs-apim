Service Discovery¶
The following section provides information on the use of using the Consul service registry for service discovery and also how you can deploy an API with Consul service catalog-based services.

Overview¶
In a microservice environment, usually the running service endpoints are not static. A service may have multiple upstream endpoints. Therefore, a service discovery mechanism is required for services to locate other services' upstream endpoints.

A service mesh is deployed when services want to communicate with each other with zero trust. Consul is a service mesh solution, which has been developed by HashiCorp. It solves the following problems that occur in microservice environments:

Service Discovery - through a centralized service registry.
Access control - through Intentions, and ACL
Configuration Management
WSO2 API Microgateway can be used as an ingress gateway in an environment that uses Consul as a service mesh so that the APIs or services can be exposed to developers or API consumers while providing security, rate limiting, and other QoS.

Therefore, WSO2 Microgateway supports service discovery using the Consul so that upstream services can be discovered automatically. WSO2 Microgateway supports service discovery by connecting to Consul service registry and discover upstream services automatically.

Consul reference with mesh

Deploying an API with Consul service catalog based services¶
Follow the instructions below to deploy an API that contains services registered with the Consul service catalog.

Prerequisites¶
Set up Consul securely.

For more instructions, see the Consul official documentation.

Step 1 - Enable Consul service discovery¶
Add the following configuration under the Adapter section to the configuration file of the Microgateway (config.toml file).


[adapter.consul]
enable = true
url = "https://169.254.1.1:8501"
pollInterval = 5
aclToken = "4f295904-1b7f-8abd-3058-cecb06ee3338"
caFile = "/home/wso2/security/truststore/consul/ca.pem"
certFile = "/home/wso2/security/truststore/consul/cert.pem"
keyFile = "/home/wso2/security/truststore/consul/key.pem"
The above configurations are described in the following table.

Property
Description
enable	Set this to true to enable Consul service discovery.
url	The URL of the Consul HTTP API.
pollInterval	The time interval (in seconds) in which the Microgateway should fetch updates from the Consul service catalog.
aclToken	ACL Token generated using Consul.
caFile	CaFile is the optional path to the CA certificate used for Consul communication, defaults to the system bundle if not specified.
certFile	CertFile is the optional path to the certificate for Consul communication. If this is set, then you need to also set keyFile.
keyFile	KeyFile is the optional path to the private key for Consul communication. If this is set, then you need to also set certFile.
Note

caFile, certFile, and keyFile are optional and needed when you need to override the Adapter's default CA, certificate, and private key.

If Consul agent's verify_incoming configuration is set to true, the certificate and private key have to be signed by the same CA that the Consul agents' certificates are signed.

Step 2 - Define the endpoints¶
Define the upstream endpoints to the Consul service catalog based services using one of the following methods.

Define Consul service catalog based services in WSO2 API Manager
Define Consul service catalog based services using an Open API definition
Define Consul service catalog based services in WSO2 API Manager¶
Define the upstream endpoints to the Consul service catalog based services in WSO2 API Manager using the proper syntax as explained in Defining the Consul upstream endpoints via the Publisher console.

reference

Define Consul service catalog based services using an Open API definition¶
Define the upstream endpoints to the Consul service catalog based services directly in the OpenAPI definition file using the proper syntax as explained in Defining the Consul upstream endpoints.

For more information, see Defining endpoints in an OpenAPI definition.

Format
Example

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
Step 3 - Deploy the API¶
Upon successfully deploying your API, the Adapter will poll the Consul HTTP API for changes concerning the services.

If a change occurs, or a health check fails, the Adapter will update the relevant cluster accordingly.

Defining the Consul upstream endpoints¶
You can define the Consul upstream endpoints by using the following syntax:

Example 1:

Format

consul(<service_name>,<default_host>)
Example
Example 2:
If you want more fine-grained access to your Consul services, you can limit the access to the upstream services by providing the datacenters and tags

Format

consul([<datacenter_1>,<datacenter_2>].<service_name>.[tag_1,tag_2],<default_host>)
Example
Info

The Adapter takes one pollInterval amount of time to update the upstreams' data to the Router. The requests that come to the Microgateway during that time are served via the default_host.
Consul upstreams are supported both on Production Endpoint and Sandbox Endpoint.
Microgateway supports both API level and Resource level endpoints for Consul service discovery.
Upstreams discovered through Consul are configured as load balanced clusters.

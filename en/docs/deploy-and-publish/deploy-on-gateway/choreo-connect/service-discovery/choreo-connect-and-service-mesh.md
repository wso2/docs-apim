# Configuring Choreo Connect with Consul Service Mesh

In a traditional on-premise datacenter, components inside the datacenter are considered secure. Any component inside the data center could communicate with another component.
If one node is compromised, the attacker could gain access to many components inside the data center.
Consul service mesh addresses this issue by implementing a zero-trust security model by attaching a sidecar proxy to each node. Traffic flows through the side-car proxy while the side-car proxy enforces security policies.
Consul uses TLS certificates to identify each service(and sidecar) and allows you to define which service is allowed to communicate with using ACL policies.
Choreo Connect can act as ingress to Consul service mesh by registering itself with service mesh as a [native service](https://www.consul.io/docs/connect/native).<br>

This part of the document describes how to set up Choreo Connect with Consul service mesh.<br>

Example:

[![service discovery]({{base_path}}/assets/img/deploy/consul-reference-with-mesh.png){: style="width:70%"}]({{base_path}}/assets/img/deploy/consul-reference-with-mesh.png)

## Step 1 - Setup Consul

Set up Consul securely.<br>
For more instructions, see the [Consul official documentation](https://www.consul.io/docs).

## Step 2 - Add Choreo Connect as a native service in Consul

You can use the Consul HTTP API to add Choreo Connect as a native service.<br>

Example Request:

```shell
curl \
--request PUT \
--data @payload.json \
http://169.254.1.1:8500/v1/agent/service/register
```
Example payload file:

```json
{
  "service": {
    "id": "choreo-connect-1",
    "name": "choreo-connect",
    "tags": [
      "wso2",
      "production"
    ],
    "connect": {
      "native": true
    },
    "token": "521059b1-66fd-7e25-7824-2597b8b712d9"
  }
}
```

For more information, see [Consul HTTP API](https://www.consul.io/api-docs/agent/service#register-service) in the Consul official documentation.

## Step 3 - Configure Choreo Connect

Refer to the Adapter section to the main configuration file of Choreo Connect (`config.toml` file).

```
[adapter.consul]
  enabled = true
  url = "https://169.254.1.1:8501"
  pollInterval = 5
  ACLToken = "d3a2a719-4221-8c65-5212-58d4727427ac"
  mgwServiceName = "choreo-connect"
  serviceMeshEnabled = true
  caCertFile = "/home/wso2/security/truststore/consul/consul-agent-ca.pem"
  certFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0.pem"
  keyFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0-key.pem"
```

1. Change the `url` to the URL of the Consul agent you want to connect to.
2. Change the `ACLToken` to the token you generated from the previous step.
3. Make sure the `serviceMeshEnabled` property  is set to `true`.
4. The `mgwServiceName` property should be the name that you used to register Choreo Connect as a Consul service.
5. Add the paths to the `caCertFile`, `certFile`, and `keyFile` files that you generated from the previous step.
6. Start Choreo Connect.

## Step 4 - Deploy the API

You can use either WSO2 API Manager or APICTL to deploy APIs as described in [defining the endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/service-discovery/service-discovery-overview/#defining-the-endpoints).

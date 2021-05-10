# Configure Choreo Connect with Consul Discovery (without service mesh)

As the number of services grows within your organization, you may have multiple nodes running the same service.
You might spin up new nodes as traffic increases to service and take down some nodes as traffic decreases.
Therefore, nodes that want to communicate with other nodes require a mechanism to discover how many nodes are up and running and how to connect to them(service discovery).<br>
Further, they need to know which nodes are healthy to send traffic to(health checks).<br>
You might have different versions of the same service running dedicated for multiple purposes such as production, development, and testing(tagging).<br>

Consul's features such as service discovery, health checks, and tagging system can be used as needed without building a full service mesh.
In this case, if you need to let end-users consume your services, you can use Choreo Connect as the API gateway.<br>

This part of the document describes how to set up Choreo Connect with Consul for service discovery.

![service discovery]({{base_path}}/assets/img/deploy/consul-reference-discovery.png)

## Step 1 - Setup Consul
Set up Consul securely.<br>
For more instructions, see the [Consul official documentation](https://www.consul.io/docs).
## Step 2 - Configure Choreo Connect

``` 
[adapter.consul]
  enable = true
  url = "https://169.254.1.1:8501"
  pollInterval = 5
  aclToken = "d3a2a719-4221-8c65-5212-58d4727427ac"
  mgwServiceName = ""
  serviceMeshEnabled = false
  caCertFile = "/home/wso2/security/truststore/consul/consul-agent-ca.pem"
  certFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0.pem"
  keyFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0-key.pem"
```
<ol>
<li> Change the `url` to the url of the Consul agent you want to connect to.<br></li>
<li>Change the `aclToken` to the token you generated from the previous step.<br></li> 
<li>`serviceMeshEnabled` should be set to `false`.<br></li>
<li>You can leave the `mgwServiceName` empty as the property is not needed.<br></li>
<li>Add the `caCertFile`, `certFile`, and `keyFile` you generated from the previous step.<br></li>
<li>Then start Choreo Connect.</li>
</ol>

## Step 3 - Deploy the API
You can use either WSO2 API Manager or APICTL to deploy APIs as described in [how to define the endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/service-discovery/service-discovery-overview/#how-to-define-the-endpoints) guide.
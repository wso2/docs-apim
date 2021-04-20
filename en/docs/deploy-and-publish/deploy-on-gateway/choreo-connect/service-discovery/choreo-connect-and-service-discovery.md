# Configure Choreo Connect with Consul Discovery (without service mesh)

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
Change the `url` to the url of the Consul agent you want to connect to.<br>
Change the `aclToken` to the token you generated from the previous step.<br>
`serviceMeshEnabled` should be set to `false`.<br>
You can leave the `mgwServiceName` empty as the property is not needed.<br>
Add the `caCertFile`, `certFile`, and `keyFile` you generated from the previous step.<br>
Then start Choreo Connect.

## Step 3 - Deploy the API
You can use either WSO2 API Manager or APICTL to deploy APIs as described in [how to define the endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/service-discovery/#how-to-define-the-endpoints) guide.
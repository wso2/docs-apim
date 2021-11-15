# Configure Choreo Connect with Consul service mesh deployed on Kubernetes
Consul service mesh supports first-class integrations between Consul and Kubernetes.
You can also [sync Kubernetes services](https://www.consul.io/docs/k8s/service-sync) with non-Kubernetes services using Consul.
Read more on how Consul works with Kubernetes on [Consul official documentation](https://www.consul.io/docs/k8s). <br>
This part of the document describes how to set up Choreo Connect with Consul service mesh in Kubernetes.<br>

Example:

![service discovery]({{base_path}}/assets/img/deploy/consul-reference-k8s.png)

## Step 1 - Deploy Consul on K8s
Deploy Consul using the [official Helm Chart](https://helm.releases.hashicorp.com/).<br>
For more instructions, see the [Consul official documentation](https://www.consul.io/docs/k8s).
## Step 2 - Configure Choreo Connect

In the config-toml-configmap.yaml file, go to the \[adapter.consul] section and update the configurations.
```
[adapter.consul]
  enable = true
  url = "http://consul-server:8500"
  pollInterval = 5
  ACLToken = "d3a2a719-4221-8c65-5212-58d4727427ac"
  mgwServiceName = "choreo-connect"
  serviceMeshEnabled = true
  caCertFile = "/home/wso2/security/truststore/consul/consul-agent-ca.pem"
  certFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0.pem"
  keyFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0-key.pem"
```

<ol>
<li> Change the `url` to the URL of the Consul agent you want to connect to.<br></li>
<li>Change the `ACLToken` to the token you generated from the previous step.<br></li> 
<li>`serviceMeshEnabled` should be set to `true`.<br></li>
<li>Configure `mgwServiceName` as choreo-connect.<br></li>
<li>Add the `caCertFile`, `certFile`, and `keyFile` you generated from the previous step.<br></li>
<li>Apply the K8s artifacts for Choreo Connect.</li>
</ol>



## Step 3 - Deploy the API
Deploy WSO2 API Manger on Kubernetes.<br>
Using the API Manager, deploy your API as described in [how to define the endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/service-discovery/service-discovery-overview/#how-to-define-the-endpoints) guide.

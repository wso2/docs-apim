# Configuring Choreo Connect with Consul Service Mesh Deployed on Kubernetes

Consul service mesh supports first-class integrations between Consul and Kubernetes.
You can also [sync Kubernetes services](https://www.consul.io/docs/k8s/service-sync) with non-Kubernetes services using Consul.
For more information on how how Consul works with Kubernetes, go to the [Consul official documentation](https://www.consul.io/docs/k8s).

Follow the instructions below to set up Choreo Connect with Consul service mesh in Kubernetes:

Example:

[![service discovery]({{base_path}}/assets/img/deploy/consul-reference-k8s.png){: style="width:70%"}]({{base_path}}/assets/img/deploy/consul-reference-k8s.png)

## Step 1 - Deploy Consul on K8s

Deploy Consul using the [official Helm Chart](https://helm.releases.hashicorp.com/).

For instructions, see the [Consul official documentation](https://www.consul.io/docs/k8s).

## Step 2 - Configure Choreo Connect

1. Navigate to the `config-toml-configmap.yaml` file.
2. Go to the `[adapter.consul]` section and update the configurations.

    ```
    [adapter.consul]
     enabled = true
     url = "http://consul-server:8500"
     pollInterval = 5
     ACLToken = "d3a2a719-4221-8c65-5212-58d4727427ac"
     mgwServiceName = "choreo-connect"
     serviceMeshEnabled = true
     caCertFile = "/home/wso2/security/truststore/consul/consul-agent-ca.pem"
     certFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0.pem"
     keyFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0-key.pem"
    ```

     1. Change the `url` to the URL of the Consul agent that you want to connect to.
     2. Change the `ACLToken` to the token you generated from the previous step.
     3. Set `serviceMeshEnabled` to `true`.
     4. Configure `mgwServiceName` as `choreo-connect`.
     5. Add the `caCertFile`, `certFile`, and `keyFile` files that you generated from the previous step.
     6. [Apply the K8s artifacts for Choreo Connect]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-kubernetes/#step-1-setup-choreo-connect-in-kubernetes).

## Step 3 - Deploy the API

Deploy WSO2 API Manger on Kubernetes.

Use WSO2 API Manager to deploy your API as described in the [defining the endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/service-discovery/service-discovery-overview/#defining-the-endpoints) guide.

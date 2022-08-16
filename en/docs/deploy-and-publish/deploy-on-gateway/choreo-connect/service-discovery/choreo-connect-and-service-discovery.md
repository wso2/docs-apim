# Configuring Choreo Connect with Consul Discovery (Without Service Mesh)

As the number of services grows within your organization, you may have multiple nodes running the same service.
You might spin up new nodes as traffic increases to the service and take down some nodes as traffic decreases.
Therefore, nodes that want to communicate with other nodes require a mechanism to discover how many nodes are up and running and how to connect to them (service discovery). Furthermore, they need to know which nodes are healthy to send traffic to (health checks).
You might have different versions of the same service running dedicated for multiple purposes such as production, development, and testing (tagging).

Consul's features such as service discovery, health checks, and tagging system can be used as needed without building a full service mesh.
In this case, if you need to let end-users consume your services, you can use Choreo Connect as the API Gateway.<br>

Follow the instructions below to set up Choreo Connect with Consul for service discovery:

[![service discovery]({{base_path}}/assets/img/deploy/consul-reference-discovery.png){: style="width:70%"}]({{base_path}}/assets/img/deploy/consul-reference-discovery.png)

## Step 1 - Setup Consul

Set up Consul securely.

For instructions, see the [Consul official documentation](https://www.consul.io/docs).

## Step 2 - Configure Choreo Connect

1. Navigate to the `config-toml-configmap.yaml` file.
2. Go to the `[adapter.consul]` section and update the configurations.

    ``` 
    [adapter.consul]
      enabled = true
      url = "https://169.254.1.1:8501"
      pollInterval = 5
      ACLToken = "d3a2a719-4221-8c65-5212-58d4727427ac"
      mgwServiceName = ""
      serviceMeshEnabled = false
      caCertFile = "/home/wso2/security/truststore/consul/consul-agent-ca.pem"
      certFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0.pem"
      keyFile = "/home/wso2/security/truststore/consul/local-dc-client-consul-0-key.pem"
    ```

      1. Change the `url` to the URL of the Consul agent you want to connect to.
      2. Change the `ACLToken` to the token you generated from the previous step.
      3. Set the `serviceMeshEnabled` field to `false`.
      4. Leave the `mgwServiceName` field empty as this property is not needed.
      5. Add the `caCertFile`, `certFile`, and `keyFile` files that you generated from the previous step.
      6. Start Choreo Connect.

## Step 3 - Deploy the API

You can use either WSO2 API Manager or APICTL to deploy APIs as described in [defining the endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/service-discovery/service-discovery-overview/#defining-the-endpoints).

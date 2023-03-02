
Open the Choreo Connect configuration file according to the deployment type you are using.

    ??? abstract "Click here to see the configuration file location for your Choreo Connect deployment."
        Navigate to the correct folder path and open the `config.toml` or `config-toml-configmap.yaml` file based on your Choreo Connect deployment.

        | **Deployment** | **Mode**| **File name** | **Directory** |
        |----------------|---------|---------------|---------------|
        | Docker Compose |[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)| `config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/` |
        | Docker Compose |[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/) | `config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/` |
        | Kubernetes |[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)| `config-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/` |
        | Kubernetes |[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)| `config-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/` |

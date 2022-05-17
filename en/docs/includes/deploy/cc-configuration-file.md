
Navigate to the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/config.toml` file when using Choreo Connect in Docker with WSO2 API Manager as the Control Plane.

    ??? note "Click here to see the file path of the configuration file for all Choreo Connect deployments."
        Navigate to the correct folder path and open the `config.toml` or `config-toml-configmap.yaml` file based on your Choreo Connect deployment.

        | **Deployment** | **File name** | **Directory** |
        |------------|-----------|-----------|
        | Docker with WSO2 API Controller | `config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/` |
        | Docker with WSO2 API Manager as the Control Plane | `config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/` |
        | Kubernetes with WSO2 API Controller | `config-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/` |
        | Kubernetes with WSO2 API Manager as the Control Plane | `config-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/config-toml-configmap.yaml` |

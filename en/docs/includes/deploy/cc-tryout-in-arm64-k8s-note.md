
    ??? note "Click here if you are using an ARM64 based machine (e.g., Apple M1)"
        If you are trying out in **ARM64** based machine (e.g., Apple M1) update the Docker image names with the following.
    
        - Kubernetes `deployment.yaml` files
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/adapter-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/choreo-connect-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/apim/apim-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/choreo-connect/adapter-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/choreo-connect/choreo-connect-deployment.yaml`
        
        | Existing (Default) image name      | Image name for tryout in ARM64 (e.g.: Apple M1) |
        |------------------------------------|-------------------------------------------------|
        | `wso2/choreo-connect-adapter:1.0.0`  | `wso2/choreo-connect-adapter:1.0.0-ubuntu`        |
        | `wso2/choreo-connect-enforcer:1.0.0` | `wso2/choreo-connect-enforcer:1.0.0-ubuntu`       |
        | `wso2/choreo-connect-router:1.0.0`   | `wso2/choreo-connect-router:1.0.0-ubuntu`         |
        | `wso2/wso2am:4.0.0-alpine`           | `wso2am/wso2am:4.0.0-ubuntu`                      |
    
        **Note:**</br>
        Note that the above Ubuntu based (`*-ubuntu`) images are for **tryout purpose only** and are **not recommended for a production deployment**.


    ??? note "Tryout in ARM64 based machine (ex. Apple M1)"
        If you are trying out in **ARM64** based machine (ex. Apple M1) update the docker image names with the following in
    
        - docker-compose.yaml (If you are trying out with Docker)
            - `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/docker-compose.yaml`
            - `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/docker-compose.yaml`
        - Kubernetes deployment.yaml (If you are trying out with Kubernetes) files.
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/adapter-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/choreo-connect-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/apim/apim-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/choreo-connect/adapter-deployment.yaml`
            - `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/choreo-connect/choreo-connect-deployment.yaml`
        
        | Existing (Default) image name      | Image name for tryout in ARM64 (ex: Apple M1) |
        |------------------------------------|-----------------------------------------------|
        | wso2/choreo-connect-adapter:1.0.0  | wso2/choreo-connect-adapter:1.0.0-ubuntu      |
        | wso2/choreo-connect-enforcer:1.0.0 | wso2/choreo-connect-enforcer:1.0.0-ubuntu     |
        | wso2/choreo-connect-router:1.0.0   | wso2/choreo-connect-router:1.0.0-ubuntu       |
        | wso2/wso2am:4.0.0-alpine           | wso2am/wso2am:4.0.0-ubuntu                    |
    
        **Note:**</br>
        Note that the above Ubuntu based (`*-ubuntu`) images are for **tryout purpose only**, **not recommended for a production deployment**.

# Deploying API-M on Kubernetes using Helm Resources

Follow the instructions below to use Kubernetes (K8s) and Helm resources for container-based deployments of WSO2 API Manager (API-M).

!!! note
        -   In the context of this document, **&lt;`HELM_HOME>         `** refers to a local copy of the [`wso2/helm-apim         `](https://github.com/wso2/helm-apim/).

!!! Prerequisites
    
    - Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Helm](https://helm.sh/docs/intro/install/), [Dep](https://golang.github.io/dep/docs/installation.html)
      and [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/) in order to run the steps
      provided in the following quick start guide.<br><br>
    
    - An already setup [Kubernetes cluster](https://kubernetes.io/docs/setup/#learning-environment).<br><br>
    
    - Install [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) **OR** [Traefik](https://doc.traefik.io/traefik/getting-started/kubernetes/#install-traefik) for Kubernetes Gateway API support. Please note that Helm resources for WSO2 product
      deployment patterns are compatible with NGINX Ingress Controller Git release [`nginx-0.22.0`](https://github.com/kubernetes/ingress-nginx/releases/tag/nginx-0.22.0).

1.  Checkout the Helm Resources for WSO2 API Manager Git repository using `git clone` :

    ``` 
    git clone https://github.com/wso2/helm-apim.git
    cd helm-apim
    git checkout tags/all-in-one-4.6.0-1
    ```

2.  Provide the necessary configurations.

    !!! note
        The default product configurations for deployment of WSO2 API Manager are available [here](https://github.com/wso2/helm-apim/tree/all-in-one-4.6.0-1/all-in-one) folder. Change the configurations, as necessary.

    Open the `<HELM_HOME>/all-in-one/values.yaml` and provide the following values for WSO2 Subscription Configurations.
    
     
    | Parameter                                                                   | Description                                                                               | Default Value               |
    |-----------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|-----------------------------|
    | `wso2.deployment.image.registry`                                                | Registry of the APIM Docker image                                                           | ""                          |
    | `wso2.deployment.image.repository`                                                | Repostiory of the APIM Docker image                                                           | ""                          |
    | `wso2.deployment.image.digest`                                                | Digest of the APIM Docker image                                                           | ""                          |

    **Using Kubernetes Gateway API (Alternative to NGINX Ingress)**
    
    If you prefer to use Kubernetes Gateway API instead of NGINX Ingress Controller, configure the following in `<HELM_HOME>/all-in-one/values.yaml`:
    
    - Disable traditional Ingress resources:
    
        ```yaml
        kubernetes:
          ingress:
            ratelimit:
              enabled: false
            management:
              enabled: false
            gateway:
              enabled: false
            websocket:
              enabled: false
            websub:
              enabled: false
        ```
    
    - Enable Gateway API resources:
    
        ```yaml
        kubernetes:
          gatewayAPI:
            enabled: true
            management:
              enabled: true
            gateway:
              enabled: true
            websocket:
              enabled: true
            websub:
              enabled: true
        ```
    
    !!! note
        Ensure that Gateway API CRDs are installed in your cluster and you have a compatible Gateway implementation configured. Refer to the [Kubernetes Gateway API documentation](https://gateway-api.sigs.k8s.io/) for more details.

3. Deploy WSO2 API Manager

    ```
    helm install --dependency-update <RELEASE_NAME> <HELM_HOME>/all-in-one --namespace <NAMESPACE>
    ```

4.  Access Management Console.

    1.  Obtain the external IP (`EXTERNAL-IP`):
    
        **If using NGINX Ingress Controller:**
        
        List down the Kubernetes Ingresses:
        
        ```
        kubectl get ing -n <NAMESPACE>
        ```

        Example:
        ```
        NAME                                                CLASS   HOSTS                   ADDRESS             PORTS     AGE
        <RELEASE_NAME>-am-all-in-one-am-gateway-ingress     nginx   gw.wso2.com             <EXTERNAL-IP>        80, 443   8s
        <RELEASE_NAME>-am-all-in-one-am-ingress             nginx   am.wso2.com             <EXTERNAL-IP>        80, 443   8s
        <RELEASE_NAME>-am-all-in-one-am-websocket-ingress   nginx   websocket.wso2.com      <EXTERNAL-IP>        80, 443   8s
        <RELEASE_NAME>-am-all-in-one-am-websub-ingress      nginx   websub.wso2.com         <EXTERNAL-IP>        80, 443   8s
        ```
        
        **If using Traefik Gateway API:**
        
        Get the external IP from the Traefik service:
        
        ```
        kubectl get svc -n traefik
        ```
        
        Example:
        ```
        NAME      TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
        traefik   LoadBalancer   10.43.x.x      <EXTERNAL-IP>   80:32080/TCP,443:32443/TCP   5m
        ```

    2.  Add the above hosts as entries in `/etc/hosts` file as follows:
    
          ```
          <EXTERNAL-IP>	am.wso2.com
          <EXTERNAL-IP>	gw.wso2.com
          <EXTERNAL-IP>	websocket.wso2.com
          <EXTERNAL-IP>	websub.wso2.com
          ```

    3.  Try navigating to `https://am.wso2.com/carbon`, `https://am.wso2.com/publisher` and `https://am.wso2.com/devportal` from your favorite browser.
    
!!! note
    You can read the [README guide](https://github.com/wso2/helm-apim/tree/all-in-one-4.6.0-1/all-in-one/README.md) of WSO2 API Manager Git repository for further details on other dependencies and configurations.

For different deployment patterns, see the deployment configurations with regard to the [Advanced Deployment Patterns]({{base_path}}/install-and-setup/setup/deployment-overview/).

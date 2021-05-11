# Deploying API-M on Kubernetes using Helm Resources

!!! Warning
    **The contents on this page are currently under review**

Follow the instructions below to use Kubernetes (K8s) and Helm resources for container-based deployments of WSO2 API Manager (API-M).

!!! note
        -   In the context of this document, **&lt;`KUBERNETES_HOME>         `** refers to a local copy of the [`wso2/kubernetes-apim         `](https://github.com/wso2/kubernetes-apim/) Git repository that **includes Helm Resources for WSO2 API Manager.**
        -   **&lt;`HELM_HOME>`** will refer to **&lt;`<KUBERNETES_HOME>/simple`**.

!!! Prerequisites
    
    - In order to use WSO2 Helm resources, you need an active [WSO2 Subscription](https://wso2.com/subscription).
      If you do not possess an active WSO2 Subscription already, you can sign up for a WSO2 Free Trial Subscription from [here](https://wso2.com/free-trial-subscription).
      Otherwise you can proceed with Docker images, which are created using GA releases.<br><br>
    
    - Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Helm](https://helm.sh/docs/intro/install/), [Dep](https://golang.github.io/dep/docs/installation.html)
      and [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/) in order to run the steps
      provided in the following quick start guide.<br><br>
    
    - An already setup [Kubernetes cluster](https://kubernetes.io/docs/setup/#learning-environment).<br><br>
    
    - Install [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/). Please note that Helm resources for WSO2 product
      deployment patterns are compatible with NGINX Ingress Controller Git release [`nginx-0.22.0`](https://github.com/kubernetes/ingress-nginx/releases/tag/nginx-0.22.0).
    
    - Add the WSO2 Helm chart repository.
        
          ```
           helm repo add wso2 https://helm.wso2.com && helm repo update
          ```

1.  Checkout the Helm Resources for WSO2 API Manager Git repository using `git clone` :

    ```
    git clone https://github.com/wso2/kubernetes-apim.git
    git checkout tags/v4.0.0.1
    ```

2.  Provide the necessary configurations.

    !!! note
        The default product configurations for deployment of WSO2 API Manager are available [here](https://github.com/wso2/kubernetes-apim/tree/v4.0.0.1/simple/am-single/templates) folder. Change the configurations, as necessary.

    Open the `<HELM_HOME>/am-single/values.yaml` file and provide the following values for WSO2 Subscription Configurations.
    
     
    | Parameter                                                                   | Description                                                                               | Default Value               |
    |-----------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|-----------------------------|
    | `wso2.subscription.username`                                                | Your WSO2 Subscription username                                                           | ""                          |
    | `wso2.subscription.password`                                                | Your WSO2 Subscription password                                                           | ""                          |
    
    !!! note
        If you do not have an active WSO2 subscription, do not change the parameters `wso2.subscription.username` and `wso2.subscription.password`. 


3.   Deploy WSO2 API Manager with Analytics.
    
    Setup the cloud Analytics solution and obtain an on-prem key. For more information, see [Register for Analytics](https://apim.docs.wso2.com/en/latest/observe/api-manager-analytics/configure-analytics/register-for-analytics/).

    ```
    helm install --dependency-update --name <RELEASE_NAME> <HELM_HOME>/am-single --namespace <NAMESPACE> --set wso2.choreoAnalytics.enabled=true --set wso2.choreoAnalytics.endpoint=<CHOREO_ANALYTICS_ENDPOINT> --set wso2.choreoAnalytics.onpremKey=<ONPREM_KEY>
    ```

    You can also provide the above configurations in the `<HELM_HOME>/am-single/values.yaml` file.

    | Parameter                                                                   | Description                                                                               | Default Value               |
    |-----------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|-----------------------------|
    | `wso2.choreoAnalytics.enabled`                                                | Analytics enabled or not                                                           | false                          |
    | `wso2.choreoAnalytics.endpoint`                                                | Analytics data publishing endpoint                                                           | https://analytics-event-auth.choreo.dev/auth/v1                          |
    | `wso2.choreoAnalytics.onpremKey`                                                | On-prem key for Analytics                                                           | ""                          |


4.  Access Management Console.

    1.  Obtain the external IP (`EXTERNAL-IP`) of the Ingress resources by listing down the Kubernetes Ingresses.
    
        ```
        kubectl get ing -n <NAMESPACE>
        ```
        Example:
        ``` java
        NAME                                               HOSTS                                ADDRESS          PORTS      AGE
        wso2am-single-node-am-gateway-ingress               <RELEASE_NAME>-gateway                <EXTERNAL-IP>    80, 443    7m
        wso2am-single-node-am-ingress                       <RELEASE_NAME>-am                     <EXTERNAL-IP>    80, 443    7m
        wso2am-single-node-am-websub-ingress                <RELEASE_NAME>-websub                 <EXTERNAL-IP>    80, 443    7m
        ```

    2.  Add the above hosts as entries in `/etc/hosts` file as follows:
    
          ```
          <EXTERNAL-IP>	<RELEASE_NAME>-am
          <EXTERNAL-IP>	<RELEASE_NAME>-gateway
          <EXTERNAL-IP>	<RELEASE_NAME>-websub
          ```

    3.  Try navigating to `https://<RELEASE_NAME>-am/carbon`, `https://<RELEASE_NAME>-am/publisher` and `https://<RELEASE_NAME>-am/devportal` from your favorite browser.
    
!!! note
    You can read the [README guide](https://github.com/wso2/kubernetes-apim/blob/v4.0.0.1/simple/am-single/README.md) of WSO2 API Manager Git repository for further details on other dependencies and configurations. 

For more information, see the deployment configurations with regard to the [Advanced Deployment Patterns]({{base_path}}/install-and-setup/setup/deployment-overview/).

- [Standard HA Deployment](https://github.com/wso2/kubernetes-apim/blob/v4.0.0.1/advanced/am-pattern-1/README.md)
- [Standard HA Deployment with Multitenancy](https://github.com/wso2/kubernetes-apim/blob/v4.0.0.1/advanced/am-pattern-2/README.md)
- [Simple Scalable Deployment](https://github.com/wso2/kubernetes-apim/blob/v4.0.0.1/advanced/am-pattern-3/README.md)

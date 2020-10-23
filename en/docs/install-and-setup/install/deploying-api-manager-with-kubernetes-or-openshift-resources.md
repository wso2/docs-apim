# Deploying API Manager with Kubernetes Resources

!!! warning
    Currently this page has instructions for deployment of WSO2 API Manager with WSO2 API Manager Analytics in Kubernetes.


Follow the instructions below to use Kubernetes (K8s) and Helm resources for container-based deployments of WSO2 API Manager (API-M).

!!! note
        -   In the context of this document, **&lt;`KUBERNETES_HOME>         `** refers to a local copy of the [`wso2/kubernetes-apim         `](https://github.com/wso2/kubernetes-apim/) Git repository that **includes Helm Resources for WSO2 API Manager.**
        -   **&lt;`HELM_HOME>`** will refer to **&lt;`<KUBERNETES_HOME>/advanced`**.

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
        
          ```java
           helm repo add wso2 https://helm.wso2.com && helm repo update
          ```

1.  Checkout the Helm Resources for WSO2 API Manager Git repository using `git clone` :

    ``` java
        git clone https://github.com/wso2/kubernetes-apim.git
        git checkout tags/v3.2.0.2
    ```

2.  Provide the necessary configurations.

    !!! note
        The default product configurations for deployment of WSO2 API Manager with WSO2 API Manager Analytics are available [here](https://github.com/wso2/kubernetes-apim/tree/v3.2.0.2/advanced/am-pattern-1/templates) folder. Change the configurations, as necessary.

    Open the `<HELM_HOME>/am-pattern-1/values.yaml` and provide the following values for WSO2 Subscription Configurations.
    
     
    | Parameter                                                                   | Description                                                                               | Default Value               |
    |-----------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|-----------------------------|
    | `wso2.subscription.username`                                                | Your WSO2 Subscription username                                                           | ""                          |
    | `wso2.subscription.password`                                                | Your WSO2 Subscription password                                                           | ""                          |
    
    !!! note
        If you do not have an active WSO2 subscription, do not change the parameters `wso2.subscription.username` and `wso2.subscription.password`. 


3.   Deploy WSO2 API Manager with WSO2 API Manager Analytics.

    ``` java
    helm install --dependency-update --name <RELEASE_NAME> <HELM_HOME>/am-pattern-1 --namespace <NAMESPACE>
    ```

4.  Access Management Console.

    1.  Obtain the external IP (`EXTERNAL-IP`) of the Ingress resources by listing down the Kubernetes Ingresses.
    
        ``` java
        kubectl get ing -n <NAMESPACE>
        ```
        Example:
        ``` java
        NAME                                               HOSTS                                ADDRESS          PORTS      AGE
        wso2am-pattern-1-am-gateway-ingress               <RELEASE_NAME>-gateway                <EXTERNAL-IP>    80, 443    7m
        wso2am-pattern-1-am-ingress                       <RELEASE_NAME>-am                     <EXTERNAL-IP>    80, 443    7m
        wso2am-pattern-1-am-analytics-dashboard-ingress   <RELEASE_NAME>-analytics-dashboard    <EXTERNAL-IP>    80, 443    7m
        ```

    2.  Add the above hosts as entries in `/etc/hosts` file as follows:
    
          ```java
          <EXTERNAL-IP>	<RELEASE_NAME>-am
          <EXTERNAL-IP>	<RELEASE_NAME>-gateway
          <EXTERNAL-IP>	<RELEASE_NAME>-analytics-dashboard
          ```

    3.  Try navigating to `https://<RELEASE_NAME>-am/carbon`, `https://<RELEASE_NAME>-am/publisher` and `https://<RELEASE_NAME>-am/devportal` from your favorite browser.
    
!!! note
    You can read the [README guide](https://github.com/wso2/kubernetes-apim/blob/v3.1.0.1/advanced/am-pattern-1/README.md) of WSO2 API Manager Git repository for further details on other dependencies and configurations. 

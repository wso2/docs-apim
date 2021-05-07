# Deploying Micro Integrator on Kubernetes using Helm Resources

Follow the instructions below to use Kubernetes (K8s) and Helm resources for container-based deployments of WSO2 API Manager (API-M).

!!! note
        -   In the context of this document, **&lt;`KUBERNETES_HOME>         `** refers to a local copy of the [`wso2/kubernetes-mi         `](https://github.com/wso2/kubernetes-mi/) Git repository that **includes Helm Resources for WSO2 Micro Integrator.**
        -   **&lt;`HELM_HOME>`** will refer to **&lt;`<KUBERNETES_HOME>/helm/micro-integrator`**.

!!! Prerequisites
    
    - In order to use WSO2 Helm resources, you need an active [WSO2 Subscription](https://wso2.com/subscription).
      If you do not possess an active WSO2 Subscription already, you can sign up for a WSO2 Free Trial Subscription from [here](https://wso2.com/free-trial-subscription).
      Otherwise you can proceed with Docker images, which are created using GA releases.<br><br>
    
    - Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Helm](https://helm.sh/docs/intro/install/), [Dep](https://golang.github.io/dep/docs/installation.html)
      and [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/) in order to run the steps
      provided in the following quick start guide.<br><br>
    
    - An already setup [Kubernetes cluster](https://kubernetes.io/docs/setup/#learning-environment).<br><br>
    
    - Install [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/). Please note that Helm resources for WSO2 product
      deployment patterns are compatible with NGINX Ingress Controller Git release [`nginx-0.30.0`](https://github.com/kubernetes/ingress-nginx/releases/tag/nginx-0.30.0).

1.  Checkout the Helm Resources for WSO2 Micro Integrator Git repository using `git clone` :

    ``` java
        git clone https://github.com/wso2/kubernetes-mi.git
        git checkout tags/v4.0.0.1
    ```

2.  Provide the necessary configurations.

    !!! note
        The default product configurations for deployment of WSO2 Micro Integrator are available [here](https://github.com/wso2/kubernetes-mi/tree/v4.0.0.1/helm/micro-integrator) folder. Change the configurations, as necessary.

    Open the `<HELM_HOME>/helm/micro-integrator/values.yaml` and provide the following values for WSO2 Subscription Configurations.
    
     
    | Parameter                                                                   | Description                                                                               | Default Value               |
    |-----------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|-----------------------------|
    | `wso2.subscription.username`                                                | Your WSO2 Subscription username                                                           | ""                          |
    | `wso2.subscription.password`                                                | Your WSO2 Subscription password                                                           | ""                          |
    
    !!! note
        If you do not have an active WSO2 subscription, do not change the parameters `wso2.subscription.username` and `wso2.subscription.password`. 


3.   Deploy WSO2 Micro Integrator.

- **Helm v2**

    [Option 1] Deploy using Docker images from DockerHub.
    
    ```
    helm install --name <RELEASE_NAME> wso2/micro-integrator --version 4.0.0-1 --namespace <NAMESPACE>
    ```
    
    [Option 2] Deploy WSO2 Micro Integrator  using Docker images from WSO2 Private Docker Registry.
    ```
    helm install --name <RELEASE_NAME> wso2/micro-integrator --version 4.0.0-1 --namespace <NAMESPACE> --set wso2.subscription.username=<SUBSCRIPTION_USERNAME> --set wso2.subscription.password=<SUBSCRIPTION_PASSWORD>
    ```

- **Helm v3**

    [Option 1] Deploy using Docker images from DockerHub.
    
    ```
    helm install <RELEASE_NAME> wso2/micro-integrator --version 4.0.0-1 --namespace <NAMESPACE> --create-namespace
    ```
    
    [Option 2] Deploy WSO2 Micro Integrator  using Docker images from WSO2 Private Docker Registry.
    ```
    helm install <RELEASE_NAME> wso2/micro-integrator --version 4.0.0-1 --namespace <NAMESPACE> --set wso2.subscription.username=<SUBSCRIPTION_USERNAME> --set wso2.subscription.password=<SUBSCRIPTION_PASSWORD> --create-namespace
    ```
    
    !!! note
    `NAMESPACE` should be the Kubernetes Namespace in which the resources are deployed.

4.  Access Micro Integrator.

    1.  Obtain the external IP (`EXTERNAL-IP`) of the Ingress resources by listing down the Kubernetes Ingresses.
    
        ``` java
        kubectl get ing -n <NAMESPACE>
        ```
        Example:
        ```
        NAME                                                 HOSTS                      ADDRESS        PORTS     AGE
        <RELEASE_NAME>-micro-integrator-service-ingress      mi.wso2.com                <EXTERNAL-IP>  80, 443   3m
        <RELEASE_NAME>-micro-integrator-management-ingress   management.mi.wso2.com     <EXTERNAL-IP>  80, 443   3m
        ```

    2.  Add the above hosts as entries in `/etc/hosts` file as follows:
    
          ```java
          <EXTERNAL-IP>	mi.wso2.com 
          <EXTERNAL-IP>	management.mi.wso2.com 
          ```

    3.  Try invoke health check service using the following command.
        
        ```java
         curl https://mi.wso2.com/healthz -k
        ```
    
!!! note
    You can read the [README guide](https://github.com/wso2/kubernetes-mi/blob/v4.0.0.1/helm/micro-integrator/README.md) of WSO2 Micro Integrator Git repository for further details on other configurations. 

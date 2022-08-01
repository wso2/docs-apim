# Deploying Choreo Connect as a Standalone Gateway on Kubernetes - Helm Artifacts

Let's deploy an API using WSO2 API Controller (apictl) on Choreo Connect, which is running on Kubernetes as a Standalone Gateway. You can select one of the options to install Choreo Connect with Helm Chart.

- [Option 1: Install Chart from WSO2 Helm Chart Repository](#option-1-install-chart-from-wso2-helm-chart-repository)
- [Option 2: Install Chart from Source](#option-2-install-chart-from-source)

!!! info "Before you begin"

    **WSO2 product Docker images**

    WSO2 product Docker images used for this Kubernetes deployment are available at [DockerHub](https://hub.docker.com/u/wso2/). It is important to note that they are General Availability (GA) versions and therefore do not include [WSO2 Updates](https://wso2.com/updates).

    For a production grade deployment of the desired WSO2 product-version, it is highly recommended to use the relevant Docker image which includes WSO2 Updates, available at [WSO2 Private Docker Registry](https://docker.wso2.com/). In order to use these images, you need an active [WSO2 Subscription](https://wso2.com/subscription).

    **Pre-Requisites**
    
    -   Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Helm](https://helm.sh/docs/intro/install/), and [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
        
    -   Set up a [Kubernetes cluster](https://kubernetes.io/docs/setup/#learning-environment).
        - Minimum CPU : 4vCPU
        - Minimum Memory : 4GB
        
    -   Install [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/).    
        Note: Helm resources for WSO2 product deployment patterns are compatible with the [`nginx-0.30.0`](https://github.com/kubernetes/ingress-nginx/releases/tag/nginx-0.30.0) release.

    
{!includes/deploy/k8s-setup-note.md!}
    

## Option 1: Install Chart from WSO2 Helm Chart Repository

### Step 1 - Add the WSO2 Helm chart repository

Add the WSO2 Helm chart repository by executing the following command.

```bash
helm repo add wso2 https://helm.wso2.com && helm repo update
```

### Step 2 - Install Chart

Execute the following command to install the Helm Cart by selecting the helm version you installed.

-   Using **Helm v2**

    ```bash tab='Format'
    helm install --name <RELEASE_NAME> wso2/choreo-connect --version {{choreo_connect.helm_chart.version}} --namespace <NAMESPACE>
    ```

    ```bash tab='Sample'
    helm install --name my-release wso2/choreo-connect --version {{choreo_connect.helm_chart.version}} --namespace cc
    ```

-   Using **Helm v3**

    ``` tab='Format'
    helm install <RELEASE_NAME> wso2/choreo-connect --version {{choreo_connect.helm_chart.version}} --namespace <NAMESPACE> --create-namespace
    ```

    ``` tab='Sample'
    helm install my-release wso2/choreo-connect --version {{choreo_connect.helm_chart.version}} --namespace cc --create-namespace
    ```

The above steps will deploy Choreo Connect using WSO2 product Docker images available at DockerHub.

If you are using Docker images available at WSO2 Private Docker Registry, please provide your **WSO2 Subscription** credentials via input values (using `--set` argument).

Please see the following example.

-   Using **Helm v2**

    ```bash tab='Format'
    helm install --name <RELEASE_NAME> wso2/choreo-connect --version {{choreo_connect.helm_chart.version}} --namespace <NAMESPACE> \
        --set wso2.subscription.username=<SUBSCRIPTION_USERNAME> \
        --set wso2.subscription.password=<SUBSCRIPTION_PASSWORD>
    ```

-   Using **Helm v3**

    ```bash tab='Format'
    helm install <RELEASE_NAME> wso2/choreo-connect --version {{choreo_connect.helm_chart.version}} --namespace <NAMESPACE> --create-namespace \
        --set wso2.subscription.username=<SUBSCRIPTION_USERNAME> \
        --set wso2.subscription.password=<SUBSCRIPTION_PASSWORD>
    ```

<br/>
Skip the following section "Option 2: Install Chart from Source" since you have already installed Choreo Connect and jump to [Access the Choreo Connect deployment](#access-the-choreo-connect-deployment) for deploying APIs.

## Option 2: Install Chart from Source

### Step 1 - Get the Helm resources

Check out the Helm Resources for the Choreo Connect Git repository.

1.  Open a terminal and navigate to the location where you want to save the local copy.
2.  Clone the Choreo Connect Git repository with Helm resources:

    ```bash
    git clone https://github.com/wso2/kubernetes-microgateway.git
    git checkout tags/{{choreo_connect.helm_chart.git_tag}}
    ```

This creates a local copy of [wso2/kubernetes-microgateway](https://github.com/wso2/kubernetes-microgateway), which includes all the Helm Resources for Choreo Connect.

Let's refer to the root folder of the local copy as `<KUBERNETES_HOME>`.

### Step 2 - Update the deployment configurations

Follow the steps given below to configure how your Choreo Connect deployment should be set up.

1.  Open the `values.yaml` file in the `<KUBERNETES_HOME>/helm/choreo-connect` directory of your local copy.

    !!! Info
        Before you do any changes, go through the [default configurations](https://github.com/wso2/kubernetes-microgateway/tree/{{choreo_connect.helm_chart.git_tag}}/helm/choreo-connect) in this file.

2.  Use the following guidelines to update the deployment configurations:

    -   **Updating the WSO2 subscription details**

        You can update the username and password in the following section. If you don't have an active WSO2 subscription, leave these parameters empty.

        ```yaml
        wso2:
            subscription:
                username: "<username>"
                password: "<password>"
        ```

        Alternatively, you can skip this step and pass your subscription details at the time of deploying (see the next step for details).

    -   You can update [other configurations](https://github.com/wso2/kubernetes-microgateway/tree/{{choreo_connect.helm_chart.git_tag}}/helm/choreo-connect/README.md) as required.

3.  Save the `values.yaml` file.

### Step 3 - Deploy Choreo Connect

Once you have set up your Helm resources locally, follow the instructions given below to set up the deployment.

1.  Open a terminal and navigate to the `<KUBERNETES_HOME>` directory.
2.  Execute the command that is relevant to your Helm version.

    !!! Tip
        Be sure to replace `NAMESPACE` with the Kubernetes namespace in which your resources are deployed.

    -   Using **Helm v2**

        ```bash
        helm install --name <RELEASE_NAME> ./helm/choreo-connect --namespace <NAMESPACE>
        ```

    -   Using **Helm v3**

        ```bash
        helm install <RELEASE_NAME> ./helm/choreo-connect --namespace <NAMESPACE> --create-namespace
        ```

#### Update configurations during deployment

If required, you can set any of the deployment configurations at the time of running the deployment (instead of
specifying them in the `values.yaml` file). See the examples given below.

-   Setting the subscription username and password.

    ```bash
    --set wso2.subscription.username=<SUBSCRIPTION_USERNAME>
    --set wso2.subscription.username=<SUBSCRIPTION_USERNAME>
    ```

## Access the Choreo Connect deployment

Follow the steps given below.

1.  Get the external IP (`EXTERNAL-IP`) of the Ingress resources by listing down the Kubernetes Ingresses.

    ```bash tab='Format'
    kubectl get ing -n <NAMESPACE>
    ```

    ```bash tab='Sample'
    kubectl get ing -n cc
    ```

    Output:

    ```bash tab='Format'
    NAME                                    CLASS    HOSTS              ADDRESS          PORTS     AGE
    <RELEASE_NAME>-choreo-connect-adapter   <none>   adapter.wso2.com   <EXTERNAL-IP>    80, 443   49s
    <RELEASE_NAME>-choreo-connect-router    <none>   gw.wso2.com        <EXTERNAL-IP>    80, 443   49s
    ```

    ```bash tab='Sample'
    NAME                                    CLASS    HOSTS              ADDRESS          PORTS     AGE
    my-release-choreo-connect-adapter       <none>   adapter.wso2.com   127.0.0.1        80, 443   49s
    my-release-choreo-connect-router        <none>   gw.wso2.com        127.0.0.1        80, 443   49s
    ```

2.  Add the above hosts in the `/etc/hosts` file as follows:

    ```bash
    <EXTERNAL-IP>   adapter.wso2.com
    <EXTERNAL-IP>   gw.wso2.com
    ```

## Deploy and Invoke Sample API

Follow the Steps 2, 3, 4 in [Deploying Choreo Connect as a Standalone Gateway on Kubernetes](https://apim.docs.wso2.com/en/latest/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-kubernetes/#step-2-initialize-an-api-project)
to deploy and invoke the sample API.

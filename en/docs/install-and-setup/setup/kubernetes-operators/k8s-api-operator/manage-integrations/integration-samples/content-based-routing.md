# K8s Deployment Sample 2: Content Based Routing

Let's define a content-based routing scenario using WSO2 Micro Integrator and deploy it on your Kubernetes environment.

## Prerequisites

-   Install and set up [WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
-   Install a [Kubernetes](https://kubernetes.io/docs/setup/) cluster and **v1.11+** client. Alternatively, you can [run Kubernetes locally via Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).
-   Install [Docker](https://docs.docker.com/).
-   Install the [Kubernetes API Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install).

## Step 1 - Create the integration solution

Let's use the <b>Content Routing</b> integration template in WSO2 Integration Studio:

1.  Open WSO2 Integration Studio.
2.  In the <b>Getting Started</b> view, select the <b>Content Based Routing</b> template.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/content-routing-template.png">

3.  Give a project name and click <b>Finish</b>.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/content-routing-sample-project.png" width="400" alt="k8s project structure">

5.  Create a **Kubernetes Project** inside the integration project. 

    1.  Right-click the <b>content-routing-sample</b> project, go to **New -> Kubernetes Exporter**:

        <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/k8s-proj.png" width="500" alt="Create Kubernetes Project">

    2.  In the **Kubernetes Exporter Information for K8s EI Operator** dialog box that opens, enter the following details:

        <table>
            <tr>
                <th>
                    Parameter
                </th>
                <th>
                    Description
                </th>
            </tr>
            <tr>
                <td>
                    Kubernetes Exporter Name
                </td>
                <td>
                   Give a unique name for the project. 
                </td>
            </tr>
            <tr>
                <td>
                    Integration Name
                </td>
                <td>
                    This name will be used to identify the integration solution in the kubernetes custom resource. Let's use <code>content-routing</code> as the integration name for this example.
                </td>
            </tr>
            <tr>
                <td>
                    Number of Replicas
                </td>
                <td>
                    Specify the number of pods that should be created in the kubernetes cluster.
                </td>
            </tr>
            <tr>
                <td>
                    Base Image Repository
                </td>
                <td>
                    Specify the base Micro Integrator Docker image for your solution. For this example, let's use the Micro Integrator docker image from the WSO2 public docker registry: <b>wso2/wso2mi</b>.</br></br>
                    Note that the image value format should be 'docker_user_name/repository_name'.
                </td>
            </tr>
            <tr>
                <td>
                    Base Image Tag
                </td>
                <td>
                    Give a tag name for the base Docker image.
                </td>
            </tr>
            <tr>
                <td>
                    Target Image Repository
                </td>
                <td>
                    The Docker repository to which the Docker image will be pushed: 'docker_user_name/repository_name'.
                </td>
            </tr>
            <tr>
                <td>
                    Target Image Tag
                </td>
                <td>
                    Give a tag name for the Docker image.
                </td>
            </tr>
        </table> 

    3.  Click <b>Finish</b>.

Your integration project with the <b>content routing</b> sample is now ready to be deployed in Kubernetes.

<img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/k8s-content-routing-sample-project.png" width="400" alt="k8s project structure">

## Step 2 - Build and Push the Docker image 

!!! Note
    Be sure to start your Docker instance before building the image. If Docker is not started, the build process will fail. 

There are two ways to build a Docker image of the integration solution and push it to your Docker registry:

-   Using <b>Maven</b>:

    !!! Note "Before you begin"
            You need **Maven 3.5.2** or a later version when you build the Docker image manually (without using WSO2 Integration Studio).

    1.  Open a terminal and navigate to the integration project.
    2.  Execute the following command. 

        Be sure to specify the user name and password of the correct Docker registry.

        ```bash
        mvn clean install -Dmaven.test.skip=true -Ddockerfile.username={username} -Ddockerfile.password={password} 
        ```

    This will build the Docker image and then push it to the specified Docker registry.

-   Using <b>WSO2 Integration Studio</b>:
      
    1.  Open the **pom.xml** file in the Kubernetes exporter.    
    2.  Ensure that the composite exporter is selected under **Dependencies** and click <b>Build & Push</b>.

        <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/select-dependency-content-routing.png">

    3.  In the dialog box that opens, enter the credentials of your Docker registry to which the image should be pushed.

        <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/docker-registry-credentials.png" width="500" alt="docker registry credentials">

    4.  Click <b>Push Image</b>.

Run the `docker image ls` command to verify that the Docker image is created.
    
## Step 3 - Deploy the solution in K8s

!!! Info
    **Before you begin**, the [API Kubernetes Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install) should be installed in your kubernetes environment.

Follow the steps given below:

1.  Open the `integration_cr.yaml` file from the Kubernetes project in WSO2 Integration Studio.
2.  See that the **integration** details of the `content-routing` solution are updated. <b>Be sure</b> to add the image name in the following format: `docker_user/repository:tag`

    ```yaml
    apiVersion: "wso2.com/v1alpha2"
    kind: "Integration"
    metadata:
      name: "content-routing"
    spec: 
      image: "<Docker image for the Content-Based Routing Scenario>"
      deploySpec:
        minReplicas: 1
    ```

3.  Open a terminal and start the Kubernetes cluster.
4.  Navigate to the location of your `integration_cr.yaml` file, and execute the following command to deploy the integration solution in the Kubernetes cluster:

    ```bash
    kubectl apply -f integration_cr.yaml
    ``` 

When the integration is successfully deployed, it should create the `content-routing` integration, `content-routing-deployment`, `content-routing-service`, and `ei-operator-ingress` as follows:

!!! Tip
    The `api-operator-ingress` is not created if you have [disabled the ingress controller]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments/#disable-ingress-controller-creation).

```bash
kubectl get integration

NAME              STATUS   SERVICE-NAME   AGE
content-routing                           40s

kubectl get deployment

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
content-routing-deployment   1/1     1            1           2m

kubectl get services
NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)       AGE
content-routing-service      ClusterIP   10.101.107.154   <none>        8290/TCP      2m
kubernetes                   ClusterIP   10.96.0.1        <none>        443/TCP       2d
k8s-api-operator             ClusterIP   10.98.78.238     <none>        443/TCP       1d

kubectl get ingress
NAME                   HOSTS                      ADDRESS     PORTS     AGE
api-operator-ingress   wso2ei.ingress.wso2.com    10.0.2.15   80, 443   2m
```

## Step 4 - Test the deployment

Let's invoke the service without going through the ingress controller.

1. Create a `request.xml` file as follows:
    ```xml
    <ArithmaticOperation>
      <Operation>Add</Operation>
      <Arg1>10</Arg1>
      <Arg2>25</Arg2>
    </ArithmaticOperation>
    ```
    or
    ```xml
    <ArithmaticOperation>
      <Operation>Divide</Operation>
      <Arg1>25</Arg1>
      <Arg2>5</Arg2>
    </ArithmaticOperation>
    ```
    
2.  Apply port forwarding as shown below. This will allow you to invoke the service without going through the Ingress controller:
    ```bash
    kubectl port-forward service/content-routing-service 8290:8290
    ```

2. Execute the following command to invoke the service:
    ```bash
    curl -X POST -d @request.xml http://localhost:8290/ArithmaticOperationService -H "Content-Type: text/xml"
    ``` 

You will receive the following SOAP response:

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:s='http://www.w3.org/2001/XMLSchema'>
  <SOAP-ENV:Body><AddIntegerResponse xmlns="http://tempuri.org"><AddIntegerResult>35</AddIntegerResult></AddIntegerResponse></SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```
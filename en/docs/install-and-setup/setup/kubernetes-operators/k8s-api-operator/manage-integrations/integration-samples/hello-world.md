# K8s Deployment Sample 1: Hello World Scenario
Let's define a basic Hello World scenario using WSO2 Micro Integrator and deploy it on your Kubernetes environment.

## Prerequisites

-   Install and set up [WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio).
-   Install a [Kubernetes](https://kubernetes.io/docs/setup/) cluster and **v1.11+** client. Alternatively, you can [run Kubernetes locally via Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).
-   Install [Docker](https://docs.docker.com/).
-   Install the [Kubernetes API Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install).

## Step 1 - Create the integration solution

Let's use an integration template in WSO2 Integration Studio to generate a sample integration solution that returns a 'Hello World' response when invoked.

1.	Open WSO2 Integration Studio.
2.	In the <b>Getting Started</b> view, select the <b>Hello kubernetes</b> template.

	<img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/k8s-hello-world-template.png" alt="getting started view">

3.	Give a project name and click <b>Finish</b>. 

This generates the complete integration project with the 'Hello World' solution, which is ready to be deployed in Kubernetes.

<img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/hello-k8s-sample-project.png" width="400" alt="k8s project structure">

## Step 2 - Build and Push the Docker image

!!! Note
	Be sure to start your Docker instance before building the image. If Docker is not started, the build process will fail. 

There are two ways to build a Docker image of the integration solution and push it to your Docker registry:

-	Using <b>Maven</b>:

	!!! Note "Before you begin"
			You need **Maven 3.5.2** or a later version when you build the Docker image manually (without using WSO2 Integration Studio).

	1.	Open a terminal and navigate to the integration project.
	2.	Execute the following command. 

		Be sure to specify the user name and password of the correct Docker registry.

	    ```bash
	    mvn clean install -Dmaven.test.skip=true -Ddockerfile.username={username} -Ddockerfile.password={password} 
		```

	This will build the Docker image and then push it to the specified Docker registry.

-	Using <b>WSO2 Integration Studio</b>:
      
	1.  Open the **pom.xml** file in the Kubernetes project as shown below.
	    
	    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/select-dependency-hello-world.png">
	
	2.	Ensure that the composite exporter is selected under **Dependencies**.
	3.  In the <b>Target Repository</b> field, enter the name of the Docker registry to which you will push a Docker image.
	4.	Click <b>Build & Push</b> to build the image and push to the Docker registry.
	5.	In the dialog box that opens, enter the credentials of your Docker registry to which the image should be pushed.

	    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/docker-registry-credentials.png" width="500" alt="docker registry credentials">

	6.	Click <b>Push Image</b>.

Run the `docker image ls` command to verify that the Docker image is created.
    
## Step 3 - Deploy the solution in K8s

!!! Info
    **Before you begin**, the [API Kubernetes Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install) should be installed in your kubernetes environment.

Follow the steps given below.

1.  Open the `integration_cr.yaml` file from the Kubernetes exporter in WSO2 Integration Studio.
2.  See that the **integration** details of the `hello-world` solution are updated. <b>Be sure</b> to add the image name in the following format: `docker_user/repository:tag`

    ```yaml
    apiVersion: "wso2.com/v1alpha2"
    kind: "Integration"
    metadata:
      name: "hello-world"
    spec:
      image: "<Docker image for the Hello World Scenario>"
      deploySpec:
        minReplicas: 1
    ```

3.  Open a terminal and start the Kubernetes cluster.
4.  Navigate to the location of your `integration_cr.yaml` file and execute the following command to deploy the integration solution in the Kubernetes cluster:

    ```bash
    kubectl apply -f integration_cr.yaml
    ``` 

When the integration is successfully deployed, it should create the `hello-world` integration, `hello-world-deployment`, `hello-world-service`, and `ei-operator-ingress` as follows:

!!! Tip
    The `ei-operator-ingress` is not created if you have [disabled the ingress controller]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments/#disable-ingress-controller-creation).

```bash
kubectl get integration

NAME          STATUS    SERVICE-NAME    AGE
hello-world   Running   hello-service   2m

kubectl get deployment

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
hello-world-deployment   1/1     1            1           2m

kubectl get services
NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)       AGE
hello-world-service      ClusterIP   10.101.107.154   <none>        8290/TCP      2m
kubernetes               ClusterIP   10.96.0.1        <none>        443/TCP       2d
k8s-api-operator         ClusterIP   10.98.78.238     <none>        443/TCP       1d

kubectl get ingress
NAME                  HOSTS                      ADDRESS     PORTS     AGE
api-operator-ingress  wso2ei.ingress.wso2.com    10.0.2.15   80, 443   2m
```

## Step 4 - Test the deployment

Let's invoke the service without going through the ingress controller.

1.  Apply port forwarding as shown below. This will allow you to invoke the service without going through the Ingress controller:
    ```bash
    kubectl port-forward service/hello-world-service 8290:8290
    ```

2.  Invoke the service as follows:
    ```bash
    curl http://localhost:8290/HelloWorld
    ```  

You will receive the following response:

```bash
{"Hello":"World"}%
```
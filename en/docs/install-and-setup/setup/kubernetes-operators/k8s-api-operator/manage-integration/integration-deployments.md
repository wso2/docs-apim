# Manage Integrations

The Kubernetes API operator (**k8s-api-operator**) provides first-class support for Micro Integrator deployments in the Kubernetes ecosystem. It uses the **Integration custom resource** (`integration_cr.yaml` file) that is available in the Kubernetes exporter module (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

The operator is configured with an NGINX Ingress controller by default, which exposes the deployed integration through HTTP/HTTPS protocols. If required, you can use the operator's configuration mapper (`integration_controller_conf.yaml` file) to update ingress controller configurations. Also, you can use the same file to disable ingress controller creation when applying the operator if you plan to use a custom ingress controller.
                                                                                                                                                                                                                                                    


##  Prerequisites (system requirements)

Listed below are the system requirements for deploying integration solutions in Kubernetes using the K8s API Operator.

!!! Info
    The K8s API Operator (k8s-api-operator) is built with **operator-sdk v0.16.0** and supported in the below environments.

- [Kubernetes](https://kubernetes.io/docs/setup/) cluster and **v1.14+** client. 
- [Docker](https://docs.docker.com/)
- Install K8s API Operator using OperatorHub.io. For information, see the installation instructions in the [OperatorHub.io](https://operatorhub.io/operator/api-operator)

## Deploy integration solutions in K8s

!!! Tip
    To try the end-to-end process of deploying integration solutions on Kubernetes, see the integration examples: 

    - [Hello World example](../integration-samples/hello-world)
    - [Message Routing example](../integration-samples/content-based-routing)
    - [JMS Sender/Receiver exampe](../integration-samples/jms-sender-receiver)

Given below are the main steps your will follow when you deploy integration solutions in a Kubernetes cluster.

1.  Be sure that the [system requirements](#prerequisites-system-requirements) are fulfilled, and that the [K8s API operator](https://operatorhub.io/operator/api-operator) is installed in your Kubernetes environment.
2.  Your integration solution should be prepared using **WSO2 Integration Studio** as follows:

    1. Create the integration solution.
    2. Generate a Kubernetes project for the solution.
    3. Build the Docker image of your integration and push it to your Docker registry.

3.  Open the `integration_cr.yaml` file from the Kubernetes project in WSO2 Integration Studio.
4.  See that the details of your **integration** are correctly included in the file. See the example given below.

    ```yaml
    apiVersion: "wso2.com/v1alpha2"
    kind: "Integration"
    metadata:
      name: "sample-integration"
    spec:
      image: "<Docker image for the Hello World Scenario>" 
      deploySpec:
        minReplicas: 1
        requestCPU: "500m"
        reqMemory: "512Mi"
        cpuLimit: "2000m"
        memoryLimit: "2048Mi"
      autoScale:
        enabled: "true"
        maxReplicas: 3
      expose:
        passthroPort: 8290
        inboundPorts:
          - 8000
          - 9000
          .....  
      env:
        - name: DEV_ENV_USER_EP
          value: "https://reqres.in/api"
        - name: SECRET_USERNAME
          valueFrom:
            secretKeyRef:
              name: backend-user
              key: backend-username
        - name: CONFIGMAP_USERNAME
          valueFrom:
            configMapRef:
              name: backend-map
              key: backend-username
      envFrom:
        - configMapRef:
            name: CONFIG_MAP_NAME
        - secretKeyRef:
            name: SECRET_NAME   
    ```

    <table>
      <tr>
        <th>
          <b>Property</b>
        </th>
        <th>
          <b>Description</b>
        </th>
      </tr>
      <tr>
        <td>
          kind
        </td>
        <td>
            The <b>Integration</b> kind represents the integration solution that will be deployed in the Kubernetes environment.
        </td>
      </tr>
      <tr>
        <td>
          metadata name
        </td>
        <td>
            The name of the integration solution.
        </td>
      </tr>
      <tr>
          <td>
            minReplicas
          </td>
          <td>
              The minimim number of pods that should be created in the Kubernetes cluster. If not defined, the operator will get pick up what is defined at integration_controller_conf.yaml file as the default.
          </td>
      </tr>
      <tr>
        <td>
          image
        </td>
        <td>
          Specify the Docker image of your integration solution. If you are using a Docker image from a private registry, you need to push the deployment as a Kuberntes secret. Follow the instructions in <a href="#use-docker-images-from-private-registries">using a private registry image</a>.
        </td>
      </tr>
      <tr>
        <td>
          cpuLimit
        </td>
        <td>
          Describes the maximum amount of compute resources allowed.
        </td>
      </tr>
      <tr>
        <td>
          requestCPU
        </td>
        <td>
          Describes the minimum amount of compute resources required.
        </td>
      </tr>
      <tr>
        <td>
          memoryLimit
        </td>
        <td>
          Describes the maximum amount of memory resources allowed.
        </td>
      </tr>
      <tr>
        <td>
          reqMemory
        </td>
        <td>
          Describes the minimum amount of memory resources required.
        </td>
      </tr>
      <tr>
        <td>
          autoScale.enabled
        </td>
        <td>
          Enable auto scale with hpa.
        </td>
      </tr>
      <tr>
        <td>
          maxReplicas
        </td>
        <td>
          The maximum number of pods that should be created in the Kubernetes cluster. If not defined, the operator will get pick up what is defined at integration_controller_conf.yaml file as the default.
        </td>
      </tr>
      <tr>
        <td>
          passthroPort
        </td>
        <td>
          Passthro port of the runtime server to be exposed.
        </td>
      </tr>
      <tr>
        <td>
          inboundPorts
        </td>
        <td>
          Inbound endpoint ports of the runtime server to be exposed.
        </td>
      </tr>
      <tr>
        <td>
          env
        </td>
        <td>
          Key-value pairs or value from references as environment variables.
        </td>
      </tr>
      <tr>
        <td>
          envFrom
        </td>
        <td>
          Environment variables from ConfigMap or Secret references.
        </td>
      </tr>
    </table>

5.  Open a terminal, navigate to the location of your `integration_cr.yaml` file, and execute the following command to deploy the integration solution into the Kubernetes cluster:
    ```bash
    kubectl apply -f integration_cr.yaml
    ``` 

When the integration is successfully deployed, it should create the `hello-world` integration, `hello-world-deployment`, `hello-world-service`, and `ei-operator-ingress` as follows:

!!! Tip
    The `ei-operator-ingress` will not be created if you have [disabled the ingress controller](#disable-ingress-controller).

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

## Use Docker images from private registries

The API operator allows the use of any custom Docker image in a private registry as an integration solution. To achieve this, users have to pass the credentials to pull the image to the Kubernetes containers as a Kubernetes secret. The API operator uses `imagePullSecret` to read the Kubernetes secret of the registry credentials. 

1.  You can use the following command to create a Kubernetes secret with the credentials of the private Docker image:

    ```bash
    kubectl create secret docker-registry <secret-alias> --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-password> --docker-email=<your-email>
    ```

    <table>
        <tr>
            <td>
                <b>Parameter</b>
            </td>
            <td>
                <b>Description</b>
            </td>
        </tr>
        <tr>
            <td>
               <code>secret-alias</code>
            </td>
            <td>
                The name of the secret.
            </td>
        </tr>
        <tr>
            <td>
                <code>your-registry-server</code>
            </td>
            <td>
                The <a href="https://index.docker.io/v1/">private Docker registry FQDN</a> for DockerHub.
            </td>
        </tr>
        <tr>
            <td>
                <code>your-name</code>
            </td>
            <td>
                Your Docker user name.
            </td>
        </tr>
        <tr>
            <td>
                <code>your-password</code>
            </td>
            <td>
                Your Docker password.
            </td>
        </tr>
        <tr>
            <td>
                <code>your-email</code>
            </td>
            <td>
                You Docker email.
            </td>
        </tr>
    </table>

2.  Add the `imagePullSecret` property to the `integration_cr.yaml` custom resource file as follows:

    ```yaml
    apiVersion: "wso2.com/v1alpha2"
    kind: "Integration"
    metadata:
      name: "hello-world"
    spec:    
      image: "<Docker image for the Hello World Scenario>"
      imagePullSecret: <secret-alias>
      deploySpec:
        minReplicas: 1
    ```

3.  You can now deploy the integration: Open a terminal and execute the following command from the location of your `integration_cr.yaml` file.

    ```bash
    kubectl apply -f integration_cr.yaml
    ``` 

## View integration process logs

Once you have [deployed your integrations](#deploy-integration-solutions-in-k8s) in the Kubernetes cluster, see the output of the running integration solutions using the pod's logs. 

1. First, you need to get the associated **pod id**. Use the `kubectl get pods` command to list down all the deployed pods.

    ```bash
    kubectl get pods

    NAME                               READY   STATUS    RESTARTS   AGE
    hello-deployment-c68cbd55d-j4vcr   1/1     Running   0          3m
    k8s-api-operator-6698d8f69d-6rfb6   1/1     Running   0          2d
    ```

2.  To view the logs of the associated pod, run the `kubectl logs <pod name>` command. This will print the output of the given pod ID.

    ```bash
    kubectl logs hello-deployment-c68cbd55d-j4vcr

    ...
    [2019-10-28 05:29:24,225]  INFO {org.wso2.micro.integrator.initializer.deployment.application.deployer.CAppDeploymentManager} - Successfully Deployed Carbon Application : HelloWorldCompositeApplication_1.0.0{super-tenant}
    [2019-10-28 05:29:24,242]  INFO {org.apache.synapse.transport.passthru.core.PassThroughListeningIOReactorManager} - Pass-through HTTP Listener started on 0.0.0.0:8290
    [2019-10-28 05:29:24,242]  INFO {org.apache.axis2.transport.mail.MailTransportListener} - MAILTO listener started
    [2019-10-28 05:29:24,250]  INFO {org.apache.synapse.transport.passthru.core.PassThroughListeningIOReactorManager} - Pass-through HTTPS Listener started on 0.0.0.0:8253
    [2019-10-28 05:29:24,251]  INFO {org.wso2.micro.integrator.initializer.StartupFinalizer} - WSO2 Micro Integrator started in 4 seconds
    ```

## Invoke the integration solution 

You can invoke the integration solution you deployed in Kubernetes using two methods.

### Invoke using Ingress controller

Once you have [deployed your integrations](#deploy-integration-solutions-in-k8s) in the Kubernetes cluster, you can use the default Ingress controller in the deployment to invoke the solution:

1.  Obtain the **External IP** of the ingress load balancer using the `kubectl get ingress` command as follows:

    ```bash
    kubectl get ingress
    NAME                   HOSTS                      ADDRESS     PORTS     AGE
    api-operator-ingress   wso2ei.ingress.wso2.com    10.0.2.15   80, 443   2m
    ```
    For **Minikube**, you have to use the Minikube IP as the external IP. Hence, run `minikube ip` command to get the IP of the Minikube cluster.

2.  Add the **HOST** (`wso2ei.ingress.wso2.com`) and related **ADDRESS** (external IP) to the `/etc/hosts` file in your machine.

    !!! Tip
        Note that the HOST of the Ingress controller is configured in the [integration_controller_conf.yaml](https://github.com/wso2/k8s-api-operator/blob/master/api-operator/deploy/controller-configs/integration_controller_conf.yaml) file. The default host is `wso2ei.ingress.wso2.com`.

3.  Execute the following CURL command to run the `hello-world` service in Kubernetes:

    ```bash
    curl http://wso2ei.ingress.wso2.com/hello-world-service/services/HelloWorld
    ```

    You will receive the following response:

    ```bash
    {"Hello":"World"}%
    ```

### Invoke without Ingress controller

Once you have [deployed your integrations](#deploy-integration-solutions-in-k8s) in the Kubernetes cluster, you can also invoke the integration solutions without going through the Ingress controller by using the [port-forward](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/#forward-a-local-port-to-a-port-on-the-pod) method for services. 

Follow the steps given below:

1. Apply port forwarding:

    ```bash
    kubectl port-forward service/hello-world-service 8290:8290
    ```

2. Invoke the proxy service:

    ```bash
    curl http://localhost:8290/services/HelloWorld
    ```

    You will receive the following response:

    ```bash
    {"Hello":"World"}%
    ```

## Update existing integration deployments

The K8s API operator allows you to update the Docker images used in Kubernetes pods(replicas) with the latest update of the tag. To pull the latest tag, we need to delete the associated pod with its pod ID as follows:

```bash 
kubectl delete pod <POD-NAME>
```

When you run the above command, Kubernetes will spawn another temporary pod, which has the same behaviour of the pod we have deleted. Then the deleted pod will restart by pulling the latest tag from the Docker image path. 

!!! Note 
    Here we are recommending to use a different image path for the updated integration solution. Otherwise, (because the Docker image is re-pulled from the existing deployment) some traffic from outside might get lost. 


## Run inbound endpoints

[Inbound Endpoints](../../../references/synapse-properties/inbound-endpoints/about-inbound-endpoints/) in the Micro Integrator are used for separating endpoint listeners. That is, for each HTTP inbound endpoint, messages are handled separately. Also, we can create any number of inbound endpoints on any port. 

Therefore, we can expose the inbound endpoint ports from the Kubernetes cluster by passing the `inboundPorts` property inside our `integration_cr.yaml` custom resource file as follows:

```yaml
apiVersion: "integration.wso2.com/v1alpha2"
kind: "Integration"
metadata:
  name: "inbound-samples"
spec:
  image: "<Docker image for the inbound endpoint Scenario>"
  deploySpec:
    minReplicas: 1
  expose:
    passthroPort: 8290
    inboundPorts:
      - 8000
      - 9000
      ...
```

Use the following methods to invoke the inbound endpoints in HTTP and HTTPS transports. Note that `<INTEGRATION-NAME>` is the value we have used as the metadata name in the `integration_cr.yaml` file. 

-   HTTP request

    ```bash
    curl http://<HOST-NAME>/<INTEGRATION-NAME>-inbound/<PORT>/<CONTEXT>
    ```

-   HTTPS request

    ```bash
    curl --cacert <CERT_FILE> https://<HOST-NAME>/<INTEGRATION-NAME>-inbound/<PORT>/<CONTEXT>
    ```    
# EI Kubernetes (K8s) Operator

The EI Kubernetes operator (**k8s-ei-operator**) provides first-class support for Micro Integrator deployments in the Kubernetes ecosystem. It uses the **Integration custom resource** (`integration_cr.yaml` file) that is available in the Kubernetes project (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

The operator is configured with an NGINX Ingress controller by default, which exposes the deployed integration through HTTP. If required, you can use the operator's configuration mapper (`config_map.yaml` file) to disable the default Ingress controller and apply other configuration changes. Find out more about [changing the default configurations](#configure-the-ei-k8s-operator-optional) of the EI K8s operator.

##  Install the EI K8s Operator
Follow the steps given below to install the EI Kubernetes operator in your Kubernetes environment.

1.  Clone the latest **k8s-ei-operator** GitHub repository:

    ```bash
    git clone https://github.com/wso2/k8s-ei-operator.git
    ```
    
2.  Navigate to the `k8s-ei-operator` directory that you cloned:

    ```bash
    cd k8s-ei-operator
    ```

3.  Start your Kubernetes environment.

    !!! Tip
        If you are using Minikube as your kubernetes environment, [install and start Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).

4.  Set up the service account:

    ```bash
    kubectl create -f deploy/service_account.yaml
    ```
    
5.  Set up RBAC:

    ```bash
    kubectl create -f deploy/role.yaml
    kubectl create -f deploy/role_binding.yaml
    ```
    
6.  Deploy a **custom resource definition**, which enables a Kubernetes cluster to understand the custom resource type. The EI K8s operator introduces the **Integration** custom resource.

    ```bash
    kubectl create -f deploy/crds/integration_v1alpha1_integration_crd.yaml
    ```
    
7.  Deploy the k8s-ei-operator:

    ```bash
    kubectl create -f deploy/operator.yaml
    ```
    
8. Apply the Ingress controller configurations to the `config_map.yaml` file (configuration mapping file):

    ```bash
    kubectl apply -f deploy/config_map.yaml
    ```

9. Verify the installation by making sure that the following deployment is running in your Kubernetes cluster:

    ```bash
    kubectl get deployment

    NAME               READY   UP-TO-DATE   AVAILABLE   AGE
    k8s-ei-operator     1/1     1            1          1m
    ```

Your Kubernetes environment is now configured with the EI K8s operator. If required, you can [configure the optional settings](#configure-the-ei-k8s-operator-optional) before using the operator.

## Configure the EI K8s Operator (Optional)
See the topics given below to update/change the default configurations of the EI K8s operator.

### Disable Ingress controller

By default, the EI operator creates an NGINX ingress through which it exposes HTTP/HTTPS transport protocols. If user needs to create a deployment without the default ingress:

1.  Open the `config_map.yaml` file.
2.  Change the `autoIngressCreation` property value to `false` in the `ei-operator-config` config mapping as follows.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ei-operator-config
    data:
      host: wso2ei
      autoIngressCreation: "false" 
    ```

### Enable HTTPS for the integration solution
We can use the **ingressTLS** property in the configuration mapping of the operator to expose an ingress NGINX HTTPS transport of your integration application in Kubernetes. If a user has defined **ingressTLS** in the configuration mapping, the ingress controller uses this TLS and terminates with the given HTTP.

```yaml
ingressTLS: wso2-tls
```

Follow the steps given below.

1.  You need to generate a self-signed certificate and private key using the following command. For more details about certificate creation, see [this link](https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/tls.md#tls-secrets).
    ```bash
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout wso2.key -out wso2.crt -subj "/CN=wso2/O=wso2"
    ```

2.  Create a Kubernetes secret called `wso2-tls` by executing the following command:
    ```bash
    kubectl create secret tls wso2-tls --key wso2.key --cert wso2.crt
    ```

3.  Open the `config_map.yaml` file, and add this secret alias called `wso2-tls` to the `ei-operator-config` configuration mapping as follows:
    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ei-operator-config
    data:
      host: wso2ei
      autoIngressCreation: "false" 
      ingressTLS: wso2-tls
    ```

Now, you can invoke the deployed applications from following URL format.

```bash
https://<HOST-NAME>/<SERVICE-NAME>/<SERVICE-CONTEXT>
```

For the **Hello World** example, the request should be as follows:

```bash
curl --cacert wso2.crt https://wso2ei/hello-world-service/services/HelloWorld
```

You will receive the following response:

```bash
{"Hello":"World"}%
```

### Enable both HTTP and HTTPS

If you have [enabled HTTPS for the Ingress controller](#enable-https-for-the-integration-solution), the ingress controller redirects HTTP requests to the HTTPS port (443), by default, using a **308 Permanent Redirect response**. To allow both HTTP and HTTPS requests, we can update the configuration mapping by adding the following property:

```yaml
sslRedirect: "false"
```

1.  Open the `config_map.yaml` file.
2.  Update the `ei-operator-config` configuration mapping:

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ei-operator-config
    data:
      host: wso2ei
      autoIngressCreation: "false" 
      ingressTLS: wso2-tls
      sslRedirect: "false"
    ```
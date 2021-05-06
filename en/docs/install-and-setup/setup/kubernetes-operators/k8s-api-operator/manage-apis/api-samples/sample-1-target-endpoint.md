# Sample 1: Target Endpoint

Let's deploy a backend using Target Endpoint resource on your Kubernetes environment and apply API management.

## Prerequisites

 -  Install a [Kubernetes](https://kubernetes.io/docs/setup/) cluster and **v1.14+** client. Alternatively,
    you can [run Kubernetes locally via Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).
 -  Install [Docker](https://docs.docker.com/).
 -  Install the [Kubernetes API Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/install).
 -  Setup Choreo Connect 
    1.  Download the Choreo Connect v0.9.0 from
        [github release page's](https://github.com/wso2/product-microgateway/releases/tag/v0.9.0) assets and extract them
        to a folder of your choice. We will refer to this folder as the `CHOREO-CONNECT_HOME`.
    
    2.  Using the kubectl tool, apply Kubernetes configurations for Choreo Connect.
    
        ```bash
        kubectl apply -f <CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect
        ```

## Step 1: Deploy Sample Backend

Let's use the TargetEndpoint custom resource to deploy our sample backend
[cakebakery/products:v1](https://hub.docker.com/r/cakebakery/products) in Kubernetes.

```sh
cat <<EOF | kubectl apply -f -
apiVersion: wso2.com/v1alpha2
kind: TargetEndpoint
metadata:
  name: products
  labels:
    app: products-backend
spec:
  applicationProtocol: http
  ports:
    - name: prod-ep
      port: 80
      targetPort: 8080
  deploy:
    name: products
    dockerImage: cakebakery/products:v1
    minReplicas: 2
    maxReplicas: 3
    requestCPU: "2m"
    reqMemory: "10Mi"
    cpuLimit: "5m"
    memoryLimit: "20Mi"
  mode: privateJet
EOF
```

After sometime executing above, you can see there are two pods of the backend running in the cluster.

```sh
kubectl get pods
```
```sh
NAME                            READY   STATUS    RESTARTS   AGE
api-operator-7d86c6bd85-x6trj   1/1     Running   0          2m4s
products-77bd6f448f-j2sqn       1/1     Running   0          100s
products-77bd6f448f-vvnl5       1/1     Running   0          100s
``` 

## Step 2: Create API for the backend

Let's create a k8s Config Map with the swagger definition of the API. We have added the following extensions for the endpoint and
base path in the swagger definition.
```yaml
x-wso2-production-endpoints:
  urls:
    - http://products
  type: http
x-wso2-sandbox-endpoints:
  urls:
    - http://products
  type: http
x-wso2-basePath: /products-api/v1
```

Create configmap with swagger definition.
```sh
k create cm products-cm \
    --from-file https://raw.githubusercontent.com/wso2/k8s-api-operator/v2.0.0/scenarios/scenario-1-target-endpoint/swagger.yaml
```

Now, let's create the API custom resource.
```sh
cat <<EOF | kubectl apply -f -
apiVersion: wso2.com/v1alpha2
kind: API
metadata:
  name: products-api
spec:
  swaggerConfigMapName: products-cm
EOF
```

## Step 3: Invoke the API

Let's get a sample token.
```sh
TOKEN=$(curl -X POST "https://gw.wso2.com/testkey" \
    -H "Authorization: Basic YWRtaW46YWRtaW4=" -k -v)
```

Invoke the API with the token.
```sh
curl -X GET "https://gw.wso2.com/products-api/v1/products/3" \
    -H "accept: application/json" \
    -H "Authorization:Bearer $TOKEN" -k
```

You will see the following response.

```json
{"id":3,"name":"ABC Smart TV","category":"Electronics","price":39999}
```

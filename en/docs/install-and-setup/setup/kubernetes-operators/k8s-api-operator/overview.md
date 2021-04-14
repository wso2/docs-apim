# Kubernetes API Operator Overview

As microservices are increasingly being deployed on Kubernetes, the need to expose these microservices as well
documented, easy to consume, managed APIs is becoming important to develop great applications.
The API operator for Kubernetes makes APIs a first-class citizen in the Kubernetes ecosystem.
Similar to deploying microservices, you can now use this operator to deploy APIs for individual microservices or
compose several microservices into individual APIs. With this users will be able to expose their microservice
as managed API in Kubernetes environment without any additional work.

The API operator for Kubernetes provides first-class support for Micro Integrator deployments in the Kubernetes
ecosystem. It uses the Integration custom resource (integration_cr.yaml file) that is available in the Kubernetes
project (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

[![With and without K8s API Operator]({{base_path}}/assets/img/learn/kubernetes-operators/with-and-withou-k8s-api-operator.png)]({{base_path}}/assets/img/learn/kubernetes-operators/with-and-withou-k8s-api-operator.png)


## How API Operator Works

Using kubectl command line tool, users are able to manage APIs and Integration custom resources in 
Kubernetes environments as follows.

[![How API Operator Works]({{base_path}}/assets/img/learn/kubernetes-operators/how-api-operator-works.png)]({{base_path}}/assets/img/learn/kubernetes-operators/how-api-operator-works.png)

### Manage APIs

- Deploy an API project or OpenAPI definition in a config map in Kubernetes
- Deploy api.yaml file which is the API custom resource definition (CRD) for the API.
- In the API, you should refer the config map which has the API project or OpenAPI definition.
- The API Operator takes the control for the API CRD.
- The API controller in the API Operator creates the relevant artifacts for deploying in the API Manager control plane 
  and data plane.
- Based on the deployment options, API controller deploys the API in the API Manager control plane or data plane.

### Manage Integrations

- Deploy integration.yaml file which is the Integration custom resource definition (CRD) for the Integration project.
- The API Operator takes the control for the Integration CRD.
- The Integration controller in the API Operator creates and deploys the relevant Kubernetes artifacts such as 
  deployment, service, ingress and horizontal pod autoscaler in the Kubernetes environment.
  
## Custom Resources

1. API

API holds the API related information. Users can provide a configmap name for swaggerConfigMapName, paramsValues and 
certsValues. The swaggerConfigMapName holds the API project or OpenAPI definition file. The paramsValues and 
certsValues holds the apictl project param configs and the certificate files for the API respectively.

```yaml
apiVersion: wso2.com/v1alpha2
kind: API
metadata:
  name: petstore-api
spec:
  swaggerConfigMapName: petstore-cm
  paramsValues: params-cm
  certsValues: certs-cm
```

2. Integration

```yaml
apiVersion: wso2.com/v1alpha2
kind: Integration
metadata:
  name: test-integration
spec:
  image: sajithagimash/test:1.0.0
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
  env:
    - name: DEV_ENV_USER_EP
      value: "https://reqres.in/api"
```

Integration holds the integration project related information. Users are able to define the docker image name, 
deployment specification, autoscale configurations, service related information and environment variables for 
the integration project.

3. TargetEndpoint

```yaml
apiVersion: wso2.com/v1alpha2
kind: TargetEndpoint
metadata:
  name: products-privatejet
  labels:
    app: wso2
spec:
  applicationProtocol: http
  ports:
    - name: prod-ep
      port: 80
      targetPort: 9090
  deploy:
    name: products-pj-service
    dockerImage: pubudu/products:1.0.0
    minReplicas: 2
    maxReplicas: 3
    requestCPU: "60m"
    reqMemory: "32Mi"
    cpuLimit: "120m"
  mode: privateJet
```

TargetEndpoint holds the endpoint related information. Users are able to define the application protocol, ports, 
deployment specification and the running mode for the endpoint.

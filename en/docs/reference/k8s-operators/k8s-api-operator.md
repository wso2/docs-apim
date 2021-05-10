# Kubernetes API Operator

As microservices are increasingly being deployed on Kubernetes, the need to expose these microservices as well
documented, easy to consume, managed APIs are becoming important to develop great applications.
The API operator for Kubernetes makes APIs a first-class citizen in the Kubernetes ecosystem.
Similar to deploying microservices, you can now use this operator to deploy APIs for individual microservices or
compose several microservices into individual APIs. With this users will be able to expose their microservice
as managed API in Kubernetes environment without any additional work.

The API operator for Kubernetes provides first-class support for Micro Integrator deployments in the Kubernetes
ecosystem. It uses the Integration custom resource (integration_cr.yaml file) that is available in the Kubernetes
project (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

[![With and without K8s API Operator]({{base_path}}/assets/img/learn/kubernetes-operators/with-and-without-k8s-api-operator.png)]({{base_path}}/assets/img/learn/kubernetes-operators/with-and-without-k8s-api-operator.png)

## How the API Operator works

Using kubectl command-line tool, users can manage APIs and Integration custom resources in 
Kubernetes environments as follows.

[![How API Operator Works]({{base_path}}/assets/img/learn/kubernetes-operators/how-api-operator-works.png)]({{base_path}}/assets/img/learn/kubernetes-operators/how-api-operator-works.png)

### Deploy APIs

The high-level steps for deploying APIs in Kubernetes using the API K8s Operator is as follows:

1.  Deploy an API project or OpenAPI definition in a config map in Kubernetes
2.  Deploy api.yaml file which is the API custom resource definition (CRD) for the API.
3.  In the API, you should refer to the config map which has the API project or OpenAPI definition.
4.  The API Operator takes control of the API CRD.
5.  The API controller in the API Operator creates the relevant artifacts for deploying in the API Manager control plane and data plane.
6.  Based on the deployment options, API controller deploys the API in the API Manager control plane or data plane.

For more information and instructions, see [Deploying APIs]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-apis/api-deployments).

### Deploy Integrations

The high-level steps for deploying integrations in Kubernetes using the API K8s Operator is as follows:

1.  Deploy integration.yaml file which is the Integration custom resource definition (CRD) for the Integration project.
2.  The API Operator takes control of the Integration CRD.
3.  The Integration controller in the API Operator creates and deploys the relevant Kubernetes artifacts such as deployment, service, ingress, and horizontal pod autoscaler in the Kubernetes environment.

For more information and instructions, see [Deploying Integrations]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments).
  
## Custom Resources

### API

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

### Integration

Integration holds the integration project-related information. Users can define the docker image name, 
deployment specification, autoscale configurations, service-related information, and environment variables for 
the integration project.

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

### TargetEndpoint

TargetEndpoint holds the endpoint-related information. Users can define the application protocol, ports, 
deployment specification and the running mode for the endpoint.

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

## API K8s Operator configurations

The configurations of the K8s API Operator are stored in K8s secrets and configmaps. Users can change the
configurations by changing the secrets and config maps in K8s.

### API Controller

Control deploying to the API microgateway and API Manager.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: api-controller-config
data:
    # Deploy the API to Microgateway
    deployAPIToMicrogateway: "true"
    # Deploy the API to API Manager
    deployAPIToAPIManager: "false"
```

### API-M configurations

Configure key manager endpoints, API publisher endpoint, ssl verification, and secret name for API Manager credentials.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: apim-config
data:
    # The following 3 endpoints are related to importing API to API Manager
    # API Manager Keymanager/DCR endpoint
    apimKeymanagerEndpoint: "https://localhost:9443"
    # API Manager Publisher endpoint
    apimPublisherEndpoint: "https://localhost:9443"
    # API Manager token endpoint
    apimTokenEndpoint: "https://localhost:9443/oauth2/token"

    # Skip verification for the REST API invocations. If "false", you need to provide the cert
    insecureSkipVerify: "true"
    # Secret name containing API Manager credentials and cert
    apimCredentialsSecret: "apim-secret"
    # Enable configurations for retrieving API and subscription data from API Manager.
``` 

### Choreo Connect configurations

Configure adapter connection URL and SSL verification.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: envoy-mgw-configs
data:
    mgwAdapterHost: "https://adapter.default:9843"
    # Skip verification for Microgateway Adapter endpoint call. If "false", you need to provide the cert
    mgwInsecureSkipVerify: "true"
``` 

### API-M secrets

Configure credentials related to API Manager and API Microgateway using K8s secrets as below. The input values should
be Base64 encoded.

```yaml tab="API-M Secret"
apiVersion: v1
kind: Secret
metadata:
    name: apim-secret
type: Opaque
data:
    # Base64 encoded username, password, and, cert secret name for API Manager
    username: YWRtaW4=
    password: YWRtaW4=
    cert_security: YXBpbS1jZXJ0LXNlY3JldA==
``` 

```yaml tab="API-M Cert Secret"
apiVersion: v1
kind: Secret
metadata:
    name: apim-cert-secret
data:
    # Base64 encoded public cert of API Manager instance
    apim.pem: <BASE 64 ENCODED PUBLIC CERT>
type: Opaque
``` 

```yaml tab="Choreo Connect Secret"
apiVersion: v1
kind: Secret
metadata:
    name: envoymgw-adapter-secret
type: Opaque
data:
    # Base64 encoded username and password for Envoy MGW Adapter
    username: YWRtaW4=
    password: YWRtaW4=
    mgwCertSecretName: ZW52b3ltZ3ctY2VydC1zZWNyZXQ=
``` 

```yaml tab="Choreo Connect Cert Secret"
apiVersion: v1
kind: Secret
metadata:
    name: envoymgw-cert-secret
data:
    # Base64 encoded public cert of Microgateway Adapter
    adapter.pem: <BASE 64 ENCODED PUBLIC CERT>
type: Opaque
``` 
  
### Integration Controller

Configure Integration custom resource-related configurations.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: integration-config
data:
    reconcileInterval: "10"
    autoIngressCreation: "true"
    enableAutoScale: "false"
    minReplicas: "1"
    maxReplicas: "5"
    # Auto Scaling Configurations
    hpaMetrics: |
    - type: Resource
        resource:
        name: cpu
        target:
            type: Utilization
            averageUtilization: 70
    # K8s Probes
    livenessProbe: |
    tcpSocket:
        port: 8290
    initialDelaySeconds: 10
    periodSeconds: 5
    readinessProbe: |
    httpGet:
        path: /healthz
        port: 9201
    initialDelaySeconds: 10
    periodSeconds: 5
``` 

### Integration Ingress configurations

Configure Ingress configurations for Integration services.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: integration-ingress-config
data:
    ingress.properties: |
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /$2
    nginx.ingress.kubernetes.io/ssl-redirect: false
    ingressResourceName: "api-operator-ingress"
    #Define whether ingress to use http or https endpoint of operator deployment
    ingressTransportMode: "https"
    #Define the hostname of the ingress
    ingressHostName : "wso2ei.ingress.wso2.com"
    #Define the secret name for TLS certificate
    #tlsSecretName: ""
``` 
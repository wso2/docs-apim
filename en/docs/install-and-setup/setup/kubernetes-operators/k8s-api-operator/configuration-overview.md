# Configuration Overview

The configurations of the K8s API Operator are stored in K8s secrets and configmaps. Users are able to change the
configurations by changing the secrets and config maps in K8s.

### API Controller

- Control deploying to the API microgateway and API Manager.

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

### API Manager

- Configure key manager endpoints, API publisher endpoint, ssl verification and secret name for API Manager credentials.

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

### API Microgateway 

- Configure adapter connection url and ssl verification.

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

### API Microgateway

- Configure credentials related to API Manager and API Microgateway using K8s secrets as below. The input values should
be Base64 encoded.

  ```yaml
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
  
  ```yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: apim-cert-secret
  data:
    # Base64 encoded public cert of API Manager instance
    apim.pem: <BASE 64 ENCODED PUBLIC CERT>
  type: Opaque
  ``` 
  
  ```yaml
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
  
  ```yaml
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

- Configure Integration custom resource related configurations.

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

### Integration Controller

- Configure Ingress configurations for Integration services.

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

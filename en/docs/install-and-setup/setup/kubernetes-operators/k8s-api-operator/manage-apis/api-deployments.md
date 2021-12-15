# Deploying APIs using the Operator

The Kubernetes API operator provides first-class support for APIs in the Kubernetes ecosystem. It uses the 
**API custom resource** which defined as follows.

```yaml
apiVersion: wso2.com/v1alpha2
kind: API
metadata:
  name: petstore-api
spec:
  swaggerConfigMapName: petstore-cm
```

When it comes to managing APIs, users are able to deploy APIs in Kubernetes with/without the Control Plane (API Manager).

Follow the deployment guides below to get started with managing APIs in Kubernetes.

- [Choreo Connect as a Standalone Gateway on Kubernetes]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-kubernetes)

- [Choreo Connect on Kubernetes with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-kubernetes-with-apim-as-control-plane/)

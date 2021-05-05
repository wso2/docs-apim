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

When it comes to managing APIs, users are able to deploy APIs in Kubernetes with/without the control plane(API Manager).
Follow the quick start guides below to get started with managing APIs in Kubernetes.

- [Without the Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-kubernetes)
- [With the Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-kubernetes-with-apim/)

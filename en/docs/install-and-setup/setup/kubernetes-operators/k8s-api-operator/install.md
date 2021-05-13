# Installing the API K8s Operator

### Before you begin...

1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
2. Setup a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.14 or above.
    - Minimum CPU : 2vCPU
    - Minimum Memory : 2GB
   
## Standalone Installation

- Installing the API Operator 

```shell
kubectl apply -f https://github.com/wso2/k8s-api-operator/releases/download/v2.0.0/api-operator-configs.yaml
```

- Verify Installation

```shell
kubectl get pods

Output:
NAME                            READY   STATUS              RESTARTS   AGE
api-operator-776c79b5f6-c9n9n   1/1     Running             0          56s
```

## Install K8s API Operator using OperatorHub.io
 
For information, see the installation instructions in the [OperatorHub.io](https://operatorhub.io/operator/api-operator).

## Install K8s API Operator in Cluster Mode

By default, API operator is configured to watch on the deployed namespace. i.e. If the API Operator runs on default 
namespace, it can only watch the custom resources that are deployed in the default namespace. By deploying in the 
cluster mode, API Operator is able to watch all the custom resources in all the namespaces.

- Deploy the ClusterRole
  
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
   name: api-operator
rules:
   - apiGroups:
        - ""
     resources:
        - pods
        - services
        - endpoints
        - persistentvolumeclaims
        - events
        - configmaps
        - secrets
        - ingresses
     verbs:
        - '*'
   - apiGroups:
        - apps
     resources:
        - deployments
        - daemonsets
        - replicasets
        - statefulsets
        - ingresses
     verbs:
        - '*'
   - apiGroups:
        - monitoring.coreos.com
     resources:
        - servicemonitors
     verbs:
        - get
        - create
   - apiGroups:
        - apps
     resourceNames:
        - api-operator
     resources:
        - deployments/finalizers
     verbs:
        - update
   - apiGroups:
        - wso2.com
     resources:
        - '*'
        - ratelimitings
        - targetendpoints
        - securities
        - integrations
     verbs:
        - '*'
   - apiGroups:
        - batch
     resources:
        - '*'
     verbs:
        - '*'
   - apiGroups:
        - autoscaling
     resources:
        - '*'
     verbs:
        - '*'
   - apiGroups:
        - extensions
     resources:
        - ingresses
        - ingress
     verbs:
        - '*'
   - apiGroups:
        - serving.knative.dev
     resources:
        - '*'
     verbs:
        - get
        - list
        - create
        - update
        - delete
        - patch
        - watch
   - apiGroups:
        - route.openshift.io
     resources:
        - '*'
     verbs:
        - get
        - list
        - create
        - update
        - delete
        - patch
        - watch
   - apiGroups:
        - networking.istio.io
     resources:
        - '*'
     verbs:
        - get
        - list
        - create
        - update
        - delete
        - patch
        - watch
```
- Deploy the ClusterRoleBinding

Replace the `<OPERATOR_DEPLOYED_NAMESPACE>` with the correct value.

```yaml
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
 name: api-operator
subjects:
- kind: ServiceAccount
 name: api-operator
 # Replace this with the namespace the operator is deployed in.
 namespace: <OPERATOR_DEPLOYED_NAMESPACE>
roleRef:
 kind: ClusterRole
 name: api-operator
 apiGroup: rbac.authorization.k8s.io
```

- Update API operator to watch cluster wide

Using the following command WATCH_CLUSTER_LEVEL config can be set to true in the API Operator deployment if the operator
is already running in the Kubernetes cluster.

```shell
kubectl set env deployment/api-operator WATCH_CLUSTER_LEVEL=true
```

## What's Next

- [Manage Integrations]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments.md)
- [Manage APIs]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-apis/api-deployments.md)

# Installing the API K8s Operator

Follow the instructions given below to install and set up the API K8s Operator in your Kubernetes environment.

## Before you begin

1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
2. Setup a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.14 or above. 
    - Minimum CPU : 2vCPU
    - Minimum Memory : 2GB
   
    Alternatively, you can [run Kubernetes locally via Minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).
   
## Install the API K8s Operator in Standalone mode

Follow the steps given below to install the operator in standalone mode.

1. Install the API Operator: 

    ```shell
    kubectl apply -f https://github.com/wso2/k8s-api-operator/releases/download/v2.0.0/api-operator-configs.yaml
    ```

2. Verify the installation:

    ```shell
    kubectl get pods

    Output:
    NAME                            READY   STATUS              RESTARTS   AGE
    api-operator-776c79b5f6-c9n9n   1/1     Running             0          56s
    ```

## Install K8s API Operator using OperatorHub.io
 
For information, see the installation instructions in the [OperatorHub.io](https://operatorhub.io/operator/api-operator).

## Install API K8s Operator in Cluster mode

By default, the K8s API operator is configured to watch the deployed namespace. That is, if the API Operator runs on the default namespace, it can only watch the custom resources that are deployed in the default namespace. By deploying in cluster mode, the API Operator is able to watch all the custom resources in all the namespaces.

-  Deploy the `ClusterRole`:
  
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

-  Deploy the `ClusterRoleBinding`:

      Be sure to replace `<OPERATOR_DEPLOYED_NAMESPACE>` with the correct value.

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

-  Update API operator to watch the cluster:

      If the operator is already running in the Kubernetes cluster, use the following command to set the `WATCH_CLUSTER_LEVEL` configuration to true in the API operator deployment.

      ```shell
      kubectl set env deployment/api-operator WATCH_CLUSTER_LEVEL=true
      ```

## What's Next

- [Deploying Integrations using the Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments)
- [Deploying APIs using the Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-apis/api-deployments)
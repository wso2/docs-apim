# Deploying the Micro Integrator on Kubernetes

You can set up a Kubernetes (K8s) cluster for the Micro Integrator using one of the following deployment options.

- [Using the Kubernetes Operator](#using-the-kubernetes-operator)

- [Using Helm resources](#using-helm-resources)

- [Using pure Kubernetes resources](#using-pure-kubernetes-resources)

## Selecting a deployment option

Take the following into consideration when deciding on whether to use the Kubernetes Operator or pure Kubernetes resources.

- The Kubernetes Operator (K8s Operator) is configuration-driven. Therefore, it is easier to provide all-in-one configurations to a K8s Operator and get it up and running when compared to using Helm resources or deploying pure Kubernetes resources.

- The K8s Operator offers first-class support for MI deployments via the Integration custom resource.

- The following is the list of deployment options in sequential order based on the ease of use.
     1. Kubernetes Operator
     2. Helm resources
     3. Pure Kubernetes resources

- If you have a lot of customizations in your deployment, you may consider using Helm resources or pure Kubernetes resources.

## Options for Kubernetes cluster set up 

### Using the K8s Operator

The API operator for Kubernetes provides first-class support for Micro Integrator deployments in the Kubernetes ecosystem. It uses the `Integration` custom resource (`integration_cr.yaml` file) that is available in the Kubernetes module, which is exported from WSO2 Integration Studio, and deploys the integration in your Kubernetes environment.

-   For instructions, see [deploying integrations on Kubernetes using the Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments).

### Using Helm resources

WSO2 releases Helm resources for all product deployments. You can get the [Helm resources for the Micro Integrator](https://github.com/wso2/kubernetes-mi/) and set up a Micro Integrator deployment on Kubernetes.

-   For instructions, see [deploying integrations on Kubernetes using Helm resources]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying-micro-integrator-with-helm).

### Using pure Kubernetes resources

Integration developers can directly generate the Kubernetes artifacts that are required for a Kubernetes deployment using WSO2 Integration Studio. After you have generated these resources, you can set a Kubernetes deployment by following the Kubernetes documentation.

-   For information on the Kubernetes Exporter in WSO2 Integration Studio, see [Create Kubernetes project]({{base_path}}/integrate/develop/create-kubernetes-project).


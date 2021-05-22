# Deploying the Micro Integrator on Kubernetes

You can set up a Kubernetes cluster for the Micro Integrator using one of the methods given below.

## Using the K8s Operator

The API operator for Kubernetes provides first-class support for Micro Integrator deployments in the Kubernetes ecosystem. It uses the `Integration` custom resource (`integration_cr.yaml` file) that is available in the Kubernetes module (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

-   See the instructions on [deploying integrations on Kubernetes using the Operator]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments).

## Using Helm resources

WSO2 releases Helm resources for all product deployments. You can get the [Helm resources for the Micro Integrator](https://github.com/wso2/kubernetes-mi/) and set up a Micro Integrator deployment on Kubernetes.

-   See the instructions on [deploying integrations on Kubernetes using Helm resources]({{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying-micro-integrator-with-helm).

## Using pure Kubernetes resources

Integration developers can directly generate the Kubernetes artifacts that are required for a Kubernetes deployment using WSO2 Integration Studio. Once these resources are generated, you can set a Kubernetes deployment by following the Kubernetes documentation.
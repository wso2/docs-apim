# Deploying the Micro Integrator on Kubernetes

You can set up a Kubernetes cluster for the Micro Integrator in two ways: 

-	Generate the Kubernetes resources for your integrations deployed in a Micro Integrator and create the Kubernetes cluster using those resources. This is the bare-metal approach to setting up a Kubernetes deployment. 
-	Use the API K8s Operator of WSO2 API Manager and automate the deployment.

## Use the K8s Operator

The API operator for Kubernetes provides first-class support for Micro Integrator deployments in the Kubernetes ecosystem. It uses the `Integration` custom resource (`integration_cr.yaml` file) that is available in the Kubernetes module (exported from WSO2 Integration Studio) and deploys the integration in your Kubernetes environment.

See [Deploying Integrations on Kubernetes]({{base_path}}/install-and-setup/setup/kubernetes-operators/k8s-api-operator/manage-integrations/integration-deployments) for more details and instructions.

## Use Kubernetes resources

Integration developers can directly generate the Kubernetes artifacts that are required for a Kubernetes deployment using WSO2 Integration Studio. Once these resources are generated, you can set a Kubernetes deployment by following the Kubernetes documentation.

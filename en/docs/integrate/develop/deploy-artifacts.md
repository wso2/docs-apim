# Deploying Artifacts

Once you have your integration artifacts developed and [packaged in a composite exporter]({{base_path}}/integrate/develop/packaging-artifacts), you can deploy the composite exporter in your Micro Integrator server or your container environment.

## Deploy artifacts in the embedded Micro Integrator

The light-weight Micro Integrator is already included in your WSO2 Integration Studio package, which allows you to deploy and run the artifacts instantly.

See the instructions in [using the embedded Micro Integrator]({{base_path}}/integrate/develop/using-embedded-micro-integrator) of WSO2 Integration Studio. 

## Deploy artifacts in a remote Micro Integrator instance

Download and set up a Micro Integrator server in your VM and deploy the composite exporter with your integration artifacts. 

See the instructions in [using a remote Micro Integrator]({{base_path}}/integrate/develop/using-remote-micro-integrator).

## Deploy artifacts in Docker

Use the <b>Docker Exporter</b> module in WSO2 Integration Studio to build a Docker image of your Micro Integrator solution and push it to your Docker registry. You can then use this Docker image from your Docker registry to start Docker containers.

See the instructions on using the [Docker Exporter]({{base_path}}/integrate/develop/create-docker-project).

## Deploy artifacts in Kubernetes

Use the <b>Kubernetes Exporter</b> module in WSO2 Integration Studio to deploy a Docker image of your Micro Integrator Solution in a Kubernetes environment. 

See the instructions on using the [Kubernetes Exporter]({{base_path}}/integrate/develop/create-kubernetes-project).

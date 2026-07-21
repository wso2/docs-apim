# Deploying Artifacts

Once you have your integration artifacts developed and [packaged in a composite application]({{base_path}}/integrate/develop/packaging-artifacts), you can deploy the composite application in your Micro Integrator server or your container environment.

## Deploy artifacts in the embedded Micro Integrator

The light-weight Micro Integrator is already included in your WSO2 Integration Studio package, which allows you to deploy and run the artifacts instantly.

See the instructions in [using the embedded Micro Integrator]({{base_path}}/integrate/develop/using-embedded-micro-integrator) of WSO2 Integration Studio. 

## Deploy artifacts in a remote Micro Integrator instance

Download and set up a Micro Integrator server in your VM and deploy the composite application with your integration artifacts. 

See the instructions in [using a remote Micro Integrator]({{base_path}}/integrate/develop/using-remote-micro-integrator).

## Deploy artifacts in Docker

Use the <b>Docker Exporter</b> module in WSO2 Integration Studio to build a Docker image of your Micro Integrator solution and push it to your Docker registry. You can then use this Docker image from your Docker registry to start Docker containers.

See the instructions on using the [Docker Exporter]({{base_path}}/integrate/develop/create-docker-project).

## Deploy artifacts in Kubernetes

Use the <b>Kubernetes Exporter</b> module in WSO2 Integration Studio to deploy a Docker image of your Micro Integrator Solution in a Kubernetes environment. 

See the instructions on using the [Kubernetes Exporter]({{base_path}}/integrate/develop/create-kubernetes-project).

## Enable priority-based composite application deployment

> **Note:** Priority-based composite application deployment is available from **WSO2 Micro Integrator 4.1.0.177 update level** onwards.

When multiple composite applications are deployed, they are processed in alphabetical order by default. However, if some composite applications depend on others, deployment may fail due to incorrect ordering. To enable priority-based deployment, add the following configuration to `<MI_HOME>/conf/deployment.toml`:

```toml
[server]
enable_priority_deployment = true
```

With this configuration, composite applications are divided into two categories:

- **High-priority**: composite applications containing a connector, datasource, registry resource, or class mediator.
- **Low-priority**: all other composite applications.

High-priority composite applications are deployed first (in alphabetical order), followed by low-priority ones (also in alphabetical order).

If high-priority composite applications depend on each other, deployment may still fail due to incorrect ordering. To mitigate this, configure a retry count using `priority_deployment_retry_count`. This value represents the number of additional deployment attempts made for high-priority composite applications after the initial attempt. The default is `1`.

```toml
[server]
enable_priority_deployment = true
priority_deployment_retry_count = 2
```

By default, the artifact types listed above (connector, datasource, registry resource, and class mediator) are treated as high-priority. You can override this default list by configuring `priority_deployment_high_priority_types` with the specific artifact types you want to treat as high-priority.

```toml
[server]
enable_priority_deployment = true
priority_deployment_high_priority_types = ["lib/synapse/mediator", "synapse/lib", "registry/resource", "datasource/datasource"]
```

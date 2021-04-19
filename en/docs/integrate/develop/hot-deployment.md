# Hot Deploying Artifacts

Hot deployment is the process of dynamically deploying your synapse artifacts (XML), dataservices(DBS), carbon applications (CAR), etc., in your Micro Integrator. That is, it is not required to restart the server for the artifact deployment to be effective.

Hot deployment is useful for testing the integration artifacts **in a VM environment**. With hot deployment, it is not required to restart the server each time you deploy an artifact and the testing time will be shorter and efficient. Hence, hot deploymet is enabled by default in the Micro Integrator distribution. However, this feature is disabled in the base Docker image of the Micro Integrator to honor the immutable nature of container environments.

!!! Note
    If  Readiness Probe is used with hot deployment, it will not detect faulty carbon applications in the deployment. If you want your server to be detected as **not ready** due to faulty applications, you need to disable hot deployment.

## Disabling hot deployment
Open the `deployment.toml` file from the `<MI_HOME>/conf` directory and set hot_deployment property to false.

```toml
[server]
hot_deployment = false
```

See the [complete list of server configurations]({{base_path}}/reference/config-catalog/#deployment).

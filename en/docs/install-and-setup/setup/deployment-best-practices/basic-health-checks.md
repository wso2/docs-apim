# Basic Health Checks

WSO2 API-M exposes health check APIs as explained below.

## API-M runtime health checks

Basic health checks can be performed on an API Manager node by connecting to relevant ports. Listed below are the ports that can be used for health checks in the available API-M profiles.

| API Manager Profile | Ports that can be used for health checks |
|---------------------|------------------------------------------|
| Gateway             | 9763 (HTTP), 9443 (HTTPS)                |
| Traffic Manager     | 5672 (TCP), 9611 (TCP)       |
| Key Manager         | 9673 (HTTP), 9443 (HTTPS)                |

For more information on each profile, see [API Manager Profiles]({{base_path}}//install-and-setup/setup/distributed-deployment/product-profiles).

There can be scenarios where even though the ports are responding, the services are not properly started. It is advisable to use service-level health checks to ensure that the services are started. For example, API Manager by default is shipped with the simple axis2 service named `Version`. This service returns the version of the API Manager instance that is running currently.

A sample cURL command and the response from the `Version` service are given below.

``` java tab="Format"
curl -v http://<HOSTNAME>:<PORT>/services/Version
```

``` java tab="Example"
curl -v http://localhost:9763/services/Version
```

``` java tab="Response"
<ns:getVersionResponse xmlns:ns="http://version.services.core.carbon.wso2.org"><return>WSO2 API Manager-2.6.0</return></ns:getVersionResponse>
```

## Micro Integrator health checks

WSO2 Micro Integrator provides a dedicated API for checking the health of the server. This can be used by a load 
balancer prior to routing traffic to a particular server node.

### Health Check API

The health check API has two behaviors depending on whether the deployment is mutable or immutable. If the deployment 
is mutable (which is mostly the configuration in centralized deployments), the probe gives a **ready** status when the 
server starts successfully. If the deployment is immutable, the probe gives a **ready** status only if all the CApps 
are deployed successfully during server startup. If there are faulty CApps, the probe returns the list of faulty CApps. The health check API serves at:

`http://localhost:9201/healthz`

!!! Note
    If you are running the server instance with a different port offset other than the default (which is 10), the heath
    check API serves at 9191 + offset.  

### Readiness Probe

The readiness probe is a vital configuration for deployments in Kubernetes as it governs the routing logic. The requests 
are not routed to a pod that is not ready.

Add the following configurations to your `deployment.yaml` file in order to configure the readiness probe for
the server. **Initial delay** and the **period** has to be fine-tuned according to your deployment.

```yaml
readinessProbe:
  httpGet:
    path: /healthz
    port: 9201
  initialDelaySeconds: 3
  periodSeconds: 1
```

### Liveness Probe

The liveness probe is a primary configuration in Kubernetes since it is used for knowing when to restart a container. For 
example, if the server stops serving requests on the http port, even though the server is alive, the container needs to 
be restarted so that the Micro Integrator instances serve the requests flawlessly. The default http socket of WSO2 Micro 
Integrator can be used to health check for liveness.

Add the following configurations to your `deployment.yaml` file in order to configure the liveness probe for
the server. **Initial delay** and the **period** have to be fine-tuned according to your deployment.

```yaml
livenessProbe:
  tcpSocket:
    port: 8290
  initialDelaySeconds: 15
  periodSeconds: 5
```

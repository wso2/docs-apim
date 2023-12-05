# Basic Health Checks

WSO2 API-M exposes health check APIs as explained below.

## API-M runtime health checks

Basic health checks can be performed on an API Manager node by connecting to relevant ports. Listed below are the ports that can be used for health checks in the available API-M profiles.

| API Manager Profile | Ports that can be used for health checks |
|---------------------|------------------------------------------|
| Gateway             | 9763 (HTTP), 9443 (HTTPS)                |
| Traffic Manager     | 5672 (TCP), 9611 (TCP)       |
| Key Manager         | 9673 (HTTP), 9443 (HTTPS)                |

For more information on each profile, see [API Manager Profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles).

There can be scenarios where even though the ports are responding, the services are not properly started. It is advisable to use service-level health checks to ensure that the services are started. For example, API Manager by default is shipped with the simple axis2 service named `Version`. This service returns the version of the API Manager instance that is running currently.

A sample cURL command and the response from the `Version` service are given below.

``` java tab="Format"
curl -v http://<HOSTNAME>:<PORT>/services/Version
```

``` java tab="Example"
curl -v http://localhost:9763/services/Version
```

``` java tab="Response"
<ns:getVersionResponse xmlns:ns="http://version.services.core.carbon.wso2.org"><return>WSO2 API Manager-4.0.0</return></ns:getVersionResponse>
```

When deploying the WSO2 API Manager Gateway, it's a best practice to ensure that all APIs are correctly deployed and ready to accept traffic before directing actual requests to the newly spawned Gateway. It's important to note that merely checking the server status might not be sufficient in this context.

To verify the successful deployment of APIs in the Gateway, we recommend using the Gateway health-check API. This dedicated API allows you to confirm the readiness of **all the APIs** in the Gateway. If everything is in order and **all the APIs** are deployed successfully, the health-check API will respond with a status code of 200 OK. This additional step helps guarantee that your API Gateway is fully prepared to handle incoming traffic.

Sample usages of this are shown below

``` yaml tab="cURL"
curl -k https://<GATEWAY_HOSTNAME>:<PORT>/api/am/gateway/v2/server-startup-healthcheck
```

``` yaml tab="Kubernetes"
readinessProbe:
  httpGet:
    path: /api/am/gateway/v2/server-startup-healthcheck
    port: 9443
    scheme: HTTPS
```

## Micro Integrator health checks

WSO2 Micro Integrator provides a dedicated API for checking the health of the server. This can be used by a load 
balancer prior to routing traffic to a particular server node.

### Health Check API

The health check API has two behaviors depending on whether the deployment is mutable or immutable. If the deployment 
is mutable (which is mostly the configuration in centralized deployments), the probe gives a **ready** status when the 
server starts successfully. If the deployment is immutable, the probe gives a **ready** status only if all the CApps 
are deployed successfully during server startup. If there are faulty CApps, the probe returns the list of faulty CApps. 

The health check API serves at:

`http://localhost:9201/healthz`

The health check can be performed over HTTPS APIs by adding the below configurations in the `deployment.toml`.

```toml
[readiness_probe]
protocols = "http https"
```

Sample Request

```curl
curl GET 'https://localhost:9164/healthz' -k
```

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

The Liveness probe is a primary configuration in Kubernetes since it is used for knowing when to restart a container. For 
example, if the server stops serving requests on the HTTP port, even though the server is alive, the container needs to 
be restarted so that the Micro Integrator instances serve the requests flawlessly. The default HTTP socket of WSO2 Micro 
Integrator can be used to health check for Liveness.

Add the following configurations to your `deployment.yaml` file in order to configure the Liveness probe for
the server. **Initial delay** and the **period** have to be fine-tuned according to your deployment.

```yaml
livenessProbe:
  tcpSocket:
    port: 8290
  initialDelaySeconds: 15
  periodSeconds: 5
```

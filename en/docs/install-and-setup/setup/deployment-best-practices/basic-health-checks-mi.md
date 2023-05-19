# Basic Health Checks

WSO2 Micro Integrator provides a dedicated API for checking the health of the server. This can be used by a load 
balancer prior to routing traffic to a particular server node.

### Health Check API

The health check API gives a **ready** status only if all the CApps are deployed successfully during server startup. If there are faulty CApps, the probe returns the list of faulty CApps. The health check API serves at:

`http://localhost:9201/healthz`

### Liveness Check API

The liveness check API gives a **ready** status when the server starts successfully.
The health check API serves at:

`http://localhost:9201/liveness`

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

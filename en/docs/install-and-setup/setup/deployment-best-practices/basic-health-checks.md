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

=== "Format"
    ``` java
    curl -v http://<HOSTNAME>:<PORT>/services/Version
    ```

=== "Example"
    ``` java
    curl -v http://localhost:9763/services/Version
    ```

=== "Response"
    ``` java
    <ns:getVersionResponse xmlns:ns="http://version.services.core.carbon.wso2.org"><return>WSO2 API Manager-4.2.0</return></ns:getVersionResponse>
    ```

!!! note
    Basic health checks for WebSocket ports 9099 and 8099 can be performed using `curl -v http://<HOSTNAME>:<PORT>/health`. For example, use the `curl -v http://localhost:9099/health` cURL command to check the health of port 9099. The response will be `200 OK` if the port is healthy.


When deploying the WSO2 API Manager Gateway, it's a best practice to ensure that all APIs are correctly deployed and ready to accept traffic before directing actual requests to the newly spawned Gateway. It's important to note that merely checking the server status might not be sufficient in this context.

To verify the successful deployment of APIs in the Gateway, we recommend using the Gateway health-check API. This dedicated API allows you to confirm the readiness of **all the APIs** in the Gateway. If everything is in order and **all the APIs** are deployed successfully, the health-check API will respond with a status code of 200 OK. This additional step helps guarantee that your API Gateway is fully prepared to handle incoming traffic.

Sample usages of this are shown below

=== "cURL"
    ``` yaml
    curl -k https://<GATEWAY_HOSTNAME>:<PORT>/api/am/gateway/v2/server-startup-healthcheck
    ```

=== "Kubernetes"
    ``` yaml
    readinessProbe:
      httpGet:
        path: /api/am/gateway/v2/server-startup-healthcheck
        port: 9443
        scheme: HTTPS
    ```

## Traffic Manager health-check API

Similarly to the Gateway health-check API, a dedicated health-check API is available for the Traffic Manager profile. Rather than only confirming that ports 5672 and 9611 are open, it confirms the Traffic Manager can actually receive throttle events (on port 9611, logging in on port 9711) and publish throttle decisions (on port 5672, and port 8672 if TLS messaging is configured) - not just whether those ports are open, but whether they really work.

!!! note
    This health-check API is delivered as a separate artifact and is not bundled in the API-M 4.3.0 pack by default. Follow the steps below to add it to a Traffic Manager node.

### Install

Download the following artifacts from the WSO2 Nexus repository and copy them into `<TM_HOME>/repository/components/dropins/`:

- `org.wso2.carbon.healthcheck.api.core-<version>.jar`
- `org.wso2.carbon.apimgt.healthcheck-<version>.jar`

<!-- TODO: link each jar to its published Nexus URL once released, in the same format as:
https://maven.wso2.org/nexus/content/repositories/releases/<groupId-path>/<artifactId>/<version>/<artifactId>-<version>.jar -->

Copy the health-check endpoint webapp into `<TM_HOME>/repository/deployment/server/webapps/`, naming it exactly as shown so it is served at `/api/health-check/v1.0`:

``` bash
cp org.wso2.carbon.healthcheck.api.endpoint-<version>.war \
  <TM_HOME>/repository/deployment/server/webapps/api#health-check#v1.0.war
```

### Configure

Add the following to `<TM_HOME>/repository/conf/deployment.toml`:

``` toml
[carbon_health_check]
enable = true

[[health_checker]]
name = "TMHealthChecker"
order = 6
[health_checker.properties]
"probe.timeout.ms" = "10000"
"slow.threshold.ms" = "2000"
"broker.receive.timeout.ms" = "5000"
"broker.ssl.port.enabled" = "true"
```

`[carbon_health_check] enable = true` turns on the health-check framework itself; the `[[health_checker]]` block registers this specific checker. Both are required - without the first, no health checker runs at all; without the second, this checker is loaded but never actually runs.

!!! tip
    If another registered health checker - for example the built-in `data_source_health_checker` - is also failing, its failure masks this checker's result too, since `/health` reports one combined status for every registered checker. To isolate the Traffic Manager check while troubleshooting, disable the others:
    ``` toml
    [carbon_health_check.health_checker.data_source_health_checker]
    enable = false

    [carbon_health_check.health_checker.super_tenant_health_checker]
    enable = false
    ```

Restart the Traffic Manager node. No `-Dsetup` flag is required - `health-check-config.xml` is regenerated from `deployment.toml` on every normal restart.

### Verify

=== "cURL"
    ``` yaml
    curl -k https://<TM_HOSTNAME>:<TM_PORT>/api/health-check/v1.0/health
    ```

=== "Response"
    ``` json
    {
      "health": [
        {"key": "tm.health.status", "value": "UP"},
        {"key": "tm.throttle.receiver.status", "value": "UP"},
        {"key": "tm.throttle.receiver.threads.status", "value": "UP"},
        {"key": "tm.message.broker.status", "value": "UP"}
      ]
    }
    ```

`tm.health.status` is the overall result: `UP`, `DEGRADED` (some, but not all, addresses have a problem), or `DOWN` (every address failed). The HTTP status is always `200` - the severity is only in this value, so a problem here is never confused with an unrelated checker's failure.

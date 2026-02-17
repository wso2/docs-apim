# Basic Health Checks

WSO2 API-M exposes health check APIs as explained below.

## API-M runtime health checks

Basic health checks can be performed on an API Manager node by connecting to relevant ports. Listed below are the ports that can be used for health checks in the available API-M components.

| API Manager Components | Ports that can be used for health checks |
|---------------------|------------------------------------------|
| Universal Gateway             | 9763 (HTTP), 9443 (HTTPS)                |
| Traffic Manager     | 5672 (TCP), 9611 (TCP)       |
| Key Manager         | 9673 (HTTP), 9443 (HTTPS)                |

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
    <ns:getVersionResponse xmlns:ns="http://version.services.core.carbon.wso2.org"><return>WSO2 API Manager-4.6.0</return></ns:getVersionResponse>
    ```

!!! note
    Basic health checks for WebSocket ports 9099 and 8099 can be performed using `curl -v http://<HOSTNAME>:<PORT>/health`. For example, use the `curl -v http://localhost:9099/health` cURL command to check the health of port 9099. The response will be `200 OK` if the port is healthy.


When deploying the WSO2 Universal Gateway, it's a best practice to ensure that all APIs are correctly deployed and ready to accept traffic before directing actual requests to the newly spawned Gateway. It's important to note that merely checking the server status might not be sufficient in this context.

To verify the successful deployment of APIs in the Gateway, we recommend using the Gateway health-check API. This dedicated API allows you to confirm the readiness of **all the APIs** in the Gateway. If everything is in order and **all the APIs** are deployed successfully, the health-check API will respond with a status code of 200 OK. This additional step helps guarantee that your  Gateway is fully prepared to handle incoming traffic.

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

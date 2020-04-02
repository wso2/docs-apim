# Basic Health Checks

Both API Manager and APIM Analytics support basic health checking by exposing health check APIs for available profiles.

## API Manager Profiles

Basic health checks can be performed on an API Manager node by connecting to relevant ports. See the following table for the ports that can be used for health checks in a fully distributed deployment.

| API Manager Profile | Ports that can be used for health checks |
|---------------------|------------------------------------------|
| Gateway Manager     | 9763 (HTTP), 9443 (HTTPS)                |
| Gateway Worker      | 8280 (HTTP), 8243 (HTTPS)                |
| API Dev Portal      | 9673 (HTTP), 9443 (HTTPS)                |
| API Publisher       | 9673 (HTTP), 9443 (HTTPS)                |
| Traffic Manager     | 5672 (TCP), 7611 (TCP), 7711 (TCP)       |
| Key Manager         | 9673 (HTTP), 9443 (HTTPS)                |

For more information on each profile, see [API Manager Profiles](https://docs.wso2.com/display/AM260/Product+Profiles) .

There can be scenarios where even though the ports are responding, the Services are not properly started. It is advisable to use Service level health checks to ensure that the services are started. For example, API Manager by default is shipped with the simple axis2 service named `Version` . This service returns the version of the API Manager instance that is running currently.

A sample cURL command and the response from the `Version` service are given below.

cURL command:

-   [**Format**](#c68169d1a59945f4905a9a6dc2f8c339)
-   [**Example**](#Example)
-   [**Response**](#response)

``` java
    curl -v http://<HOSTNAME>:<PORT>/services/Version
```

``` java
    curl -v http://localhost:9763/services/Version
```

``` java
    <ns:getVersionResponse xmlns:ns="http://version.services.core.carbon.wso2.org"><return>WSO2 API Manager-2.6.0</return></ns:getVersionResponse>
```
## APIM Analytics Profiles

Basic health checks can be performed on APIM analytics profiles by connecting to relevant ports. 

APIM Analytics by default is shipped with the simple service named `health`, and that is available in port number 9091 for Worker profile.
 
The following configuration should be added to the `<ANALYTICS_HOME>/conf/dashboard/deployment.yaml` in order to expose the service in the dashboard profile.
```yaml
   wso2.transport.http:
      listenerConfigurations:
          - id: "default"
            host: "0.0.0.0"
            port: 9092
```
This service returns the status as a json string as `{"status":"healthy"}`.

See the following table for the ports that can be used for health checks.

| APIM Analytics Profile | Ports that can be used for health checks |
|------------------------|------------------------------------------|
| Analytics Worker       | 9091 (HTTP), 9444 (HTTPS)                |
| Analytics Dashboard    | 9092 (HTTP), 9643 (HTTPS)                |

The cURL command format, a sample cURL command and the response from the `health` service are given below.

cURL command:

-   **Format**
``` java
    curl -X GET http://<HOSTNAME>:<PORT>/health
```
-   **Example**
``` java
    curl -X GET http://localhost:9091/health
```
-   **Response**
``` java
    {"status":"healthy"}
```

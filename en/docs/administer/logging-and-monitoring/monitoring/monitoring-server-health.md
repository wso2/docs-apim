# Monitoring Server Health

**Health Check API** is used to validate and verify the status of the API-M server and its dependencies. It is a REST service that returns the operational status, performance information of the configured endpoints (with the appropriate HTTP return code), and a JSON object. There are three Health Checkers available by default:

-  **Data Sources Health Checker** - This checker goes through the data sources that are configured in the `<API-M_HOME>/repository/conf/deployment.toml` file and checks if the active connection count surpasses a healthy percentage limit (e.g., 80%) of the maximum allowed connections count. This checker also tests the connection from each data source to see whether the connection is successful.
-  **User Store Health Checker** - This checker iterates through configured user stores of the super tenant domain and attempts to invoke the `isExistingUser` method to check whether a failure occurs.
-  **Traffic Manager (TM) Health Checker** - This checker probes the Traffic Manager's rate-limit event receiver (the port Gateways publish usage events to, together with its own login port) and its message broker (the port rate-limit decisions are delivered back through), reporting whether each is reachable and responding - see the Traffic Manager (TM) Health Checker section further down this page.

!!! note
    The Health Check API only supports WSO2 API Manager that runs on Java 8 or a later version.

## Enabling Health Checkers

### Step 1 - Deploy the Health Checker

The Carbon Health Check framework (its core bundle and the `/health` endpoint webapp) and the Traffic Manager (TM) Health Checker both ship pre-installed as part of the WSO2 API Manager distribution - there is nothing to fork, build, or copy into `dropins`/`webapps` manually. Skip straight to Step 2 to turn health checking on.

!!! note
    If you are instead adding your own **custom** Health Checker, see [Adding a custom Health Checker](#adding-a-custom-health-checker) below - that is the only case where you still need to deploy a Health Checker yourself.

### Step 2 - Configure the Health Checker global configurations

1. Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` configuration file.

2. Enable the Health Checker.
    
     Add the following global configuration to enable the DataSource Health Checker and the User Store Health Checker.
    
    ```
    [carbon_health_check]
    enable = true
    ```

### Step 3 - Optionally, update the Health Checker specific configurations

!!! note
    This step is only needed if you wish to change the default values for the Health Checkers.

The properties configured under each Health Checker will be available for each Health Checker at runtime.

#### Step 3.1 - Optionally, configure the User Store Health Checker

!!! note
    Skip this step if you wish to use the default values for the User Store Health Checker.

This Health Checker returns the status of the user stores available in the system. You can configure the user stores to be monitored by adding the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file.

```
[carbon_health_check.health_checker.data_source_health_checker]
enable =false
order = 98

[carbon_health_check.health_checker.super_tenant_health_checker.properties]
'monitored.user.stores' = "primary" 
```

| **Configuration**                               | **Description**                          |
| ---------------------------------------------| ------------------------------------ |
| enable                                        | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this configuration will get enabled by default.  |
| order                                         | The execution order in which the User Store Health Checker is executed. The default value is `98`. The lowest value is given priority. |
| monitored.user.stores                         | This configuration is used to specify the user stores as comma-separated values. The default value is `PRIMARY`. |

!!! example "Response"
    When you invoke the API and the User Stores are healthy, you can see a response similar to the following:

    ``` java
    {
        "health":[
            {
                "key":"PRIMARY.userstore.health",
                "value":"healthy"
            }
        ]
    }
    ```

#### Step 3.2 - Optionally, configure the DataSource Health Checker

!!! note
    Skip this step if you wish to use the default values for the DataSource Health Checker.

This Health Checker returns the status of the data sources available in the system.

To indicate the data source connection pool usage and specify the order, add the following configurations to the `<API-M_HOME>/repository/conf/deployment.toml` file.

```
[carbon_health_check.health_checker.data_source_health_checker]
enable = true
pool_usage_limit_percentage = "80"
order = "97"

[carbon_health_check.health_checker.data_source_health_checker.properties]
'monitored.datasources' = "jdbc/WSO2CarbonDB,jdbc/WSO2AM_DB,jdbc/SHARED_DB"
```   

| **Configuration**                               | **Description**                          |
| ---------------------------------------------| ------------------------------------ |
| enable                                        | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this configuration will get enabled by default.  |
| pool_usage_limit_percentage                   | This configuration is used to specify a healthy percentage limit of the maximum allowed connections count. The Data Health Checker checks if the active connection count surpasses the given healthy percentage limit. The default value is `80`. |
| order                                         | The execution order in which the DataSource Health Checker is executed. The default value is `97`.|
| monitored.datasources                         | This configuration is used to specify the Data Sources to be monitored as comma-separated values.|

!!! example "Response"
    When you invoke the API and the User Stores are healthy, you can see a response similar to the following:

    ```
    {
        "health":[
            {
                "key":"jdbc/SHARED_DB.connectivity.time.ms",
                "value":"0"
            },
            {
                "key":"WSO2MBStoreDB.connectivity.time.ms",
                "value":"0"
            },
            {
                "key":"jdbc/WSO2CarbonDB.connectivity.time.ms",
                "value":"0"
            },
            {
                "key":"jdbc/WSO2AM_DB.connectivity.time.ms",
                "value":"0"
            },
            {
                "key":"jdbc/WSO2CarbonDB.active.connection.count",
                "value":"1"
            },
            {
                "key":"jdbc/WSO2MetricsDB.active.connection.count",
                "value":"1"
            },
            {
                "key":"jdbc/WSO2MetricsDB.connectivity.time.ms",
                "value":"33"
            },
            {
                "key":"jdbc/WSO2AM_DB.active.connection.count",
                "value":"1"
            },
            {
                "key":"jdbc/SHARED_DB.active.connection.count",
                "value":"1"
            },
            {
                "key":"WSO2MBStoreDB.active.connection.count",
                "value":"1"
            }
        ]
    }
    ```

    -   The `active.connection.count` parameter reflects the number of connections that are active.

    -   `ConnectivityTime` refers to the duration of the connection.

#### Step 3.3 - Optionally, configure the Traffic Manager (TM) Health Checker

!!! note
    Skip this step if you wish to use the default values for the TM Health Checker.

This Health Checker reports whether the Traffic Manager's two moving parts are reachable from this node: the **rate-limit event receiver** (the port Gateways publish usage events to, plus its own login port) and the **message broker** (the port rate-limit decisions are delivered back through). It also reports how many connection slots the receiver's worker thread pools have free.

Unlike the Data Sources and User Store Health Checkers above, this is a custom-style Health Checker (registered the same way described under [Adding a custom Health Checker](#adding-a-custom-health-checker) below, except you do not need to deploy anything yourself - see Step 1). It is active as soon as `carbon_health_check` is enabled; the `[[health_checker]]` block below is only needed if you want to change its defaults.

The Traffic Manager's addresses are **not** configured here - they are resolved automatically from the same `[apim.throttling]` configuration the Gateways themselves use.

```toml
[[health_checker]]
name = "TMHealthChecker"
order = "6"

[health_checker.properties]
"probe.timeout.ms" = "10000"
"broker.receive.timeout.ms" = "5000"
"broker.ssl.port.enabled" = "true"
```

| **Configuration**          | **Description**                                                                                                                                                                                 |
|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name                         | Must be exactly `TMHealthChecker` - this is how the framework matches this configuration block to the checker.                                                                              |
| order                        | The execution order in which this checker runs relative to the others. |
| probe.timeout.ms             | How long, in milliseconds, to wait for a response from each address before reporting it as timed out. The default value is `10000`.                                                        |
| broker.receive.timeout.ms    | How long, in milliseconds, to wait for the message broker to deliver the test message back before reporting it as not received. The default value is `5000`.                              |
| broker.ssl.port.enabled      | Whether to also probe the message broker's SSL port (the configured port + 1000, e.g. `8672` alongside `5672`). Set to `false` if TLS messaging is not configured. The default value is `true`. |
| slow.threshold.ms            | An address that answers, but takes longer than this many milliseconds, is reported as `DEGRADED` rather than `UP`. Advanced - the default value is `2000`.                                 |
| stream.id                    | The name and version of the internal marker stream the test event is published to, as `<name>:<version>`. Advanced - only change this if you need to avoid a naming collision with another stream; the default value is `org.wso2.carbon.apimgt.healthcheck.marker:1.0.0`. |

!!! example "Response - every connection healthy"
    ``` java
    {
        "health":[
            {"key": "tm.health.status", "value": "UP"},
            {"key": "tm.health.message", "value": "Working normally."},
            {"key": "tm.throttle.receiver.status", "value": "UP"},
            {"key": "tm.throttle.receiver.message", "value": "Gateways can send usage events (port 9611, login 9711)."},
            {"key": "tm.throttle.receiver.endpoint.9611.source", "value": "apim.throttling"},
            {"key": "tm.throttle.receiver.endpoint.9611.status", "value": "UP"},
            {"key": "tm.throttle.receiver.endpoint.9611.auth.status", "value": "UP"},
            {"key": "tm.throttle.receiver.threads.status", "value": "UP"},
            {"key": "tm.throttle.receiver.threads.message", "value": "100/100 TCP, 100/100 SSL slots free."},
            {"key": "tm.throttle.receiver.threads.tcp.remaining", "value": "100"},
            {"key": "tm.throttle.receiver.threads.ssl.remaining", "value": "100"},
            {"key": "tm.message.broker.status", "value": "UP"},
            {"key": "tm.message.broker.message", "value": "Rate-limit decisions reach Gateways (port 5672)."},
            {"key": "tm.message.broker.endpoint.5672.source", "value": "apim.throttling"},
            {"key": "tm.message.broker.endpoint.5672.status", "value": "UP"}
        ]
    }
    ```

    The `tm.message.broker.endpoint.8672.*` keys (the SSL port) only appear if TLS messaging is configured - they are left out entirely otherwise, rather than shown with any other value.

!!! example "Response - the rate-limit event receiver is rejecting events"
    ``` java
    {
        "health":[
            {"key": "tm.health.status", "value": "DEGRADED"},
            {"key": "tm.health.message", "value": "Partly working. Problem: rate-limit event receiver."},
            {"key": "tm.throttle.receiver.status", "value": "DOWN"},
            {"key": "tm.throttle.receiver.message", "value": "Gateways cannot send usage events (port 9611, login 9711)."},
            {"key": "tm.throttle.receiver.endpoint.9611.source", "value": "apim.throttling"},
            {"key": "tm.throttle.receiver.endpoint.9611.status", "value": "DOWN"},
            {"key": "tm.throttle.receiver.endpoint.9611.error.code", "value": "TM_HC_PUBLISH_FAILED"},
            {"key": "tm.throttle.receiver.endpoint.9611.error.message", "value": "Test message was not accepted"},
            {"key": "tm.throttle.receiver.endpoint.9611.auth.status", "value": "UP"},
            {"key": "tm.throttle.receiver.threads.status", "value": "UP"},
            {"key": "tm.throttle.receiver.threads.message", "value": "100/100 TCP, 100/100 SSL slots free."},
            {"key": "tm.throttle.receiver.threads.tcp.remaining", "value": "100"},
            {"key": "tm.throttle.receiver.threads.ssl.remaining", "value": "100"},
            {"key": "tm.message.broker.status", "value": "UP"},
            {"key": "tm.message.broker.message", "value": "Rate-limit decisions reach Gateways (port 5672)."},
            {"key": "tm.message.broker.endpoint.5672.source", "value": "apim.throttling"},
            {"key": "tm.message.broker.endpoint.5672.status", "value": "UP"}
        ]
    }
    ```

!!! important
    Unlike the Data Sources and User Store Health Checkers, the TM Health Checker never turns the overall `GET /health` response into a non-2xx **Error response** (see below) - a Traffic Manager problem is never thrown as an exception. The HTTP status stays `200`, and a failure is reported entirely through `tm.health.status`/`tm.*.status` being something other than `UP`, together with a `.error.code`/`.error.message` pair on the specific key that failed. This is deliberate: the framework turns the *whole* response non-2xx if *any one* registered checker throws, which would otherwise hide an unrelated, healthy checker's result behind an error status.

    A throttle receiver endpoint's own `.status` can also be `UNKNOWN` instead of `UP`/`DOWN` - this means its login step (port 9711) failed, so the publish step (port 9611) was never even attempted. The real failure reason is then under that same endpoint's `.auth.error.code`/`.auth.error.message` instead:

    ``` java
    {"key": "tm.throttle.receiver.endpoint.9611.status", "value": "UNKNOWN"},
    {"key": "tm.throttle.receiver.endpoint.9611.error.code", "value": "TM_HC_NOT_ATTEMPTED"},
    {"key": "tm.throttle.receiver.endpoint.9611.auth.status", "value": "DOWN"},
    {"key": "tm.throttle.receiver.endpoint.9611.auth.error.code", "value": "TM_HC_LOGIN_FAILED"}
    ```

    | **Error Code**              | **Description**                                                                                      |
    |------------------------------|-------------------------------------------------------------------------------------------------------|
    | TM\_HC\_CONFIG\_UNRESOLVED   | No address could be resolved from the `[apim.throttling]` configuration.                              |
    | TM\_HC\_PORT\_CLOSED         | The port is not reachable.                                                                             |
    | TM\_HC\_TLS\_FAILED          | The secure (SSL/TLS) connection failed.                                                               |
    | TM\_HC\_LOGIN\_FAILED        | Login to the receiver (port 9711 + offset) failed.                                                    |
    | TM\_HC\_PUBLISH\_FAILED      | The receiver did not accept the test event.                                                           |
    | TM\_HC\_TIMEOUT              | No answer was received within `probe.timeout.ms`.                                                     |
    | TM\_HC\_UNEXPECTED\_ERROR    | An unexpected error occurred while probing.                                                           |
    | TM\_HC\_STREAM\_UNDEFINED    | The health check marker stream is not deployed on the receiver side.                                  |
    | TM\_HC\_SESSION\_EXPIRED     | The receiver rejected the login session.                                                              |
    | TM\_HC\_NOT\_ATTEMPTED       | The publish step (9611) was never attempted, because the login step (9711) failed first - see above.  |
    | TM\_HC\_CONNECT\_FAILED      | Could not connect to the message broker.                                                              |
    | TM\_HC\_SUBSCRIBE\_FAILED    | Could not subscribe to the message broker's health check topic.                                       |
    | TM\_HC\_NOT\_RECEIVED        | The test message was not delivered back from the broker in time.                                      |
    | TM\_HC\_THREAD\_POOL\_SIZE\_UNKNOWN | The receiver's free thread pool counts could not be read.                                      |

### Step 4 - Invoke the Health Checker API

1. Start WSO2 API Manager.

2. Send a GET request to the health check API. 

     A sample cURL command is shown below.

    ``` java
    curl -k -v https://{hostname}:{port}/api/health-check/v1.0/health
    ```

## Adding a custom Health Checker

Follow the instructions below to add a custom Health Checker:

1. Add a new custom Health Checker.

    You can use the WSO2 [carbon-health-check repository](https://github.com/wso2/carbon-health-check) to implement your custom Health Checkers.

    Follow the instructions below to extend the base classes of the current Health Checker implementation and to formulate a logic:

    1. Extend the [HealthChecker method](https://github.com/wso2/carbon-health-check/blob/3f8e1cc064acc56e15c28e4d692edd10fda7eac2/components/org.wso2.carbon.healthcheck.api.core/src/main/java/org/wso2/carbon/healthcheck/api/core/HealthChecker.java) to write your custom Health Checker.

    2. Write your logic for that implementation in the `checkHealth()` method.

    3. Register your custom Health Checker as an OSGi component in the [HealthMonitorServiceComponent.java](https://github.com/wso2/carbon-health-check/blob/3f8e1cc064acc56e15c28e4d692edd10fda7eac2/components/org.wso2.carbon.healthcheck.api.core/src/main/java/org/wso2/carbon/healthcheck/api/core/internal/HealthMonitorServiceComponent.java) file.

2. Deploy the Health Checker using one of the following methods.
     
     - If you are working with a JAR, copy the `.jar` file to the `<API-M_HOME>/repository/component/lib/` directory.
     - If you are working with an OSGI bundle, paste it in the `<API-M_HOME>/repository/component/dropins/` directory.

3. Register the new Health Checker as shown below in the `deployment.toml` file.

    ```
    [[health_checker]]
    name = "customChecker" 
    order="87" 
    [health_checker.properties] 
    property1 = "property-1-value"
    property2 = "property-2-value" 
    ```

!!! example "Sample configuration"
    The following is a sample configuration of the `deployment.toml` file, which is configured to monitor the DataSources Health Checker, User Store Health Checker, and a custom Health Checker. 
    
    ```
    [carbon_health_check] 
    enable = true
    
    [carbon_health_check.health_checker.data_source_health_checker]
    enable = true
    pool_usage_limit_percentage = "80"
    order = "97"

    [carbon_health_check.health_checker.data_source_health_checker.properties]
    'monitored.datasources' = "jdbc/WSO2CarbonDB,jdbc/WSO2AM_DB,jdbc/SHARED_DB"

    [carbon_health_check.health_checker.super_tenant_health_checker]
    enable =false
    order = 98

    [carbon_health_check.health_checker.super_tenant_health_checker.properties]
    'monitored.user.stores' = "primary" 
    
    [[health_checker]] 
    name = "customChecker" 
    order = "87"

    [health_checker.properties] 
    property1 = "property-1-value" 
    property2 = "property-2-value" 
    ```

## Error responses

The following responses are possible error responses that you may receive when monitoring the health of the server.

!!! Example
    The code block below shows a sample **503 Unavailable** response with an array of errors.

    ``` java
    {  
        "errors":[  
            {  
                "code":"HC_00001",
                "message":"Error while getting database connection for datasource: jdbc/DISCONNECTED",
                "description":"Network is unreachable (connect failed)"
            },
            {  
                "code":"HC_00003",
                "message": "Error while checking the health of USM with domain: SEC",
                "description":"Access denied for user 'root'@'localhost' (using password: YES)"
            }
        ]
    }
    ```

| **Error Code** | **Description**                                                                                                       |
|------------|-------------------------------------------------------------------------------------------------------------------|
| HC\_00001  | Data source connectivity error.                                                                                   |
| HC\_00002  | Number of connections in data source exceeds the healthy percentage.                                              |
| HC\_00003  | Error while testing connectivity to the user store using the `isExistingUser` operation. |
| HC\_00004  | Server status is not running. |
| HC\_00005  | Error listing user stores. |

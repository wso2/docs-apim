# Monitoring Server Health

**Health Check API** is used to validate and verify the status of the API-M server and its dependencies. It is a REST service that returns the operational status, performance information of the configured endpoints (with the appropriate HTTP return code), and a JSON object. The distribution includes three Health Checkers. The Data Sources and User Store Health Checkers are enabled by the global configuration. The TM Health Checker is pre-installed but requires a `[[health_checker]]` block named `TMHealthChecker` before it runs:

- **Data Sources Health Checker** - This checker goes through the data sources that are configured in the `<API-M_HOME>/repository/conf/deployment.toml` file and checks if the active connection count surpasses a healthy percentage limit (e.g., 80%) of the maximum allowed connections count. This checker also tests the connection from each data source to see whether the connection is successful.
- **User Store Health Checker** - This checker iterates through configured user stores of the super tenant domain and attempts to invoke the `isExistingUser` method to check whether a failure occurs.
- **Traffic Manager (TM) Health Checker** - This checker probes the Traffic Manager's rate-limit event receiver (the port Gateways publish usage events to, together with its own login port) and its message broker (the port rate-limit decisions are delivered back through), reporting whether each is reachable and responding - see the [Traffic Manager (TM) Health Checker](#step-33---optionally-configure-the-traffic-manager-tm-health-checker) section further down this page.

!!! note
    The Health Check API only supports WSO2 API Manager that runs on Java 8 or a later version.

## Enabling Health Checkers

### Step 1 - Deploy the Health Checker

This section guides you through deploying the Carbon Health Check components in WSO2 API Manager

1. Fork the following GitHub repository.

   `https://github.com/wso2/carbon-health-check`
2. Navigate to the place where you want to clone the repository and clone the forked repository.

   The forked repository is referred to as `<HEALTH_CHECK_HOME>` in this document.

   `git clone https://github.com/[git-username]/carbon-health-check`
3. Checkout to tag `v1.3.3`.
4. Navigate to `<HEALTH_CHECK_HOME>` and build the product.

   `mvn clean install`
5. Rename `org.wso2.carbon.healthcheck.api.core-<version-number>-SNAPSHOT.jar`, which is found in the `<HEALTH_CHECK_HOME>/components/org.wso2.carbon.healthcheck.api.core/target` directory, as `org.wso2.carbon.healthcheck.api.core-<version-number>.jar` and paste it in the `<API-M_HOME>/repository/components/dropins` directory.
6. Copy the webapp `api#health-check#v1.0.war`, which is found in the `<HEALTH_CHECK_HOME>/components/org.wso2.carbon.healthcheck.api.endpoint/target/` directory and paste it in the `<API-M_HOME>/repository/deployment/server/webapps` directory.
7. Copy the `health-check-config.xml` configuration file found in the `<HEALTH_CHECK_HOME>/features/org.wso2.carbon.healthcheck.server.feature/resources` directory to your `<PRODUCT_HOME>/repository/conf/` directory.
8. Optionally, to also enable the Traffic Manager (TM) Health Checker, download [org.wso2.carbon.apimgt.healthcheck-9.29.120.363-SNAPSHOT.jar]({{base_path}}/assets/attachments/monitoring/org.wso2.carbon.apimgt.healthcheck-9.29.120.363-SNAPSHOT.jar) and paste it in the `<API-M_HOME>/repository/components/dropins` directory as well - see [Step 3.3](#step-33---optionally-configure-the-traffic-manager-tm-health-checker) further down this page.
9. Correct the health check related configurations as indicated below in the `<API-M-HOME>/repository/conf/deployment.toml` file.

   ```toml
   [carbon_health_check]
   enable= true
   [carbon_health_check.health_checker.data_source_health_checker.properties]
   'monitored.datasources' = "jdbc/WSO2CarbonDB,jdbc/WSO2AM_DB,jdbc/SHARED_DB"
   [carbon_health_check.health_checker.super_tenant_health_checker.properties]
   'monitored.user.stores' = "primary"
   ```

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

| **Configuration** | **Description**                                                                                                                                     |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| enable                  | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this configuration will get enabled by default. |
| order                   | The execution order in which the User Store Health Checker is executed. The default value is `98`. The lowest value is given priority.                  |
| monitored.user.stores   | This configuration is used to specify the user stores as comma-separated values. The default value is `PRIMARY`.                                        |

!!! example "Response"
    When you invoke the API and the User Stores are healthy, you can see a response similar to the following:

    ``java     {         "health":[             {                 "key":"PRIMARY.userstore.health",                 "value":"healthy"             }         ]     }    ``

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

| **Configuration**     | **Description**                                                                                                                                                                                                                               |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| enable                      | The configuration element is to enable DataSource Health Checker. When `carbon_health_check` is enabled this configuration will get enabled by default.                                                                                           |
| pool_usage_limit_percentage | This configuration is used to specify a healthy percentage limit of the maximum allowed connections count. The Data Health Checker checks if the active connection count surpasses the given healthy percentage limit. The default value is `80`. |
| order                       | The execution order in which the DataSource Health Checker is executed. The default value is `97`.                                                                                                                                                |
| monitored.datasources       | This configuration is used to specify the Data Sources to be monitored as comma-separated values.                                                                                                                                                   |

!!! example "Response"
    When you invoke the API and the User Stores are healthy, you can see a response similar to the following:

    ``    {         "health":[             {                 "key":"jdbc/SHARED_DB.connectivity.time.ms",                 "value":"0"             },             {                 "key":"WSO2MBStoreDB.connectivity.time.ms",                 "value":"0"             },             {                 "key":"jdbc/WSO2CarbonDB.connectivity.time.ms",                 "value":"0"             },             {                 "key":"jdbc/WSO2AM_DB.connectivity.time.ms",                 "value":"0"             },             {                 "key":"jdbc/WSO2CarbonDB.active.connection.count",                 "value":"1"             },             {                 "key":"jdbc/WSO2MetricsDB.active.connection.count",                 "value":"1"             },             {                 "key":"jdbc/WSO2MetricsDB.connectivity.time.ms",                 "value":"33"             },             {                 "key":"jdbc/WSO2AM_DB.active.connection.count",                 "value":"1"             },             {                 "key":"jdbc/SHARED_DB.active.connection.count",                 "value":"1"             },             {                 "key":"WSO2MBStoreDB.active.connection.count",                 "value":"1"             }         ]     }    ``

    -   The `active.connection.count` parameter reflects the number of connections that are active.

    -   `ConnectivityTime` refers to the duration of the connection.

#### Step 3.3 - Configure the Traffic Manager (TM) Health Checker

!!! note
    Skip this step if you did not deploy `org.wso2.carbon.apimgt.healthcheck-9.29.120.363-SNAPSHOT.jar` in Step 1.

This Health Checker reports whether the Traffic Manager's two moving parts work from this node: the **rate-limit event receiver** (the port Gateways publish usage events to, plus its own login port) and the **message broker** (the port rate-limit decisions are delivered back through). It also reports how many connection slots the receiver's worker thread pools have free. On each probe it logs in to the receiver, publishes one test event, and sends one test message through the broker and waits for it to come back, so a port that accepts connections but does not work is reported as down. The result of a probe is reused for `result.cache.ms` (default `5000` milliseconds), so calls within that period do not log in or send new test messages; set `result.cache.ms` to `0` to probe on every call.

The checker reports on the Traffic Manager node it runs on. There is no cross-node aggregation.

!!! important
    Unlike the Data Sources and User Store Health Checkers, this checker does nothing until you add a `[[health_checker]]` block named `TMHealthChecker`. Unless `endpoint.checks.enabled` is `false`, the block must also have a `username` and `password`. The checker does not read the credentials from any other configuration, so it does not depend on the API Manager configuration service.

##### Configuring the checker

The `username` and `password` are used to log in to the receiver and to connect to the broker. Use the account the Gateways publish with.

=== "All-in-one deployment"

    The `[apim.throttling]` credentials resolve in every deployment, so `$ref{...}` is the safest choice and needs no extra start-up arguments. The addresses default to this node, so you do not need to list them.

    ```toml
    [carbon_health_check]
    enable = true

    [[health_checker]]
    name = "TMHealthChecker"
    order = "6"

    [health_checker.properties]
    "username" = "${admin.username}"
    "password" = "${admin.password}"
    "broker.ssl.port.enabled" = false


    ```

=== "Distributed deployment"

    Add this to **each Traffic Manager node**. Give the credentials the Gateways use to publish to this node. Do not list the other Traffic Manager nodes - each node checks itself, so a problem on one node never shows up on another.

    ```toml
    [carbon_health_check]
    enable = true

    [[health_checker]]
    name = "TMHealthChecker"
    order = "6"

    [health_checker.properties]
    "username" = "${admin.username}"
    "password" = "${admin.password}"
    "broker.ssl.port.enabled" = false

    # Only if this node's receiver or broker is not on carbon.local.ip with the standard ports:
    # "receiver.urls" = "tcp://tm1.example.com:9611"
    # "receiver.auth.urls" = "ssl://tm1.example.com:9711"
    # "broker.urls" = "tcp://tm1.example.com:5672"
    ```

##### All properties

All properties go under `[health_checker.properties]`. Quote the names, because they contain dots. A value that cannot be parsed falls back to its default and logs a warning.

| **Configuration**              | **Description**                                                                                                                                                                                                                                                                                                                                     |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| username, password                   | **Required**, unless `endpoint.checks.enabled` is `false`. The credentials for the receiver login and the broker connection. If they are missing, the check reports `TM_HC_LOGIN_FAILED` without connecting.                                                                                                                                  |
| receiver.username, receiver.password | The credentials for the receiver only. The default is `username` and `password`.                                                                                                                                                                                                                                                                      |
| broker.username, broker.password     | The credentials for the broker only. The default is `username` and `password`.                                                                                                                                                                                                                                                                        |
| receiver.urls                        | The receiver addresses, comma-separated, for example `tcp://tm1.example.com:9611`. The default is `carbon.local.ip` on port `9611` plus the port offset.                                                                                                                                                                                            |
| receiver.auth.urls                   | The receiver login addresses, comma-separated, for example `ssl://tm1.example.com:9711`, matched in order with `receiver.urls`. The default is each receiver's host on port `9711` plus the port offset.                                                                                                                                            |
| broker.urls                          | The broker addresses, separated by `;` or `,`, for example `tcp://tm1.example.com:5672`. Add `?ssl='true'` to mark a TLS address. The default is `carbon.local.ip` on port `5672` plus the port offset.                                                                                                                                       |
| fail.on.status                       | The lowest status that makes `GET /health` answer HTTP `503`. `DEGRADED` (default): any failed address, or no free receiver threads. A busy receiver can have no free threads, so do not use `DEGRADED` for a liveness probe (see below). `DOWN`: only when everything failed. `NONE`: never answers `503`.                                                                                                                                        |
| login.retry.interval.ms              | The default is `0`: once the receiver rejects the login, it is not tried again until the server restarts, so the check cannot lock the account when account locking is enabled. A value above `0` tries again after that many milliseconds.                                                                                                           |
| result.cache.ms                      | How long one result is reused across callers, in milliseconds. `0` turns it off. The default is `5000`. Each uncached check is a real login, so a higher value means fewer logins (see below).                                                                                                                                                                                                                                               |
| probe.timeout.ms                     | TThe maximum time `GET /health` waits for probe results before responding, in milliseconds. Socket read operations on individual probe threads continue until the underlying socket timeout (e.g., `socketTimeoutMS`) elapses. The default is `1670` (or `4000` recommended in busy networks). Make sure external callers (such as Kubernetes liveness probes) set their probe timeout higher than this value.|
| broker.receive.timeout.ms            | How long to wait for the broker's test message to come back, in milliseconds. The default is `1670`.                                                                                                                                                                                                                                                    |
| slow.threshold.ms                    | An address that answers but takes longer than this many milliseconds is reported as `DEGRADED`. A slow address never makes `GET /health` answer `503`. The default is `2000`.                                                                                                                                                                     |
| broker.ssl.port.enabled              | Also probe the broker's TLS port (`8672` plus the port offset) for a host that has no TLS entry. Set to `false` if the broker has no TLS listener. The default is `true`.                                                                                                                                                                           |
| endpoint.checks.enabled              | Set to `false` to stop probing the receiver and the broker, and report only the overall status and the receiver thread pools (`tm.throttle.receiver.threads.*`). The `username`, `password` and address properties are then not used, but the `[[health_checker]]` block itself is still required. The default is `true`.                     |
| probe.max.threads                    | The most probes that can run at the same time, across all calls. A probe that is stuck, for example behind a dropped connection, keeps its thread until it ends. When every thread is busy, the next probe is not started and `GET /health` answers `503` with `TM_HC_PROBE_POOL_EXHAUSTED`. The default is `100`.                                |
| stream.id                            | The internal marker stream the test event is sent to, as `<name>:<version>`. Advanced. The default is `org.wso2.carbon.apimgt.healthcheck.marker:1.0.0`.                                                                                                                                                                                              |

In the address properties you can use `${name}` for a system property that is resolved when the check runs, for example `"tcp://${carbon.local.ip}:${receiver.url.port}"`. An address with an explicit port is used as is, so the port offset is not added to it.

!!! warning "Do not use this endpoint as a Kubernetes liveness probe"
    Each Gateway connection to the receiver holds one of its worker threads. A Traffic Manager that serves about as many Gateway connections as the pool size (`tcpReceiverThreadPoolSize` and `sslReceiverThreadPoolSize` in `data-bridge-config.xml`, default `100`) has no free threads left, so with the default `fail.on.status` of `DEGRADED` it answers HTTP `503` although it is only busy. A liveness probe would then restart a healthy node. Use `GET /health` as a readiness probe or for monitoring and alerting. If you must use it for liveness, set `"fail.on.status" = "DOWN"`, so that only a node where nothing works fails the check. Raise the pool sizes if the node regularly runs close to them.

!!! note "Each check performs a real login"
    Every check that is not served from the cache logs in to the receiver with the configured account (usually `admin`) and publishes a test event. With the default `result.cache.ms` of `5000`, that is up to 12 logins a minute. They appear in the audit and login logs, and they add load to the user store, which matters if it is LDAP or Active Directory. Raise `result.cache.ms` (for example, `30000` gives 2 logins a minute) and use a dedicated service account if you want to keep them apart from administrator logins.

##### Reading the response

A working or slow Traffic Manager answers HTTP `200` with a `health` array. The keys are named by role (`receiver`, `amqp`, `amqps`, then `_2`, `_3` for more nodes), so every node reports under the same keys whatever its port offset.

```java
{
    "health": [
        {"key": "tm.health.status", "value": "UP"},
        {"key": "tm.throttle.receiver.status", "value": "UP"},
        {"key": "tm.throttle.receiver.endpoint.receiver.source", "value": "health_checker"},
        {"key": "tm.throttle.receiver.endpoint.receiver.port", "value": "9611"},
        {"key": "tm.throttle.receiver.endpoint.receiver.auth.port", "value": "9711"},
        {"key": "tm.throttle.receiver.endpoint.receiver.status", "value": "UP"},
        {"key": "tm.throttle.receiver.endpoint.receiver.auth.status", "value": "UP"},
        {"key": "tm.throttle.receiver.threads.status", "value": "UP"},
        {"key": "tm.throttle.receiver.threads.tcp.remaining", "value": "100"},
        {"key": "tm.throttle.receiver.threads.ssl.remaining", "value": "100"},
        {"key": "tm.message.broker.status", "value": "UP"},
        {"key": "tm.message.broker.endpoint.amqp.port", "value": "5672"},
        {"key": "tm.message.broker.endpoint.amqp.status", "value": "UP"}
    ]
}
```

With `"endpoint.checks.enabled" = "false"`, the response contains only `tm.health.status`, `tm.health.message` and the `tm.throttle.receiver.threads.*` keys. The overall status is `UP`, or `DEGRADED` (HTTP `503`, subject to `fail.on.status`) when the receiver has no free threads.

Each status also has a plain-English `.message` key beside it, which the example leaves out. The `.source` value is `health_checker` when the address was configured, and `default` when it was derived from `carbon.local.ip`.

When an address fails, or the receiver has no free threads, `GET /health` answers HTTP `503` with an `errors` array and no `health` array (provided the resulting failure meets the configured `fail.on.status` threshold), like the Data Sources and User Store Health Checkers. The first error describes the overall status, and each further error is one failed address or check, with the key prefix as its `description`:

```java
{
    "errors": [
        {"code": "TM_HC_DEGRADED", "message": "Partly working. Problem: rate-limit event receiver.", "description": "tm.health.status"},
        {"code": "TM_HC_TIMEOUT", "message": "No answer in time", "description": "tm.throttle.receiver.endpoint.receiver"}
    ]
}
```

Set `"fail.on.status" = "NONE"` to always get the full `health` array with HTTP `200`, including the `.error.code` and `.error.message` of any failed key. The response never includes host names, connection strings or credentials; the details are only written to the log.

A receiver endpoint's status is `UNKNOWN` when its login step failed, so the publish step was never attempted. The cause is then under that endpoint's `.auth.error.code` and `.auth.error.message`.

| **Error Code**                | **Description**                                                                                                                 |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| TM\_HC\_DEGRADED                    | Overall status: some parts work and some do not, or one is slow.                                                                      |
| TM\_HC\_DOWN                        | Overall status: nothing works.                                                                                                        |
| TM\_HC\_CONFIG\_UNRESOLVED          | No address could be resolved from `receiver.urls` or `broker.urls`.                                                               |
| TM\_HC\_PORT\_CLOSED                | Port is not reachable.                                                                                                                |
| TM\_HC\_TLS\_FAILED                 | Secure connection failed.                                                                                                             |
| TM\_HC\_LOGIN\_FAILED               | Login failed, or no `username` and `password` are configured. A rejected login is not repeated (see `login.retry.interval.ms`). |
| TM\_HC\_PUBLISH\_FAILED             | Test message was not accepted.                                                                                                        |
| TM\_HC\_TIMEOUT                     | No answer in time.                                                                                                                    |
| TM\_HC\_UNEXPECTED\_ERROR           | Unexpected error during the check. See the server log.                                                                                |
| TM\_HC\_STREAM\_UNDEFINED           | Health check stream is not deployed.                                                                                                  |
| TM\_HC\_SESSION\_EXPIRED            | Login session was rejected.                                                                                                           |
| TM\_HC\_NOT\_ATTEMPTED              | Not attempted, because the login step failed first.                                                                                   |
| TM\_HC\_CONNECT\_FAILED             | Could not connect to the broker.                                                                                                      |
| TM\_HC\_THREAD\_POOL\_SIZE\_UNKNOWN | The receiver's thread pool sizes could not be read.                                                                                   |
| TM\_HC\_SUBSCRIBE\_FAILED           | Could not subscribe to the health check topic.                                                                                        |
| TM\_HC\_NOT\_RECEIVED               | Test message was not delivered back in time.                                                                                          |
| TM\_HC\_PROBE\_POOL\_EXHAUSTED      | Every probe thread is busy with an earlier probe that has not finished (see `probe.max.threads`).                                   |

### Step 4 - Invoke the Health Checker API

1. Start WSO2 API Manager.
2. Send a GET request to the health check API.

   A sample cURL command is shown below.

   ```java
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
    enable = false
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

    ``java     {           "errors":[               {                   "code":"HC_00001",                 "message":"Error while getting database connection for datasource: jdbc/DISCONNECTED",                 "description":"Network is unreachable (connect failed)"             },             {                   "code":"HC_00003",                 "message": "Error while checking the health of USM with domain: SEC",                 "description":"Access denied for user 'root'@'localhost' (using password: YES)"             }         ]     }    ``

| **Error Code** | **Description**                                                                      |
| -------------------- | ------------------------------------------------------------------------------------------ |
| HC\_00001            | Data source connectivity error.                                                            |
| HC\_00002            | Number of connections in data source exceeds the healthy percentage.                       |
| HC\_00003            | Error while testing connectivity to the user store using the `isExistingUser` operation. |
| HC\_00004            | Server status is not running.                                                              |
| HC\_00005            | Error listing user stores.                                                                 |

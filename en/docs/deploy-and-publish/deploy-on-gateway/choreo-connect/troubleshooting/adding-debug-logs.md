## Enable Debug and Trace Logs

It is possible to troubleshoot Choreo Connect using debug logs and trace logs. Debug logs can be enabled in all three components and access logs can be enabled at the Router and Enforcer to trace requests from the Router to the Enforcer. The following sections will guide you through how to enable debug and access logs in each component.

### Adapter

Set the log level as `DEBG` in the `log_config.toml` as described in [Adapter log configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-adapter/#adapter-log-configurations) to enable debug logs in the Adapter.

If you need debug logs to be only enabled in package level, set the log level as `DEBG` only in the relavant [package level configuration]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-adapter/#adapter-package-level-configurations).

### Enforcer

Configure `log4j2.properties` file and make the value of `rootLogger.level` as `DEBUG` will enable debug logs as well as access logs in enforcer. Refer [enforcer log configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#enforcer-log-configurations) for more details.

!!! Note
    If you want to enable debug logs and access logs seperately, you need to define a new logger. For more information refer to [Configuring Log4j2 Loggers]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#configuring-log4j2-loggers).

The access log format will be as follows. It will print the server time, trace Id from Envoy, gRPC service method, gRPC status code, and response time according to the above configuration.

```yaml
[2022-04-03 18:29:45,032] - [id: 0xe5e8976f, L:/172.20.0.4:8081 - R:/172.20.0.5:48158] INBOUND HEADERS: streamId=5 headers=GrpcHttp2RequestHeaders[:path: /envoy.service.auth.v3.Authorization/Check, :authority: ext-authz, :method: POST, :scheme: http, te: trailers, grpc-timeout: 20000m, content-type: application/grpc, x-envoy-internal: true, x-forwarded-for: 172.20.0.5, x-envoy-expected-rq-timeout-ms: 20000] padding=0 endStream=false
```

### Router

Perform the relavant configurations in the `log_config.toml` according to the instructions given in [Router Access Logging]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-router/#router-access-logging).

In order to enable debug logs, follow the instructions provided in [Router Debug Logs]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-router/#router-debug-logs).

To enable wire logs, follow the instructions provided in [Router Wire Logs]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-router/#router-wire-logs).

## Admin portal

The admin interface can be used to view statistics, envoy configurations, etc. For more information, please follow [Envoy admin interface]({{envoy_path}}/start/quick-start/admin)
Configure host and port for the envoy admin interface and expose it.

!!! note
    This endpoint is not protected with authentication, hence ensure to restrict access to this address in your network infrastructure.   

For example, provide following to the docker-compose.yaml in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/`.

```yaml
  router:
    environment:
      - ROUTER_ADMIN_HOST=0.0.0.0
      - ROUTER_ADMIN_PORT=9000
    ports:
      - "9000:9000"  
```

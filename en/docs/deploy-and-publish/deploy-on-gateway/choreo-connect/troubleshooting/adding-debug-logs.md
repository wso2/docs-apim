# Adding Debug and Trace Logs

Following explain how to add debug and trace logs for the main three components of the Choreo Connect which are Adapter, Enforcer and Router.

## Adapter

### Enable debug logs

Set the log level as `DEBG` in the `log_config.toml` in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`, as described in [adapter log configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-adapter/#adapter-root-level-configurations). If you need debug logs to be only enables in package level, set the log level as `DEBG` only in the relavant [package level configuration]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-adapter/#adapter-package-level-configurations).

## Enforcer

### Enable debug logs

Configure `log4j2.properties` located in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.
Make relevant packages to `DEBUG` level, as mentioned in [enforcer log configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#setting-the-log-level).

```yaml
logger.enforcer.level = DEBUG
```

### Enable access logs

Configure `log4j2.properties` located in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.

By making the value `logger.mgw-enforcer-interceptors.level` to `DEBUG` in the below configuration will enable access logs without restarting the enforcer.

```yaml
logger.mgw-enforcer-interceptors.level = DEBUG
```


The access log format will be as follow. It will print the server time, trace Id from envoy, gRPC service method, gRPC status code, response time according to the above configuration.

```yaml
[2021-02-19 07:48:49,505] - 5920896249661898188 envoy.service.auth.v3.Authorization/Check 16 34
[2021-02-19 07:48:52,592] - 17895662172888229144 envoy.service.auth.v3.Authorization/Check 16 7
```

## Router

### Enable access logs.

Configure the following in the `log_config.toml` in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.
Please follow [command operators]({{envoy_path}}/configuration/observability/access_log/usage#command-operators) for more information on the supported options for log format, `format` configuration.  

```toml
[accessLogs]
enable = false
logfile = "/tmp/envoy.access.log" # This file will be created inside router container.
format = "[%START_TIME%] '%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%' %RESPONSE_CODE% %RESPONSE_FLAGS% %BYTES_RECEIVED% %BYTES_SENT% %DURATION% %RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)% '%REQ(X-FORWARDED-FOR)%' '%REQ(USER-AGENT)%' '%REQ(X-REQUEST-ID)%' '%REQ(:AUTHORITY)%' '%UPSTREAM_HOST%'\n"
```

### Enable debug logs

Provide the log level as trailing arguments for the envoy command as follows.

```toml tab="Format"
-l <level>, 
--log-level <level>
--component-log-level <component>:<level>,<component>:<level>...
```

```toml tab="Example"
-l trace, 
--log-level trace
--component-log-level upstream:debug,connection:trace
```

Please follow [Command line options]({{envoy_path}}/operations/cli) for more information.

For example, Add following line to the docker-compose.yaml in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/`.

```yaml
  router:
    environment:
      - TRAILING_ARGS=--log-level trace
```

### Admin portal

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

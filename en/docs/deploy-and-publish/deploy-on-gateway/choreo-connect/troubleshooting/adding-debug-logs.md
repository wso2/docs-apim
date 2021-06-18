# Adding Debug and Trace Logs

Following explain how to add debug and trace logs for the main three components of the Choreo Connect which are Adapter, Enforcer and Router.

## Adapter

### Enable debug logs

Configure the logging in the `log_config.toml` in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.

The following log levels are supported at root and package level. 
"INFO", "WARN", "DEBG", "FATL", "ERRO", "PANC"

Additionally, log rotation can be configured as follows for adapter logs.

```toml
## Adapter root Level configurations

logfile = "logs/adapter.log" # This file will be created inside adapter container.
logLevel = "INFO"

[rotation]
MaxSize = 10 # In MegaBytes (MB)
MaxBackups = 3
MaxAge =  2   # In days
Compress = true

## Adapter package Level configurations

[[pkg]]
name = "github.com/wso2/adapter/internal/adapter"
logLevel = "INFO"

[[pkg]]
name = "github.com/wso2/adapter/internal/oasparser"
logLevel = "INFO"
```

## Enforcer

### Enable debug logs

Configure `log4j2.properties` located in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.
Make relevant packages to `DEBUG` level.

```yaml
logger.enforcer.level = DEBUG
```

```yaml
appender.ENFORCER_LOGFILE.fileName = logs/enforcer.log
appender.ENFORCER_LOGFILE.filePattern = /logs/enforcer-%d{MM-dd-yyyy}.log
appender.ENFORCER_LOGFILE.layout.type = PatternLayout
appender.ENFORCER_LOGFILE.layout.pattern = [%d][%X{traceId}] %5p - %m%ex%n
...
```

### Enable access logs

Configure `log4j2.properties` located in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.

By making the value `logger.mgw-enforcer-interceptors.level` to `DEBUG` in the below configuration will enable access logs without restarting the enforcer.

```yaml
logger.mgw-enforcer-interceptors.level = DEBUG
```

```yaml
appender.MGW_ACCESS_LOG.fileName = logs/enforcer_access.log # This file will be created inside enforcer container.
appender.MGW_ACCESS_LOG.filePattern = /logs/enforcer_access-%d{MM-dd-yyyy}.log
appender.MGW_ACCESS_LOG.layout.type = PatternLayout
appender.MGW_ACCESS_LOG.layout.pattern = [%d] - %m%ex%n # Log pattern
...
```

The access log format will be as follow. It will print the server time, trace Id from envoy, gRPC service method, gRPC status code, response time according to the above configuration.

```yaml
[2021-02-19 07:48:49,505] - 5920896249661898188 envoy.service.auth.v3.Authorization/Check 16 34
[2021-02-19 07:48:52,592] - 17895662172888229144 envoy.service.auth.v3.Authorization/Check 16 7
```

## Router

### Enable access logs.

Configure the following in the `log_config.toml` in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.
Please follow [command operators](https://www.envoyproxy.io/docs/envoy/v1.17.0/configuration/observability/access_log/usage#command-operators) for more information on the supported options for log format, `format` configuration.  

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

Please follow [Command line options](https://www.envoyproxy.io/docs/envoy/v1.17.0/operations/cli) for more information.

For example, Add following line to the docker-compose.yaml in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/`.

```yaml
router:
    command: ["/usr/local/bin/envoy", "-c /etc/envoy.yaml", "-l", "trace"]
```

### Admin portal

The admin interface can be used to view statistics, envoy configurations, etc. For more information, please follow [Envoy admin interface](https://www.envoyproxy.io/docs/envoy/v1.17.0/start/quick-start/admin)
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

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

For example, Add following line to the docker-compose.yaml in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/`. 

```yaml
  router:
    environment:
      - TRAILING_ARGS=--log-level trace
```
The following example configuration can log request headers and response headers.

```yaml
  router:
    environment:
      - TRAILING_ARGS=TRAILING_ARGS=--component-log-level http:debug,http2:debug,conn_handler:debug
```
Example log of request headers and repsonse headers is given below.

Client to router request headers
```yaml
[2022-04-07 06:27:50.056][15][debug][http] [source/common/http/conn_manager_impl.cc:867] [C23][S16704314296340818822] request headers complete (end_stream=false):
':authority', 'localhost:9095'
':path', '/v2/1.0.6/pet/findByStatus?status=available'
':method', 'GET'
'authorization', 'Bearer eyJ4NXQiOiJOMkpqTWpOaU0yRXhZalJrTnpaalptWTFZVEF4Tm1GbE5qZzRPV1UxWVdRMll6YzFObVk1TlEiLCJraWQiOiJNREpsTmpJeE4yRTFPR1psT0dWbU1HUXhPVEZsTXpCbU5tRmpaalEwWTJZd09HWTBOMkkwWXpFNFl6WmpOalJoWW1SbU1tUTBPRGRpTkRoak1HRXdNQV9SUzI1NiIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJhZG1pbiIsImF1dCI6IkFQUExJQ0FUSU9OIiwiYXVkIjoiaWxBRkJNcVBPRVp6YVMzYkM0ajRTZEc5SU9jYSIsIm5iZiI6MTY0OTMxMjUyNywiYXpwIjoiaWxBRkJNcVBPRVp6YVMzYkM0ajRTZEc5SU9jYSIsInNjb3BlIjoicmVhZDpwZXRzIHdyaXRlOnBldHMiLCJpc3MiOiJodHRwczpcL1wvYXBpbTo5NDQ0XC9vYXV0aDJcL3Rva2VuIiwiZXhwIjoxNjQ5MzE2MTI3LCJpYXQiOjE2NDkzMTI1MjcsImp0aSI6IjI4YTU0YmE3LWIwMzAtNDMyNS05N2QzLWU5MGJmM2I1ZWRkYSJ9.QiLKUnfdO27kiAbY_tzldDQjG28RGgPJ79jC8YDIeK-6XGzGssD_mx-lZeJzyR3CZDqqqqWEK5W08EZb_V3KI7kt6U6LbazPt8IQz7DfrLeEgFWVKTTHvmcgUkOW1XDLTISg053Jeg9xcv36qG-k4SEGRQRO9U31xegj2nZnZGQm7vPB2T6TLTXbqnKI720JupVinYIumXhpFkWQ1hTA4FdyYaPVtRNrwfEmOHd7YYKO467xSg8lTttIlRL2tkWDsOH4HC5U7TsfCVhKV2TNDZLKAtVWQXlQSktWQdyVirxTGs5-iDyKYQaMzORxbt6Dpyw9Tb5V2YYPGh_WmtIhyw'
'content-type', 'application/json'
'user-agent', 'PostmanRuntime/7.29.0'
'accept', '*/*'
'postman-token', '4b437f9d-f56a-46dd-bbcc-151264008049'
'accept-encoding', 'gzip, deflate, br'
'connection', 'keep-alive'
'content-length', '35'
```

Router to client response headers
```yaml
[2022-04-07 06:27:51.851][15][debug][http] [source/common/http/conn_manager_impl.cc:1467] [C23][S16704314296340818822] encoding headers via codec (end_stream=false):
':status', '200'
'date', 'Thu, 07 Apr 2022 06:27:51 GMT'
'content-type', 'application/json'
'access-control-allow-origin', '*'
'access-control-allow-methods', 'GET, POST, DELETE, PUT'
'access-control-allow-headers', 'Content-Type, api_key, Authorization'
'server', 'envoy'
'x-envoy-decorator-operation', 'localhost:^/v2/1.0.6/pet/findByStatus(\?([^/]+))?$'
```

Please follow [Command line options]({{envoy_path}}/operations/cli) for more information.

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

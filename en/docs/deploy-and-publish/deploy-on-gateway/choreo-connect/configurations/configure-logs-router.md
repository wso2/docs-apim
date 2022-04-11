# Router Log Configurations

As Choreo Connect uses envoy proxy as the router component, it only supports the logging mechanisms provided by envoy proxy ([Read more details about router]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/choreo-connect-overview/#router)). In the folllowing sections you may find how to enable router access logs and debug logs.

## Router Access Logging

You can enable router access logs by using the following configs. Router access logs related configurations are in the `log_config.toml` file which is located in the [these directories]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-overview/#log_config_toml) based on your Choreo Connect deployment method.

```toml tab="Format"
[accessLogs]
enable = <true or false>
logfile = <file_path> # This file will be created inside router container.
format = <format_string>
```

```toml tab="Example"
[accessLogs]
enable = true
logfile = "/tmp/envoy.access.log"
format = "[%START_TIME%] '%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%' %RESPONSE_CODE% %RESPONSE_FLAGS% %BYTES_RECEIVED% %BYTES_SENT% %DURATION% %RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)% '%REQ(X-FORWARDED-FOR)%' '%REQ(USER-AGENT)%' '%REQ(X-REQUEST-ID)%' '%REQ(:AUTHORITY)%' '%UPSTREAM_HOST%'\n"
```

Setting `enable` flas as `true` will let you enable the router access logs and the file path can be setup using the `logfile`. Please follow [format strings]({{envoy_path}}configuration/observability/access_log/usage#format-strings) and [command operators]({{envoy_path}}/configuration/observability/access_log/usage#command-operators) for more information on the supported options for log format, `format` configuration.

## Router debug logs

To enable router debug logs, provide the log level as trailing arguments for the envoy command as follows.

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

You can do this by setting `TRAILING_ARGS` environment variable in router. For example, Add following line to the docker-compose.yaml in the directory `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/`.

```yaml
  router:
    environment:
      - TRAILING_ARGS=--log-level trace
```

### Log Request and Response headers

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

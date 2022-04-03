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

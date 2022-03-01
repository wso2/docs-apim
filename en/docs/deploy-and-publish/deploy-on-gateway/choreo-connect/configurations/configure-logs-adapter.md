# Adapter Log Configurations

The log configurations for adapter are located in the log_config.toml file in the directory of `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect>/conf/`.

## Adapter root level configurations

The following configurations will allow you to configure root level configurations in adapter logs.

``` toml
## Adapter root Level configurations

logfile = "logs/adapter.log" # This file will be created inside the adapter container.
logLevel = "INFO" # LogLevels can be "DEBG", "FATL", "ERRO", "WARN", "INFO", "PANC"
LogFormat = "TEXT" # Values can be "JSON", "TEXT"
```

`LogFormat` can be used to set the format of the logs printed. Following are some examples for the logs in both formats.

TEXT

``` text
2022-02-24 11:45:18 ERRO [subscription.go:138] - [eventhub.LoadSubscriptionData] [-] Error occurred while fetching data from control plane: Get "https://apim:9443/internal/data/v1/subscriptions": dial tcp 127.0.0.1:9443: connect: connection refused [severity=Major error_code=1601]
```

JSON
``` json
{"error_code":1601,"file":"subscription.go:138","func":"eventhub.LoadSubscriptionData","level":"error","msg":"Error occurred while fetching data from control plane: Get \"https://apim:9443/internal/data/v1/subscriptions\": dial tcp 127.0.0.1:9443: connect: connection refused","severity":"Major","time":"2022-02-24 12:09:49"}
```

Additionally, you can set the log file rotation for adapter can be configured using the following configs.

``` toml
[rotation]
MaxSize = 10 # In MegaBytes (MB)
MaxBackups = 3
MaxAge =  2   # In days
Compress = true
```

## Adapter package level configurations

Following configurations can be used to override the root level configurations in package level.

``` toml
## Adapter package Level configurations

[[pkg]]
name = "github.com/wso2/product-microgateway/adapter/internal/adapter"
logLevel = "INFO" # LogLevels can be "DEBG", "FATL", "ERRO", "WARN", "INFO", "PANC"

[[pkg]]
name = "github.com/wso2/product-microgateway/adapter/internal/oasparser"
logLevel = "INFO"
```

!!! note
    `LogFormat` cannot be configured at package level

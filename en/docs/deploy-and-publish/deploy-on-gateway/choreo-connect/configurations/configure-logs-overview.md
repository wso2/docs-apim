# Overview

Logging in Choreo Connect is really important when debugging issues in a short period of time and looking into the underlying details of how each component works.  Choreo Connect provides facilities for getting the logs in various formats (JSON, Plain text), various output methods and various logging levels.

## Log Configurations

There are two main configuration files used by Choreo Connect for the logging purposes.

- log_config.toml - This will be using for the log configurations related to `adapter` and `router`.
- log4j2.properties - This will be using for the log configurations related to `enforcer`.

These files are located in the following locations based on your Choreo Connect deployment architecture.

<a name="log_config_toml"></a>

**log_config.toml**

| **Deployment** | **File name** | **Directory** |
|----------------|---------------|---------------|
| Docker Compose - Choreo Connect in standalone mode | `log_config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/` |
| Docker Compose - Choreo Connect with WSO2 API Manager | `log_config.toml` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/` |
| k8s - Choreo Connect in standalone mode | `logconfig-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/` |
| k8s - Choreo Connect with WSO2 API Manager | `logconfig-toml-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/` |

**log4j2.properties**

<a name="log4j2_properties"></a>

| **Deployment** | **File name** | **Directory** |
|----------------|---------------|---------------|
| Docker - Choreo Connect in standalone mode | `log4j2.properties` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/` |
| Docker - Choreo Connect with WSO2 API Manager | `log4j2.properties` | `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/` |
| k8s - Choreo Connect in standalone mode | `log4j2-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect/` |
| k8s - Choreo Connect with WSO2 API Manager | `log4j2-configmap.yaml` | `<CHOREO-CONNECT_HOME>/k8s-artifacts/choreo-connect-with-apim/` |

## Error Codes in Logs 

In addition to these, the adapter and enforcer components have been defined with a set of error codes for each of the components’ error logs, in order to uniquely identify application errors. Following are the error codes ranges for each of the components.

- Adapter error codes range from 1000 to 4999.
- Enforcer error codes range from 5000 to 8999.


## See Also

Here is a summary of topics that will be covered under this log configurations section.

- [Adapter Log Configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-adapter/)
    - [Adapter root level configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-adapter#adapter-root-level-configurations)
    - [Adapter package level configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-adapter#adapter-package-level-configurations)

- [Enforcer Log Configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer)
    - [Configuring Log4j2 Properties]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#configuring-log4j2-properties)
        - [Setting the Log Level]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#setting-the-log-level)
        - [Setting the Threshold]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#setting-the-threshold)
        - [Configuring Log4j2 Appenders]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#configuring-log4j2-appenders)
        - [Configuring Log4j2 Loggers]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#configuring-log4j2-loggers)
    - [Enforcer Access Logs]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#enforcer-access-logs)
    - [Setting the log format]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#setting-the-log-format)
        - [Plain Text format]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#plain-text-format)
        - [JSON format]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-enforcer/#json-format)

- [Router Log Configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-router/#router-log-configurations)
    - [Router Access Logging]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-router/#router-access-logging)
    - [Router Debug Logs]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/configure-logs-router/#router-debug-logs)

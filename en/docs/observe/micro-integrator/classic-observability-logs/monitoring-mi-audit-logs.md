---
title: Monitoring Audit Logs - WSO2 API Manager 4.2.0
---

# Monitoring Audit Logs in Micro Integrator

Auditing is a primary requirement when it comes to monitoring production servers. For example, DevOps needs to have a clear mechanism to identify who did what, and to filter possible system violations or breaches. Audit Logs or Audit Trails contain a set of log entries that describe a sequence of actions that occurred over a period of time. Audit Logs allow you to trace all the actions of a single user, or all the actions or changes introduced to a certain module in the system etc. over a period of time. For example, it captures all the actions of a single user from the first point of logging in to the server.

By default, the Audit Logs that get created when running WSO2 Micro Integrator are stored in the `audit.log` file, which is located in the `<MI_HOME>/repository/logs` directory.

## Configuring Audit Logs

Audit logs are enabled by default in WSO2 Micro Integrator (WSO2 MI) via the following configurations, which are in the `<MI_HOME>/conf/log4j2.properties` file.

```
appender.AUDIT_LOGFILE.type = RollingFile
appender.AUDIT_LOGFILE.name = AUDIT_LOGFILE
appender.AUDIT_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/audit.log
appender.AUDIT_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/audit-%d{MM-dd-yyyy}.log
appender.AUDIT_LOGFILE.layout.type = PatternLayout
appender.AUDIT_LOGFILE.layout.pattern = [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
appender.AUDIT_LOGFILE.policies.type = Policies
appender.AUDIT_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
appender.AUDIT_LOGFILE.policies.time.interval = 1
appender.AUDIT_LOGFILE.policies.time.modulate = true
appender.AUDIT_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
appender.AUDIT_LOGFILE.policies.size.size=10MB
appender.AUDIT_LOGFILE.strategy.type = DefaultRolloverStrategy
appender.AUDIT_LOGFILE.strategy.max = 20
appender.AUDIT_LOGFILE.filter.threshold.type = ThresholdFilter
appender.AUDIT_LOGFILE.filter.threshold.level = INFO
```

The log growth of Audit Logs can be managed by using the configurations that are discussed in the [Managing Log Growth]({{base_path}}/administer/logging-and-monitoring/logging/managing-log-growth) guide.

## Audit Log actions

In WSO2 MI, Audit Logs are availble with the management API where you can monitor the changes that happened to the MI instance.


| Action                   | Sample Format                                                                                                                                                                                                                                                     |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Sign in | `[2017-06-07 22:26:22,506]  INFO -  admin logged in at [2017-06-07 22:26:22,501+0530]`|
| Sign out            | `[2017-06-07 22:26:22,506]  INFO -  admin logged out at [2017-06-07 22:26:22,501+0530]`|
| Add user            | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: “created”,  “type”: “user”, “info” : “{\“userId\” : \“user4\”,\“isAdmin\”: \“true\”}”}` |
| Remove user            | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: “deleted”,  “type”: “user”, “info” : “{\“userId\”: \“user4\”}”}`|
| Activate/Deactivate proxy service | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: “enabled”,  “type”: “proxy_service”, “info” : “{\“proxyName\”: \“proxy1\”}”}` |
| Enable/Disable message tracing for proxy service | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: “enabled”,  “type”: “proxy_service_trace”, “info” : “{\“proxyName\”: \“proxy1\”}”}` |
| Add Carbon application | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: “created”,  “type”: "carbon_application", “info” : “{\“cAppfileName\”: \“abc.car\”}”}` |
| Remove Carbon application | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "deleted",  “type”: "carbon_application", “info” : “{\“cAppfileName\”: \“abc.car\”}”}` |
| Activate/Deactivate endpoint | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "enabled",  “type”: "endpoint", “info” : “{\“endpointName\”: \“httpEP\”}”}` |
| Enable/Disable message tracing for endpoint | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "enabled",  “type”: "endpoint_trace", “info” : “{\“endpointName\”: \“httpEP\”}”}` |
| Enable/Disable message tracing for API | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "enabled",  “type”: "api_trace", “info” : “{\“apiName\”: \“helloAPI\”}”}` |
| Enable/Disable message tracing for sequence | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "enabled",  “type”: "sequence_trace", “info” : “{\“sequenceName\”: \“helloSequence\”}”}` |
| Activate/Deactivate message processor | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "enabled",  “type”: "message_processor", “info” : “{\“messageProcessorName\”: \“processor1\”}”}` |
| Enable/Disable message tracing for inbound endpoint | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "enabled",  “type”: "inbound_endpoint_trace", “info” : “{\“inboundEndpointName\”: \“httpIEP\”}”}` |
| Enable/Disable message tracing for sequence template | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "enabled",  “type”: "sequence_template_trace", “info” : “{\“sequenceName\”: \“sequenceTemplate\”,\“sequenceType\”: “sequence\”}”}` |
| Update log level | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "updated",  “type”: "log_level", “info” : “{\“loggerName\”: \“org-apache-hive\”,\“loggingLevel\”: “WARN}”}` |
| Add new logger | `[2021-09-07 12:42:59,249]  INFO {AUDIT_LOG} - { “performedBy”: “admin”, “action”: "created",  “type”: "logger", “info” : {“loggerName”: “synapse-api”,\“loggingLevel\”: \“DEBUG\”,\“loggerClass\”: \“org.apache.rest.API\”}}` |

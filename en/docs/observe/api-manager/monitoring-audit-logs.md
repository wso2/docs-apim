# Monitoring Audit Logs

Auditing is a primary requirement when it comes to monitoring production servers. For example, DevOps need to have a clear mechanism for identifying who did what, and to filter possible system violations or breaches.
Audit logs or audit trails contain a set of log entries that describe a sequence of actions that occurred over a period of time. Audit logs allow you to trace all the actions of a single user or all the actions or changes introduced to a certain module in the system, etc., over a period of time. For example, it captures all the actions of a single user from the first point of logging in to the server. 
By default, the audit logs that get created when running WSO2 API-M are stored in the `audit.log` file, which is located in the `<API-M_HOME>/repository/logs` directory.

## Configuring Audit Logs

Audit logs are enabled by default in WSO2 API Manager (WSO2 API-M) via the following configurations, which are in the `<API-M-HOME>/repository/conf/log4j2.properties` file. 

``` 
appender.AUDIT_LOGFILE.type = RollingFile
appender.AUDIT_LOGFILE.name = AUDIT_LOGFILE
appender.AUDIT_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/audit.log
appender.AUDIT_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/audit-%d{MM-dd-yyyy}.log
appender.AUDIT_LOGFILE.layout.type = PatternLayout
appender.AUDIT_LOGFILE.layout.pattern = TID: [%tenantId] [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
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

The log growth of audit logs can be managed by the configurations discussed in [Managing log growth]({{base_path}}/administer/logging-and-monitoring/logging/managing-log-growth) guide.
   
## Audit log actions

In WSO2 API-M, audit logs can be enabled for the following user actions in the Publisher and Developer Portal.

### Publisher

| Action                   | Sample Format                                                                                                                                                                                                                                                     |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Sign in to the Publisher | `[2017-06-07 22:26:22,506]  INFO -  'devona@carbon.super [-1234]' logged in at [2017-06-07 22:26:22,501+0530]`|
| Create an API            | `[2017-06-07 22:28:06,027]  INFO -  {"performedBy":"admin","action":"created","typ":"API","info":"{\"provider\":\"admin\",\"name\":\"PhoneVerification\",\"context\":\"\\\/phoneverify\\\/1.0.0\",\"version\":\"1.0.0\"}"}`|
| Update an API            | `[2017-06-08 10:22:49,657]  INFO -  {"performedBy":"admin","action":"updated","typ":"API","info":"{\"provider\":\"admin\",\"name\":\"PhoneVerification\",\"context\":\"\\\/phoneverify\\\/1.0.0\",\"version\":\"1.0.0\"}"}` |
| Delete an API            | `[2017-06-08 10:15:55,369]  INFO -  {"performedBy":"admin","action":"deleted","typ":"API","info":"{\"provider\":\"admin\",\"name\":\"PhoneVerification\",\"version\":\"1.0.0\"}"}`|

### Developer Portal

| Action                          | Sample Format                                                                                                                                                                                                                                                                         |
|---------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Sign in to the Developer Portal            | `[2017-06-07 22:34:54,684]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-06-07 22:34:54,682+0530]`|
| Sign up via the Developer Portal          | `[2017-06-07 22:55:34,054]  INFO -  Initiator : admin@carbon.super | Action : Update Roles of User | Target : Kimmmy | Data : { Roles : [] } | Result : Success`|
| Create an application           | `[2017-06-07 22:40:17,625]  INFO -  {"performedBy":"admin","action":"created","typ":"Application","info":"{\"tier\":\"20PerMin\",\"name\":\"TestApp\",\"callbackURL\":null}"}`|
| Update an application           | `[2017-06-07 22:44:25,931]  INFO -  {"performedBy":"admin","action":"updated","typ":"Application","info":"{\"tier\":\"20PerMin\",\"name\":\"MobileApp\",\"callbackURL\":\"\",\"status\":\"APPROVED\"}"}`|
| Delete an application           | `[2017-06-07 22:45:59,093]  INFO -  {"performedBy":"admin","action":"deleted","typ":"Application","info":"{\"tier\":\"20PerMin\",\"name\":\"MobileApp\",\"callbackURL\":\"\"}"}`|
| Subscribe to an application     | `[2017-06-07 22:36:48,826]  INFO -  {"performedBy":"admin","action":"created","typ":"Subscription","info":"{\"application_name\":\"DefaultApplication\",\"tier\":\"Gold\",\"provider\":\"admin\",\"api_name\":\"PhoneVerification\",\"application_id\":1}"}` |
| Unsubscribe from an application | `[2017-06-07 22:38:08,277]  INFO -  {"performedBy":"admin","action":"deleted","typ":"Subscription","info":"{\"application_name\":\"DefaultApplication\",\"provider\":\"admin\",\"api_name\":\"PhoneVerification\",\"application_id\":1}"}`|


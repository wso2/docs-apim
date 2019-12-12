# Upgrading to Log4j2

From kernel 4.5.x onwards the carbon.logging jar is not packed and the pax-logging-api is used instead. With this upgrade the log4j version is also upgraded to log4j2.

Refer to the following steps for upgrading to log4j2.

1.  Replace carbon logging or commons.logging dependencies with pax-logging dependency.

     ```
     <!-- Pax Logging -->
     <dependency>
        <groupId>org.ops4j.pax.logging</groupId>
        <artifactId>pax-logging-api</artifactId>
        <version>${pax.logging.api.version}</version>
     </dependency>
    
     <!-- Pax Logging Version -->
     <pax.logging.api.version>1.10.1</pax.logging.api.version>
     ```

2.  If log4j dependency is directly used,
    
     ``` tab="Option 1"
     Replace log4j dependency with log4j2 dependency and rewrite the loggers accordingly.
    
     <dependency>
        <groupId>org.ops4j.pax.logging</groupId>
        <artifactId>pax-logging-log4j2</artifactId>
         <version>${pax.logging.log4j2.version}</version>
     </dependency>
     ```
    
     ``` tab="Option 2"
     Replace log4j dependency with pax-logging dependency and rewrite the loggers using commons.logging accordingly.   
     ```

3.  If commons.logging is imported using Import-Package add the version range.

     ```
     org.apache.commons.logging; version="${commons.logging.version.range}"
     <commons.logging.version.range>[1.2.0,2.0.0)</commons.logging.version.range>
     ```
    
4.  Change appenders in the log4j2.properties file and add the appender to the appenders list.
    
     ```
     appender.CARBON_LOGFILE.type = RollingFile
     appender.CARBON_LOGFILE.name = CARBON_LOGFILE
     appender.CARBON_LOGFILE.fileName = ${sys:carbon.home}/repository/logs/wso2carbon.log
     appender.CARBON_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2carbon-%d{MM-dd-yyyy}.log
     appender.CARBON_LOGFILE.layout.type = PatternLayout
     appender.CARBON_LOGFILE.layout.pattern = TID: [%tenantId] [%appName] [%d] %5p {% raw %}{%c}{% endraw %} - %m%ex%n
     appender.CARBON_LOGFILE.policies.type = Policies
     appender.CARBON_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
     appender.CARBON_LOGFILE.policies.time.interval = 1
     appender.CARBON_LOGFILE.policies.time.modulate = true
     appender.CARBON_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
     appender.CARBON_LOGFILE.policies.size.size=10MB
     appender.CARBON_LOGFILE.strategy.type = DefaultRolloverStrategy
     appender.CARBON_LOGFILE.strategy.max = 20
     appender.CARBON_LOGFILE.filter.threshold.type = ThresholdFilter
     appender.CARBON_LOGFILE.filter.threshold.level = DEBUG

     appenders = CARBON_LOGFILE, CARBON_CONSOLE, AUDIT_LOGFILE, ATOMIKOS_LOGFILE, CARBON_TRACE_LOGFILE, CARBON_MEMORY, 
     DELETE_EVENT_LOGFILE, TRANSACTION_LOGFILE
     ```

5.  Add logger in the log4j2.properties file and add the logger to the loggers list.

     ```
     logger.<Logger_Name>.name = <Component_name>
     logger.<Logger_Name>.level = INFO
     ```
    
     Then add the <Logger_Name> to the loggers list by comma-separate.

     ```
     logger.org-wso2-carbon-identity-core.name = org.wso2.carbon.identity.core
     logger.org-wso2-carbon-identity-core.level = INFO
    
     loggers = org-wso2-carbon-identity-core, trace-messages, org-apache-coyote,com-hazelcast
     ``` 
    
# Monitoring Service-Level Logs

The advantage of having per-service log files is that it is very easy to analyze/monitor what went wrong in this particular service (proxy service, data service etc.) by looking at the service log. Enabling this feature will not terminate the `wso2carbon.log` file. This file will contain the complete log with every log statement, including the service logs that you have configured to be logged into a different log file. In other words, the service log is an additional log file, which will contain a copy of the logs to that particular service.

## Enabling log4j2 for a service

Follow the instructions below to enable log4j2 logs for a sample proxy service (named `StockQuoteProxy`). 

1.  Open up the `log4j2.properties` file (stored in the `<MI_HOME>/conf` directory. 
2.  Let's define a new appender for the `StockQuoteProxy` service by adding the following section to the end of the file (starting in a new line).

    !!! Note
        This configuration creates a log file named  `stock-quote-proxy-service.log` in the `<MI_HOME>/repository/logs` folder.

    ```bash
    # SQ_PROXY_APPENDER is set to be a DailyRollingFileAppender using a PatternLayout.
    appender.SQ_PROXY_APPENDER.type = RollingFile
    appender.SQ_PROXY_APPENDER.name = SQ_PROXY_APPENDER
    appender.SQ_PROXY_APPENDER.fileName = ${sys:carbon.home}/repository/logs/stock-quote-proxy-service.log
    appender.SQ_PROXY_APPENDER.filePattern = ${sys:carbon.home}/repository/logs/stock-quote-proxy-service-%d{MM-dd-yyyy}.log
    appender.SQ_PROXY_APPENDER.layout.type = PatternLayout
    appender.SQ_PROXY_APPENDER.layout.pattern = TID: [%d] %5p {% raw %}{%c}{% endraw %} [%logger] - %m%ex%n
    appender.SQ_PROXY_APPENDER.policies.type = Policies
    appender.SQ_PROXY_APPENDER.policies.time.type = TimeBasedTriggeringPolicy
    appender.SQ_PROXY_APPENDER.policies.time.interval = 1
    appender.SQ_PROXY_APPENDER.policies.time.modulate = true
    appender.SQ_PROXY_APPENDER.policies.size.type = SizeBasedTriggeringPolicy
    appender.SQ_PROXY_APPENDER.policies.size.size=10MB
    appender.SQ_PROXY_APPENDER.strategy.type = DefaultRolloverStrategy
    appender.SQ_PROXY_APPENDER.strategy.max = 20
    appender.SQ_PROXY_APPENDER.filter.threshold.type = ThresholdFilter
    appender.SQ_PROXY_APPENDER.filter.threshold.level = DEBUG
    ```
    
3. Register the appender (named `SQ_PROXY_APPENDER`):
    
    ```xml
    appenders = CARBON_CONSOLE, CARBON_LOGFILE, AUDIT_LOGFILE, SQ_PROXY_APPENDER, 
    ```

4. Define a new logger to filter out `StockQuoteProxy` related logs:

    ```xml
    logger.StockQuoteProxy.name = SERVICE_LOGGER.StockQuoteProxy
    logger.StockQuoteProxy.level = INFO
    logger.StockQuoteProxy.appenderRef.SQ_PROXY_APPENDER.ref = SQ_PROXY_APPENDER
    logger.StockQuoteProxy.additivity = false
    ```

    !!! Info
        This particular logger is configured to rotate the file each minute whenever there is a log going into the service log. 

5.  Register the `StockQuoteProxy` logger:

    ```xml
    loggers = AUDIT_LOG, StockQuoteProxy, SERVICE_LOGGER,
    ```  

6.  Save the `log4j2.properties` file.

## Configuring the proxy service

The log4j2 configurations in the `log4j2.properties` file does not create logs for the proxy service by default. Add a <b>Log</b> mediator to the proxy service's in-sequence and configure it to log messages at `Full` log level.

## Dynamically changing log level

See the instructions on [updating the log level]({{base_path}}/observe/micro-integrator/classic-observability-logs/configuring-log4j2-properties/#updating-the-log4j2-log-level).

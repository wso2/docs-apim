# Monitoring API-Level Logs

The advantage of having per-API log files is that it is very easy to analyze/monitor what went wrong in a particular REST API defined in WSO2 Micro Integrator by looking at the log files. The API log is an additional log file, which will contain a copy of the logs to a particular REST API.

Below are the configuration details to configure the logs of a REST API called `TestAPI` using `log4j`
properties.

Open `<MI_HOME>/conf/log4j2.properties` file using your favorite text editor to configure `log4j` to log the API specific logs to a file. You can configure the logger for either INFO level logs or DEBUG level logs as follows:

## Enabling log4j for an API

Follow the instructions below to enable log4j2 logs for a sample REST API (named `TestAPI`). 

1.  Open up the `log4j2.properties` file (stored in the `<MI_HOME>/conf` ) directory. 
2.  Let's define a new appender for the `TestAPI` API by adding the following section to the end of the file (starting in a new line).

	!!! Note
        This configuration creates a log file named `TestAPI.log` in the folder `<MI_HOME>/repository/logs` folder.

	```bash
	# API_APPENDER is set to be a DailyRollingFileAppender using a PatternLayout.
	appender.API_APPENDER.type = RollingFile
	appender.API_APPENDER.name = API_APPENDER
	appender.API_APPENDER.fileName = ${sys:carbon.home}/repository/logs/TestAPI.log
	appender.API_APPENDER.filePattern = ${sys:carbon.home}/repository/logs/wso2-ei-api-%d{MM-dd-yyyy}.log
	appender.API_APPENDER.layout.type = PatternLayout
	appender.API_APPENDER.layout.pattern = TID: [%d] %5p {% raw %}{%c}{% endraw %} [%logger] - %m%ex%n
	appender.API_APPENDER.policies.type = Policies
	appender.API_APPENDER.policies.time.type = TimeBasedTriggeringPolicy
	appender.API_APPENDER.policies.time.interval = 1
	appender.API_APPENDER.policies.time.modulate = true
	appender.API_APPENDER.policies.size.type = SizeBasedTriggeringPolicy
	appender.API_APPENDER.policies.size.size=10MB
	appender.API_APPENDER.strategy.type = DefaultRolloverStrategy
	appender.API_APPENDER.strategy.max = 20
	appender.API_APPENDER.filter.threshold.type = ThresholdFilter
	appender.API_APPENDER.filter.threshold.level = INFO
	```

3. Register the appender (named `API_APPENDER`):
        
	```xml
	appenders = CARBON_CONSOLE, CARBON_LOGFILE, AUDIT_LOGFILE, API_APPENDER, 
	```

4. Define a new logger to filter out `TestAPI` related logs:

	```xml
	logger.API_LOG.name=API_LOGGER.TestAPI
	logger.API_LOG.level=INFO
	logger.API_LOG.appenderRef.API_APPENDER.ref = API_APPENDER
	logger.API_LOG.additivity=false
	```

5.  Register the `API_LOG` logger:

	```xml
	loggers = AUDIT_LOG, API_LOG, SERVICE_LOGGER,
	```  

6.	Save the `log4j2.properties` file.

## Configuring the REST API

The log4j2 configurations in the `log4j2.properties` file does not create logs for the REST API by default. Add a <b>Log</b> mediator to the REST API's in-sequence and configure it to log messages at `INFO` log level.

## Dynamically changing log level

See the instructions on [updating the log level]({{base_path}}/observe/micro-integrator/classic-observability-logs/configuring-log4j2-properties/#updating-the-log4j2-log-level).

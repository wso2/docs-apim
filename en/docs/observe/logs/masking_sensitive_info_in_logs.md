# Masking Sensitive Information in Logs

There can be business sensitive information that are added to logs. When these logs are analyzed, the information is exposed.

To avoid this potential security pitfall, you can mask sensitive information (such as credit card numbers, access tokens, etc.) in the log file when the logs are created. You can also define patterns that need to be masked from the logs.

## Enabling log masking

1.  Open the `MI_HOME/conf/log4j.properties` file in a text editor.
2.  Uncomment or add the following property under `CarbonConsoleAppender` or `CarbonDailyRollingFileAppender`.  

    ```xml
    log4j.appender.CARBON_CONSOLE.maskingPatternFile=path-to-masking-patterns
    ```

The `path-to-masking-patterns` value must be the absolute path to the [masking patterns file](#the-masking-pattern-file). In this file, each pattern is defined as key-value pairs (patten-name=pattern). 

The following is a sample configuration for the above property:

```xml
log4j.appender.CARBON_CONSOLE.maskingPatternFile=/home/conf/masking-patterns.properties
```

For the `DailyRollingFileAppender` value, the above property would be similar to the following:

```xml
log4j.appender.CARBON_LOGFILE.maskingPatternFile=path-to-masking-patterns
```

In this case, you can define separate masking pattern files for the console appender and file appender (or configure only one property).

## The masking pattern file

The masking pattern file is a property file that can contain one or more
masking patterns. The following is a sample configuration that shows
how to mask the credit card numbers in the logs.

```xml
masking.pattern.sample.CREDIT_CARD_VISA=4[0-9]{6,}$
masking.pattern.sample.CREDIT_CARD_MASTER=(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}
masking.pattern.sample.CREDIT_CARD_AMEX=[34|37][0-9]{14}$
```

With this configuration, each log line is checked for all the configured
patterns. If any match is found, it is masked with ‘*****’.

!!! Note
    -   If the pattern file that is configured in the `log4j.properties` file
    is not found, a default property file will be used (`           wso2-log-masking.properties          ` ).
    -   If there are no patterns defined in the file, no masking happens.

!!! Warning
    This feature can impact server performance since each log line is matched to each of the specified patterns. Therefore, it is highly recommended to use only the most necessary patterns.


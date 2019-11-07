## Rewrite

# admin\_Masking Sensitive Information in Logs

There can be business sensitive information that are added to logs in the WSO2 product console and/or WSO2 Carbon log files. When these logs are analyzed, the information is exposed to those who check this.

To avoid this potential security pitfall, users can mask sensitive information from the log file at the time of logging. In this feature, you can define patterns that need to be masked from the logs. This is particularly useful in the case of credit card numbers, access tokens, etc.

To configure this feature, follow the instructions below.

### Enabling log masking

1.  Open the `<PRODUCT_HOME>/repository/conf/log4j.properties` file in a text editor.

2.  Uncomment or add the following property under `CarbonConsoleAppender` or `CarbonDailyRollingFileAppender` .

    ``` java
        log4j.appender.CARBON_CONSOLE.maskingPatternFile=path-to-masking-patterns
    ```

The `path-to-masking-patterns` value must be a absolute path to the masking patterns file. In this file, each pattern is defined as key, value pairs (patten-name=pattern). Please refer to the next section for information on this file.

The following is a sample configuration for the above property.

``` java
    log4j.appender.CARBON_CONSOLE.maskingPatternFile=/home/conf/masking-patterns.properties
```

For the `DailyRollingFileAppender` value, the above property would be similar to the following.

``` java
    log4j.appender.CARBON_LOGFILE.maskingPatternFile=path-to-masking-patterns
```

In this case, you can define separate masking pattern files for console appender and file appender. (or configure only one property.)

### The masking pattern file

The masking pattern file is a property file that can contain one or more masking patterns. The following is a sample configuration that showcases how to mask the credit card numbers from the logs.

``` java
    masking.pattern.sample.CREDIT_CARD_VISA=4[0-9]{6,}$
    masking.pattern.sample.CREDIT_CARD_MASTER=(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}
    masking.pattern.sample.CREDIT_CARD_AMEX=[34|37][0-9]{14}$
```

With this configuration, each log line is checked for all the configured patterns. If any match is found, it is masked with ‘\*\*\*\*\*’.

!!! note
**Note** :

-   If the pattern file that is configured in the log4j.properties file is not found, a default property file will be used ( `wso2-log-masking.properties` ).

-   If there are no any patterns defined in the file, no masking happens.

!!! warning
**Important** : There can be a performance impact when using this feature with many masking patterns since each log line is matched with each of the patterns. So it is highly advisable to only use the most necessary patterns.



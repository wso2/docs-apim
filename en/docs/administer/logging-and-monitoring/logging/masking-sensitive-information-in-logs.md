# Masking Sensitive Information in Logs

There can be business sensitive information that are added to logs in the WSO2 product console and/or WSO2 Carbon log files. When these logs are analyzed, the information is exposed to those who check this.

To avoid this potential security pitfall, users can mask sensitive information from the log file at the time of logging. In this feature, you can define patterns that need to be masked from the logs. This is particularly useful in the case of credit card numbers, access tokens, etc.

To configure this feature, follow the instructions below.

### Enabling log masking

1. Log masking in not enabled by default in API Manager. Therefore, you need to manaully enable it and configure the required masking patterns. 

2. To enable log masking, navigate to `<APIM-HOME>/repository/conf/log4j2.properties` and do the necessary changes. The masking feature can be enabled by adding an additional `m` after the `%m` in the `layout.pattern`. Therefore you can add an additional `m` to the log files in which you want the values to be masked as shown below.

    ```java
    appender.CARBON_CONSOLE.layout.pattern = [%d{DEFAULT}] %5p - %c{1} %mm%n
    ``` 
 
3. The masking patterns are configured in `<APIM-HOME>/repository/conf/wso2-log-masking.properties`. You can change its default configurations in `<APIM-HOME>/repository/conf/deployment.toml`

### The masking pattern file

The masking pattern file is a property file that can contain one or more masking patterns. The following is a sample configuration that showcases how to mask the credit card numbers from the logs.

Navigate to `<APIM-HOME>/repository/conf/deployment.toml` and add the following configuration.

```properties
[masking_pattern.properties]
"CREDIT_CARD_VISA" = "4[0-9]{6,}$"
"CREDIT_CARD_MASTER" = "(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}"
"CREDIT_CARD_AMEX" = "[34|37][0-9]{14}$"
```

With this configuration, each log line is checked for all the configured patterns. If any match is found, it is masked with ‘\*\*\*\*\*’.

!!! warning
    There can be a performance impact when using this feature with many masking patterns since each log line is matched with each of the patterns. So it is highly advisable to only use the most necessary patterns.

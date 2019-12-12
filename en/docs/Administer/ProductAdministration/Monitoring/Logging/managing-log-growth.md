# Managing log growth

See the following content on managing the growth of [Carbon logs](#managing-the-growth-of-carbon-logs) and [Audit logs](#managing-the-growth-of-audit-log-files) :

Log4j2 supports two main log rotation options.

- Rollover based on log file size.
- Rollover based on a time period.

By default wso2 supports rollover based on a time period. This interval is by default one day. The log4j-based logging mechanism uses appenders to append all the log messages into a file, then at the end of the log rotation period, a new file will be created with the appended logs and archived. The name of the archived log file will always contain the date on which the file is archived.

#### Managing the growth of Carbon logs

Log growth in [Carbon logs]({base_path}/Administer/ProductAdministration/Monitoring/Logging/setting-up-logging/#configuring-carbon-logs) can be managed by following configurations in `<APIM_HOME>/repository/conf/log4j2.properties` file.


-   Rollover based on a time period can be configured by changing `appender.CARBON_LOGFILE.policies.time.interval` value in days(Default value is 1 day).

    ``` 
    appender.CARBON_LOGFILE.policies.time.interval = 1
    ```
    
-   Rollover based on log file size can be configured by following steps.

    1.  Remove following configuration from log4j2.properties file.
        
           ``` toml
           appender.CARBON_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
           appender.CARBON_LOGFILE.policies.time.interval = 1
           ```
       
    2.  Add following configuration to log4j2.properties file.

           ``` toml
           appender.CARBON_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
           appender.CARBON_LOGFILE.policies.size.size=10MB
           ```
       
           If the size of the log file is exceeding the value defined in the `appender.CARBON_LOGFILE.policies.size.size` property, the content is copied to a backup file and the logs are continued to be added to a new empty log file.     
  

-   The following property under `CARBON_LOGFILE` appender is used to limit the number of backup files.
    You can change it as per your requirement by changing its value.

    ``` toml
    appender.CARBON_LOGFILE.strategy.max   
    ```

#### Managing the growth of audit log files

-   Rollover based on a time period can be configured by changing `appender.AUDIT_LOGFILE.policies.time.interval` value in days(Default value is 1 day).

    ``` 
    appender.AUDIT_LOGFILE.policies.time.interval = 1
    ```
    
-   Rollover based on log file size can be configured by following steps.

    1.  Remove following configuration from log4j2.properties file.
        
           ``` toml
           appender.AUDIT_LOGFILE.policies.time.type = TimeBasedTriggeringPolicy
           appender.AUDIT_LOGFILE.policies.time.interval = 1
           ```
       
    2.  Add following configuration to log4j2.properties file.

           ``` toml
           appender.AUDIT_LOGFILE.policies.size.type = SizeBasedTriggeringPolicy
           appender.AUDIT_LOGFILE.policies.size.size=10MB
           ```
       
           If the size of the log file is exceeding the value defined in the `appender.AUDIT_LOGFILE.policies.size.size` property, the content is copied to a backup file and the logs are continued to be added to a new empty log file.     
  

-   The following property under `AUDIT_LOGFILE` appender is used to limit the number of audit log backup files.
    You can change it as per your requirement by changing its value.

    ``` toml
    appender.CARBON_LOGFILE.strategy.max   
    ```
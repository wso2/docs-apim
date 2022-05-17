# Managing Log Growth

See the following content on managing the growth of [Carbon Logs](#managing-the-growth-of-carbon-logs) and [Audit Logs](#managing-the-growth-of-audit-log-files):

Log4j2 supports two main log rotation options.

- Rollover based on log file size.
- Rollover based on a time period.

By default, WSO2 supports rollover based on a time period. This interval is, by default, one day. The log4j-based logging mechanism uses appenders to append all the log messages into a file, then at the end of the log rotation period, a new file will be created with the appended logs and archived. The name of the archived log file will always contain the date on which the file is archived.

## Managing the growth of Carbon Logs

Log growth in [Carbon Logs]({{base_path}}/administer/logging-and-monitoring/logging/configuring-logging/#configuring-carbon-logs) can be managed by following configurations in `<API-M_HOME>/repository/conf/log4j2.properties` file.


-   Rollover based on a time period can be configured by changing `appender.CARBON_LOGFILE.policies.time.interval` value in days (Default value is 1 day).

    ``` 
    appender.CARBON_LOGFILE.policies.time.interval = 1
    ```
    
-   Rollover based on log file size can be configured by following steps.

    1.  Disable time based triggering policy configuration for CARBON_LOGFILE logger in log4j2.properties file.
        
           ``` toml
           appender.CARBON_LOGFILE.policies.time.modulate = false
           ```
         
    2.  By default, the size limit of the log file is 10MB. You can change the default value using the following configuration.
    
        ```toml
        appender.CARBON_LOGFILE.policies.size.size=<file_size_limit>
        ```
            
        If the size of the log file is exceeding the value defined in the `appender.CARBON_LOGFILE.policies.size.size` property, the content is copied to a backup file and the logs are continued to be added to a new empty log file.  
         
    3.  Append timestamp(mm-dd-yyyy) to file pattern `appender.CARBON_LOGFILE.filePattern`. 
    
        !!!Note
            When file size based log rollover has been enabled, the timestamp should be appended to file pattern in order to differentiate the backup file names by time stamp. Unless, the current backup file will be replaced by the next backup which is created on the same day, since both file  will be having the same name(ie: wso2carbon-12-16-2019.log).
            
     
        ```toml
        appender.CARBON_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/wso2carbon-%d{mm-dd-yyyy}-%i.log
        ```   

-   The following property under `CARBON_LOGFILE` appender is used to limit the number of backup files.
    You can change it as per your requirement by changing its value.

    ``` toml
    appender.CARBON_LOGFILE.strategy.max   
    ```

    !!! Note
        This will only work with size-based rolling approach. For time-based rolling approach, you need to add the following configuration in order to delete the older files for this to work.

        ```
        appender.CARBON_LOGFILE.strategy.action.type = Delete
        appender.CARBON_LOGFILE.strategy.action.basepath = ${sys:carbon.home}/repository/logs/
        appender.CARBON_LOGFILE.strategy.action.maxdepth = 1
        appender.CARBON_LOGFILE.strategy.action.condition.type = IfLastModified
        appender.CARBON_LOGFILE.strategy.action.condition.age = 3D
        appender.CARBON_LOGFILE.strategy.action.PathConditions.type = IfFileName
        appender.CARBON_LOGFILE.strategy.action.PathConditions.glob = wso2carbon-*
        ```

        You can change the `appender.CARBON_LOGFILE.strategy.action.condition.age` parameter to accept files that are as old or older than the specified duration.

#### Managing the growth of audit log files

-   Rollover based on a time period can be configured by changing `appender.AUDIT_LOGFILE.policies.time.interval` value in days (Default value is 1 day).

    ``` 
    appender.AUDIT_LOGFILE.policies.time.interval = 1
    ```
    
-   Rollover based on log file size can be configured by following steps.

    1.  Disable time based triggering policy configuration for AUDIT_LOGFILE logger in log4j2.properties file.
        
           ``` toml
           appender.AUDIT_LOGFILE.policies.time.modulate = false
           ```
       
    2.  Add the following configuration to the `log4j2.properties` file, in order to enable size based triggering policy.

           ``` toml
           appender.AUDIT_LOGFILE.policies.size.modulate = true
           ```
           
    3.  By default, the size limit of the log file is 10MB. You can change the default value using the following configuration.
    
        ```toml
        appender.AUDIT_LOGFILE.policies.size.size=<file_size_limit>
        ```
            
        If the size of the log file exceeds the value defined in the `appender.CARBON_LOGFILE.policies.size.size` property, the content is copied to a backup file, and the logs are continued to be added to a new empty log file.  
         
    4.  Append timestamp(mm-dd-yyyy) to file pattern `appender.AUDIT_LOGFILE.filePattern`. 
    
        !!!Note
            When file size based log rollover has been enabled, the timestamp should be appended to the file pattern in order to differentiate the backup file names by time stamp. Unless, the current backup file will be replaced by the next backup, which is created on the same day since both file names are same (i.e., audit-12-16-2019.log).
            
     
        ```toml
        appender.AUDIT_LOGFILE.filePattern = ${sys:carbon.home}/repository/logs/audit-%d{mm-dd-yyyy}-%i.log
        ```
        
-   The following property under `AUDIT_LOGFILE` appender is used to limit the number of Audit Log backup files.
    You can change it as per your requirement by changing its value.

    ``` toml
    appender.AUDIT_LOGFILE.strategy.max   
    ```
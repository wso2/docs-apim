# Removing Unused Tokens from the Database

As you use WSO2 API Manager, the number of revoked, inactive and expired tokens accumulate in the IDN\_OAUTH2\_ACCESS\_TOKEN table. These tokens are kept in the database for logging and audit purposes, but they can have a negative impact on the server's performance over time. Therefore, it is recommended to clean them.

The following methods can be used for token cleanup:

-   [Configuring API Manager for token cleanup](#configuring-api-manager-for-token-cleanup)
-   [Using stored procedures for token cleanup](#using-stored-procedures-for-token-cleanup)

### Configuring API Manager for token cleanup

WSO2 API Manager triggers token cleanup during the following instances.

-   Token generation
-   Token refresh
-   Token revocation

!!! note
    This cleanup procedure is enabled by default. In this scenario **Inactive**, **Revoked**, **Expired** token will be cleaned. If you disabled this procedure and after some time you want to enable this cleanup procedure it is better to clean the access token table using [script](https://github.com/wso2/carbon-identity-framework/tree/master/features/identity-core/org.wso2.carbon.identity.core.server.feature/resources/dbscripts/stored-procedures) provided in latter part of the document and enable the feature.

To enable or disable token cleanup, open the `<API-M_HOME>/repository/conf/deployment.toml` file and do the following changes.(add the configuration if not exists in the deployment.toml file)

``` toml
    [oauth.token_cleanup]
    enable = true
    retain_access_tokens_for_auditing = true
```

<table>
<colgroup>
<col width="30%" />
<col width="70%" />
</colgroup>
<tr class="even">
<th>Property</th>
<th>Description</th>
</tr>
<tr class="even">
<td>enable</td>
<td>Set this property to <strong>true</strong> to enable token cleanup. Set it to <strong>false</strong> to disable token cleanup.</td>
</tr>
<tr class="even">
<td>retain_access_tokens_for_auditing</td>
<td>Set this property to true to move the old, invalid tokens to the Audit table when token cleaning is enabled.Set it to false if you do not wish to store old tokens in the Audit table.</td>
</tr>
</table>

### Using stored procedures for token cleanup

Alternatively, you can also use the stored procedures provided below, to run a token cleanup task periodically to remove the old and invalid tokens.

!!! tip
    It is safe to run these steps in read-only mode or during a time when traffic on the server is low, but that is not mandatory.


1.  Take a backup of the running database.
2.  Set up the database dump in a test environment and test it for any issues.

    For more information on setting up a database dump, go to the [MySQL](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#mysqldump-syntax) , [SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server) , and [Oracle](https://docs.oracle.com/cd/E11882_01/backup.112/e10642/rcmbckba.htm#BRADV8138) official documentation.

!!! tip
    We recommend you to test the database dump before the cleanup task as the cleanup can take some time.


3.  Depending on your database, select the appropriate token cleanup script from [here](https://github.com/wso2/carbon-identity-framework/tree/master/features/identity-core/org.wso2.carbon.identity.core.server.feature/resources/dbscripts/stored-procedures) and run it on the database dump. This takes a backup of the necessary tables, turns off SQL updates and cleans the database of unused tokens.

4.  Once the cleanup is over, start the API Manager pointing to the cleaned-up database dump and test thoroughly for any issues.
    You can also schedule a cleanup task that will automatically run after a given period of time. Here's an example:

    -   [**MySQL**](#schedule-task-for-mysql)
    -   [**SQL Server**](#schedule-task-for-sql-server)
    
####Schedule task for MySQL
``` sql
    USE 'WSO2AM_DB';
    DROP EVENT IF EXISTS 'cleanup_tokens_event';
    CREATE EVENT 'cleanup_tokens_event'
        ON SCHEDULE
            EVERY 1 WEEK STARTS '2018-01-01 00:00.00'
        DO
            CALL 'WSO2AM_DB'.'cleanup_tokens'();
    -- 'Turn on the event_scheduler'
    SET GLOBAL event_scheduler = ON;

```
####Schedule task for SQL Server

``` sql
    USE WSO2AM_DB ;  
    GO  
    -- Creates a schedule named CleanupTask.   
    -- Jobs that use this schedule execute every day when the time on the server is 01:00.   
    EXEC sp_add_schedule  
        @schedule_name = N'CleanupTask' ,  
        @freq_type = 4,  
        @freq_interval = 1,  
        @active_start_time = 010000 ;  
    GO  
    -- attaches the schedule to the job BackupDatabase  
    EXEC sp_attach_schedule  
        @job_name = N'BackupDatabase',  
        @schedule_name = N'CleanupTask' ;  
    GO
```

Replace `WSO2AM_DB` with the name of your API Manager database in the above script.

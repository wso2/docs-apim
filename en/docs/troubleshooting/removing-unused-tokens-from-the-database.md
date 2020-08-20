# Removing Unused Tokens from the Database

!!! note
    From 2.6.0 onwards, WSO2 API Manager is configured by default to trigger token clean up during token generation, token refreshing, and token revocation. Therefore, when the state of the token (`TOKEN_STATE`) changes during any of the latter mentioned processes for tokens that were in the `ACTIVE` state before, by default, such tokens will be removed from the `IDN_OAUTH2_ACCESS_TOKEN` table and stored in an audit table. Therefore, you do not need to manually clean up the unused tokens as guided below from API-M 2.6.0 onwards.

As you use WSO2 API Manager over a period of time, the number of revoked, inactive, and expired tokens accumulate in the `IDN\_OAUTH2\_ACCESS\_TOKEN` table. These tokens are kept in the database for logging and audit purposes, but over time they can have a negative impact on the server's performance. Therefore, it is recommended to clean them.

The following methods can be used for token cleanup:

-   [Configuring API Manager for token cleanup](#configuring-api-manager-for-token-cleanup)
-   [Using stored procedures for token cleanup](#using-stored-procedures-for-token-cleanup)

### Configuring API Manager for token cleanup

WSO2 API Manager triggers token cleanup during the following instances.

-   Token generation
-   Token refresh
-   Token revocation

!!! note
    This cleanup procedure is enabled by default. In this scenario, the **Inactive**, **Revoked**, and **Expired** tokens will be cleaned. If you disabled the cleanup procedure and after some time you want to enable it, it is better to initially clean up the access token table using the [script](https://github.com/wso2/carbon-identity-framework/tree/master/features/identity-core/org.wso2.carbon.identity.core.server.feature/resources/dbscripts/stored-procedures), which is provided, and thereafter enable the cleanup procedure.

To enable or disable token cleanup, open the `<API-M_HOME>/repository/conf/deployment.toml` file and do the following changes. (Add this configuration if it does not exist in the `deployment.toml` file)

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
<th><b>Property</b></th>
<th><b>Description</b></th>
</tr>
<tr class="even">
<td>enable</td>
<td>Set this property to <strong>true</strong> to enable token cleanup. Set it to <strong>false</strong> to disable token cleanup.</td>
</tr>
<tr class="even">
<td>retain_access_tokens_for_auditing</td>
<td>Set this property to <strong>true</strong> to move the old, invalid tokens to the Audit table when token cleaning is enabled. Set it to <strong>false</strong> if you do not wish to store old tokens in the Audit table.</td>
</tr>
</table>

### Using stored procedures for token cleanup

Alternatively, you can also use the stored procedures provided below, to run a token cleanup task periodically. This will remove the old and invalid tokens, sessions, and Auth codes, which cannot be cleaned by the inbuilt cleanup process in WSO2 API Manager.

!!! tip
    It is safe to run these steps in read-only mode or during a time when the traffic on the server is low. However, this is not mandatory if you are evaluating or testing the product. Nevertheless, if you are running a production deployment with a high volume of traffic, it is recommended that you run this periodically as the unused tokens, sessions count, etc. can be high.

1. Take a backup of the running database.
2. Set up the database dump in a test environment and test it for any issues.

     For more information on setting up a database dump, go to the [MySQL](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#mysqldump-syntax), [SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/create-a-full-database-backup-sql-server), and [Oracle](https://docs.oracle.com/cd/E11882_01/backup.112/e10642/rcmbckba.htm#BRADV8138) official documentation.

    !!! tip
        WSO2 recommends that you test the cleanup scripts and stored procedures before running or configuring them against your product database server.

3. Select the appropriate token cleanup script based on your database from [here](https://github.com/wso2/carbon-identity-framework/tree/master/features/identity-core/org.wso2.carbon.identity.core.server.feature/resources/dbscripts/stored-procedures) and run it on the database dump. 

     This takes a backup of the necessary tables, turns off SQL updates, and cleans the database of unused tokens. However, you do not always have to run the script with a backup. This can be run on production data, provided the script has been tested at least once on a lower environment.

4. After the cleanup is over, start the API Manager pointing to the cleaned-up database dump and test thoroughly for any issues.

     You can also schedule a cleanup task that will automatically run after a given period of time. 
     
     **Example:**

    !!! note
        Replace `WSO2AM_DB` with the name of your API Manager database in the above script.

    ``` sql tab="Schedule task for MySQL"
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

    ``` sql tab="Schedule task for SQL Server"
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

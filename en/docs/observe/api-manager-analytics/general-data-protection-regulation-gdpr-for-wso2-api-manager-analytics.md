# General Data Protection Regulation (GDPR) for WSO2 API Manager Analytics

In API Manager Analytics, Personally Identifiable Information(PII) of a user can be included in the log files and in the data sources associated to API Manager Analytics distribution.

To handle the PII of a user to support GDPR, following steps needs to be executed.

1. Remove personally identifiable information of a user in the API Manager Analytics logs via the Forget-me tool
2. Obfuscate personally identifiable information of a user stored in the data sources associated to API Manager Analytics via the GDPR-Client


## Removing personally identifiable information via the Forget-me tool

!!! tip "Before you begin:"
    - Note that this tool is designed to run in offline mode (e.g., the server should be shut down or run on another machine) in order to prevent unnecessary load to the server.

**Step 1: Configure the config.json file**

The `<API-M_ANALYTICS_HOME>/wso2/tools/identity-anonymization-tool/conf/config.json` file specifies the log file
 locations from which persisted user data needs to be removed. 
 
Replace the content in the `config.json` file with the below content. 
Then replace `<API-M_ANALYTICS_HOME>` with the path to the API Manager Analytics distribution.

If you have configured logs with PII to be saved in another location, you can add it to this list of processors.

``` js
{
  "processors" : [
    "log-file"
  ],
  "directories": [
    {
      "dir": "worker-logs",
      "type": "log-file",
      "processor" : "log-file",
      "log-file-path" : "<API-M_ANALYTICS_HOME>/wso2/worker/logs",
      "log-file-name-regex" : "(.)*(log|out)"
    },
    {
      "dir": "dashboard-logs",
      "type": "log-file",
      "processor" : "log-file",
      "log-file-path" : "<API-M_ANALYTICS_HOME>/wso2/dashboard/logs",
      "log-file-name-regex" : "(.)*(log|out)"
    }
  ]
}
```

For information on changing these configurations, see [Configuring the config.json file]({{base_path}}/administer/product-security/general-data-protection-regulation-gdpr-for-wso2-api-manager/#configuring-the-master-configuration-file) in the Product Administration Guide.

**Step 2: Execute the Forget-me tool**

1. Open a new terminal window and navigate to the `<API-M_ANALYTICS_HOME>/bin` directory.
2. Execute one of the following commands depending on your operating system:
    - On Linux/Mac OS: `./forgetme.sh -U <username>`
    - On Windows: `forgetme.bat -U <username>`

!!!note
    When specifying the `<username>` please provide the full tenant qualified username.
    
    e.g.,
    ```
    ./forgetme.sh -U user1@abc.com
    ```
 
## Obfuscate personally identifiable information of a user stored in the data sources via the GDPR-Client

This gdpr-client tool obfuscate personally identifiable information of a user stored in the API Manager Analytics related databases. 
 
This tool removes the following personally identifiable information of a specified user:

1. Username
2. User email address
3. User IP address

!!! tip "Before you begin:"
    - Note that this tool is designed to run in offline mode (e.g., the worker and dashboard servers should be shutdown or run on another machine) in order to prevent unnecessary load to the server.
     If this tool runs in online mode (e.g., when the servers are running), DB lock situations on the H2 databases may occur.
    - If you have configured any JDBC database other than the H2 database provided by default, copy the relevant JDBC driver to the `<API-M_ANALYTICS_HOME>/wso2/tools/gdpr-client/lib` directory.

**Step 1: Configure the conf.yaml file**

The `<API-M_ANALYTICS_HOME>/wso2/tools/gdpr-client/conf/conf.yaml` file specifies the configurations for data sources
 which store personally identifiable information(PII) of a user. This `conf.yaml` file also consists with the tables with
  column names where the PII of a user are stored.
  
1. Replace `<API-M_ANALYTICS_HOME>` reference (used in database configurations and secure vault configurations) with
 the relevant absolute path to the API Manager Analytics home directory.
2. If you have configured any JDBC databases for the defined data sources(`APIM_ANALYTICS_DB` and `DASHBOARD_DB`) in the
 conf.yaml file other than the H2 database provided by default, you need to edit the relevant data source configuration.

    For an example if you have configured MySQL for `APIM_ANALYTICS_DB` you need to add the relevant MySQL JDBC driver 
    to `<API-M_ANALYTICS_HOME>/wso2/tools/gdpr-client/lib` directory and edit the `APIM_ANALYTICS_DB` datasource as
    shown below.
   
    ```java
    wso2.datasources:
      dataSources:
        - name: APIM_ANALYTICS_DB
          description: "The datasource used for APIM statistics aggregated data."
          definition:
            type: RDBMS
            configuration:
              jdbcUrl: 'jdbc:jdbc:mysql://localhost:3306/APIM_ANALYTICS_DB'
              username: wso2carbon
              password: wso2carbon
              driverClassName: com.mysql.jdbc.Driver
              maxPoolSize: 1
              idleTimeout: 60000
              connectionTestQuery: SELECT 1
              validationTimeout: 30000
              isAutoCommit: false
    ```

**Step 2: Execute the gdpr-client tool**

1. Open a new terminal window and navigate to the `<API-M_ANALYTICS_HOME>/bin` directory.
2. Execute one of the following commands depending on your operating system:
    - On Linux/Mac OS: `./gdprclient.sh -U <username> -T <userTenantDomain> -E <userEmail> -I <userIPaddress>` 
    - On Windows: `gdprclient.bat -U <username> -T <userTenantDomain> -E <userEmail> -I <userIPaddress>`
    
    e.g.,
    ```
    ./gdprclient.sh -U user1 -T abc.com -E user1@abc.com -I 127.0.0.1
    ```

    !!!warning 
        Before running the command, make sure that you have finalised the command line options given with the command.
        For an example if you have run the command `./gdprclient.sh -U user1 -T abc.com -E user1@abc.com` this will not
        update the IP address of the user(only the username and the email address will be replaced). You cannot rerun 
        the tool and update the IP address(with pseudonym value) of the user again, as at this moment username is already
        replaced with the pseudonym value. If you need to remove the IP address as well, then execute `./gdprclient.sh -U user1 -T
         abc.com -E user1@abc.com -I 127.0.0.1` command in the first place.
         
        Same as that, if you did not provide the `-E <userEmail>` option, this will not replace any user associated
        email address and you cannot rerun the tool and replace the email value afterwards.
    
    **The following is the list of all the command line options that can be used with gdpr-client.**
    
    | **Option** | **Description** | **Mandatory/ Optional** | **Example** |
    | -- | -- | -- | -- |
    | -U | Username(without appending the user tenant domain) | Mandatory | -U john |
    | -T | Tenant domain of the user.<br><br>If this option is not provided, by default `carbon.super` will be used as the tenant domain.| Optional | -T abc.com |
    | -E | User email<br><br>If this option is not provided, then the stored references(in database tables) of the user email will not be removed. You cannot rerun the tool and replace the email references of the user afterwards, if you have not provided this option in the first run.<br> | Optional | john@abc.com |
    | -I | User ip address<br><br>If this option is not provided, then the stored references(in database tables) of the user IP address will not be removed. You cannot rerun the tool and replace the user IP address references of the user afterwards, if you have not provided this option in the first run. | Optional | 123.3.5.2 |
    | -pu | Pseudonym which the user name and email needs to be replaced with.<br><br>If this option is not provided, by default a random UUID value is generated. | Optional | -pu “123-343-435-545-dfd-4” |
    | -sha256 | If this option is provided, a SHA256 hash value will be generated as the pseudonym to obfuscate the username and user email address.| Optional | -sha256 |

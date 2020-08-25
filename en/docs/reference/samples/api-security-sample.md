# API Security Sample

### Usecase

-   Prevent misuse or abuse of information or of any application resources exposed by an API

-   Ability to distinguish between internal, partner and public use of APIs via security controls and audits

-   Ability to trace back which apps are using what APIs (hence data or resources) with which user credentials, permissions and roles

-   Ability to support multiple security standards and protocols

-   Embed custom security algorithms globally or for selected services

-   Ability to enforce both authentication (are you a valid user) and authorization (are you permitted to perform this action) on APIs

### Business Story

ABC organization is a mobile phone manufacturing company that has to expose their price details to the public. They also need to manage the salary details of all the employees, which should be visible to a certain set of employees under the finance department. These information should be exposed securely throught APIs for internal, partner, and public usage. The API invocations, service usage restrictions for employees, and changes made to the APIs shouls be tracked and custom security standards must be added. They need the users of their system to be authenticated to facilitate that only the permitted set of users are using the system and when the API invocation happens they need to authorize the users whether they are permitted to access the APIs.

### Running the sample

-   Start wso2am-2.2.0-updateX.
-   Go to `<API-M_HOME>/sample-scenarios`. Execute the `run.sh` file. Enter the scenario number as 4, when prompted.

### User credentials

| User         | Username | Password |
|--------------|----------|----------|
| Super tenant | admin    | admin    |

### Implement using WSO2 API Manager

-   We need to create and API to get the salary details of the employees
-   We need to have separate tenants to manage their APIs through tenants. For more details, see Managing Public, Partner vs Private APIs
-   We need to enable audit logs to trace the API creations and API invocations.
    For example, to enable custom security algorithms we can use the [Kerberos OAuth2 Grant.]({{base_path}}/learn/api-security/oauth2/grant-types/kerberos-oauth2-grant)
-   We can authorize the users through API Manager access tokens and we can use scopes to authorise the API consumers when consuming the APIS.

The audit logs are printed in the `<API-M_HOME>/repository/logs/audit.log` file, when you run the sample.

After invoking and creating the APIs the audit logs will be similar to the following sample.

??? info "Expand to see the sample audit log..."
    ``` java
        [2017-12-22 11:48:03,227]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:03,226+0530]
        [2017-12-22 11:48:03,341]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:03,339+0530]
        [2017-12-22 11:48:09,390]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:09,389+0530]
        [2017-12-22 11:48:09,398]  INFO -  Initiator : admin@carbon.super | Action : Add User | Target : tom | Data : { Roles :Internal/subscriber, } | Result : Success
        [2017-12-22 11:48:09,437]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:09,436+0530]
        [2017-12-22 11:48:09,458]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:09,457+0530]
        [2017-12-22 11:48:10,396]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:10,395+0530]
        [2017-12-22 11:48:10,819] Chris@finance.abc.com [1] [AM] INFO -  Initiator : Chris | Action : create | Target : 0 | Data : { Chris_Integration_Test_App } | Result : Success
        [2017-12-22 11:48:10,941] Chris@finance.abc.com [1] [AM] INFO -  Initiator : Chris | Action : update | Target : 1 | Data : { Chris_Integration_Test_App } | Result : Success
        [2017-12-22 11:48:11,132]  INFO -  Initiator : admin | Action : create | Target : 0 | Data : { admin_Integration_Test_App } | Result : Success
        [2017-12-22 11:48:11,138]  INFO -  Initiator : admin | Action : update | Target : 2 | Data : { admin_Integration_Test_App } | Result : Success
        [2017-12-22 11:48:12,437]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:12,436+0530]
        [2017-12-22 11:48:12,709]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:12,709+0530]
        [2017-12-22 11:48:12,813]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:12,813+0530]
        [2017-12-22 11:48:12,880]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:12,879+0530]
        [2017-12-22 11:48:12,909]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:12,909+0530]
        [2017-12-22 11:48:13,116]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,116+0530]
        [2017-12-22 11:48:13,207]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,207+0530]
        [2017-12-22 11:48:13,234]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,234+0530]
        [2017-12-22 11:48:13,293]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,293+0530]
        [2017-12-22 11:48:13,342]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,341+0530]
        [2017-12-22 11:48:13,425]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,425+0530]
        [2017-12-22 11:48:13,484]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,484+0530]
        [2017-12-22 11:48:13,503] ERROR -  Illegal access attempt at [2017-12-22 11:48:13,0502] from IP address 127.0.0.1 while trying to authenticate access to service EventProcessorAdminService
        [2017-12-22 11:48:13,509]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,509+0530]
        [2017-12-22 11:48:13,594]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:13,593+0530]
        [2017-12-22 11:48:14,449] Chris@finance.abc.com@finance.abc.com [1] [AM] INFO -  {"performedBy":"Chris","action":"created","typ":"API","info":"{\"provider\":\"Chris-AT-finance.abc.com\",\"name\":\"Salary_details_API\",\"context\":\"\\\/t\\\/finance.abc.com\\\/salaries\\\/1.0.0\",\"version\":\"1.0.0\"}"}
        [2017-12-22 11:48:14,911]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:14,910+0530]
        [2017-12-22 11:48:15,003]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:15,003+0530]
        [2017-12-22 11:48:15,175]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:15,175+0530]
        [2017-12-22 11:48:15,629]  INFO -  {"performedBy":"admin","action":"created","typ":"API","info":"{\"provider\":\"admin\",\"name\":\"Mobile_stock_API\",\"context\":\"\\\/stocks\\\/1.0.0\",\"version\":\"1.0.0\"}"}
        [2017-12-22 11:48:15,689]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:15,689+0530]
        [2017-12-22 11:48:15,722]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:15,722+0530]
        [2017-12-22 11:48:15,808]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:15,808+0530]
        [2017-12-22 11:48:18,412]  INFO -  {"performedBy":"admin","action":"created","typ":"Application","info":"{\"tier\":\"Unlimited\",\"name\":\"Application_one\",\"callbackURL\":null}"}
        [2017-12-22 11:48:18,507]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:18,507+0530]
        [2017-12-22 11:48:18,512]  INFO -  Initiator : admin | Action : create | Target : 0 | Data : { admin_Application_one_PRODUCTION } | Result : Success
        [2017-12-22 11:48:18,514]  INFO -  Initiator : admin | Action : update | Target : 3 | Data : { admin_Application_one_PRODUCTION } | Result : Success
        [2017-12-22 11:48:18,520]  INFO -  Initiator : admin | Action : update | Target : 3 | Data : { admin_Application_one_PRODUCTION } | Result : Success
        [2017-12-22 11:48:18,671]  INFO -  {"performedBy":"admin","action":"updated","typ":"Application","info":"{\"Generated keys for application\":\"Application_one\"}"}
        [2017-12-22 11:48:18,720]  INFO -  {"performedBy":"admin","action":"created","typ":"Subscription","info":"{\"application_name\":\"Application_one\",\"tier\":\"Unlimited\",\"provider\":\"admin\",\"api_name\":\"Mobile_stock_API\",\"application_id\":2}"}
        [2017-12-22 11:48:18,732]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:18,732+0530]
        [2017-12-22 11:48:18,884]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:18,884+0530] from IP address
        [2017-12-22 11:48:19,823]  INFO -  {"performedBy":"admin","action":"created","typ":"Application","info":"{\"tier\":\"Unlimited\",\"name\":\"Application_two\",\"callbackURL\":null}"}
        [2017-12-22 11:48:19,848]  INFO -  Initiator : admin | Action : create | Target : 0 | Data : { admin_Application_two_PRODUCTION } | Result : Success
        [2017-12-22 11:48:19,851]  INFO -  Initiator : admin | Action : update | Target : 4 | Data : { admin_Application_two_PRODUCTION } | Result : Success
        [2017-12-22 11:48:19,854]  INFO -  Initiator : admin | Action : update | Target : 4 | Data : { admin_Application_two_PRODUCTION } | Result : Success
        [2017-12-22 11:48:19,888]  INFO -  {"performedBy":"admin","action":"updated","typ":"Application","info":"{\"Generated keys for application\":\"Application_two\"}"}
        [2017-12-22 11:48:19,904]  INFO -  {"performedBy":"admin","action":"created","typ":"Subscription","info":"{\"application_name\":\"Application_two\",\"tier\":\"Unlimited\",\"provider\":\"admin\",\"api_name\":\"Mobile_stock_API\",\"application_id\":3}"}
        [2017-12-22 11:48:19,908]  INFO -  'admin@carbon.super [-1234]' logged in at [2017-12-22 11:48:19,908+0530]
    ```

When analysing the audit logs

-   This log show that a user has been created

    ``` java
    [2017-12-22 11:48:09,398]  INFO -  Initiator : admin@carbon.super | Action : Add User | Target : tom | Data : { Roles :Internal/subscriber, } | Result : Success
    ```

-   This log show that an application has been created

    ``` java
    [2017-12-22 11:48:10,819] Chris@finance.abc.com [1] [AM] INFO -  Initiator : Chris | Action : create | Target : 0 | Data : { Chris_Integration_Test_App } | Result : Success
    ```

-   This log show the API creation of the Salary details API

    ``` java
    [2017-12-22 11:48:14,449] Chris@finance.abc.com@finance.abc.com [1] [AM] INFO -  {"performedBy":"Chris","action":"created","typ":"API","info":"{\"provider\":\"Chris-AT-finance.abc.com\",\"name\":\"Salary_details_API\",\"context\":\"\\\/t\\\/finance.abc.com\\\/salaries\\\/1.0.0\",\"version\":\"1.0.0\"}"}
    ```

These data can be viewed via WSO2 API Manager Analytics server. For more details, see copy\_API Governance.

Assume that the `GET` resource in the Salary API should be restricted for admin role users. Follow the steps below to restrict the resource for a particular role.

1.  Create a scope named `new_scope.` Assign scope to the admin role. 

    ![](https://lh6.googleusercontent.com/P4ixhA2IooMGlCyw1S0_QnmCFjcI8dPwk3LzArNRIr8rP5hC8FNr3IxkvAPUcYP36fQHWxWPHXysqGUqyea2z1_1gxxV6vAD57Wec6PNvfDZ0tHGM9oe1xypil9nnyrsRXBEL5yt)

2.  When you execute the sample, it invokes the API without this scope. 

    ![](https://lh3.googleusercontent.com/xZnDwHf4dbw4ynxUyOBEjYuG87X3nJ2DWsuApHWhW1KKTSbKHLP3YCDEIrqkD3oCezEjuJS4KtbDnbguTyOeTNTs9_YQ1wT5UXFS_BuEaTepB-wvdh8qz9rTEASBvtG6Y8-PSJ4p)

    !!! note
        You will see the following error in the audit log if the access token does not allow you to access the requested resource.

        ``` java
            WARN - APIAuthenticationHandler API authentication failure
        ```


3.  Executing the sample also invokes the `GET` resource and return the response as shown below. 

    ![](https://lh4.googleusercontent.com/a9GVqIUs62NnynUA9HpIy6WqU3xEW4Pr9kl_veTTrt89OquS4YHqHLMxBDUMy3o9qKCQwy90U3JjcRFcepETVejA7W9QJibEINQHPmRhuZdY97bTO4iFZLwhC7148fpXMjxcPgr8)


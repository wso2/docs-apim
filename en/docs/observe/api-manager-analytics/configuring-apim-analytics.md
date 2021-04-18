# Configuring APIM Analytics

WSO2 API Manager Analytics provides reports, statistics, and graphs on the APIs deployed in WSO2 API Manager. You can configure alerts to monitor these APIs and detect unusual activity, manage locations via Geo-location statistics, and carry out a detailed analysis of the logs. WSO2 API Manager has an enhanced distribution of Analytics to cater to the API Manager specific scenarios that are used here to configure API-M Analytics.

Refer the  [**Quick Setup**](#quick-setup) section to set up analytics for quick demos and try-out scenarios, or refer the [**Standard Setup**](#standard-setup) section to set up analytics for a production environment.

-   [**Quick Setup**](#quick-setup)
-   [**Standard Setup**](#standard-setup)

## Quick Setup

Follow the instructions below if you wish to set up API-M Analytics for quick demos and to try-out scenarios:

1.  Download and install WSO2 API-M.

     WSO2 API-M via the [WSO2 API Manager page](https://wso2.com/api-management/install/). 
    
     For more information on installing WSO2 API-M, see the [Installation Guide]({{base_path}}/install-and-setup/install/installation-prerequisites).

     [![apim download page]({{base_path}}/assets/img/learn/api-download-page.png)]({{base_path}}/assets/img/learn/apim-download-page.png)
    
2.  Download and install WSO2 API-M Analytics.

    To download WSO2 API-M Analytics go to the [WSO2 API Manager page](https://wso2.com/api-management/install/), click **DOWNLOAD** to expand the installation options. Scroll down past the installation options to navigate to the **OTHER RESOURCES** section, and click **Analytics**. 

    <img src="{{base_path}}/assets/img/learn/analytics-download-page.png" width="400">
    
       <html><div class="admonition warning">
       <p class="admonition-title">Note</p>
       <p>If you are following the quick setup, make sure that both the binaries (the unzipped API-M pack and the unzipped Analytics pack) are inside the same directory, because the default configurations such as database connection URLs, etc. are configured assuming that both the packs are inside the same folder.</p>
       <img src="{{base_path}}/assets/img/learn/analytics-quick-setup.png" width="300">
       </div>
       </html>
                  
3.  Enable Analytics.

     1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file.
     2. Uncomment the analytics enabling section as shown below.

        ``` toml
        [apim.analytics]
        enable = true
        ```
        
     3. Save the change.

4.  Start the Worker profile of the Analytics Server.
    
    Navigate to the `<API-M_ANALYTICS_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.
    
    -   On Windows: `worker.bat --run              `
    -   On Linux/Mac OS: `sh worker.sh               `

5.  Start the API Manager server.
    
     Navigate to the `<API-M_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.
    
     - On Windows: `api-manager.bat --run`
     - On Linux/Mac OS: `sh api-manager.sh` 
    
    !!! info
        If API-M Analytics is properly configured in WSO2 API Manager, when you start up the API Manager server, which is after the WSO2 API-M Analytics server, you will see the following log message in the terminal that is running the API-M Analytics server.
            
        INFO {org.wso2.carbon.databridge.core.DataBridge} - user admin connected   
 
     <a name="dashboard"></a>

6.  Start the Dashboard profile of the Analytics Server.
    
    Navigate to the `<API-M_ANALYTICS_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.
    
    -   On Windows: `dashboard.bat --run` 
    -   On Linux/Mac OS: `sh dashboard.sh`

7.  Optionally, if you wish to access the business rules via the Dashboard node, you can use the dashboard profile that we started in the <a href="#dashboard">previous step</a>.

You can now start using the WSO2 API Manager for its usual operations and the required Analytics functionality.

## Standard Setup

![]({{base_path}}/assets/img/learn/analytics-standard-architecture-diagram.png)

Follow the instructions below if you wish to set up API-M Analytics for a production environment.

- [Step 1 - Download and install WSO2 API-M](#step-1-download-and-install-wso2-api-m)
- [Step 2 - Download and install WSO2 API-M Analytics](#step-2-download-and-install-wso2-api-m-analytics)
- [Step 3 - Configure WSO2 API Manager to publish statistics](#step-3-configure-wso2-api-manager-to-publish-statistics)
- [Step 4 - Configure Analytics](#step-4-configure-analytics)
     - [Step 4.1 - Configure the Analytics Worker](#step-41-configure-the-analytics-worker)
     - [Step 4.2 - Configure the Analytics Dashboard](#step-42-configure-the-analytics-dashboard)
- [Step 5 - Include third-party libraries and database drivers](#step-5-include-third-party-libraries-and-database-drivers)
- [Step 6 - Configure the keystores](#step-6-configure-keystores)
- [Step 7 - Configure the User-Agent Parser](#step-7-configure-user-agent-parser)

### Step 1 - Download and install WSO2 API-M

 Download and install WSO2 API-M via the [WSO2 API Manager page](https://wso2.com/api-management/install/). Click **DOWNLOAD** and go to **INSTALLATION OPTIONS**.
 <br/>For more information on installing WSO2 API-M, see the [Installation Guide]({{base_path}}/install-and-setup/install/installation-prerequisites).
    
### Step 2 - Download and install WSO2 API-M Analytics

To download WSO2 API-M Analytics go to the [WSO2 API Manager page](https://wso2.com/api-management/install/), click **DOWNLOAD** to expand the installation options. Scroll down past the installation options to navigate to the **OTHER RESOURCES** section, and click **Analytics**.

<img src="{{base_path}}/assets/img/learn/analytics-download-page.png" width="400">
    
### Step 3 - Configure WSO2 API Manager to publish statistics

Follow the instructions below to do the required configurations for WSO2 API-M to publish statistics in the WSO2 API-M Analytics server.

!!! warning
      If you are working on a distributed (clustered) setup of API Manager, carryout the instructed configurations in the Publisher, Developer Portal, and Gateway nodes of the API Manager.

1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file.
2. Enable API-M Analytics.

     Uncomment the following section as shown below.

    ``` toml
    [apim.analytics]
    enable = true
    ```

3. Configure the following parameters under the `[apim.analytics]` section if required.
     <table>
     <thead>
     <tr class="header">
     <th style="width:200px"><b>Parameter</b></th>
     <th><b>Value</b></th>
     <th><b>Description</b></th>
     </tr>
     </thead>
     <tbody>
     <tr class="even">
     <td><code>store_api_url</code></td>
     <td><code>https://&lt;host&gt;:&lt;port&gt;</code></td>
     <td>The WSO2 API-M Analytics REST API URL. The WSO2 API-M Analytics REST API connection information, which is included under the REST API-M connection information, are defined as global properties, as they are common to all the WSO2 API-M analytics.
     </td>
     </tr>
     <tr class="even">
     <td><code>username</code></td>
     <td>A valid administrator username</td>
     <td>
     <div class="content-wrapper">
     <p>The administrator username to log into the remote WSO2 API-M Analytics server that can publish events and query data.</p>
     <p>If the username is not defined, the admin username defined under <code>[super_admin]</code> will be used.</p>
     </div>
     </td>
     </tr>
     <tr class="even">
     <td><code>password</code></td>
     <td>A valid administrator password.</td>
     <td>
     <div class="content-wrapper">
     <p>The administrator password for the user to log into the remote WSO2 API-M Analytics server that can publish events and query data.</p>
     <p>If the password is not defined, the admin password defined under <code>[super_admin]</code> will be used.</p>
     </div>
     </td>
     </tr>
     <tr class="even">
     <td><code>receiver_username</code></td>
     <td>A valid administrator username.</td>
     <td>
     <div class="content-wrapper">
     <p>The administrator username to log into the remote WSO2 API-M Analytics server that can publish events.</p>
     <p>This need to be configured if the event receiver user is different from the <code>username</code>. </p>
     </div>
     </td>
     </tr>
     <tr class="odd">
     <td><code>receiver_password</code></td>
     <td>The password of the <code>receiver_username</code> specified.</td>
     <td>
     <div class="content-wrapper">
     <p>The administrator password to log into the remote WSO2 API-M Analytics server that collects statistics from WSO2 API Manager.</p>
     <p>This needs to be configured if the event receiver user is different from the <code>username</code>. </p>
     </div>
     </td>
     </tr>
     <tr class="odd">
     <td><code>store_api_username </code></td>
     <td>A valid administrator username.</td>
     <td>
     <div class="content-wrapper">
     <p>The administrator username to log into the remote WSO2 API-M Analytics server that can query data.</p>
     <p>This needs to be configured if the Siddhi Store REST API user is different from the administrator <code>username</code>.</p>
     </div>
     </td>
     </tr>
     <tr class="even">
     <td><code>store_api_password</code></td>
     <td>The password of the username specified.</td>
     <td>
     <div class="content-wrapper">
     <p>The administrator password to log in to the remote WSO2 API-M Analytics server.</p>
     <p>This needs to be configured if the store REST API user is different from the <code>username</code>.</p>
     </div>
     </td>
     </tr>
     </tbody>
     </table>
4. Save the change.

    !!! note
        If you enable email user, you need to configure <code>@carbon.super</code> to the username of the API-M Analytics admin user. For example, if the username of the API-M Analytics admin user is <code>demo@wso2.com</code>, it must be <code>demo@wso2.com@carbon.super</code> after you have enabled email user.

5. Configure the following event receiver configuration groups.

    ``` toml
    [[apim.analytics.url_group]]
    analytics_url =["tcp://analytics1:7611","tcp://analytics2:7611"]
    analytics_auth_url =["ssl://analytics1:7711","ssl://analytics2:7711"]
    type = "loadbalance"
    ```

    <table>
    <thead>
    <tr class="header">
    <th style="width:200px"><b>Parameter</b></th>
    <th style="width:200px"><b>Value</b></th>
    <th><b>Description</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="even">
    <td><code>analytics_url</code></td>
    <td><code>https://&lt;host&gt;:&lt;port&gt;</code></td>
    <td>
    <p>Array of event receiver URLs.</p>
    </td>
    </tr>
    <tr class="even">
    <td><code>analytics_auth_url</code></td>
    <td><code>https://&lt;host&gt;:&lt;port&gt;</code></td>
    <td>
    <p>Array of event receiver Auth URLs.</p>
    </td>
    </tr>   
    <tr class="even">
    <td><code>type</code></td>
    <td>Event publishing mechanism</td>
    <td>
    <p>It supports client-side load balancer or failover event publishing. By default, is supports failover event publishing.</p>
    <p>Setting <code>type=loadbalance</code> can change it to publishing in failover manner.</p>
    <p>If an Active-Active deployment is used for the Analytics Worker, <code>loadbalance</code> can be used, and in an Active-Passive setup, you need to use failover publishing.</p>
    </td>
    </tr>
    </tbody>
    </table>

6. Save the changes.

### Step 4 - Configure Analytics

!!! warning
    When configuring API-M Analytics, change only the required properties(which are mentioned in the respective documentation) 
    of the deployment.yaml file of either worker or dashboard runtime. Do not change other default values as it may result in an erroneous state.

  API-M Analytics contains two runtimes, namely worker and dashboard. The worker is responsible for the summarization of the collected data and the dashboard is responsible to represent the summarised data in the dashboards. Therefore, two separate JVMs are required. As a best practice, the worker and dashboard runtime can have the same analytics binary. This helps when managing the deployment and when applying WUM updates. However, it is up to the dev-ops engineer to decide whether to use the same binary (pack) or two binaries for the two runtimes.

!!! info
    Sometimes due to case insensitivity of primary keys in aggregation tables, primary key violation errors are thrown when you try to insert a new record with the same value as an existing record. To overcome this, you need to add encoding and collation to database when the Analytics DB is created (i.e., before the tables are created). For more information on collation, see [MySQL](https://dev.mysql.com/doc/refman/5.7/en/charset-collation-names.html) or [MS SQL](https://docs.microsoft.com/en-us/sql/relational-databases/collations/collation-and-unicode-support?view=sql-server-ver15) based on the database that you are using. Sample commands are provided below.

    !!! example

        ```sql tab="MySQL"
        ALTER DATABASE <DB-NAME> COLLATE latin1_general_cs ;
        ```

        ```sql tab="MS SQL"
        ALTER DATABASE <DB-NAME> COLLATE SQL_Latin1_General_CP1_CS_AS ;
        ```
  
  - The Worker supports an Active-Active deployment and an Active-Passive deployment. 
  - As the dashboard is used only to render the data there is no active-active or active-passive concept. However, based on the High-availability (HA) requirement it can be configured as Active-Active or Active-Passive by defining the `loadbalance` configuration.
  
#### System requirements

You will be running an Analytics worker and an Analytics dashboard for this solution. Be sure that you have the required system specifications to run each server.

-   For the Analytics **Worker**:

    <table>
    <tbody>
    <tr class="odd">
    <th>Memory</th>
    <td><p><ul><li>~ 4 GB per worker node<li>It is recommended to allocate 4 cores.</li></li><li>~ 2 GB is the initial heap (-Xms)  required for the server startup. The maximum heap size is 4 GB (-Xmx)</li></ul></p></td>
    </tr>
    <tr class="even">
    <th>Disk</th>
    <td><p><li>~ 480 MB, excluding space allocated for log files and databases.</li></p></td>
    </tr>
    </tbody>
    </table>

-   For the Analytics **Dashboard**:

    <table>
    <tbody>
    <tr class="odd">
    <th>Memory</th>
    <td><p><ul><li>~ 2 GB minimum, 4 GB Maximum<li>2 CPU cores minimum. It is recommended to allocate 4 cores.</li></li><li>~ 512 MB heap size. This is generally sufficient to process typical SOAP messages but the requirements vary with larger message sizes and  the number of messages processed concurrently.</li></ul></p></td>
    </tr>
    <tr class="even">
    <th>Disk</th>
    <td><p><li>~ 480 MB, excluding space allocated for log files and databases.</li></p></td>
    </tr>
    </tbody>
    </table>
      
#### Step 4.1 - Configure the Analytics Worker

  1. Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.
  2. Edit the `APIM_ANALYTICS_DB` section.
        ``` yaml
        A sample for MySQL is shown below.
        
        - name: APIM_ANALYTICS_DB
            description: "The datasource used for APIM statistics aggregated data."
            jndiConfig:
            name: jdbc/APIM_ANALYTICS_DB
            definition:
            type: RDBMS
            configuration:
                jdbcUrl: 'jdbc:mysql://localhost:3306/analytics_db'
                username: 'root'
                password: '123'
                driverClassName: com.mysql.jdbc.Driver
                minIdle: 5
                maxPoolSize: 50
                idleTimeout: 60000
                connectionTestQuery: SELECT 1
                validationTimeout: 30000
                isAutoCommit: false
        ```
  3. Point the following data sources to external databases. 
     
     None of the following databases need DB scripts. The tables will be automatically created.
     - `GEO_LOCATION_DATA` (Only if you need Geo-location based statistics.)

#### Step 4.2 - Configure the Analytics Dashboard

  1. Open the `<API-M_ANALYTICS_HOME>/conf/dashboard/deployment.yaml` file.
  2. Edit the `APIM_ANALYTICS_DB` and `AM_DB` sections, and point to your desired type of database.
   
    !!! note
        In the below configuration, the database defined as `am_db` is the same database which is defined under `[database.apim_db]` configuration in the **deployment.toml** file of the WSO2 API Manager.
        <hr>
        **If you are configuring the `AM_DB` databases in Oracle**, apart from the following configurations, you need to add the `alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'` section to the `AM_DB` datasource that you configured with Oracle.
    
    ``` yaml
     A sample for MySQL is shown below.
     
    - name: AM_DB
        description: Main datasource used by API Manager
        jndiConfig:
         name: jdbc/AM_DB
        definition:
         type: RDBMS
         configuration:
           jdbcUrl: "jdbc:mysql://localhost:3306/am_db"
           username: wso2carbon
           password: wso2carbon
           driverClassName: com.mysql.jdbc.Driver
           maxPoolSize: 10
           idleTimeout: 60000
           connectionTestQuery: SELECT 1
           validationTimeout: 30000
           isAutoCommit: false

    - name: APIM_ANALYTICS_DB
         description: "The datasource used for APIM statistics aggregated data."
         jndiConfig:
           name: jdbc/APIM_ANALYTICS_DB
         definition:
           type: RDBMS
           configuration:
             jdbcUrl: 'jdbc:mysql://localhost:3306/analytics_db'
             username: 'root'
             password: '123'
             driverClassName: com.mysql.jdbc.Driver
             minIdle: 5
             maxPoolSize: 50
             idleTimeout: 60000
             connectionTestQuery: SELECT 1
             validationTimeout: 30000
             isAutoCommit: false           
    ```
    
  3. Point the following data sources to external databases. 
     
     None of the following databases need DB scripts. The tables will be automatically created.
      - `WSO2_DASHBOARD_DB`
      - `BUSINESS_RULES_DB`
      - `WSO2_PERMISSIONS_DB`    
         
  4. Configure the Dashboard IdP configurations.
  
     The Dashboard IDP configurations are used to point to the same user store and STS API Manager support. As a result, the same users and roles can be used to log in to the dashboards. Similar to the API-M portals, the OAuth2 Authorization code flow is used to log in to the Dashboard Portal. By default, SSO (Single Sign-On) is enabled for analytics dashboards.
  
     These configurations need to be done under the `auth.configs` namespace as shown below and need to be changed according to the APIM deployment.

      ```
      auth.configs:
      type: apim
      ssoEnabled: true
      properties:
        adminScope: apim_analytics:admin_carbon.super
        allScopes: apim_analytics:admin openid apim:api_view apim:subscribe apim_analytics:monitoring_dashboard:own apim_analytics:monitoring_dashboard:edit apim_analytics:monitoring_dashboard:view apim_analytics:business_analytics:own apim_analytics:business_analytics:edit apim_analytics:business_analytics:view apim_analytics:api_analytics:own apim_analytics:api_analytics:edit apim_analytics:api_analytics:view apim_analytics:application_analytics:own apim_analytics:application_analytics:edit apim_analytics:application_analytics:view
        adminUsername: admin
        adminPassword: admin
        kmDcrUrl: https://localhost:9443/client-registration/v0.17/register
        kmTokenUrlForRedirection: https://localhost:9443/oauth2
        kmTokenUrl: https://localhost:9443/oauth2
        kmUsername: admin
        kmPassword: admin
        portalAppContext: analytics-dashboard
        businessRulesAppContext : business-rules
        cacheTimeout: 30
        baseUrl: https://localhost:9643
        grantType: authorization_code
        publisherUrl: https://localhost:9443
        devPortalUrl: https://localhost:9443
        externalLogoutUrl: https://localhost:9443/oidc/logout
      ```
  
     The details of the properties related to the IdP configuration are as follows:
  
      |<div style="width:170px">**Property**</div>            |**Default Value**                    |**Description**                 |
      |-------------------------------------------------------|-------------------------------------|--------------------------------|
      | `adminScope` | apim_analytics:admin_carbon.super | The Admin scope that is used for the permissions in the dashboards.|
      | `allScopes`| apim_analytics:admin apim_analytics:product_manager apim_analytics:api_developer apim_analytics:app_developer apim_analytics:devops_engineer apim_analytics:analytics_viewer apim_analytics:everyone openid apim:api_view apim:subscribe | All the scopes used for permissions in the dashboards.|
      | `adminUsername`| admin | The username for the admin services that corresponds to the credentials defined under the super tenant in the API Manager's `deployment.toml` file.|
      | `adminPassword`| admin | The password for the admin services that corresponds to the credentials defined under the super tenant in the API Manager's `deployment.toml` file.|
      | `kmDcrUrl`| https://localhost:9443/client-registration/v0.17/register | The Dynamic Client Registration (DCR) endpoint of the key manager in the IdP. This should be pointed to the API Manager Publisher node URL.|
      | `kmTokenUrlForRedirection`| https://localhost:9443/oauth2 | The token endpoint of the key manager in the IdP which is used for browser redirection. This should be pointed to the API Manager Publisher node URL.|
      | `kmTokenUrl`| https://localhost:9443/oauth2 | The token endpoint of the key manager in the IdP. This should be pointed to the API Manager Publisher node URL.|
      | `kmUsername`| admin | The username for the Key Manager in the IdP.|
      | `kmPassword`| admin | The password for the Key Manager in the IdP.|
      | `portalAppContext`| analytics-dashboard | The application context of the Analytics Dashboard application.|
      | `businessRulesAppContext`| business-rules| The application context of the Business Rules application.|
      | `cacheTimeout`| 30 | The cache timeout for the validity period of the token in seconds.|
      | `baseUrl`| https://localhost:9643 | The base URL to which the token should be redirected after the code returned from the Authorization Code grant type is used to get the token. This is the URL where the API-M Analytics Dashboard server is running.|
      | `grantType`| authorization_code | 	The grant type used in the OAuth application token request.|
      | `publisherUrl`| https://localhost:9443 | URL that the API Manager Publisher is running.|
      | `devPortalUrl`| https://localhost:9443 | URL that the API Manager Developer Portal  is running.|
      | `externalLogoutUrl`| https://localhost:9443/oidc/logout | The URL used to log out from the external IdP provider (API Manager) side in the SSO. This should be pointed to the API Manager Publisher node URL.|
         
### Step 5 - Include third-party libraries and database drivers 

API-M Analytics supports both OSGi and Non-OSGi libraries. When integrating a third-party library or DB driver, you need to include it in the appropriate location.

If the library is -

- **OSGi** - Add it to the `<API-M_ANALYTICS_HOME>/lib` directory and restart.
- **Non-OSGi** - Add it to the `<API-M_ANALYTICS_HOME>/jars` directory and restart.  

### Step 6 - Configure the keystores

In the SSL handshake between the API Manager and the API Manager Analytics servers, the client (i.e., API Manager) needs to verify the certificate presented by the server (i.e., API Manager Analytics). For this purpose, the client stores the trusted certificate of the server in the `client-truststore.jks` keystore.

- If you use a custom keystore in API Manager and/or API Manager Analytics, import the public key certificate of API Manager Analytics into the `client-truststore.jks` file of the API Manager. 
- To export the public key from the server and import it into the client's trust store, follow the steps given in [Adding CA-signed certificates to keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/#step-1-generating-a-ca-signed-certificate).

For more information, see [Configuring Keystores in API-M Analytics]({{base_path}}/observe/api-manager-analytics/configuring-keystores-in-apim-analytics/#configuring-keystores-in-api-m-analytics).

### Step 7 - Configure the User-Agent Parser

The User-Agent and Operating System information is extracted from the User-Agent header of the API requests for the purpose of analytics. This process requires a set of regular expressions to parse the header and extract the information. By default, it is configured to use the `<API-M_ANALYTICS_HOME>/conf/worker/regexes.yaml` file for this purpose as shown below.

```
siddhi:
  extensions:
    # Provides the regular expression collection to parse the user-agent header
    -
      extension:
        name: 'getUserAgentProperty'
        namespace: 'env'
        properties:
          regexFilePath : ${sys:carbon.home}/conf/worker/regexes.yaml
```
However, if you need to use your own regular expressions to extract the information in detail, then you can replace the `regexFilePath` property with your own file.

!!! warning
    The Regular Expressions configured above is reduced to provide the optimal performance while identifying common User-Agents and Operating Systems. However, if you completely remove the latter mentioned configuration, you will end up by using a standard Regular Expression set, which is packed inside the parser library, and it will extract almost every User-Agents and Operating Systems, but it may provide lower performance throughput.

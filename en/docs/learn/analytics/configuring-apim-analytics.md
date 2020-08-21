# Configuring APIM Analytics

This section explains how to configure analytics for WSO2 API Manager (WSO2 API-M). The API Manager analytics to provide reports, statistics and graphs on the APIs deployed in WSO2 API Manager. You can then configure alerts to monitor these APIs and detect unusual activity, manage locations via geo location statistics and carry out detailed analysis of the logs. WSO2 API Manager has an enhanced distribution of Analytics to cater to API Manager specific scenarios which is used here to configure APIM Analytics.

Please refer the  [**Quick Setup**](#quick-setup) section to set up analytics for quick demos and try-out scenarios, or refer the [**Standard Setup**](#standard-setup) section to set up analytics for a production environment.

-   [**Quick Setup**](#quick-setup)
-   [**Standard Setup**](#standard-setup)

## Quick Setup

Follow the instructions below if you wish to set up API-M Analytics for quick demos and to try-out scenarios.

1.  Download and install WSO2 API-M.

    WSO2 API-M via the [WSO2 API Manager page](https://wso2.com/api-management/install/). For more information on installing WSO2 API-M, see the [Installation Guide]({{base_path}}/install-and-setup/install/installation-prerequisites.md).
   
    ![]({{base_path}}/assets/img/learn/apim-download-page.png)
    
2.  Download and install WSO2 API-M Analytics.

    To download WSO2 API-M Analytics go to the [WSO2 API Manager page](https://wso2.com/api-management/install/), click **Download** to expand the installation options. Navigate to the **Other Resources** section, and click **Analytics**. 

    ![]({{base_path}}/assets/img/learn/analytics-download-page.png)
    
    
       <html><div class="admonition warning">
       <p class="admonition-title">Note</p>
       <p>If you are following the quick setup make sure both the binaries (unzipped API-M pack and unzipped Analytics pack) are inside the same directory. 
                        Because the default configurations such as database connection urls etc are configured assuming that both the packs are inside the same folder.
                        </p>
                        ![]({{base_path}}/assets/img/learn/analytics-quick-setup.png)
       </div>
       </html>
                  
3.  To enable Analytics, open the `<API-M_HOME>/repository/conf/deployment.toml` file and uncomment the analytics enabling section as shown below. Save this change.

    ``` toml
      [apim.analytics]
      enable = true
    ```

4.  Start the Worker profile of the Analytics Server.
    
    Navigate to the `<API-M_ANALYTICS_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.
    
    -   On Windows: `worker.bat --run              `
    -   On Linux/Mac OS: `sh worker.sh               `

5.  Start the API Manager server.
    
    Navigate to the `<API-M_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.
    
    - On Windows: `wso2server.bat --run`
    - On Linux/Mac OS: `sh wso2server.sh` 
    
        !!! info
              If API-M Analytics is properly configured in WSO2 API Manager, when you start up the API Manager server, which is after the WSO2 API-M Analytics server, you will see the following log message in the terminal that is running the API-M Analytics server.
            
                INFO {org.wso2.carbon.databridge.core.DataBridge} - user admin connected   
                    
6.  Start the Dashboard profile of the Analytics Server.
    
    Navigate to the `<API-M_ANALYTICS_HOME>/bin` directory in your console and execute one of the following scripts based on your OS.
    
    -   On Windows: `dashboard.bat --run`  
    -   On Linux/Mac OS: `sh dashboard.sh`    
    
    

7.  Optionally, if you wish to access the business rules via the Dashboard node, you can use the dashboard profile that we started in the previous step.            

You can now start using the WSO2 API Manager for its usual operations and the required Analytics functionality.

## Standard Setup

Follow the instructions below if you wish to set up API-M Analytics for a production environment.

- [Step 1 - Download and install WSO2 API-M](#step-1---download-and-install-wso2-api-m)
- [Step 2 - Download and install WSO2 API-M Analytics](#step-2---download-and-install-wso2-api-m-analytics)
- [Step 3 - Configure WSO2 API Manager to publish statistics](#step-3---configure-wso2-api-manager-to-publish-statistics)
- [Step 4 - Configure databases](#step-4---configure-databases)
- [Step 5 - Configure APIM IdP Client](#step-5---configure-apim-idp-client)
  - [Details of the properties in APIM IdP Client](#details-of-the-properties-in-apim-idp-client)
- [Step 6 - Configure keystores](#step-6---configure-keystores)
- [Step 7 - Configure User-Agent Parser](#step-7---configure-user-agent-parser)

### Step 1 - Download and install WSO2 API-M

 Download and install WSO2 API-M via the [WSO2 API Manager page](https://wso2.com/api-management/install/). Click **DOWNLOAD** and go to **INSTALLATION OPTIONS**.
 <br/>For more information on installing WSO2 API-M, see the [Installation Guide]({{base_path}}/install-and-setup/install/installation-prerequisites.md).
    
 ![]({{base_path}}/assets/img/learn/apim-download-page.png)
    
### Step 2 - Download and install WSO2 API-M Analytics

To download WSO2 API-M Analytics go to the [WSO2 API Manager page](https://wso2.com/api-management/install/), click **Download** to expand the installation options.Navigate to the **Other Resources** section, and click **Analytics**. 

  ![]({{base_path}}/assets/img/learn/analytics-download-page.png)
    
### Step 3 - Configure WSO2 API Manager to publish statistics

Follow the instructions below to do the required configurations for WSO2 API-M to publish statistics in the WSO2 API-M Analytics server.

!!! warning
      If you are working on a distributed (clustered) setup of API Manager, carryout the instructed configurations in the Publisher, Store and Gateway nodes of the API Manager.

Open the `<API-M_HOME>/repository/conf/deployment.toml` file and uncomment the following section as shown below. Save this change.

   ``` toml
   [apim.analytics]
   enable = true
   ```
Configure the following parameters under the `[apim.analytics]` section if required.

<table>
    <thead>
        <tr class="header">
            <th style="width:200px">Parameter</th>
            <th>Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr class="even">
            <td><code>store_api_url</code></td>
            <td><code>https://&lt;host&gt;:&lt;port&gt;</code></td>
            <td>The WSO2 API-M Analytics REST API URL. The WSO2 API-M Analytics REST API connection information, which are
                included under the REST API-M connection information, are defined as global properties, as they are common
                to all the WSO2 API-M analytics.
            </td>
        </tr>
        <tr class="even">
            <td><code>username</code></td>
            <td>A valid administrator username</td>
            <td>
                <div class="content-wrapper">
                    <p>The administrator username to log into the remote WSO2 API-M Analytics server that can publish events and query data</p>
                    <p>If username is not defined, admin username defined under [super_admin] will be used.</p>
                </div>
            </td>
        </tr>
        <tr class="even">
            <td><code>password</code></td>
            <td>A valid administrator password</td>
            <td>
                <div class="content-wrapper">
                    <p>The administrator password for the user to log into the remote WSO2 API-M Analytics server that can publish events and query data</p>
                    <p>If password is not defined, admin password defined under [super_admin] will be used.</p>
                </div>
            </td>
        </tr>
        <tr class="even">
                <td><code>receiver_username</code></td>
                <td>A valid administrator username</td>
                <td>
                    <div class="content-wrapper">
                        <p>The administrator username to log into the remote WSO2 API-M Analytics server that can publish events</p>
                        <p>This need to be configure if event receiver user is different from the <code>username</code>. </p>
                    </div>
                </td>
            </tr>
        <tr class="odd">
            <td><code>receiver_password</code></td>
            <td>The password of the receiver_username specified.</td>
            <td>
                <div class="content-wrapper">
                    <p>The administrator password to log into the remote WSO2 API-M Analytics server that collects statistics from WSO2 API Manager.</p>
                    <p>This need to be configure if event receiver user is different from the <code>username</code>. </p>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td><code>store_api_username </code></td>
            <td>A valid administrator username</td>
            <td>
                <div class="content-wrapper">
                    <p>The administrator username to log into the remote WSO2 API-M Analytics server that can query data</p>
                    <p>This need to be configure if store rest api user is different from the <code>username</code></p>
                </div>
            </td>
        </tr>
        <tr class="even">
            <td><code>store_api_password</code></td>
            <td>The password of the username specified.</td>
            <td>
                <div class="content-wrapper">
                    <p>The administrator password to log into the remote WSO2 API-M Analytics server.</p>
                    <p>This need to be configure if store rest api user is different from the <code>username</code></p>
                </div>
            </td>
        </tr>
    </tbody>
</table>

!!! note
    If you enable email user, you need to configure <code>@carbon.super</code> to the username of the API-M Analytics admin user. e.g., If
    the username of the API-M Analytics admin user is <code>demo@wso2.com</code>, it must be <code>demo@wso2.com@carbon.super</code> once you
    have enabled email user.
    
Configure the following event receiver configuration groups.
   ``` toml
   [[apim.analytics.url_group]]
   analytics_url =["tcp://analytics1:7611","tcp://analytics2:7611"]
   analytics_auth_url =["ssl://analytics1:7711","ssl://analytics2:7711"]
   type = "loadbalance"
   ```
<table>
    <thead>
        <tr class="header">
            <th style="width:200px">Parameter</th>
            <th style="width:200px">Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr class="even">
            <td><code>analytics_url</code></td>
            <td><code>https://&lt;host&gt;:&lt;port&gt;</code></td>
            <td>
                <p>Array of event receiver urls.</p>
            </td>
        </tr>
        <tr class="even">
            <td><code>analytics_auth_url</code></td>
            <td><code>https://&lt;host&gt;:&lt;port&gt;</code></td>
            <td>
                <p>Array of event receiver auth urls.</p>
            </td>
        </tr>   
        <tr class="even">
            <td><code>type</code></td>
            <td>Event publishing mechanism</td>
            <td>
                <p>It support clinet side load balance or failover event publishing. By default is suppoer failover event publishing</p>
                <p>Setting <code>type=loadbalance</code> can change it to publishing in failover manner.</p>
                <p>If the analytics worker is active-active deployement loadbalance can be used and in active-passive setup, need to use failover publishing.</p>
            </td>
        </tr>        
    </tbody>
</table>

Save the changes.

### Step 4 - Configure analytics

  APIM analytics contain two runtime as worker and dashboard. Worker is responsible for summarization collect data and dashboard is responsible for represent summarised 
  data in dashboards. Hence two separate JVM is required. As a best practice worker and dashboard runtime can have same analytics binary. It is helps when managing the deployment 
  and when appliying WUM updates. But it is upto the dev-ops engineer decide whether it used same binary(pack) or two binary for both runtimes.
  
  Wroker support [active-active]({{base_path}}/install-and-setup/setup/distributed-deployment/configure-apim-analytics/active-active) deployment and [active-passive]({{base_path}}/install-and-setup/setup/distributed-deployment/configure-apim-analytics/active-passive) deployment. Since dashboard is used only to render the data there is no active-active or active-passive concepet. But 
  Based on the High-availability requirement it can be configured as active-active or active-passive based by defining loadbalancer.
      
#### Configure analytics worker

  1. Open the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file 
  1. Edit the `APIM_ANALYTICS_DB` section.
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
             maxPoolSize: 50
             idleTimeout: 60000
          connectionTestQuery: SELECT 1
          validationTimeout: 30000
          isAutoCommit: false
    ```
  1. Point the following data sources to external databases. None of the following databases need DB scripts. The tables will be automatically created.
    - GEO_LOCATION_DATA (Only if you need geo-location based statistics.)

#### Configure analytics dashboard

  1. Open the `<API-M_ANALYTICS_HOME>/conf/dashboard/deployment.yaml` file.
  2. Edit the `APIM_ANALYTICS_DB` and `AM_DB` sections and point to your desired type of database.
   
    !!! note
        If you are configuring AM_DB databases in **Oracle**, apart from the below mentioned configurations, 
        you need to add the `alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'` section to AM_DB datasource you configure with Oracle.
    
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
             maxPoolSize: 50
             idleTimeout: 60000
          connectionTestQuery: SELECT 1
          validationTimeout: 30000
          isAutoCommit: false           
    ```
    
  1. Point the following data sources to external databases. None of the following databases need DB scripts. The tables will be automatically created.
      - WSO2_DASHBOARD_DB
      - BUSINESS_RULES_DB
      - WSO2_PERMISSIONS_DB    
         
  1. Configure dashboard IDP configurations
  
    Dashboard IDP configuration is used to point same user store and STS API Manager support. With that same users and roles can be used to login to the dashboards. Same as APIM portals OAuth2 Authorization code flow is used to login to the dashboard portal. By default SSO(Single Sign On) is enabled for analytics dashboards.
  
    - Furthermore, these configurations are done under the auth.configs namespace as shown below and need to be changed according to the APIM deployement. 
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
  
    - Details of the properties in IdP configuration
  
      |<div style="width:170px">**Property**</div>            |**Default Value**                    |**Description**                 |
      |-------------------------------------------------------|-------------------------------------|--------------------------------|
      | `adminScope` | apim_analytics:admin_carbon.super | Admin scope which is used for permissions in dashboards.|
      | `allScopes`| apim_analytics:admin apim_analytics:product_manager apim_analytics:api_developer apim_analytics:app_developer apim_analytics:devops_engineer apim_analytics:analytics_viewer apim_analytics:everyone openid apim:api_view apim:subscribe | All the scopes used for permissions in the dashboards.|
      | `adminUsername`| admin | The username for the admin services.|
      | `adminPassword`| admin | The password for the admin services.|
      | `kmDcrUrl`| https://localhost:9443/client-registration/v0.17/register | The Dynamic Client Registration (DCR) endpoint of the key manager in the IdP. This should be pointed to the API Manager Publisher node url.|
      | `kmTokenUrlForRedirection`| https://localhost:9443/oauth2 | The token endpoint of the key manager in the IdP which is used for browser redirection. This should be pointed to the API Manager Publisher node url.|
      | `kmTokenUrl`| https://localhost:9443/oauth2 | The token endpoint of the key manager in the IdP. This should be pointed to the API Manager Publisher node url.|
      | `kmUsername`| admin | The username for the key manager in the IdP.|
      | `kmPassword`| admin | The password for the key manager in the IdP.|
      | `portalAppContext`| analytics-dashboard | The application context of the Analytics Dashboard application.|
      | `businessRulesAppContext`| business-rules| The application context of the Business Rules application.|
      | `cacheTimeout`| 30 | The cache timeout for the validity period of the token in seconds.|
      | `baseUrl`| https://localhost:9643 | The base URL to which the token should be redirected after the code returned from the Authorization Code grant type is used to get the token. This is the URL where the API-M Analytics Dashboard server is running.|
      | `grantType`| authorization_code | 	The grant type used in the OAuth application token request.|
      | `publisherUrl`| https://localhost:9443 | Url which the API Manager Publisher is running.|
      | `devPortalUrl`| https://localhost:9443 | Url which the API Manager Developer Portal  is running.|
      | `externalLogoutUrl`| https://localhost:9443/oidc/logout | The URL via which you can log out from the external IDP provider(API Manager) side in the SSO. This should be pointed to the API Manager Publisher node url.|
         
### Step 5 - Include third party libraries and database drivers 

  1. APIM analytics support both OSGI and Non-Osgi libraries
  1. When integrating third party library or DB driver need to include it to the appropriate location.
  1. If they library is,
    1. osgi - Add it to `<API-M_ANALYTICS_HOME>/lib` directory and restart  
    1. non osgi - Add it to `<API-M_ANALYTICS_HOME>/jars` directory and restart  

### Step 6 - Configure keystores

In the SSL handshake between the API Manager and API Manager Analytics servers, the client (i.e. API Manager) needs to verify the certificate presented by the server (i.e. API Manager Analytics). For this purpose, the client stores the trusted certificate of the server in the `client-truststore.jks` keystore.

If you use a custom keystore in API Manager and/or API Manager Analytics, import the public key certificate of API Manager Analytics into the `client-truststore.jks` file of the API Manager. To export the public key from the server and import it into the client's trust store, follow the steps given in [Adding CA-signed certificates to keystores]({{base_path}}/administer/product-security/General/UsingAsymmetricEncryption/admin-creating-new-keystores/#step-1-generating-a-ca-signed-certificate) in the Administration Guide.

For more information follow [Configuring Keystores in APIM Analytics]({{base_path}}/learn/analytics/configuring-keystores-in-apim-analytics/).

### Step 7 - Configure User-Agent Parser

The User-Agent and Operating System information is extracted from the User-Agent header of the API requests for the purpose of analytics. This process requires a set of regular expressions to parse the header and extract the information. By default, it is configured to use the `<API-M_ANALYTICS_HOME>/conf/worker/regexs.yaml` file for this purpose as shown below.

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
    The regular expressions configured above is reduced to provide the optimal performance, while identifying common User-Agents and Operating Systems. However, if you completely remove the latter mentioned configuration, you will end-up by using a standard regular expression set, which is packed inside the parser library, and it will extract almost every User-Agents and Operating Systems, but might provide lower performance throughput.

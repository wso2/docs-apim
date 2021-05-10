# Monetizing an API

API Monetization allows organizations to expand their business and generate higher revenue by exposing their services and data via APIs. API Publishers can publish their APIs with competitive business plans to the Developer Portal. Thereafter, API subscribers (e.g., Application Developers) can discover, subscribe, and invoke these monetized APIs, and pay for their API usage based on dynamic or fixed business plans.

WSO2 API Manager (WSO2 API-M) allows API Publishers to manage, govern, and monetize their APIs based on their business monetization goals. API Publishers can use the monetization capability in WSO2 API Manager to define various business plans for the same service; therefore, API subscribers have the freedom of selecting a preferred business plan as their subscription. 

WSO2 API Manager provides an extendable interface that allows API Management solution developers to provide custom implementations with any third-party billing engine for the purpose of monetizing APIs based on paid business plans.

WSO2 API Manager uses <a href="https://stripe.com">Stripe</a> as its sample implementation billing engine to handle the payments for API monetization. However, you can use any custom implementation with WSO2 API Manager's API Monetization capabilities based on your requirement.

## Monetize an API

<html>
      <div class="admonition warning">
      <p class="admonition-title">Warning</p>
      <p><b>The following steps are based on the <a href="https://stripe.com">Stripe billing engine</a></b>. If you wish to work with another third-party billing engine, you need to first create a custom implementation by extending the <a href="https://github.com/wso2/carbon-apimgt/blob/master/components/apimgt/org.wso2.carbon.apimgt.api/src/main/java/org/wso2/carbon/apimgt/api/model/Monetization.java">monetization interface</a>, and only thereafter will you be able to monetize your API.</p>
      </div> 
</html>

Let's use the
[wso2-am-stripe-plugin](https://github.com/wso2-extensions/wso2-am-stripe-plugin/blob/master/src/main/java/org.wso2.apim.monetization/impl/StripeMonetizationImpl.java) to monetize an API in the following example scenario.

### Before you begin

#### (A) - Configure the billing engine

 Create a connected account to configure the Stripe billing engine.  

 The Stripe connected account will connect all the API Publisher accounts to the Tenant Admin's account. This allows the Tenant Admin to access the API Publishers' data, and create payments and customers on behalf of them. 

 For more information go to, [Using Connect with Standard Accounts](https://stripe.com/docs/connect/standard-accounts).

 <html>
 <div class="admonition note">
 <p class="admonition-title">Note</p>
 <ul><li><p>
 Make sure to configure the <a href="https://dashboard.stripe.com/account">timezone to UTC</a> before creating any objects in the Stripe accounts.</p></li>
 <li>Create the following two Stripe accounts only if you do not have an existing Stripe account.</li>
 </ul>
 </div> 
 </html>

 1. Create an account for the Tenant Admin.

     The Tenant Admin account will be used to create a connected account in order to centrally manage the payments for the Publisher accounts.

     1. [Create an account in Stripe](https://dashboard.stripe.com/register).  

         Use the details of the Tenant Admin and verify the account. Let's name this account as Tenant Admin. <a name="tenantSK"></a>

     2. [Obtain the keys](https://stripe.com/docs/keys#api-keys).  

        [![Obtain keys]({{base_path}}/assets/img/learn/monetization_obtain_keys.png)]({{base_path}}/assets/img/learn/monetization_obtain_keys.png)
        
 2.  Create an account for the API Publisher.  
    
     Each Publisher Stripe account corresponds to a specific Publisher in WSO2 API Manager. Every Publisher should create a separate Stripe account if they wish to monetize their APIs.

    1.  [Create an account in Stripe](https://dashboard.stripe.com/register). 

    2.  [Obtain the keys](https://stripe.com/docs/keys#api-keys).

 3.  Enable Connect and create a [connected account](https://stripe.com/docs/connect/quickstart#create-account) in Stripe.  

    1. Sign in to the Tenant Admin's Stripe account.
    2. Click **Connected accounts** > **Get Started** > **Build a platform or marketplace** > **Continue** to create a platform account.

        [![Create a platform account]({{base_path}}/assets/img/learn/monetization_create_connected_account.png)]({{base_path}}/assets/img/learn/monetization_create_connected_account.png)

    3. In the prompted screen click **+ Create** and select the Account type as Standard and select the Country. If you haven't enabled OAuth for standard accounts, the **Continue** button will be disabled. Click **enable OAuth for Standard Accounts** in the pop-up that appears on **Continue** button.

        [![Enable oauth]({{base_path}}/assets/img/learn/monetization_enable_oauth.png)]({{base_path}}/assets/img/learn/monetization_enable_oauth.png)
    
    4. Enable **OAuth for Standard Accounts** under **OAuth Settings** in the prompted screen. Then, go back to the previous step and create a connected account. This will provide a one-time-use Standard onboarding link which would take the following format. The Tenant Admin can share this with the API Publisher.
    
         ```
         https://connect.stripe.com/oauth/authorize?redirect_uri=https://connect.stripe.com/hosted/oauth&client_id=<client-id>& state=<state>&response_type=code&scope=read_write&stripe_user[country]=<country>
        ```
 
         The API Publisher has to access the given link and provide the details of the API Publisher account. Provide **Two-step authentication** details as well. Alternatively, you can use **skip this account form** to work in the developer mode.

         [![Work in developer mode]({{base_path}}/assets/img/learn/developer-mode.png)]({{base_path}}/assets/img/learn/developer-mode.png)
     
    5. Once you follow either of the options in the previous step, the onboarding process will be completed. After few seconds, API Publisher account will be listed under Connected accounts in Tenant Admin account. The connected account ID (Connect ID) for the API Publisher's account will appear when clicking on the connected account. Copy the **Connect ID** value as it is required when enabling monetization for an API from the APIM Publisher portal.

#### (B) - Configure WSO2 API Manager

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>In a distributed WSO2 API Manager deployment, you need to do the following configurations in the Publisher and the Developer Portal nodes.</p>
</div> 
</html>

1. Connect WSO2 API Manager to the billing engine.

    1. Download and copy the JAR specific to the billing engine, which you are working with, into the `<API-M_HOME>/repository/components/lib` directory.
        
        In this example scenario, add the [Stripe Java 9.8.0 JAR](https://mvnrepository.com/artifact/com.stripe/stripe-java/9.8.0) into the latter mentioned `lib` folder.

    2. Build the implementation of the respective monetization interface and add the JAR into the `<API-M_HOME>/repository/components/lib` directory.
        
        In this example scenario, you need to add the [org.wso2.apim.monetization.impl-1.1.1.jar]({{base_path}}/assets/attachments/learn/monetization/org.wso2.apim.monetization.impl-1.1.1.jar) JAR into the latter mentioned `lib` folder. Note that this JAR has been derived by building the [wso2-am-stripe-plugin repository](https://github.com/wso2-extensions/wso2-am-stripe-plugin). 

    3.  Define the monetization implementation in WSO2 API Manager.
     
        Decompile the `org.wso2.apim.monetization.impl-1.0.0.jar` JAR and add the name of the package in the `<API-M_HOME>/repository/conf/deployment.toml` file as follows:

        ``` json tab="Format"
        [apim.monetization]
        monetization_impl = "<monetization-implementation>"
        ```

        ``` json tab="Example"
        [apim.monetization]
        monetization_impl = "org.wso2.apim.monetization.impl.StripeMonetizationImpl"
        ```

2.  Configure the database.
  
    1. Download and add the database related connector JAR into the`<APIM_HOME/repository/components/lib` directory. 
        
        As a MySQL database is used for this example scenario, download and copy the [MySQL connector JAR](https://mvnrepository.com/artifact/mysql/mysql-connector-java/5.1.36) into the `<APIM_HOME/repository/components/lib` directory.

    2. Configure the WSO2 API Manager related datasource.  
        
        Add the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file under the `database.apim_db` section. Make sure to add the parameters based on your setup.

        ``` java
        [database.apim_db]
        type = "mysql"
        url = "jdbc:mysql://<DBHost>:<Port>/<DBName>?autoReconnect=true"
        username = "xxx"
        password = "yyy"
        defaultAutoCommit = "false"
        driverClassName = "com.mysql.jdbc.Driver"
        maxActive = "50"
        maxWait = "60000"
        testOnBorrow = "true"
        validationQuery = "SELECT 1"
        validationInterval = "30000"
        ```

    3.  Navigate to the `<API-M_HOME>/dbscripts/apimgt/` directory and execute the database script that corresponds to the database management system that you are working on.
         
         As a MySQL database is used for this example scenario, execute the `mysql.sql` script.
         
    4.  Execute one of the following database scripts in the `WSO2AM_DB` database, based on the RDBMS that you are using.
         
         Execute the MySQL script in this example scenario.
    
        ``` java tab="MySQL"
        CREATE TABLE IF NOT EXISTS AM_MONETIZATION (
            API_ID INTEGER NOT NULL,
            TIER_NAME VARCHAR(512),
            STRIPE_PRODUCT_ID VARCHAR(512),
            STRIPE_PLAN_ID VARCHAR(512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE
        ) ENGINE=InnoDB;


        CREATE TABLE IF NOT EXISTS AM_POLICY_PLAN_MAPPING (
                POLICY_UUID VARCHAR(256),
                PRODUCT_ID VARCHAR(512),
                PLAN_ID VARCHAR(512),
                FOREIGN KEY (POLICY_UUID) REFERENCES AM_POLICY_SUBSCRIPTION(UUID)
        ) ENGINE=InnoDB;


        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_PLATFORM_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBER_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            CUSTOMER_ID VARCHAR(256) NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON DELETE CASCADE
        ) ENGINE=InnoDB;


        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_SHARED_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            APPLICATION_ID INTEGER NOT NULL,
            API_PROVIDER VARCHAR(256) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SHARED_CUSTOMER_ID VARCHAR(256) NOT NULL,
            PARENT_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (PARENT_CUSTOMER_ID) REFERENCES AM_MONETIZATION_PLATFORM_CUSTOMERS(ID) ON DELETE CASCADE
        )ENGINE=INNODB;


        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_SUBSCRIPTIONS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBED_APPLICATION_ID INTEGER NOT NULL,
            SUBSCRIBED_API_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SUBSCRIPTION_ID VARCHAR(256) NOT NULL,
            SHARED_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBED_APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (SUBSCRIBED_API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (SHARED_CUSTOMER_ID) REFERENCES AM_MONETIZATION_SHARED_CUSTOMERS(ID) ON DELETE CASCADE
        )ENGINE INNODB;
        ```

        ``` java tab="DB2"
        CREATE TABLE IF NOT EXISTS AM_MONETIZATION (
            API_ID INTEGER NOT NULL,
            TIER_NAME VARCHAR(512),
            STRIPE_PRODUCT_ID VARCHAR(512),
            STRIPE_PLAN_ID VARCHAR(512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE
        )/

        CREATE TABLE IF NOT EXISTS AM_POLICY_PLAN_MAPPING (
                POLICY_UUID VARCHAR(256),
                PRODUCT_ID VARCHAR(512),
                PLAN_ID VARCHAR(512),
                FOREIGN KEY (POLICY_UUID) REFERENCES AM_POLICY_SUBSCRIPTION(UUID)
        )/

        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_PLATFORM_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBER_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            CUSTOMER_ID VARCHAR(256) NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON DELETE CASCADE
        )/

        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_SHARED_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            APPLICATION_ID INTEGER NOT NULL,
            API_PROVIDER VARCHAR(256) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SHARED_CUSTOMER_ID VARCHAR(256) NOT NULL,
            PARENT_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (PARENT_CUSTOMER_ID) REFERENCES AM_MONETIZATION_PLATFORM_CUSTOMERS(ID) ON DELETE CASCADE
        )/

        CREATE TABLE IF NOT EXISTS AM_MONETIZATION_SUBSCRIPTIONS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBED_APPLICATION_ID INTEGER NOT NULL,
            SUBSCRIBED_API_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SUBSCRIPTION_ID VARCHAR(256) NOT NULL,
            SHARED_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBED_APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (SUBSCRIBED_API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (SHARED_CUSTOMER_ID) REFERENCES AM_MONETIZATION_SHARED_CUSTOMERS(ID) ON DELETE CASCADE
        )/
        ```

        ``` java tab="MSSQL"
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_MONETIZATION]') AND TYPE IN (N'U'))
        CREATE TABLE AM_MONETIZATION (
            API_ID INTEGER NOT NULL,
            TIER_NAME VARCHAR(512),
            STRIPE_PRODUCT_ID VARCHAR(512),
            STRIPE_PLAN_ID VARCHAR(512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE
        );

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_POLICY_PLAN_MAPPING]') AND TYPE IN (N'U'))
        CREATE TABLE AM_POLICY_PLAN_MAPPING (
                POLICY_UUID VARCHAR(256),
                PRODUCT_ID VARCHAR(512),
                PLAN_ID VARCHAR(512),
                FOREIGN KEY (POLICY_UUID) REFERENCES AM_POLICY_SUBSCRIPTION(UUID)

        );

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_MONETIZATION_PLATFORM_CUSTOMERS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_MONETIZATION_PLATFORM_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBER_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            CUSTOMER_ID VARCHAR(256) NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON DELETE CASCADE
        );

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_MONETIZATION_SHARED_CUSTOMERS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_MONETIZATION_SHARED_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            APPLICATION_ID INTEGER NOT NULL,
            API_PROVIDER VARCHAR(256) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SHARED_CUSTOMER_ID VARCHAR(256) NOT NULL,
            PARENT_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (PARENT_CUSTOMER_ID) REFERENCES AM_MONETIZATION_PLATFORM_CUSTOMERS(ID) ON DELETE CASCADE
        );

        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_MONETIZATION_SUBSCRIPTIONS]') AND TYPE IN (N'U'))
        CREATE TABLE AM_MONETIZATION_SUBSCRIPTIONS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBED_APPLICATION_ID INTEGER NOT NULL,
            SUBSCRIBED_API_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SUBSCRIPTION_ID VARCHAR(256) NOT NULL,
            SHARED_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBED_APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (SUBSCRIBED_API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (SHARED_CUSTOMER_ID) REFERENCES AM_MONETIZATION_SHARED_CUSTOMERS(ID) ON DELETE CASCADE
        );
        ```

        ``` java tab="Oracle"
        CREATE TABLE AM_MONETIZATION (
            API_ID INTEGER NOT NULL,
            TIER_NAME VARCHAR(512),
            STRIPE_PRODUCT_ID VARCHAR(512),
            STRIPE_PLAN_ID VARCHAR(512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE
        )
        /

        CREATE TABLE AM_POLICY_PLAN_MAPPING (
                POLICY_UUID VARCHAR(256),
                PRODUCT_ID VARCHAR(512),
                PLAN_ID VARCHAR(512),
                FOREIGN KEY (POLICY_UUID) REFERENCES AM_POLICY_SUBSCRIPTION(UUID)
        )
        /

        CREATE TABLE AM_MONETIZATION_PLATFORM_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBER_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            CUSTOMER_ID VARCHAR(256) NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON DELETE CASCADE
        )
        /

        CREATE TABLE AM_MONETIZATION_SHARED_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            APPLICATION_ID INTEGER NOT NULL,
            API_PROVIDER VARCHAR(256) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SHARED_CUSTOMER_ID VARCHAR(256) NOT NULL,
            PARENT_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (PARENT_CUSTOMER_ID) REFERENCES AM_MONETIZATION_PLATFORM_CUSTOMERS(ID) ON DELETE CASCADE
        )
        /

        CREATE TABLE AM_MONETIZATION_SUBSCRIPTIONS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBED_APPLICATION_ID INTEGER NOT NULL,
            SUBSCRIBED_API_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SUBSCRIPTION_ID VARCHAR(256) NOT NULL,
            SHARED_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBED_APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (SUBSCRIBED_API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (SHARED_CUSTOMER_ID) REFERENCES AM_MONETIZATION_SHARED_CUSTOMERS(ID) ON DELETE CASCADE
        )
        /
        ```

        ``` java tab="Oracle Rac"
        CREATE TABLE AM_MONETIZATION (
            API_ID INTEGER NOT NULL,
            TIER_NAME VARCHAR(512),
            STRIPE_PRODUCT_ID VARCHAR(512),
            STRIPE_PLAN_ID VARCHAR(512),
            FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE
        )
        /

        CREATE TABLE AM_POLICY_PLAN_MAPPING (
                POLICY_UUID VARCHAR(256),
                PRODUCT_ID VARCHAR(512),
                PLAN_ID VARCHAR(512),
                FOREIGN KEY (POLICY_UUID) REFERENCES AM_POLICY_SUBSCRIPTION(UUID)
        )
        /

        CREATE TABLE AM_MONETIZATION_PLATFORM_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBER_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            CUSTOMER_ID VARCHAR(256) NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON DELETE CASCADE
        )
        /

        CREATE TABLE AM_MONETIZATION_SHARED_CUSTOMERS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            APPLICATION_ID INTEGER NOT NULL,
            API_PROVIDER VARCHAR(256) NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SHARED_CUSTOMER_ID VARCHAR(256) NOT NULL,
            PARENT_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (PARENT_CUSTOMER_ID) REFERENCES AM_MONETIZATION_PLATFORM_CUSTOMERS(ID) ON DELETE CASCADE
        )
        /

        CREATE TABLE AM_MONETIZATION_SUBSCRIPTIONS (
            ID INTEGER NOT NULL AUTO_INCREMENT,
            SUBSCRIBED_APPLICATION_ID INTEGER NOT NULL,
            SUBSCRIBED_API_ID INTEGER NOT NULL,
            TENANT_ID INTEGER NOT NULL,
            SUBSCRIPTION_ID VARCHAR(256) NOT NULL,
            SHARED_CUSTOMER_ID INTEGER NOT NULL,    
            PRIMARY KEY (ID),
            FOREIGN KEY (SUBSCRIBED_APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
            FOREIGN KEY (SUBSCRIBED_API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
            FOREIGN KEY (SHARED_CUSTOMER_ID) REFERENCES AM_MONETIZATION_SHARED_CUSTOMERS(ID) ON DELETE CASCADE
        )
        /
        ```

        ``` java tab="Postgre"
            CREATE SEQUENCE AM_MONETIZATION START WITH 1 INCREMENT BY 1;
            CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                API_ID INTEGER NOT NULL,
                TIER_NAME VARCHAR(512),
                STRIPE_PRODUCT_ID VARCHAR(512),
                STRIPE_PLAN_ID VARCHAR(512),
                FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE
            );
        
            CREATE SEQUENCE AM_POLICY_PLAN_MAPPING START WITH 1 INCREMENT BY 1;
            CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                    POLICY_ID INTEGER DEFAULT NEXTVAL('AM_POLICY_PLAN_MAPPING'),
                    POLICY_UUID VARCHAR(256),
                    PRODUCT_ID VARCHAR(512),
                    PLAN_ID VARCHAR(512),
                    FOREIGN KEY (POLICY_UUID) REFERENCES AM_POLICY_SUBSCRIPTION(UUID)
        
            );
        
            CREATE SEQUENCE AM_MONETIZATION_PLATFORM_CUSTOMERS START WITH 1 INCREMENT BY 1;
            CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                        POLICY_ID INTEGER DEFAULT NEXTVAL('AM_MONETIZATION_PLATFORM_CUSTOMERS'),
                ID INTEGER NOT NULL AUTO_INCREMENT,
                SUBSCRIBER_ID INTEGER NOT NULL,
                TENANT_ID INTEGER NOT NULL,
                CUSTOMER_ID VARCHAR(256) NOT NULL,    
                PRIMARY KEY (ID),
                FOREIGN KEY (SUBSCRIBER_ID) REFERENCES AM_SUBSCRIBER(SUBSCRIBER_ID) ON DELETE CASCADE
            );
        
            CREATE SEQUENCE AM_MONETIZATION_SHARED_CUSTOMERS START WITH 1 INCREMENT BY 1;
            CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                        POLICY_ID INTEGER DEFAULT NEXTVAL('AM_MONETIZATION_SHARED_CUSTOMERS'),
                ID INTEGER NOT NULL AUTO_INCREMENT,
                APPLICATION_ID INTEGER NOT NULL,
                API_PROVIDER VARCHAR(256) NOT NULL,
                TENANT_ID INTEGER NOT NULL,
                SHARED_CUSTOMER_ID VARCHAR(256) NOT NULL,
                PARENT_CUSTOMER_ID INTEGER NOT NULL,    
                PRIMARY KEY (ID),
                FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
                FOREIGN KEY (PARENT_CUSTOMER_ID) REFERENCES AM_MONETIZATION_PLATFORM_CUSTOMERS(ID) ON DELETE CASCADE
            );
        
            CREATE SEQUENCE AM_MONETIZATION_SUBSCRIPTIONS START WITH 1 INCREMENT BY 1;
            CREATE TABLE IF NOT EXISTS AM_POLICY_SUBSCRIPTION (
                        POLICY_ID INTEGER DEFAULT NEXTVAL('AM_MONETIZATION_SUBSCRIPTIONS'),
                ID INTEGER NOT NULL AUTO_INCREMENT,
                SUBSCRIBED_APPLICATION_ID INTEGER NOT NULL,
                SUBSCRIBED_API_ID INTEGER NOT NULL,
                TENANT_ID INTEGER NOT NULL,
                SUBSCRIPTION_ID VARCHAR(256) NOT NULL,
                SHARED_CUSTOMER_ID INTEGER NOT NULL,    
                PRIMARY KEY (ID),
                FOREIGN KEY (SUBSCRIBED_APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON DELETE CASCADE,
                FOREIGN KEY (SUBSCRIBED_API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
                FOREIGN KEY (SHARED_CUSTOMER_ID) REFERENCES AM_MONETIZATION_SHARED_CUSTOMERS(ID) ON DELETE CASCADE
            );
        ```

3. Configure the additional monetization properties that are specific to the billing engine in WSO2 API Manager.    

      Add the following configuration in the `<API-M_HOME>/repository/conf/deployment.toml` file.
      
      ``` java tab="Format"
      [[apim.monetization.additional_attributes]]
      name = "<Name of the attribute>"
      display_name = "<Displayed name of the Attribute>"
      required = "<mandatory or not>"
      description = "<Description about the attribute>"
      ```
  
      ``` java tab="Example"
      [[apim.monetization.additional_attributes]]
      name = "ConnectedAccountKey"
      display_name = "ConnectedAccountKey"
      required = "true"
      description = "connected account of the publisher"
      ```
           
      The name property has to be identical to `ConnectedAccountKey`, which is defined in the [wso2-am-stripe-plugin](https://github.com/wso2-extensions/wso2-am-stripe-plugin/blob/master/src/main/java/org.wso2.apim.monetization/impl/StripeMonetizationImpl.java). However, you can add perferred values for the other properties.
 
    After saving these configurations, these additional properties appear in the **Monetization** page under the **Monetization properties** section in the API Publisher Portal.

4. Optionally, configure WSO2 API Manager to work with Choreo Analytics.

     These configurations are required only if you intend to create dynamic plans (usage-based plans) where consumers are charged based on the usage of the API. In such situations, you need analytics to record and retrieve the usage of the monetized APIs. 
    
    1. Enable analytics.
    
        ``` java tab="Format"
         [apim.analytics]
         enable = <true/false>
         config_endpoint = "<Choeo config endpoint>"
         auth_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        ```
     
        ``` java tab="Example"
         [apim.analytics]
         enable = true
         config_endpoint = "https://analytics-event-auth.st.choreo.dev/auth/v1"
         auth_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        ```    
   
    2. Define the Query API endpoint of Choreo Analytics under the monetization configuration.
    
         ``` java tab="Format"
         [apim.monetization]
         analytics_query_api_endpoint= "<Endpoint of the query API>"
         ```

         ``` java tab="Example"
         [apim.monetization]
         analytics_query_api_endpoint= "https://analytics-api.st.choreo.dev/query-api"
         ```     
   
    3. Define the Access Token required to access the above Query API. 
    
         The same access token which is configured under analytcts configuration in step 1 can be configured here.
   
         ``` java tab="Format"
         [apim.monetization]
         analytics_access_token == "<Token to access the Choreo query API>"
         ```

         ``` java tab="Example"
         [apim.monetization]
         analytics_access_token == "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
         ```     
   
5.  Configure the Tenant Admin on WSO2 API Manager.

    1.  Start the WSO2 API Manager server.

    2.  Sign in to the WSO2 API-M Management Console.
       
         `https://<hostname>:9443/carbon`

    3. Click **Main**, navigate to **Resources**, and click **Browse**.
    
    4. Enter the following path in **Location:** and click **Go**.

         `/_system/config/apimgt/applicationdata/tenant-conf.json`

         [![Resources page]({{base_path}}/assets/img/learn/tenant-config.png)]({{base_path}}/assets/img/learn/tenant-config.png)
    
    5. Add the following configuration in the `tenant-conf.json` file using the WSO2 API-M Management Console.  

        ``` json tab="Format"
        "MonetizationInfo": {
            "<key-value-pair>"
        }
        ```

        ``` json tab="Example"
        "MonetizationInfo": {
            "BillingEnginePlatformAccountKey": "sk_test_wBMSreyjGQoczL9uIw6YPYRq00kcHcQqDi"
        }
        ```

        * `<key-value-pair>` - The key-value pair varies based on your monetization interface. There can be multiple key-value pairs.

        * `sk_test_wBMSreyjGQoczL9uIw6YPYRq00kcHcQqDi` - This is the [secret key that corresponds to the Tenant Admin's Stripe account](#tenantSK).

6.  Configure the workflows.

    !!! note
        It is mandatory to comment out or delete the existing default workflow executors.

     You need to do this to ensure that the correct workflows are engaged when a subscription is added or removed.

     1.  Navigate to the **Browse** page.

         1.  Sign in to the WSO2 API-M Management Console.
       
             `https://<hostname>:9443/carbon`

         2. Click **Main**, navigate to **Resources**, and click **Browse**.
    
     2. Enter the following path in the **Location:** text-box and click **Go**.

         `/_system/governance/apimgt/applicationdata/workflow-extensions.xml`

     3.  Edit the workflow executors in the `workflow-extensions.xml` file.

         ``` xml tab="Format"
         <SubscriptionCreation executor="<billing-engine-related-SubscriptionCreationWorkflowExecutor>"/>
         <SubscriptionDeletion executor="<billing-engine-related-StripeSubscriptionDeletionWorkflowExecutor>"/> 
         ```

         ``` xml tab="Example"
         <SubscriptionCreation executor="org.wso2.apim.monetization.impl.workflow.StripeSubscriptionCreationWorkflowExecutor"/>
         <SubscriptionDeletion executor="org.wso2.apim.monetization.impl.workflow.StripeSubscriptionDeletionWorkflowExecutor"/>
         ```            

### Step 1 - Create a subscription policy

1.  Navigate to the WSO2 API Manager admin dashboard.  
     
     `https://<API-M_host>:<port>/admin`

2.  Create a subscription policy.  
     
     Specify the subscription policy-related data based on your monetization goals. For more information, see [Adding a new subscription-level throttling policy](/learn/rate-limiting/adding-new-throttling-policies#Adding-a-new-subscription---level-throttling-tier).

     <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>When using Stripe as a billing engine it only allows you to create monetization plans for commercial business plans. Therefore, make sure to create a subscription policy that has a paid business plan.</p>
      </div> 
     </html>


     <html>
     <head>
     </head>
     <body>
     <img src="{{base_path}}/assets/img/learn/subscription-commercial-tier.png" alt="Subscription to a paid business plan" title="Paid business plan" width="400" />
     </body>
     </html>

     After you save the policy, a plan gets created in the Stripe account of the Tenant Admin.  

     ![Stripe account after creating a paid business plan]({{base_path}}/assets/img/learn/monetization_subscription.png)
     
     When you update the details of this business plan, the plan in Stripe will get updated with the corresponding details. Likewise, when you delete a business plan, the plan in Stripe will get deleted.

### Step 2 - Enable monetization

1.  Sign in to the API Publisher Portal.  
    `https://<hostname>:9443/publisher`

2.  Click on the API that you wish to monetize.  
    ![Enable monetization]({{base_path}}/assets/img/learn/enable-monetization.png)

3.  Click **Monetization** to navigate to the Monetization configurations.

4.  Enter the connect ID as the connected account key and click
    **Save**.  

    When using Stripe as the billing engine, you need to enter the [connect ID](#connectID), which is the ID that indicates the link between the Tenant Admin and the API Publisher Stripe accounts.
        
    The plans get created in Stripe based on the business plan attached to the API.

### Step 3 - Subscribe to a monetized API

[Subscribe to an API]({{base_path}}/consume/manage-subscription/subscribe-to-an-api) and invoke the API. The price of the business plan appears when subscribing to an API. Therefore, the Subscriber can select an appropriate plan and subscribe to it. 

When subscribing to an API, simultaneously a customer is created in the Stripe platform account (e.g., the Stripe account is created for the Tenant Admin). The following screenshot shows the customer record in the platform Stripe account.

![Customer created in stripe]({{base_path}}/assets/img/learn/monetization_customer_created.png)

The following screenshot depicts the details of the newly created customer in the platform Stripe account.

![New customer details]({{base_path}}/assets/img/learn/monetization_new_customer_details.png)

Thereafter, the customer details are copied to the Stripe account of the API Publisher, which is the connected account.

![Shared customer in connected account]({{base_path}}/assets/img/learn/monetization_shared_customer.png)

The following are the details of the shared customer that appears in the
Stripe UI.

![Shared customer details]({{base_path}}/assets/img/learn/monetization_shared_customer_details.png)

Specific Stripe billing plans correspond to specific WSO2 API Manager business plans. Therefore, when an App developer subscribes to an API via the API Developer Portal, Stripe will use the information in their business plan to create a corresponding subscription for the App developer in Stripe.  

<html>
    <div class="admonition note">
        <p class="admonition-title">Note</p>
        <p>The customers are created in Stripe with sample payment(card) details. The real card details should be updated in order to process real payments. Once the real card details are updated for the relevant customer created for a particular subscriber in the platform account, it will be copied when shared customers are created in the connected accounts for the same subscriber there after. So its important that you collect and edit the correct payment details in both platform and connected account for a subscriber when he subscribes for the first time.</p>
        <p>Please refer the [document](https://stripe.com/docs/payments/cards/collecting) to find out how to collect the card details safely in Stripe.</p>
    </div> 
</html>

### Step 4 - Send usage data to the billing engine

You can use the admin REST API, which is available in WSO2 API Manager, to publish the summarized data to Stripe. After this API call takes place, it pushes the usage data to Stripe. After Stripe gets the usage data, it checks for the subscriptions that have completed their billing cycle and charges the customer based on their API usage.

1.  Obtain the consumer key and secret key pair by calling the dynamic client registration endpoint.  
     
     For more information, see [Admin REST API v1.0]({{base_path}}/develop/product-apis/admin-apis/admin-v2/admin-v2/).

    ``` java
    curl -X POST -H "Authorization: Basic <base64encoded-admin-account-credentials>" -H "Content-Type: application/json" -d @payload.json https://localhost:9443/client-registration/v0.17/register
    ```

    -   `<base64encoded-admin-account-credentials>` - [base64 encoded](https://www.base64encode.org) admin user account credentials (in `<username>:<password>` format).
    - `payload.json` should take the following format.
        ```json
        "callbackUrl": "www.google.lk",
        "clientName": "rest_api_admin",
        "owner": "admin",
        "grantType": "password refresh_token",
        "saasApp": true
        ```

2.  Obtain a token with the monetization usage scope (`scope=apim:monetization_usage_publish`).

    ``` java
    curl -X POST https://localhost:8243/token -H 'Authorization: Basic <base64encoded-registeration-credentials>' -d 'grant_type=password&username=admin&password=admin&scope=apim:monetization_usage_publish'
    ```
      
    -   `<base64encoded-registeration-credentials>` - [base64 encoded](https://www.base64encode.org) client credentials received as the response in the client registration step (in `<client-id>:<client-secret>` format).
    
3.  Publish usage data to the Stripe billing engine.

    ``` java
    curl -k -H "Authorization: Bearer <monetization-usage-publish-token>" -X POST -H "Content-Type: application/json" https://localhost:9443/api/am/admin/v1/monetization/publish-usage
    ```

    -   `<monetization-usage-publish-token>` - Token obtained using client credentials with `monetization_usage_publish` scope in the previous step.

    The REST API response is as follows:

    ``` java
    {"status":"Request Accepted","message":"Server is running the usage publisher"}
    ```

    After making an admin API call the bill gets generated in the Stripe connected account.

    ![Pricing]({{base_path}}/assets/img/learn/monetization_pricing_bill.png) The charging process takes place at the end of the billing cycle. As this example scenario uses a usage-based business plan, the payment that the subscribers make for their bills are sent to the API Publisher via the billing engine.

4.  Monitor the status of the last usage publishing job.

    When you call the Admin API to publish usage data, a separate job in a separate thread is created to publish usage data to the billing engine. The status of the above job can be monitored as follows.
  
    ``` java
    curl -k -H "Authorization: Bearer <monetization-usage-publish-token>" -X GET -H "Content-Type: application/json" https://localhost:9443/api/am/admin/v1/monetization/publish-usage/status
    ```
    -   `<monetization-usage-publish-token>` - The same token that you got with the monetization usage scope in previous steps.

    The sample response will be as follows

    ``` java
    {"state": "COMPLETED", "status": "SUCCESSFUL", "startedTime": "1571748288000", "lastPublsihedTime": "1571661888000"}
    ```

### Step 5 - Monitor usage of a monetized API

Two types of business plans are available for monetized APIs namely, the fixed business plan and the dynamic business plan. Dynamic business plans are based on the subscribers' API usage. However, users who are on fixed business plans are charged a fixed price irrespective of their API usage. When deciding on a business plan, the Publisher takes into account the type of the API, the value that the API creates, and its organization business model.

The monitoring of API usage is only done for APIs associated with dynamic business plans (metered billing). When an API request is initiated, the API Gateway publishes the analytics related to that request. The successful API calls are recorded in the database, and this data is used to calculate the API usage and charge the subscriber.

#### View the invoice via the API Developer Portal

The Application Developers who are subscribed to a dynamic business plan can sign in to the API Developer Portal to view the billing details of their subscription from the start of the current billing cycle to the current date, which is the date of viewing the bill.

1. Sign in to the API Developer Portal.  
    `https://<hostname>:9443/devportal`

2. Click **Applications** and click **Subscriptions**.

     The list of subscriptions that correspond to the API appears.

     ![Subscription details via the API Publisher Portal]({{base_path}}/assets/img/learn/subscription-dev-portal.png)

3. Click **View Invoice** to view the invoice corresponding to a specific API.

     <html>
    <head>
    </head>
    <body>
    <img src="{{base_path}}/assets/img/learn/invoice-details.png" alt="Subscriber's Invoice details" title="Subscriber's invoice details" width="500" />
    </body>
     </html>


#### View the invoice via the API Publisher

The API Publisher can access the billing information related to each of the subscriptions that correspond to a specific API via the API Publisher Portal to view their revenue.

1.  Sign in to the API Publisher Portal.  
    `https://<hostname>:9443/publisher`

2. Click on the specific monetized API.

3. Click **Subscriptions**.

     The list of subscriptions that correspond to the API appears.

     ![Subscription details via the API Publisher Portal]({{base_path}}/assets/img/learn/subscription-details-publisher.png)

4. Click **View Invoice** to view the invoice that corresponds to a specific subscriber.

     <html>
    <head>
    </head>
    <body>
    <img src="{{base_path}}/assets/img/learn/invoice-details.png" alt="Invoice details" title="Invoice details" width="500" />
    </body>
     </html>

## Disable monetization

Follow the instructions below to disable monetization for an API:

1.  Sign in to the API Publisher Portal.  
    `https://<hostname>:9443/publisher`

2.  Click on the monetized API for which you need to disable monetization.

3.  Click **Monetization** to go to the Monetization configurations.  
    ![Disable monetization]({{base_path}}/assets/img/learn/disable-monetization.png)

4.  Enter the [connect ID](#connectID) as the connected account key

5.  .Click **Enable Monetization** to unselect the enable monetization option.

6.  Click **Save**.  
    
     The products and plans are removed in the Stripe billing engine based on the business plan attached to the API.

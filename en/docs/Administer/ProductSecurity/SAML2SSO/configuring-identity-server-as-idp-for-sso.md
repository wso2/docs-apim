# Configuring Identity Server as IDP for SSO

The **Single Sign-On with SAML 2.0** feature in the API Manager is implemented according to the SAML 2.0 browser-based SSO support that is facilitated by WSO2 Identity Server (WSO2 IS). This feature is available in any WSO2 IS version from 4.1.0 onwards. We use **WSO2 IS 5.7.0** in this guide. WSO2 Identity Server acts as an identity service provider of systems enabled with single sign-on, while the Web applications act as SSO service providers. Using this feature, you can configure SSO across the API Publisher and Store. After configuring, you can access the API Store or API Publisher in a single authentication attempt.

The topics below explain the configurations.

!!! tip
In this documentation, MySQL is used as the database to configure WSO2 API Manager with WSO2 Identity Server. For instructions on replacing the default H2 database with MySQL, see [Setting up MySQL](https://docs.wso2.com/display/ADMIN44x/Setting+up+MySQL) .


-   [Sharing the user store](#ConfiguringIdentityServerasIDPforSSO-Sharingtheuserstore)
-   [Sharing the registry space](#ConfiguringIdentityServerasIDPforSSO-Sharingtheregistryspace)
-   [Configuring WSO2 Identity Server as a SAML 2.0 SSO Identity Provider](#ConfiguringIdentityServerasIDPforSSO-ConfiguringWSO2IdentityServerasaSAML2.0SSOIdentityProvider)
-   [Configuring WSO2 API Manager apps as SAML 2.0 SSO service providers](#ConfiguringIdentityServerasIDPforSSO-ConfiguringWSO2APIManagerappsasSAML2.0SSOserviceproviders)

### Sharing the user store

Initially, configure your user store(s), if you have not done so already, by following the instructions in [Configuring User Stores](_Configuring_User_Stores_) . Thereafter, point both WSO2 IS and WSO2 API Manager to your user stores(s) using the instructions given below.You do this to make sure that a user who tries to log in to the API Manager console, the API Store or the Publisher is authorized. When a user tries to log in to either of the three applications, s/he is redirected to the configured identity provider (WSO2 IS in this case) where s/he provides the login credentials to be authenticated. In addition to this, the user should also be authorized by the system as some user roles do not have permission to perform certain actions. For the purpose of authorization, the IS and API Manager need to have a shared user store and user management database (by default, this is the H2 database in the `<API-M_HOME>/repository/conf/user-mgt.xml` file) where the user's role and permissions are stored.

For example, let's share a JDBC user store (MySQL) with both the WSO2 Identity Server and WSO2 API Manager as follows:

1.  Download WSO2 API Manager from [here](https://wso2.com/api-management/) and unzip it. `<API-M_HOME>` refers to the root folder where WSO2 API-M was unzipped.

2.  Create a MySQL database (e.g., 410\_um\_db) and run the `<API-M_HOME>/dbscripts/mysql.sql` script on it to create the required tables.

        !!! note
    There are two MySQL DB scripts available in the product distribution from WSO2 Carbon Kernel 4.4.6 onwards. Click [here](https://docs.wso2.com/display/AM260/FAQ#FAQ-WhichMySQLdatabasescriptshouldIuse?) to identify as to which version of the MySQL script to use. If you are using a different database type, find the relevant script from the `<API-M_HOME>/dbscripts` directory.


3.  Open the `<API-M_HOME>/repository/conf/datasources/master-datasources.xml` file and add the datasource configuration for the database that you use for the shared user store and user management information. For example, you can share as single user store as follows. If you are sharing multiple datasources, you need to define a datasource for each of the user stores that you are working with, so that they can be shared.

    **Example**

    ``` java
        <datasource>
             <name>WSO2_UM_DB</name>
             <description>The datasource used for registry and user manager</description>
             <jndiConfig>
                      <name>jdbc/WSO2UMDB</name>
             </jndiConfig>
             <definition type="RDBMS">
                      <configuration>
                          <url>jdbc:mysql://localhost:3306/410_um_db</url>
                          <username>username</username>
                          <password>password</password>
                          <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                          <maxActive>50</maxActive>
                          <maxWait>60000</maxWait>
                          <testOnBorrow>true</testOnBorrow>
                          <validationQuery>SELECT 1</validationQuery>
                          <validationInterval>30000</validationInterval>
                      </configuration>
               </definition>
        </datasource>
    ```

        !!! note
    Change the database url to the url of the MySQL database you have created above. Modify the username and password parameters in above configuration with your mysql database credentials.

        !!! info
    Refer [Configuring master-datasources.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+master-datasources.xml) for descriptive information about each property of the datasource configuration.


4.  Download WSO2 Identity Server (WSO2 IS) 5.7.0 from [here](https://wso2.com/identity-and-access-management) and unzip it. `<IS_HOME>` refers to the root folder where WSO2 IS was unzipped.

        !!! tip
    To use WSO2 IS as the Key Manager, download the **WSO2 Identity Server 5.7.0 as a Key Manager** pack, with pre-packaged Key Manager features, from [here](https://wso2.com/identity-and-access-management) .


5.  Add the same datasource configuration above to `<IS_HOME>/repository/conf/datasources/master-datasources.xml` file.

6.  Copy the database driver JAR file to the `<IS_HOME>/repository/components/lib` and `<API-M_HOME>/repository/components/lib` directories.

7.  Open the `<API-M_HOME>/repository/conf/user-mgt.xml` file. The `dataSource` property points to the default H2 database. Change it to the jndiConfig name given above (i.e., `jdbc/WSO2UMDB` ). This changes the datasource reference that is pointing to the default H2 database.

    ``` html/xml
        <Realm>
                <Configuration>
                    ...
                    <Property name="dataSource">jdbc/WSO2UMDB</Property>
                </Configuration>
                ...
        </Realm> 
    ```

8.  Add the same configuration above to the `<IS_HOME>/repository/conf/user-mgt.xml` file.
9.  The Identity Server has an embedded LDAP user store by default. As this is enabled by default, follow the instructions in [Internal JDBC User Store Configuration](Configuring-Primary-User-Stores_103333489.html#ConfiguringPrimaryUserStores-Configuringaninternal/externalJDBCuserstore) to disable the default LDAP and enable the JDBC user store instead.

        !!! note
    In WSO2 API Manager, the JDBC User Store is enabled by default. By changing the default user store of WSO2 Identity server to JDBC User Store, we are pointing both WSO2 API Manager and WSO2 Identity Server to the same user store so that, their user stores are shared.


### Sharing the registry space

In a multi-tenanted environment, by default, the Identity Server uses the key store of the super tenant to sign SAML responses. The API Store and Publishers are already registered as SPs in the super tenant. However, if you want the Identity Server to use the registry key store of the tenant that the user belongs to, you can create a common registry database and mount it on both the IS and the APIM.

1.  Create a MySQL database (e.g., registry) and run the `<IS_HOME>/dbscripts/mysql.sql` script on it to create the required tables.
    If you are using a different database type, find the relevant script from the `<IS_HOME>/dbscripts` directory.

        !!! note
    There are two MySQL DB scripts available in the product distribution f rom WSO2 Carbon Kernel 4.4.6 onwards . Click [here](https://docs.wso2.com/display/AM260/FAQ#FAQ-WhichMySQLdatabasescriptshouldIuse?) to identify as to which version of the MySQL script to use.


2.  Add the following datasource configuration to both the `<IS_HOME>/repository/conf/datasources/master-datasources.xml` and `<API-M_HOME>/repository/conf/datasources/master-datasources.xml` files.

    ``` xml
        <datasource>
            <name>WSO2REG_DB</name>
            <description>The datasource used for registry</description>
            <jndiConfig>
                <name>jdbc/WSO2REG_DB</name>
            </jndiConfig>
            <definition type="RDBMS">
                <configuration>
                    <url>jdbc:mysql://localhost:3306/registry?autoReconnect=true&amp;relaxAutoCommit=true&amp;</url>
                    <username>apiuser</username>
                    <password>apimanager</password>
                    <driverClassName>com.mysql.jdbc.Driver</driverClassName>
                    <maxActive>50</maxActive>
                    <maxWait>60000</maxWait>
                    <testOnBorrow>true</testOnBorrow>
                    <validationQuery>SELECT 1</validationQuery>
                    <validationInterval>30000</validationInterval>
                </configuration>
            </definition>
        </datasource> 
    ```

        !!! note
    Modify the username and password parameters of above configuration with your mysql database credentials.

        !!! info
    Refer [Configuring master-datasources.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+master-datasources.xml) for descriptive information about each property of the datasource configuration.


3.  Create the registry mounts by inserting the following sections into the `<IS_HOME>/repository/conf/registry.xml` file.

        !!! tip
    When doing this change, do not replace the existing `<dbConfig>` for " `wso2registry` ". Simply add the following configuration to the existing configurations.


    ``` xml
        <dbConfig name="govregistry">
                <dataSource>jdbc/WSO2REG_DB</dataSource>
        </dbConfig>
         
        <remoteInstance url="https://localhost">    
                <id>gov</id>
                <dbConfig>govregistry</dbConfig>
                <readOnly>false</readOnly>
                <enableCache>true</enableCache>
                <registryRoot>/</registryRoot>
        </remoteInstance>
         
        <mount path="/_system/governance" overwrite="true">
                <instanceId>gov</instanceId>
                <targetPath>/_system/governance</targetPath>
        </mount>
         
        <mount path="/_system/config" overwrite="true">
               <instanceId>gov</instanceId>
               <targetPath>/_system/config</targetPath>
        </mount>
    ```

        !!! info
    Refer [Configuring registry.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+registry.xml) for more details on configuration details and usage of registry.xml


4.  Repeat the above step in the `<API-M_HOME>/repository/conf/registry.xml` file as well.

Next, let us look at the SSO configurations.

### Configuring WSO2 Identity Server as a SAML 2.0 SSO Identity Provider

1.  Start WSO2 Identity Server.

    ``` java
        ./wso2server.sh -DportOffset=1
    ```

        !!! tip
    You also can change Port offset value by changing `<Offset> 1 </Offset>` under `<Ports>` in `<IS_HOME>/repository/conf/carbon.xml file.                     `

        !!! info
    What is port offset?

    The port offset feature allows you to run multiple WSO2 products, multiple instances of a WSO2 product, or multiple WSO2 product clusters on the same server or virtual machine (VM). The port offset defines the number by which all ports defined in the runtime, such as the HTTP/S ports, will be offset. For example, if the HTTPS port is defined as 9443 and the portOffset is 1, the effective HTTPS port will be 9444.


2.  Sign in to the WSO2 IS Management Console UI ( `https://localhost:9444/carbon)` .

        !!! tip
    If you use signin pages that are hosted externally to sign in to the Identity Server, give the absolute URLs of those login pages in the `authenticators.xml` and `application-authenticators.xml` files in the `<IS_HOME>/repository/conf/identity` directory.


3.  Select **Add** under the **Service Providers** menu.
    ![]({{base_path}}/assets/attachments/103333476/103333477.png)
4.  Give a service provider name and click **Register** .
    ![]({{base_path}}/assets/attachments/103333476/103333483.png){height="250"}

        !!! tip
    **In a multi tenanted environment,** for all tenants to be able to log in to the APIM Web applications, do the following:

    -   Click the **SaaS Application** option that appears after registering the service provider.
        ![]({{base_path}}/assets/attachments/103333476/103333482.png)
        If not, only users in the current tenant domain (the one you are defining the service provider in) will be allowed to log in to the Web application and you have to register new service providers for all Web applications (API Store and API Publisher in this case) from each tenant space separately. For example, let's say you have three tenants as TA, TB and TC and you register the service provider in TA only. If you tick the **SaaS Application** option, all users in TA, TB, TC tenant domains will be able to log in. Else, only users in TA will be able to log in.

    -   Add the following inside the `<SSOService>` element in the `<IS_HOME>/repository/conf/identity/identity.xml` file and restart the server.

        ``` java
                <SSOService>
                      <UseAuthenticatedUserDomainCrypto>true</UseAuthenticatedUserDomainCrypto>
                      ...
                </SSOService>
        ```

        If not, you get an exception as SAML response signature verification fails.

    -   Because the servers in a multi-tenanted environment interact with all tenants, all nodes should share the same user store. Therefore, make sure you have a shared registry (JDBC mount, WSO2 Governance Registry etc.) instance across all nodes.


5.  You are navigated to the detailed configuration page. Inside the **Inbound Authentication Configuration** section, expand **SAML2 Web SSO Configuration** and click **Configure** .
    ![]({{base_path}}/assets/attachments/103333476/103333481.png)
        !!! note
    To enable tenant specific SSO with IS 5.7.0 for `API_PUBLISHER` and `API_STORE` , enable **Use tenant domain in local subject identifier** under the Local & Outbound Authentication Configuration section.

    ![]({{base_path}}/assets/attachments/103333476/103333478.png)

6.  Provide the configurations to register the API Publisher as the SSO service provider. These sample values may change depending in your configuration.

    -   Issuer: API\_PUBLISHER
    -   Assertion Consumer URL: `https://localhost:9443/publisher/jagg/jaggery_acs.jag` . Change the IP and port accordingly. This is the URL for the Assertion Consumer Services (ACS) page in your running publisher app.
    -   Select the following options:

        -   **Enable Response Signing**

        -   **Enable Single Logout**

    -   Click **Register** once done.

For example:
![]({{base_path}}/assets/attachments/103333476/103333479.png)
Similarly, provide the configurations to register the API Store as the SSO service provider. These sample values may change depending in your configuration.

-   Issuer: API\_STORE
-   Assertion Consumer URL: `https://localhost:9443/store/jagg/jaggery_acs.jag` . Change the IP and port accordingly. This is the URL for the Assertion Consumer Services (ACS) page in your running Store app.
-   Select the following options:
    -   **Enable Response Signing**
    -   **Enable Single Logout**
-   Click **Register** once done.

Make sure that the `responseSigningEnabled` element is set to `true` in both the following files:

-`<API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/site/conf/site.json`
-`<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json`

### Configuring WSO2 API Manager apps as SAML 2.0 SSO service providers

1.  Open `<API-M_Home>/repository/deployment/server/jaggeryapps/publisher/site/conf/site.json` and modify the following configurations found under **ssoConfiguration** .
    -   **enabled:** Set this value to **true** to enable SSO in the application
    -   **issuer:** `API_PUBLISHER` . This value can change depending on the **Issuer** value defined in WSO2 IS SSO configuration above.
    -   **identityProviderURL:** <https://localhost:9444/samlsso> . Change the IP and port accordingly. This is the redirecting SSO URL in your running WSO2 IS server instance.
    -   **keyStoreName:** The keystore of the running IDP. As you use a remote instance of WSO2 IS here, you can import the public certificate of the IS keystore to the APIM and then point to the APIM keystore. The default keystore of the APIM is `<API-M_HOME>/repository/resources/security/wso2carbon.jks` . **Be sure to give the full path of the keystore here** .
    -   **keyStorePassword:** Password for the above keystore. The default keyStorePassword is `wso2carbon` .
    -   **identityAlias:** wso2carbon
2.  Similarly, configure the API Store with SSO. The only difference in API Store SSO configurations is setting **API\_STORE** as the **issuer** .

3.  Reduce the priority of the `SAML2SSOAuthenticator` configuration in the `<API-M_HOME>/repository/conf/security/authenticators.xml` file.
    You do this as a workaround for a known issue that will be fixed in a future release. The `SAML2SSOAuthenticator` handler does not process only SAML authentication requests at the moment. If you set its priority higher than that of the `BasicAuthenticator` handler, the `SAML2SSOAuthenticator` tries to process the basic authentication requests as well. This causes login issues in the API Publisher/Store.
    ``` java
        <Authenticator name="SAML2SSOAuthenticator" disabled="false">
           <Priority>0</Priority>
           ....
        </Authenticator>
    ```

        !!! note
        You can skip this step if you are using Identity Server 5.7.0 as the IDP.

4.  Access the API Publisher: `https://localhost:/publisher` (e.g., `https://localhost:9443/publisher` ). Observe the request redirect to the WSO2 IS SAML2.0 based SSO login page. For example,
    ![]({{base_path}}/assets/attachments/103333476/103333480.png)5.  Enter user credentials. If the user authentication is successful against WSO2 IS, it will redirect to the API Publisher Web application with the user already authenticated.
6.  Access the API Store application, click its **Login** link (top, right-hand corner) and verify that the same user is already authenticated in API Store.

!!! note
Even with SSO enabled, if the user doesn't have sufficient privileges to access API Publisher/Store or any other application, s/he will not be authorized to access them.

!!! info
To learn more about Single Sign-On with WSO2 Identity Server, see [SAML 2.0 Web SSO](https://docs.wso2.com/display/IS570/SAML+2.0+Web+SSO) in the WSO2 Identity Server documentation.



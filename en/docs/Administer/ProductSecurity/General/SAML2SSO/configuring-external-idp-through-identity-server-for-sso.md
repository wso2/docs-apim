# Configuring External IDP through Identity Server for SSO

The topics below explain the configurations you need to make to configure an external IDP through WSO2 Identity Server.

-   [Sharing the user store](#ConfiguringExternalIDPthroughIdentityServerforSSO-Sharingtheuserstore)
-   [Sharing the registry space](#ConfiguringExternalIDPthroughIdentityServerforSSO-Sharingtheregistryspace)
-   [Configuring WSO2 Identity Server as a SAML 2.0 SSO Identity Provider](#ConfiguringExternalIDPthroughIdentityServerforSSO-ConfiguringWSO2IdentityServerasaSAML2.0SSOIdentityProvider)
-   [Configuring WSO2 API Manager apps as SAML 2.0 SSO service providers](#ConfiguringExternalIDPthroughIdentityServerforSSO-ConfiguringWSO2APIManagerappsasSAML2.0SSOserviceproviders)

### Sharing the user store

First you need to point both WSO2 IS and WSO2 API Manager to a single user store.

You do this to make sure that a user who tries to log in to the API Manager console, the API Store or the API Publisher is authorized. When a user tries to log in to either of the three applications, s/he is redirected to the configured identity provider (WSO2 IS, in this case) where s/he provides the login credentials to be authenticated. In addition to this, the user should also be authorized by the system as some user roles do not have permission to perform certain actions. For the purpose of authorization, the IS and API Manager need to have a shared user store and user management database (by default, this is the H2 database in the `         <API-M_HOME>/repository/conf/user-mgt.xml        ` file) where the user's role and permissions are stored.

For example, let's take a common JDBC user store (MySQL) for both the IS and API Manager.

!!! note
Refer [Configuring User Stores](_Configuring_User_Stores_) for more information on Configuring different types of user stores.


1.  Create a MySQL database (e.g., 410\_um\_db) and run the `           <API-M_HOME>/dbscripts/mysql.sql          ` script on it to create the required tables.
    If you are using a different database type, find the relevant script from the `           <API-M_HOME>/dbscripts          ` directory.

        !!! note
    `           <API-M_HOME>/dbscripts/mysql.sql          ` is the script that should be used to run on the `           410_um_db          ` database for MySQL 5.6 and prior versions. If you database is MySQL 5.7 or later version, use `           <API-M_HOME>/dbscripts/mysql5.7.sql          ` script file.


2.  Open the `           <API-M_HOME>/repository/conf/datasources/master-datasources.xml          ` file and add the datasource configuration for the database that you use for the shared user store and user management information. For example,

    ``` html/xml
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

        !!! info
    Refer Configuring master-datasources.xml for descriptive information about each property of the datasource configuration.


3.  Add the same datasource configuration above to the `           <IS_HOME>/repository/conf/datasources/master-datasources.xml          ` file.

4.  Copy the database driver JAR file to the `           <IS_HOME>/repository/components/lib          ` and `           <API-M_HOME>/repository/components/lib          ` directories.

5.  Open the `           <API-M_HOME>/repository/conf/user-mgt.xml          ` file. The `           dataSource          ` property points to the default H2 database. Change it to the jndiConfig name given above (i.e., `           jdbc/WSO2UMDB          ` ). This changes the datasource reference that is pointing to the default H2 database.

    ``` html/xml
        <Realm>
                <Configuration>
                    ...
                    <Property name="dataSource">jdbc/WSO2UMDB</Property>
                </Configuration>
                ...
        </Realm> 
    ```

6.  Add the same configuration above to the `          <IS_HOME>/repository/conf/user-mgt.xml         ` file.
7.  The Identity Server has an embedded LDAP user store by default. As this is enabled by default, follow the instructions in [Internal JDBC User Store Configuration](Configuring-Primary-User-Stores_103333489.html#ConfiguringPrimaryUserStores-Configuringaninternal/externalJDBCuserstore) to disable the default LDAP and enable the JDBC user store instead.

### Sharing the registry space

In a multi-tenanted environment, by default, the Identity Server uses the key store of the super tenant to sign SAML responses. The API Store and API Publisher are already registered as SPs in the super tenant. However, if you want the Identity Server to use the registry key store of the tenant that the user belongs to, you can create a common registry database and mount it on both the IS and the API Manager.

1.  Create a MySQL database (e.g., registry) and run the `           <IS_HOME>/dbscripts/mysql.sql          ` script on it to create the required tables.
    If you are using a different database type, find the relevant script from the `           <IS_HOME>/dbscripts          ` directory.

2.  Add the following datasource configuration to both the `           <IS_HOME>/repository/conf/datasources/master-datasources.xml          ` and `           <API-M_HOME>/repository/conf/datasources/master-datasources.xml          ` files.

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

3.  Create the registry mounts by inserting the following sections into the `           <IS_HOME>/repository/conf/registry.xml          ` file.

        !!! tip
    When doing this change, do not replace the existing `           <dbConfig>          ` for " `           wso2registry          ` ". Simply add the following configuration to the existing configurations. Refer [Configuring registry.xml](https://docs.wso2.com/display/ADMIN44x/Configuring+registry.xml) for more information on the parameters used in configuring registry.xml


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

4.  Repeat the above step in the `           <API-M_HOME>/repository/conf/registry.xml          ` file as well.

Next, let us look at the SSO configurations.

### Configuring WSO2 Identity Server as a SAML 2.0 SSO Identity Provider

1.  Start the IS server and log in to its Management Console ( `                       https://localhost:9444/carbon                      )          ` .

        !!! tip
    If you use login pages that are hosted externally to log in to the Identity Server, give the absolute URLs of those login pages in the `           authenticators.xml          ` and `           application-authenticators.xml          ` files in the `           <IS_HOME>/repository/conf/identity          ` directory.


2.  Click **Add** under the **Service Providers** menu.
    ![](attachments/103333463/103333469.png)
3.  Give a service provider name and click **Register** .
    ![](attachments/103333463/103333466.png)

        !!! tip
    **In a multi tenanted environment,** for all tenants to be able to log in to the API Manager web applications, do the following:

    -   Click the **SaaS Application** option that appears after registering the service provider.
        ![](attachments/103333463/103333464.png)
        If not, only users in the current tenant domain (the one you are defining the service provider in) will be allowed to log in to the web application and you have to register new service providers for all web applications (API Store and API Publisher in this case) from each tenant space separately. For example, let's say you have three tenants as TA, TB and TC and you register the service provider in TA only. If you tick the **SaaS Application** option, all users in TA, TB, TC tenant domains will be able to log in. Otherwise, only users in TA will be able to log in.

    -   Add the following inside the `             <SSOService>            ` element in the `             <IS_HOME>/repository/conf/identity/identity.xml            ` file and restart the server.

        ``` java
                <SSOService>
                      <UseAuthenticatedUserDomainCrypto>true</UseAuthenticatedUserDomainCrypto>
                      ...
                </SSOService>
        ```

        If not, you get an exception stating that the SAML response signature verification fails.

    -   Since the servers in a multi-tenanted environment interact with all tenants, all nodes should share the same user store. Therefore, make sure you have a shared registry (JDBC mount, WSO2 Governance Registry etc.) instance across all nodes.


4.  You are navigated to the detailed configuration page. Inside the **Inbound Authentication Configuration** section, expand **SAML2 Web SSO Configuration** and click **Configure** .
    ![](attachments/103333463/103333465.png)

        !!! note
    To enable tenant specific SSO with IS 5.7.0 for API\_PUBLISHER and API\_STORE, enable **Use tenant domain in local subject identifier** under the Local & Outbound Authentication Configuration section.

    ![](attachments/103333463/103333468.png)


5.  Provide the configurations to register the API Publisher as the SSO service provider. These sample values may change depending on your configuration.

    -   Issuer: API\_PUBLISHER
    -   Assertion Consumer URL: `                           https://localhost:9443/publisher/jagg/jaggery_acs.jag                         ` Change the IP and port accordingly. This is the URL for the acs page in your running publisher app.
    -   Select the following options:

        -   **Enable Response Signing**

        -   **Enable Single Logout**

        -   **Enable Attribute Profile**

            -   **Include Attributes in the Responses Always**

    -   Click **Register** once done.

For example:
![](attachments/103333463/103333470.png)
Similarly, provide the configurations to register the API Store as the SSO service provider. These sample values may change depending in your configuration.

-   Issuer: API\_STORE
-   Assertion Consumer URL: `                           https://localhost:9443/store/jagg/jaggery_acs.jag                         ` Change the IP and port accordingly. This is the URL for the acs page in your running store app.
-   Select the following options:
    -   **Enable Response Signing**
    -   **Enable Single Logout**
    -   **Enable Attribute Profile**

        -   **Include Attributes in the Responses Always**

-   Click **Register** once done.

Make sure that the `           responseSigningEnabled          ` element is set to `           true          ` in both the following files:

!!! note
This is used to sign the SAML2 Responses returned after the authentication process is complete.


-   `            <API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/site/conf/site.json           `
-   `            <API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json           `

Add a new Identity Provider in WSO2 Identity Server. For more details on configuring external IDPs in WSO2 IS, see [Configuring an Identity Provider](https://docs.wso2.com/display/IS570/Configuring+an+Identity+Provider) .

-   Identity Provider Name: ExternalIS
-   Do the following changes under Federated Authenticators &gt; SAML2 Web SSO Configurations
    -   **Enable SAML2 Web SSO**
    -   Check **Default**
    -   Set **Service Provider Entity ID**
    -   Set SSO URL for the external IDP (e.g., https://localhost/ :9453/samlsso)
    -   **Enable Logout**

Enable JIT Provisioning for the external IDP. For more information, see [Configuring Just-In-Time Provisioning for an Identity Provider](https://docs.wso2.com/display/IS570/Configuring+Just-In-Time+Provisioning+for+an+Identity+Provider) .

Map the external IDP roles to the roles configured in API Manager. For more information on mapping roles, see [Configuring Roles for an Identity Provider](https://docs.wso2.com/display/IS570/Configuring+Roles+for+an+Identity+Provider) .
![](attachments/103333463/103333473.png)
Open the management console, and click **Edit** under **Service Providers.**

Under **Local & Outbound Authentication Configuration** select **Federated Authentication** . Select the newly created external IDP.
![](attachments/103333463/103333472.png)

Add `                       http://wso2.org/claims/role                     ` as the Claim URI under **Claim Configuration.** Select the **Mandatory Claim** check box. ** Add `                       http:/wso2.org/claims/username                     ` as the Subject Claim URI. **
![](attachments/103333463/103333471.png)
!!! tip
Additionally, you might need to configure claims to map them to the available claims in WSO2 Identity Server. For more details, see [Configuring Claims for an Identity Provider](https://docs.wso2.com/display/IS570/Configuring+Claims+for+an+Identity+Provider) .


**
**

### Configuring WSO2 API Manager apps as SAML 2.0 SSO service providers

1.  Open the `          <API-M_Home>/repository/deployment/server/jaggeryapps/publisher/site/conf/site.json         ` and modify the following configurations found under **ssoConfiguration** .
    -   **enabled** : Set this value to **true** to enable SSO in the application
    -   **issuer** : API\_PUBLISHER. This value can change depending on the **Issuer** value defined in the WSO2 IS SSO configuration above.
    -   **identityProviderURL** : <https://localhost:9444/samlsso> . Change the IP and port accordingly. This is the redirecting SSO URL in your running WSO2 IS server instance.
    -   **keyStoreName** : The keystore of the running IDP. As you use a remote instance of WSO2 IS here, you can import the public certificate of the IS keystore to the API Manager and then point to the API Manager keystore. The default keystore of the API Manager is `            <API-M_HOME>/repository/resources/security/wso2carbon.jks           ` . **Make sure you give the full path of the keystore here** .
    -   **keyStorePassword** : Password for the above keystore
    -   **identityAlias** : wso2carbon
2.  Similarly, configure the API Store with SSO. The only difference in API Store SSO configurations is setting **API\_STORE** as the **issuer** .

3.  Reduce the priority of the `           SAML2SSOAuthenticator          ` configuration in the `           <API-M_HOME>/repository/conf/security/authenticators.xml          ` file.
    You do this as a workaround for a known issue that will be fixed in a future release. The `           SAML2SSOAuthenticator          ` handler does not process only SAML authentication requests at the moment. If you set its priority higher than that of the `           BasicAuthenticator          ` handler, the `           SAML2SSOAuthenticator          ` tries to process the basic authentication requests as well. This causes login issues in the API Publisher/Store.
    ``` java
        <Authenticator name="SAML2SSOAuthenticator" disabled="false">
           <Priority>0</Priority>
           ....
        </Authenticator>
    ```

        !!! note
        You can skip this step if you are using Identity Server 5.7.0 as the IDP.

4.  Access the API Publisher (e.g., `                     https://localhost:9443/publisher                   ` ). Observe the request redirecting to the WSO2 IS SAML2.0 based SSO login page. For example,
    ![](attachments/103333463/103333467.png)
5.  Enter the user credentials. If the user authentication is successful against WSO2 IS, it redirects to the API Publisher with the user that is already authenticated.
6.  Access the API Store, click its **Login** link (top, right-hand corner) and verify that the same user is already authenticated in the API Store.

!!! note
Even with SSO enabled, if the user doesn't have sufficient privileges to access the API Publisher/Store or any other application, s/he will not be authorized to access them.

!!! info
To learn more about Single Sign-On with WSO2 Identity Server, see [SAML 2.0 Web SSO](https://docs.wso2.com/display/IS570/SAML+2.0+Web+SSO) in the WSO2 Identity Server documentation.



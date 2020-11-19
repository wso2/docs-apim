# Configuring Identity Server as IDP for SSO

!!! info
    The **Single Sign-On with OpenID Connect** feature is enabled by default in the API Manager.  
    
The **Single Sign-On with SAML 2.0** feature in the API Manager is implemented according to the SAML 2.0 browser-based SSO support that is facilitated by WSO2 Identity Server (WSO2 IS). This feature is available in any WSO2 IS version from 4.1.0 onwards. Note that **WSO2 IS 5.10.0** is used in this guide. WSO2 Identity Server acts as an identity service provider of systems enabled with Single Sign-On, while the Web applications act as SSO service providers. Using this feature, you can configure SSO with SAML 2.0 across the API Publisher and Developer Portal. After configuring, you can access the Developer Portal or API Publisher in a single authentication attempt.

The topics below explain the configurations.

-   [Sharing the user store](#sharing-the-user-store)
-   [Configuring WSO2 API Manager as Service Provider for Identity Server](#configuring-wso2-api-manager-as-service-provider-for-identity-server)
-   [Configuring WSO2 Identity Server as a SAML 2.0 SSO Identity Provider](#configuring-wso2-identity-server-as-a-saml-20-sso-identity-provider)
-   [Configuring WSO2 API Manager apps as SAML 2.0 SSO service providers](#configuring-wso2-api-manager-apps-as-saml-20-sso-service-providers)

!!! tip
    In this documentation, MySQL is used as the database to configure WSO2 API Manager with WSO2 Identity Server. For instructions on replacing the default H2 database with MySQL, see [Setting up MySQL]({{base_path}}/install-and-setup/setup/setting-up-databases/changing-default-databases/changing-to-mysql/#setting-up-mysql).

## Sharing the user store

1. Configure your user store(s) (if you have not done so already), by following the instructions in [Configuring User Stores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/introduction-to-userstores/).

2. Point both WSO2 IS and WSO2 API Manager to your user stores(s) using the instructions given below. 

     This is required to make sure that a user who tries to sign in to the Developer Portal or the Publisher is authorized. When users try to sign in to either of the applications, they are redirected to the configured identity provider (WSO2 IS in this case) where they can provide the login credentials to be authenticated. 

     In addition, the user should also be authorized by the system to enable [Role-based Permissions]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-permissions/). Therefore, for the purpose of authorization, the IS and API Manager needs to have a shared user store and user management database (by default, this is the H2 database in the `<API-M_HOME>/repository/conf/user-mgt.xml` file) where the user's role and permissions are stored.

     For example, let's share a JDBC user store (MySQL) with both the WSO2 Identity Server and WSO2 API Manager as follows:

     1.  Download WSO2 API Manager from [here](https://wso2.com/api-management/) and unzip it. `<API-M_HOME>` refers to the root folder where WSO2 API-M was unzipped.

        !!! tip
            To use WSO2 IS as the Key Manager, download the **WSO2 Identity Server 5.10.0 as a Key Manager** pack, with pre-packaged Key Manager features, from [here](https://wso2.com/identity-and-access-management).

     2.  Download WSO2 Identity Server (WSO2 IS) 5.10.0 from [here](https://wso2.com/identity-and-access-management) and unzip it. `<IS_HOME>` refers to the root folder where WSO2 IS was unzipped.

     3.  Create a MySQL database (e.g., 410\_um\_db) and run the `<API-M_HOME>/dbscripts/mysql.sql` script on it to create the required tables.

     4.  Go to the `<API-M_HOME>/repository/conf/deployment.toml` file and add database configurations. 
     
         For example, you can share a single user store as follows. 
         
         (If you are sharing multiple datasources, you need to define a datasource for each of the user stores that you are working with, so that they can be shared.)
    
        **Example**

        ``` toml
        [database.shared_db]
        type = "mysql"
        url = "jdbc:mysql://localhost:3306/410_um_db"
        username = "wso2carbon"
        password = "wso2carbon"   
        ```

        !!! note
            Change the database URL to the URL of the shared database (MySQL database) you have created above. Modify the username and password parameters in the above configuration with your database credentials.

     5.  Add the same datasource configuration above to the `<IS_HOME>/repository/conf/deployment.toml` file.

     6.  The Identity Server has an embedded LDAP user store by default and it is enabled by default. Change the default user store to the database user store.
     
         Add the following to the `<IS_HOME>/repository/conf/deployment.toml` file, and follow the instructions in [Internal JDBC User Store Configuration](https://is.docs.wso2.com/en/5.10.0/setup/configuring-a-jdbc-user-store/) to disable the default LDAP and enable the JDBC user store instead. 
    
        ``` toml
        [user_store]
        type = "database"
        ```
    
        !!! note
            In WSO2 API Manager, the JDBC User Store is enabled by default. (i.e., The following configuration exists in `<API-M_HOME>/repository/conf/deployment.toml` by default.) By changing the default user store of the WSO2 Identity server to JDBC User Store, you are pointing WSO2 API Manager and WSO2 Identity Server to the same user store so that the user stores are shared.

     7.  Copy the database driver JAR file to the `<IS_HOME>/repository/components/lib` and `<API-M_HOME>/repository/components/lib` directories.


## Configuring WSO2 API Manager as Service Provider for Identity Server

1.  Start WSO2 Identity Server.

    ```
    ./wso2server.sh -DportOffset=1
    ```

    !!! tip
        You also can change port offset value in `<IS_HOME>/repository/conf/carbon.xml` file. Add the following to the `<IS_HOME>/repository/conf/deployment.toml` file.
        ``` toml
        [server]
        offset = "1"
        ```                

    !!! info
        What is port offset?
        
        The port offset feature allows you to run multiple WSO2 products, multiple instances of a WSO2 product, or multiple WSO2 product clusters on the same server or virtual machine (VM). The port offset defines the number by which all ports defined in the runtime, such as the HTTP/S ports, will be offset. For example, if the HTTPS port is defined as 9443 and the port offset is 1, the effective HTTPS port will be 9444.


2.  Sign in to the WSO2 IS Management Console UI (e.g., `https://localhost:9444/carbon)`. 

    !!! tip
        If you use sign-in pages that are hosted externally to sign in to the Identity Server, give the absolute URLs of those login pages in the `authenticators.xml` and `application-authenticators.xml` files in the `<IS_HOME>/repository/conf/identity` directory.

3.  Select **Add** under the **Service Providers**.

    [![Add Service Provider]({{base_path}}/assets/img/learn/extensions/saml2-sso/add-sp.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/add-sp.png)
  
4.  Enter a service provider name and click **Register**.

    [![Service Provider name]({{base_path}}/assets/img/learn/extensions/saml2-sso/sp-name.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/sp-name.png)

    !!! tip
        **In a multi-tenanted environment,** for all tenants to be able to sign in to the APIM Web applications, do the following:

         -   Click the **SaaS Application** option that appears after registering the service provider.
             ![]({{base_path}}/assets/img/learn/extensions/saml2-sso/saas.png)
             If not, only users in the current tenant domain (the one you are defining the service provider in) will be allowed to sign in to the Web application and you have to register new service providers for all Web applications (Developer Portal and API Publisher in this case) from each tenant space separately. 
             </br>For example, let's say you have three tenants as TA, TB, and TC and you register the service provider in TA only. If you tick the **SaaS Application** option, all users in TA, TB, TC tenant domains will be able to sign in. Otherwise, only users in TA will be able to sign in.
  
        -   Because the servers in a multi-tenanted environment interact with all tenants, all nodes should share the same user store. Therefore, make sure you have a shared registry (JDBC mount, WSO2 Governance Registry, etc.) instance across all nodes.

     You are navigated to the detailed configuration page. 

5. Click and expand the **Inbound Authentication Configuration** section, click and expand **SAML2 Web SSO Configuration**, and click **Configure**.
     ![inbound-authentication-config]({{base_path}}/assets/img/learn/extensions/saml2-sso/inbound-authentication-config.png)
  
    !!! note
        To enable tenant-specific SSO with IS 5.10.0 for the API Publisher and Developer Portal -</br>
         1. Click and expand the Local & Outbound Authentication Configuration section.</br>
         2. Select **Use tenant domain in local subject identifier**.

         ![enable-tenant-domain]({{base_path}}/assets/img/learn/extensions/saml2-sso/enable-tenant-domain.png)

6.  Provide the configurations to register the API Publisher as the SSO service provider. 

     These sample values may change depending on your configuration.

    -   **Issuer**: apim
    -   **Assertion Consumer URL**: `https://localhost:9443/commonauth`. Change the IP and port accordingly. This is the URL for the Assertion Consumer Services (ACS) page in your running publisher app.
    -   **Response Signing Algorithm**: rsa-sha256   
    -   Select the following options:
    
           -   **Enable Response Signing**
           -   **Enable Signature Validation in Authentication Requests and Logout Request**
           -   **Enable Single Logout**
    
7.  Click **Register**.

     **Example**
    
     [![sample Service Provider]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-sp.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-sp.png)

8. Upload the public certificate of the API Manager by selecting **Select SP Certificate Type**.

## Configuring WSO2 Identity Server as a SAML 2.0 SSO Identity Provider

Similarly, add the Identity Server as an identity provider configurations in `https://localhost:9443/carbon`. These sample values may change depending in your configuration.

1. Start API Manager
  ```
       ./wso2server.sh
   ```
 
2.  Sign in to the WSO2 API Management Console UI (e.g. `https://localhost:9443/carbon)`.

3.  Select **Add** under the **Identity Providers** menu.

     <img src="{{base_path}}/assets/img/learn/extensions/saml2-sso/add-idp.png" width="350px">
    
4. Upload the public certificate of Identity Server under **Identity Provider Public Certificate**.

5. Configure **Federated authenticators** > **SAML2 Web SSO Configurations**

    [![federate Auth]({{base_path}}/assets/img/learn/extensions/saml2-sso/federated-auth.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/federated-auth.png)
    
    -   **Identity Provider Name**: is
    -   **Service Provider Entity ID**: apim
         
         This value can change depending on the **Issuer** value defined in WSO2 IS SSO configuration above.

    -   **Identity Provider Entity ID**: localhost
    -   **SSO URL**: `https://localhost:9444/samlsso` Change the IP and port accordingly. This is the redirecting SSO URL in your running WSO2 IS server instance.
    -   **Signature Algorithm**: RSA with SHA256
    -   Select the following options:
        -   **Enable SAML2 Web SSO**
        -   **Enable Authentication Request Signing**
        -   **Enable Authentication Response Signing**
        -   **Enable Logout Request Signing**
        -   **Enable Logout**      
   6. Click **Register**.


   **Example**
  
   [![sample IDP]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-idp.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-idp.png)

!!! note
    Make sure that your service provider configuration in WSO2 Identity Server and the identity provider configuration in WSO2 API Manager is similarly reflected on each other. 
    </br>Example:
    
    -   If the **Response Signing Algorithm** in WSO2 Identity Server is rsa-sha256, then the **Signature Algorithm** in WSO2 API Manager should be RSA with SHA256.
    -   If you enabled **Enable Single Logout** in Identity Server, then enable **Enable Logout** in WSO2 API Manager.

## Configuring WSO2 API Manager apps as SAML 2.0 SSO service providers

1.  Sign in to the WSO2 API Management Console UI (`https://localhost:9443/carbon)`.

2.  List the service providers, and click **Edit** on the relevant application for the Publisher, Developer Portal, or Admin Portal.

     [![listed-sp]({{base_path}}/assets/img/develop/extensions/listed-sp.png)]({{base_path}}/assets/img/develop/extensions/listed-sp.png)
  
    !!! note
        Note that the Publisher, Developer Portal, and Admin Portal service providers will be listed under **Service Providers** after you have logged in to each of the portals at least once.
         
3. Click and expand **Local and Outbound Authentication Configuration**, and select Identity Provider as the **Federated Authentication**.

     [![app-federate]({{base_path}}/assets/img/learn/extensions/saml2-sso/app-federate.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/app-federate.png)
  
4.  Click **Update**.

5.  Repeat the above steps (Step 2 to Step 4) to configure SAML2 SSO for any of the Publisher, Developer Portal or Admin Portal applications.

4.  Access the API Publisher: `https://localhost:<PORT>/publisher` (e.g., `https://localhost:9443/publisher`). 

     Observe the request redirect to the WSO2 IS SAML2.0 based SSO login page. 
     
     Example:
     [![Sign in page]({{base_path}}/assets/img/learn/extensions/saml2-sso/login-page.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/login-page.png)

    Similarly, access the Developer Portal `https://localhost:<PORT>/devportal` (e.g., `https://localhost:9443/devportal`) and the Admin Portal `https://localhost:<PORT>/admin` (e.g., `https://localhost:9443/admin`)
  
5.  Enter user credentials. 

     If the user authentication is successful against WSO2 IS, it will redirect to the particular Web application with the user already authenticated.

6.  If you sign in to the Publisher, then access the Developer Portal application, click **Login** and verify that the same user is already authenticated in the Developer Portal.

!!!info
    When Just-In-Time Provisioning is enabled, the user details will be saved in the API Manager user store. User profile details will be update via federation following each login event. To preserve the user profile details without any changes you need to enable the `SystemRolesRetainedProvisionHandler`.
    Add the following to the `<API-M_HOME>/repository/conf/deployment.toml` file and restart the server.

    ```
        [authentication.framework.extensions]
        provisioning_handler = "org.wso2.carbon.identity.application.authentication.framework.handler.provisioning.impl.SystemRolesRetainedProvisionHandler"
    ```

!!! note
    Even with SSO enabled, if the users do not have sufficient privileges to access API Publisher/Developer Portal/Admin Portal or any other application, they will not be authorized to access them.

!!! info
    For more information on Single Sign-On with WSO2 Identity Server, see [SAML 2.0 Web SSO](https://is.docs.wso2.com/en/5.10.0/learn/saml-2.0-web-sso/) in the WSO2 Identity Server documentation.

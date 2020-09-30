# Configuring Identity Server as IDP for SSO

!!! info
    The **Single Sign-On with OpenID Connect** feature is enabled by default in WSO2 API Manager.  
    
The **Single Sign-On with SAML 2.0** feature in the API Manager is implemented according to the SAML 2.0 browser-based SSO support that is facilitated by WSO2 Identity Server (WSO2 IS). This feature is available in any WSO2 IS version from 4.1.0 onwards. **WSO2 IS 5.10.0** is used in this guide. WSO2 Identity Server acts as an identity service provider of systems enabled with single sign-on, while the Web applications act as SSO service providers. Using this feature, you can configure SSO with SAML 2.0 across the API Publisher and Developer Portal. After configuring, you can access the Developer Portal or API Publisher in a single authentication attempt.

!!! tip
    In this documentation, MySQL is used as the database to configure WSO2 API Manager with WSO2 Identity Server. For instructions on replacing the default H2 database with MySQL, see [Setting up MySQL]({{base_path}}/install-and-setup/setup/setting-up-databases/changing-default-databases/changing-to-mysql/#setting-up-mysql).

## Step 1 - Share the user store

1. Configure your user store(s) (if you have not done so already).

     Follow the instructions in [Configuring User Stores]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-user-stores/introduction-to-userstores/).

2. Point both WSO2 IS and WSO2 API Manager to your user stores(s). 

     This is required to make sure that a user who tries to sign in to the Developer Portal or the Publisher is authorized. When users try to sign in to either of the applications, they are redirected to the configured identity provider (WSO2 IS in this case) where they need to provide their login credentials to be authenticated.

     In addition to this, the user should also be authorized by the system to enable [Role-based Permissions]({{base_path}}/administer/product-administration/managing-users-and-roles/managing-permissions/). 

     Therefore, for the purpose of authorization, WSO2 IS and WSO2 API Manager needs to have a shared user store and user management database (by default, this is the H2 database in the `<API-M_HOME>/repository/conf/user-mgt.xml` file) where the user's role and permissions are stored.

     Follow the instructions below to point both WSO2 IS and WSO2 API Manager to your user stores(s):

     For example, let's share a JDBC user store (MySQL) with both the WSO2 Identity Server and WSO2 API Manager as explained below.

    1.  Download WSO2 API Manager from [here](https://wso2.com/api-management/) and unzip it. 
    
         `<API-M_HOME>` refers to the root folder where WSO2 API-M was unzipped.

        !!! tip
            To use WSO2 IS as the Key Manager, download the **WSO2 Identity Server 5.10.0 as a Key Manager** pack, with pre-packaged Key Manager features as follows:
            
            1. Access the [previous WSO2 API Manager related releases](https://wso2.com/api-management/previous-releases/).
            2. Select version 3.1.0.
            3. Click on the Identity Server as a Key Manager download option.

    2.  Download WSO2 Identity Server (WSO2 IS) 5.10.0 from [here](https://wso2.com/identity-and-access-management) and unzip it. 
    
         `<IS_HOME>` refers to the root folder where WSO2 IS was unzipped.

    3.  Create a MySQL database (e.g., 410\_um\_db) and run the `<API-M_HOME>/dbscripts/mysql.sql` script on it to create the required tables.

    4.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file and add database configurations. 
    
         For example, you can share a single user store as follows. (If you are sharing multiple datasources, you need to define a datasource for each of the user stores that you are working with, so that they can be shared.)
    
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

    5.  Add the latter datasource configuration that appears above in the `<IS_HOME>/repository/conf/deployment.toml` file.

    6.  Disable the default LDAP and enable the JDBC user store instead.
    
         WSO2 Identity Server has an embedded LDAP user store by default. 
         
         1. As the LDAP user store is enabled by default, add the following in the `<IS_HOME>/repository/conf/deployment.toml` file to change this to the database user store.

            ``` toml
            [user_store]
            type = "database"
            ```
         
         2. Disable the default LDAP and enable the JDBC user store.
         
             For instructions, see [Internal JDBC User Store Configuration](https://is.docs.wso2.com/en/5.10.0/setup/configuring-a-jdbc-user-store/).  
    
        !!! note
            In WSO2 API Manager, the JDBC User Store is enabled by default. (i.e., The following configuration exists in the `<API-M_HOME>/repository/conf/deployment.toml` by default.) By changing the default user store of the WSO2 Identity server to JDBC User Store, you are pointing both WSO2 API Manager and WSO2 Identity Server to the same user store to share their user stores.

    6.  Copy the database driver JAR file to the `<IS_HOME>/repository/components/lib` and `<API-M_HOME>/repository/components/lib` directories.

## Step 2 - Configure WSO2 API Manager as the Service Provider for WSO2 Identity Server

1.  Start WSO2 Identity Server.

    ```
    ./wso2server.sh -DportOffset=1
    ```

    !!! tip
        You also can change the port offset value in the `<IS_HOME>/repository/conf/carbon.xml` file by adding the following to the `<IS_HOME>/repository/conf/deployment.toml` file.

        ``` toml
        [server]
        offset = "1"
        ```                

    ??? info "What is port offset?"
        
        The port offset feature allows you to run multiple WSO2 products, multiple instances of a WSO2 product, or multiple WSO2 product clusters on the same server or virtual machine (VM). The port offset defines the number by which all ports defined in the runtime, such as the HTTP/S ports, will be offset. For example, if the HTTPS port is defined as 9443 and the port offset is 1, the effective HTTPS port will be 9444.

2.  Sign in to the WSO2 IS Management Console.
     
     `https://<hostname>:9443/carbon`
     
     `https://localhost:9443/carbon`

    !!! tip
        If you are using sign-in pages that are hosted externally to sign in to the Identity Server, define the absolute URLs of those login pages in the `authenticators.xml` and `application-authenticators.xml` files in the `<IS_HOME>/repository/conf/identity` directory.

3.  Click **Main**, **Identity**, and then click **Add** under the **Service Providers** menu.

     [![add-sp]({{base_path}}/assets/img/learn/extensions/saml2-sso/add-sp.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/add-sp.png)
  
4.  Enter a Service Provider name and click **Register**.

     The detailed configuration page appears.

     [![sp-name]({{base_path}}/assets/img/learn/extensions/saml2-sso/sp-name.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/sp-name.png)

    <div class="admonition tip">
    <p class="admonition-title">Multi-tenanted environment</p>
    <p>
    <p>Carry out the instructions given below for all the tenants to be able to sign in to the API-M Web applications in a <b>multi-tenanted environment</b>.</p>
    <p><ol><li>Click the **SaaS Application** option that appears after registering the service provider.</p>
    <a href="{{base_path}}/assets/img/learn/extensions/saml2-sso/saas.png"><img src="{{base_path}}/assets/img/learn/extensions/saml2-sso/saas.png"></a>
    <p>If you do not select the SaaS Application option, only users in the current tenant domain (the tenant domain that you are defining the service provider in) will be allowed to sign in to the Web application and you will need to register new service providers for all the Web applications (Developer Portal and API Publisher in this case) from each tenant space separately.</p>
    <p><br/>For example, let's say that you have three tenants as TA, TB and TC, and you register the service provider in TA only. If you tick the <b>SaaS Application</b> option, all users in TA, TB, TC tenant domains will be able to sign in. Else, only users in TA will be able to sign in.</p>
    </li>
    <li><p>As the servers in a multi-tenanted environment interact with all tenants, all nodes should share the same user store. Therefore, make sure you have a shared registry (JDBC mount, WSO2 Governance Registry, etc.) instance across all nodes.</p></li>
    </ol>
    </p>
    </div>

5.  Expand the **Inbound Authentication Configuration** section, then expand the **SAML2 Web SSO Configuration** section, and click **Configure**.
    
     [![inbound-authentication-config]({{base_path}}/assets/img/learn/extensions/saml2-sso/inbound-authentication-config.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/inbound-authentication-config.png)
  
    !!! note "Enable a tenant-specific SSO for the Publisher and Developer Portal"
        To enable a tenant-specific SSO with IS 5.10.0 for `Publisher` and the `Developer Portal`, enable the **Use tenant domain in local subject identifier** option under the **Local & Outbound Authentication Configuration** section.

        [![enable-tenant-domain]({{base_path}}/assets/img/learn/extensions/saml2-sso/enable-tenant-domain.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/enable-tenant-domain.png)

6.  Register the API Publisher as the SSO service provider. 

     1. Enter the configurations to register the API Publisher as the SSO service provider. These sample values may change based on your configuration.

        -   **Issuer**: apim
        -   **Assertion Consumer URL**: `https://localhost:9443/commonauth`. 
            
            Change the IP and port accordingly. This is the URL for the Assertion Consumer Services (ACS) page in your running publisher app.

        -   **Response Signing Algorithm**: rsa-sha256   
        -   Select the following options:
        
            -   **Enable Response Signing**
            -   **Enable Signature Validation in Authentication Requests and Logout Request**
            -   **Enable Single Logout**
    
    2.   Click **Register**.

    **Example**
    
    [![sample-sp]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-sp.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-sp.png)

7. Upload the public certificate of the API Manager by selecting **Select SP Certificate Type**.

## Step 3 - Configure WSO2 Identity Server as a SAML 2.0 SSO Identity Provider

1. Start API Manager
  
    ```
    ./wso2server.sh
    ```
 
2.  Sign in to the WSO2 API Management Console.

     `https://<hostname>:9443/carbon`
     
     `https://localhost:9443/carbon`

3.  Click **Main**, **Identity**, and then click **Add** under the **Identity Providers** menu.

     <a href="{{base_path}}/assets/img/learn/extensions/saml2-sso/add-idp.png"><img src="{{base_path}}/assets/img/learn/extensions/saml2-sso/add-idp.png" width="300"></a>
    
4. Upload the public certificate of Identity Server under **Identity Provider Public Certificate**.

5. Define the Federated authenticator.

    1. Expand the **Federated authenticators** section, then expand the **SAML2 Web SSO Configurations** section and define the Federated authenticator as follows:

         [![federated-auth]({{base_path}}/assets/img/learn/extensions/saml2-sso/federated-auth.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/federated-auth.png)
    
        -   **Identity Provider Name**: is
        -   **Service Provider Entity ID**: apim
            
            This value can change depending on the **Issuer** value defined in WSO2 IS SSO configuration above.
        
        -   **Identity Provider Entity ID**: localhost
        -   **SSO URL**: `https://localhost:9444/samlsso` 
        
            Change the IP and port accordingly. This is the redirecting SSO URL in your running WSO2 IS server instance.

        -   **Signature Algorithm**: RSA with SHA256
        -   Select the following options:
            -   **Enable SAML2 Web SSO**
            -   **Enable Authentication Request Signing**
            -   **Enable Authentication Response Signing**
            -   **Enable Logout Request Signing**
            -   **Enable Logout**

    2. Click **Register**.


   **Example**
  
   [![sample-idp]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-idp.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/sample-idp.png)

!!! note
    Make sure your service provider configurations in the Identity Server and the identity provider configurations in API Manager are similarly reflected to each other.

    Example: 
    
    -   If the **Response Signing Algorithm** in Identity Server is `rsa-sha256`, then the **Signature Algorithm** in API Manager should be `RSA with SHA256`.
    -   If you enabled **Enable Single Logout** in Identity Server, then enable **Enable Logout** in API Manager.

## Step 4 - Configure WSO2 API Manager apps as SAML 2.0 SSO service providers

1.  Sign in to the WSO2 API-M Management Console.

     `https://<hostname>:9443/carbon`
     
     `https://localhost:9443/carbon`

2.  List the service providers and click the edit option that corresponds to the API Publisher.

    [![listed-sp]({{base_path}}/assets/img/learn/extensions/saml2-sso/listed-sp.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/listed-sp.png)
  
    !!! note
        The Publisher and Developer Portal service providers will be listed under service providers after you have logged in to the Publisher and the Developer Portal at least once. 
         
3.  Navigate to **Local and Outbound Authentication Configuration** and select Identity Provider as the **Federated Authentication**.

    [![app-federate]({{base_path}}/assets/img/learn/extensions/saml2-sso/app-federate.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/app-federate.png)
  
4.  Click **Update**.

5.  Repeat the above steps (Step 2 to Step 4) with regard to the Developer Portal as well.

4.  Access the Publisher.

     `https://<hostname>:9443/publisher`
     
     `https://localhost:9443/publisher`

     Observe that the request is redirected to the WSO2 IS SAML2.0 based SSO login page.

    [![login-page]({{base_path}}/assets/img/learn/extensions/saml2-sso/login-page.png)]({{base_path}}/assets/img/learn/extensions/saml2-sso/login-page.png)
  
5.  Enter the user credentials. 

     If the user authentication is successful against WSO2 IS, it will redirect to the API Publisher Web application with the user already authenticated.

6.  Access the Developer Portal application, click its **Login** link (top, right-hand corner) and verify that the same user is already authenticated in the Developer Portal.

!!! note
    Even with SSO enabled, if users do not have sufficient privileges to access API Publisher/Developer Portal or any other application, they will not be authorized to access them.

!!! info
    To learn more about Single Sign-On with WSO2 Identity Server, see [SAML 2.0 Web SSO](https://is.docs.wso2.com/en/5.10.0/learn/saml-2.0-web-sso/) in the WSO2 Identity Server documentation.

## Step 5 - Configure the WSO2 API Manager Admin Portal as the SAML 2.0 SSO service provider

1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/conf/site.json` file.

2. Modify the following configurations found under `ssoConfiguration`.

    <table>
    <colgroup>
    <col width="33%" />
    <col width="33%" />
    <col width="33%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th><b>Parameter</b></th>
    <th><b>Description</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><pre><code>enabled</code></pre></td>
    <td>Set this value to <code>true</code> to enable SSO in the application.</td>
    </tr>
    <tr class="even">
    <td><pre><code>issuer</code></pre></td>
    <td><code>ADMIN_PORTAL</code>
    <br/>This value can change depending on the Issuer value defined in WSO2 IS SSO configuration above.</td>
    </tr>
    <tr class="odd">
    <td><pre><code>identityProviderURL</code></pre></td>
    <td><code>https://localhost:9444/samlsso</code>
    <br/> Change the IP and port accordingly. This is the redirecting SSO URL in your running WSO2 IS server instance.</td>
    </tr>
    <tr class="odd">
    <td><pre><code>keyStoreName</code></pre></td>
    <td>The keystore of the running IDP. As you use a remote instance of WSO2 IS here, you can import the public certificate of the IS keystore to the APIM and then point to the APIM keystore. The default keystore of the APIM is <code>&lt;API-M_HOME&gt;/repository/resources/security/wso2carbon.jks</code>. Be sure to define the full path of the keystore here.</td>
    </tr>
    <tr class="even">
    <td><pre><code>keyStorePassword</code></pre></td>
    <td>Password for the above keystore. The default <code>keyStorePassword</code> is <code>wso2carbon</code></td>
    </tr>
    <tr class="odd">
    <td><pre><code>identityAlias</code></pre></td>
    <td><code>wso2carbon</code></td>
    </tr>
    </tbody>
    </table>

     [![Admin Portal SSO Configuration]({{base_path}}/assets/img/develop/extensions/admin-portal-sso-config.png)]({{base_path}}/assets/img/develop/extensions/admin-portal-sso-config.png)

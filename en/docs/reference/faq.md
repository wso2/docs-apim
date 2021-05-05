# FAQ

## About WSO2 API Manager

### What is WSO2 API Manager?

WSO2 API Manager is a complete solution for creating, publishing and managing all aspects of an API and its life cycle. For more information, see the [introduction]({{base_path}}/getting-started/overview/).

### What is the open source license of the API Manager?

[Apache Software License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

### Is there commercial support available for WSO2 API Manager?

It is completely supported from evaluation to production. For more details, see [WSO2 Support](http://wso2.com/support/).

### What are the default ports opened in the API Manager?

For a list of all default ports available, see [Default Ports of WSO2 Products]({{base_path}}/install-and-setup/setup/reference/default-product-ports/#api-manager).

### What are the technologies used underneath WSO2 API Manager?

The API Manager is built on top of [WSO2 Carbon](http://wso2.com/products/carbon), an OSGi based components framework for SOA. For more details, see [API Manager components]({{base_path}}/getting-started/key-concepts/).

### Can I get involved in API-M development activities?

Not only are you allowed, but also encouraged. You can start by subscribing to the `dev@wso2.org` and `architecture@wso2.org` mailing lists. Feel free to provide ideas, feedback and help make our code better. For more information on contacts, mailing lists and forums, see [our community page](https://wso2.com/community).

### What is the default communication protocol of the API Manager?

The default communication protocol is [Thrift](http://thrift.apache.org/static/files/thrift-20070401.pdf).

### Does WSO2 API-M support HTTP pipelining?

No, currently WSO2 API-M does not support [HTTP pipelining](https://en.wikipedia.org/wiki/HTTP_pipelining).

------------------------------------------------------------------------

## Installation and start up

### What are the minimum requirements needed to run WSO2 API Manager?

For a list of system requirements, environment compatibility and required applications, see [Installation Prerequisites]({{base_path}}/install-and-setup/install/installation-prerequisites).

### How do I deploy a third-party library into the API Manager?

Copy any third-party JARs to `<API-M_HOME>/repository/components/lib` directory and restart the server.

### Can I connect the API Manager directly to an LDAP or Active Directory where corporate identities are stored?

Yes, you can configure the API Manager with multiple user stores. For more details, see [Configuring User Stores]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/configuring-secondary-user-stores/).

### Can I extend the management console UI to add custom UIs?

Yes, you can extend the management console (default URL is <https://localhost:9443/carbon>) easily by writing a custom UI component and simply deploying the OSGi bundle.

### I don't want some of the features that come with WSO2 API Manager. Can I remove them?

Yes, you can do this using the **Features** menu under the **Configure** menu of the management console (default URL is <https://localhost:9443/carbon>).

### How can I change the memory allocation for the API Manager?

The memory allocation settings are stored in the `<API-M_HOME>/bin/api-manager.sh` file.

### How do I start up only selected components of the API Manager?

Even though the API Manager bundles all components together, you can select which component(s) you want to start by using the `-Dprofile` command at product startup. For more information, see [Product Profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles/).

------------------------------------------------------------------------

## Deployment

### What are the different deployment patterns and clustering configurations of the API Manager?

See [Deploying WSO2 API Manager]({{base_path}}/install-and-setup/setup/deployment-patterns/).

### What are the container technologies that are supported in API Manager?

OpenShift, Docker, Kubernetes and Mesos are supported.

### Is it recommended to run multiple WSO2 products on a single server?

This is not recommended in a production environment involving multiple transactions. If you want to start several WSO2 products on a single server, you must change their default ports to avoid port conflicts. See [Changing the Default Ports with Offset]({{base_path}}/install-and-setup/setup/deployment-best-practices/changing-the-default-ports-with-offset).

### Can I install features of other WSO2 products to the API Manager?

Yes, you can do this using the management console. The API Manager already has features of WSO2 Identity Server, WSO2 Governance Registry, WSO2 ESB etc. embedded in it. However, if you require more features of a certain product, it is recommended to use a separate instance of it rather than install its features to the API Manager.

### How can I continue to use my email address as the username in a distributed API-M deployment?

To enable using your email (e.g., `admin@wso2.com`) as your username when deploying WSO2 API-M and WSO2 Identity Server (WSO2 IS), while doing master configurations, do the following in the `<API-M_HOME>/repository/conf/deployment toml` file. 

```
[apim.throttling.jms]
username="admin!wso2.com!carbon.super"
```

For more details, see [Setting up an e-mail login]({{base_path}}/install-and-setup/setup/security/logins-and-passwords/maintaining-logins-and-passwords/#setting-up-an-e-mail-login).

------------------------------------------------------------------------

### How can I set up a reverse proxy server to pass server requests?

See [Configuring the Proxy Server and the Load Balancer]({{base_path}}/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer/).

------------------------------------------------------------------------

## Functionality

### Why can't I see all the APIs that I published on the Developer Portal ?

If you have multiple versions of an API published, only the latest version is shown in the Developer Portal. To display multiple versions, set the `display_multiple_versions` value to `true` in the `<API-M_HOME>/repository/conf/deployment.toml` file.

```
[apim.devportal]
display_multiple_versions = true
```

### When editing an API's resource parameters, how can I add multiple options to the **Response Content Type parameter** ?

You cannot do this using the UI. Instead, edit the Swagger definition of the API as shown in the following example,
`content_type: ["text/xml","text/plain"]        `

### Why are the changes I did to the `Response Content Type` resource parameter of a published API not reflected in the Developer Portal, even after saving?

If you edited the **Response Content Type** using the UI, please open the API's Swagger definition, do your changes, and save. Then the changes should be reflected back in the Developer Portal. This will be fixed in a future release.

### How do I change the pass-through transport configurations?

If you have enabled the pass-through transport, you can change its default configurations by adding the  following under the `[transport.passthru_https.listener.parameters]` element in the `<API-M_HOME>/repository/conf/deployment.toml` file. Be sure to **stop the server** before editing the file.

If you are using JDK 1.7.\* or 1.8.\*, add the parameter given below:

```
[transport.passthru_https.listener.parameters]
HttpsProtocols = "TLSv1,TLSv1.1,TLSv1.2"
```

### How can I extend the default API Manager server by installing new features?

See [Working with Features](https://docs.wso2.com/display/ADMIN44x/Working+with+Features) in the WSO2 Admin Guide.

### How can I preserve the CDATA element tag in API responses?

Set the `javax.xml.stream.isCoalescing` property to `false` by adding the following configuration in `deployment.toml` file, which is in the `<API-M-Home>/repository/conf` directory.

``` toml
[xml_input_factory.properties]
"javax.xml.stream.isCoalescing" = false
```

Example:

``` java
<XacuteResponse xmlns="http://aaa/xI">
    <Rowset>
        <Row>
            <outxml><![CDATA[<inSequence>
            <send>
                <endpoint>
                    <address uri="http://localhost:8080/my-webapp/echo"/>
                </endpoint>
            </send>
            </inSequence>]]></outxml>
        </Row>
    </Rowset>
</XacuteResponse>
```

------------------------------------------------------------------------

## Authentication and security

### How can I manage authentication centrally in a clustered environment?

You can enable centralized authentication using a WSO2 Identity Server based [security and identity gateway solution](http://wso2.com/whitepapers/wso2-security-and-identity-gateway-solution/), which [enables SSO](https://is.docs.wso2.com/en/latest/learn/configuring-saml2-single-sign-on-across-different-wso2-products/) (Single Sign On) across all the servers.

### How can I manage the API permissions/visibility?

To set visibility of the API only to selected user roles in the server, see [API Visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/).

### How can I add security policies (UT, XACML, etc.) for the services?

This should be done in the backend services in the Application Server or WSO2 ESB.

### How can I enable self signup to the Developer Portal ?

See [how to enable self signup]({{base_path}}/consume/customizations/customizing-the-developer-portal/enabling-or-disabling-self-signup/).

### How can I disable self signup to the Developer Portal ? I want to engage my own approval mechanism.

To disable the self signup capability, open the API-M management console and click the **Resources &gt; Browse** menu. The registry opens. Navigate to the `/_system/governance/apimgt/applicationdata/sign-up-config.xml` file and set the `<SelfSignUp><Enabled>` element to false. To engage your own signup process, see [Adding a User Signup Workflow]({{base_path}}/develop/customizations/adding-a-user-signup-workflow/).

### Is there a way to lock a user's account after a certain number of failed login attempts to the Developer Portal ?

If your identity provider is WSO2 Identity Server, this facility comes out of the box. If not, install the **Account Recovery and Credentials Management** feature (available under the User Management category) to the API Manager and configure it. For more information, see [User Account Locking and Account Disabling](https://is.docs.wso2.com/en/5.10.0/learn/user-account-locking-and-account-disabling/) in the Identity Server documentation. For more information on installing features, see [Working with features](https://docs.wso2.com/display/ADMIN44x/Installing+Features+using+pom+Files) in the Admin Guide.

### How do I change the default admin password?

To change the default admin password, sign in to the management console with admin/admin credentials and use the **Change my password** option. After changing the password in the management console, configure the new password in the `deployment.toml` file, which is in the `<API-M_HOME>/repository/conf` directory.

``` toml
[super_admin]
username = "admin"
password = "${new-password}"
```

You can verify whether the password change is applied correctly by checking the following elements in the `<API-M_HOME>/repository/conf/api-manager.xml` file.

``` xml
<AuthManager>
    <Username>admin</Username>
    <Password>newpassword</Password>
</AuthManager>
```

``` xml
<APIGateway>
   <Username>admin</Username>
   <Password>newpassword</Password>
</APIGateway>
```

``` xml
<APIKeyManager>
   <Username>admin</Username>
   <Password>newpassword</Password>
</APIKeyManager>
```
Go to the **Resources &gt; Browse** menu in the management console to open the registry and update the credentials in the `/_system/governance/apimgt/applicationdata/sign-up-config.xml` registry location.

### How can I recover the admin password used to log in to the management console?

Use the `<API-M_HOME>/bin/chpasswd.sh` script.

### How can I manage session timeouts for the management console?

To configure session timeouts, see [Configuring the session time-out]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#configuring-the-session-time-out).

### How can I add authentication headers to messages going out of the API Gateway to the backend?

Set the `enable_outbound_auth_header` value to `true` in the `<API-M_HOME>/repository/conf/deployment.toml` file.

```
[apim.oauth_config]
enable_outbound_auth_header = true
```

### Can I give special characters in the passwords that appear in the configuration files?

If the config file is in XML, take care when giving special characters in the user names and passwords. According to XML specification (<http://www.w3.org/TR/xml/>), some special characters can disrupt the configuration. For example, the ampersand character (&) must not appear in the literal form in XML files. It can cause a Java Null Pointer exception. You must wrap it with CDATA as shown below or remove the character:

``` 
[super_admin]
username = "your-name"
password = "<![CDATA[your-password]]>" 
```

### How can I protect my product server from security attacks caused by weak ciphers?

You can protect your server from attacks such as the Logjam attack (Man-in-the-Middle attack) by disabling weak ciphers. For more details, see [Disable weak ciphers]({{base}}/install-and-setup/setup/security/configuring-transport-level-security/#disabling-weak-ciphers) in the WSO2 Admin Guide.

## Troubleshooting

### Why do I get an illegal access attempt error while trying to authenticate APIKeyValidationService?

If you get the following error: `org.wso2.carbon.server.admin.module.handler.AuthenticationHandler - Illegal access attempt`, it may be due to the following reasons,

-   Did you change the default admin password?

    If the answer to the above question is "yes", verify the credentials that you configured for the `password` property under the `[apim.key_manager]` element in the `<API-M_HOME>/repository/conf/deployment.toml` file of the API Gateway node(s).

-   Have you set the priority of the `SAML2SSOAuthenticator` handler higher than that of the `BasicAuthenticator` handler?

    If the answer to the above question is "yes", the `SAML2SSOAuthenticator` handler tries to manage the basic authentication requests as well. Set a lower priority to the `SAML2SSOAuthenticator` than the `BasicAuthenticator` handler by adding the following configuration in the `deployment.toml` file, which is in the `<API-M_HOME>/repository/conf` directory.

    ``` toml
    [admin_console.authenticator.saml_sso_authenticator]
    priority = 0
    enable = true
    ```

### How can I fix a mismatching certificate hostname exception?

**Reason for occurrence**

The *`javax.net.ssl.SSLException: hostname in certificate didn't match: <ip addrees> != <localhost>         `* exception is a very common exception that occurs whenever the WSO2 product server is accessed using a different IP address (e.g., `https://10.100.0.77:9443/publisher`) except localhost (e.g., `https://localhost:9443/publisher`).

The reason that the exception occurs is because the self-signed certificate that is shipped with WSO2 products is configured using the hostname as `localhost`, and as a result Apache Shindig does not allow any other HTTP requests that originate from other hostnames/IP addresses other than localhost.

**Overcoming the issue**

You have to create and add a certificate for the IP/domain name in order to overcome this issue. Follow the instructions below:

!!! note
    In the following instructions, assume that you are attempting to add a self-signed certificate for the domain 'foo.com'.


**Step 1 - Create a self-signed Java KeyStore file and include your domain as the Common Name (CN)**

1.  Open a terminal and type the following command to generate a KeyStore.

    ``` java
    keytool -genkey -alias test.foo.com -keyalg RSA -keystore foo.jks -keysize 2048
    ```

2.  Specify a preferred KeyStore password when prompted.

    ``` java
    Enter keystore password: <keystore_password>
    Re-enter new password: <keystore_password>
    ```

3.  Enter the first name and last name as `*.foo.com` and fill out the other information accordingly when prompted.

    **Example**

    ``` java
    What is your first and last name?
        [Unknown]:  <new_host_name>
    What is the name of your organizational unit?
        [Unknown]:  
    What is the name of your organization?
        [Unknown]:  WSO2
    What is the name of your City or Locality?
        [Unknown]:  Mountain View
    What is the name of your State or Province?
        [Unknown]:  CA
    What is the two-letter country code for this unit?
        [Unknown]:  US
    Is CN=*.foo.com, OU=Unknown, O=WSO2, L=Mountain View, ST=CA, C=US correct?
        [no]:  yes
    ```

4.  Specify a preferred private Key password when prompted.

    ``` java
    Enter key password for <keystore_password>
        (RETURN if same as keystore password):  <key_password>
    Re-enter new password: <key_password>
    ```

    -`<key_password>` -  Enter the key password that you provided in [step 1.2](#FAQ-Keystorepassword).

    This generates a KeyStore with a private key and a public certificate with CN as `*.foo.com          `

**Step 2 - Configure the SSL KeyStore**

Follow the instructions to configure the WSO2 product with the generated KeyStore:

1.  Copy the generated self-signed keystore, `foo.jks`, which was created in [step 1](#FAQ-Step1-CreateaselfsignedJavaKeyStorefileandincludeyourdomainastheCN), into the `<API-M_HOME>/repository/resources/security` directory.
2.  Export the public certificate from the keystore and import that certificate to the `client­-truststore.jks` file.
    1.  Navigate to the `<API-M_HOME>/repository/resources/security` directory.
    2.  Export the public certificate from the primary KeyStore.

        ``` java
        keytool -export -alias test.foo.com -file test.foo.com -keystore foo.jks -storepass <KEYSTORE_PASSWORD_GIVEN_ABOVE>
        ```

    3.  Import the certificate to the `client­-truststore.jks` file.

        ``` java
        keytool -import -alias test.foo.com -file test.foo.com -keystore client-truststore.jks -storepass wso2carbon
        ```

**Step 3 - Configure the values for the TLS Key Store**

1.  Change the `file_name` and `password` of the `[keystore.tls]` configuration in `<API-M_HOME>/repository/conf/deployment.toml` file.

    ```
    [keystore.tls]
    file_name =  "foo.jks"
    type =  "JKS"
    password =  "wso2carbon"
    alias =  "test.foo.com"
    key_password =  "KEYSTORE_PASSWORD_GIVEN_ABOVE"
    ```

2.  Restart the server for the changes to be applicable.

### How can I fix a fatal alert: unknown\_ca error when invoking the methods of an API via the API Console?

The root cause for the `javax.net.ssl.SSLException: Received fatal alert: unknown_ca` error is because the default pack is not shipped with a CA-signed certificate. When using the API Console, the web browser sends an HTTPs request to the API Gateway. As the certificate on the Gateway is not CA-signed, the browser does not accept it.

To resolve this issue, first access the Gateway URL via a new browser tab of the same browser and accept the certificate from the browser.

### I get a **`Hostname verfiication failed`** exception when trying to send requests to a secured endpoint. What should I do?

Set the `HostnameVerifier` element to `AllowAll` in `<API-M_HOME>/repository/conf/deployment.toml` file's HTTPS transport sender configuration.

```
[transport.passthru_https.sender.parameters]
HostnameVerifier = "AllowAll"
```

This parameter verifies the hostname of the certificate of a server when the API Manager acts as a client and does outbound service calls.

### When I add new users or roles, I get an error message stating that the entered user name is not conforming to policy. What should I do?

This is because your user name or password length or any other parameter is not conforming to the `RegEx` configurations of the user store. See [Managing Users and Roles]({{base_path}}/administer/managing-users-and-roles/introduction-to-user-management/).

### When I call a REST API, a lot of temporary files are created in my server and takes up a lot of space. What should I do?

There might be multiple configuration context objects created per API invocation. Check whether your client creates a configuration context object per API invocation. You can also configure a HouseKeeping task in the `<API-M_HOME>/repository/conf/carbon.xml` file to clear the temporary folders. For example,

``` xml
<HouseKeeping> 
        <AutoStart>true</AutoStart> 
         
        <!-- The interval in *minutes*, between house-keeping runs --> 
        <Interval>10</Interval> 
    <!-- The maximum time in *minutes*, temp files are allowed to live in the system. Files/directories which were modified more than 
        "MaxTempFileLifetime" minutes ago will be removed by the house-keeping task --> 
    <MaxTempFileLifetime>30</MaxTempFileLifetime>
</HouseKeeping>
```
### Why do I get a Gateway Failures error?

The Gateway Failures UI error occurs when the `service_url`, `username`, `password` and/or `https_endpoint/http_endpoint` is incorrect. This can be rectified by checking and correcting the gateway configurations under `[[apim.gateway.environment]]` in the `<API-M_HOME>/repository/conf/deployment.toml` file.

!!! tip
    If you are using the API-M instance you used as the first instance in the [Publish through Multiple API Gateways]({{base_path}}/learn/design-api/publish-api/publish-through-multiple-api-gateways) tutorial, you may receive the above error when trying out other tutorials. This is because you updated the environments configurations in that pack by adding two API Gateway environments under the `[[apim.gateway.environment]]` element,  and modifying the default configuration. To overcome this error, revert the default `[[apim.gateway.environment]]` configuration.


### How can I capture the state of a system?

At the time of an error, you can use a tool called Carbon Dump (`carbondump.sh`) to collect all the necessary data (i.e., heap and thread dumps) from a running WSO2 API Manager instance in order to carryout a head dump and thread stack analysis. For more information on using this tool, see [Capturing the state of the system]({{base_path}}/troubleshooting/admin-troubleshooting-in-production-environments/#capturing-the-state-of-the-system) in the Administration guide.

### How can I clean up the REG\_LOG table?

The `REG_LOG` table contains all the registry operations performed for all the registry resources in the system. When you clean up this table, you need to keep the latest record from every resource path to maintain atleast one resource reference in case of reindexing. Exceute the following query to clean this table.

``` java
CREATE TABLE reg_log_ids_to_KEEP (
                REG_LOG_ID INTEGER,
                REG_TENANT_ID INTEGER
);
INSERT INTO reg_log_ids_to_KEEP (REG_LOG_ID, REG_TENANT_ID) 
SELECT MAX(REG_LOG_ID) AS REG_LOG_ID, REG_TENANT_ID FROM REG_LOG GROUP BY REG_PATH, REG_TENANT_ID;

DELETE FROM REG_LOG where REG_LOG_ID not in (SELECT REG_LOG_ID from reg_log_ids_to_KEEP);
drop table reg_log_ids_to_KEEP;

DELETE FROM REG_LOG WHERE REG_ACTION = 7;
```
Cleaning up the REG\_LOG table periodically might be required if there is a large amount of data in the table, and as a result it takes a long time to process queries. Executing the query given above helps to improve the performance of the database.

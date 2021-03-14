# Maintaining Logins and Passwords

The following section explains how you can change your credentials, recover your password, and customize your login.

## Change the super admin credentials

Follow the instructions below to change the default admin password:

1.  Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file and change the user credentials as shown below.

    ``` toml
    [super_admin]
    username = "your-name"
    password = "your-password"
    ```

!!! note
    **Do you have any special characters in username or passwords?**

    -   The above credentials are applied to relevant XML configuration files such as `user-mgt.xml`.

        If you specify passwords inside XML files, you have to be mindful when defining special characters in the user names and passwords.
        Based on the XML specification (<https://www.w3.org/TR/xml/#sec-cdata-sect/>), some special characters can disrupt the configuration.
        For example, the ampersand character (&) must not appear in the literal form in XML files. It can cause a Java Null Pointer exception. You must wrap it with [CDATA](https://www.w3schools.com/xml/dom_cdatasection.asp) as shown below or remove the character:    

    -   The above credentials are applied to the `jndi.properties` file.
        -   **It is not possible to use the `@` `{` `}` symbols in the username or password**.
        -   **It is also not possible to use the percentage (%) sign in the password**. When building the connection URL, the URL with credentials is parsed.
        This parsing exception happens because the percentage (%) sign acts as the escape character in URL parsing. If the percentage (%) sign in the connection string is required, use the respective encoding character for the percentage (%) sign in the connection string. For example, if you need to pass `adm%in` as the password, then the `%` symbol should be encoded with its respective URL encoding character. Therefore, you have to send it as `adm%25in`.
        For a list of possible URL parsing patterns, see [URL encoding reference](http://www.w3schools.com/tags/ref_urlencode.asp).
        Add the following configuration.

    Therefore, if you have special characters, add the following configurations.
    If you have special characters, be mindful to wrap values with CDATA tag in super_admin configurations and to encode values in the `apim.throttling.jms` configurations.  
    ``` toml
    [super_admin]
    username = "your-name"
    password = "<![CDATA[your-password]]>" 
    
    [apim.throttling.jms]
    username = "your-name"
    password = "your-encoded-password"        
    ```

    ??? info "sample deployment.toml configs"
        ```
        [super_admin]
        username = "foo_admin"
        password = "<![CDATA[~^&*#`43d:3;]]>"
        
        [apim.throttling.jms]
        username = "foo_admin"
        password = "~%5E%26*%23%6043d%3A3%3B"
        ```
            
!!! note

    Note that the above password is written to the primary user store when the server starts for the first time.
    Thereafter, the password will be validated from the primary user store and not from the configuration file.
    Therefore, if you need to change the admin password stored in the user store, you cannot simply change the credentials as above.
    To change the super admin password, you must use the **Change Password** option from the management console.

    To change the password from Management Console (<https://localhost:9443/carbon>), follow the steps in [Changing a Password](https://docs.wso2.com/display/ADMIN44x/Changing+a+Password) corresponding to API Manager.

## Recover a password

Use the `<API-M_HOME>/bin/chpasswd.sh` script.

!!! note
    If you encountered an error similar to `ant: command not found`, Please install [Apache Ant](https://ant.apache.org/) before running the above script.

## Setup an e-mail login

1. Follow the steps from Step 1 to Step 5 given in [Email Authentication](https://is.docs.wso2.com/en/5.10.0/learn/using-email-address-as-the-username/) in the WSO2 IS documentation.

2. Define the complete username with the tenant domain under the API-M throttling related sections in the `<API-M_HOME>/repository/conf/deployment.toml` file.

    If you are in the super tenant mode, the username should have the following format: 

    `<email>@carbon.super`

    ``` toml
    [tenant_mgt]
    enable_email_domain= true

    [apim.throttling.policy_deploy]
    username = "$ref{super_admin.username}@carbon.super"

    [apim.throttling]
    receiver_username = "$ref{super_admin.username}@carbon.super"

    [apim.throttling.jms]
    username="admin!wso2.com!carbon.super"
    password = "$ref{super_admin.password}"
    ```

    <html>
    <table>
    <tbody>
    <tr>
    <th width="30%"><b>Element</b></th>
    <th><b>Description</b></th>
    </tr>
    <tr>
    <td>`[tenant_mgt] enable_email_domain`</td>
    <td>This property specifies whether the email authentication is activated or not.</td>
    </tr>
    <tr>
    <td>`[apim.throttling] receiver_username`</td>
    <td>When the email login feature is enabled, the super tenant will be attached with the username. This property facilitates the latter mentioned requirement.</td>
    </tr>
    <tr>
    <td>`[apim.throttling.policy_deploy]
    username`</td>
    <td>Specify the username required to deploy throttling policies.</td>
    </tr>
    <tr>
    <td> `[apim.throttling.jms]
    username`</td>
    <td>Specify the username in JMS Connection URL.</br>
    <div class="admonition note">
    <p class="admonition-title">note</p>
    <p>The "@" character is a reserved character in the WSO2 messaging component. Therefore, when specifying the username in JMS Connection URL, under <code>apim.throttling.jms.username</code> section in the <code>&lt;API-M_HOME&gt;/repository/conf/deployment.toml</code> file, "@" characters should be replaced by "!" character. An example is shown below.</br>
    <code>
    [apim.throttling.jms]
    username="admin!wso2.com!carbon.super"
    </code>
    </p>
    </div>
    </td>
    </tr>
    </tbody>
    </table>
    </html>

3. Restart the server.

??? info "sample deployment.toml configs"
    ```
    [tenant_mgt]
    enable_email_domain= true

    [super_admin]
    username = "admin@wso2.com"
    password = "admin"
    create_admin_account = true

    [apim.throttling]
    username = "admin@wso2.com@carbon.super"

    [apim.throttling.jms]
    username = "admin!wso2.com!carbon.super"

    [user_store]
    type = "database_unique_id"
    username_java_regex = '^[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}'
    username_java_script_regex = '^[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'
    ```   

## Developer Portal

### Setup a social media login

You can auto-provision users based on a social network login by integrating the API Manager with WSO2 Identity Server. For more information, see [Log in to the API Developer Portal using Social Media]({{base_path}}/develop/customizations/log-in-to-the-dev-portal-using-social-media).

!!! note
    Note that auto-provision users based on a social network login are not supported in a **multi-tenant environment**.

!!! info
    In a multi-tenant environment, the system cannot identify the tenant domain in the login request that comes to the API Manager's Publisher/Developer Portal. Therefore, the service provider is registered as a SaaS application within the super tenant's space. Configuring user provisioning is part of creating the service provider. In order to authenticate the user through a third-party identity provider such as social network login, you must enable identity federation. As the service provider is created in the super tenant's space, the provisioned user is also created within the super tenant's space. As a result, it is not possible to provision the user in the tenant's space.

Follow the instructions below to overcome the latter mentioned limitation:

1. Write a custom authenticator to retrieve the tenant domain of the user.

     For information on writing a custom authenticator, see [Creating Custom Authenticators](https://is.docs.wso2.com/en/5.10.0/develop/writing-a-custom-local-authenticator/) in the WSO2 IS documentation.

2. Write a custom login page where the user can enter the tenant domain, which is then added to the authenticator context.

     For information on writing a custom login page, see [Customizing Login Pages](https://is.docs.wso2.com/en/5.10.0/develop/customizing-login-pages-for-service-providers/) in the WSO2 IS documentation.

3. Write a custom provisioning handler to provision the user in the tenant domain that is maintained in the context.

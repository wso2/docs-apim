# Maintaining Logins and Passwords

This section covers the following topics:

-   [Changing the super admin credentials](#MaintainingLoginsandPasswords-Changingthesuperadmincredentials)
-   [Recovering a password](#MaintainingLoginsandPasswords-Recoveringapassword)
-   [Login in via multiple user attributes in API Store](#MaintainingLoginsandPasswords-LogininviamultipleuserattributesinAPIStore)
-   [Setting up an e-mail login](#MaintainingLoginsandPasswords-Settingupane-mailloginemaillogin)
-   [Setting up a social media login](#MaintainingLoginsandPasswords-Settingupasocialmedialogin)

### Changing the super admin credentials

Follow the instructions below to change the default admin password:

1.  Change the user credentials in the following files.

    -   The `             <UserName>            ` and `             <Password>            ` values in `             <API-M_HOME>/repository/conf/user-mgt.xml            ` file.

        ``` xml
                <UserManager>
                   <Realm>
                      <Configuration>
                          ...
                          <AdminUser>
                             <UserName>admin</UserName>                  
                             <Password>admin</Password>
                          </AdminUser>
                      ...
                   </Realm>
                </UserManager>
        ```

                !!! note
        Note that the password in the `             user-mgt.xml            ` file is written to the primary user store when the server starts for the first time. Thereafter, the password will be validated from the primary user store and not from the `             user-mgt.xml            ` file. Therefore, if you need to change the admin password stored in the user store, you cannot simply change the value in the `             user-mgt.xml            ` file. To change the super admin password, you must use the **Change Password** option from the management console.

        To change the password from Management Console ( <https://localhost:9443/carbon> ), follow the steps in [Changing a Password](https://docs.wso2.com/display/ADMIN44x/Changing+a+Password) corresponding to API Manager.


    -   The `             <API-M_HOME>/repository/conf/jndi.properties            ` file.

        ``` java
                connectionfactory.TopicConnectionFactory = amqp://admin:admin@clientid/carbon?brokerlist='tcp://localhost:5672'
                connectionfactory.QueueConnectionFactory = amqp://admin:admin@clientID/test?brokerlist='tcp://localhost:5672'
        ```

    **If you have [Configured API Manager Analytics](https://docs.wso2.com/display/AM2xx/Configuring+APIM+Analytics) ,** when changing the super admin credentials you have to change credentials in `           <API-M_HOME>/repository/conf/api-manager.xml          ` and `           <API-M_HOME>/repository/conf/log4j.properties          ` as well.

    -   The `             <API-M_HOME>/repository/conf/api-manager.xml            ` file.

        ``` java
                    <Analytics>
                            <!-- Enable Analytics for API Manager -->
                            <Enabled>true</Enabled>
                            ....
                <StreamProcessorServerURL>{tcp://localhost:7612}</StreamProcessorServerURL>
                <!--StreamProcessorAuthServerURL>{ssl://localhost:7712}</StreamProcessorAuthServerURL-->
                <!-- Administrator username to login to the remote Stream Processor server. -->
                <StreamProcessorUsername>${admin.username}</StreamProcessorUsername>
                <!-- Administrator password to login to the remote Stream Processor server. -->
                <StreamProcessorPassword>${admin.password}</StreamProcessorPassword>

                ....

                <StatsProviderImpl>org.wso2.carbon.apimgt.usage.client.impl.APIUsageStatisticsRdbmsClientImpl</StatsProviderImpl>

                ...

                <StreamProcessorRestApiURL>https://localhost:9444</StreamProcessorRestApiURL>
                <StreamProcessorRestApiUsername>${admin.username}</StreamProcessorRestApiUsername>
                <StreamProcessorRestApiPassword>${admin.password}</StreamProcessorRestApiPassword>

                .....

            </Analytics>
        ```
    -   The `             <API-M_HOME>/repository/conf/log4j.properties            ` file.

        ``` java
                log4j.appender.DAS_AGENT.userName=admin
                log4j.appender.DAS_AGENT.password=admin

        log4j.appender.LOGEVENT.userName=admin
        log4j.appender.LOGEVENT.password=admin       
        ```
!!! note
**Do you have any special characters in passwords?**

-   If you specify passwords inside XML files, take care when giving special characters in the user names and passwords. According to XML specification ( <http://www.w3.org/TR/xml/> ), some special characters can disrupt the configuration. For example, the ampersand character (&) must not appear in the literal form in XML files. It can cause a Java Null Pointer exception. You must wrap it with CDATA ( <http://www.w3schools.com/xml/xml_cdata.asp> ) as shown below or remove the character:

    ``` xml
        <Password>
            <![CDATA[xnvYh?@VHAkc?qZ%Jv855&A4a,%M8B]]>
        </Password>
    ```

-   Note the following if you have special characters in the passwords on your `           jndi.properties          ` file:

    -   It is not possible to use the `            @           ` symbol in the username or password.
    -   It is also not possible to use the percentage (%) sign in the password. When building the connection URL, the URL is parsed. This parsing exception happens because the percentage (%) sign acts as the escape character in URL parsing. If using the percentage (%) sign in the connection string is required, use the respective encoding character for the percentage (%) sign in the connection string. For example, if you need to pass `            adm%in           ` as the password, then the `            %           ` symbol should be encoded with its respective URL encoding character. Therefore, you have to send it as `            adm%25in           ` .
        For a list of possible URL parsing patterns, see [URL encoding reference](http://www.w3schools.com/tags/ref_urlencode.asp) .


### Recovering a password

For information, see [How can I recover the admin password used to log in to the management console?](_FAQ_)

### Login in via multiple user attributes in API Store

For information, see [Authentication using multiple Attributes](https://docs.wso2.com/display/IS560/Managing+User+Attributes#ManagingUserAttributes-Authenticationusingmultipleattributes) in the WSO2 IS documentation.

### Setting up an e-mail login

For information, see [Email Authentication](https://docs.wso2.com/display/IS560/Using+Email+Address+as+the+Username) in the WSO2 IS documentation.

!!! tip
-   When setting up email login, specify the complete username with tenant domain. If you are in the super tenant mode the username should be as follows. `          <username>@<email>@carbon.super         `
    **Example:** `                     admin@wso2.com                    @carbon.super         `

<!-- -->

-   When configuring the `          <DataPublisher>         ` section under `          <ThrottlingConfiguration>         ` in the `          <PRODUCT_HOME>/repository/conf/api-manager.xml         ` file, specify the fully qualified username with tenant domain.
    **Example :** `          <Username>admin@                     wso2.com                    @carbon.super</Username>         `

<!-- -->

-   The "@" character is a reserved character in the WSO2 messaging component. Therefore, when specifing username in JMS Connection URL, under `           <JMSConnectionParameters>          ` section in the `           <PRODUCT_HOME>/repository/conf/api-manager.xml          ` file, "@" characters should be replaced by "!" character. An example is shown below.

    ``` java
        <connectionfactory.TopicConnectionFactory><![CDATA[amqp://admin!wso2.com!carbon.super:admin@clientid/carbon?failover='roundrobin'&cyclecount='2'&brokerlist='tcp://10.100.0.3:5682?retries='5'&connectdelay='50';tcp://10.100.0.3:5692?retries='5'&connectdelay='50'']]></connectionfactory.TopicConnectionFactory>
    ```


### Setting up a social media login

You can auto-provision users based on a social network login by integrating the API Manager with WSO2 Identity Server. Refer [Log in to the API Store using Social Media](_Log_in_to_the_API_Store_using_Social_Media_) for more information.

!!! note
Note that auto-provision users based on a social network login is not supported in a **multi-tenant environment** .

!!! info
In a multi-tenant environment, the system cannot identify the tenant domain in the login request that comes to the API Manager's Publisher/Store. Therefore, the service provider is registered as a SaaS application within the super tenant's space. Configuring user provisioning is part of creating the service provider. In order to authenticate the user through a third party identity provider such as a social network login, you must enable identity federation. As the service provider is created in the super tenant's space, the provisioned user is also created within the super tenant's space. As a result, it is not possible to provision the user in the tenant's space.

To overcome this limitation, you can write a custom authenticator to retrieve the tenant domain of the user and write a custom login page where the user can enter the tenant domain, which is then added to the authenticator context. Then, write a custom provisioning handler to provision the user in the tenant domain that is maintained in the context.

-   For information on writing a custom authenticator, see [Creating Custom Authenticators](https://docs.wso2.com/display/IS560/Writing+a+Custom+Local+Authenticator) in the WSO2 IS documentation.
-   For information on writing a custom login page, see [Customizing Login Pages](https://docs.wso2.com/display/IS560/Customizing+Login+Pages+for+Service+Providers) in the WSO2 IS documentation.



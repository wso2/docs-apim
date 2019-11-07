# admin\_Configuring a Read-Only LDAP User Store

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `user-mgt.xml` file found in the `<PRODUCT_HOME>/repository/conf/` directory. This file is shipped with user store manager configurations for all possible user store types (JDBC, read-only LDAP/Active Directory, read-write LDAP and read-write Active directory). The instructions given below explains how to configure a read-only LDAP or Active Directory as the primary user store for the WSO2 server.

!!! info
The default User Store

The primary user store that is configured by default in the user-mgt.xml file is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2 for all WSO2 products excluding the Identity Server. This database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles). In the case of the WSO2 Identity Server, the default user store is an LDAP (Apache DS) that is shipped with the product.


Note that the RDBMS used in the default configuration can remain as the database used for storing Authorization information.

Follow the given steps to configure a read-only LDAP/AD as the primary user store:

-   [Step 1: Setting up the read-only LDAP/AD user store manager](#admin_ConfiguringaRead-OnlyLDAPUserStore-Step1:Settinguptheread-onlyLDAP/ADuserstoremanager)
-   [Step 2: Updating the system administrator](#admin_ConfiguringaRead-OnlyLDAPUserStore-UpdatingthesystemadministratorStep2:Updatingthesystemadministrator)
-   [Step 3: Starting the server](#admin_ConfiguringaRead-OnlyLDAPUserStore-Step3:Startingtheserver)

### Step 1: Setting up the read-only LDAP/AD user store manager

!!! info
Before you begin

-   If you create the `user-mgt.xml` file yourself, be sure to save it in the `<PRODUCT_HOME>/repository/conf` directory.
-   The `class` attribute for a read-only LDAP/Active Directory is `<UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager">.`


1.  Uncomment the following user store in the `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file:
`<UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager">` . Also, ensure that you comment out the configurations for any other user stores in the same file.

2.  Given below is a sample for the L DAP/AD user store configuration in read-only mode. You can change the values to match your LDAP/AD. For descriptions on each of the properties used in the `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file which are used for configuring the primary user store , see [Properties of User Stores](https://docs.wso2.com/display/ADMIN44x/Working+with+Properties+of+User+Stores) .

    ``` html/xml
        <UserManager>
         <Realm>
          ...
           <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager"> 
                    <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
                    <Property name="ConnectionURL">ldap://localhost:10389</Property>
                    <Property name="ConnectionName">uid=admin,ou=system</Property>
                    <Property name="ConnectionPassword">admin</Property>
                    <Property name="AnonymousBind">false</Property>
                    <Property name="UserSearchBase">ou=system</Property>
                    <Property name="UserNameAttribute"></Property>
                    <Property name="UserNameSearchFilter">(&amp;(objectClass=person)(uid=?))</Property>
                    <Property name="UserNameListFilter">(objectClass=person)</Property>
                    <Property name="DisplayNameAttribute"/>
                    <Property name="ReadGroups">true</Property>
                    <Property name="GroupSearchBase">ou=system</Property>
                    <Property name="GroupNameAttribute">cn</Property>
                    <Property name="GroupNameSearchFilter">(&amp;(objectClass=groupOfNames)(cn=?))</Property>
                    <Property name="GroupNameListFilter">(objectClass=groupOfNames)</Property>
                    <Property name="MembershipAttribute">member</Property>
                    <Property name="BackLinksEnabled">false</Property>
                    <Property name="UsernameJavaRegEx">[a-zA-Z0-9._-|//]{3,30}$</Property>
                    <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
                    <Property name="RolenameJavaRegEx">[a-zA-Z0-9._-|//]{3,30}$</Property>
                    <Property name="SCIMEnabled">false</Property>
                    <Property name="PasswordHashMethod">PLAIN_TEXT</Property>
                    <Property name="MultiAttributeSeparator">,</Property>
                    <Property name="MaxUserNameListLength">100</Property>
                    <Property name="MaxRoleNameListLength">100</Property>
                    <Property name="UserRolesCacheEnabled">true</Property>
                    <Property name="ConnectionPoolingEnabled">true</Property>
                    <Property name="LDAPConnectionTimeout">5000</Property>
                    <Property name="ReadTimeout"/>
                    <Property name="RetryAttempts"/>
                    <Property name="ReplaceEscapeCharactersAtUserLogin">true</Property> 
                </UserStoreManager>
         </Realm>
        </UserManager> 
    ```

    1.  Update the connection details to match your user store. For example:

        ``` html/xml
                <Property name="ConnectionURL">ldap://localhost:10389</Property>
        ```

        For Active Directory, theconnectionURLshouldhavethe following format:

        ``` java
                    <Property name="ConnectionURL">ldap://<AD host-ip>:<AD_listen_port></Property>
        ```

                !!! note
        If you are using `ldaps` (secured LDAP) to connect to the LDAP/Active Directory:

        -   You need set the `ConnectionURL` as shown below.

            ``` xml
                        <Property name="ConnectionURL">ldaps://10.100.1.100:636</Property>
            ```

        -   For Active Directory, you need to import the certificate of Active Directory to the `client-truststore.jks` of the WSO2 product. For information on how to add certificates to the truststore and how keystores are configured and used in a system, see [Using Asymmetric Encryption](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption) .

        -   You also need to [enable connection pooling](https://docs.wso2.com/display/ADMIN44x/Performance+Tuning#PerformanceTuning-ldaps_pooling) for LDAPS connections at the time of starting your server, which will enhance server performance.


    2.  Obtain a user who has permission to read all users/attributes and perform searches on the user store from your LDAP/Active Directory administrator. For example, if the privileged user is AdminLDAP and the password is 2010\#Avrudu, update the following sections of the user store configuration as shown below. Note that this user does NOT have to be the system administrator that you define [here](#admin_ConfiguringaRead-OnlyLDAPUserStore-Updatingthesystemadministrator) .

        ``` html/xml
                <Property name="ConnectionName">uid=AdminLDAP,ou=system</Property>
                <Property name="ConnectionPassword">2010#Avrudu</Property>
        ```

    3.  Update `<Property name="UserSearchBase">` with the directory name where the users are stored. When LDAP searches for users, it will start from this location of the directory.

        ``` html/xml
                    <Property name="UserSearchBase">ou=system</Property> 
        ```

    4.  Set the attribute to use as the username, typically either `cn` or `uid` for LDAP. Ideally, `<Property name="UserNameAttribute">` and `<Property name="UserNameSearchFilter">` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP/Active Directory administrator.

        For example:

        ``` html/xml
                    <Property name="UserNameAttribute">uid</Property>
        ```

    5.  Set the `ReadGroups` property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `GroupSearchBase` , `GroupSearchFilter` and `GroupNameAttribute` properties. If the `ReadGroups` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a membership (user list) or backlink attribute as shown below.
        To read the user/role mapping based on a membership (This is used by the `ApacheDirectory` server and `OpenLDAP)` :

        -   Enable the `ReadGroups` property.

            ``` html/xml
                            <Property name="ReadGroups">true</Property>
            ```

        -   Set the `GroupSearchBase` property to the directory name where the Roles are stored. That is, the roles you create using the management console of your product will be stored in this directory location. Also, when LDAP searches for users, it will start from this location of the directory. For example:

            ``` html/xml
                            <Property name="GroupSearchBase">ou=system,CN=Users,DC=wso2,DC=test</Property>
            ```

        -   Set the GroupSearchFilter and GroupNameAttributes. For example:

            ``` html/xml
                            <Property name="GroupSearchFilter">(objectClass=groupOfNames)</Property>
                            <Property name="GroupNameAttribute">cn</Property>
            ```

        -   Set the `MembershipAttribute` property as shown below:

            ``` html/xml
                            <Property name="MembershipAttribute">member</Property> 
            ```

        To read roles based on a backlink attribute, use thefollowingcodesnipetinsteadofthe above:

        ``` html/xml
                    <Property name="ReadGroups">false</Property>
                    <Property name="GroupSearchBase">ou=system</Property>
                    <Property name="GroupSearchFilter">(objectClass=groupOfNames)</Property>
                    <Property name="GroupNameAttribute">cn</Property>
                    <Property name="MembershipAttribute">member</Property>
        <Property name="BackLinksEnabled">true</Property>
        <Property name="MembershipOfAttribute">memberOf</Property> 
        ```
    6.  For Active Directory, you can use `<Property name="Referral">follow</Property>` to enable referrals within the user store. The AD user store may be partitioned into multiple domains. However, according to the use store configurations in the `user-mgt.xml` file, we are only connecting to one of the domains. Therefore, when a request for an object is received to the user store, the `<Property name="Referral">follow</Property>` property ensures that all the domains in the directory will be searched to locate the requested object.

    7.  In WSO2 products based on Carbon 4.4.x, you can set the `LDAPConnectionTimeout` property: If the connection to the LDAP is inactive for the length of time (in milliseconds) specified by this property, the connection will be terminated.

### Step 2: Updating the system administrator

The admin user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. The `<Configuration>` section in the `user-mgt.xml` file contains the super admin information. Update this configuration for the read-only LDAP/AD as explained below.

``` java
    <Configuration>
            <AddAdmin>False</AddAdmin>
            <AdminRole>admin</AdminRole>
            <AdminUser>
                 <UserName>AdminSOA</UserName>
                 <Password>XXXXXX</Password>
            </AdminUser>
            ............
    </Configuration> 
```

-   **&lt;AddAdmin&gt;:** This should be set to 'False' as it will not be allowed to create users and roles in a read-only user store.
-   **&lt;AdminRole&gt;:** The admin role you enter here should already exist in the read-only user store. Otherwise, you must enter an internal role, which will be saved to the internal database of the system when the system starts the first time.
-   **&lt;AdminUser&gt;:** Since we are configuring a read-only LDAP as the primary user store, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. For example, say a valid username is AdminSOA. Update the `<AdminUser>` section of your configuration as shown above. You do not have to update the password element as it is already set in the user store.

For information information about the system administrator user, see [Configuring the System Administrator](https://docs.wso2.com/display/ADMIN44x/Configuring+the+System+Administrator) , and for information on how keystores are used in WSO2 products, see [Using Asymmetric Encryption](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption) .

### Step 3: Starting the server

Start your server and try to log in as the admin user you specifie d. The password is the admin user's password in the LDAP server.



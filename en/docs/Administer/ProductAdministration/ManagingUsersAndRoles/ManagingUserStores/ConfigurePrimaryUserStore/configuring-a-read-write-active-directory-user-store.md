# Configuring a Read-Write Active Directory User Store

!!! info
The default User Store

The primary user store that is configured by default in the `user-mgt.xml` file is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2 for all WSO2 products excluding WSO2 Identity Server. This database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles). In the case of the WSO2 Identity Server, the default user store is an LDAP (Apache DS) that is shipped with the product.


Note that the RDBMS used in the default configuration can remain as the database used for storing Authorization information.

Follow the given steps to configure an external Active Directory as the primary user store:

-   [Step 1: Setting up the external AD user store manager](#ConfiguringaRead-WriteActiveDirectoryUserStore-Step1:SettinguptheexternalADuserstoremanager)
-   [Step 2: Updating the system administrator](#ConfiguringaRead-WriteActiveDirectoryUserStore-Step2:Updatingthesystemadministrator)
-   [Step 3: Starting the server](#ConfiguringaRead-WriteActiveDirectoryUserStore-Step3:Startingtheserver)

### Step 1: Setting up the external AD user store manager

!!! info
Before you begin

-   If you create the `user-mgt.xml` file yourself, be sure to save it in the `<PRODUCT_HOME>/repository/conf` directory.
-   The `class` attribute for an external AD is `<UserStoreManager class="org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager">.`


1.  Enable the `ActiveDirectoryUserStoreManager` class in the `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file by uncommenting the code. When it is enabled, the user manager reads/writes into the Active Directory user store.

        !!! note
    Note that these configurations already exist in the `user-mgt.xml` file so you only need to uncomment them and make the appropriate adjustments. Also ensure that you comment out the configurations for other user stores which you are not using.


2.  The default configuration for the external read/write user store in the `user-mgt.xml` file is as given below. Change the values according to your requirement. For more information on each of the properties used in the user-mgt.xml file for configuring the primary user store , see [Properties of User Stores](https://docs.wso2.com/display/ADMIN44x/Working+with+Properties+of+User+Stores) .

    ``` html/xml
        <UserStoreManager class="org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager">
                    <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
                    <Property name="ConnectionURL">ldaps://10.100.1.100:636</Property> 
                    <Property name="ConnectionName">CN=admin,CN=Users,DC=WSO2,DC=Com</Property>
                    <Property name="ConnectionPassword">A1b2c3d4</Property>
                    <Property name="AnonymousBind">false</Property>
                    <Property name="UserSearchBase">CN=Users,DC=WSO2,DC=Com</Property>
                    <Property name="UserEntryObjectClass">user</Property>
                    <Property name="UserNameAttribute">cn</Property>
                    <Property name="UserNameSearchFilter">(&amp;(objectClass=user)(cn=?))</Property>
                    <Property name="UserNameListFilter">(objectClass=user)</Property>
                    <Property name="DisplayNameAttribute"/>
                    <Property name="ReadGroups">true</Property>
                    <Property name="WriteGroups">true</Property>
                    <Property name="GroupSearchBase">CN=Users,DC=WSO2,DC=Com</Property>
                    <Property name="GroupEntryObjectClass">group</Property>
                    <Property name="GroupNameAttribute">cn</Property>
                    <Property name="GroupNameSearchFilter">(&amp;(objectClass=group)(cn=?))</Property>
                    <Property name="GroupNameListFilter">(objectcategory=group)</Property>
                    <Property name="MembershipAttribute">member</Property>
                    <Property name="MemberOfAttribute">memberOf</Property>
                    <Property name="BackLinksEnabled">true</Property>
                    <Property name="Referral">follow</Property>
                    <Property name="UsernameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
                    <Property name="UsernameJavaScriptRegEx">^[\S]{3,30}$</Property>
                    <Property name="UsernameJavaRegExViolationErrorMsg">Username pattern policy violated</Property>
                    <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
                    <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
                    <Property name="PasswordJavaRegExViolationErrorMsg">Password length should be within 5 to 30 characters</Property>
                    <Property name="RolenameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
                    <Property name="RolenameJavaScriptRegEx">^[\S]{3,30}$</Property>
                    <Property name="SCIMEnabled">false</Property>
                    <Property name="IsBulkImportSupported">true</Property>
                    <Property name="EmptyRolesAllowed">true</Property>
                    <Property name="PasswordHashMethod">PLAIN_TEXT</Property>
                    <Property name="MultiAttributeSeparator">,</Property>
                    <Property name="isADLDSRole">false</Property>
                    <Property name="userAccountControl">512</Property>
                    <Property name="MaxUserNameListLength">100</Property>     
                    <Property name="MaxRoleNameListLength">100</Property>                     
                    <Property name="kdcEnabled">false</Property>
                    <Property name="defaultRealmName">WSO2.ORG</Property>
                    <Property name="UserRolesCacheEnabled">true</Property>
                    <Property name="ConnectionPoolingEnabled">false</Property>
                    <Property name="LDAPConnectionTimeout">5000</Property>
                    <Property name="ReadTimeout"/>
                    <Property name="RetryAttempts"/>
        </UserStoreManager>
    ```

        !!! note
    When working with Active Directory;

    -   It is best to enable the `GetAllRolesOfUserEnabled` property in the `AuthorizationManager` as follows. See the documentation on [configuring the Authorization Manager](#ConfiguringaRead-WriteActiveDirectoryUserStore-RelatedTopics) for more information.

        ``` xml
                <AuthorizationManager class="org.wso2.carbon.user.core.authorization.JDBCAuthorizationManager">
                    <Property name="AdminRoleManagementPermissions">/permission</Property>
                    <Property name="AuthorizationCacheEnabled">true</Property>
                    <Property name="GetAllRolesOfUserEnabled">true</Property>
                </AuthorizationManager>
        ```

        Although using the user store manager does not depend on this property, you must consider enabling this if there are any performance issues in your production environment. Enabling this property affects the performance when the user logs in. This depends on the users, roles and permission stats.

    -   If you are using `ldaps` (secured LDAP) to connect to the Active Directory as shown in the example below, you need to import the certificate of Active Directory to the `client-truststore.jks` of the WSO2 product. For information on how to add certificates to the truststore and how keystores are configured and used in a system, see [Using Asymmetric Encryption](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption) .

        ``` xml
                    <Property name="ConnectionURL">ldaps://10.100.1.100:636</Property>
        ```

    -   You also need to [enable connection pooling](https://docs.wso2.com/display/ADMIN44x/Performance+Tuning#PerformanceTuning-ldaps_pooling) for LDAPS connections at the time of starting your server, which will enhance server performance.


3.  For Active Directory, you can use `<Property name="Referral">follow</Property>` to enable referrals within the user store. The AD user store may be partitioned into multiple domains. However, according to the use store configurations in the `user-mgt.xml` file, we are only connecting to one of the domains. Therefore, when a request for an object is received to the user store, the `<Property name="Referral">follow</Property>` property ensures that all the domains in the directory will be searched to locate the requested object.

4.  Set the attribute to use as the username, typically either `cn` or `uid` for LDAP. Ideally, `<Property name="UserNameAttribute">` and `<Property name="UserNameSearchFilter">` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP/Active Directory administrator.

    ``` html/xml
        <Property name="UserNameAttribute">sAMAccountName</Property>
    ```

5.  In WSO2 products based on Carbon 4.4.x, you can set the `LDAPConnectionTimeout` property: If the connection to the LDAP is inactive for the length of time (in milliseconds) specified by this property, the connection will be terminated.

6.  Set the `ReadGroups` property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `GroupSearchBase` , `GroupSearchFilter` and `GroupNameAttribute` properties. If the `ReadGroups` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a membership (user list) or backlink attribute as shown below.
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

    To read roles based on a backlink attribute, use the following code snipet instead of the above:

    ``` html/xml
            <Property name="ReadGroups">false</Property>
            <Property name="GroupSearchBase">ou=system</Property>
            <Property name="GroupSearchFilter">(objectClass=groupOfNames)</Property>
            <Property name="GroupNameAttribute">cn</Property>
            <Property name="MembershipAttribute">member</Property>
    <Property name="BackLinksEnabled">true</Property>
    <Property name="MembershipOfAttribute">memberOf</Property> 
    ```
### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. Since the Active Directory user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. Alternatively, you can also use a user ID that already exists in the user store. For more information on setting up the system administrator and the authorization manager, see [Configuring the User Realm](https://docs.wso2.com/display/ADMIN44x/Configuring+the+User+Realm) .

-   These two alternative configurations can be done as explained below.

<!-- -->

-   Find a valid user that already resides in the user store. For example, say a valid username is AdminSOA. Update the `<AdminUser>` section of your configuration as shown below. You do not have to update the password element as it is already set in the user store.

    ``` html/xml
        <AddAdmin>False</AddAdmin> 
        <AdminRole>admin</AdminRole> 
        <AdminUser>
         <UserName>AdminSOA</UserName> 
         <Password>XXXXXX</Password> 
        </AdminUser>
    ```

-   Since the user store can be written to, you can add the super tenant user to the user store. Therefore, `<AddAdmin>` should be set to `true` as shown below.

    ``` html/xml
            <AddAdmin>true</AddAdmin> 
            <AdminRole>admin</AdminRole> 
            <AdminUser> 
             <UserName>admin</UserName> 
             <Password>admin</Password> 
            </AdminUser>
    ```

### Step 3: Starting the server

Start your server and try to log in as the admin user you specified.

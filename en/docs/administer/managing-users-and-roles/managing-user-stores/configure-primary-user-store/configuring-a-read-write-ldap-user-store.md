# Configuring a Read-Write LDAP User Store

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `deployment.toml` file found in the `<PRODUCT_HOME>/repository/conf/` directory and the changes will be automatically applied to `user-mgt.xml` file in `<PRODUCT_HOME>/repository/conf/` directory as well. This file is shipped with user store manager configurations for all possible user store types (JDBC, read-only LDAP/Active Directory, read-write LDAP and read-write Active directory). The instructions given below explains how to configure a read-write LDAP as the primary user store for the WSO2 server.

!!! info
        The default User Store

        The primary user store that is configured by default in the user-mgt.xml file of WSO2 products is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2. This database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles). In the case of the WSO2 Identity Server, the default user store is an LDAP (Apache DS) that is shipped with the product.


        Note that the RDBMS used in the default configuration can remain as the database used for storing Authorization information.

Follow the given steps to configure a read-write LDAP as the primary user store:

-   [Step 1: Setting up the read-write LDAP user store manager](#ConfiguringaRead-WriteLDAPUserStore-Step1:Settinguptheread-writeLDAPuserstoremanager)
-   [Step 2: Updating the system administrator](#ConfiguringaRead-WriteLDAPUserStore-Step2:Updatingthesystemadministrator)
-   [Step 3: Starting the server](#ConfiguringaRead-WriteLDAPUserStore-Step3:Startingtheserver)

### Step 1: Setting up the read-write LDAP user store manager


Before you begin

-   Navigate to `<PRODUCT_HOME>/repository/conf` directory to open `deployment.toml` file and do user_store_properties configurations as follows:
    ```
    [user_store.properties]
    TenantManager= "org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager"
    ConnectionURL="ldap://localhost:10390"
    ConnectionName="uid=admin,ou=system"
    UserSearchBase="ou=Users,dc=wso2,dc=org"
    GroupSearchBase="ou=Groups,dc=wso2,dc=org"
    ConnectionPassword="admin"
    AnonymousBind= "false"
    WriteGroups= "true"
    UserEntryObjectClass= "identityPerson"
    UserNameAttribute= "uid"
    UserNameSearchFilter= "(\u0026amp;(objectClass\u003dperson)(uid\u003d?))"
    UserNameListFilter= "(objectClass\u003dperson)"
    DisplayNameAttribute= ""
    GroupEntryObjectClass= "groupOfNames"
    GroupNameAttribute= "cn"
    GroupNameSearchFilter= "(\u0026amp;(objectClass\u003dgroupOfNames)(cn\u003d?))"
    GroupNameListFilter= "(objectClass\u003dgroupOfNames)"
    MembershipAttribute= "member"
    BackLinksEnabled= "false"
    SCIMEnabled= "true"
    IsBulkImportSupported= "true"
    UsernameJavaRegEx= "[a-zA-Z0-9._\\-|//]{3,30}$"
    RolenameJavaRegEx= "[a-zA-Z0-9._\\-|//]{3,30}$"
    PasswordHashMethod= "PLAIN_TEXT"
    ConnectionPoolingEnabled= "false"
    LDAPConnectionTimeout= "5000"
    ReplaceEscapeCharactersAtUserLogin= "true"
    EmptyRolesAllowed= "true"
    kdcEnabled= "false"
    defaultRealmName= "WSO2.ORG"
    StartTLSEnabled= "false"
    UserRolesCacheEnabled= "true"
    ConnectionRetryDelay= "2m"
    ```
-   The `class` attribute for a read-write LDAP is `<UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager">`
    ```
    [user_store]
    class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager"
    type = "database"
    ```


Once the above points are made note of and completed, you can start configuring your external read-write LDAP as the primary user store.

!!! note
    Note that these configurations will automatically applied to the `user-mgt.xml` file so you do not need to edit it.


The configuration for the external read/write user store in the `user-mgt.xml` file looks as follows. For more information about each of the properties used in the `deployment.toml` file for configuring the primary user store , see [Properties of User Stores](https://is.docs.wso2.com/en/5.10.0/setup/configuring-a-read-write-ldap-user-store/#properties-used-in-read-write-ldap-user-store-manager) .

``` xml
<UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager">
  <Property name="IsBulkImportSupported">true</Property>
  <Property name="MaxUserNameListLength">100</Property>
  <Property name="MultiAttributeSeparator">,</Property>
  <Property name="ConnectionPassword">admin</Property>
  <Property name="UserNameUniqueAcrossTenants">false</Property>
  <Property name="StoreSaltedPassword">true</Property>
  <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
  <Property name="UserSearchBase">ou=system</Property>
  <Property name="GroupNameSearchFilter">(&amp;(objectClass=groupOfNames)(cn=?))</Property>
  <Property name="ConnectionPoolingEnabled">true</Property>
  <Property name="CaseInsensitiveUsername">true</Property>
  <Property name="UserNameSearchFilter">(&amp;(objectClass=person)(uid=?))</Property>
  <Property name="LDAPConnectionTimeout">5000</Property>
  <Property name="UserNameAttribute">uid</Property>
  <Property name="GroupNameAttribute">cn</Property>
  <Property name="UsernameJavaRegEx">[a-zA-Z0-9._\-|//]{3,30}$</Property>
  <Property name="WriteGroups">true</Property>
  <Property name="AnonymousBind">false</Property>
  <Property name="ConnectionName">uid=admin,ou=system</Property>
  <Property name="ConnectionURL">ldap://localhost:10390</Property>
  <Property name="RolenameJavaScriptRegEx">^[\S]{3,30}$</Property>
  <Property name="RolenameJavaRegEx">[a-zA-Z0-9._\-|//]{3,30}$</Property>
  <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
  <Property name="PasswordHashMethod">PLAIN_TEXT</Property>
  <Property name="GroupSearchBase">ou=system</Property>
  <Property name="ReadGroups">true</Property>
  <Property name="ReplaceEscapeCharactersAtUserLogin">true</Property>
  <Property name="ConnectionRetryDelay">120000</Property>
  <Property name="MembershipAttribute">member</Property>
  <Property name="PasswordJavaRegExViolationErrorMsg">Password length should be within 5 to 30 characters</Property>
  <Property name="MaxRoleNameListLength">100</Property>
  <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
  <Property name="BackLinksEnabled">false</Property>
  <Property name="UsernameJavaRegExViolationErrorMsg">Username pattern policy violated</Property>
  <Property name="UserRolesCacheEnabled">true</Property>
  <Property name="GroupNameListFilter">(objectClass=groupOfNames)</Property>
  <Property name="SCIMEnabled">false</Property>
  <Property name="PasswordDigest">SHA-256</Property>
  <Property name="UserNameListFilter">(&amp;(objectClass=person)(!(sn=Service)))</Property>
  <Property name="UsernameJavaScriptRegEx">[a-zA-Z0-9._\\-|//]{3,30}$</Property>
  <Property name="ReadOnly">false</Property>
</UserStoreManager>
```

1.  To read and write to an LDAP userstore, it is important to ensure that the `ReadGroups` and `WriteGroups` properties in the `<PRODUCT_HOME>/repository/conf/deployment.toml` file are set to `true`.
    ```
    WriteGroups = "true"
    ReadGroups = "true"
    ```

2.  Set the attribute to use as the username, typically either `cn` or `uid` for LDAP. Ideally, `UserNameAttribute` and `UserNameSearchFilter` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP administrator.

    ```
    UserNameAttribute = "uid"
    ```

3.  Specify the following properties that are relevant to connecting to the LDAP in order to perform various tasks.

    ```
    ConnectionURL = "ldap://localhost:<LDAPServerPort>"
    ConnectionName = "uid=admin,ou=system"
    ConnectionPassword = "admin"
    ```

    !!! note
        If you are using `ldaps` (secured LDAP) to connect to the LDAP:

           -   You need set the `ConnectionURL` as shown below.

           ```
           ConnectionURL = "ldaps://10.100.1.100:636"
           ```
           -   You also need to [enable connection pooling](https://is.docs.wso2.com/en/5.10.0/setup/performance-tuning-recommendations/#pooling-ldaps-connections) for LDAPS connections at the time of starting your server, which will enhance server performance.


4.  In WSO2 products based on Carbon 4.5.x, you can set the `LDAPConnectionTimeout` property: If the connection to the LDAP is inactive for the length of time (in milliseconds) specified by this property, the connection will be terminated.

5.  Set the `ReadGroups` property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `GroupSearchBase` , `GroupSearchFilter` and `GroupNameAttribute` properties. If the `ReadGroups` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a membership (user list) or back link attribute as shown below.
        To read the user/role mapping based on a membership (This is used by the `ApacheDirectory` server and `OpenLDAP)` :

       -   Enable the `ReadGroups` property.
            ```
            ReadGroups = "true"
            ```

       -   Set the `GroupSearchBase` property to the directory name where the Roles are stored. That is, the roles you create using the management console of your product will be stored in this directory location. Also, when LDAP searches for groups, it will start from this location of the directory. For example:
            ```
            GroupSearchBase = "ou=system,CN=Users,DC=wso2,DC=test"
            ```

       -   Set the GroupSearchFilter andGroupNameAttributes. For example:
            ```
            GroupSearchFilter = "(objectClass=groupOfNames)"
            GroupNameAttribute = "cn"
            ```

       -   Set the `MembershipAttribute` property as shown below:
            ```
            MembershipAttribute = "member"
            ```

        To read roles based on a backlink attribute, use thefollowingcodesnipetinsteadofthe above:

        ```
        ReadGroups = "false"
        GroupSearchBase = "ou=system"
        GroupSearchFilter = "(objectClass=groupOfNames)"
        GroupNameAttribute = "cn"
        MembershipAttribute = "member"
        BackLinksEnabled = "true"
        MembershipOfAttribute = "memberOf" 
        ```

### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. Since the LDAP user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. Alternatively, you can also use a user ID that already exists in the LDAP. For information about the system administrator user, see [Configuring the System Administrator]({{base_path}}/reference/config-catalog/#super-admin-configurations) .

These two alternative configurations can be done as explained below.

-   If the user store is read-only, find a valid user that already resides in the user store. For example, say a valid username is 'admin'. Update the `[super_admin]` section of your configuration as shown below. You do not have to update the password element as it is already set in the user store.
    ```
    [super_admin]
    username = "admin"
    password = "admin"
    create_admin_account = false
    ```

-   If the user store can be written to, you can add the super tenant user to the user store. Therefore, `create_admin_account` should be set to true as shown below.
    ```
    username = "admin"
    password = "admin"
    create_admin_account = true
    ```

### Step 3: Starting the server

Start your server and try to log in as the admin user you specified in **Step 2** .

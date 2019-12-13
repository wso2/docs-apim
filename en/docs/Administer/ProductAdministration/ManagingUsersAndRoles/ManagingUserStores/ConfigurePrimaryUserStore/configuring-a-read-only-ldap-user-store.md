# Configuring a Read-Only LDAP User Store

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `deployment.toml` file found in the `<PRODUCT_HOME>/repository/conf/` directory and the changes will be automatically applied to `user-mgt.xml` file in `<PRODUCT_HOME>/repository/conf/` directory as well. This file is shipped with user store manager configurations for all possible user store types (JDBC, read-only LDAP/Active Directory, read-write LDAP and read-write Active directory). The instructions given below explains how to configure a read-write LDAP as the primary user store for the WSO2 server.

!!! info
        The default User Store

        The primary user store that is configured by default in the user-mgt.xml file is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2 for all WSO2 products excluding the Identity Server. This database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles). In the case of the WSO2 Identity Server, the default user store is an LDAP (Apache DS) that is shipped with the product.
        
        
        Note that the RDBMS used in the default configuration can remain as the database used for storing Authorization information.

Follow the given steps to configure a read-only LDAP/AD as the primary user store:

-   [Step 1: Setting up the read-only LDAP/AD user store manager](#ConfiguringaRead-OnlyLDAPUserStore-Step1:Settinguptheread-onlyLDAP/ADuserstoremanager)
-   [Step 2: Updating the system administrator](#ConfiguringaRead-OnlyLDAPUserStore-UpdatingthesystemadministratorStep2:Updatingthesystemadministrator)
-   [Step 3: Starting the server](#ConfiguringaRead-OnlyLDAPUserStore-Step3:Startingtheserver)

### Step 1: Setting up the read-only LDAP/AD user store manager

!!! info
     In WSO2 Identity Server, the embedded user store is LDAP. Instead of using the embedded user store, you can set your own user store as the primary user store.
Before you begin

-   Navigate to `<PRODUCT_HOME>/repository/conf` directory to open `deployment.toml` file and do user_store_properties configurations according to the LDAP user store provider. Following is the read-only user store configurations for WSO2 Identity Server 5.9.0:
    ```
    [user_store.properties] 
    TenantManager="org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager"
    ConnectionURL="ldap://localhost:10390"
    ConnectionName="uid=admin,ou=system"
    ConnectionPassword="admin"
    AnonymousBind="false"
    UserNameAttribute="uid"
    UserNameSearchFilter="(&amp;(objectClass=person)(uid=?))"
    ReadGroups="true"
    GroupSearchBase="ou=system,CN=Users,DC=wso2,DC=test"
    GroupNameAttribute="cn"
    GroupNameSearchFilter="(&amp;(objectClass=groupOfNames)(cn=?))"
    GroupNameListFilter="(objectClass=groupOfNames)"
    MembershipAttribute="member"
    BackLinksEnabled="false"
    UsernameJavaRegEx="[a-zA-Z0-9._\\-|//]{3,30}$"
    PasswordJavaRegEx="^[\\S]{5,30}$"
    SCIMEnabled="true"
    PasswordHashMethod="PLAIN_TEXT"
    MultiAttributeSeparator=","
    MaxUserNameListLength="100"
    MaxRoleNameListLength="100"
    UserRolesCacheEnabled="true"
    LDAPConnectionTimeout=5000
    ReplaceEscapeCharactersAtUserLogin="true"
    ConnectionRetryDelay="120000"
    GroupSearchFilter="(objectClass=groupOfNames)"
    UserEntryObjectClass="identityPerson"
    IsBulkImportSupported="true"
    defaultRealmName="WSO2.ORG"
    EmptyRolesAllowed="true"
    UserSearchBase="ou=Users,dc=wso2,dc=org"            
    ConnectionPoolingEnabled="false"
    StartTLSEnabled="false"
    WriteGroups="true"
    RolenameJavaRegEx="[a-zA-Z0-9._\\-|//]{3,30}$"
    GroupEntryObjectClass="groupOfNames"
    EnableMaxUserLimitForSCIM="false"
    PasswordJavaRegExViolationErrorMsg="Password length should be within 5 to 30 characters"
    PasswordJavaScriptRegEx="^[\\S]{5,30}$"
    UsernameJavaRegExViolationErrorMsg="Username pattern policy violated"
    UserNameListFilter="(objectClass=person)"
    UsernameJavaScriptRegEx="^[\\S]{3,30}$"
    kdcEnabled="false"
    ```

-   The `class` attribute for a read-only LDAP/Active Directory is `org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager`.
    ```
    [user_store]
    class="org.wso2.carbon.user.core.ldap.RReadOnlyLDAPUserStoreManager"
    type = "database"
    ```

!!! note
    Note that these configurations will automatically applied to the `user-mgt.xml` file so you do not need to edit it.
    
Given below is a sample for the L DAP/AD user store configuration in read-only mode. You can change the values to match your LDAP/AD in `deployment.toml` file. For descriptions on each of the properties used in the `<PRODUCT_HOME>/repository/conf/deployment.toml` file which are used for configuring the primary user store , see [Properties of User Stores](https://is.docs.wso2.com/en/5.9.0/setup/configuring-a-read-only-ldap-user-store/#properties-used-in-read-only-ldap-user-store-manager).
The configuration for the external read-only user store in the user-mgt.xml file looks as follows for the above configurations:

    <UserManager>
      <Realm>
        <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager">
            <Property name="IsBulkImportSupported">true</Property>
            <Property name="MaxUserNameListLength">100</Property>
            <Property name="defaultRealmName">WSO2.ORG</Property>
            <Property name="MultiAttributeSeparator">,</Property>
            <Property name="EmptyRolesAllowed">true</Property>
            <Property name="ConnectionPassword">admin</Property>
            <Property name="UserNameUniqueAcrossTenants">false</Property>
            <Property name="StoreSaltedPassword">true</Property>
            <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
            <Property name="UserSearchBase">ou=Users,dc=wso2,dc=org</Property>
            <Property name="GroupNameSearchFilter">(&amp;(objectClass=groupOfNames)(cn=?))</Property>
            <Property name="ConnectionPoolingEnabled">false</Property>
            <Property name="StartTLSEnabled">false</Property>
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
            <Property name="GroupSearchFilter">(objectClass=groupOfNames)</Property>
            <Property name="RolenameJavaRegEx">[a-zA-Z0-9._\-|//]{3,30}$</Property>
            <Property name="GroupEntryObjectClass">groupOfNames</Property>
            <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
            <Property name="EnableMaxUserLimitForSCIM">false</Property>
            <Property name="PasswordHashMethod">PLAIN_TEXT</Property>
            <Property name="GroupSearchBase">ou=system,CN=Users,DC=wso2,DC=test</Property>
            <Property name="ReadGroups">true</Property>
            <Property name="ReplaceEscapeCharactersAtUserLogin">true</Property>
            <Property name="ConnectionRetryDelay">120000</Property>
            <Property name="MembershipAttribute">member</Property>
            <Property name="UserEntryObjectClass">identityPerson</Property>
            <Property name="PasswordJavaRegExViolationErrorMsg">Password length should be within 5 to 30 characters</Property>
            <Property name="MaxRoleNameListLength">100</Property>
            <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
            <Property name="BackLinksEnabled">false</Property>
            <Property name="UsernameJavaRegExViolationErrorMsg">Username pattern policy violated</Property>
            <Property name="UserRolesCacheEnabled">true</Property>
            <Property name="GroupNameListFilter">(objectClass=groupOfNames)</Property>
            <Property name="SCIMEnabled">true</Property>
            <Property name="PasswordDigest">SHA-256</Property>
            <Property name="UserNameListFilter">(objectClass=person)</Property>
            <Property name="UsernameJavaScriptRegEx">^[\S]{3,30}$</Property>
            <Property name="ReadOnly">false</Property>
            <Property name="kdcEnabled">false</Property>
        </UserStoreManager>
      </Realm>
    </UserManager> 

   1.  Update the connection details to match your user store. For example:

     ``` 
     ConnectionURL="ldap://localhost:10390"
     ```
    
       For Active Directory, the connection URL should have the following format:
    
       ```
       ConnectionURL="ldap://<AD host-ip>:<AD_listen_port>"
       ```
    
    
    !!! note
           If you are using `ldaps` (secured LDAP) to connect to the LDAP/Active Directory:
    
           -   You need set the `ConnectionURL` as shown below.
            ```
            ConnectionURL="ldaps://10.100.1.100:636"
            ```
    
           -   For Active Directory, you need to import the certificate of Active Directory to the `client-truststore.jks` of the WSO2 product. For information on how to add certificates to the truststore and how keystores are configured and used in a system, see [Using Asymmetric Encryption](https://apim.docs.wso2.com/en/latest/Administer/ProductSecurity/General/UsingAsymmetricEncryption/creating-new-keystores/) .
    
           -   You also need to [enable connection pooling](https://is.docs.wso2.com/en/5.9.0/setup/performance-tuning-recommendations/#pooling-ldaps-connections) for LDAPS connections at the time of starting your server, which will enhance server performance.
    

   2.  Obtain a user who has permission to read all users/attributes and perform searches on the user store from your LDAP/Active Directory administrator. For example, if the privileged user is `admin` and the password is `admin`, update the following sections of the user store configuration as shown below. Note that this user does NOT have to be the system administrator that you define [here](#admin_ConfiguringaRead-OnlyLDAPUserStore-Updatingthesystemadministrator) .

     ``` 
     ConnectionName="uid=admin,ou=system"
     ConnectionPassword="admin"
     ```

   3.  Update `UserSearchBase` with the directory name where the users are stored. When LDAP searches for users, it will start from this location of the directory.

     ```
     UserSearchBase="ou=system"
     ```

   4.  Set the attribute to use as the username, typically either `cn` or `uid` for LDAP. Ideally, `UserNameAttribute` and `UserNameSearchFilter` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP/Active Directory administrator.
    For example:

     ``` 
     UserNameAttribute="uid"
     UserNameSearchFilter="(&amp;(objectClass=person)(uid=?))"
     ```

   5.  Set the `ReadGroups` property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `GroupSearchBase` , `GroupSearchFilter` and `GroupNameAttribute` properties. If the `ReadGroups` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a membership (user list) or backlink attribute as shown below.
        To read the user/role mapping based on a membership (This is used by the `ApacheDirectory` server and `OpenLDAP)` :

    -   Enable the `ReadGroups` property.
    
        ``` 
        ReadGroups="true"
        ```

    -   Set the `GroupSearchBase` property to the directory name where the Roles are stored. That is, the roles you create using the management console of your product will be stored in this directory location. Also, when LDAP searches for users, it will start from this location of the directory. For example:

        ``` 
        GroupSearchBase="ou=system,CN=Users,DC=wso2,DC=test"
        ```

    -   Set the GroupSearchFilter and GroupNameAttributes. For example:

        ``` 
        GroupSearchFilter="(objectClass=groupOfNames)"
        GroupNameAttribute="cn"
        ```

    -   Set the `MembershipAttribute` property as shown below:

        ``` 
        MembershipAttribute="member"
        ```

        To read roles based on a backlink attribute, use the following code snipet instead of the above:

        ``` 
        ReadGroups="true"
        GroupSearchBase="ou=system,CN=Users,DC=wso2,DC=test"
        GroupSearchFilter="(objectClass=groupOfNames)"
        GroupNameAttribute="cn"
        MembershipAttribute="member"
        BackLinksEnabled="false"
        MembershipOfAttribute="memberOf"
        ```
  
   6.  For Active Directory, you can use `Referral="follow` to enable referrals within the user store. The AD user store may be partitioned into multiple domains. However, according to the use store configurations in the `deployment.toml` file, we are only connecting to one of the domains. Therefore, when a request for an object is received to the user store, the `Referral="follow"` property ensures that all the domains in the directory will be searched to locate the requested object.

   7.  In WSO2 products based on Carbon 4.5.x, you can set the `LDAPConnectionTimeout` property: If the connection to the LDAP is inactive for the length of time (in milliseconds) specified by this property, the connection will be terminated.

### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. By default, the system will create an admin user in the LDAP that has admin permissions. But this cannot be done it the LDAP user store is read-only. Hence that capability should be disabled as follows:

``` 
[super_admin]
username = "admin"
admin_role = "admin"
create_admin_account = false
```

-   **create_admin_account:** This should be set to 'False' as it will not be allowed to create users and roles in a read-only user store.
-   **admin_role:** The admin role you enter here should already exist in the read-only user store. Otherwise, you must enter an internal role, which will be saved to the internal database of the system when the system starts the first time.
-   **username:** Since we are configuring a read-only LDAP as the primary user store, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. For example, say a valid username is AdminSOA. Update the `admin_role` section of your configuration as shown above. You do not have to update the password element as it is already set in the user store.


If the user store can be written to, you can add the super tenant user to the user store. Therefore, create_admin_account should be set to true as shown below.
``` 
[super_admin]
username = "admin"
admin_role = "admin"
create_admin_account = true
```
For information information about the system administrator user, see [Configuring the System Administrator](https://apim.docs.wso2.com/en/latest/Reference/ConfigCatalog/#super-admin-configurations) , and for information on how keystores are used in WSO2 products, see [Using Asymmetric Encryption](https://apim.docs.wso2.com/en/latest/Administer/ProductSecurity/General/UsingAsymmetricEncryption/creating-new-keystores/) .

### Step 3: Starting the server

Start your server and try to log in as the admin user you specifie d. The password is the admin user's password in the LDAP server.



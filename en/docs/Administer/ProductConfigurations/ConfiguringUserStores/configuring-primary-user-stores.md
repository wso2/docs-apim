# Configuring Primary User Stores

Every WSO2 product comes with an embedded, internal user store, which is configured in `         <PRODUCT_HOME>/repository/conf/user-mgt.xml        ` . In WSO2 Identity Server, the embedded user store is LDAP, and in other products it is JDBC. Because the domain name (unique identifier) of this default user store is set to `         PRIMARY        ` by default, it is called the primary user store.

Instead of using the embedded user store, you can set your own user store as the primary user store. Since the user store you want to connect to might have different schemas from the ones available in the embedded user store, it needs to go through an adaptation process. WSO2 products provide the following adapters to enable you to authenticate users from different types of user stores and plug into LDAP, Active Directory, and JDBC to perform authentication:

<table>
<thead>
<tr class="header">
<th>User store manager class</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager</code></pre></td>
<td><p>Use <code>              ReadOnlyLDAPUserStoreManager             </code> to do read-only operations for external LDAP user stores.</p></td>
</tr>
<tr class="even">
<td><code>             org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager            </code></td>
<td><p>Use <code>              ReadWriteLDAPUserStoreManager             </code> for external LDAP user stores to do both read and write operations. This is the user store configuration which is uncommented in the code in the <code>              user-mgt.xml             </code> file.</p></td>
</tr>
<tr class="odd">
<td><pre><code>org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager</code></pre></td>
<td><p>Use <code>              ActiveDirectoryUserStoreManager             </code> to configure an Active Di rectory Domain Service (AD DS) or Active Directory Lightweight Directory Service (AD LDS).<br />
This can be used <strong>only</strong> for read/write operations.<br />
If you need to use AD as read-only you must use <code>              org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager             </code> .</p>
<pre><code>SELECT UM_USER_NAME FROM UM_USER, UM_USER_ATTRIBUTE WHERE UM_USER_ATTRIBUTE.UM_USER_ID = UM_USER.UM_ID AND UM_USER_ATTRIBUTE.UM_ATTR_NAME =? AND UM_USER_ATTRIBUTE.UM_ATTR_VALUE LIKE ? AND UM_USER_ATTRIBUTE.UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</code></pre></td>
</tr>
<tr class="even">
<td><pre><code>org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager</code></pre></td>
<td><p>Use <code>              JDBCUserStoreManager             </code> for both internal and external JDBC user stores.</p></td>
</tr>
</tbody>
</table>

The `         user-mgt.xml        ` file already has sample configurations for all of the above user stores. To enable these configurations, you must uncomment them in the code and comment out the ones that you do not need.

The following topics provide details on the various primary user stores you can configure.

-   [Configuring an external LDAP or Active Directory user store](#ConfiguringPrimaryUserStores-ConfiguringanexternalLDAPorActiveDirectoryuserstore)
-   [Configuring an internal/external JDBC user store](#ConfiguringPrimaryUserStores-Configuringaninternal/externalJDBCuserstore)

!!! note
If you are using `         ldaps        ` (secured) to connect to the Active Directory as shown below, you need to import the certificate of Active Directory to the `         client-truststore.jks        ` of the WSO2 product. See the topic on configuring keystores for information on how to add certificates to the trust-store.

``` xml
    <Property name="ConnectionURL">ldaps://10.100.1.100:636</Property>
```


### Configuring an external LDAP or Active Directory user store

All WSO2 products can read and write users and roles from external Active Directory or LDAP user stores. You can configure WSO2 products to access these user stores in one of the following modes:

-   [Read-only mode](#ConfiguringPrimaryUserStores-Read-onlymode)
-   [Read/write mode](#ConfiguringPrimaryUserStores-Read/Write)

#### Read-only mode

!!! info
Before you begin

-   If you create the `          user-mgt.xml         ` file yourself, be sure to save it in the `          <PRODUCT_HOME>/repository/conf         ` directory.
-   The `          class         ` attribute for a read-only LDAP is `          <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager">         `


When you configure a product to read users/roles from your company LDAP in read-only mode, it does not write any data into the LDAP.

1.  Comment out the following user store which is enabled by default in the `           <PRODUCT_HOME>/repository/conf/user-mgt.xml          ` file.
    `           <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager">          `

2.  Given below is a sample for the L DAP user store. This configuration is found in the `           <PRODUCT_HOME>          ` `           /repository/conf/user-mgt.xml          ` file, however, you need to uncomment them and make the appropriate adjustments. Also ensure that you comment out the configurations for other user stores which you are not using.

    ``` html/xml
        <UserManager>
         <Realm>
          ...
           <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager"> 
                    <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property> 
                    <Property name="ReadOnly">true</Property> 
                    <Property name="Disabled">false</Property> 
                    <Property name="MaxUserNameListLength">100</Property> 
                    <Property name="ConnectionURL">ldap://localhost:10389&lt</Property> 
                    <Property name="ConnectionName">uid=admin,ou=system</Property> 
                    <Property name="ConnectionPassword">admin</Property> 
                    <Property name="PasswordHashMethod">PLAIN_TEXT</Property> 
                    <Property name="UserSearchBase">ou=system</Property> 
                    <Property name="UserNameListFilter">(objectClass=person)</Property> 
                    <Property name="UserNameSearchFilter">(&amp;(objectClass=person)(uid=?))</Property> 
                    <Property name="UserNameAttribute">uid</Property> 
                    <Property name="ReadGroups">true</Property> 
                    <Property name="GroupSearchBase">ou=system</Property> 
                    <Property name="GroupNameListFilter">(objectClass=groupOfNames)</Property> 
                    <Property name="GroupNameSearchFilter">(&amp;(objectClass=groupOfNames)(cn=?))</Property> 
                    <Property name="GroupNameAttribute">cn</Property> 
                    <Property name="SharedGroupNameAttribute">cn</Property> 
                    <Property name="SharedGroupSearchBase">ou=SharedGroups,dc=wso2,dc=org</Property> 
                    <Property name="SharedGroupNameListFilter">(objectClass=groupOfNames)</Property> 
                    <Property name="SharedTenantNameListFilter">(objectClass=organizationalUnit)</Property> 
                    <Property name="SharedTenantNameAttribute">ou</Property> 
                    <Property name="SharedTenantObjectClass">organizationalUnit</Property> 
                    <Property name="MembershipAttribute">member</Property> 
                    <Property name="UserRolesCacheEnabled">true</Property> 
                    <Property name="ReplaceEscapeCharactersAtUserLogin">true</Property> 
                    <Property name="MaxRoleNameListLength">100</Property> 
                    <Property name="MaxUserNameListLength">100</Property> 
                    <Property name="SCIMEnabled">false</Property> 
                </UserStoreManager>
         </Realm>
        </UserManager>
    ```

    1.  Update the connection details to match your user store. For example:

        ``` html/xml
                <Property name="ConnectionURL">ldap://localhost:10389</Property>
        ```

    2.  Obtain a user who has permission to read all users/attributes and perform searches on the user store from your LDAP/Active Directory administrator. For example, if the privileged user is "AdminLDAP" and the password is "2010\#Avrudu", update the following sections of the realm configuration as follows:

        ``` html/xml
                    <Property name="ConnectionName">uid=AdminLDAP,ou=system</Property>
                    <Property name="ConnectionPassword">2010#Avrudu</Property>
        ```

    3.  Update `             <Property name="UserSearchBase">            ` with the directory name where the users are stored. When LDAP searches for users, it will start from this location of the directory.

        ``` html/xml
                    <Property name="UserSearchBase">ou=system</Property> 
        ```

    4.  Set the attribute to use as the username, typically either cn or uid for LDAP. Ideally, `             <Property name="UserNameAttribute">            ` and `             <Property name="UserNameSearchFilter">            ` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP/Active Directory administrator.

        For example:

        ``` html/xml
                    <Property name="UserNameAttribute">uid</Property>
        ```

    5.  Set the ReadGroups property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the GroupSearchBase, GroupSearchFilter and GroupNameAttribute properties as shown in the following example:

        ``` html/xml
                    <Property name="ReadGroups">true</Property>
                    <Property name="GroupSearchBase">ou=system</Property>
                    <Property name="GroupSearchFilter">(objectClass=groupOfNames)</Property>
                    <Property name="GroupNameAttribute">cn</Property>
        ```

        If the ReadGroups property is set to 'false', only Users can be read from the user store.

    6.  Optionally, configure the realm to read roles from the user store by reading the user/role mapping based on a membership (user list) or backlink attribute. The following code snippet represents reading roles based on a membership attribute. This is used by the `             ApacheDirectory            ` server and `             OpenLDAP            ` .

        ``` html/xml
                    <Property name="ReadGroups">false</Property>
                    <Property name="GroupSearchBase">ou=system</Property>
                    <Property name="GroupSearchFilter">(objectClass=groupOfNames)</Property>
                    <Property name="GroupNameAttribute">cn</Property>
                    <Property name="MembershipAttribute">member</Property>
        ```

    7.  For Active Directory, you can use `             <Property name="Referral">follow</Property>            ` to enable referrals within the user store. The AD user store may be partitioned into multiple domains. However, according to the use store configurations in the `             user-mgt.xml            ` file, we are only connecting to one of the domains. Therefore, when a request for an object is received to the user store, the `             <Property name="Referral">follow</Property>            ` property ensures that all the domains in the directory will be searched to locate the requested object.

3.  Start your server and try to log in as the admin user you specified. The password is the admin user's password in the LDAP server.

#### Read/write mode

!!! info
Before you begin

-   To read and write to an Active Directory user store, set the `          WriteGroups         ` property to `          true         ` instead of `          false         ` .
-   To write user entries to an LDAP user store (roles are not written, just user entries), you follow the steps in the [Read-only mode](#ConfiguringPrimaryUserStores-Read-onlymode) section but specify the following class instead:

    ``` html/xml
        <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager">
    ```

-   Use the following class for Active Directory.

    ``` html/xml
            <UserStoreManager class="org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager">
    ```


The `         <PRODUCT_HOME>/repository/conf/user-mgt.xml        ` file has commented-out configurations for external LDAP/AD user stores.

1.  Enable the `          <ReadWriteLDAPUserStoreManager>         ` or the `          <ActiveDirectoryUserStoreManager>         ` in the `          <PRODUCT_HOME>/repository/conf/user-mgt.xml         ` file by uncommenting the code. When it is enabled, the user manager reads/writes into the LDAP/AD user store. Note that these configurations already exist in the `          user-mgt.xml         ` file so you only need to uncomment them and make the appropriate adjustments. Also ensure that you comment out the configurations for other user stores which you are not using.
2.  The default configuration for the external read/write user store in the `           user-mgt.xml          ` file is as follows. Change the values according to your requirements.

    -   [**LDAP User Store**](#5c8352912e284090b14ad254e1036352)
    -   [**Active Directory User Store**](#8210d29be9484db696f669aad96bfd3e)

    LDAP user store sample:

    ``` html/xml
        <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager">
           <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
           <Property name="ConnectionURL">ldap://localhost:${Ports.EmbeddedLDAP.LDAPServerPort}</Property>
           <Property name="ConnectionName">uid=admin,ou=system</Property>
           <Property name="ConnectionPassword">admin</Property>
           <Property name="PasswordHashMethod">SHA</Property>
           <Property name="UserNameListFilter">(objectClass=person)</Property>
           <Property name="UserEntryObjectClass">wso2Person</Property>
           <Property name="UserSearchBase">ou=Users,dc=wso2,dc=org</Property>
           <Property name="UserNameSearchFilter">(&amp;(objectClass=person)(uid=?))</Property>
           <Property name="UserNameAttribute">uid</Property>
           <Property name="PasswordJavaScriptRegEx">[\\S]{5,30}</Property>
           <Property name="UsernameJavaScriptRegEx">[\\S]{3,30}</Property>
           <Property name="UsernameJavaRegEx">^[^~!@#$;%^*+={}\\|\\\\&lt;&gt;,\'\"]{3,30}$</Property>
           <Property name="RolenameJavaScriptRegEx">[\\S]{3,30}</Property>
           <Property name="RolenameJavaRegEx">^[^~!@#$;%^*+={}\\|\\\\&lt;&gt;,\'\"]{3,30}$</Property>
           <Property name="ReadGroups">true</Property>
           <Property name="WriteGroups">true</Property>
           <Property name="EmptyRolesAllowed">true</Property>
           <Property name="GroupSearchBase">ou=Groups,dc=wso2,dc=org</Property>
           <Property name="GroupNameListFilter">(objectClass=groupOfNames)</Property>
           <Property name="GroupEntryObjectClass">groupOfNames</Property>
           <Property name="GroupNameSearchFilter">(&amp;(objectClass=groupOfNames)(cn=?))</Property>
           <Property name="GroupNameAttribute">cn</Property>
           <Property name="SharedGroupNameAttribute">cn</Property>
           <Property name="SharedGroupSearchBase">ou=SharedGroups,dc=wso2,dc=org</Property> 
           <Property name="SharedGroupEntryObjectClass">groups</Property>
           <Property name="SharedTenantNameListFilter">(object=organizationalUnit)</Property>
           <Property name="SharedTenantNameAttribute">ou</Property>
           <Property name="SharedTenantObjectClass">organizationalUnit</Property>
           <Property name="MembershipAttribute">member</Property>
           <Property name="UserRolesCacheEnabled">true</Property>
           <Property name="UserDNPattern">uid={0},ou=Users,dc=wso2,dc=org</Property>
        </UserStoreManager>
    ```

        !!! tip
        **Tip** : Be sure to set the `              EmptyRolesAllowed             ` property to true. If not, you will get the following error at start up- APIManagementException: Error while creating subscriber role: subscriber - Self registration might not function properly.

    Active directory user store sample:

    ``` html/xml
        <UserStoreManager class="org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager">
                    <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
                    <Property name="defaultRealmName">WSO2.ORG</Property>
                    <Property name="Disabled">false</Property>                                   
                    <Property name="kdcEnabled">false</Property>
                    <Property name="ConnectionURL">ldaps://10.100.1.100:636</Property> 
                    <Property name="ConnectionName">CN=admin,CN=Users,DC=WSO2,DC=Com</Property>
                    <Property name="ConnectionPassword">A1b2c3d4</Property>
                    <Property name="PasswordHashMethod">PLAIN_TEXT</Property>
                    <Property name="UserSearchBase">CN=Users,DC=WSO2,DC=Com</Property>
                    <Property name="UserEntryObjectClass">user</Property>
                    <Property name="UserNameAttribute">cn</Property>
                    <Property name="isADLDSRole">false</Property>
                    <Property name="userAccountControl">512</Property>
                    <Property name="UserNameListFilter">(objectClass=user)</Property>
                    <Property name="UserNameSearchFilter">(&amp;(objectClass=user)(cn=?))</Property>
                    <Property name="UsernameJavaRegEx">[a-zA-Z0-9._-|//]{3,30}$</Property>
                    <Property name="UsernameJavaScriptRegEx">^[\S]{3,30}$</Property>
                    <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
                    <Property name="RolenameJavaScriptRegEx">^[\S]{3,30}$</Property>
                    <Property name="RolenameJavaRegEx">[a-zA-Z0-9._-|//]{3,30}$</Property>
                    <Property name="ReadGroups">true</Property>
                    <Property name="WriteGroups">true</Property>
                    <Property name="EmptyRolesAllowed">true</Property>
                    <Property name="GroupSearchBase">CN=Users,DC=WSO2,DC=Com</Property>
                    <Property name="GroupEntryObjectClass">group</Property>
                    <Property name="GroupNameAttribute">cn</Property>
                    <Property name="SharedGroupNameAttribute">cn</Property>
                    <Property name="SharedGroupSearchBase">ou=SharedGroups,dc=wso2,dc=org</Property>
                    <Property name="SharedGroupEntryObjectClass">groups</Property>
                    <Property name="SharedTenantNameListFilter">(object=organizationalUnit)</Property>
                    <Property name="SharedTenantNameAttribute">ou</Property>
                    <Property name="SharedTenantObjectClass">organizationalUnit</Property>
                    <Property name="MembershipAttribute">member</Property>
                    <Property name="GroupNameListFilter">(objectcategory=group)</Property>
                    <Property name="GroupNameSearchFilter">(&amp;(objectClass=group)(cn=?))</Property>
                    <Property name="UserRolesCacheEnabled">true</Property>
                    <Property name="Referral">follow</Property>
                    <Property name="BackLinksEnabled">true</Property>
                    <Property name="MaxRoleNameListLength">100</Property>
                    <Property name="MaxUserNameListLength">100</Property>
                    <Property name="SCIMEnabled">false</Property>
        </UserStoreManager>
    ```

        !!! tip
        **Tip** : Be sure to set the `              EmptyRolesAllowed             ` property to true. If not, you will get the following error at start up- APIManagementException: Error while creating subscriber role: subscriber - Self registration might not function properly.

        !!! note
    When working with Active Directory it is best to enable the `           GetAllRolesOfUserEnabled          ` property in the `           AuthorizationManager          ` as follows.

    ``` xml
        <AuthorizationManager class="org.wso2.carbon.user.core.authorization.JDBCAuthorizationManager">
            <Property name="AdminRoleManagementPermissions">/permission</Property>
            <Property name="AuthorizationCacheEnabled">true</Property>
            <Property name="GetAllRolesOfUserEnabled">true</Property>
        </AuthorizationManager>
    ```

    While using the user store manager does not depend on this property, you must consider enabling this if there are any performance issues in your production environment. Enabling this property affects the performance when the user logs in. This depends on the users, roles and permissions stats.

        !!! info
    If you create the `           user-mgt.xml          ` file yourself, be sure to save it in the `           <PRODUCT_HOME>/repository/conf          ` directory.

    The `           class          ` attribute of the `           UserStoreManager          ` element indicates whether it is an Active Directory or LDAP user store:

    -   Active Directory: `            <UserStoreManager class="org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager">           `
    -   Read-only LDAP: `            <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager">           `


3.  Set the attribute to use as the username, typically either cn or uid for LDAP. Ideally, `           <Property name="UserNameAttribute">          ` and `           <Property name="UserNameSearchFilter">          ` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP/Active Directory administrator.

    For example:

    -   [**LDAP**](#84e3154b36594292bc4aab79487efd67)
    -   [**Active Directory**](#19fd23de30224d1b8c93e1ef0671fedc)

    ``` html/xml
        <Property name="UserNameAttribute">uid</Property>
    ```

    ``` html/xml
            <Property name="UserNameAttribute">sAMAccountName</Property>
    ```

4.  The following code snippet represents reading roles based on a backlink attribute. This is used by the Active Directory.

    ``` html/xml
            <Property name="ReadGroups">true</Property>
            <Property name="GroupSearchBase">cn=users,dc=wso2,dc=lk</Property>
            <Property name="GroupSearchFilter">(objectcategory=group)</Property>
            <Property name="GroupNameAttribute">cn</Property>
            <Property name="MemberOfAttribute">memberOf</Property>
    ```

5.  For Active Directory, you can use `           <Property name="Referral">follow</Property>          ` to enable referrals within the user store. The AD user store may be partitioned into multiple domains. However, according to the use store configurations in the `           user-mgt.xml          ` file, we are only connecting to one of the domains. Therefore, when a request for an object is received to the user store, the `           <Property name="Referral">follow</Property>          ` property ensures that all the domains in the directory will be searched to locate the requested object.

6.  Start your server and try to log in as the admin user you specified. The password is the admin user's password in the LDAP server.

        !!! info
    When configuring an external LDAP for Governance Registry or API Manager, the user name and password for the default admin will change to the LDAP admin. As a result, the &lt;PRODUCT\_HOME&gt;/repository/conf/api-manager.xml file must be updated with the new LDAP admin credentials.


### Configuring an internal/external JDBC user store

The default internal JDBC user store reads/writes into the internal database of the Carbon server. JDBC user stores can be configured using the `         <PRODUCT_HOME>/repository/conf/user-mgt.xml        ` file's `         JDBCUserStoreManager        ` configuration section. Additionally, all Carbon-based products can work with an external RDBMS. You can configure Carbon to read users/roles from your company RDBMS and even write to it. Therefore, in this scenario, the user core connects to two databases:

-   The Carbon database where authorization information is stored internally.
-   Your company database where users/roles reside.

Therefore, the `         user-mgt.xml        ` file must contain details for two database connections. The connection details mentioned earlier are used by the authorization manager. If we specify another set of database connection details inside the UserStoreManager, it reads/writes users to that database. The following are step-by-step guidelines for connecting to an internal and external JDBC user store in read-only mode:

1.  Uncomment the following section in `           <PRODUCT_HOME>/repository/conf/user-mgt.xml          ` :

        !!! warning
    Ensure that you comment out the configurations for other user stores which you are not using when uncommenting **`            JDBCUserStoreManager           ` .**


    ``` html/xml
        <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
    ```

    The following are samples for the internal and external JDBC user store configuration:

    -   [**Internal JDBC User Store**](#d80034099ba84f588c5f15e4ad174779)
    -   [**External JDBC User Store**](#131d1d39d7904a0c9920e533fb838937)

    Internal JDBC user store configuration sample:

                <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
                    <Property name="TenantManager">org.wso2.carbon.user.core.tenant.JDBCTenantManager</Property>
                    <Property name="ReadOnly">false</Property>
                    <Property name="ReadGroups">true</Property>
                    <Property name="WriteGroups">true</Property>
                    <Property name="UsernameJavaRegEx">^[\S]{3,30}$</Property>
                    <Property name="UsernameJavaScriptRegEx">^[\S]{3,30}$</Property>
                    <Property name="UsernameJavaRegExViolationErrorMsg">Username pattern policy violated</Property>
                    <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
                    <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
                    <Property name="PasswordJavaRegExViolationErrorMsg">Password length should be within 5 to 30 characters</Property>
                    <Property name="RolenameJavaRegEx">^[\S]{3,30}$</Property>
                    <Property name="RolenameJavaScriptRegEx">^[\S]{3,30}$</Property>
                    <Property name="CaseInsensitiveUsername">true</Property>
                    <Property name="SCIMEnabled">false</Property>
                    <Property name="IsBulkImportSupported">true</Property>
                    <Property name="PasswordDigest">SHA-256</Property>
                    <Property name="StoreSaltedPassword">true</Property>
                    <Property name="MultiAttributeSeparator">,</Property>
                    <Property name="MaxUserNameListLength">100</Property>
                    <Property name="MaxRoleNameListLength">100</Property>
                    <Property name="UserRolesCacheEnabled">true</Property>
                    <Property name="UserNameUniqueAcrossTenants">false</Property>
                </UserStoreManager>

    External JDBC user store configuration sample:

    ``` html/xml
            <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
                  <Property name="TenantManager">org.wso2.carbon.user.core.tenant.JDBCTenantManager</Property>
                  <Property name="driverName">com.mysql.jdbc.Driver</Property>
                  <Property name="url">jdbc:mysql://localhost:3306/tcsdev</Property>
                  <Property name="userName">shavantha</Property>
                  <Property name="password">welcome</Property>
                  <Property name="Disabled">false</Property>
                  <Property name="MaxUserNameListLength">100</Property>
                  <Property name="MaxRoleNameListLength">100</Property>
                  <Property name="UserRolesCacheEnabled">true</Property>
                  <Property name="PasswordDigest">SHA-256</Property>
                  <Property name="ReadGroups">true</Property>
                  <Property name="ReadOnly">false</Property>
                  <Property name="IsEmailUserName">false</Property>
                  <Property name="DomainCalculation">default</Property>
                  <Property name="StoreSaltedPassword">true</Property>
                  <Property name="WriteGroups">false</Property>
                  <Property name="UserNameUniqueAcrossTenants">false</Property>
                  <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
                  <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
                  <Property name="UsernameJavaRegEx">^[\S]{5,30}$</Property>
                  <Property name="UsernameJavaScriptRegEx">^[\S]{5,30}$</Property>
                  <Property name="RolenameJavaRegEx">^[\S]{5,30}$</Property>
                  <Property name="RolenameJavaScriptRegEx">^[\S]{5,30}$</Property>
                  <Property name="SCIMEnabled">false</Property>
                  <Property name="SelectUserSQL">SELECT * FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
                  <Property name="GetRoleListSQL">SELECT UM_ROLE_NAME, UM_TENANT_ID, UM_SHARED_ROLE FROM UM_ROLE WHERE UM_ROLE_NAME LIKE ? AND UM_TENANT_ID=? AND UM_SHARED_ROLE ='0' ORDER BY UM_ROLE_NAME</Property>
                  <Property name="GetSharedRoleListSQL">SELECT UM_ROLE_NAME, UM_TENANT_ID, UM_SHARED_ROLE FROM UM_ROLE WHERE UM_ROLE_NAME LIKE ? AND UM_SHARED_ROLE ='1' ORDER BY UM_ROLE_NAME</Property>
                  <Property name="UserFilterSQL">SELECT UM_USER_NAME FROM UM_USER WHERE UM_USER_NAME LIKE ? AND UM_TENANT_ID=? ORDER BY UM_USER_NAME</Property>
                  <Property name="UserRoleSQL">SELECT UM_ROLE_NAME FROM UM_USER_ROLE, UM_ROLE, UM_USER WHERE UM_USER.UM_USER_NAME=? AND UM_USER.UM_ID=UM_USER_ROLE.UM_USER_ID AND UM_ROLE.UM_ID=UM_USER_ROLE.UM_ROLE_ID AND UM_USER_ROLE.UM_TENANT_ID=? AND UM_ROLE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
                  <Property name="UserSharedRoleSQL">SELECT UM_ROLE_NAME, UM_ROLE.UM_TENANT_ID, UM_SHARED_ROLE FROM UM_SHARED_USER_ROLE INNER JOIN UM_USER ON UM_SHARED_USER_ROLE.UM_USER_ID = UM_USER.UM_ID INNER JOIN UM_ROLE ON UM_SHARED_USER_ROLE.UM_ROLE_ID = UM_ROLE.UM_ID WHERE UM_USER.UM_USER_NAME = ? AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = UM_USER.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_ROLE_TENANT_ID = UM_ROLE.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = ?</Property>
                  <Property name="IsRoleExistingSQL">SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?</Property>
                  <Property name="GetUserListOfRoleSQL">SELECT UM_USER_NAME FROM UM_USER_ROLE, UM_ROLE, UM_USER WHERE UM_ROLE.UM_ROLE_NAME=? AND UM_USER.UM_ID=UM_USER_ROLE.UM_USER_ID AND UM_ROLE.UM_ID=UM_USER_ROLE.UM_ROLE_ID AND UM_USER_ROLE.UM_TENANT_ID=? AND UM_ROLE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
                  <Property name="GetUserListOfSharedRoleSQL">SELECT UM_USER_NAME FROM UM_SHARED_USER_ROLE INNER JOIN UM_USER ON UM_SHARED_USER_ROLE.UM_USER_ID = UM_USER.UM_ID INNER JOIN UM_ROLE ON UM_SHARED_USER_ROLE.UM_ROLE_ID = UM_ROLE.UM_ID WHERE UM_ROLE.UM_ROLE_NAME= ? AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = UM_USER.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_ROLE_TENANT_ID = UM_ROLE.UM_TENANT_ID</Property>
                  <Property name="IsUserExistingSQL">SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
                  <Property name="GetUserPropertiesForProfileSQL">SELECT UM_ATTR_NAME, UM_ATTR_VALUE FROM UM_USER_ATTRIBUTE, UM_USER WHERE UM_USER.UM_ID = UM_USER_ATTRIBUTE.UM_USER_ID AND UM_USER.UM_USER_NAME=? AND UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
                  <Property name="GetUserPropertyForProfileSQL">SELECT UM_ATTR_VALUE FROM UM_USER_ATTRIBUTE, UM_USER WHERE UM_USER.UM_ID = UM_USER_ATTRIBUTE.UM_USER_ID AND UM_USER.UM_USER_NAME=? AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
                  <Property name="GetUserLisForPropertySQL">SELECT UM_USER_NAME FROM UM_USER, UM_USER_ATTRIBUTE WHERE UM_USER_ATTRIBUTE.UM_USER_ID = UM_USER.UM_ID AND UM_USER_ATTRIBUTE.UM_ATTR_NAME =? AND UM_USER_ATTRIBUTE.UM_ATTR_VALUE =? AND UM_USER_ATTRIBUTE.UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?SELECT UM_USER_NAME FROM UM_USER, UM_USER_ATTRIBUTE WHERE UM_USER_ATTRIBUTE.UM_USER_ID = UM_USER.UM_ID AND UM_USER_ATTRIBUTE.UM_ATTR_NAME =? AND UM_USER_ATTRIBUTE.UM_ATTR_VALUE LIKE ? AND UM_USER_ATTRIBUTE.UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
                  <Property name="GetProfileNamesSQL">SELECT DISTINCT UM_PROFILE_ID FROM UM_USER_ATTRIBUTE WHERE UM_TENANT_ID=?</Property>
                  <Property name="GetUserProfileNamesSQL">SELECT DISTINCT UM_PROFILE_ID FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
                  <Property name="GetUserIDFromUserNameSQL">SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
                  <Property name="GetUserNameFromTenantIDSQL">SELECT UM_USER_NAME FROM UM_USER WHERE UM_TENANT_ID=?</Property>
                  <Property name="GetTenantIDFromUserNameSQL">SELECT UM_TENANT_ID FROM UM_USER WHERE UM_USER_NAME=?</Property>
                  <Property name="AddUserSQL">INSERT INTO UM_USER (UM_USER_NAME, UM_USER_PASSWORD, UM_SALT_VALUE, UM_REQUIRE_CHANGE, UM_CHANGED_TIME, UM_TENANT_ID) VALUES (?, ?, ?, ?, ?, ?)</Property>
                  <Property name="AddUserToRoleSQL">INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?), ?)</Property>
                  <Property name="AddRoleSQL">INSERT INTO UM_ROLE (UM_ROLE_NAME, UM_TENANT_ID) VALUES (?, ?)</Property>
                  <Property name="AddSharedRoleSQL">UPDATE UM_ROLE SET UM_SHARED_ROLE = ? WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID = ?</Property>
                  <Property name="AddRoleToUserSQL">INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?)</Property>
                  <Property name="AddSharedRoleToUserSQL">INSERT INTO UM_SHARED_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_USER_TENANT_ID, UM_ROLE_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?, ?)</Property>
                  <Property name="RemoveUserFromSharedRoleSQL">DELETE FROM UM_SHARED_USER_ROLE WHERE   UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_USER_TENANT_ID=? AND UM_ROLE_TENANT_ID = ?</Property>
                  <Property name="RemoveUserFromRoleSQL">DELETE FROM UM_USER_ROLE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
                  <Property name="RemoveRoleFromUserSQL">DELETE FROM UM_USER_ROLE WHERE UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
                  <Property name="DeleteRoleSQL">DELETE FROM UM_ROLE WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID=?</Property>
                  <Property name="OnDeleteRoleRemoveUserRoleMappingSQL">DELETE FROM UM_USER_ROLE WHERE UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
                  <Property name="DeleteUserSQL">DELETE FROM UM_USER WHERE UM_USER_NAME = ? AND UM_TENANT_ID=?</Property>
                  <Property name="OnDeleteUserRemoveUserRoleMappingSQL">DELETE FROM UM_USER_ROLE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
                  <Property name="OnDeleteUserRemoveUserAttributeSQL">DELETE FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
                  <Property name="UpdateUserPasswordSQL">UPDATE UM_USER SET UM_USER_PASSWORD= ?, UM_SALT_VALUE=?, UM_REQUIRE_CHANGE=?, UM_CHANGED_TIME=? WHERE UM_USER_NAME= ? AND UM_TENANT_ID=?</Property>
                  <Property name="UpdateRoleNameSQL">UPDATE UM_ROLE set UM_ROLE_NAME=? WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID=?</Property>
                  <Property name="AddUserPropertySQL">INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?, ?, ?, ?)</Property>
                  <Property name="UpdateUserPropertySQL">UPDATE UM_USER_ATTRIBUTE SET UM_ATTR_VALUE=? WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_TENANT_ID=?</Property>
                  <Property name="DeleteUserPropertySQL">DELETE FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_TENANT_ID=?</Property>
                  <Property name="UserNameUniqueAcrossTenantsSQL">SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=?</Property>
                  <Property name="IsDomainExistingSQL">SELECT UM_DOMAIN_ID FROM UM_DOMAIN WHERE UM_DOMAIN_NAME=? AND UM_TENANT_ID=?</Property>
                  <Property name="AddDomainSQL">INSERT INTO UM_DOMAIN (UM_DOMAIN_NAME, UM_TENANT_ID) VALUES (?, ?)</Property>
                  <Property name="AddUserToRoleSQL-mssql">INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(?)</Property>
                  <Property name="AddRoleToUserSQL-mssql">INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), (?)</Property>
                  <Property name="AddUserPropertySQL-mssql">INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), (?), (?), (?), (?)</Property>
                  <Property name="AddUserToRoleSQL-openedge">INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) SELECT UU.UM_ID, UR.UM_ID, ? FROM UM_USER UU, UM_ROLE UR WHERE UU.UM_USER_NAME=? AND UU.UM_TENANT_ID=? AND UR.UM_ROLE_NAME=? AND UR.UM_TENANT_ID=?</Property>
                  <Property name="AddRoleToUserSQL-openedge">INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) SELECT UR.UM_ID, UU.UM_ID, ? FROM UM_ROLE UR, UM_USER UU WHERE UR.UM_ROLE_NAME=? AND UR.UM_TENANT_ID=? AND UU.UM_USER_NAME=? AND UU.UM_TENANT_ID=?</Property>
                  <Property name="AddUserPropertySQL-openedge">INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) SELECT UM_ID, ?, ?, ?, ? FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
                  <Property name="DomainName">wso2.org</Property>
                  <Property name="Description"/>
            </UserStoreManager>
    ```

        !!! info
    The sample for the external JDBC user store consists of properties pertaining to various SQL statements. This is because the schema may be different for an external user store, and these adjustments need to be made to streamline the configurations with WSO2 products.

        !!! info
    You can define a data source in `           <PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml          ` and refer to it from the `           user-mgt.xml          ` file. This takes the properties defined in the `           master-datasources.xml          ` file and reuses them in the `           user-mgt.xml          ` file. To do this, you need to define the following property: `                     `

    `           <          ` `           Property          ` `           name          ` `           =          ` `           "dataSource"          ` `           >jdbc/WSO2CarbonDB</          ` `           Property          ` `           >          `


2.  Find a valid user that resides in the RDBMS. For example, say a valid username is AdminSOA. Update the Admin user section of your configuration as follows. You do not have to update the password element; leave it as is.

    ``` html/xml
        <AdminUser>
           <UserName>AdminSOA</UserName>
           <Password>XXXXXX</Password>
        </AdminUser>
    ```

3.  Add the `           PasswordHashMethod          ` property to the UserStoreManager configuration for `           JDBCUserStoreManager          ` . For example:

    ``` html/xml
            <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
                 <Property name="PasswordHashMethod">SHA</Property>
                 ...
            </UserStoreManager>
    ```

    The `           PasswordHashMethod          ` property specifies how the password should be stored. It usually has the following values:

    -   `            SHA           ` - Uses SHA digest method.
    -   `            MD5           ` - Uses MD 5 digest method.
    -   `            PLAIN_TEXT           ` - Plain text passwords.

    In addition, it also supports all digest methods in <http://docs.oracle.com/javase/6/docs/api/java/security/MessageDigest.html> .

4.  Update the connection details found within the `          <UserStoreManager>         ` class based on your preferences. For more information on parameters need to be configured refer [Configuring a JDBC User Store](https://docs.wso2.com/display/IS540/Configuring+a+JDBC+User+Store) .
5.  In the realm configuration section, add the property `          MultiTenantRealmConfigBuilder and set the value to         ` `          org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder         ` in order to constrcut teant specific realm configurations.

    For example:

    ``` html/xml
            <Property name="MultiTenantRealmConfigBuilder">org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder</Property>
    ```

6.  Add the JDBC driver to the classpath by copying its JAR file into the `          <PRODUCT_HOME>/repository/components/lib         ` directory.
7.  Edit the SQLs in the `          user-mgt.xml         ` file according to your requirements, and then start the server.

!!! info
#### Related Links

-   For a comprehensive understanding on the configuration details, see [Working with Properties of User Stores](https://docs.wso2.com/display/ADMIN44x/Working+with+Properties+of+User+Stores) in the WSO2 Administration guide.
-   For details on writing a simple custom user store manager for WSO2 products, see [Writing a Custom User Store Manager](https://docs.wso2.com/display/ADMIN44x/Writing+a+Custom+User+Store+Manager) in the WSO2 Administration guide.



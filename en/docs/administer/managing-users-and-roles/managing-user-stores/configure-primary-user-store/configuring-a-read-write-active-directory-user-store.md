#Configuring a Read-Write Active Directory User Store

!!! info
    The default User Store

    The primary user store that is configured by default in the `user-mgt.xml` file is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2 for all WSO2 products excluding WSO2 Identity Server.
    
    Note that the RDBMS used in the default configuration can remain as the database used for storing Authorization information.

Follow the given steps to configure an external Active Directory as the primary user store:

-   [Step 1: Setting up the external AD user store manager](#step-1-setting-up-the-external-ad-user-store-manager)
-   [Step 2: Updating the system administrator](#step-2-updating-the-system-administrator)
-   [Step 3: Starting the server](#step-3-starting-the-server)

### Step 1: Setting up the external AD user store manager

!!! info

-   Navigate to `<PRODUCT_HOME>/repository/conf` directory to open `deployment.toml` file and do user_store_properties configurations. Following is the sample read-write active directory user store configurations:
 ```toml
 [user_store.properties]
 TenantManager="org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager"
 ConnectionURL="ldaps://10.100.1.102:639"
 ConnectionName="CN=admin,CN=Users,DC=WSO2,DC=Com"
 ConnectionPassword="A1b2c3d4"           
 AnonymousBind="false"
 UserSearchBase="CN=Users,DC=WSO2,DC=Com"
 UserEntryObjectClass="user"
 UserNameAttribute="cn"
 UserNameSearchFilter="(&amp;(objectClass=user)(cn=?))"
 UserNameListFilter="(&amp;(objectClass=user)(!(sn=Service)))"           
 ReadGroups="true"
 WriteGroups="true"
 GroupSearchBase="CN=Users,DC=WSO2,DC=Com"
 GroupEntryObjectClass="group"
 GroupNameAttribute="cn"
 GroupNameSearchFilter="(&amp;(objectClass=group)(cn=?))"
 GroupNameListFilter="(objectcategory=group)"
 MembershipAttribute="member"
 MemberOfAttribute="memberOf"
 BackLinksEnabled="true"
 Referral="follow"
 UsernameJavaRegEx="[a-zA-Z0-9._\\-|//]{3,30}$"
 UsernameJavaScriptRegEx="^[\\S]{3,30}$"
 UsernameJavaRegExViolationErrorMsg="Username pattern policy violated"
 PasswordJavaRegEx="^[\\S]{5,30}$"
 PasswordJavaScriptRegEx="^[\\S]{5,30}$"
 PasswordJavaRegExViolationErrorMsg="Password length should be within 5 to 30 characters"
 RolenameJavaRegEx="[a-zA-Z0-9._\\-|//]{3,30}$"
 RolenameJavaScriptRegEx="^[\\S]{3,30}$"
 SCIMEnabled="false"
 IsBulkImportSupported="false"
 EmptyRolesAllowed="true"
 PasswordHashMethod="PLAIN_TEXT"
 MultiAttributeSeparator=","
 isADLDSRole="false"
 userAccountControl="512"
 MaxUserNameListLength="100"    
 MaxRoleNameListLength="100"                    
 MembershipAttributeRange="1500"
 kdcEnabled="false"
 defaultRealmName="WSO2.ORG"
 UserRolesCacheEnabled="true"
 ConnectionPoolingEnabled="false"
 LDAPConnectionTimeout="5000"
 StartTLSEnabled="false"
 ConnectionRetryDelay="120000"
 ```
 
-   The `class` attribute for an external AD is `org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager`.
```toml
[user_store]
class="org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager"
type = "active_directory"
base_dn = "cn=Users,dc=wso2,dc=org"
```

!!! note
    Note that these configurations will automatically applied to the `user-mgt.xml` file so you do not need to edit it.

Given below is a sample configuration for the external read/write user store in the `user-mgt.xml`. You can change the values to match your requirement in `deployment.toml` file. For descriptions on each of the properties used in the `<PRODUCT_HOME>/repository/conf/deployment.toml` file which are used for configuring the primary user store , see [Configuring Read-Write Active Directory User Store](#configuring-read-write-active-directory-user-store) and [Properties of User Stores](#properties-used-in-read-write-active-directory-user-store).
    ```
    <UserStoreManager class="org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager">
        <Property name="IsBulkImportSupported">true</Property>
        <Property name="MaxUserNameListLength">100</Property>
        <Property name="defaultRealmName">WSO2.ORG</Property>
        <Property name="isADLDSRole">false</Property>
        <Property name="userAccountControl">512</Property>
        <Property name="EmptyRolesAllowed">true</Property>
        <Property name="MultiAttributeSeparator">,</Property>
        <Property name="MembershipAttributeRange">1500</Property>
        <Property name="DisplayNameAttribute"></Property>
        <Property name="TenantManager">org.wso2.carbon.user.core.tenant.CommonHybridLDAPTenantManager</Property>
        <Property name="UserSearchBase">ou=Users,cn=Users,dc=wso2,dc=org</Property>
        <Property name="GroupNameSearchFilter">(&amp;(objectClass=groupOfNames)(cn=?))</Property>
        <Property name="ConnectionPoolingEnabled">false</Property>
        <Property name="StartTLSEnabled">false</Property>
        <Property name="UserNameSearchFilter">(&amp;(objectClass=person)(uid=?))</Property>
        <Property name="LDAPConnectionTimeout">5000</Property>
        <Property name="UserNameAttribute">uid</Property>
        <Property name="GroupNameAttribute">cn</Property>
        <Property name="UsernameJavaRegEx">[a-zA-Z0-9._\-|//]{3,30}$</Property>
        <Property name="WriteGroups">true</Property>
        <Property name="AnonymousBind">false</Property>
        <Property name="RolenameJavaScriptRegEx">^[\S]{3,30}$</Property>
        <Property name="RolenameJavaRegEx">[a-zA-Z0-9._\-|//]{3,30}$</Property>
        <Property name="GroupEntryObjectClass">groupOfNames</Property>
        <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
        <Property name="PasswordHashMethod">PLAIN_TEXT</Property>
        <Property name="GroupSearchBase">ou=Groups,cn=Users,dc=wso2,dc=org</Property>
        <Property name="ReadGroups">true</Property>
        <Property name="ReplaceEscapeCharactersAtUserLogin">true</Property>
        <Property name="ConnectionRetryDelay">120000</Property>
        <Property name="MembershipAttribute">member</Property>
        <Property name="Referral">follow</Property>
        <Property name="UserEntryObjectClass">identityPerson</Property>
        <Property name="PasswordJavaRegExViolationErrorMsg">Password length should be within 5 to 30 characters</Property>
        <Property name="MaxRoleNameListLength">100</Property>
        <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
        <Property name="BackLinksEnabled">false</Property>
        <Property name="UsernameJavaRegExViolationErrorMsg">Username pattern policy violated</Property>
        <Property name="UserRolesCacheEnabled">true</Property>
        <Property name="GroupNameListFilter">(objectClass=groupOfNames)</Property>
        <Property name="SCIMEnabled">false</Property>
        <Property name="UserNameListFilter">(objectClass=person)</Property>
        <Property name="MemberOfAttribute">memberOf</Property>
        <Property name="UsernameJavaScriptRegEx">^[\S]{3,30}$</Property>
        <Property name="kdcEnabled">false</Property>
     </UserStoreManager>
    ```

!!! note
    When working with Active Directory;

    -   It is best to enable the `GetAllRolesOfUserEnabled` property in the `AuthorizationManager` as follows. See the documentation on [configuring the Authorization Manager]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/configuring-the-authorization-manager) for more information.

        ``` xml
        <AuthorizationManager class="org.wso2.carbon.user.core.authorization.JDBCAuthorizationManager">
            <Property name="AdminRoleManagementPermissions">/permission</Property>
            <Property name="AuthorizationCacheEnabled">true</Property>
            <Property name="GetAllRolesOfUserEnabled">true</Property>
        </AuthorizationManager>
        ```

        Although using the user store manager does not depend on this property, you must consider enabling this if there are any performance issues in your production environment. Enabling this property affects the performance when the user logs in. This depends on the users, roles and permission stats.

    -   If you are using `ldaps` (secured LDAP) to connect to the Active Directory as shown in the example below, you need to import the certificate of Active Directory to the `client-truststore.jks` of the WSO2 product. For information on how to add certificates to the truststore and how keystores are configured and used in a system, see [Using Asymmetric Encryption](./../../../../../product-security/UsingAsymmetricEncryption/creating-new-keystores/) .

        ``` toml
        ConnectionURL="ldaps://10.100.1.100:636"
        ```

    -   You also need to [enable connection pooling](https://docs.wso2.com/display/ADMIN44x/Performance+Tuning#PerformanceTuning-ldaps_pooling) for LDAPS connections at the time of starting your server, which will enhance server performance.


1.  For Active Directory, you can use `Referral="follow"` to enable referrals within the user store. The AD user store may be partitioned into multiple domains. However, according to the use store configurations in the `deployment.toml` file, we are only connecting to one of the domains. Therefore, when a request for an object is received to the user store, the `Referral="follow"` property ensures that all the domains in the directory will be searched to locate the requested object.

2.  Set the attribute to use as the username, typically either `cn` or `uid` for LDAP. Ideally, `UserNameAttribute` and `UserNameSearchFilter` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP/Active Directory administrator.
        ```toml   
        UserNameAttribute="cn"
        UserNameSearchFilter="(&amp;(objectClass=user)(cn=?))"
        ```
        
3.  In WSO2 products based on Carbon 4.5.x, you can set the `LDAPConnectionTimeout` property: If the connection to the LDAP is inactive for the length of time (in milliseconds) specified by this property, the connection will be terminated.

4.  Set the `ReadGroups` property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `GroupSearchBase` , `GroupNameSearchFilter` and `GroupNameAttribute` properties. If the `ReadGroups` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a membership (user list) or backlink attribute as shown below.
    To read the user/role mapping based on a membership (This is used by the `ApacheDirectory` server and `OpenLDAP)` :

    -   Enable the `ReadGroups` property.
            ```toml
            ReadGroups="true"
            ```

    -   Set the `GroupSearchBase` property to the directory name where the Roles are stored. That is, the roles you create using the management console of your product will be stored in this directory location. Also, when LDAP searches for users, it will start from this location of the directory. For example:
            ``` 
            GroupSearchBase="ou=Groups,cn=Users,dc=wso2,dc=org"
            ```

    -   Set the GroupNameSearchFilter and GroupNameAttributes. For example:
            ```toml
            GroupNameSearchFilter="(&amp;(objectClass=groupOfNames)(cn=?))"
            GroupNameAttribute="cn"
            ```

    -   Set the `MembershipAttribute` property as shown below:
            ``` 
            MembershipAttribute="member"
            ```

    To read roles based on a backlink attribute, use the following code snipet instead of the above:
        ```
        ReadGroups="false"
        GroupSearchBase="ou=system"
        GroupNameSearchFilter="(objectClass=groupOfNames)"
        GroupNameAttribute="cn"
        MembershipAttribute="member"
        BackLinksEnabled="true"
        MembershipOfAttribute="memberOf"
        ```
        
### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. Since the Active Directory user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. Alternatively, you can also use a user ID that already exists in the user store. For more information on setting up the [system administrator](./../../configuring-the-system-administrator/) and the [authorization manager](./../../configuring-the-authorization-manager/) .

-   These two alternative configurations can be done as explained below.

<!-- -->

-   Find a valid user that already resides in the user store. For example, say a valid username is AdminSOA. Update the `[super_admin]` section of your configuration as shown below. You do not have to update the password element as it is already set in the user store.
        ``` 
        [super_admin]
        username = "AdminSOA"
        admin_role = "admin"
        create_admin_account = false
        ```

-   If the user store can be written to, you can add the super tenant user to the user store. Therefore, create_admin_account should be set to true as shown below.
        ``` 
        [super_admin]
        username = "admin"
        admin_role = "admin"
        create_admin_account = true
        ```

### Step 3: Starting the server

Start your server and try to log in as the admin user you specified.

## Configuring Read-Write Active Directory User Store

Following are the minimum configurations that are needed to be provided to configure Read-write Active Directory user store manager.

<table>
<thead>
<tr class="header">
<th>Configuration Name</th>
<th>Display Name</th>
<th>Description</th>
</tr>
<tr class="even">
<td>type</td>
<td>User Store Type</td>
<td>Type of the user store manager that we are using.For Read-only LDAP user store manager this value
should be active_directory.
</td>
</tr>
<tr class="odd">
<td>base_dn</td>
<td>User Search Base</td>
<td>DN of the context or object under which the user entries are stored in the user store. When the user store searches for users, it will start from this location of the directory<br />
Sample values: ou=Users,dc=wso2,dc=org</td>
</tr>
</table>
</thead>


## Properties used in Read-Write Active Directory User Store

The following table lists the properties used in Read-write Active Directory and their descriptions:
Any of  the following properties can be configured for the `PRIMARY` user store by adding them as follows to `<API-M_HOME>/repository/conf/deployment.toml`.

<table> 
<col width="50">
<col width="50">
<col width="50">
<col width="100">
<thead>
<tr class="header">
<th>Property Id</th>
<th>Primary User Store Property </th>
<th>Secondary User Store Property </th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>UserEntryObjectClass</td>
<td>user_entry_object_class</td>
<td>User Entry Object Class</td>
<td>Object class used to construct user entries.<br />
Default: user</td>
</tr>
<tr class="odd">
<td>UserNameAttribute</td>
<td>user_name_attribute</td>
<td>Username Attribute</td>
<td>The attribute used for uniquely identifying a user entry. Users can be authenticated using their email address, UID, etc. The name of the attribute is considered as the username.
<p>Default: cn<br />
<br />
Note: email address is considered as a special case in WSO2 products, if you want to set the email address as username, see <a href="https://is.docs.wso2.com/en/5.10.0/learn/using-email-address-as-the-username/">Using email address as the username</a></p>
sample values: sAMAccountName</td>
</tr>
<tr class="even">
<td>UserNameSearchFilter</td>
<td>user_name_search_filter</td>
<td>User Search Filter</td>
<td>Filtering criteria used to search for a particular user entry.<br />
Default : (&amp;(objectClass=user)(cn=?))</td>
</tr>
<tr class="odd">
<td>UserNameListFilter</td>
<td>user_name_list_filter</td>
<td>User List Filter</td>
<td>Filtering criteria for searching user entries in the user store. This query or filter is used when doing search operations on users with different search attributes.<br />
<br />
Default: (&amp;(objectClass=user)(!(sn=Service)))<br />
In this case, the search operation only provides the objects created from the person object class.</td>
</tr>
<tr class="even">
<td>UserDNPattern</td>
<td>user_dn_pattern</td>
<td>User DN Pattern</td>
<td>The pattern for the user's DN, which can be defined to improve the search. When there are many user entries in the LDAP user store, defining a UserDNPattern provides more impact on performances as the LDAP does not have to travel through the entire tree to find users.
<p>Sample values: uid={0},ou=Users,dc=wso2,dc=org</p></td>
</tr>
<tr class="odd">
<td>DisplayNameAttribute</td>
<td>display_name_attribute</td>
<td>Display name attribute</td>
<td>This is an optional property. The Display Name Attribute is the name by which users will be listed when you list users in the management console.
<p>Default: blank</td>
</tr>
<tr class="even">
<td>ReadGroups</td>
<td>read_groups</td>
<td>Read Groups</td>
<td>When WriteGroups is set to falses, this Indicates whether groups should be read from the user store. If this is disabled by setting it to false, none of the groups in the user store can be read, and the following group configurations are NOT mandatory: GroupSearchBase, GroupNameListFilter, or GroupNameAttribute.<br />
<p>Default: true
<br />
Possible values:<br />
true: Read groups from user store<br />
false: Don’t read groups from user store</td>
</td>
</tr>
<tr class="odd">
<td>WriteGroups</td>
<td>write_groups</td>
<td>Write Groups</td>
<td>Indicates whether groups should be write to the user store.<br />
<p>Default: true
<br />
Possible values:<br />
true: Write groups to user store<br />
false: Do not write groups to user store, so only internal roles can be created. Depend on the value of ReadGroups property, it will read existing groups from user store or not<br />
</td>
</tr>
<tr class="even">
<td>GroupSearchBase</td>
<td>group_search_base</td>
<td>Group Search Base</td>
<td>DN of the context or object under which the group entries are stored in the user store. When the user store searches for groups, it will start from this location of the directory.
<p>Default: ou=Groups,cn=Users,dc=wso2,dc=org</p></td>
</tr>
<tr class="odd">
<td>GroupEntryObjectClass</td>
<td>group_entry_object_class</td>
<td>Group Entry Object Class</td>
<td>Object class used to construct group entries.<br/>
Default: groupOfNames</td>
</tr>
<tr class="even">
<td>GroupNameAttribute</td>
<td>group_name_attribute</td>
<td>Group Name Attribute</td>
<td>Attribute used for uniquely identifying a group entry. This attribute is to be treated as the group name.
<br/>Default: cn</td>
</tr>
<tr class="odd">
<td>GroupNameSearchFilter</td>
<td>group_name_search_filter</td>
<td>Group Search Filter</td>
<td>Filtering criteria used to search for a particular group entry.
<p>Default: (&amp;(objectClass=groupOfNames)(cn=?))</p></td>
</tr>
<tr class="even">
<td>GroupNameListFilter</td>
<td>group_name_list_filter</td>
<td>Group List Filter</td>
<td>Filtering criteria for searching group entries in the user store. This query or filter is used when doing search operations on groups with different search attributes.
<p>Default: (objectClass=groupOfNames) In this case, the search operation only provides the objects created from the groupOfName object class.</p></td>
</tr>
<tr class="odd">
<td>RoleDNPattern</td>
<td>role_dn_pattern</td>
<td>Role DN Pattern</td>
<td>The pattern for the group's DN, which can be defined to improve the search. When there are many group entries in the LDAP user store, defining a RoleDNPattern provides more impact on performances as the LDAP does not have to traverse through the entire tree to find group.
<p>Sample values: cn={0},ou=Groups,dc=wso2,dc=org</p></td>
</tr>
<tr class="even">
<td>MembershipAttribute</td>
<td>membership_attribute</td>
<td>Membership Attribute</td>
<td>Defines the attribute that contains the distinguished names (DN) of user objects that are in a group.
<p>Default: member</p></td>
</tr>
<tr class="odd">
<td>MemberOfAttribute</td>
<td>member_of_attribute</td>
<td>Member Of Attribute</td>
<td>Define the attribute that contains the distinguished names (DN ) of group objects that user is assigned to.<br />
Default: memberOf</td>
</tr>
<tr class="even">
<td>BackLinksEnabled</td>
<td>back_links_enabled</td>
<td>Enable Back Links</td>
<td>Defines whether the backlink support is enabled. If you are using MemberOfAttribute attributes this should be set to 'true'.
<br/>Default : false</td>
</tr>
<tr class="odd">
<td>UsernameJavaRegEx</td>
<td>username_java_regex</td>
<td>Username RegEx (Java)</td>
<td>The regular expression used by the back-end components for username validation. By default, strings with non-empty characters have a length of 3 to 30 allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.<br />
Default: [a-zA-Z0-9._\-|//]{3,30}$</td>
</tr>
<tr class="even">
<td>UsernameJava<br />ScriptRegEx</td>
<td>username_java_<br />script_regex</td>
<td>Username RegEx (Javascript)</td>
<td>The regular expression used by the front-end components for username validation.<br />
Default: ^[\S]{3,30}$</td>
</tr>
<tr class="odd">
<td>UsernameJavaReg<br />ExViolationErrorMsg</td>
<td>username_java_reg_<br />ex_violation_error_msg</td>
<td>Username RegEx Violation Error Message</td>
<td>Error message when the Username is not matched with UsernameJavaRegEx<br />
Default: Username pattern policy violated</td>
</tr>
<tr class="even">
<td>PasswordJavaRegEx</td>
<td>password_java_regex</td>
<td>Password RegEx (Java)</td>
<td>The regular expression used by the back-end components for password validation. By default, strings with non-empty characters have a length of 5 to 30 allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.<br />
Default: ^[\S]{5,30}$</td>
</tr>
<tr class="odd">
<td>PasswordJava<br />ScriptRegEx</td>
<td>password_java_<br />script_regex</td>
<td>Password RegEx (Javascript)</td>
<td>The regular expression used by the front-end components for password validation.<br />
Default: ^[\S]{5,30}$</td>
</tr>
<tr class="even">
<td>PasswordJavaReg<br />ExViolationErrorMsg</td>
<td>password_java_reg<br />ex_violation_error_msg</td>
<td>Password RegEx Violation Error Message</td>
<td>Error message when the Password is not matched with passwordJavaRegEx<br />
Default: Password length should be within 5 to 30 characters</td></tr>
<tr class="odd">
<td>RolenameJavaRegEx</td>
<td>rolename_java_regex</td>
<td>Role Name RegEx (Java)</td>
<td>The regular expression used by the back-end components for role name validation. By default, strings with non-empty characters have a length of 3 to 30 allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.<br />
Default: [a-zA-Z0-9._\-|//]{3,30}$</td>
</tr>
<tr class="even">
<td>SCIMEnabled</td>
<td>scim_enabled</td>
<td>Enable SCIM</td>
<td>This is to configure whether user store is supported for SCIM provisioning.<br />
<br />
Possible values:<br />
True : User store support for SCIM provisioning.<br />
False: User does not store support for SCIM provisioning.
<br />
Default: false</td>
</tr>
<tr class="odd">
<td>PasswordHashMethod</td>
<td>password_hash_method</td>
<td>Password Hashing Algorithm</td>
<td>Specifies the Password Hashing Algorithm used the hash the password before storing in the user store.<br />
Possible values:<br />
SHA - Uses SHA digest method. SHA-1, SHA-256<br />
MD5 - Uses MD 5 digest method.<br />
PLAIN_TEXT - Plain text passwords.(Default)</p>
<p>If you just configure as SHA, It is considered as SHA-1, It is always better to configure algorithm with higher bit value as digest bit size would be increased.<br />
<br />
Most of the LDAP servers (such as OpenLdap, OpenDJ, AD, ApacheDS and etc..) are supported to store password as salted hashed values (SSHA).
If your LDAP does not support to store user password as hashed values. You can configure WSO2 server to hash the password and feeds the hashed password into the LDAP server. Then you need to configure PasswordHashMethod property with SHA (SHA-1), SHA-256, SHA-512. Please note WSO2 server cannot create a salted hashed password (SSHA) to feed into the LDAP.</p></td>
</tr>
<tr class="even">
<td>MultiAttributeSeparator</td>
<td>multi_attribute_separator</td>
<td>Multiple Attribute Separator</td>
<td>This property is used to define a character to separate multiple attributes. This ensures that it will not appear as part of a claim value. Normally “,” is used to separate multiple attributes, but you can define ",,," or "..." or a similar character sequence<br />
Default: “,”</td>
</tr>
<tr class="odd">
<td>MaxUserName<br>ListLength </td>
<td>max_user_name_<br />list_length</td>
<td>Maximum User List Length</td>
<td>Controls the number of users listed in the user store of a WSO2 product. This is useful when you have a large number of users and don't want to list them all. Setting this property to 0 displays all users.<br />
Default: 100<br />
<br />
In some user stores, there are policies to limit the number of records that can be returned from the query. Setting the value 0 it will list the maximum results returned by the user store. If you need to increase that you need to set it in the user store level.<br />
Eg : Active directory has the MaxPageSize property with the default value 1000.</td>
</tr>
<tr class="even">
<td>MaxRoleName<br>ListLength</td>
<td>max_role_name_<br />list_length</td>
<td>Maximum Role List Length</td>
<td>Controls the number of roles listed in the user store of a WSO2 product. This is useful when you have a large number of roles and don't want to list them all. Setting this property to 0 displays all roles.<br />
Default: 100<br />
<br />
In some user stores, there are policies to limit the number of records that can be returned from the query, Setting the value 0 it will list the maximum results returned by the user store. If you need to increase that you need to set it n the user store level.</p>
<p>Eg: Active directory has the MaxPageSize property with the default value 1000.</p></td>
</tr>
<tr class="odd">
<td>kdcEnabled</td>
<td>kdc_enabled</td>
<td>Enable KDC</td>
<td>If your user store is capable of acting as a Kerberos, Key Distribution Center (KDC) and if you like to enable it, set this property to true.<br />
Default: false</td>
</tr>
<tr class="even">
<td>UserRoles<br />CacheEnabled</td>
<td>user_roles_<br />cache_enabled</td>
<td>Enable User Role Cache</td>
<td>This is to indicate whether to cache the role list of a user.<br />
Default: true<br />
<br />
Possible values:<br />
false: Set it to false if the user roles are changed by external means and those changes should be instantly reflected in the Carbon instance.
<br />
Default: true<br /></td>
</tr>
<tr class="odd">
<td>Connection<br />PoolingEnabled</td>
<td>connection_<br />pooling_enabled</td>
<td>Enable LDAP Connection Pooling</td>
<td>Define whether LDAP connection pooling is enabled<br />
Possible values:<br />
True: Enable connection pooling. Enabling it will improve the performance<br />
False: Disable connection pooling
<br />
Default: false<br /></td>
</tr>
<tr class="even">
<td>LDAPConnectionT<br>imeout</td>
<td>ldap_connection<br>_timeout</td>
<td>LDAP Connection Timeout</td>
<td>Timeout in making the initial LDAP connection. This is configured in milliseconds.<br />
Default: 5000</td>
</tr>
<tr class="odd">
<td>ReadTimeout</td>
<td>read_timeout</td>
<td>LDAP Read Timeout</td>
<td>The value of this property is the read timeout in milliseconds for LDAP operations. If the LDAP provider cannot get a LDAP response within that period, it aborts the read attempt. The integer should be greater than zero. An integer less than or equal to zero means no read timeout is specified which is equivalent to waiting for the response infinitely until it is received.
<br />
Default: not configured</td>
</tr>
<tr class="even">
<td>Membership<br />AttributeRange</td>
<td>membership_<br />attribute_range</td>
<td>Membership Attribute Range</td>
<td>This is to define the maximum users of role returned by the LDAP/AD user store. This does not depend on the max page size of the user store.
<p>Default: 1500</p></td>
</tr>
<tr class="odd">
<td>RetryAttempts</td>
<td>retry_attempts</td>
<td>Retry Attempts</td>
<td>Retry the authentication request if a timeout happened
<p>Default: not configured</p></td>
</tr>
</tbody>
</table>

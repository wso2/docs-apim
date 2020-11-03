# Configuring a Read-Write LDAP User Store

User management functionality is provided by default in WSO2 API Manager and it can be configured in the 
`<API-M_HOME>/repository/conf/deployment.toml` file. The changes done in the `deployment.toml` file will be automatically populated to the `<API-M_HOME>/repository/conf/user-mgt.xml` file as well. 
This file is shipped with user store manager configurations for all possible user store types ([JDBC](../configuring-a-jdbc-user-store), [read-only LDAP/Active Directory](../configuring-a-read-only-ldap-user-store), 
[read-write Active directory](../configuring-a-read-write-active-directory-user-store), and [read-write LDAP](../configuring-a-read-write-ldap-user-store)). The instructions given below explains how to configure a read-write LDAP 
as the primary user store for WSO2 API Manager.

!!! tip
       Refer [Configuring primary User Stores](../configuring-the-primary-user-store) to get a high-level understanding of the primary user stores available in WSO2 API Manager.

!!! info
       **Default User Store**: The primary user store that is configured by default in the `deployment.toml` file of API Manager is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2. This database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles).
       
       Note that the RDBMS used in the default configuration can remain as the database used for storing Authorization information.
       
Follow the given steps to configure a read-write LDAP as the primary user store:

-   [Step 1: Setting up the read-write LDAP user store manager](#step-1-setting-up-the-read-write-ldap-user-store-manager)
-   [Step 2: Updating the system administrator](#step-2-updating-the-system-administrator)
-   [Step 3: Starting the IS server](#step-3-starting-the-is-server)
-   [Step 4: Starting the APIM server](#step-3-starting-the-apim-server)

### Step 1: Setting up the read-write LDAP user store manager

-   Add these configurations below in `<API-M_HOME>/repository/conf/deployment.toml` file.

    ```
    [user_store]
    class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager"
    type = "read_write_ldap"
    connection_url = "ldap://localhost:10389"
    connection_name = "uid=admin,ou=system"
    connection_password = "admin"
    ```

    Descriptions on connection properties of `[user_store]` is given below: 
  
<table>
<thead>
<tr class="header">
<th>Property Id</th>
<th>Primary User Store Property</th>
<th>Secondary User Store Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>ConnectionURL</td>
<td>connection_url</td>
<td>Connection URL</td>
<td><p>Connection URL to the user store server. In the case of default LDAP in Carbon, the port is specified in the carbon.xml file, and a reference to that port is included in this configuration.</p>
<p>Sample values:<br />
<a href="ldap://10.100.1.100:389">ldap://10.100.1.100:389</a><br />
<a href="ldaps://10.100.1.102:639">ldaps://10.100.1.102:639</a><br />
<br />
If you are connecting over ldaps (secured LDAP)<br />
Need to import the certificate of user store to the client-truststore.jks of the WSO2 product. For information on how to add certificates to the truststore and how keystores are configured and used in a system, see Using Asymmetric Encryption.<br />
<a href="https://is.docs.wso2.com/en/5.9.0/administer/using-asymmetric-encryption">Using asymmetric encryption</a><br />
<br />
If LDAP connection pooling is used, see enable connection pooling for LDAPS connections.<br />
<a href="https://is.docs.wso2.com/en/5.10.0/setup/performance-tuning-recommendations/#pooling-ldaps-connections">performance tuning ldaps pooling</a>.</p></td>
</tr>
<tr class="odd">
<td>ConnectionName</td>
<td>connection_name</td>
<td>Connection Name</td>
<td><p>The username used to connect to the user store and perform various operations. This user does not need to be an administrator in the user store or have an administrator role in the WSO2 product that you are using, but this user MUST have permissions to read the user list and users' attributes and to perform search operations on the user store. The value you specify is used as the DN (Distinguish Name) attribute of the user who has sufficient permissions to perform operations on users and roles in LDAP</p>
<p>This property is mandatory.<br />
Sample values: uid=admin,ou=system</p></td>
</tr>
<tr class="even">
<td>ConnectionPassword</td>
<td>connection_password</td>
<td>Connection Password</td>
<td>Password for the ConnectionName user.</td>
</tr>
</table>

-   Add  `[user_store.properties]` configuration element in `deployment.toml` file as follows:
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
    ReadGroups = "true"
    UserEntryObjectClass= "identityPerson"
    UserNameAttribute= "uid"
    UserNameSearchFilter= "(\u0026amp;(objectClass\u003dperson)(uid\u003d?))"
    UserNameListFilter= "(objectClass\u003dperson)"
    DisplayNameAttribute= ""
    GroupEntryObjectClass= "groupOfNames"
    GroupNameAttribute= "cn"
    GroupNameSearchFilter= "(\u0026amp;(objectClass\u003dgroupOfNames)(cn\u003d?))"
    GroupNameListFilter= "(objectClass\u003dgroupOfNames)"
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
    MembershipAttribute = "member"
    GroupSearchFilter = "(objectClass=groupOfNames)"
    ```
   
-  Set the `ReadGroups` property to `true`, if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `GroupSearchBase` , `GroupSearchFilter` and `GroupNameAttribute` properties. If the `ReadGroups` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a **membership (user list)** or **backlink attribute** as shown below.

       a.  To read the user/role mapping based on a **membership** (This is used by the `ApacheDirectory` server and `OpenLDAP)` :

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

      b.   To read roles based on a **backlink attribute**, use the configuration given below:

      ```
        ReadGroups = "false"
        GroupSearchBase = "ou=system"
        GroupSearchFilter = "(objectClass=groupOfNames)"
        GroupNameAttribute = "cn"
        MembershipAttribute = "member"
        BackLinksEnabled = "true"
        MembershipOfAttribute = "memberOf" 
      ```

!!! note
    Note that these configurations will automatically applied to the `user-mgt.xml` file so you do not need to edit it.
    The configuration for the external read-write user store in the `user-mgt.xml` file looks as follows for the above configurations:

    ``` xml
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
       <Property name="UsernameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
       <Property name="RolenameJavaScriptRegEx">[\\S]{3,30}</Property>
       <Property name="RolenameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
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
       <Property name="LDAPConnectionTimeout">5000</Property>
       <Property name="UserRolesCacheEnabled">true</Property>
       <Property name="UserDNPattern">uid={0},ou=Users,dc=wso2,dc=org</Property>
    </UserStoreManager>
    ```
            
Apart from above properties WSO2 API Manager also supports advanced LDAP configurations. For descriptions on each of the advanced properties used in the `<API-M_HOME>/repository/conf/deployment.toml` file , see [Properties of User Stores](properties-used-in-read-write-ldap-user-store). 

### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles, and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. Since the LDAP user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. Alternatively, you can also use a user ID that already exists in the LDAP. For information about the system administrator user, see [Configuring the System Administrator]({{base_path}}/reference/config-catalog/#super-admin-configurations).

These two alternative configurations can be done as explained below.

-   If the user store is read-only, find a valid user that already resides in the user store. For example, if the username of `admin` is in the user store with admin permissions, update the `[super_admin]` section of your configuration as shown below. You do not need to update the password element as it is already set in the user store.
    ```
    [super_admin]
    username = "admin"
    password = "admin"
    create_admin_account = false
    ```

-   If you are creating a new admin user in the user store when you start the system, you can add the super tenant user to the user store. Add the following configuration to the `deployment.toml` as shown below.
    ```
    [super_admin]
    username = "admin"
    password = "admin"
    create_admin_account = true
    ```
### Step 3: Starting the IS server

- Navigate to  `<IS_HOME>/repository/conf/deployment.toml` and change the port offset to 1. This is to prevent any port conflicts with API Manager because the default port of the product is 0.

    ```
    offset=1
    ```

- Start your IS server.

    ```
    sh wso2server.sh
    ```

!!! note 
        Default LDAP server port of WSO2 IS is 10389. Based on your offset number provide the correct connection URL in `<API-M_HOME>/repository/conf/deployment.toml`.
        For example of you specify the offset of 1 in WSO2 IS your connection URL should be `ldap://{connection_ip}:10390`.     

### Step 3: Starting the APIM server

Start your APIM server and try to log in as the admin user you specified in **Step 2** .

```
sh wso2server.sh
```

### Properties used in Read-Write LDAP User Store

Any of  the following properties can be configured for the `PRIMARY` user store by adding them as follows to 
`<API-M_HOME>/repository/conf/deployment.toml`.

``` toml
[user_store]
<Property-Name> = <Property-Value>
```
For example :

``` toml
[user_store]
read_groups = true
```

!!! note 
    In the table given below, the `Primary User Store Property` column has the `PRIMARY` userstore properties that can be configured in the `deployment.toml` file. The `Secondary User Store Property` column has the properties that can be configured for a secondary user store through the Management Console.


<table>
<thead>
<tr class="header">
<th>Property Id</th>
<th>Primary User Store Property</th>
<th>Secondary User Store Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>UserEntryObjectClass</td>
<td>user_entry_object_class</td>
<td>User Entry Object Class</td>
<td>Object class used to construct user entries.<br />
Default: identityPerson( Is a custom object class defined in WSO2 Identity Server)</td>
</tr>
<tr class="odd">
<td>UserNameAttribute</td>
<td>user_name_attribute</td>
<td>Username Attribute</td>
<td><p>A uniquely identifying attribute that represents the username of the user. Users can be authenticated using their email address, UID, etc. The value of the attribute is considered as the username.</p>
<p>Default: uid<br />
<br />
Ideally, `UserNameAttribute` and `UserNameSearchFilter` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP administrator.
<br />
Note: email address is considered as a special case in WSO2 products, if you want to set the email address as username, see <a href="{{base_path}}/administer/product-security/logins-and-passwords/maintaining-logins-and-passwords/#setting-up-an-e-mail-login">Using email address as the username</a></p></td>
</tr>
<tr class="odd">
<td>UserIDAttribute</td>
<td>user_id_attribute</td>
<td>User ID Attribute</td>
<td><p>The attribute used for uniquely identifying a user entry. The value of the attribute is considered as the unique user ID. </p>
<p>Default: scimId <br /></p></td>
</tr>
<tr class="even">
<td>UserNameSearchFilter</td>
<td>user_name_search_filter</td>
<td>User Search Filter</td>
<td>Filtering criteria used to search for a particular user entry.<br />
Default : (&amp;amp;(objectClass=person)(uid=?))</td>
</tr>
<tr class="odd">
<td>UserNameListFilter</td>
<td>user_name_list_filter</td>
<td>User List Filter</td>
<td>Filtering criteria for searching user entries in the user store. This query or filter is used when doing search operations on users with different search attributes.<br />
<br />
Default: (objectClass=person)<br />
In this case, the search operation only provides the objects created from the person object class.</td>
</tr>
<tr class="even">
<td>UserDNPattern</td>
<td>user_dn_pattern</td>
<td>User DN Pattern</td>
<td><p>The pattern for the user's DN, which can be defined to improve the search. When there are many user entries in the LDAP user store, defining a UserDNPattern provides more impact on performances as the LDAP does not have to travel through the entire tree to find users.</p>
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
<td>read_groups
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
<td><p>DN of the context or object under which the group entries are stored in the user store. When the user store searches for groups, it will start from this location of the directory</p>
<p>Default: ou=Groups,dc=wso2,dc=org</p></td>
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
<td><p>Filtering criteria used to search for a particular group entry.</p>
<p>Default: (&amp;amp;(objectClass=groupOfNames)(cn=?))</p></td>
</tr>
<tr class="even">
<td>GroupNameListFilter</td>
<td>group_name_list_filter</td>
<td>Group List Filter</td>
<td><p>Filtering criteria for searching group entries in the user store. This query or filter is used when doing search operations on groups with different search attributes.</p>
<p>Default: ((objectClass=groupOfNames)) In this case, the search operation only provides the objects created from the 
groupOfName object class.</p></td>
</tr>
<tr class="odd">
<td>RoleDNPattern</td>
<td>role_dn_pattern</td>
<td>Role DN Pattern</td>
<td><p>The pattern for the group's DN, which can be defined to improve the search. When there are many group entries in the LDAP user store, defining a RoleDNPattern provides more impact on performances as the LDAP does not have to traverse through the entire tree to findgroup.</p>
<p>Sample values: cn={0},ou=Groups,dc=wso2,dc=org</p></td>
</tr>
<tr class="even">
<td>MembershipAttribute</td>
<td>membership_attribute</td>
<td>Membership Attribute</td>
<td><p>Defines the attribute that contains the distinguished names (DN) of user objects that are in a group.</p>
<p>Default: member</p></td>
</tr>
<tr class="odd">
<td>MemberOfAttribute</td>
<td>member_of_attribute</td>
<td>Member Of Attribute</td>
<td>Define the attribute that contains the distinguished names (DN ) of group objects that user is assigned to.<br />
Possible values: memberOf</td>
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
<td>UsernameJava<br>ScriptRegEx</td>
<td>username_java_<br>script_regex</td>
<td>Username RegEx (Javascript)</td>
<td>The regular expression used by the front-end components for username validation.<br />
Default: ^[\S]{3,30}$</td>
</tr>
<tr class="odd">
<td>UsernameJavaReg<br>ExViolationErrorMsg</td>
<td>username_java_reg_<br>ex_violation_error_msg</td>
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
<td>PasswordJava<br>ScriptRegEx</td>
<td>password_java_<br>script_regex</td>
<td>Password RegEx (Javascript)</td>
<td>The regular expression used by the front-end components for password validation.<br />
Default: ^[\S]{5,30}$</td>
</tr>
<tr class="even">
<td>PasswordJavaReg<br>ExViolationErrorMsg</td>
<td>password_java_reg<br>ex_violation_error_msg</td>
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
<tr class="odd">
<td>PasswordHashMethod</td>
<td>password_hash_method</td>
<td>Password Hashing Algorithm</td>
<td><p>Specifies the Password Hashing Algorithm used the hash the password before storing in the user store.<br />
Possible values:<br />
SHA - Uses SHA digest method. SHA-1, SHA-256<br />
MD5 - Uses MD 5 digest method.<br />
PLAIN_TEXT - Plain text passwords.(Default)</p>
<p>If you just configure as SHA, It is considered as SHA-1, It is always better to configure algorithm with higher bit value as digest bit size would be increased.<br />
<br />
Most of the LDAP servers (such as OpenLdap, OpenDJ, AD, ApacheDS and etc..) are supported to store password as salted hashed values (SSHA)<br />
Therefore WSO2IS server just wants to feed password into the connected user store as a plain text value. Then LDAP user store can store them as salted hashed value. To feed the plain text into the LDAP server, you need to set PasswordHashMethod to “PLAIN_TEXT”<br />
But; if your LDAP does not support to store user password as hashed values. You can configure WSO2 server to hash the password and feeds the hashed password into the LDAP server. Then you need to configure PasswordHashMethod property with SHA (SHA-1), SHA-256, SHA-512. Please note WSO2 server cannot create a salted hashed password (SSHA) to feed into the LDAP.</p></td>
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
<td>max_user_name<br>_list_length</td>
<td>Maximum User List Length</td>
<td>Controls the number of users listed in the user store of a WSO2 product. This is useful when you have a large number of users and don't want to list them all. Setting this property to 0 displays all users.<br />
Default: 100<br />
<br />
In some user stores, there are policies to limit the number of records that can be returned from the query. Setting the value 0 it will list the maximum results returned by the user store. If you need to increase that you need to set it in the user store level.<br />
Eg : Active directory has the MaxPageSize property with the default value 1000.</td>
</tr>
<tr class="even">
<td>MaxRoleName<br>ListLength</td>
<td>max_role_name<br>_list_length</td>
<td>Maximum Role List Length</td>
<td><p>Controls the number of roles listed in the user store of a WSO2 product. This is useful when you have a large number of roles and don't want to list them all. Setting this property to 0 displays all roles.<br />
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
<td>UserRoles<br>CacheEnabled</td>
<td>user_roles<br>_cache_enabled</td>
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
<td>ConnectionPooling<br>Enabled</td>
<td>connection_pooling<br>_enabled</td>
<td>Enable LDAP Connection Pooling</td>
<td>Define whether LDAP connection pooling is enabled<br />
Possible values:<br />
True: Enable connection pooling. Enabling it will improve the performance<br />
False: Disable connection pooling
<br />
Default: false<br /></td>
</tr>
<tr class="even">
<td>LDAPConnectionTimeout</td>
<td>ldap_connection_timeout</td>
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
<td>MembershipAttributeRange</td>
<td>membership_attribute_range</td>
<td>Membership Attribute Range</td>
<td><p>This is to define the maximum users of role returned by the LDAP/AD user store. This does not depend on the max page size of the user store.</p>
<p>Default: not configured</p></td>
</tr>
<tr class="odd">
<td>RetryAttempts</td>
<td>retry_attempts</td>
<td>Retry Attempts</td>
<td>Retry the authentication request if a timeout happened
<p>Default: not configured</p></td>
</tr>
<tr class="even">
<td>LDAPConnection<br>Timeout</td>
<td>ldap_connection<br>_timeout</td>
<td>LDAP Connection Timeout</td>
<td>If the connection to the LDAP is inactive for the length of time
(in milliseconds) specified by this property, the connection
will be terminated.
<p>Default: not configured</p><br/>
<p>Sample: 20</p>
</td>
</tr>
</tbody>
</table>

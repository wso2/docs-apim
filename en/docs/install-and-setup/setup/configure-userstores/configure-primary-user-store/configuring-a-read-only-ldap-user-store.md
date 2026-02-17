# Configuring a Read-Only LDAP User Store

It is assumed that you have already setup your read-only LDAP user store. Follow the given steps to configure it as the primary user store in WSO2 API Manager:

-   [Step 1: Setting up the read-only LDAP/AD user store manager](#step-1-setting-up-the-read-only-ldapad-user-store-manager)
-   [Step 2: Updating the system administrator](#step-2-updating-the-system-administrator)
-   [Step 3: Starting the server](#step-3-starting-the-server)

!!! info
    API Manager is compatible with multiple user stores. Instead of using the embedded user store, you can set your own user store as the primary user store.

## Step 1: Setting up the read-only LDAP/AD user store manager

The following are the minimum configurations that are required to configure the Read-only LDAP userstore manager.

<table>
<thead>
<tr class="header">
<th>Configuration Name</th>
<th>Display Name</th>
<th>Description</th>
</tr>
<tr class="even">
<td>type</td>
<td>userstore Type</td>
<td>This indicates the type of userstore manager that we are using. For Read-only LDAP userstore manager, this value
should be read_only_ldap_unique_id.
</td>
</tr>
<tr class="odd">
<td>base_dn</td>
<td>User Search Base</td>
<td>This is the DN of the context or object under which the user entries are stored in the userstore. When the userstore searches for users, it will start from this location of the directory.<br />
Sample values: ou=Users,dc=wso2,dc=org</td>
</tr>
</thead>
</table>

Following are the minimum userstore properties that are required to configure the Read-only LDAP userstore manager.

<table>
<thead>
<tr class="header">
<th>Property Id</th>
<th>Primary userstore Property</th>
<th>Secondary userstore Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>ConnectionURL</td>
<td>connection_url</td>
<td>Connection URL</td>
<td><p>This is the connection URL to the user store server.</p>
<p>Sample values:<br />
<a href="ldap://10.100.1.100:389">ldap://10.100.1.100:389</a><br />
<a href="ldaps://10.100.1.102:639">ldaps://10.100.1.102:639</a><br />
<br />
If you are connecting over ldaps (secured LDAP).<br />
you need to import the certificate of the userstore to <code><&ZeroWidthSpace;APIM_HOME>/repository/resources/security/client-truststore.jks</code>. For information on how to add certificates to the truststore and how keystores are configured and used in a system, see <br />
<a href="{{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/">Using asymmetric encryption</a><br />
<br />
If LDAP connection pooling is used, see enable connection pooling for LDAPS connections.</br>
</p></td>
</tr>
<tr class="odd">
<td>ConnectionName</td>
<td>connection_name</td>
<td>Connection Name</td>
<td><p>This is the username used to connect to the userstore and perform various operations. This user does not need to be an administrator in the userstore or have an administrator role in the WSO2 product that you are using, but this user must have permissions to read the user list and users' attributes and to perform search operations on the userstore. The value you specify is used as the DN (Distinguish Name) attribute of the user who has sufficient permissions to perform operations on users and roles in LDAP.</p>
<p>This property is mandatory.<br />
Sample values: uid=admin,ou=system</p></td>
</tr>
<tr class="even">
<td>ConnectionPassword</td>
<td>connection_password</td>
<td>Connection Password</td>
<td>Password for the ConnectionName user</td>
</tr>
</tbody>
</table>

Replace the default `user_store` configuration in the `<APIM_HOME>/repository/conf/deployment.toml        
` file, as per your ldap server configuration. A sample configuration is given below.

``` toml
[user_store]
type = "read_only_ldap_unique_id"
base_dn = "ou=system"
connection_url = "ldap://localhost:10389"
connection_name = "uid=admin,ou=system"
connection_password = "admin"
```
Apart from the properties mentioned above, WSO2 API Manager also supports advanced LDAP configurations.

---

### Properties used in read-only LDAP userstore manager

Any of the following properties can be configured for the `PRIMARY` userstore by adding them as follows to
`<APIM-HOME>/repository/conf/deployment.toml`.

``` toml
[user_store]
<Property-Name> = <Property-Value>
```
For example :

``` toml
[user_store]
read_groups = true
```

!!! tip
    The properties given below can also be configured for a secondary userstore through the management console.

### Properties used in read-only LDAP userstore manager

Any of the following properties can be configured for the `PRIMARY` userstore by adding them as follows to
`<APIM-HOME>/repository/conf/deployment.toml`.

``` toml
[user_store]
<Property-Name> = <Property-Value>
```
For example :

``` toml
[user_store]
read_groups = true
```

!!! tip
    The properties given below can also be configured for a secondary userstore through the management console.

<table>
<thead>
<tr class="header">
<th>Property Id</th>
<th>Primary Userstore Property</th>
<th>Secondary Userstore Property
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td>UserEntryObjectClass</td>
<td>user_entry_object_class</td>
<td>User Entry Object Class</td>
<td>The object class that is used to construct user entries<br />
<p>Default: identityPerson (a custom object class defined in WSO2 Identity Server)</p></td>
</tr>
<tr class="odd">
<td>UserNameAttribute</td>
<td>user_name_attribute</td>
<td>Username Attribute</td>
<td><p>This is a uniquely identifying attribute that represents the username of the user. Users can be authenticated using their email address, UID, etc. The value of the attribute is considered as the username.</p>
<p>Default: uid<br />
<br />
 Note: email address is considered as a special case in WSO2 products, if you want to set the email address as username, see <a href="{{base_path}}/administer/product-security/logins-and-passwords/maintaining-logins-and-passwords/#setting-up-an-e-mail-login">Using email address as the username</a></p></td>
</tr>
<tr class="odd">
<td>UserIDAttribute</td>
<td>user_id_attribute</td>
<td>User ID Attribute</td>
<td><p>This is the attribute used for uniquely identifying a user entry. The value of the attribute is considered as the unique user ID.</p>
<p>Default: scimId <br/></p></td>
</tr>
<tr class="even">
<td>UserNameSearchFilter</td>
<td>user_name_search_filter</td>
<td>User Search Filter</td>
<td>Filtering criteria used to search for a particular user entry<br />
<p>Default : (&amp;amp;(objectClass=person)(uid=?))</p></td>
</tr>
<tr class="odd">
<td>UserNameListFilter</td>
<td>user_name_list_filter</td>
<td>User List Filter</td>
<td>This is the filtering criteria for searching user entries in the userstore. This query or filter is used when doing search operations on users with different search attributes.<br />
<br />
<p>Default: (objectClass=person)</p><br />
In this case, the search operation only provides the objects created from the person object class.</td>
</tr>
<tr class="even">
<td>UserDNPattern</td>
<td>user_dn_pattern</td>
<td>User DN Pattern</td>
<td><p>This is the pattern for the user's DN, which can be defined to improve the search. When there are many user entries in the LDAP userstore, defining a UserDNPattern provides more impact on performances as the LDAP does not have to travel through the entire tree to find users.</p>
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
<td>When WriteGroups is set to <code>false</code>, none of the groups in the userstore can be read, and the following group configurations are NOT mandatory: GroupSearchBase, GroupNameListFilter, or GroupNameAttribute.<br />
<p>Default: true
<br />
Possible values:<br />
true: Reads groups from userstore<br />
false: Doesn’t read groups from userstore</td>
</tr>
<tr class="odd">
<td>WriteGroups</td>
<td>write_groups</td>
<td>Write Groups</td>
<td>Indicates whether groups should be write to the userstore<br />
<p>Default: true
<br />
Possible values:<br />
true: Writes groups to userstore<br />
false: Does not write groups to userstore, so only internal roles can be created. Whether the existing userstore groups will be read, depends on the value of the ReadGroups property.<br />
</td>
</tr>
<tr class="even">
<td>UserSearchBase</td>
<td>user_search_base</td>
<td>User Search Base</td>
<td>DN of the context or object under which the users are stored in the user store. When the user store searches for users, it will start from this location of the directory
<p>Default: ou=Users,dc=wso2,dc=org</p></td>
</tr>
<tr class="odd">
<td>GroupSearchBase</td>
<td>group_search_base</td>
<td>Group Search Base</td>
<td><p>This is the DN of the context or object under which the group entries are stored in the userstore. When the userstore searches for groups, it will start from this location of the directory.</p>
<p>Default: ou=Groups,dc=wso2,dc=org</p></td>
</tr>
<tr class="even">
<td>GroupEntryObjectClass</td>
<td>group_entry_object_class</td>
<td>Group Entry Object Class</td>
<td>Object class used to construct group entries.<br/>
Default: groupOfNames</td>
</tr>
<tr class="odd">
<td>GroupNameAttribute</td>
<td>group_name_attribute</td>
<td>Group Name Attribute</td>
<td>This is the attribute used for uniquely identifying a group entry. This attribute is to be treated as the group name.
<br/><p>Default: cn</p></td>
</tr>
<tr class="even">
<td>GroupNameSearchFilter</td>
<td>group_name_search_filter</td>
<td>Group Search Filter</td>
<td><p>Filtering criteria used to search for a particular group entry</p>
<p>Default: (&amp;amp;(objectClass=groupOfNames)(cn=?))</p></td>
</tr>
<tr class="odd">
<td>GroupNameListFilter</td>
<td>group_name_list_filter</td>
<td>Group List Filter</td>
<td><p>This is the filtering criteria for searching group entries in the userstore. This query or filter is used when doing search operations on groups with different search attributes.</p>
<p>Default: ((objectClass=groupOfNames)) In this case, the search operation only provides the objects created from the 
groupOfName object class.</p></td>
</tr>
<tr class="even">
<td>RoleDNPattern</td>
<td>role_dn_pattern</td>
<td>Role DN Pattern</td>
<td><p>This denotes the pattern for the group's DN which can be defined to improve the search. When there are many group entries in the LDAP userstore, defining a RoleDNPattern provides more impact on performances as the LDAP does not have to traverse through the entire tree to find the group.</p>
<p>Sample values: cn={0},ou=Groups,dc=wso2,dc=org</p></td>
</tr>
<tr class="odd">
<td>MembershipAttribute</td>
<td>membership_attribute_range</td>
<td>Membership Attribute</td>
<td><p>Defines the attribute that contains the distinguished names (DN) of user objects that are in a group</p>
<p>Default: member</p></td>
</tr>
<tr class="even">
<td>MemberOfAttribute</td>
<td>member_of_attribute</td>
<td>Member Of Attribute</td>
<td>Defines the attribute that contains the distinguished names (DN) of group objects that a user is assigned to<br />
Possible values: memberOf</td>
</tr>
<tr class="odd">
<td>BackLinksEnabled</td>
<td>back_links_enabled</td>
<td>Enable Back Links</td>
<td>This defines whether the backlink support is enabled. If you are using MemberOfAttribute attribute, this should be set to <code>true</code>.
<br/><p>Default : false</p></td>
</tr>
<tr class="even">
<td>UsernameJavaRegEx</td>
<td>username_java_regex</td>
<td>Username RegEx (Java)</td>
<td>This is the regular expression used by the back-end components for username validation. By default, strings with non-empty characters have a length of 3 to 30 allowed. You can provide ranges of alphabets, numbers, and ASCII values in the RegEx properties.<br />
<p>Default: [a-zA-Z0-9._\-|//]{3,30}$</p></td>
</tr>
<tr class="odd">
<td>UsernameJava<br>ScriptRegEx</td>
<td>username_java<br>_script_regex</td>
<td>Username RegEx (Javascript)</td>
<td>The regular expression used by the front-end components for username validation<br />
<p>Default: ^[\S]{3,30}$</p></td>
</tr>
<tr class="even">
<td>UsernameJavaReg<br>ExViolationErrorMsg</td>
<td>username_java_reg<br>_ex_violation_error_msg</td>
<td>Username RegEx Violation Error Message</td>
<td>Error message when the Username does not match with UsernameJavaRegEx<br />
<p>Default: Username pattern policy violated</p></td>
</tr>
<tr class="odd">
<td>PasswordJavaRegEx</td>
<td>password_java_regex</td>
<td>Password RegEx (Java)</td>
<td>The regular expression used by the back-end components for password validation. By default, strings with non-empty characters have a length of 5 to 30 allowed. You can provide ranges of alphabets, numbers, and ASCII values in the RegEx properties.<br />
<p>Default: ^[\S]{5,30}$</p></td>
</tr>
<tr class="even">
<td>PasswordJava<br>ScriptRegEx</td>
<td>password_java<br>_script_regex</td>
<td>Password RegEx (Javascript)</td>
<td>The regular expression used by the front-end components for password validation<br />
<p>Default: ^[\S]{5,30}$</p></td>
</tr>
<tr class="odd">
<td>PasswordJavaReg<br>ExViolationErrorMsg</td>
<td>password_java_reg<br>ex_violation_error_msg</td>
<td>Password RegEx Violation Error Message</td>
<td>Error message when the Password is not matched with passwordJavaRegEx<br />
<p>Default: Password length should be within 5 to 30 characters</p></td></tr>
<tr class="even">
<td>RolenameJavaRegEx</td>
<td>rolename_java_regex</td>
<td>Role Name RegEx (Java)</td>
<td>The regular expression used by the back-end components for role name validation. By default, strings with non-empty characters have a length of 3 to 30 allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.<br />
<p>Default: [a-zA-Z0-9._\-|//]{3,30}$</p></td>
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
Default: true</td>
</tr>
<tr class="odd">
<td>PasswordHashMethod</td>
<td>password_hash_method</td>
<td>Password Hashing Algorithm</td>
<td><p>Specifies the Password Hashing Algorithm used the hash the password before storing in the userstore<br />
Possible values:<br />
SHA - Uses SHA digest method. SHA-1, SHA-256<br />
MD5 - Uses MD 5 digest method.<br />
PLAIN_TEXT - Plain text passwords.(Default)</p>
<p>If you configure this as SHA, it is considered as SHA-1. It is always better to configure algorithm with a higher bit value as the digest bit size would be increased.<br />
<br />
Most of the LDAP servers (such as OpenLdap, OpenDJ, AD, ApacheDS and etc.) are supported to store passwords as salted hashed values (SSHA).<br />
Therefore, WSO2 API Manager just wants to feed passwords into the connected userstore as a plain text value. Then LDAP userstore can store them as a salted hashed value. To feed the plain text into the LDAP server, you need to set PasswordHashMethod to “PLAIN_TEXT”<br />
However, if your LDAP does not support storing user passwords as hashed values, you can configure the WSO2 API Manager to hash the password and then feed the hashed password into the LDAP server. For this, you need to configure the PasswordHashMethod property with SHA (SHA-1), SHA-256, or SHA-512. The WSO2 API Manager cannot create a salted hashed password (SSHA) to feed into the LDAP.</p></td>
</tr>
<tr class="even">
<td>MultiAttribute<br>Separator</td>
<td>multi_attribute<br>_separator</td>
<td>Multiple Attribute Separator</td>
<td>This property is used to define a character to separate multiple attributes. This ensures that it will not appear as part of a claim value. Normally “,” is used to separate multiple attributes, but you can define ",,," or "..." or a similar character sequence.<br />
<p>Default: “,”</p></td>
</tr>
<tr class="odd">
<td>MaxUserName<br>ListLength </td>
<td>max_user_name<br>_list_length</td>
<td>Maximum User List Length</td>
<td>This controls the number of users listed in the userstore of WSO2 API Manager. This is useful when you have a large number of users and don't want to list them all. Setting this property to 0 displays all users.<br />
<p>Default: 100</p><br />
In some userstores, there are policies to limit the number of records that can be returned from the query. Setting the value to 0 will list the maximum results returned by the userstore. If you need to increase this, you need to set it in the userstore level.<br />
Eg : Active directory has the MaxPageSize property with the default value as 1000.</td>
</tr>
<tr class="even">
<td>MaxRoleName<br>ListLength</td>
<td>max_role_name_<br>list_length</td>
<td>Maximum Role List Length</td>
<td><p>This controls the number of roles listed in the userstore of WSO2 API Manager. This is useful when you have a large number of roles and don't want to list them all. Setting this property to 0 displays all roles.<br />
<p>Default: 100</p><br />
In some userstores, there are policies to limit the number of records that can be returned from the query. Setting the value to 0 will list the maximum results returned by the userstore. If you need to increase this, you need to set it in the userstore level.</p>
<p>Eg: Active directory has the MaxPageSize property with the default value as 1000.</p></td>
</tr>
<tr class="odd">
<td>kdcEnabled</td>
<td>kdc_enabled</td>
<td>Enable KDC</td>
<td>If your userstore is capable of acting as a Kerberos Key Distribution Center (KDC) and if you prefer to enable it, set this property to <code>true</code>.<br />
<p>Default: false</p></td>
</tr>
<tr class="even">
<td>UserRoles<br>CacheEnabled</td>
<td>user_roles_<br>cache_enabled</td>
<td>Enable User Role Cache</td>
<td>This is to indicate whether to cache the role list of a user.<br />
Default: true<br />
<br />
Possible values:<br />
false: Set it to <code>false</code> if the user roles are changed by external means and those changes should be instantly reflected in the Carbon instance.
<br />
Default: true<br /></td>
</tr>
<tr class="odd">
<td>Connection<br>PoolingEnabled</td>
<td>connection_<br>pooling_enabled</td>
<td>Enable LDAP Connection Pooling</td>
<td>Defines whether LDAP connection pooling is enabled<br />
Possible values:<br />
True: Enables connection pooling. Enabling it will improve the performance.<br />
False: Disables connection pooling
<br />
<p>Default: false</p><br /></td>
</tr>
<tr class="even">
<td>LDAPConnectionTimeout</td>
<td>ldap_connection_timeout</td>
<td>LDAP Connection Timeout</td>
<td>Timeout in making the initial LDAP connection. This is configured in milliseconds.<br /> Default: 5000</td>
</tr>
<tr class="odd">
<td>ReadTimeout</td>
<td>read_timeout</td>
<td>LDAP Read Timeout</td>
<td>The value of this property is the read timeout in milliseconds for LDAP operations. If the LDAP provider cannot get an LDAP response within that period, it aborts the read attempt. The integer should be greater than zero. An integer less than or equal to zero indicates that no read timeout is specified, which is equivalent to waiting for the response infinitely until it is received.
<br />
<p>Default: not configured</p></td>
</tr>
<tr class="odd">
<td>Membership<br>AttributeRange</td>
<td>membership_<br>attribute_range</td>
<td>Membership Attribute Range</td>
<td><p>This is to define the maximum users of role returned by the LDAP/AD userstore. This does not depend on the max page size of the userstore.</p>
<p>Default: not configured</p></td>
</tr>
<tr class="even">
<td>RetryAttempts</td>
<td>retry_attempts</td>
<td>Retry Attempts</td>
<td>Retry the authentication request if a timeout happens
<p>Default: not configured</p></td>
</tr>
</tbody>
</table>

---

Following are some key points to consider :

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
    
           -   For Active Directory, you need to import the certificate of Active Directory to the `client-truststore.jks` of the WSO2 product. For information on how to add certificates to the truststore and how keystores are configured and used in a system, see [Using Asymmetric Encryption]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/) .
    
           -   You also need to [enable connection pooling](https://is.docs.wso2.com/en/5.10.0/setup/performance-tuning-recommendations/#pooling-ldaps-connections) for LDAPS connections at the time of starting your server, which will enhance server performance.
    

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

   5.  Set the `ReadGroups` property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `GroupSearchBase` , `GroupSearchFilter` and `GroupNameAttribute` properties. If the `ReadGroups` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a membership (user list) or back link attribute as shown below.
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

        To read roles based on a backlink attribute, use the following code snippet instead of the above:

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

Following is a sample of read-only LDAP related user_store_properties in `<API-M_HOME>/repository/conf/deployment.toml` file:
```
[user_store.properties]
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

## Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. By default, the system will create an admin user in the LDAP that has admin permissions. But this cannot be done it the LDAP user store is read-only. Hence that capability should be disabled in the `<APIM_HOME>/repository/conf/deployment.toml` file as follows:

``` 
[super_admin]
username = "AdminSOA"
admin_role = "admin"
create_admin_account = false
```

-   **create_admin_account:** This should be set to 'False' as it will not be allowed to create users and roles in a read-only user store.
-   **admin_role:** The admin role you enter here should already exist in the read-only user store. Otherwise, you must enter an internal role, which will be saved to the internal database of the system when the system starts the first time.
-   **username:** Since we are configuring a read-only LDAP as the primary user store, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. For example, say a valid username is AdminSOA. Update the `username` section of your configuration as shown above. You do not have to update the password element as it is already set in the user store.


If the user store can be written to, you can add the super tenant user to the user store. Therefore, create_admin_account should be set to true as shown below.
``` 
[super_admin]
username = "admin"
admin_role = "admin"
create_admin_account = true
```
For information about the system administrator user, see [Configuring the System Administrator]({{base_path}}/reference/config-catalog/#super-admin-configurations) , and for information on how keystores are used in WSO2 products, see [Using Asymmetric Encryption]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/) .

## Step 3: Starting the server

Start your server and try to log in as the admin user you specified. The password is the admin user's password in the LDAP server.





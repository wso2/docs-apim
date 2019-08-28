# admin\_Configuring a Read-Write LDAP User Store

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `         user-mgt.xml        ` file found in the `         <PRODUCT_HOME>/repository/conf/        ` directory. This file is shipped with user store manager configurations for all possible user store types (JDBC, read-only LDAP/Active Directory, read-write LDAP and read-write Active directory). The instructions given below explains how to configure a read-write LDAP as the primary user store for the WSO2 server.

!!! info
The default User Store

The primary user store that is configured by default in the user-mgt.xml file of WSO2 products is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2. This database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles). In the case of the WSO2 Identity Server, the default user store is an LDAP (Apache DS) that is shipped with the product.


Note that the RDBMS used in the default configuration can remain as the database used for storing Authorization information.

Follow the given steps to configure a read-write LDAP as the primary user store:

-   [Step 1: Setting up the read-write LDAP user store manager](#admin_ConfiguringaRead-WriteLDAPUserStore-Step1:Settinguptheread-writeLDAPuserstoremanager)
-   [Step 2: Updating the system administrator](#admin_ConfiguringaRead-WriteLDAPUserStore-Step2:Updatingthesystemadministrator)
-   [Step 3: Starting the server](#admin_ConfiguringaRead-WriteLDAPUserStore-Step3:Startingtheserver)

### Step 1: Setting up the read-write LDAP user store manager

!!! info
Before you begin

-   If you create the `          user-mgt.xml         ` file yourself, be sure to save it in the `          <PRODUCT_HOME>/repository/conf         ` directory.
-   The `          class         ` attribute for a read-write LDAP is `          <UserStoreManager class="org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager">         `


Once the above points are made note of and completed, you can start configuring your external read-write LDAP as the primary user store.

1.  Enable the `           <ReadWriteLDAPUserStoreManager>          ` user store manager class in the `           user-mgt.xml          ` file by uncommenting the relevant code. When it is enabled, the user manager reads/writes into the LDAP user store.

        !!! note
    Note that these configurations already exist in the `           user-mgt.xml          ` file so you only need to uncomment them and make the appropriate adjustments.Also ensure that you comment out the configurations for other user stores that you are not using; in short, you can only configure one primary user store.


2.  The default configuration for the external read/write user store in the `           user-mgt.xml          ` file is as follows. You may have to change some of these values according to your requirements. For more information about each of the properties used in the `           user-mgt.xml          ` file for configuring the primary user store , see [Properties of User Stores](https://docs.wso2.com/display/ADMIN44x/Working+with+Properties+of+User+Stores) .

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

    1.  To read and write to an LDAPuserstore, it is important to ensure that the `             ReadGroups            ` and `             WriteGroups            ` properties in the `             <PRODUCT_HOME>/repository/conf/user-mgt.xml            ` file are set to `             true            ` .

        ``` xml
                <Property name="ReadGroups">true</Property>
                <Property name="WriteGroups">true</Property>
        ```

    2.  Set the attribute to use as the username, typically either `             cn            ` or `             uid            ` for LDAP. Ideally, `             <Property name="UserNameAttribute">            ` and `             <Property name="UserNameSearchFilter">            ` should refer to the same attribute. If you are not sure what attribute is available in your user store, check with your LDAP administrator.

        ``` html/xml
                    <Property name="UserNameAttribute">uid</Property>
        ```

    3.  Specify the following properties that are relevant to connecting to the LDAP in order to perform various tasks.

        ``` xml
                    <Property name="ConnectionURL">ldap://localhost:${Ports.EmbeddedLDAP.LDAPServerPort}</Property>
                    <Property name="ConnectionName">uid=admin,ou=system</Property>
                    <Property name="ConnectionPassword">admin</Property>
        ```

                !!! note
        If you are using `             ldaps            ` (secured LDAP) to connect to the LDAP:

        -   You need set the `               ConnectionURL              ` as shown below.

            ``` xml
                        <Property name="ConnectionURL">ldaps://10.100.1.100:636</Property>
            ```

        -   You also need to [enable connection pooling](https://docs.wso2.com/display/ADMIN44x/Performance+Tuning#PerformanceTuning-ldaps_pooling) for LDAPS connections at the time of starting your server, which will enhance server performance.


    4.  In WSO2 products based on Carbon 4.4.x, you can set the `             LDAPConnectionTimeout            ` property: If the connection to the LDAP is inactive for the length of time (in milliseconds) specified by this property, the connection will be terminated.

    5.  Set the `             ReadGroups            ` property to 'true', if it should be allowed to read roles from this user store. When this property is 'true', you must also specify values for the `             GroupSearchBase            ` , `             GroupSearchFilter            ` and `             GroupNameAttribute            ` properties. If the `             ReadGroups            ` property is set to 'false', only Users can be read from the user store. You can set the configuration to read roles from the user store by reading the user/role mapping based on a membership (user list) or backlink attribute as shown below.
        To read the user/role mapping based on a membership (This is used by the `             ApacheDirectory            ` server and `             OpenLDAP)            ` :

        -   Enable the `               ReadGroups              ` property.

            ``` html/xml
                        <Property name="ReadGroups">true</Property>
            ```

        -   Set the `               GroupSearchBase              ` property to the directory name where the Roles are stored. That is, the roles you create using the management console of your product will be stored in this directory location. Also, when LDAP searches for groups, it will start from this location of the directory. For example:

            ``` html/xml
                            <Property name="GroupSearchBase">ou=system,CN=Users,DC=wso2,DC=test</Property>
            ```

        -   Set the GroupSearchFilter andGroupNameAttributes. For example:

            ``` html/xml
                            <Property name="GroupSearchFilter">(objectClass=groupOfNames)</Property>
                            <Property name="GroupNameAttribute">cn</Property>
            ```

        -   Set the `               MembershipAttribute              ` property as shown below:

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
### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. Since the LDAP user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. Alternatively, you can also use a user ID that already exists in the LDAP. For information about the system administrator user, see [Configuring the System Administrator](https://docs.wso2.com/display/ADMIN44x/Configuring+the+System+Administrator) .

These two alternative configurations can be done as explained below.

-   If the user store is read-only, find a valid user that already resides in the user store. For example, say a valid username is AdminSOA. Update the `           <AdminUser>          ` section of your configuration as shown below. You do not have to update the password element as it is already set in the user store.

    ``` html/xml
        <AddAdmin>False</AddAdmin> 
        <AdminRole>admin</AdminRole> 
        <AdminUser> 
         <UserName>AdminSOA</UserName> 
         <Password>XXXXXX</Password> 
        </AdminUser>
    ```

-   If the user store can be written to, you can add the super tenant user to the user store. Therefore, `           <AddAdmin>          ` should be set to true as shown below.

    ``` html/xml
            <AddAdmin>true</AddAdmin> 
            <AdminRole>admin</AdminRole> 
            <AdminUser> 
             <UserName>admin</UserName> 
             <Password>admin</Password> 
            </AdminUser>
    ```

### Step 3: Starting the server

Start your server and try to log in as the admin user you specified in **Step 2** .

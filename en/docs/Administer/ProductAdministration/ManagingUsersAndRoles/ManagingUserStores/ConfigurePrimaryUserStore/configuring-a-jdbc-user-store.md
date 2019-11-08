# admin\_Configuring a JDBC User Store

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the user-mgt.xml file found in the &lt;PRODUCT\_HOME&gt;/repository/conf/ directory. This file is shipped with user store manager configurations for all possible user store types (JDBC, read-only LDAP/Active Directory, read-write LDAP and read-write Active directory). The instructions given below explains how to configure an RDBMS (JDBC) as the primary user store for the WSO2 server.

!!! info
The default User Store

The internal H2 database that is shipped with every WSO2 product (except WSO2 Identity Server) is configured as the default primary user store. This internal database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles). In the case of the WSO2 Identity Server, the default user store is an LDAP (Apache DS) that is shipped with the product.


When you configure a JDBC user store as the primary user store, you can either use the default configuration or you can change it in the following ways:

-   You can set up two separate databases for the Authorization Manager and the User Store Manager.
-   It is not recommended to use the default H2 database in production. Therefore, you can replace this. For instructions on replacing this by setting up a new RDBMS and configuring it for your system, see [Setting Up the Physical Database](https://docs.wso2.com/display/ADMIN44x/Setting+up+the+Physical+Database) .

Therefore, before you begin, ensure that the RDBMS that you want to use as the JDBC user store is correctly set up for your system. Then, follow the steps given below to configure a JDBC user store as the primary user store in your product.

-   [Step 1: Configuring the JDBC user store manager](#admin_ConfiguringaJDBCUserStore-Step1:ConfiguringtheJDBCuserstoremanager)
-   [Step 2: Updating the system administrator](#admin_ConfiguringaJDBCUserStore-Step_2_updating_the_system_administratorStep2:Updatingthesystemadministrator)
-   [Step 3: Updating the datasources](#admin_ConfiguringaJDBCUserStore-Step_3_Updating_the_datasourcesStep3:Updatingthedatasources)
-   [Step 4: Starting the server](#admin_ConfiguringaJDBCUserStore-Step4:Startingtheserver)

### Step 1: Configuring the JDBC user store manager

!!! info
Before you begin

-   If you create the `user-mgt.xml` file yourself, be sure to save it in the `<PRODUCT_HOME>/repository/conf/` directory.
-   The `class` attribute for JDBC is `<UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">` .


To configure a JDBC user store as the primary user store, you must change the `JDBCUserStoreManager` section in the `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file.

1.  Uncomment the following section:

    ``` html/xml
        <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
    ```

2.  Specify the connection to the RDBMS inside the JDBC user store manager according to your requirement. For more information on user store properties in the `<PRODUCT_HOME>/repository/conf/user-mgt.xm` l file which are used for configuring the primary user store, see [Properties of Primary User Stores](https://docs.wso2.com/display/ADMIN44x/Working+with+Properties+of+User+Stores) .

    -   [**Internal JDBC User Store**](#07558322bc01441bb93d694b1a414907)
    -   [**External JDBC User Store**](#a7ce30ed25ea4009a85474287ec472e5)

    The following sample shows how to configure the internal RDBMS as the JDBC user store:

    ``` html/xml
            <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
                 <Property name="TenantManager">org.wso2.carbon.user.core.tenant.JDBCTenantManager</Property>
                 <Property name="ReadOnly">false</Property>
                 <Property name="MaxUserNameListLength">100</Property>
                 <Property name="IsEmailUserName">false</Property>
                 <Property name="DomainCalculation">default</Property>
                 <Property name="PasswordDigest">SHA-256</Property>
                 <Property name="StoreSaltedPassword">true</Property>
                 <Property name="UserNameUniqueAcrossTenants">false</Property>
                 <Property name="PasswordJavaRegEx">[\S]{5,30}$</Property>
                 <Property name="PasswordJavaScriptRegEx">[\\S]{5,30}</Property>
                 <Property name="UsernameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
                 <Property name="UsernameJavaScriptRegEx">[\\S]{3,30}</Property>
                 <Property name="RolenameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
                 <Property name="RolenameJavaScriptRegEx">[\\S]{3,30}</Property>
                 <Property name="UserRolesCacheEnabled">true</Property>
            </UserStoreManager>
    ```

    The following sample shows how to configure an external RDBMS as the JDBC user store:

    ``` html/xml
            <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
                  <Property name="TenantManager">org.wso2.carbon.user.core.tenant.JDBCTenantManager</Property>
                  <Property name="driverName">com.mysql.jdbc.Driver</Property>
                  <Property name="url">jdbc:mysql://localhost:3306/tcsdev</Property>
                  <Property name="userName"></Property>
                  <Property name="password"></Property>
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
                  <Property name="UsernameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
                  <Property name="UsernameJavaScriptRegEx">^[\S]{5,30}$</Property>
                  <Property name="RolenameJavaRegEx">[a-zA-Z0-9._\-|/]{3,30}$</Property>
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
                  <Property name="GetUserLisForPropertySQL">SELECT UM_USER_NAME FROM UM_USER, UM_USER_ATTRIBUTE WHERE UM_USER_ATTRIBUTE.UM_USER_ID = UM_USER.UM_ID AND UM_USER_ATTRIBUTE.UM_ATTR_NAME =? AND UM_USER_ATTRIBUTE.UM_ATTR_VALUE LIKE ? AND UM_USER_ATTRIBUTE.UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
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
    The sample for the external JDBC user store consists of properties pertaining to various SQL statements. This is because the schema may be different for an external user store, and these adjustments need to be made in order to streamline the configurations with WSO2 products.


3.  Add the `PasswordHashMethod` property to the `UserStoreManager` configuration for `JDBCUserStoreManager` . For example:

    ``` html/xml
        <UserStoreManager class="org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager">
             <Property name="PasswordHashMethod">SHA</Property>
             ...
        </UserStoreManager>
    ```

    The `PasswordHashMethod` property specifies how the password should be stored. It usually has the following values:

    -`SHA` - Uses SHA digest method.
    -`MD5` - Uses MD 5 digest method.
    -`PLAIN_TEXT` - Plain text passwords.

    In addition, it also supports all digest methods in <http://docs.oracle.com/javase/6/docs/api/java/security/MessageDigest.html> .

4.  If you are setting up an external JDBC user store, you need to set the following property to 'true' to be able to create roles in the primary user store.

    ``` java
            <Property name="WriteGroups">false</Property>
    ```

### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time. If the JDBC user store is read-only, then we need to always use a user ID that is already in the user store as the super tenant. Otherwise, if the JDBC user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. F or information on configuring the system administrator user, see [Configuring the System Administrator](https://docs.wso2.com/display/ADMIN44x/Configuring+the+System+Administrator) .

These two alternative configurations can be done as explained below.

-   If the user store is read-only, find a valid user that already resides in the RDBMS. For example, say a valid username is AdminSOA. Update the `<AdminUser>` section of your configuration as shown below. You do not have to update the password element as it is already set in the user store.

    ``` html/xml
            <AddAdmin>False</AddAdmin> 
            <AdminRole>admin</AdminRole> 
            <AdminUser> 
             <UserName>AdminSOA</UserName> 
             <Password>XXXXXX</Password> 
            </AdminUser>
    ```

-   If the user store can be written to, you can add the super tenant user to the user store. Therefore, `<AddAdmin>` should be set to `true` as shown below.

    ``` html/xml
            <AddAdmin>true</AddAdmin> 
            <AdminRole>admin</AdminRole> 
            <AdminUser> 
             <UserName>admin</UserName> 
             <Password>admin</Password> 
            </AdminUser>
    ```

In the realm configuration section, set the value of the `MultiTenantRealmConfigBuilder` property to `org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder` . For example:

``` html/xml
    <Property name="MultiTenantRealmConfigBuilder">org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder</Property>
```

### Step 3: Updating the datasources

Whenever there is an RDBMS set up for your system, it is necessary to create a corresponding datasource, which allows the system to connect to the database. The datasource for the internal H2 database that is shipped with WSO2 products by default, is configured in the `master-datasources.xml` file, which is stored in the `<PRODUCT_HOME>/repository/conf/datasources/` directory. F or detailed information on setting up databases, see [Setting Up the Physical Database](https://docs.wso2.com/display/ADMIN44x/Setting+up+the+Physical+Database) , and for information on the purpose of defining datasources and how they are configured for a product, see [Managing Datasources](https://docs.wso2.com/display/ADMIN44x/Managing+Datasources) .

1.  There are two possible methods for updating datasources:
    -   Shown below is how the `master-datasources.xml` file is configured to connect to the default H2 database in your system. If you have replaced the default database with a new RDBMS, which you are now using as the JDBC users store, you have to update the `master-datasource.xml` file with the relevant information.

        ``` java
                <datasource>
                            <name>WSO2_CARBON_DB</name>
                            <description>The datasource used for registry and user manager</description>
                            <jndiConfig>
                                <name>jdbc/WSO2CarbonDB</name>
                            </jndiConfig>
                            <definition type="RDBMS">
                                <configuration>
                                    <url>jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000</url>
                                    <username>wso2carbon</username>
                                    <password>wso2carbon</password>
                                    <driverClassName>org.h2.Driver</driverClassName>
                                    <maxActive>50</maxActive>
                                    <maxWait>60000</maxWait>
                                    <testOnBorrow>true</testOnBorrow>
                                    <validationQuery>SELECT 1</validationQuery>
                                    <validationInterval>30000</validationInterval>
                                </configuration>
                            </definition>
                </datasource>
        ```

<!-- -->

1.  -   Alternatively, instead of using the master-datasource.xml file, you can also create a new XML file with the datasource information of your new RDBMS and store it in the same `<PRODUCT_HOME>/repository/conf/datasources/` directory.

2.  Now, the datasource configuration and the user store manager configuration in the user-mgt.xml file should be linked together. You can do this by referring to the datasource information (typically defined in the `master-datasources.xml` file) from the `user-mgt.xml` file as explained below.
    -   The RDBMS that is used for storing Authorization information is configured under the `<Configuration>` section in the `user-mgt.xml` file, by adding `<Property name="dataSource">` as shown below. The following example refers to the default H2 database.

        ``` html/xml
                    <Configuration> 
                        ....... 
                        <Property name="dataSource">jdbc/WSO2CarbonDB</Property> 
                    </Configuration>
        ```

        If you are using the same RDBMS as the user store in your system, this datasource reference will suffice.

    -   However, if you have set up a separate RDBMS as the user store, instead of using a common RDBMS for Authorization information as well as the user store, you must refer to the datasource configuration from within the User Store Manager configuration in the `user-mgt.xml` file by adding the `<Property name="dataSource">` property.

### Step 4: Starting the server

1.  Add the JDBC driver to the classpath by copying its JAR file into the `<PRODUCT_HOME>/repository/components/lib` directory.
2.  Start the server.


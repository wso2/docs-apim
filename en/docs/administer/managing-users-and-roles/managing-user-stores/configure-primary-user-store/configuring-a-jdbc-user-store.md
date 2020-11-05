# Configuring a JDBC User Store

User management functionality is provided by default in WSO2 API Manager and it can be configured via the `<API-M_HOME>/repository/conf/deployment.toml` file. The instructions given below explain how to configure JDBC as a user store.

!!! tip
       To get a high-level understanding of the primary user stores available in WSO2 API Manager, see [Configuring primary User Stores]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/configure-primary-user-store/configuring-the-primary-user-store) 

The user core connects to two databases (the same database is utilized by default):

-   **User Management Database** - The database where authorization information is stored internally.
-   **User Store Database** - The user store database where users/roles reside.

You can either use the default configuration or you can change it in the following ways:

-   You can set up two separate databases for the Authorization Manager and the User Store Manager.
-   It is not recommended to use the default H2 database in production. Therefore, you can replace them with a different RDBMS. For instructions on setting up a new RDBMS and configuring it for your system, see [Setting Up Databases]({{base_path}}/install-and-setup/setting-up-databases/overview).

!!!tip
    Before you begin, ensure that the RDBMS that you want to use as the JDBC user store is correctly set up for your system. Then, follow the steps given below to configure a JDBC user store as the primary user store in your product.

Follow the given steps to configure a JDBC user store:

- [Step 1 - Configure the JDBC user store manager](#step-1-configure-the-jdbc-user-store-manager)
- [Step 2 - Update the system administrator](#step-2-update-the-system-administrator)
- [Step 3 - Update the datasources](#step-3-update-the-datasources)
- [Step 4 - Start the server](#step-4-start-the-server)

## Step 1 - Configure the JDBC user store manager

1. Add the following configurations in the `<API-M_HOME>/repository/conf/deployment.toml` file.

    ```
    [user_store]
    type = "database_unique_id"
    class = "org.wso2.carbon.user.core.jdbc.UniqueIDJDBCUserStoreManager"
    ```

2. Optionally, if you need to connect to an external RDBMS for the `database` user store type, you need to define the following configurations along with the user store type.

    !!! info
        By default, the WSO2 API Manager uses a JDBC user store manager, which is an internal RDBMS.

    ```toml
    [user_store.properties]
    TenantManager = "org.wso2.carbon.user.core.tenant.JDBCTenantManager"
    data_source = "WSO2USER_DB"
    Disabled = false
    MaxUserNameListLength = 100
    MaxRoleNameListLength = 100
    UserRolesCacheEnabled = true
    PasswordDigest = "SHA-256"
    ReadGroups = true
    ReadOnly = false
    IsEmailUserName = false
    DomainCalculation = "default"
    StoreSaltedPassword = true
    WriteGroups = false
    UserNameUniqueAcrossTenants = false
    PasswordJavaRegEx = "^[\\S]{5,30}$"
    PasswordJavaScriptRegEx = "^[\\S]{5,30}$"
    UsernameJavaRegEx = "^[\\S]{5,30}$"
    UsernameJavaScriptRegEx = "^[\\S]{5,30}$"
    RolenameJavaRegEx = "^[\\S]{5,30}$"
    RolenameJavaScriptRegEx = "^[\\S]{5,30}$"
    SCIMEnabled = false
    SelectUserSQL = "SELECT * FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?"
    GetRoleListSQL = "SELECT UM_ROLE_NAME, UM_TENANT_ID, UM_SHARED_ROLE FROM UM_ROLE WHERE UM_ROLE_NAME LIKE ? AND UM_TENANT_ID=? AND UM_SHARED_ROLE ='0' ORDER BY UM_ROLE_NAME"
    GetSharedRoleListSQL = "SELECT UM_ROLE_NAME, UM_TENANT_ID, UM_SHARED_ROLE FROM UM_ROLE WHERE UM_ROLE_NAME LIKE ? AND UM_SHARED_ROLE ='1' ORDER BY UM_ROLE_NAME"
    UserFilterSQL = "SELECT UM_USER_NAME FROM UM_USER WHERE UM_USER_NAME LIKE ? AND UM_TENANT_ID=? ORDER BY UM_USER_NAME"
    UserRoleSQL = "SELECT UM_ROLE_NAME FROM UM_USER_ROLE, UM_ROLE, UM_USER WHERE UM_USER.UM_USER_NAME=? AND UM_USER.UM_ID=UM_USER_ROLE.UM_USER_ID AND UM_ROLE.UM_ID=UM_USER_ROLE.UM_ROLE_ID AND UM_USER_ROLE.UM_TENANT_ID=? AND UM_ROLE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?"
    UserSharedRoleSQL = "SELECT UM_ROLE_NAME, UM_ROLE.UM_TENANT_ID, UM_SHARED_ROLE FROM UM_SHARED_USER_ROLE INNER JOIN UM_USER ON UM_SHARED_USER_ROLE.UM_USER_ID = UM_USER.UM_ID INNER JOIN UM_ROLE ON UM_SHARED_USER_ROLE.UM_ROLE_ID = UM_ROLE.UM_ID WHERE UM_USER.UM_USER_NAME = ? AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = UM_USER.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_ROLE_TENANT_ID = UM_ROLE.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = ?"
    IsRoleExistingSQL = "SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?"
    GetUserListOfRoleSQL = "SELECT UM_USER_NAME FROM UM_USER_ROLE, UM_ROLE, UM_USER WHERE UM_ROLE.UM_ROLE_NAME=? AND UM_USER.UM_ID=UM_USER_ROLE.UM_USER_ID AND UM_ROLE.UM_ID=UM_USER_ROLE.UM_ROLE_ID AND UM_USER_ROLE.UM_TENANT_ID=? AND UM_ROLE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?"
    GetUserListOfSharedRoleSQL = "SELECT UM_USER_NAME FROM UM_SHARED_USER_ROLE INNER JOIN UM_USER ON UM_SHARED_USER_ROLE.UM_USER_ID = UM_USER.UM_ID INNER JOIN UM_ROLE ON UM_SHARED_USER_ROLE.UM_ROLE_ID = UM_ROLE.UM_ID WHERE UM_ROLE.UM_ROLE_NAME= ? AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = UM_USER.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_ROLE_TENANT_ID = UM_ROLE.UM_TENANT_ID"
    IsUserExistingSQL = "SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?"
    GetUserPropertiesForProfileSQL = "SELECT UM_ATTR_NAME, UM_ATTR_VALUE FROM UM_USER_ATTRIBUTE, UM_USER WHERE UM_USER.UM_ID = UM_USER_ATTRIBUTE.UM_USER_ID AND UM_USER.UM_USER_NAME=? AND UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?"
    GetUserPropertyForProfileSQL = "SELECT UM_ATTR_VALUE FROM UM_USER_ATTRIBUTE, UM_USER WHERE UM_USER.UM_ID = UM_USER_ATTRIBUTE.UM_USER_ID AND UM_USER.UM_USER_NAME=? AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?"
    GetUserLisForPropertySQL = "SELECT UM_USER_NAME FROM UM_USER, UM_USER_ATTRIBUTE WHERE UM_USER_ATTRIBUTE.UM_USER_ID = UM_USER.UM_ID AND UM_USER_ATTRIBUTE.UM_ATTR_NAME =? AND UM_USER_ATTRIBUTE.UM_ATTR_VALUE LIKE ? AND UM_USER_ATTRIBUTE.UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?"
    GetProfileNamesSQL = "SELECT DISTINCT UM_PROFILE_ID FROM UM_USER_ATTRIBUTE WHERE UM_TENANT_ID=?"
    GetUserProfileNamesSQL = "SELECT DISTINCT UM_PROFILE_ID FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?"
    GetUserIDFromUserNameSQL = "SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?"
    GetUserNameFromTenantIDSQL = "SELECT UM_USER_NAME FROM UM_USER WHERE UM_TENANT_ID=?"
    GetTenantIDFromUserNameSQL = "SELECT UM_TENANT_ID FROM UM_USER WHERE UM_USER_NAME=?"
    AddUserSQL = "INSERT INTO UM_USER (UM_USER_NAME, UM_USER_PASSWORD, UM_SALT_VALUE, UM_REQUIRE_CHANGE, UM_CHANGED_TIME, UM_TENANT_ID) VALUES (?, ?, ?, ?, ?, ?)"
    AddUserToRoleSQL = "INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?), ?)"
    AddRoleSQL = "INSERT INTO UM_ROLE (UM_ROLE_NAME, UM_TENANT_ID) VALUES (?, ?)"
    AddSharedRoleSQL = "UPDATE UM_ROLE SET UM_SHARED_ROLE = ? WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID = ?"
    AddRoleToUserSQL = "INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?)"
    AddSharedRoleToUserSQL = "INSERT INTO UM_SHARED_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_USER_TENANT_ID, UM_ROLE_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?, ?)"
    RemoveUserFromSharedRoleSQL = "DELETE FROM UM_SHARED_USER_ROLE WHERE   UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_USER_TENANT_ID=? AND UM_ROLE_TENANT_ID = ?"
    RemoveUserFromRoleSQL = "DELETE FROM UM_USER_ROLE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?"
    RemoveRoleFromUserSQL = "DELETE FROM UM_USER_ROLE WHERE UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?"
    DeleteRoleSQL = "DELETE FROM UM_ROLE WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID=?"
    OnDeleteRoleRemoveUserRoleMappingSQL = "DELETE FROM UM_USER_ROLE WHERE UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?"
    DeleteUserSQL = "DELETE FROM UM_USER WHERE UM_USER_NAME = ? AND UM_TENANT_ID=?"
    OnDeleteUserRemoveUserRoleMappingSQL = "DELETE FROM UM_USER_ROLE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?"
    OnDeleteUserRemoveUserAttributeSQL = "DELETE FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?"
    UpdateUserPasswordSQL = "UPDATE UM_USER SET UM_USER_PASSWORD= ?, UM_SALT_VALUE=?, UM_REQUIRE_CHANGE=?, UM_CHANGED_TIME=? WHERE UM_USER_NAME= ? AND UM_TENANT_ID=?"
    UpdateRoleNameSQL = "UPDATE UM_ROLE set UM_ROLE_NAME=? WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID=?"
    AddUserPropertySQL = "INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?, ?, ?, ?)"
    UpdateUserPropertySQL = "UPDATE UM_USER_ATTRIBUTE SET UM_ATTR_VALUE=? WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_TENANT_ID=?"
    DeleteUserPropertySQL = "DELETE FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_TENANT_ID=?"
    UserNameUniqueAcrossTenantsSQL = "SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=?"
    IsDomainExistingSQL = "SELECT UM_DOMAIN_ID FROM UM_DOMAIN WHERE UM_DOMAIN_NAME=? AND UM_TENANT_ID=?"
    AddDomainSQL = "INSERT INTO UM_DOMAIN (UM_DOMAIN_NAME, UM_TENANT_ID) VALUES (?, ?)"
    AddUserToRoleSQL-mssql = "INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(?)"
    AddRoleToUserSQL-mssql = "INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), (?)"
    AddUserPropertySQL-mssql = "INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), (?), (?), (?), (?)"
    AddUserToRoleSQL-openedge = "INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) SELECT UU.UM_ID, UR.UM_ID, ? FROM UM_USER UU, UM_ROLE UR WHERE UU.UM_USER_NAME=? AND UU.UM_TENANT_ID=? AND UR.UM_ROLE_NAME=? AND UR.UM_TENANT_ID=?"
    AddRoleToUserSQL-openedge = "INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) SELECT UR.UM_ID, UU.UM_ID, ? FROM UM_ROLE UR, UM_USER UU WHERE UR.UM_ROLE_NAME=? AND UR.UM_TENANT_ID=? AND UU.UM_USER_NAME=? AND UU.UM_TENANT_ID=?"
    AddUserPropertySQL-openedge = "INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) SELECT UM_ID, ?, ?, ?, ? FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?"
    DomainName = "wso2.org"
    Description = "This is an external JDBC primary user store"
    ```

    !!! info
        The sample for the external JDBC user store configuration consists of properties on various SQL statements. This is because the schema may be different for an external user store, and these adjustments need to be made in order to streamline the configurations with WSO2 products.

3.  Add the `PasswordHashMethod` property to the `UserStoreManager` configuration for `JDBCUserStoreManager`. 

    Example:

    ``` toml
    [user_store.properties]
    ReadGroupsPasswordHashMethod = "SHA"
    ```

    The `PasswordHashMethod` property specifies how the password should be stored. It usually has the following values:

    - **SHA** - Uses SHA digest method.
    - **MD5** - Uses MD 5 digest method.
    - **PLAIN_TEXT** - Plain text passwords.

    In addition, it also supports all the digest methods in [java.security Class MessageDigest](http://docs.oracle.com/javase/6/docs/api/java/security/MessageDigest.html).

4.  If you are setting up an external JDBC user store, you need to set the following property to `true` to be able to create roles in the primary user store.

    ``` toml
    [user_store.properties]
    WriteGroups = false
    ```

!!! note
    Note that these configurations will be automatically populated to the `user-mgt.xml` file. You can verify whether your configured properties are populated correctly using this file.
    
    Given below is a sample configuration populated for the JDBC user store in the `user-mgt.xml`.
    
    ```
    <UserStoreManager class="org.wso2.carbon.user.core.jdbc.UniqueIDJDBCUserStoreManager">
        <Property name="IsBulkImportSupported">true</Property>
        <Property name="MaxUserNameListLength">100</Property>
        <Property name="UpdateUserPropertySQL">UPDATE UM_USER_ATTRIBUTE SET UM_ATTR_VALUE=? WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_TENANT_ID=?</Property>
        <Property name="GetRoleListSQL">SELECT UM_ROLE_NAME, UM_TENANT_ID, UM_SHARED_ROLE FROM UM_ROLE WHERE UM_ROLE_NAME LIKE ? AND UM_TENANT_ID=? AND UM_SHARED_ROLE ='0' ORDER BY UM_ROLE_NAME</Property>
        <Property name="MultiAttributeSeparator">,</Property>
        <Property name="GetUserIDFromUserNameSQL">SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
        <Property name="RemoveRoleFromUserSQL">DELETE FROM UM_USER_ROLE WHERE UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
        <Property name="AddSharedRoleSQL">UPDATE UM_ROLE SET UM_SHARED_ROLE = ? WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID = ?</Property>
        <Property name="GetUserPropertyForProfileSQL">SELECT UM_ATTR_VALUE FROM UM_USER_ATTRIBUTE, UM_USER WHERE UM_USER.UM_ID = UM_USER_ATTRIBUTE.UM_USER_ID AND UM_USER.UM_USER_NAME=? AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
        <Property name="ReadGroupsPasswordHashMethod">SHA</Property>
        <Property name="UserNameUniqueAcrossTenants">false</Property>
        <Property name="StoreSaltedPassword">true</Property>
        <Property name="TenantManager">org.wso2.carbon.user.core.tenant.JDBCTenantManager</Property>
        <Property name="RemoveUserFromRoleSQL">DELETE FROM UM_USER_ROLE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
        <Property name="AddUserPropertySQL-mssql">INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), (?), (?), (?), (?)</Property>
        <Property name="GetTenantIDFromUserNameSQL">SELECT UM_TENANT_ID FROM UM_USER WHERE UM_USER_NAME=?</Property>
        <Property name="Disabled">false</Property>
        <Property name="OnDeleteUserRemoveUserRoleMappingSQL">DELETE FROM UM_USER_ROLE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
        <Property name="AddUserPropertySQL-openedge">INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) SELECT UM_ID, ?, ?, ?, ? FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
        <Property name="CaseInsensitiveUsername">true</Property>
        <Property name="GetUserListOfSharedRoleSQL">SELECT UM_USER_NAME FROM UM_SHARED_USER_ROLE INNER JOIN UM_USER ON UM_SHARED_USER_ROLE.UM_USER_ID = UM_USER.UM_ID INNER JOIN UM_ROLE ON UM_SHARED_USER_ROLE.UM_ROLE_ID = UM_ROLE.UM_ID WHERE UM_ROLE.UM_ROLE_NAME= ? AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = UM_USER.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_ROLE_TENANT_ID = UM_ROLE.UM_TENANT_ID</Property>
        <Property name="IsEmailUserName">false</Property>
        <Property name="GetUserPropertiesForProfileSQL">SELECT UM_ATTR_NAME, UM_ATTR_VALUE FROM UM_USER_ATTRIBUTE, UM_USER WHERE UM_USER.UM_ID = UM_USER_ATTRIBUTE.UM_USER_ID AND UM_USER.UM_USER_NAME=? AND UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
        <Property name="AddUserToRoleSQL-mssql">INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(?)</Property>
        <Property name="IsRoleExistingSQL">SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?</Property>
        <Property name="GetUserListOfRoleSQL">SELECT UM_USER_NAME FROM UM_USER_ROLE, UM_ROLE, UM_USER WHERE UM_ROLE.UM_ROLE_NAME=? AND UM_USER.UM_ID=UM_USER_ROLE.UM_USER_ID AND UM_ROLE.UM_ID=UM_USER_ROLE.UM_ROLE_ID AND UM_USER_ROLE.UM_TENANT_ID=? AND UM_ROLE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
        <Property name="GetUserLisForPropertySQL">SELECT UM_USER_NAME FROM UM_USER, UM_USER_ATTRIBUTE WHERE UM_USER_ATTRIBUTE.UM_USER_ID = UM_USER.UM_ID AND UM_USER_ATTRIBUTE.UM_ATTR_NAME =? AND UM_USER_ATTRIBUTE.UM_ATTR_VALUE LIKE ? AND UM_USER_ATTRIBUTE.UM_PROFILE_ID=? AND UM_USER_ATTRIBUTE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
        <Property name="DomainName">wso2.org</Property>
        <Property name="AddUserToRoleSQL">INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?), ?)</Property>
        <Property name="UsernameJavaRegEx">^[\S]{5,30}$</Property>
        <Property name="AddUserSQL">INSERT INTO UM_USER (UM_USER_NAME, UM_USER_PASSWORD, UM_SALT_VALUE, UM_REQUIRE_CHANGE, UM_CHANGED_TIME, UM_TENANT_ID) VALUES (?, ?, ?, ?, ?, ?)</Property>
        <Property name="SelectUserSQL">SELECT * FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
        <Property name="GetSharedRoleListSQL">SELECT UM_ROLE_NAME, UM_TENANT_ID, UM_SHARED_ROLE FROM UM_ROLE WHERE UM_ROLE_NAME LIKE ? AND UM_SHARED_ROLE ='1' ORDER BY UM_ROLE_NAME</Property>
        <Property name="WriteGroups">false</Property>
        <Property name="GetUserNameFromTenantIDSQL">SELECT UM_USER_NAME FROM UM_USER WHERE UM_TENANT_ID=?</Property>
        <Property name="AddRoleToUserSQL-openedge">INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) SELECT UR.UM_ID, UU.UM_ID, ? FROM UM_ROLE UR, UM_USER UU WHERE UR.UM_ROLE_NAME=? AND UR.UM_TENANT_ID=? AND UU.UM_USER_NAME=? AND UU.UM_TENANT_ID=?</Property>
        <Property name="AddRoleToUserSQL-mssql">INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) SELECT (SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), (?)</Property>
        <Property name="AddDomainSQL">INSERT INTO UM_DOMAIN (UM_DOMAIN_NAME, UM_TENANT_ID) VALUES (?, ?)</Property>
        <Property name="OnDeleteUserRemoveUserAttributeSQL">DELETE FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
        <Property name="IsUserExistingSQL">SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?</Property>
        <Property name="RolenameJavaScriptRegEx">^[\S]{5,30}$</Property>
        <Property name="RolenameJavaRegEx">^[\S]{5,30}$</Property>
        <Property name="UserRoleSQL">SELECT UM_ROLE_NAME FROM UM_USER_ROLE, UM_ROLE, UM_USER WHERE UM_USER.UM_USER_NAME=? AND UM_USER.UM_ID=UM_USER_ROLE.UM_USER_ID AND UM_ROLE.UM_ID=UM_USER_ROLE.UM_ROLE_ID AND UM_USER_ROLE.UM_TENANT_ID=? AND UM_ROLE.UM_TENANT_ID=? AND UM_USER.UM_TENANT_ID=?</Property>
        <Property name="IsDomainExistingSQL">SELECT UM_DOMAIN_ID FROM UM_DOMAIN WHERE UM_DOMAIN_NAME=? AND UM_TENANT_ID=?</Property>
        <Property name="PasswordJavaRegEx">^[\S]{5,30}$</Property>
        <Property name="DeleteRoleSQL">DELETE FROM UM_ROLE WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID=?</Property>
        <Property name="GetUserProfileNamesSQL">SELECT DISTINCT UM_PROFILE_ID FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
        <Property name="AddRoleToUserSQL">INSERT INTO UM_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?)</Property>
        <Property name="ReadGroups">true</Property>
        <Property name="UserNameUniqueAcrossTenantsSQL">SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=?</Property>
        <Property name="UpdateUserPasswordSQL">UPDATE UM_USER SET UM_USER_PASSWORD= ?, UM_SALT_VALUE=?, UM_REQUIRE_CHANGE=?, UM_CHANGED_TIME=? WHERE UM_USER_NAME= ? AND UM_TENANT_ID=?</Property>
        <Property name="DeleteUserPropertySQL">DELETE FROM UM_USER_ATTRIBUTE WHERE UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_ATTR_NAME=? AND UM_PROFILE_ID=? AND UM_TENANT_ID=?</Property>
        <Property name="AddUserPropertySQL">INSERT INTO UM_USER_ATTRIBUTE (UM_USER_ID, UM_ATTR_NAME, UM_ATTR_VALUE, UM_PROFILE_ID, UM_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?, ?, ?, ?)</Property>
        <Property name="AddRoleSQL">INSERT INTO UM_ROLE (UM_ROLE_NAME, UM_TENANT_ID) VALUES (?, ?)</Property>
        <Property name="PasswordJavaRegExViolationErrorMsg">Password length should be within 5 to 30 characters</Property>
        <Property name="MaxRoleNameListLength">100</Property>
        <Property name="PasswordJavaScriptRegEx">^[\S]{5,30}$</Property>
        <Property name="data_source">WSO2USER_DB</Property>
        <Property name="RemoveUserFromSharedRoleSQL">DELETE FROM UM_SHARED_USER_ROLE WHERE   UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_USER_ID=(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?) AND UM_USER_TENANT_ID=? AND UM_ROLE_TENANT_ID = ?</Property>
        <Property name="UsernameJavaRegExViolationErrorMsg">Username pattern policy violated</Property>
        <Property name="UserRolesCacheEnabled">true</Property>
        <Property name="AddSharedRoleToUserSQL">INSERT INTO UM_SHARED_USER_ROLE (UM_ROLE_ID, UM_USER_ID, UM_USER_TENANT_ID, UM_ROLE_TENANT_ID) VALUES ((SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?),(SELECT UM_ID FROM UM_USER WHERE UM_USER_NAME=? AND UM_TENANT_ID=?), ?, ?)</Property>
        <Property name="AddUserToRoleSQL-openedge">INSERT INTO UM_USER_ROLE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID) SELECT UU.UM_ID, UR.UM_ID, ? FROM UM_USER UU, UM_ROLE UR WHERE UU.UM_USER_NAME=? AND UU.UM_TENANT_ID=? AND UR.UM_ROLE_NAME=? AND UR.UM_TENANT_ID=?</Property>
        <Property name="GetProfileNamesSQL">SELECT DISTINCT UM_PROFILE_ID FROM UM_USER_ATTRIBUTE WHERE UM_TENANT_ID=?</Property>
        <Property name="DeleteUserSQL">DELETE FROM UM_USER WHERE UM_USER_NAME = ? AND UM_TENANT_ID=?</Property>
        <Property name="DomainCalculation">default</Property>
        <Property name="SCIMEnabled">false</Property>
        <Property name="PasswordDigest">SHA-256</Property>
        <Property name="OnDeleteRoleRemoveUserRoleMappingSQL">DELETE FROM UM_USER_ROLE WHERE UM_ROLE_ID=(SELECT UM_ID FROM UM_ROLE WHERE UM_ROLE_NAME=? AND UM_TENANT_ID=?) AND UM_TENANT_ID=?</Property>
        <Property name="UpdateRoleNameSQL">UPDATE UM_ROLE set UM_ROLE_NAME=? WHERE UM_ROLE_NAME = ? AND UM_TENANT_ID=?</Property>
        <Property name="Description">This is an external JDBC primary user store</Property>
        <Property name="UserSharedRoleSQL">SELECT UM_ROLE_NAME, UM_ROLE.UM_TENANT_ID, UM_SHARED_ROLE FROM UM_SHARED_USER_ROLE INNER JOIN UM_USER ON UM_SHARED_USER_ROLE.UM_USER_ID = UM_USER.UM_ID INNER JOIN UM_ROLE ON UM_SHARED_USER_ROLE.UM_ROLE_ID = UM_ROLE.UM_ID WHERE UM_USER.UM_USER_NAME = ? AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = UM_USER.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_ROLE_TENANT_ID = UM_ROLE.UM_TENANT_ID AND UM_SHARED_USER_ROLE.UM_USER_TENANT_ID = ?</Property>
        <Property name="UsernameJavaScriptRegEx">^[\S]{5,30}$</Property>
        <Property name="ReadOnly">false</Property>
        <Property name="UserFilterSQL">SELECT UM_USER_NAME FROM UM_USER WHERE UM_USER_NAME LIKE ? AND UM_TENANT_ID=? ORDER BY UM_USER_NAME</Property>
    </UserStoreManager>
    ```
    
Apart from the above properties WSO2 API Manager also supports advanced JDBC configurations. For descriptions on each of the advanced properties used in the `<API-M_HOME>/repository/conf/deployment.toml` file, see [JDBC user store manager related properties](#jdbc-user-store-manager-related-properties). 

<a name="step2"></a>
## Step 2 - Update the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles, and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time.  

If the JDBC user store is read-only, then you need to use a user ID that is already in the user store as the super tenant. Otherwise, if the JDBC user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. These two alternative configurations can be configured as explained below.

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

In the realm configuration section, set the value of the `MultiTenantRealmConfigBuilder` property to `org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder` in order to construct tenant-specific realm configurations as mentioned below.

``` toml
[realm_manager.properties]
MultiTenantRealmConfigBuilder = "org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder"
```

## Step 3 - Update the datasources

1. Create a database on [any supported RDBMS database]({{base_path}}/install-and-setup/setting-up-databases/overview). 
    
2. Configure the database.
    
     The following are the example configurations for each database type.

    <details class="example">
    <summary>PostgreSQL</summary>
    <p>
    <ol>
    <li><p>Add the `deployment.toml` configurations.</p>
    <pre><code>[database.user]
    url = "jdbc:postgresql://localhost:5432/userdb"
    username = "root"
    password = "root"
    driver = "org.postgresql.Driver"
    </code></pre>
    </li>
    <li>
    <p>Link the datasource configuration and the user store manager RDBMS configuration together.
    </br>By default, the database that is used for persisting user authorization information is the **SHARED_DB**. In addition, by default this is the datasource used for the primary JDBC userstore as well.</p>
    <ul><li><p>If you are going to change both the user management database and the primary userstore, the following configuration will be sufficient.</p>
    <pre><code>[realm_manager]
    data_source = "WSO2USER_DB"
    </code></pre>
    </li>
    <li>
    <p>However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows:</p>
    <pre><code>[user_store.properties]
    data_source = "WSO2USER_DB"
    </code></pre>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>This configuration is already added to the external primary user store configuration given in the second step.</p>
    </div>
    </li></ul>
    </li>
    <li><p>Execute the database scripts.</br>
    Navigate to the <code>&lt;API-M_HOME&gt;/dbscripts</code> directory and execute the <code>&lt;API-M_HOME&gt;/dbscripts/postgresql.sql</code> script.</p>
    </li>
    <li><p>Download the PostgreSQL JDBC driver for the version you are using and copy it to the <code>&lt;API-M_HOME&gt;/repository/components/lib</code> directory.</p>
    </li>
    </ol>
    </p>
    </details>

    <details class="example">
    <summary>MySQL</summary>
    <p>
    <ol>
    <li><p>Add the `deployment.toml` configurations.</p>
    <pre><code>[database.user]
    url = "jdbc:mysql://localhost:3306/userdb?useSSL=false"
    username = "root"
    password = "root"
    driver = "com.mysql.jdbc.Driver"
    </code></pre>
    </li>
    <li>
    <p>Link the datasource configuration and the user store manager RDBMS configuration together.
    </br>By default, the database that is used for persisting user authorization information is the **SHARED_DB**. In addition, by default this is the datasource used for the primary JDBC userstore as well.</p>
    <ul><li><p>If you are going to change both the user management database and the primary userstore, the following configuration will be sufficient.</p>
    <pre><code>[realm_manager]
    data_source = "WSO2USER_DB"
    </code></pre>
    </li>
    <li>
    <p>However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows:</p>
    <pre><code>[user_store.properties]
    data_source = "WSO2USER_DB"
    </code></pre>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>This configuration is already added to the external primary user store configuration given in the second step.</p>
    </div>
    </li></ul>
    </li>
    <li><p>Execute the database scripts.</br>
    Navigate to the <code>&lt;API-M_HOME&gt;/dbscripts</code> directory and execute the <code>&lt;API-M_HOME&gt;/dbscripts/mysql.sql</code> script.</p>
    </li>
    <li><p>Download the MySQL JDBC driver for the version you are using and copy it to the <code>&lt;API-M_HOME&gt;/repository/components/lib</code> directory.</p>
    </li>
    </ol>
    </p>
    </details>        

    <details class="example">
    <summary>DB2</summary>
    <p>
    <ol>
    <li><p>Add the `deployment.toml` configurations.</p>
    <pre><code>[database.user]
    url = "jdbc:db2://192.168.108.31:50000/userdb"
    username = "root"
    password = "root"
    driver = "com.ibm.db2.jcc.DB2Driver"
    </code></pre>
    </li>
    <li>
    <p>Link the datasource configuration and the user store manager RDBMS configuration together.
    </br>By default, the database that is used for persisting user authorization information is the **SHARED_DB**. In addition, by default this is the datasource used for the primary JDBC userstore as well.</p>
    <ul><li><p>If you are going to change both the user management database and the primary userstore, the following configuration will be sufficient.</p>
    <pre><code>[realm_manager]
    data_source = "WSO2USER_DB"
    </code></pre>
    </li>
    <li>
    <p>However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows:</p>
    <pre><code>[user_store.properties]
    data_source = "WSO2USER_DB"
    </code></pre>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>This configuration is already added to the external primary user store configuration given in the second step.</p>
    </div>
    </li></ul>
    </li>
    <li><p>Execute the database scripts.</br>
    Navigate to the <code>&lt;API-M_HOME&gt;/dbscripts</code> directory and execute the <code>&lt;API-M_HOME&gt;/dbscripts/db2.sql</code> script.</p>
    </li>
    <li><p>Download the DB2 JDBC driver for the version you are using and copy it to the <code>&lt;API-M_HOME&gt;/repository/components/lib</code> directory.</p>
    </li>
    </ol>
    </p>
    </details>

    <details class="example">
    <summary>MSSQL</summary>
    <p>
    <ol>
    <li><p>Add the `deployment.toml` configurations.</p>
    <pre><code>[database.user]
    url = "jdbc:sqlserver://localhost:1433;databaseName=userdb;SendStringParametersAsUnicode=false"
    username = "root"
    password = "root"
    driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    </code></pre>
    </li>
    <li>
    <p>Link the datasource configuration and the user store manager RDBMS configuration together.
    </br>By default, the database that is used for persisting user authorization information is the **SHARED_DB**. In addition, by default this is the datasource used for the primary JDBC userstore as well.</p>
    <ul><li><p>If you are going to change both the user management database and the primary userstore, the following configuration will be sufficient.</p>
    <pre><code>[realm_manager]
    data_source = "WSO2USER_DB"
    </code></pre>
    </li>
    <li>
    <p>However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows:</p>
    <pre><code>[user_store.properties]
    data_source = "WSO2USER_DB"
    </code></pre>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>This configuration is already added to the external primary user store configuration given in the second step.</p>
    </div>
    </li></ul>
    </li>
    <li><p>Execute the database scripts.</br>
    Navigate to the <code>&lt;API-M_HOME&gt;/dbscripts</code> directory and execute the <code>&lt;API-M_HOME&gt;/dbscripts/mssql.sql</code> script.</p>
    </li>
    <li><p>Download the MSSQL JDBC driver for the version you are using and copy it to the <code>&lt;API-M_HOME&gt;/repository/components/lib</code> directory.</p>
    </li>
    </ol>
    </p>
    </details> 

    <details class="example">
    <summary>Oracle</summary>
    <p>
    <ol>
    <li><p>Add the `deployment.toml` configurations.</p>
    <pre><code>[database.user]
    url = "jdbc:oracle:thin:@localhost:1521/userdb"
    username = "root"
    password = "root"
    driver = "oracle.jdbc.OracleDriver"
    </code></pre>
    </li>
    <li>
    <p>Link the datasource configuration and the user store manager RDBMS configuration together.
    </br>By default, the database that is used for persisting user authorization information is the **SHARED_DB**. In addition, by default this is the datasource used for the primary JDBC userstore as well.</p>
    <ul><li><p>If you are going to change both the user management database and the primary userstore, the following configuration will be sufficient.</p>
    <pre><code>[realm_manager]
    data_source = "WSO2USER_DB"
    </code></pre>
    </li>
    <li>
    <p>However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows:</p>
    <pre><code>[user_store.properties]
    data_source = "WSO2USER_DB"
    </code></pre>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <p>This configuration is already added to the external primary user store configuration given in the second step.</p>
    </div>
    </li></ul>
    </li>
    <li><p>Execute the database scripts.</br>
    Navigate to the <code>&lt;API-M_HOME&gt;/dbscripts</code> directory and execute the <code>&lt;API-M_HOME&gt;/dbscripts/oracle.sql</code> script.</p>
    </li>
    <li><p>Download the Oracle JDBC driver for the version you are using and copy it to the <code>&lt;API-M_HOME&gt;/repository/components/lib</code> directory.</p>
    </li>
    </ol>
    </p>
    </details>
                  
## Step 4 - Start the server

Start your API-M server and try to sign in using the admin user credentials that you specified in <a href="#step2"><b>Step 2</b></a>.

```
sh wso2server.sh
```

## JDBC user store manager related properties

The following are the properties used in the JDBC user store manager. You can configure any of these properties as follows:

Add the following configuration to the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` toml
[user_store]
<Property-Name> = <Property-Value>
```
Example:

``` toml
[user_store]
read_groups = true
```

!!! tip 
    The properties given below can be configured for a secondary user store through the management console.

<table>

<tr>
<th><b>Property ID</b></th>
<td><code>ReadGroups</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>read_groups</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td><code>ReadGroups</code></td></tr>
<tr>
<th><b>Description</b></th>
<td><p>When <code>ReadGroups</code> is set to <code>false</code>, it indicates whether groups should be read from the user store. <br>If this is disabled by setting it to <code>false</code>, none of the groups in the user store can be read, and the following group configurations are NOT mandatory: <code>GroupSearchBase</code>,<code>GroupNameListFilter</code>, or <code>GroupNameAttribute</code>.</p></br>
<p><b>Default:</b> <code>true</code> <br/></p>
<b>Possible values:</b><br/></p>
<ul><li><p><code>true</code>: Read groups from user store<br /></p></li>
<li><p><code>false</code>: Do not read groups from user store</p></li></ul></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>WriteGroups</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>write_groups</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td><code>WriteGroups</code></td></tr>
<tr>
<th><b>Description</b></th>
<td>Indicates whether groups should be written to the user store.<br />
<br />
<p><b>Default</b> : <code>true</code> <br/></p>
<p><b>Possible values</b>:<br /></p>
<ul><li><p><code>true</code> : Write groups to user store<br /></p></li>
<li><p><code>false</code> : Do not write groups to user store, so only internal roles can be created. Depending on the value of the <code>ReadGroups</code> property, it will read the existing groups from user store or not.</p></li></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>PasswordHashMethod</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>password_hash_method</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Password Hashing Algorithm</td></tr>
<tr>
<th><b>Description</b></th>
<td>Specifies the Password Hashing Algorithm used to hash the password before storing it in the userstore.</br>
Possible values:<br />
<ul><li><code>SHA</code> - Uses SHA digest method. <code>SHA-1</code>, <code>SHA-256</code></li>
<li><code>MD5</code> - Uses MD 5 digest method.</li>
<li><code>PLAIN_TEXT</code> - Plain text passwords.</li></ul>
If you just enter the value <code>SHA</code>, it will be considered as <code>SHA-1</code>. It is always better to configure an algorithm with a higher bit value so that the digest bit size would be increased.</p>
<p>The default value for JDBC userstores is <code>SHA-256</code>. 
</p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>UsernameJavaRegEx</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>username_java_regex</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td><code>UsernameJavaRegEx</code></td></tr>
<tr>
<th><b>Description</b></th>
<td>The regular expression that is used by the backend components for username validation. By default, strings with non-empty characters have a length of 3 to 30 are allowed. You can provide ranges of alphabets, numbers, and also ranges of ASCII values in the RegEx properties.<br/>
<p><b>Default:</b> <code>^[\S]{3,30}$</code></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>UsernameJavaScriptRegEx</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>username_java_script_regex</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td><code>UsernameJavaScriptRegEx</code></td></tr>
<tr>
<th><b>Description</b></th>
<td>The regular expression that is used by the front-end components for username validation.
<br/><p> <b>Default:</b> <code>^[\S]{3,30}$</code></p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>UsernameJavaRegExViolationErrorMsg</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>username_java_reg_ex_violation_error_msg</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Username RegEx Violation Error Message</td></tr>
<tr>
<th><b>Description</b></th>
<td>The error message when the username is not matched with <code>username_java_regex</code> 
<br/><p> <b>Default:</b> <code>Username pattern policy violated</code>  </p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>PasswordJavaRegEx</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>password_java_regex</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Password RegEx (Java)</td></tr>
<tr>
<th><b>Description</b></th>
<td>The regular expression that is used by the backend components for password validation. By default, strings with non-empty characters have a length of 5 to 30 are allowed. You can provide ranges of alphabets, numbers, and also ranges of ASCII values in the RegEx properties.<br />
<p><b>Default:</b> <code>^[\S]{5,30}$</code></p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>PasswordJavaScriptRegEx</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>password_java_script_regex</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Password RegEx (Javascript)</td></tr>
<tr>
<th><b>Description</b></th>
<td>The regular expression that is used by the front-end components for password validation.<br />
<p><b>Default:</b> <code>^[\S]{5,30}$</code></p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>PasswordJavaRegExViolationErrorMsg</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>password_java_regex_violation_error_msg</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Password RegEx Violation Error Message</td></tr>
<tr>
<th><b>Description</b></th>
<td>Error message when the Password is not matched with <code>passwordJavaRegEx</code>.<br />
<p><b>Default:</b> <code>Password length should be within 5 to 30 characters.</code></p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>PasswordJavaRegExViolationErrorMsg</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>password_java_regex_violation_error_msg</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Password RegEx Violation Error Message</td></tr>
<tr>
<th><b>Description</b></th>
<td>Error message when the password is not matched with <code>passwordJavaRegEx</code>.<br />
<p><b>Default:</b> <code>Password length should be within 5 to 30 characters.</code></p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>RolenameJavaRegEx</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>rolename_java_regex</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Role Name RegEx (Java)</td></tr>
<tr>
<th><b>Description</b></th>
<td>The regular expression that is used by the back-end components for role name validation. By default, strings with non-empty characters have a length of 3 to 30 are allowed. You can provide ranges of alphabets, numbers, and also ranges of ASCII values in the RegEx properties.<br />
<p><b>Default:</b> <code>[a-zA-Z0-9._-|//]{3,30}$</code></p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>MultiAttributeSeparator</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>multi_attribute_separator</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Multiple Attribute Separator</td></tr>
<tr>
<th><b>Description</b></th>
<td>This property is used to define a character to separate multiple attributes. This ensures that it will not appear as part of a claim value. Normally “,” is used to separate multiple attributes, but you can define ",,," or "..." or a similar character sequence<br />
<p><b>Default:</b> <code>“,”</code></p></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>MaxUserNameListLength</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>max_user_name_list_length</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Maximum User List Length</td></tr>
<tr>
<th><b>Description</b></th>
<td>Controls the number of users listed in the user store of a WSO2 product. This is useful when you have a large number of users and do not want to list them all. Setting this property to <code>0</code> displays all the users. (Default: <code>100</code>)<br />
<br />
In some user stores, there are policies to limit the number of records that can be returned from a query. By setting the value to 0, it will list the maximum results returned by the user store. If you need to increase this number, you need to set it in the user store level.<br />
<b>Example:</b> Active directory has the <code>MaxPageSize</code> property with the default value of <code>100</code>.</td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>MaxRoleNameListLength</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>max_role_name_list_length</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Maximum Role List Length</td></tr>
<tr>
<th><b>Description</b></th>
<td>Controls the number of roles listed in the user store of a WSO2 product. This is useful when you have a large number of roles and do not want to list them all. Setting this property to <code>0</code> displays all the roles. (Default: <code>100</code>)<br />
<br />
In some user stores, there are policies to limit the number of records that can be returned from a query. By setting the value to <code>0</code>, it will list the maximum results returned by the user store. If you need to increase this number, you need to set it in the user store level.<br />
<b>Example:</b> Active directory has the <code>MaxPageSize</code> property with the default value of <code>1000</code>.</td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>UserRolesCacheEnabled</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>user_roles_cache_enabled</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Enable User Role Cache</td></tr>
<tr>
<th><b>Description</b></th>
<td>This is to indicate whether to cache the role list of a user. (Default: <code>true</code>)<br />
<br />
<b>Possible values:</b>
<ul><li>
<code>false:</code> Set it to false if the user roles are changed by external means and those changes should be instantly reflected in the Carbon instance.</li><ul></td>
</tr>

<tr>
<th></th>
<th></th>
</tr>

<tr>
<th><b>Property ID</b></th>
<td><code>CaseInsensitiveUsername</code></td></tr>
<tr>
<th><b>Primary User Store </br>Property</b></th>
<td><code>properties.CaseInsensitiveUsername</code></td></tr>
<tr>
<th><b>Secondary User Store </br>Property</b></th>
<td>Case Insensitive Username</td></tr>
<tr>
<th><b>Description</b></th>
<td>Enables the case-insensitivity of the user's username. The default value is <code>true</code> for this configuration. 
<br /><b>Example:</b> If a user's username is <code>test</code>, that user can also use the username as <code>TEST</code>.</td>
</tr>

<tbody>
</table>

!!! note
    In addition to these properties, you can configure SQL queries that are used in the JDBC user store manager and if required you can change the default queries. Even though the additional properties are not listed under the above properties section you can configure it in the same manner as described above.

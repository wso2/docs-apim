# Configuring a JDBC User Store

User management functionality is provided by default in WSO2 API Manager and it can be configured in the 
`<API-M_HOME>/repository/conf/deployment.toml` file. The changes done in the `deployment.toml` file will be automatically populated to the `<API-M_HOME>/repository/conf/user-mgt.xml` file as well. 
This file is shipped with user store manager configurations for all possible user store types ([JDBC](../configuring-a-jdbc-user-store), [read-only LDAP/Active Directory](../configuring-a-read-only-ldap-user-store), 
[read-write Active directory](../configuring-a-read-write-active-directory-user-store), and [read-write LDAP](../configuring-a-read-write-ldap-user-store)). 
The instructions given below explains how to configure JDBC as a user store.

!!! tip
       Refer [Configuring primary User Stores](../configuring-the-primary-user-store) to get a high-level understanding of the primary user stores available in WSO2 API Manager.

The user core connects to two databases (the same database is utilized by default):

-   **User Management Database** - The database where authorization information is stored internally.
-   **User Store Database** - The user store database where users/roles reside.

You can either use the default configuration or you can change it in the following ways:

-   You can set up two separate databases for the Authorization Manager and the User Store Manager.
-   It is not recommended to use the default H2 database in production. Therefore, you can replace them with a different RDBMS. For instructions on setting up a new RDBMS and configuring it for your system, see [Setting Up Databases]({{base_path}}/install-and-setup/setting-up-databases/overview).

!!!tip
    Before you begin, ensure that the RDBMS that you want to use as the JDBC user store is correctly set up for your system. Then, follow the steps given below to configure a JDBC user store as the primary user store in your product.

Follow the given steps to configure a JDBC user store:

-   [Step 1: Configuring the JDBC user store manager](#step-1-configuring-the-jdbc-user-store-manager)
-   [Step 2: Updating the system administrator](#step-2-updating-the-system-administrator)
-   [Step 3: Updating the datasources](#step-3-updating-the-datasources)
-   [Step 4: Starting the server](#step-4-starting-the-server)

### Step 1: Configuring the JDBC user store manager

-   Add these configurations below in `<API-M_HOME>/repository/conf/deployment.toml` file.

    ```
        [user_store]
        type = "database"
    ```

2. By default the WSO2 API Manager uses a JDBC user store manager. This is an internal RDBMS. If you are willing to connect to an external RDBMS for the `database` user store type, you will have to define the following configurations along with the user store type. 

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
        The sample for the external JDBC user store configuration, consists of properties pertaining to various SQL statements. This is because the schema may be different for an external user store, and these adjustments need to be made in order to streamline the configurations with WSO2 products.

3.  Add the `PasswordHashMethod` property to the `UserStoreManager` configuration for `JDBCUserStoreManager` . For example:

    ``` toml
    [user_store.properties]
    ReadGroupsPasswordHashMethod = "SHA"
    ```

    The `PasswordHashMethod` property specifies how the password should be stored. It usually has the following values:

    - **SHA** - Uses SHA digest method.
    - **MD5** - Uses MD 5 digest method.
    - **PLAIN_TEXT** - Plain text passwords.

    In addition, it also supports all digest methods in <http://docs.oracle.com/javase/6/docs/api/java/security/MessageDigest.html> .

4.  If you are setting up an external JDBC user store, you need to set the following property to 'true' to be able to create roles in the primary user store.

    ``` toml
    [user_store.properties]
    WriteGroups = false
    ```
Apart from above properties WSO2 API Manager also supports advanced JDBC configurations. For descriptions on each of the advanced properties used in the `<API-M_HOME>/repository/conf/deployment.toml` file , see [Properties used in JDBC user store manager](properties-used-in-jdbc-user-store-manager). 

### Step 2: Updating the system administrator

The **admin** user is the super tenant that will be able to manage all other users, roles, and permissions in the system by using the management console of the product. Therefore, the user that should have admin permissions is required to be stored in the user store when you start the system for the first time.  If the JDBC user store is read-only, then we need to use a user ID that is already in the user store as the super tenant. Otherwise, if the JDBC user store can be written to, you have the option of creating a new admin user in the user store when you start the system for the first time. These two alternative configurations can be configured as explained below.

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

In the realm configuration section, set the value of the `MultiTenantRealmConfigBuilder` property to `org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder` in order to construct teant specific realm configurations as given below.

``` toml
[realm_manager.properties]
MultiTenantRealmConfigBuilder = "org.wso2.carbon.user.core.config.multitenancy.SimpleRealmConfigBuilder"
```

### Step 3: Updating the datasources


  1. Create a database on [any supported RDBMS database]({{base_path}}/install-and-setup/setting-up-databases/overview). 
    
  2. Following are the example configurations for each database type.
        
??? example "PostgreSQL"
    
    1. deployment.toml Configurations.
        ```
        [database.user]
        url = "jdbc:postgresql://localhost:5432/userdb"
        username = "root"
        password = "root"
        driver = "org.postgresql.Driver"
        
        ```
    2.  Now, the datasource configuration and the user store manager RDBMS configuration should be linked together.
        -   By default, the database that is used for persisting user authorization information is the SHARED_DB. Also, by default this is the datasource used for the primary JDBC userstore as well. If you are willing to change both the user management database and the primary userstore, the following configuration will be sufficient.  
        
            ```toml
            [realm_manager]
            data_source = "WSO2USER_DB"
            ```
    
        -   However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows.
    
            ```toml
            [user_store.properties]
            data_source = "WSO2USER_DB"
            ```
    
            !!! note
                This configuration is already added to the external primary user store configuration given in the second step.

        
    3. Executing database scripts. 
    
        Navigate to `<API-M_HOME>/dbscripts`. Execute the scripts of `<API-M_HOME>/dbscripts/postgresql.sql`
          
    4. Download the PostgreSQL JDBC driver for the version you are using and
                   copy it to the `<API-M_HOME>/repository/components/lib` folder 

??? example "MySQL"

    1. deployment.toml Configurations.
        ```
        [database.user]
        url = "jdbc:mysql://localhost:3306/userdb?useSSL=false"
        username = "root"
        password = "root"
        driver = "com.mysql.jdbc.Driver"
        
        [realm_manager]
        data_source = "WSO2USER_DB"
        ```
    2.  Now, the datasource configuration and the user store manager RDBMS configuration should be linked together.
        -   By default, the database that is used for persisting user authorization information is the SHARED_DB. Also, by default this is the datasource used for the primary JDBC userstore as well. If you are willing to change both the user management database and the primary userstore, the following configuration will be sufficient.  
        
            ```toml
            [realm_manager]
            data_source = "WSO2USER_DB"
            ```
    
        -   However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows.
    
            ```toml
            [user_store.properties]
            data_source = "WSO2USER_DB"
            ```
    
            !!! note
                This configuration is already added to the external primary user store configuration given in the second step.

    3. Executing database scripts. 

        Navigate to `<API-M_HOME>/dbscripts`. Execute the scripts of `<API-M_HOME>/dbscripts/mysql.sql`

    4. Download the MySQL JDBC driver for the version you are using and
                   copy it to the `<API-M_HOME>/repository/components/lib` folder          

??? example "DB2"

    1. deployment.toml Configurations.
        ```
        [database.user]
        url = "jdbc:db2://192.168.108.31:50000/userdb"
        username = "root"
        password = "root"
        driver = "com.ibm.db2.jcc.DB2Driver"
        
        [realm_manager]
        data_source = "WSO2USER_DB"
        ```    
    2.  Now, the datasource configuration and the user store manager RDBMS configuration should be linked together.
        -   By default, the database that is used for persisting user authorization information is the SHARED_DB. Also, by default this is the datasource used for the primary JDBC userstore as well. If you are willing to change both the user management database and the primary userstore, the following configuration will be sufficient.  
        
            ```toml
            [realm_manager]
            data_source = "WSO2USER_DB"
            ```
    
        -   However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows.
    
            ```toml
            [user_store.properties]
            data_source = "WSO2USER_DB"
            ```
    
            !!! note
                This configuration is already added to the external primary user store configuration given in the second step.

    3. Executing database scripts. 
    
        Navigate to `<API-M_HOME>/dbscripts`. Execute the scripts of `<API-M_HOME>/dbscripts/db2.sql`
   
    4. Download the DB2 JDBC driver for the version you are using and
                   copy it to the `<API-M_HOME>/repository/components/lib` folder 

??? example "MSSQL"

    1. deployment.toml Configurations.
        ```
        [database.user]
        url = "jdbc:sqlserver://localhost:1433;databaseName=userdb;SendStringParametersAsUnicode=false"
        username = "root"
        password = "root"
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
        
        [realm_manager]
        data_source = "WSO2USER_DB"
        ```
    2.  Now, the datasource configuration and the user store manager RDBMS configuration should be linked together.
        -   By default, the database that is used for persisting user authorization information is the SHARED_DB. Also, by default this is the datasource used for the primary JDBC userstore as well. If you are willing to change both the user management database and the primary userstore, the following configuration will be sufficient.  
        
            ```toml
            [realm_manager]
            data_source = "WSO2USER_DB"
            ```
    
        -   However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows.
    
            ```toml
            [user_store.properties]
            data_source = "WSO2USER_DB"
            ```
    
            !!! note
                This configuration is already added to the external primary user store configuration given in the second step.

    3. Executing database scripts. 
    
        Navigate to `<API-M_HOME>/dbscripts`. Execute the scripts of `<API-M_HOME>/dbscripts/mssql.sql`
          
    4. Download the MSSQL JDBC driver for the version you are using and copy it to the `<API-M_HOME>/repository/components/lib` folder  
                   
    

??? example "Oracle"

    1. deployment.toml Configurations.
        ```
        [database.user]
        url = "jdbc:oracle:thin:@localhost:1521/userdb"
        username = "root"
        password = "root"
        driver = "oracle.jdbc.OracleDriver"
        
        [realm_manager]
        data_source = "WSO2USER_DB"
        ```
        
    2.  Now, the datasource configuration and the user store manager RDBMS configuration should be linked together.
        -   By default, the database that is used for persisting user authorization information is the SHARED_DB. Also, by default this is the datasource used for the primary JDBC userstore as well. If you are willing to change both the user management database and the primary userstore, the following configuration will be sufficient.  
        
            ```toml
            [realm_manager]
            data_source = "WSO2USER_DB"
            ```
    
        -   However, if you have set up an external RDBMS as the primary user store, instead of a common RDBMS for both, the user management and the user store, you must configure the datasource for this external user store as follows.
    
            ```toml
            [user_store.properties]
            data_source = "WSO2USER_DB"
            ```
    
            !!! note
                This configuration is already added to the external primary user store configuration given in the second step.

    3. Executing database scripts. 
    
        Navigate to `<API-M_HOME>/dbscripts`. Execute the scripts of `API-M_HOME/dbscripts/oracle.sql`
          
    4. Download the Oracle JDBC driver for the version you are using and copy it to the `<API-M_HOME>/repository/components/lib` folder 
                  
### Step 4: Starting the server

Start your APIM server and try to log in as the admin user you specified in **Step 2** .

```
sh wso2server.sh
```

### Properties used in JDBC user store manager.

Following are the properties used in JDBC user store manager. You can configure any of
those properties as follows. 

Add the following configuration to `<API-M_HOME>/repository/conf/deployment.toml`.

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
    The properties given below can be configured for a secondary user store through the management console.

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
<tr class="odd">
<td>ReadGroups</td>
<td>read_groups</td>
<td>ReadGroups</td>
<td>When ReadGroups is set to false, it Indicates whether groups should be read from the user store. If this is disabled by setting it to false, none of the groups in the user store can be read, and the following group configurations are NOT mandatory: GroupSearchBase, GroupNameListFilter, or GroupNameAttribute.<br />
<br />
<p>Default : true <br/>
Possible values:<br/>
true: Read groups from user store<br />
false: Do not read groups from user store</p></td>
</tr>
<tr class="even">
<td>WriteGroups</td>
<td>write_groups</td>
<td>WriteGroups</td>
<td>Indicates whether groups should be written to the user store.<br />
<br />
<p>Default : true <br/>
Possible values:<br />
true : Write groups to user store<br />
false : Do not write groups to user store, so only internal roles can be created. Depending on the value of ReadGroups property, it will read existing groups from user store or not</p></td>
</tr>
<tr class="odd">
<td>PasswordHashMethod</td>
<td>password_hash_method</td>
<td>Password Hashing Algorithm</td>
<td><p>Specifies the Password Hashing Algorithm used to hash the password before storing it in the userstore.<br />
Possible values:<br />
SHA - Uses SHA digest method. SHA-1, SHA-256<br />
MD5 - Uses MD 5 digest method.<br />
PLAIN_TEXT - Plain text passwords.</p>
<p>If you just enter the value `SHA`, it will be considered as `SHA-1`. It is always better to configure an algorithm with a higher bit value so that the digest bit size would be increased.
<br />
The default value for JDBC userstores is SHA-256. 
</p></td>
</tr> 
<tr class="odd">
<td>UsernameJavaRegEx</td>
<td>username_java_regex</td>
<td>UsernameJavaRegEx</td>
<td>The regular expression used by the back-end components for username validation. By default, strings with non-empty characters have a length of 3 to 30 are allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.<br/>
<p>Default: ^[\S]{3,30}$</td></p> <br/>
</tr>
<tr class="even">
<td>UsernameJava<br>ScriptRegEx</td> 
<td>username_java_<br>script_regex</td>
<td>UsernameJavaScriptRegEx</td>
<td>The regular expression used by the front-end components for username validation.
<br/><p> Default: ^[\S]{3,30}$  </p></td>
</tr>
<tr class="odd">
<td>UsernameJavaReg<br>ExViolationErrorMsg</td>
<td>username_java_reg<br>_ex_violation_error_msg</td>
<td>Username RegEx Violation Error Message</td>
<td>Error message when the Username is not matched with username_java_regex 
<br/><p> Default: Username pattern policy violated  </p></td>
</tr>
<tr class="even">
<td>PasswordJavaRegEx</td>
<td>password_java_regex</td>
<td>Password RegEx (Java)</td>
<td>The regular expression used by the back-end components for password validation. By default, strings with non-empty characters have a length of 5 to 30 are allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.<br />
Default: ^[\S]{5,30}$</td>
</tr>
<tr class="odd">
<td>PasswordJava<br>ScriptRegEx</td>
<td>password_java_<br>script_regex</td>
<td>Password RegEx (Javascript)</td>
<td>The regular expression used by the front-end components for password validation.<br />
<p>Default: ^[\S]{5,30}$</p></td>
</tr>
<tr class="even">
<td>PasswordJavaReg<br>ExViolationErrorMsg</td>
<td>password_java_reg<br>ex_violation_error_msg</td>
<td>Password RegEx Violation Error Message</td>
<td>Error message when the Password is not matched with passwordJavaRegEx.<br />
<p>Default: Password length should be within 5 to 30 characters.</p></td>
<tr class="odd">
<td>RolenameJavaRegEx</td>
<td>rolename_java_regex</td>
<td>Role Name RegEx (Java)</td>
<td>The regular expression used by the back-end components for role name validation. By default, strings with non-empty characters have a length of 3 to 30 are allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.<br />
<p>Default: [a-zA-Z0-9._-|//]{3,30}$</p></td>
</tr>
<tr class="odd">
<td>MultiAttribute<br>Separator</td>
<td>multi_attribute<br>_separator</td>
<td>Multiple Attribute Separator</td>
<td>This property is used to define a character to separate multiple attributes. This ensures that it will not appear as part of a claim value. Normally “,” is used to separate multiple attributes, but you can define ",,," or "..." or a similar character sequence<br />
<p>Default: “,”</p></td>
</tr>
<tr class="even">
<td>MaxUserName<br>ListLength</td>
<td>max_user_name_<br>list_length</td>
<td>Maximum User List Length</td>
<td>Controls the number of users listed in the user store of a WSO2 product. This is useful when you have a large number of users and do not want to list them all. Setting this property to 0 displays all users. (Default: 100)<br />
<br />
In some user stores, there are policies to limit the number of records that can be returned from a query. By setting the value to 0, it will list the maximum results returned by the user store. If you need to increase this number, you need to set it in the user store level.<br />
Eg: Active directory has the MaxPageSize property with the default value of 100.</td>
</tr>
<tr class="odd">
<td>MaxRoleName<br>ListLength</td>
<td>max_role_name_<br>list_length</td>
<td>Maximum Role List Length</td>
<td>Controls the number of roles listed in the user store of a WSO2 product. This is useful when you have a large number of roles and do not want to list them all. Setting this property to 0 displays all roles. (Default: 100)<br />
<br />
In some user stores, there are policies to limit the number of records that can be returned from a query. By setting the value to 0, it will list the maximum results returned by the user store. If you need to increase this number, you need to set it in the user store level.<br />
Eg: Active directory has the MaxPageSize property with the default value of 1000.</td>
</tr>
<tr class="even">
<td>UserRolesCacheEnabled</td>
<td>user_roles_cache_enabled</td>
<td>Enable User Role Cache</td>
<td>This is to indicate whether to cache the role list of a user. (Default: true)<br />
<br />
Possible values:<br />
false: Set it to false if the user roles are changed by external means and those changes should be instantly reflected in the Carbon instance.</td>
</tr>
<tr class="odd">
<td>CaseInsensitiveUsername</td>
<td>properties.CaseInsensitiveUsername</td>
<td>Case Insensitive Username</td>
<td>Enables the case insensitivity of the user's username. Default value is <code>true</code> for this configuration. 
<br />Eg: If a user's username is <code>test</code>, that user can also use the username as <code>TEST</code>.
</td>
</tr>
</tbody>
</table>

!!! note
    Addition to these properties, you can configure SQL queries that are
    used in JDBC user store manager and if required can change default
    queries. Those are not listed under above property section but you can
    do the configuration as same as described above.
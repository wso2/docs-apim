# Upgrading WSO2 IS as Key Manager to 5.11.0

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 2.6.0 to 4.1.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager** in the pre-migrated setup.

!!! note
    -   You can follow the below information in either one of the following situations:
        -   You are currently using a WSO2 IS 5.7.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
        -   You are currently using a pre-packaged WSO2 Identity Server as Key Manager 5.7.0 distribution.

-   [Step A - Upgrade IS as Key Manager 5.7.0 to IS 5.11.0](#upgrade-is-as-key-manager-570-to-is-5110)
-   [Step B - Upgrade API Manager 2.6.0 to 4.1.0](#step-b-upgrade-api-manager-260-to-410)

## Step A - Upgrade IS as Key Manager 5.7.0 to IS 5.11.0

Follow step 1 to step 3 below to upgrade your IS as Key Manager 5.7.0 to IS 5.11.0

-   [Step 1 - Migrate the IS as KM configurations to IS 5.11.0](#step-1-migrate-the-is-as-km-configurations)

-   [Step 2 - Migrate the IS as KM resources to IS 5.11.0](#step-2-migrate-the-is-as-km-resources)

-   [Step 3 - Migrate the IS as KM components to IS 5.11.0](#step-3-migrate-the-is-as-km-components)

### Step 1 - Migrate the IS as KM configurations

1. Download WSO2 IS 5.11.0 distribution from [here](https://wso2.com/identity-and-access-management/) and extract it.
   `<IS_HOME>` refers to the root folder of the extracted WSO2 IS 5.11.0.
   
2. Add following configurations in the `<IS_HOME>/repository/conf/deployment.toml` file.

    ??? info "deployment.toml"
        ```
        [[event_listener]]
        id = "token_revocation"
        type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
        name = "org.wso2.is.notification.ApimOauthEventInterceptor"
        order = 1
   
        [[resource.access_control]]
        context = "(.)/keymanager-operations/user-info/claims(.)"
        secure = true
        http_method = "GET"
        permissions = "/permission/admin/manage/identity/usermgt/list"
        scopes = "internal_user_mgt_list"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/user-info/claims/generate"
        secure = true
        http_method = "POST"
        permissions = "/permission/admin/manage/identity/usermgt/list"
        scopes = "internal_user_mgt_list"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register"
        secure = true
        http_method = "POST"
        permissions = "/permission/admin/manage/identity/applicationmgt/create"
        scopes = "internal_application_mgt_create"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register(.*)"
        secure = true
        http_method = "GET"
        permissions = "/permission/admin/manage/identity/applicationmgt/view"
        scopes = "internal_application_mgt_view"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register(.*)"
        secure = true
        http_method = "PUT"
        permissions = "/permission/admin/manage/identity/applicationmgt/update"
        scopes = "internal_application_mgt_update"

        [[resource.access_control]]
        context = "(.*)/keymanager-operations/dcr/register(.*)"
        secure = true
        http_method = "DELETE"
        permissions = "/permission/admin/manage/identity/applicationmgt/delete"
        scopes = "internal_application_mgt_delete"

        [tenant_context.rewrite]
        custom_webapps = ["/keymanager-operations/"]
        ```
3. Configure the event listener endpoint to publish controller events to the Traffic Manager.

    ```
    [event_listener.properties]
    notification_endpoint = "https://<tm.wso2.com>:9443/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "WSO2-IS"
    ```
   
4. IS 5.11.0 uses Symmetric encryption as default and APIM 410 uses Asymmetric algorithm as default. So when using IS 5.11.0 as KM please add below configurations to `deployment.toml`.
   ```
   [keystore]
   userstore_password_encryption = "InternalKeyStore"
   
   [system.parameter]
   "org.wso2.CipherTransformation"="RSA/ECB/OAEPwithSHA1andMGF1Padding"
   
   [encryption]
   internal_crypto_provider = "org.wso2.carbon.crypto.provider.KeyStoreBasedInternalCryptoProvider"
   ```   
5. Migrate IS KM 5.7.0 configurations as per the instructions in [Migrating the configurations](https://is.docs.wso2.com/en/5.11.0/setup/migrating-preparing-for-migration/#migrating-the-configurations).

    !!! Important
        When following the instructions in [Migration the configurations](https://is.docs.wso2.com/en/5.11.0/setup/migrating-preparing-for-migration/#migrating-the-configurations) section of IS 5.11.0 migration guide, make sure to
        follow the below guidelines as well.

        -   Configure the `identity_db` datasource in `<IS_HOME>/repository/conf/deployment.toml` of IS 5.11.0  by pointing to the **old** `WSO2AM_DB`.
            ```
            [database.identity_db]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/am_db"
            username = "wso2carbon"
            password = "wso2carbon"
            ```

        -   If you have used a **JDBCUserStoreManager** as the userstore in previous IS as KM setup, comment/remove the following from `<IS_HOME>/repository/conf/deployment.toml` in IS 5.11.0.
            ```
            #[user_store]
            #type = "read_write_ldap_unique_id"
            #connection_url = "ldap://localhost:${Ports.EmbeddedLDAP.LDAPServerPort}"
            #connection_name = "uid=admin,ou=system"
            #connection_password = "admin"
            #base_dn = "dc=wso2,dc=org"      
            ```
            Instead, add the following to the `<IS_HOME>/repository/conf/deployment.toml` in IS 5.11.0
            ```
            [user_store]
            type = "database"
            ```

        -   If you have used **separate DBs** for user management and registry in the previous IS as KM version, you need to configure WSO2REG_DB and WSO2USER_DB databases separately in `<IS_HOME>/repository/conf/deployment.toml` of IS 5.11.0 to avoid any issues.
            ```
            [database.shared_db]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/reg_db"
            username = "wso2carbon"
            password = "wso2carbon"

            [database.user]
            type = "mysql"
            url = "jdbc:mysql://localhost:3306/um_db"
            username = "wso2carbon"
            password = "wso2carbon"
            ```

        -   If you have used a separate user management database as the primary userstore in previous IS as KM setup, add the following to the `<IS_HOME>/repository/conf/deployment.toml` in IS 5.11.0.
            ```
            [realm_manager]
            data_source = "WSO2USER_DB"
            ```
        -   You **DO NOT NEED** to copy the API-M Key Manager specific configurations from `<OLD_IS_KM_HOME>/repository/conf/api-manager.xml` of previous IS as KM version to IS 5.11.0.

### Step 2 - Migrate the IS as KM Resources
   
1. Download the [WSO2 IS Connector]({{base_path}}/assets/attachments/administer/wso2is-extensions-1.4.2.zip).

2. Extract the distribution and copy the following JAR files to the `<IS_HOME>/repository/components/dropins` directory.
    
    - `wso2is.key.manager.core-1.2.10.jar`
    - `wso2is.notification.event.handlers_1.2.10.jar`

3. Add `keymanager-operations.war` from the extracted distribution to the `<IS_HOME>/repository/deployment/server/webapps` directory.

4. Follow the steps 1 to 8 in [WSO2 IS 5.11.0 migration guide](https://is.docs.wso2.com/en/5.11.0/setup/migrating-to-5110/) **except for step 6** to prepare your current IS as KM 5.7.0 for migration to IS 5.11.0.

### Step 3 - Migrate the IS as KM Components

1. Make sure you backed up all the databases in API-M 2.6.0

2. Run the below script against the AM_DB.

    ??? info "DB Scripts"
        ```tab="DB2"
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER   NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        TIMESTAMP NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        )
        /

        CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_RESOURCE_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_RESOURCE_SEQ);
        END
        /
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID)
        /
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN)
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER NOT NULL,
        RESOURCE_IDENTITY INTEGER NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_RESOURCE_META_DATA_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_META_DATA
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_RESOURCE_META_DATA_SEQ);
        END
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER NOT NULL,
        RESOURCE_IDENTITY INTEGER NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_RESOURCE_SCOPE_TRIG  NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_RESOURCE_SCOPE_SEQ);
        END
        /
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME)
        /
        
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER      NOT NULL,
        PT              VARCHAR(255) NOT NULL,
        TIME_CREATED    TIMESTAMP    NOT NULL,
        EXPIRY_TIME     TIMESTAMP    NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_PERMISSION_TICKET_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_PERMISSION_TICKET
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_PERMISSION_TICKET_SEQ);
        END
        /
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT)
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER NOT NULL,
        PT_RESOURCE_ID INTEGER NOT NULL,
        PT_ID          INTEGER NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_PT_RESOURCE_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_PT_RESOURCE_SEQ);
        END
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER NOT NULL,
        PT_RESOURCE_ID INTEGER NOT NULL,
        PT_SCOPE_ID    INTEGER NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE TRIGGER IDN_UMA_PT_RESOURCE_SCOPE_TRIG NO CASCADE
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW MODE DB2SQL
        BEGIN ATOMIC
        SET (NEW.ID) = (NEXTVAL FOR IDN_UMA_PT_RESOURCE_SCOPE_SEQ);
        END
        /
        ```
    
        ```tab="MSSQL"
        IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER IDENTITY NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        DATETIME         NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);
        
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE_META_DATA]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER IDENTITY NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
    
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_RESOURCE_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER IDENTITY NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);
        
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PERMISSION_TICKET]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER IDENTITY NOT NULL,
        PT              VARCHAR(255)     NOT NULL,
        TIME_CREATED    DATETIME         NOT NULL,
        EXPIRY_TIME     DATETIME         NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);
    
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PT_RESOURCE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER IDENTITY NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID)
        );
    
        IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_UMA_PT_RESOURCE_SCOPE]') AND TYPE IN (N'U'))
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER IDENTITY NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID)
        );
        ```
    
        ```tab="MySQL"
        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE (
        ID                  INTEGER AUTO_INCREMENT NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        TIMESTAMP              NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER AUTO_INCREMENT NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER AUTO_INCREMENT NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER AUTO_INCREMENT NOT NULL,
        PT              VARCHAR(255)           NOT NULL,
        TIME_CREATED    TIMESTAMP              NOT NULL,
        EXPIRY_TIME     TIMESTAMP              NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        );
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE (
        ID             INTEGER AUTO_INCREMENT NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        CREATE TABLE IF NOT EXISTS IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER AUTO_INCREMENT NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        );
        ```
    
        ```tab="Oracle"
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER,
        RESOURCE_ID         VARCHAR2(255),
        RESOURCE_NAME       VARCHAR2(255),
        TIME_CREATED        TIMESTAMP              NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR2(255),
        CLIENT_ID           VARCHAR2(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR2(50),
        PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_TRIG
        BEFORE INSERT
        ON IDN_UMA_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID)
        /
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN)
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR2(40),
        PROPERTY_VALUE    VARCHAR2(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_METADATA_TRIG
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_META_DATA
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_RESOURCE_META_DATA_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR2(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_SCOPE_TRIG
        BEFORE INSERT
        ON IDN_UMA_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME)
        /
        
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER,
        PT              VARCHAR2(255)           NOT NULL,
        TIME_CREATED    TIMESTAMP              NOT NULL,
        EXPIRY_TIME     TIMESTAMP              NOT NULL,
        TICKET_STATE    VARCHAR2(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_PERMISSION_TICKET_TRIG
        BEFORE INSERT
        ON IDN_UMA_PERMISSION_TICKET
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_PERMISSION_TICKET_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT)
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_TRIG
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_PT_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        )
        /
        
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
        /
        
        CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_SCOPE_TRIG
        BEFORE INSERT
        ON IDN_UMA_PT_RESOURCE_SCOPE
        REFERENCING NEW AS NEW
        FOR EACH ROW
        BEGIN
        SELECT IDN_UMA_PT_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
        END;
        /
        ```
    
        ```tab="PostgreSQL"
        DROP TABLE IF EXISTS IDN_UMA_RESOURCE;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE (
        ID                  INTEGER DEFAULT NEXTVAL('IDN_UMA_RESOURCE_SEQ') NOT NULL,
        RESOURCE_ID         VARCHAR(255),
        RESOURCE_NAME       VARCHAR(255),
        TIME_CREATED        TIMESTAMP                                   NOT NULL,
        RESOURCE_OWNER_NAME VARCHAR(255),
        CLIENT_ID           VARCHAR(255),
        TENANT_ID           INTEGER DEFAULT -1234,
        USER_DOMAIN         VARCHAR(50),
        PRIMARY KEY (ID)
        );
        
        DROP INDEX IF EXISTS IDX_RID;
        
        CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID);
        
        DROP INDEX IF EXISTS IDX_USER;
        
        CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN);
        
        DROP TABLE IF EXISTS IDN_UMA_RESOURCE_META_DATA;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_META_DATA_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
        ID                INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_META_DATA_SEQ') NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        PROPERTY_KEY      VARCHAR(40),
        PROPERTY_VALUE    VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        DROP TABLE IF EXISTS IDN_UMA_RESOURCE_SCOPE;
        DROP SEQUENCE IF EXISTS IDN_UMA_RESOURCE_SCOPE_SEQ;
        CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ;
        CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
        ID                INTEGER DEFAULT NEXTVAL ('IDN_UMA_RESOURCE_SCOPE_SEQ') NOT NULL,
        RESOURCE_IDENTITY INTEGER                NOT NULL,
        SCOPE_NAME        VARCHAR(255),
        PRIMARY KEY (ID),
        FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        DROP INDEX IF EXISTS IDX_RS;
        
        CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME);
        
        DROP TABLE IF EXISTS IDN_UMA_PERMISSION_TICKET;
        DROP SEQUENCE IF EXISTS IDN_UMA_PERMISSION_TICKET_SEQ;
        CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ;
        CREATE TABLE IDN_UMA_PERMISSION_TICKET (
        ID              INTEGER DEFAULT NEXTVAL('IDN_UMA_PERMISSION_TICKET_SEQ') NOT NULL,
        PT              VARCHAR(255)                                         NOT NULL,
        TIME_CREATED    TIMESTAMP                                            NOT NULL,
        EXPIRY_TIME     TIMESTAMP                                            NOT NULL,
        TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
        TENANT_ID       INTEGER     DEFAULT -1234,
        PRIMARY KEY (ID)
        );
        
        DROP INDEX IF EXISTS IDX_PT;
        
        CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT);
        
        DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE;
        DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SEQ;
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ;
        CREATE TABLE IDN_UMA_PT_RESOURCE (
        ID             INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SEQ') NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_ID          INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
        );
        
        DROP TABLE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE;
        DROP SEQUENCE IF EXISTS IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
        CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ;
        CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
        ID             INTEGER DEFAULT NEXTVAL ('IDN_UMA_PT_RESOURCE_SCOPE_SEQ') NOT NULL,
        PT_RESOURCE_ID INTEGER                NOT NULL,
        PT_SCOPE_ID    INTEGER                NOT NULL,
        PRIMARY KEY (ID),
        FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
        FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
        );
        ```

4.  Download the identity component migration resources and unzip it in a local directory.

    Navigate to the [latest release tag](https://github.com/wso2-extensions/apim-identity-migration-resources/releases) and download the `wso2is-migration-x.x.x.zip` under **Assets**.

    Let's refer to this directory that you downloaded and extracted as `<IS_MIGRATION_TOOL_HOME>`.

5.  Copy the `migration-resources` folder from the extracted folder to the `<IS_HOME>` directory.

6.  Open the `migration-config.yaml` file in the migration-resources directory and make sure that the `currentVersion` element is set to 5.7.0, as shown below.

    ``` java
    migrationEnable: "true"
    currentVersion: "5.7.0"
    migrateVersion: "5.11.0"
    ```
7. Remove the following 2 steps from  migration-config.yaml which is included under version: "5.10.0"

    ```
    - version: "5.10.0"
        migratorConfigs:
        -
            name: "MigrationValidator"
            order: 2
        -
            name: "SchemaMigrator"
            order: 5
            parameters:
            location: "step2"
            schema: "identity"
        -
            name: "TenantPortalMigrator"
            order: 11
    ```

8. Remove the following 2 steps from  migration-config.yaml which is included under version: "5.11.0"

    ```
    -
        name: "EncryptionAdminFlowMigrator"
        order: 1
        parameters:
           currentEncryptionAlgorithm: "RSA/ECB/OAEPwithSHA1andMGF1Padding"
           migratedEncryptionAlgorithm: "AES/GCM/NoPadding"
           schema: "identity"
    -
        name: "EncryptionUserFlowMigrator"
        order: 2
        parameters:
           currentEncryptionAlgorithm: "RSA/ECB/OAEPwithSHA1andMGF1Padding"
           migratedEncryptionAlgorithm: "AES/GCM/NoPadding"
           schema: "identity"
    ```

9.  Copy the `org.wso2.carbon.is.migration-x.x.x.jar` from the `<IS_MIGRATION_TOOL_HOME>/dropins` directory to the `<IS_HOME>/repository/components/dropins` directory.

10. Add below configuration  to `<IS_HOME>/repository/conf/deployment.toml` to disable group role separation.

     ```
     [authorization_manager.properties]
     GroupAndRoleSeparationEnabled = false
     ```

11.  Start WSO2 IS 5.11.0 as follows to carry out the complete Identity component migration.

    ```tab="Linux / Mac OS"
    sh wso2server.sh -Dmigrate -Dcomponent=identity
    ```

    ```tab="Windows"
    wso2server.bat -Dmigrate -Dcomponent=identity
    ```

    !!! warning

        Depending on the number of records in the identity tables, this identity component migration will take a considerable amount of time to finish. Do **NOT** stop the server during the migration process and please wait until the migration process finish completely and server get started.

12. After you have successfully completed the migration, stop the server and remove the following files and folders.

    -   Remove the `org.wso2.carbon.is.migration-x.x.x.jar` file, which is in the `<IS_HOME>/repository/components/dropins` directory.

    -   Remove the migration-resources directory, which is in the `<IS_HOME>` directory.

    -   Remove the below configuration from `<IS_HOME>/repository/conf/deployment.toml`
         ```
         [authorization_manager.properties]
         GroupAndRoleSeparationEnabled = false
         ```

    -   If you ran WSO2 IS as a Windows Service when doing the IS migration , then you need to remove the following parameters in the command line arguments section (CMD_LINE_ARGS) of the `wso2server.bat` file.
        ```
        -Dmigrate -Dcomponent=identity        
        ```
              
## Step 2 - Upgrade API Manager 2.6.0 to 4.1.0

Follow the steps mentioned in [Upgrading API-M from 2.6.0 to 4.1.0]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-260-to-410/) to upgrade your API-M environment from 2.6.0 to 4.1.0.

!!! important

    -   When following guidelines under [Step 1 - Migrate the API Manager configurations]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/upgrading-from-260-to-410/#step-1-migrate-the-api-manager-configurations), make sure to add
    the following to the `<API-M_HOME>/repository/conf/deployment.toml`. This is to configure your IS 5.11.0 as the **Resident Key Manager** of your API-M 4.1.0 deployment.
        ```
        [apim.key_manager]
        service_url = "https://<IS_5.11.0_HOST_NAME>:<PORT>/services/"
        type = "WSO2-IS"
        ```

        -  Do NOT copy anyother Key Manager specific configurations coming from previous API-M version to the latest pointing to the IS instance.

    -   **SKIP** guidelines under [Step 3 - Migrate the Identity Components]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/260-to-410/upgrading-from-260-to-410/#step-3-migrate-the-identity-components)

         -   You have already done this in Step 3 of [Step A - Upgrade IS as Key Manager 5.7.0 to IS 5.11.0]({{base_path}}/install-and-setup/upgrading-wso2-is-as-key-manager/upgrading-from-is-570-to-is-5110/#upgrade-is-as-key-manager-570-to-is-5110).

    - After configuring WSO2 IS as the **Resident Key Manager** and before starting the API-M 4.1.0 server for the first time in **Step 6** under [Step 6 - Restart the WSO2 API-M 4.1.0 Server]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/260-to-410/upgrading-from-260-to-410/#step-6-restart-the-wso2-api-m-410-server), make sure you have already started WSO2 IS 5.11.0.

!!! info

    If you want to use the latest user store, please update both the `<IS_HOME>/repository/conf/deployment.toml` and `<API-M_HOME>/repository/conf/deployment.toml` as follows after the migration.
    ```
    [user_store]
    type = "database_unique_id"
    ```


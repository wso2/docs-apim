# Access Token Optimization with WSO2 IS as Key Manager

WSO2 API Manager (API-M) 4.0, from update level 363 onwards, introduces a feature to handle indirect token revocations when WSO2 Identity Server (IS) is configured as the Key Manager and JWT access token persistence is optimized.

## Overview

When using the [token persistence optimization](https://is.docs.wso2.com/en/5.11.0/setup/token-persistence/#optimizing-jwt-access-token-persistence) feature in WSO2 IS (available for WSO2 Identity Server 5.11.0 as of update level 410), the JWT access tokens are not stored in the database. Consequently, indirect token revocation events, such as user password changes, user disablement, or application credential revocations, are persisted in the Identity Server.

WSO2 API-M can now subscribe to these revocation events from the WSO2 IS. This allows the API Gateway to validate tokens against these indirect revocation events during API invocation, ensuring that access is denied for tokens that are no longer valid due to such changes.

## Prerequisites

Before enabling this feature, ensure you have the following setup:

1.  WSO2 IS Token Persistence Optimization: You must have the JWT access token persistence optimization enabled and configured in WSO2 IS as per the official documentation: [Optimizing JWT Access Token Persistence.](https://is.docs.wso2.com/en/5.11.0/setup/token-persistence/#optimizing-jwt-access-token-persistence)

2.  WSO2 IS as Key Manager: WSO2 IS must be configured as the Key Manager for your WSO2 API-M deployment. Follow the steps outlined in the documentation: [Configuring WSO2 Identity Server as a Key Manager.](../configuring-wso2-identity-server-as-a-key-manager.md). You will need WSO2 IS Connector version `1.2.10.27` or any newer version.

### Configuration Steps

Follow the steps below to enable the validation of indirect token revocation events in WSO2 API Manager.

### Step 1: Update the Database

You need to execute the following database scripts on the API Manager database (AM_DB).

??? Example "DB2"

    ```sql
    CREATE TABLE AM_APP_REVOKED_EVENT (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100)    NOT NULL,
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION))
    /

    CREATE TABLE AM_SUBJECT_ENTITY_REVOKED_EVENT (
        ENTITY_ID      VARCHAR(255)    NOT NULL,
        ENTITY_TYPE    VARCHAR(100)    NOT NULL,
        TIME_REVOKED   TIMESTAMP       NOT NULL,
        ORGANIZATION   VARCHAR(100)    NOT NULL,
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION))
    /
    ```

??? Example "H2"

    ```sql
    CREATE TABLE IF NOT EXISTS AM_APP_REVOKED_EVENT (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION)
    );

    CREATE TABLE IF NOT EXISTS AM_SUBJECT_ENTITY_REVOKED_EVENT (
        ENTITY_ID       VARCHAR(255)    NOT NULL,
        ENTITY_TYPE     VARCHAR(100)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION)
    );
    ```

??? Example "MSSQL"

    ```sql

    IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_APP_REVOKED_EVENT]') AND TYPE IN (N'U'))
    CREATE TABLE AM_APP_REVOKED_EVENT (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    DATETIME        NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION)
    );

    IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[AM_SUBJECT_ENTITY_REVOKED_EVENT]') AND TYPE IN (N'U'))
    CREATE TABLE AM_SUBJECT_ENTITY_REVOKED_EVENT (
        ENTITY_ID       VARCHAR(255)    NOT NULL,
        ENTITY_TYPE     VARCHAR(100)    NOT NULL,
        TIME_REVOKED    DATETIME        NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION)
    );
    ```

??? Example "MySQL"

    ```sql
    CREATE TABLE IF NOT EXISTS AM_APP_REVOKED_EVENT (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION)
    )ENGINE INNODB;

    CREATE TABLE IF NOT EXISTS AM_SUBJECT_ENTITY_REVOKED_EVENT (
        ENTITY_ID       VARCHAR(255)    NOT NULL,
        ENTITY_TYPE     VARCHAR(100)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION)
    )ENGINE INNODB;
    ```

??? Example "MySQL-Cluster"

    ```sql
    CREATE TABLE IF NOT EXISTS AM_APP_REVOKED_EVENT (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION)
    )ENGINE=NDB;

    CREATE TABLE IF NOT EXISTS AM_SUBJECT_ENTITY_REVOKED_EVENT (
        ENTITY_ID       VARCHAR(255)    NOT NULL,
        ENTITY_TYPE     VARCHAR(100)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION)
    )ENGINE=NDB;       
    ```

??? Example "Oracle"

    ```sql
    CREATE TABLE AM_APP_REVOKED_EVENT
    (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION)
    )
    /

    CREATE TABLE AM_SUBJECT_ENTITY_REVOKED_EVENT
    (
        ENTITY_ID       VARCHAR(255)    NOT NULL,
        ENTITY_TYPE     VARCHAR(100)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION)
    )
    /

    ```

??? Example "Oracle RAC"

    ```sql
    CREATE TABLE AM_APP_REVOKED_EVENT
    (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION)
    )
    /
    CREATE TABLE AM_SUBJECT_ENTITY_REVOKED_EVENT
    (
        ENTITY_ID       VARCHAR(255)    NOT NULL,
        ENTITY_TYPE     VARCHAR(100)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION)
    )
    /
    ```

??? Example "PostgreSQL"

    ```sql
    CREATE TABLE IF NOT EXISTS AM_APP_REVOKED_EVENT (
        CONSUMER_KEY    VARCHAR(255)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (CONSUMER_KEY, ORGANIZATION)
    );

    CREATE TABLE IF NOT EXISTS AM_SUBJECT_ENTITY_REVOKED_EVENT (
        ENTITY_ID      VARCHAR(255)    NOT NULL,
        ENTITY_TYPE VARCHAR(100)    NOT NULL,
        TIME_REVOKED    TIMESTAMP       NOT NULL,
        ORGANIZATION    VARCHAR(100),
        PRIMARY KEY (ENTITY_ID, ENTITY_TYPE, ORGANIZATION)
    );       
    ```

### Step 2: Enable Revoked Token Event Validation

To enable this feature, you need to add the following configuration to the deployment.toml file of your WSO2 API Manager instance. Refer [Configuration Catalog](../reference/config-catalog/#jwt-token-persistence-optimization-configurations)

``` toml
[apim.key_manager]
enable_revoked_token_event_validation = true
```

In a distributed WSO2 API Manager deployment, this configuration should be added to the deployment.toml file of the API Gateway node(s).

### Step 3: Restart the Server

After applying the database scripts and the configuration changes, restart the WSO2 API Manager server (or the Gateway nodes in a distributed setup) for the changes to take effect.

Once restarted, the API Gateway will start validating access tokens against the indirect revocation events published by the WSO2 Identity Server, enhancing the security and control over your APIs.
# Upgrade WSO2 API Manager

This document walks you through the process of upgrading WSO2 API Manager. 

## Why upgrade?

There are multiple reasons why you would want to upgrade the WSO2 product to the latest version. These reasons include but are not limited to the following.  

- The current product version you are using is reaching its end of life. To see if this is the case, view the [support matrix documentation](https://wso2.com/products/support-matrix/). 
- You want to leverage the new features of the latest version of the product.
- The version of the product you have does not have certain security and bug fixes that you require.

## What has changed

Over the course of its lifetime, WSO2 API Manager has changed significantly and some of the features you were using in an older version may not work the same way.

To learn what's new in the WSO2 API Manager 4.2.0 release, see the [About this Release page]({{base_path}}/get-started/about-this-release/).

## Migration configuration for separate databases

If you are using separate User Management (UM) and Registry (REG) databases in your current deployment, you need to configure the migration client properly to handle this setup.

### Configuring isSeparateRegistryDB parameter

When the migration client is configured to handle separate UM and REG databases, the `isSeparateRegistryDB` property in the `migration-config.yaml` file must be set to `true` to ensure that registry-related queries are executed on the correct REG database.

```yaml
# migration-config.yaml
isSeparateRegistryDB: true
```

This configuration is essential when:

- Your current API Manager deployment uses separate databases for User Management and Registry data
- You are migrating from an earlier version where UM_DB and REG_DB are configured as separate databases
- You want to ensure registry-related migration queries target the correct database during the migration process

!!! warning
    If you have separate UM and REG databases but do not set `isSeparateRegistryDB` to `true`, the migration may encounter issues or data inconsistencies. Always verify your database configuration before starting the migration process.

## Get started

To make sure that the upgrade process is smooth and you have the best experience, WSO2 recommends that you reach out to WSO2 Support in order to upgrade WSO2 API Manager with minimal difficulty.

If you are ready to start the upgrading process, follow the instructions given below.

- If you already have a WSO2 subscription, create a support ticket with your migration requirements and one of our support engineers will get in touch with you.

    [Create a ticket](https://support.wso2.com/support)

- If you are not a WSO2 customer and still need migration assistance and resources, please contact us through the following link. One of our Account Managers will get in touch with you to help.

    [Contact us](https://wso2.com/contact/)
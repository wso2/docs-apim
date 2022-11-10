# Upgrading WSO2 API Manager

This document walks you through the process of upgrading WSO2 API Manager. 

## Why upgrade?

There are multiple reasons why you would want to upgrade the WSO2 product to the latest version. These reasons include but are not limited to the following.  

- The current product version you are using is reaching its end of life. To see if this is the case, view the [support matrix documentation](https://wso2.com/products/support-matrix/). 
- You want to leverage the new features of the latest version of the product.
- The version of the product you have does not have certain security and bug fixes that you require.

## What has changed

Over the course of its lifetime, WSO2 API Manager has changed significantly and some of the features you were using in an older version may not work the same way. This section summarizes the key changes that have taken place in each version of WSO2 API Manager.

For more details on the API-M 4.1.0 release, see the [About this Release page]({{base_path}}/get-started/about-this-release/).

## Upgrading process information

This section contains information on the upgrading process that WSO2 API Manager follows. Go through the information available before reaching out to us.

A less successful upgrading process can result in errors, missing data, breaks in existing functionality, and unwanted downtime. So it is important to get this done correctly. 

To make sure that the upgrade process is smooth and you have the best experience, WSO2 recommends that you reach out to WSO2 Support in order to upgrade WSO2 API Manager with minimal difficulty.

- Ideally you would want to upgrade your product with zero downtime. To achieve this, you must contact WSO2 Support. WSO2 does not recommend proceeding with a zero downtime upgrade without WSO2 Support. You can also get the migration resources from WSO2 Support in order to upgrade the product.

- Always upgrade to the [latest version](https://wso2.com/api-management/) as the latest fixes and new features are available in the latest version. 

- Migrating the production environment requires additional hardware/VM resources because both the old environment and the new environment will be running until all the traffic is routed to the new environment.

- Understand how the target version differs from the source version and its impact on your setup. For example, some of the product profiles that you currently use may not be available with the latest version.

- Before you start the upgrade process, check the [compatibility matrix]({{base_path}}/install-and-setup/setup/reference/product-compatibility/) of the target version to get information on operating systems, JDKs, and DBMSs that the target version has been tested with.

- You need to take backups of the existing databases used by the current WSO2 API Manager server. This backup is necessary in case the migration causes any issues in the existing database.

   !!! important
       Check on the [Tested DBMS]({{base_path}}/install-and-setup/setup/reference/product-compatibility/#tested-dbmss) for API-M 4.1.0. Only those versions will be supported in migration as well. Therefore, if you are currently on an older database version, you may need to first upgrade your database to the supported version before proceeding with the migration.

- If you have customizations in your setup, they may not be supported by default in the latest version.

- List down the functional and non-functional use cases in your deployment. You may need to create test cases for them as part of the upgrade process. This is useful to verify that the upgraded environment works as expected.    

- It is possible that there will be configuration migrations required for the new setup. For more information on the new configuration model introduced, see the [Configuration Catalog]({{base_path}}/reference/config-catalog).

- When you follow the above instructions, you can get a rough estimate of the time for the final production update, and you can allocate time slots based on the above analysis. WSO2 recommends that you perform the upgrade when the system is under minimum traffic.

- After the migration is complete, verify the migration process using the following instructions.
  
    - Monitor the system health (CPU, memory usage, etc.).
    - Monitor the WSO2 logs for errors.

## Get started

If you are ready to start the upgrading process, follow the instructions given below.

- If you already have a WSO2 subscription, create a support ticket with your migration requirements and one of our support engineers will get in touch with you.

    [Create a ticket](https://support.wso2.com/jira/secure/Dashboard.jspa)

- Even if you don’t have a WSO2 subscription, you can reach out to us and we will get in touch with you. 

    [Contact us](https://wso2.com/contact/)

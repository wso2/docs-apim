# Database Upgrade Guide

This page takes you through the general steps for upgrading product versions based on Carbon 4.4.6 to Carbon 4.4.7.

### Preparing to Upgrade

The following are the specific prerequisites you must complete before an upgrade:

-   Before you upgrade to the latest version of a product, you create a staging database, which is essentially an empty database. Note that you should NOT connect a new product version to an older database that has not been upgraded.

-   Make a backup of the database and the `<PRODUCT_HOME>` directory prior to upgrading. The `<PRODUCT_HOME>` directory can simply be copied to the new directory.

-   Stop all the Carbon servers connected to the database before running the migration scripts.

        !!! note
    Note that the upgrade should be done during a period when there is low traffic on the system.


#### Limitations

-   This upgrade can only be done if the database type is the same. For example, if you are using MySQL currently and you need to migrate to Oracle in the new version, these scripts will not work.
-   You cannot roll back an upgrade. It is impossible to restore a backup of the previous server and retry the upgrade process.

#### Downtime

The downtime is limited to the time taken for switching databases when the staging database is promoted to the actual production status.

### Upgrading the configurations

There are no database changes between Carbon 4.4.6 to Carbon 4.4.7. Therefore, only the new configuration options in Carbon 4.4.7 should be updated for the new environment as explained below.

1.  Copy the data from the old database to the staging database you created. This becomes the new database for your new version of Carbon.
2.  Download Carbon 4.4.7 and connect it to your staging database.

3.  Update the configuration files in Carbon 4.4.7 as required.

4.  Copy the following directories from the old database to the staging database.

    1.  To migrate the super tenant settings, copy the `<PRODUCT_HOME>/repository/deployment/server` directory.
    2.  If multitenancy is used, copy the `<PRODUCT_HOME>/repository/tenants` directory.

        !!! note
    Note that configurations should not be copied directly between servers.


5.  Start the server.

### Going into production

The following are recommended tests to run on the staging system.

-   Create multiple user stores and try adding users to different user stores.

-   Create multiple tenants and add different user stores to the different tenants. Thereafter, add users to the various user stores.

Once the above tests are run successfully, it is safe to consider that the upgrade is ready for production. However, it is advised to test any features that are being used in production.

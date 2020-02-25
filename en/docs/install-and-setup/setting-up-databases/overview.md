# Working with Databases

WSO2 API Manager is shipped with an H2 database for storing data. These default databases are located in the `<API-M_HOME>/repository/database` directory of the product pack.

### Default databases

Explained below are the default databases that you will find in the `database` directory.

-   **AM database** :`WSO2AM_DB.mv.db` WSO2 API Manager has this database keeping its specific API-M related data.
-   **Shared database** :`WSO2SHARED_DB.mv.db` This database contains the registry and user management data.
-   **Carbon database:** `WSO2CARBON_DB.mv.db` This database has the internal data related to the product. This data is stored in the embedded H2 database.
-   **Metrics database:** `WSO2METRICS_DB.mv.db` This database has the metrics monitoring data. This data is stored in the embedded H2 database.
-   **MB database:** `WSO2MB_DB.mv.db` This database has the message brokering data.

!!! Warning
    **Do not share** `WSO2MB_DB` among the nodes in an **Active-Active set-up** or **Traffic Manager HA** scenario, because each node should have its own local `WSO2_MB_STORE_DB` database to act as separate Traffic Managers.

Following image shows the default databases and the data that are stored in each database.

<a href="{{base_path}}/assets/img/setup-and-install/working-with-dbs-overview.png" ><img src="{{base_path}}/assets/img/setup-and-install/working-with-dbs-overview.png" alt="Data bases" title="Data bases" width="100%" /></a>

### Changing the default databases

The embedded H2 databases shipped with your product are suitable for suitable for development and testing environments. However, for **production environments,** it is recommended to use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, MS SQL, etc.

WSO2 products are shipped with scripts for creating the required tables in all the required databases: The scripts for creating tables for apim, user
management and registry data are stored in the `<API-M_HOME>/dbscripts` folder.

**Changing the default database:** You simply have to set up new physical databases, point the product server to the new databases by updating the relevant configuration files, and create the required tables using the scripts provided in the product pack. See the following topics for instructions:

-   [Changing to MySQL](changing-default-databases/changing-to-mysql.md)
-   [Changing to Oracle](changing-default-databases/changing-to-oracle.md)
-   [Changing to MSSQL](changing-default-databases/changing-to-mssql.md)
-   [Changing to Oracle RAC](changing-default-databases/changing-to-oracle-rac.md)
-   [Changing to PostgreSQL](changing-default-databases/changing-to-postgresql.md)
-   [Changing to IBM DB2](changing-default-databases/changing-to-ibm-db2.md)
-   [Changing to MariaDB](changing-default-databases/changing-to-mariadb.md)
-   [Changing to Remote H2](changing-default-databases/changing-to-remote-h2.md)

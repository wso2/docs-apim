# Working with Databases

WSO2 API Manager is shipped with an H2 database for storing data. These default databases are located in the `<API-M_HOME>/repository/database` directory of the product pack.

## Default databases

Explained below are the default databases which will be used within API Manager.

-   **AM database** :`WSO2AM_DB.mv.db` WSO2 API Manager has this database keeping its specific API-M related data.
-   **Shared database** :`WSO2SHARED_DB.mv.db` This database contains the registry and user management data.
-   **Carbon database:** `WSO2CARBON_DB.mv.db` This database has the internal data related to the product. This data is stored in the embedded H2 database.

The following image shows the default databases and the data that are stored in each database.

<a href="{{base_path}}/assets/img/setup-and-install/working-with-dbs-overview.png" ><img src="{{base_path}}/assets/img/setup-and-install/working-with-dbs-overview.png" alt="Data bases" title="Data bases" width="100%" /></a>

## Databases used by API-M profiles

When you run the API-M runtime as separate [profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/understanding-the-distributed-deployment-of-wso2-api-m/), the databases are used as shown below.

<table>
<thead>
<tr class="header">
<th><br />
</th>
<th><p><strong>API Manager<br />
database</strong></p>
<p><code>              apimgtdb             </code></p>
<p><code>              WSO2_AM_DB             </code></p></th>
<th><p><strong>Shared Database</strong></p>
<p><code>                                            shareddb                           </code></p>
<p><code>              WSO2_SHARED_DB             </code></p></th>

</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><strong>Control Plane profile</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
</tr>
<tr class="even">
<td><p><strong>Gateway profile</strong></p></td>
<td><p>Not used</p></td>
<td><p>Used (in multi-tenancy mode/ in multiple gateway mode when Google Analytics is used)</p></td>

</tr>
<tr class="odd">
<td><strong>Traffic Manager profile</strong></td>
<td>Used</td>
<td>Used</td>

</tr>
</tbody>
</table>

## Changing the default databases

The embedded H2 databases shipped with your product are suitable for development and testing environments. However, for **production environments,** it is recommended to use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, MS SQL, etc.

WSO2 products are shipped with scripts for creating the required tables in all the required databases: The scripts for creating tables for API-M, user management, and registry data are stored in the `<API-M_HOME>/dbscripts` directory.

**Changing the default database:** You simply have to set up new physical databases, point the product server to the new databases by updating the relevant configuration files, and create the required tables using the scripts provided in the product pack. See the following topics for instructions:

-   [Changing to MySQL]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-mysql)
-   [Changing to Oracle]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-oracle)
-   [Changing to MSSQL]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-mssql)
-   [Changing to Oracle RAC]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-oracle-rac)
-   [Changing to PostgreSQL]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-postgresql)
-   [Changing to IBM DB2]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-ibm-db2)
-   [Changing to MariaDB]({{base_path}}/install-and-setup/setting-up-databases/changing-default-databases/changing-to-mariadb)

!!! Note

    - To enable the default H2 database, add the below configurations to deployment.toml file in <APIM_HOME>/repository/conf and restart the server.
          ```toml
          [database_configuration]
          enable_h2_console = true
          ```
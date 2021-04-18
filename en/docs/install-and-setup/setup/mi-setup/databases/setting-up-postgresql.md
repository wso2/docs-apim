# Setting up a PostgreSQL Database

Follow the steps given below to set up the required Postgre databases for your Micro Integrator.

!!! Tip
	WSO2 Micro Integrator requires databases for the following scenarios:

	-	<a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei#cluster-coordination'>cluster coordination</a>
    -	<a href='{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore'>using an RDBMS user store</a>
    -	<a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_checklist#monitoring-transaction-counts'>monitoring transaction counts</a>.

## Setting up the database and login role

The following Postgre scripts are stored in the `<MI_HOME>/dbscripts/postgres` directory of your Micro Integrator. First, select the scripts that are required for your deployment.

You can run the scripts on one database instance or set up separate instances for each requirement. For convenience, it is recommended to set up separate databases for each use case.

<table>
	<tr>
		<th>Script</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>postgresql_cluster.sql</td>
		<td>This script creates the database tables that are required for <a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei/#cluster-coordination'>cluster coordination</a> (i.e., coordinating the server nodes in your VM deployment). This is only applicable if you have stateful integration artifacts deployed in a clustered setup.
		</td>
	</tr>
	<tr>
		<td>postgresql_user.sql</td>
		<td>This script creates the database tables that are required for storing users and roles. This is only required if you have configured an <a href='{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore'>RDBMS user store</a>.</td>
	</tr>
	<tr>
		<td>postgresql_transaction_count.sql</td>
		<td>This script creates the database tables that are required for storing the transaction counts. This is only required if you want to <a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_checklist/#monitoring-transaction-counts'>monitor transaction counts</a> in your deployment.</td>
	</tr>
</table>

Create the databases and then create the DB tables by pointing to the relevant script in the `<MI_HOME>/dbscripts/postgres` directory.

1.  Install PostgreSQL on your computer as follows:  
2.  Start the PostgreSQL service using the following command:  
3.  Create a database and the login role from a GUI using the
4.  To connect PGAdminIII to a PostgreSQL database server, locate the
    server from the object browser, right-click the client and click
    **Connect** . This will show you the databases, tablespaces, and
    login roles as follows:  
5.  To create a database, click **Databases** in the tree (inside the
    object browser), and click **New Database** .
6.  In the **New Database** dialog box, give a name to the database,
    e.g., gregdb and click **OK** .
7.  To create a login role, click **Login Roles** in the tree (inside
    the object browser), and click **New Login Role** . Enter the role
    name and a password.

    These values will be used in the product configurations as described
        in the following sections. In the sample configuration,
        `           dbadmin          ` will be used as both the role name
        and the password.

8.  Optionally, enter other policies, such as the expiration time for
    the login and the connection limit.
9.  Click **OK** to finish creating the login role.

## Setting up the drivers

1.  Download the [PostgreSQL JDBC4 driver](http://jdbc.postgresql.org/download.html).
2.  Copy the driver to the `MI_HOME/lib` directory.    

## Connecting the database to the server

Open the `deployment.toml` file in the `<MI_HOME>/conf` directory and add the following sections to create the connection between the Micro Integrator and the relevant database. Note that you need separate configurations corresponding to the separate databases (`clusterdb`, `userdb`, and `transactiondb`).

```toml tab='Cluster DB Connection'
[[datasource]]
id = "WSO2_COORDINATION_DB"
url= "jdbc:postgresql://localhost:5432/clusterdb"
username="root"
password="root"
driver="org.postgresql.Driver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true
```

```toml tab='User DB Connection'
[[datasource]]
id = "WSO2CarbonDB"
url= "jdbc:postgresql://localhost:5432/userdb"
username="root"
password="root"
driver="org.postgresql.Driver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true
```

```toml tab='Transaction Counter DB Connection'
[[datasource]]
id = "WSO2_TRANSACTION_DB"
url= "jdbc:postgresql://localhost:5432/transactiondb"
username="root"
password="root"
driver="org.postgresql.Driver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true
[transaction_counter]
enable = true
data_source = "WSO2_TRANSACTION_DB"
update_interval = 2
```

{!includes/integration/pull-content-user-store-db-id.md!}

See the descriptions of [database connection parameters]({{base_path}}/reference/config-catalog-mi/#database-connection).
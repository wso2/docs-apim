# Setting up an Oracle Database

Follow the steps given below to set up the required Oracle databases for your Micro Integrator.

!!! Tip
    WSO2 Micro Integrator requires databases for the following scenarios:

    -	<a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei#cluster-coordination'>cluster coordination</a>
    -	<a href='{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore'>using an RDBMS user store</a>
    -	<a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_checklist#monitoring-transaction-counts'>monitoring transaction counts</a>.

## Setting up the database and users

The following Oracle scripts are stored in the `<MI_HOME>/dbscripts/oracle` directory of your Micro Integrator. First, select the scripts that are required for your deployment.

You can run the scripts on one database instance or set up separate instances for each requirement. For convenience, it is recommended to set up separate databases for each use case.

<table>
	<tr>
		<th>Script</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>oracle_cluster.sql</td>
		<td>This script creates the database tables that are required for <a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei/#cluster-coordination'>cluster coordination</a> (i.e., coordinating the server nodes in your VM deployment). This is only applicable if you have stateful integration artifacts deployed in a clustered setup.
        </td>
	</tr>
	<tr>
		<td>oracle_user.sql</td>
		<td>This script creates the database tables that are required for storing users and roles. This is only required if you have configured an <a href='{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore'>RDBMS user store</a>.</td>
	</tr>
	<tr>
		<td>oracle_transaction_count.sql</td>
		<td>This script creates the database tables that are required for storing the transaction counts. This is only required if you want to <a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_checklist/#monitoring-transaction-counts'>monitor transaction counts</a> in your deployment.</td>
	</tr>
</table>

Create the databases and then create the DB tables by pointing to the relevant script in the `<MI_HOME>/dbscripts/oracle` directory.

Follow the steps below to set up an Oracle database.

1.  Create a new database by using the Oracle database configuration
    assistant (dbca) or manually.
2.  Make the necessary changes in the Oracle
    `           tnsnames.ora          ` and
    `           listner.ora          ` files in order to define
    addresses of the databases for establishing connections to the newly
    created database.
3.  After configuring the `           .ora          ` files, start the
    Oracle instance using the following command:

     ```
     sudo /etc/init.d/oracle-xe restart
     ```

4.  Connect to Oracle using SQL\*Plus as SYSDBA as follows:

    ```
    ./$<ORACLE_HOME>/config/scripts/sqlplus.sh sysadm/password as SYSDBA
    ```

5.  Connect to the instance with the username and password using the
    following command:

    ```
    connect
    ```

6.  As SYSDBA, create a database user and grant privileges to the user
    as shown below:

    ```bash
    Create user <USER_NAME> identified by <PASSWORD> account unlock;
    grant connect to <USER_NAME>;
    grant create session, create table, create sequence, create trigger to <USER_NAME>;
    alter user <USER_NAME> quota <SPACE_QUOTA_SIZE_IN_MEGABYTES> on '<TABLE_SPACE_NAME>';
    commit;
    ```

7.  Exit from the SQL\*Plus session by executing the `quit` command.

## Setting up the JDBC driver

1.  Copy the Oracle JDBC libraries (for example, \<
    `ORACLE_HOME/jdbc/lib/ojdbc14.jar)` to the `MI_HOME/lib/`
    directory.
2.  Remove the old database driver from the
    `MI_HOME/repository/components/dropins/         `
    directory.

!!! Tip
    If you get a "`timezone region not found"` error when using the `ojdbc6.jar` file with the Micro Integrator, set the Java property as follows: `export JAVA_OPTS="-Duser.timezone='+05:30'"` the value of this property should be the GMT difference of the country. If it is necessary to set this property permanently, define it inside the `micro-integrator.sh        ` as a new `JAVA_OPT` property.

## Connecting the database to the server

Open the `deployment.toml` file in the `<MI_HOME>/conf` directory and add the following sections to create the connection between the Micro Integrator and the relevant database. Note that you need separate configurations corresponding to the separate databases (`clusterdb`, `userdb`, and `transactiondb`).

```toml tab='Cluster DB Connection'
[[datasource]]
id = "WSO2_COORDINATION_DB"
url= "jdbc:oracle:thin:@SERVER_NAME:PORT/SID"
username="root"
password="root"
driver="oracle.jdbc.OracleDriver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true
```

```toml tab='User DB Connection'
[[datasource]]
id = "WSO2CarbonDB"
url= "jdbc:oracle:thin:@SERVER_NAME:PORT/SID"
username="root"
password="root"
driver="oracle.jdbc.OracleDriver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true
```

```toml tab='Transaction Counter DB Connection'
[[datasource]]
id = "WSO2_TRANSACTION_DB"
url= "jdbc:oracle:thin:@SERVER_NAME:PORT/SID"
username="root"
password="root"
driver="oracle.jdbc.OracleDriver"
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
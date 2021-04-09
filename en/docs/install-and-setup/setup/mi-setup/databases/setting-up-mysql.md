# Setting up a MySQL Database

Follow the steps given below to set up the required MySQL databases for your Micro Integrator.

!!! Tip
	WSO2 Micro Integrator requires databases for the following scenarios: 

	-	<a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei#cluster-coordination'>cluster coordination</a>
    -	<a href='{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore'>using an RDBMS user store</a>
    -	<a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_checklist#monitoring-transaction-counts'>monitoring transaction counts</a>.

## Setting up a MySQL server

To set up MySQL:

1. Download and install [MySQL Server](http://dev.mysql.com/downloads/).
2. Execute the following command in a terminal/command where the username is the username you want to use to access the server:

	 ```bash
	 mysql -u username -p
	 ```

3. When prompted, specify the password to access the server with the username you specified.

## Creating the databases

The following MySQL scripts are stored in the `<MI_HOME>/dbscripts/mysql` directory of your Micro Integrator. First, select the scripts that are required for your deployment.

You can run the scripts on one database instance or set up separate instances for each requirement. For convenience, it is recommended to set up separate databases for each use case.

<table>
	<tr>
		<th>Script</th>
		<th>Description</th>
	</tr>
	<tr>
		<td>mysql_cluster.sql</td>
		<td>This script creates the database tables that are required for <a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deploying_wso2_ei/#cluster-coordination'>cluster coordination</a> (i.e., coordinating the server nodes in your VM deployment). This is only applicable if you have stateful integration artifacts deployed in a clustered setup.
		</td>
	</tr>
	<tr>
		<td>mysql_user.sql</td>
		<td>This script creates the database tables that are required for storing users and roles. This is only required if you have configured an <a href='{{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore'>RDBMS user store</a>.</td>
	</tr>
	<tr>
		<td>mysql_transaction_count.sql</td>
		<td>This script creates the database tables that are required for storing the transaction counts. This is only required if you want to <a href='{{base_path}}/install-and-setup/setup/mi-setup/deployment/deployment_checklist/#monitoring-transaction-counts'>monitor transaction counts</a> in your deployment.</td>
	</tr>
</table>

Create the databases and then create the DB tables by pointing to the relevant MySQL script in the `<MI_HOME>/dbscripts/mysql` directory.

```bash tab='Cluster Coordination DB'
mysql> create database clusterdb;
mysql> use clusterdb;
mysql> source <MI_HOME>/dbscripts/mysql/mysql_cluster.sql;
```

```bash tab='User Store DB'
mysql> create database userdb;
mysql> use userdb;
mysql> source <MI_HOME>/dbscripts/mysql/mysql_user.sql;
```

```bash tab='Transaction Counter DB'
mysql> create database transactiondb;
mysql> use transactiondb;
mysql> source <MI_HOME>/dbscripts/mysql/mysql_transaction_count.sql;
```

!!! Info
	**About using MySQL in different operating systems**

	-	For users of Microsoft Windows, when creating the database in MySQL, it is important to specify the character set as latin1. Failure to do this may result in an error (error code: 1709) when starting your cluster. This error occurs in certain versions of MySQL (5.6.x) and is related to the UTF-8 encoding. MySQL originally used the latin1 character set by default, which stored characters in a 2-byte sequence. However, in recent versions, MySQL defaults to UTF-8 to be friendlier to international users. Hence, you must use latin1 as the character set as indicated below in the database creation commands to avoid this problem. Note that this may result in issues with non-latin characters (like Hebrew, Japanese, etc.). The following is how your database creation command should look: `mysql> create database <DATABASE_NAME> character set latin1;`
	-	For users of other operating systems, the standard database creation commands will suffice. For these operating systems, the following is how your database creation command should look: `mysql> create database <DATABASE_NAME>;`

## Setting up the JDBC driver

1. Download the [MySQL JDBC driver](http://dev.mysql.com/downloads/connector/j/).
2. Unzip the downloaded MySQL driver and copy the JAR (mysql-connector-java-x.x.xx-bin.jar) to the `<MI_HOME>/lib/` directory of your Micro Integrator.

## Connecting the database to the server

Open the `deployment.toml` file in the `<MI_HOME>/conf` directory and add the following sections to create the connection between the Micro Integrator and the relevant database. Note that you need separate configurations corresponding to the separate databases (`clusterdb`, `userdb`, and `transactiondb`).

```toml tab='Cluster Coordination Connection'
[[datasource]]
id = "WSO2_COORDINATION_DB"
url= "jdbc:mysql://localhost:3306/clusterdb"
username="root"
password="root"
driver="com.mysql.jdbc.Driver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true
```

```toml tab='User Store DB Connection'
[[datasource]]
id = "WSO2CarbonDB"
url= "jdbc:mysql://localhost:3306/userdb"
username="root"
password="root"
driver="com.mysql.jdbc.Driver"
pool_options.maxActive=50
pool_options.maxWait = 60000
pool_options.testOnBorrow = true
```

```toml tab='Transaction Counter DB Connection'
[[datasource]]
id = "WSO2_TRANSACTION_DB"
url= "jdbc:mysql://localhost:3306/transactiondb"
username="root"
password="root"
driver="com.mysql.jdbc.Driver"
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
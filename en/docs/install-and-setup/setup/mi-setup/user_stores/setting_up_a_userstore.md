# Configuring a User Store

A user store is a repository that stores user credentials (user names and passwords).

## Users in the Micro Integrator

Find out about [user credentials in the Micro Integrator]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/managing_users/#users-credentials-in-the-mi).

## File-based user store (Default)

The default user store of the Micro Integrator is file-based. You can open the `deployment.toml` file and add new users to the file-based user store as shown below. You can [encrypt the plain text]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text) using **secure vault**.

```toml
[[internal_apis.users]]
user.name = "user-1"
user.password = "pwd-1"

[[internal_apis.users]]
user.name = "user-2"
user.password = "pwd-2"
``` 

The users in this store can only access the management API and related tools ([Micro Integrator dashboard]({{base_path}}/observe/mi-observe/working-with-monitoring-dashboard)/[API Controller]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller). That is, the file-based user store only supports user authentication for the management API. If you want to use **authentication for integration use cases** or **authorization**, you need an [LDAP](#configuring-an-ldap-user-store) or [RDBMS](#configuring-an-rdbms-user-store) user store.

## Disabling the file-based user store

To **disable** the file-based user store, add the following to the `deployment.toml` file.

```toml
[internal_apis.file_user_store]
enable = false
```

## Configuring an LDAP user store

!!! note "Before you begin"
	-	See the documentation of your LDAP provider for instructions on setting up the LDAP.
	-	[Disable the file-based user store](#disabling-the-file-based-user-store).

Follow the steps given below to connect the Micro Integrator to your LDAP user store.

1.	Open the `deployment.toml` file stored in the `<MI_HOME>/conf/` directory.
2.	Add the following configurations and update the required values.
	
	!!! Tip
		Note that the `[user_store]` section is enabled by default. Be sure to update the section without duplicating the `[user_store]` header.

	```toml
	[user_store]
	connection_url = "ldap://localhost:10389"  
	connection_name = "uid=admin,ou=system"
	connection_password = "admin"  
	user_search_base = "ou=Users,dc=wso2,dc=org"
	type = "read_only_ldap"
	```

	Parameters used above are explained below.

	<table>
		<tr>
			<th>Parameter</th>
			<th>Value</th>
		</tr>
		<tr>
			<td>
				<code>connection_url</code>
			</td>
			<td>
				The URL for connecting to the LDAP. If you are connecting over ldaps (secured LDAP), you need to import the certificate of the user store to the truststore (wso2truststore.jks by default). See the instructions on how to <a href="{{base_path}}/install-and-setup/setup/mi-setup/setup/security/importing_ssl_certificate">add certificates to the truststore</a>.
			</td>
		</tr>
		<tr>
			<td>
				<code>connection_name</code>
			</td>
			<td>
				The username used to connect to the user store and perform various operations. This user needs to be an administrator in the user store. That is, the user requires write permission to manage add, modify users and to perform search operations on the user store. The value you specify is used as the DN (Distinguish Name) attribute of the user who has sufficient permissions to perform operations on users and roles in LDAP.
			</td>
		</tr>
		<tr>
			<td>
				<code>connection_password</code>
			</td>
			<td>
				Password for the connection user name.
			</td>
		</tr>
		<tr>
			<td>
				<code>user_search_base</code>
			</td>
			<td>
				The DN of the context or object under which the user entries are stored in the user store. When the user store searches for users, it will start from this location of the directory.
			</td>
		</tr>
		<tr>
			<td>
				<code>type</code>
			</td>
			<td>
				Use one of the following values. </br></br>
				<b>read_only_ldap</b>: The LDAP connection does not provide write access.</br>
				<b>read_write_ldap</b>: The LDAP connection provides write access.
			</td>
		</tr>
	</table>

See the [complete list of parameters]({{base_path}}/reference/config-catalog-mi/#ldap-user-store) you can configure for the ldap user store.

## Configuring an RDBMS user store

!!! note "Before you begin"
	[Disable the file-based user store](#disabling-the-file-based-user-store).

If you are already using a JDBC user store (database) with another WSO2 product ([WSO2 API Manager](https://wso2.com/api-management/), [WSO2 Identity Server](https://wso2.com/identity-and-access-management/), or an instance of [WSO2 Enterprise Integrator 6.x.x](https://wso2.com/enterprise-integrator/6.6.0)), you can connect the same database to the Micro Integrator of EI 7.1. Alternatively, you can create a new RDBMS user store and connect it to the Micro Integrator.

1.	To set up a new RDBMS, select the preferred RDBMS type and follow the instructions. 

	!!! Tip
		If you already have an RDBMS user store set up, you can skip this step.

	- [Setting up a MySQL database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-mysql)
	- [Setting up an MSSQL database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-mssql)
	- [Setting up an Oracle database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-oracle)
	- [Setting up a Postgre database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-postgresql)
	- [Setting up an IBM database]({{base_path}}/install-and-setup/setup/mi-setup/databases/setting-up-ibm-db2)

2.	Be sure to add the JDBC driver to the `<MI_HOME>/lib` folder.
3.	To connect the Micro Integrator to your RDBMS user store: 

	1.	Open the `deployment.toml` file (stored in the `<MI_HOME>/conf` directory).
	2.	Add the relevant configurations for your RDBMS type.

		```toml tab='MySQL'
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

		```toml tab='MSSQL'
		[[datasource]]
		id = "WSO2CarbonDB"
		url= "jdbc:sqlserver://<IP>:1433;databaseName=userdb;SendStringParametersAsUnicode=false"
		username="root"
		password="root"
		driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
		pool_options.maxActive=50
		pool_options.maxWait = 60000
		pool_options.testOnBorrow = true
		```

		```toml tab='Oracle'
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

		```toml tab='PostgreSQL'
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

		```toml tab='IBM DB'
		[[datasource]]
		id = "WSO2CarbonDB"
		url="jdbc:db2://SERVER_NAME:PORT/userdb"
		username="root"
		password="root"
		driver="com.ibm.db2.jcc.DB2Driver"
		pool_options.maxActive=50
		pool_options.maxWait = 60000
		pool_options.testOnBorrow = true
		```

		Parameters used above are explained below.

		<table>
			<tr>
				<th>Parameter</th>
				<th>Value</th>
			</tr>
			<tr>
				<td>
					<code>id</code>
				</td>
				<td>
					The name given to the datasource. This is required to be <b>WSO2CarbonDB</b>.</br></br>
					<b>Note</b>: If you replace 'WSO2CarbonDB' with a different id, you also need to list the id as a datasource under the <code>[realm_manager]</code> section in the <code>deployment.toml</code> file as shown below.
					<div>
						<code>
						[realm_manager]</br>
						data_source = "new_id"
						</code>
					</div>
					Otherwise the user store database id defaults to 'WSO2CarbonDB' in the realm manager configurations.
				</td>
			</tr>
			<tr>
				<td>
					<code>url</code>
				</td>
				<td>
					The URL for connecting to the database. The type of database is determined by the URL string.</a>.
				</td>
			</tr>
			<tr>
				<td>
					<code>username</code>
				</td>
				<td>
					The username used to connect to the user store and perform various operations. This user needs to be an administrator in the user store. That is, the user requires write permission to manage add, modify users and to perform search operations on the user store.
				</td>
			</tr>
			<tr>
				<td>
					<code>password</code>
				</td>
				<td>
					Password for the connection user name.
				</td>
			</tr>
			<tr>
				<td>
					<code>driver</code>
				</td>
				<td>
					The driver class specific to the JDBC user store.
				</td>
			</tr>
		</table>
		
		See the complete list of [database connection parameters]({{base_path}}/reference/config-catalog-mi/#database-connection) and their descriptions. Also, see the recommendations for [tuning the JDBC connection pool]({{base_path}}/install-and-setup/setup/mi-setup/performance_tuning/jdbc_tuning).

	3.	Add the JDBC user store manager under the `[user_store]` toml heading as shown below.

		!!! Tip
			-	If you want to be able to modify the data in your user store, be sure to enable write access to the user store.
			-	Note that the `[user_store]` section is enabled by default. Be sure to update the section without duplicating the `[user_store]` header.

		```toml
		[user_store]
		class = "org.wso2.micro.integrator.security.user.core.jdbc.JDBCUserStoreManager"
		type = "database"

		# Add the following parameter only if you want to disable write access to the user store.
		read_only = true
		```
		
		The datasource configured under the `[[datasource]]` toml heading will now be the effective user store for the Micro Integrator. 

## What's next?

See [Managing Users]{{base_path}}/install-and-setup/setup/mi-setup/user_stores/managing_users) for instructions on adding, deleting, or viewing users in the user store.

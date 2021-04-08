# Upgrading from WSO2 EI 7.1.x to WSO2 API-M 4.0.0

This guide explains the recommended strategy for upgrading from the Micro Integrator of WSO2 EI 7.1.0 to the Micro Integrator of WSO2 API-M 4.0.0.

### Setting up

-	Make a backup of the databases used by the current EI 7.1.x deployment. This backup is necessary in case the migration causes any issues in the existing database.
-	Download and install WSO2 API-M 4.0.0 in your environment:

	-	Install the product [using the Installer]({{base_path}}/install-and-setup/install/installing-the-product/install-mi-in-vm-installer).
	-	Install the product [using the binary distribution]({{base_path}}/install-and-setup/install/installing-the-product/installing-the-binary/install-mi-in-vm-binary).

-	Use [WSO2 Update Manager](https://updates.docs.wso2.com/en/latest/updates/overview/) to get the latest available updates for your API-M 4.0.0 distribution.

	!!! Info
		Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.

### Migrating the user store

If you are already using a JDBC or LDAP user store with the Micro Integrator of EI 7.1.0, you can simply connect the same to the Micro Integrator of API-M 4.0.0 by updating the configuration details in the Micro Integrator's `deployment.toml` file. Following is a set of high-level configurations. 

!!! Tip
	See the instructions on [configuring a user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore) for more information.

```toml tab='RDBMS User Store'
[user_store]
type = "database"
read_only = "false"

[[datasource]]
id = "WSO2_USER_DB"
url= "jdbc:mysql://localhost:3306/userdb"
username="root"
password="root"
driver="com.mysql.jdbc.Driver"

[realm_manager]
data_source = "WSO2_USER_DB" 

[internal_apis.file_user_store]
enable = false
```

```toml tab='Read-Only LDAP User Store'
[user_store]
connection_url = "ldap://localhost:10389"  
connection_name = "uid=admin,ou=system"
connection_password = "admin"  
user_search_base = "ou=Users,dc=wso2,dc=org"
type = "read_only_ldap"
   
[internal_apis.file_user_store]
enable = false
```

```toml tab='Read-Write LDAP User Store'
[user_store]
connection_url = "ldap://localhost:10389"  
connection_name = "uid=admin,ou=system"
connection_password = "admin"  
user_search_base = "ou=Users,dc=wso2,dc=org"
type = "read_write_ldap"
   
[internal_apis.file_user_store]
enable = false
```

### Migrating the registry

The Micro Integrator uses a [file-based registry]({{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry). You can directly migrate the artifacts to the Micro Integrator of API-M 4.0.0 by copying the carbon applications from the `<MI_HOME>/repository/deployment/server/carbonapps` folder in the Micro Integrator of EI 7.1.0 to the same folder in API-M 4.0.0. 

### Migrating artifacts

Copy the contents inside the `<MI_HOME>/repository/deployment` folder in the Micro Integrator of EI 7.1.0 to the same folder in API-M 4.0.0.

### Migrating custom components

Copy the jars inside the `<MI_HOME>/dropins` folder in the Micro Integrator of EI 7.1.0 to the same folder in API-M 4.0.0. The custom JARs can be copied to the `<MI_HOME>/lib` folder in API-M 4.0.0.

### Migrating keystores

Copy the JKS files from the `<MI_HOME>/repository/resources/security` folder in the Micro Integrator of EI 7.1.0 to the same folder in API-M 4.0.0.

### Migrating configurations

Copy the configurations in the `deployment.toml` file of the Micro Integrator of EI 7.1.0 (such as database, transport, datasource configurations, etc.) to the `deployment.toml` file of the Micro Integrator in API-M 4.0.0.

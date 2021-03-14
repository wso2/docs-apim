# Migrating from WSO2 EI 7.0.x to WSO2 EI 7.1.x

This guide explains the recommended strategy for migrating from the Micro Integrator of WSO2 EI 7.0.0 to the Micro Integrator of WSO2 EI 7.1.0.

### Set up the migration

-	Make a backup of the database used by the current EI 6.x.x deployment. This backup is necessary in case the migration causes any issues in the existing database.
-	Download and install EI 7.1 in your environment:

	-	Install the product [using the Installer](../../../setup/installation/install_in_vm_installer).
	-	Install the product [using the binary distribution](../../../setup/installation/install_in_vm_binary).

-	Use [WSO2 Update Manager](https://docs.wso2.com/display/updates/) to get the latest available updates for your EI 7.0 distribution.

	!!! Info
		Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.

### Migrating the user store

If you are already using a JDBC or LDAP user store with the Micro Integrator of EI 7.0, you can simply connect the same to the Micro Integrator of EI 7.1 by updating the configuration details in `deployment.toml` file. Following is a set of high-level configurations. 

!!! Tip
	See the instructions on [configuring a user store](../../user_stores/setting_up_a_userstore) for more information.

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
The Micro Integrator uses a [file-based registry](../file_based_registry). You can directly migrate the artifacts to the Micro Integrator of EI 7.1.0 by copying the carbon applications from the `<MI_HOME>/repository/deployment/server/carbonapps` folder in the Micro Integrator of EI 7.0.0 to the same folder in EI 7.1.0. 

### Migrating artifacts
Copy the contents inside the `<MI_HOME>/repository/deployment` folder in the Micro Integrator of EI 7.0.0 to the same folder in EI 7.1.0.

### Migrating custom components
Copy the jars inside the `<MI_HOME>/dropins` folder in the Micro Integrator of EI 7.0.0 to the same folder in EI 7.1.0. The custom JARs can be copied to the `<MI_HOME>/lib` directory in EI 7.1.0.

### Migrating keystores
Copy the JKS files from the `<MI_HOME>/repository/resources/security` folder in the Micro Integrator of EI 7.0.0 to the same folder in EI 7.1.0.

### Migrating configurations
Copy the configurations in the `deployment.toml` file of the Micro Integrator of EI 7.0.0 (such as database, transport, datasource configurations, etc.) to the `deployment.toml` file of the Micro Integrator in EI 7.1.0.

!!! Info
	If you have done any customization to the `<MI_HOME>/conf/internal-apis.xml` file in the Micro Integrator of EI 7.0.0, you have to move them to the `deployment.toml` file in EI 7.1.0. 

	See the following topics for the TOML configurations that correspond to your configurations in the `internal-apis.xml` file:
	
	-	[Management API Token Handler Parameters](../../../references/config-catalog/#management-api-token-handler).
	-	[Management API Token Store Parameters](../../../references/config-catalog/#management-api-token-store).
	-	[Management API Token Parameters](../../../references/config-catalog/#management-api-token).
	-	[Management API - Default User Store Parameters](../../../references/config-catalog/#management-api-default-user-store).
	-	[Management API - Users Parameters](../../../references/config-catalog/#management-api-users).
	-	[Management API - CORS Parameters](../../../references/config-catalog/#management-api-cors).

### Migrating encrypted passwords

In version 7.0.0, **secure vault** was used to store sensitive information used in **synapse** configurations and the **cipher tool** was used for sensitive **server** configurations. In EI 7.1.0, all the sensitive information (in server configurations as well as synapse configuration) can simply be encrypted and stored using the cipher tool.

To migrate the encrypted passwords from EI 7.0.0, you need to first obtain the plain-text passwords. We provide a migration tool, which allows you to decrypt already encrypted passwords in EI 7.0.0.  The plain-text values can then be added to the `[secrets]` section of the `deployment.toml` file of the Micro Integrator of EI 7.1.0 and re-encrypted by running the cipher tool. 

Follow the instructions given below.

1. Download the [tool](https://github.com/wso2-docs/WSO2_EI/blob/master/migration-client/org.wso2.mi.migration-1.2.0.jar).
2. Get the latest update for your existing EI 7.0.0 distribution by using [WSO2 Update Manager](https://docs.wso2.com/display/updates/).

	!!! Info
		Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.

3. Copy the `org.wso2.mi.migration-1.2.0.jar` file to the `MI_HOME/dropins` folder in the Micro Integrator of EI 7.0.0.

4. Start the server using the `migrate.from.product.version` system property as follows:

	```bash tab='On Linux/Unix'
	sh micro-integrator.sh -Dmigrate.from.product.version=110
	```
	
	```bash tab='On Windows'
	micro-integrator.bat -Dmigrate.from.product.version=110
	```

	!!! Info
		Upon successful execution, the decrypted (plain-text) values in the `secure-vault.properties` and `cipher-text.properties` files will be written respectively to `<MI_HOME>/migration/secure-vault-decrypted.properties` file and the `<MI_HOME>/migration/cipher-text-decrypted.properties` file in the Micro Integrator of EI 7.0.0.

	The encrypted passwords are now decrypted and you have access to the plain-text password values.

5.	Use the plain-text passwords and follow the normal procedure of encrypting secrets in EI 7.1 See [Encrypting Secrets](../../security/encrypting_plain_text) for instructions.

### Migrating Hl7 Transport

HL7 transport is not shipped by default in the pack and the jars need to be added to the product manually. Please 
refer [Configuring the HL7 transport](../transport_configurations/configuring-transports/#configuring-the-hl7-transport) for more details.

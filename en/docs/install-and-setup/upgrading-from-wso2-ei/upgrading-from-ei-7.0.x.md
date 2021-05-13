# Upgrading from WSO2 EI 7.0.x to WSO2 API-M 4.0.0

This guide explains the recommended strategy for upgrading from the Micro Integrator of WSO2 EI 7.0.0 to the Micro Integrator of WSO2 API-M 4.0.0.

### Setting up

-	Make a backup of the databases used by the current EI 7.0.x deployment. This backup is necessary in case the migration causes any issues in the existing database.
-	[Download and install]({{base_path}}/install-and-setup/install/installing-the-product/installing-mi) the latest Micro Integrator in your environment:

	!!! Tip
		The home directory of your Micro Integrator will be referred to as `<MI_HOME>` from hereon.

-	Use [WSO2 Updates](https://updates.docs.wso2.com/en/latest/updates/overview/) to get the latest available updates for your Micro Integrator distribution.

	!!! Info
		Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.

### Migrating the user store

If you are using an **LDAP user store** with EI 7.0.0, you can simply connect the same to the Micro Integrator of API-M 4.0.0 by updating the configuration details in the Micro Integrator's `deployment.toml` file. 

If you are using a **JDBC user store** with EI 7.0.0, you need to first update the database before connecting the same to APIM 4.0.0.

Follow the steps given below.

#### Step 1 - Update the database structure

This step is applicable only if your user store is JDBC. 

There are changes in the database structure (schema) that is used in EI 7.0.0. To update the database schema:

1. Download the [database migration scripts]({{base_path}}/assets/attachments/migration/micro-integrator/migration-scripts-ei7.0.x-to-apim4.0.0.zip).

2. Unzip the downloaded file and select the script relevant to your database type.

3. Connect to the database and run the script.

Your database schema is now updated for APIM 4.0.0. Now you can update the configuration details in the Micro Integrator's `deployment.toml` file.

#### Step 2 - Connect to the user store

To connect the Micro Integrator to the primary user store:

-	[configuring an LDAP user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-ldap-user-store) for the Micro Integrator in API-M 4.0.0.
-	[configuring an RDBMS user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-rdbms-user-store) for the Micro Integrator in API-M 4.0.0.

### Migrating the registry
The Micro Integrator uses a [file-based registry]({{base_path}}/install-and-setup/setup/mi-setup/deployment/file_based_registry). You can directly migrate the artifacts to the Micro Integrator of API-M 4.0.0 by copying the carbon applications from the `<MI_HOME>/repository/deployment/server/carbonapps` folder in the Micro Integrator of EI 7.0.0 to the same folder in API-M 4.0.0. 

### Migrating artifacts
Copy the contents inside the `<MI_HOME>/repository/deployment` folder in the Micro Integrator of EI 7.0.0 to the same folder in API-M 4.0.0.

### Migrating custom components
Copy the jars inside the `<MI_HOME>/dropins` folder in the Micro Integrator of EI 7.0.0 to the same folder in API-M 4.0.0. The custom JARs can be copied to the `<MI_HOME>/lib` folder in API-M 4.0.0.

### Migrating keystores
Copy the JKS files from the `<MI_HOME>/repository/resources/security` folder in the Micro Integrator of EI 7.0.0 to the same folder in API-M 4.0.0.

### Migrating configurations
Copy the configurations in the `deployment.toml` file of the Micro Integrator of EI 7.0.0 (such as database, transport, datasource configurations, etc.) to the `deployment.toml` file of the Micro Integrator in API-M 4.0.0.

!!! Info
	If you have done any customization to the `<MI_HOME>/conf/internal-apis.xml` file in the Micro Integrator of EI 7.0.0, you have to move them to the `deployment.toml` file in API-M 4.0.0. 

	See [Securing the Management API]({{base_path}}/install-and-setup/setup/mi-setup/security/securing_management_api) for instructions.

### Migrating encrypted passwords

In version 7.0.0, **secure vault** was used to store sensitive information used in **synapse** configurations and the **cipher tool** was used for sensitive **server** configurations. In API-M 4.0.0, all the sensitive information (in server configurations as well as synapse configurations) can simply be encrypted and stored using the cipher tool.

To migrate the encrypted passwords from EI 7.0.0, you need to first obtain the plain-text passwords. We provide a migration tool, which allows you to decrypt already encrypted passwords in EI 7.0.0.  The plain-text values can then be added to the `[secrets]` section of the `deployment.toml` file of the Micro Integrator of API-M 4.0.0 and re-encrypted by running the cipher tool. 

Follow the instructions given below.

1. Download the [tool](https://github.com/wso2-docs/WSO2_EI/blob/master/migration-client/org.wso2.mi.migration-1.2.0.jar).
2. Get the latest update for your existing EI 7.0.0 distribution by using [WSO2 Updates](https://updates.docs.wso2.com/en/latest/updates/overview/).

	!!! Info
		Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.

3. Copy the `org.wso2.mi.migration-1.2.0.jar` file to the `MI_HOME/dropins` folder in the Micro Integrator of EI 7.0.0.

4. Start the server using the `migrate.from.product.version` system property as follows:

	```bash tab='On Linux/Unix'
	sh micro-integrator.sh -Dmigrate.from.product.version=mi110
	```
	
	```bash tab='On Windows'
	micro-integrator.bat -Dmigrate.from.product.version=mi110
	```

	!!! Info
		Upon successful execution, the decrypted (plain-text) values in the `secure-vault.properties` and `cipher-text.properties` files are written respectively to the `<MI_HOME>/migration/secure-vault-decrypted.properties` file and the `<MI_HOME>/migration/cipher-text-decrypted.properties` file in the Micro Integrator of EI 7.0.0.

	The encrypted passwords are now decrypted and you have access to the plain-text password values.

5.	Use the plain-text passwords and follow the normal procedure of encrypting secrets in the Micro Integrator of API-M 4.0.0. See [Encrypting Secrets]({{base_path}}/install-and-setup/setup/mi-setup/security/encrypting_plain_text) for instructions.

### Migrating Hl7 Transport

HL7 transport is not shipped by default in the API-M 4.0.0 Micro Integrator distribution. Therefore, the jars need to be added to the Micro Integrator server manually. See [Configuring the HL7 transport]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-hl7-transport) for details.

# Upgrading from WSO2 EI 7.1.x to WSO2 API-M 4.0.0

This guide explains the recommended strategy for upgrading from the Micro Integrator of WSO2 EI 7.1.0 to the Micro Integrator of WSO2 API-M 4.0.0. 

!!! Note
	Because there aren't any database changes between the Micro Integrators of EI 7.1.0 and API-M 4.0.0, upgrading involves moving (migrating) all your artifacts and configurations from EI 7.1.0 to API-M 4.0.0.

### Setting up

-	Make a backup of the databases used by the current EI 7.1.x deployment. This backup is necessary in case the migration causes any issues in the existing database.
-	Download and install WSO2 API-M 4.0.0 in your environment:

	-	Install the product [using the Installer]({{base_path}}/install-and-setup/install/installing-the-product/install-mi-in-vm-installer).
	-	Install the product [using the binary distribution]({{base_path}}/install-and-setup/install/installing-the-product/installing-the-binary/install-mi-in-vm-binary).

-	Use [WSO2 Update Manager](https://updates.docs.wso2.com/en/latest/updates/overview/) to get the latest available updates for your API-M 4.0.0 distribution.

	!!! Info
		Note that you need a valid [WSO2 subscription](https://wso2.com/subscription) to use updates in a production environment.

### Migrating the user store

If you are using LDAP user store with the Micro Integrator of EI 7.1.0, you can simply connect the same to the Micro Integrator.

If you are using a JDBC user store with the Micro Integrator of EI 7.1.0, you can use the same databases with APIM 4.0.0. However, you need to apply the following updates.

#### Update the database structure

There are changes in the database structure (schema) that is used in EI 7.1.0. To update the database schema:

1. Download the [database migration scripts]({{base_path}}/assets/attachments/migration/micro-integrator/migration-scripts-EI71X_to_APIM400.zip).

2. Unzip the downloaded file and select the script relevant to your database type.

3. Connect to the database and run the script.

Your database schema is now updated for APIM 4.0.0. Now you can update the configuration details in the Micro Integrator's `deployment.toml` file as given below.

Follow the links given below for instructions.

-	[configuring an LDAP user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-ldap-user-store) for the Micro Integrator in API-M 4.0.0.
-	[configuring an RDBMS user store]({{base_path}}/install-and-setup/setup/mi-setup/user_stores/setting_up_a_userstore/#configuring-an-rdbms-user-store) for the Micro Integrator in API-M 4.0.0.

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

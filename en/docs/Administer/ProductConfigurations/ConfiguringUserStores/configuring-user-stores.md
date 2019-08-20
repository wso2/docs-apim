# Configuring User Stores

A user store is the database where information of the users and/or user roles is stored. User information includes log-in name, password, fist name, last name, e-mail etc.

All WSO2 products have an embedded H2 database except for WSO2 Identity Server, which has an embedded LDAP as its user store. Permission is stored in a separate database called the user management database, which by default is H2. However, users have the ability to connect to external user stores as well.

The user stores of Carbon products can be configured to operate in either one of the following modes.

-   User store operates in read/write mode - In Read/Write mode, WSO2 Carbon reads/writes into the user store.
-   User store operates in read only mode - In Read Only mode, WSO2 Carbon guarantees that it does not modify any data in the user store. Carbon maintains roles and permissions in the Carbon database but it can read users/roles from the configured user store.

The sections below provide configuration details:

-   [Realm Configuration](_Realm_Configuration_)
-   [Changing the RDBMS](_Changing_the_RDBMS_)
-   [Configuring Primary User Stores](_Configuring_Primary_User_Stores_)



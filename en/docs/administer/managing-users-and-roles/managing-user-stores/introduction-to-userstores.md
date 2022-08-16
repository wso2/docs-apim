A user store is the database where information of the users and/or user roles are stored. User information includes log-in name, password, first name, last name, e-mail etc. The WSO2 API Manager have an embedded H2 database by default for this purpose. 

Permissions and other authorization related information is stored in a separate database called the user management database, which by default is H2 as well. However, users have the ability to connect to external user stores as well.

The user stores of can be configured to operate in either one of the following modes.

**User store operates in read/write mode** - In Read/Write mode, the API Manager reads/writes into the user store.

**User store operates in read only mode** - In Read Only mode, the API Manager does not modify any data in the user store. Instead we maintain roles and permissions in a separate database and read users/roles from the configured read only user store.
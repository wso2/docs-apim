# Configuring the Datasource Provider

A datasource provider connects to a source of data such as a database, accesses its data, and returns the results of the access queries. When creating a RDBMS datasource, use the default provider or link to an external provider.

### Default datasource provider

To use the default datasource provider, select **default** , and then enter the Driver, URL, User Name, and Password connection properties  as follows:

![](attachments/43977371/44172370.png)
### External datasource provider

If you need to add a datasource supported by an external provider class such as `          com.mysql.jdbc.jdbc2.optional.MysqlXADataSource         ` , select **External Data Source** , click **Add Property** , and then enter the name and value of each connection property you need to configure. Following is an example datasource for an external datasource provider:

![](attachments/43977371/44172371.png)


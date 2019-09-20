# Configuring an RDBMS Datasource

When adding a datasource, if you select RDBMS as the datasource type, the following screen appears:

![](/assets/attachments/43977370/44172369.png)

This is the default RDBMS datasource configuration provided by WSO2. You can also write your own RDBMS configuration by selecting the custom datasource option. Enter values for the following fields when using the default RDBMS datasource configuration:

-   **Data Source Type** : RDBMS
-   **Name** : Name of the datasource (must be a unique value)
-   **Data Source Provider** : Specify the datasource provider.
-   **Driver** : The class name of the JDBC driver to use. Make sure to copy the JDBC driver relevant to the database engine to the `<PRODUCT_HOME>/repository/components/lib/` directory. For example, if you are using MySQL, specify `com.mysql.jdbc.Driver` as the driver and copy `mysql-connector-java-5.XX-bin.jar` file to this directory. If you do not copy the driver to this directory when you create the datasource, you will get an exception similar to `Cannot load JDBC driver class com.mysql.jdbc.Driver` .
-   **URL** : The connection URL to pass to the JDBC driver to establish the connection.
-   **User Name** : The connection user name that will be passed to the JDBC driver to establish the connection.
-   **Password** : The connection password that will be passed to the JDBC driver to establish the connection.
-   **Expose as a JNDI Data Souce** : Allows you to specify the JNDI datasource.
-   **Data Source Configuration Parameters** : Allows you to specify the datasource connection pool parameters when creating a RDBMS datasource.

For more details on datasource configuration parameters, see [ApacheTomcat JDBC Connection Pool guide](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html) .

After creating datasources, they appear on the **Data Sources** page. You can edit and delete them as needed by clicking **Edit** or **Delete** links.



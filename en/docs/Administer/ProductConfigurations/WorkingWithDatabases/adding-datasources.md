# Adding Datasources

If the datasource management feature is installed in your WSO2 product instance, you can add datasources that allow the server to connect to databases and other external data stores.

Use the following steps to add a datasource:

1.  In the product management console, click **Data Sources** on the **Configure** tab.
    ![](http://docs.wso2.org/wiki/download/attachments/4885163/1.png?version=2&modificationDate=1327323080000)2.  Click **Add Data Source** .
3.  Specify the required options for connecting to the database. The available options are based on the type of datasource you are creating:
    -   Configuring a RDBMS Datasource
    -   Configuring a Custom Datasource

After adding datasources, they will appear on the **Data Sources** page. You can edit and delete them as needed by clicking **Edit** or **Delete** links.

!!! note
When adding an RDBMS datasource, be sure to copy the JDBC driver JAR file for your database to `          <PRODUCT_HOME>/repository/components/lib         ` .




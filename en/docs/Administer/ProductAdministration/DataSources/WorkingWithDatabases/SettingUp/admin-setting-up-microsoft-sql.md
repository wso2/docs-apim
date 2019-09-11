# admin\_Setting up Microsoft SQL

The following sections describe how to set up Microsoft SQL to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#admin_SettingupMicrosoftSQL-Settingupthedatabaseandusers)
-   [Setting up the JDBC driver](#admin_SettingupMicrosoftSQL-SettinguptheJDBCdriver)

### Setting up the database and users

Follow the steps below to set up the Microsoft SQL database and users.

#### Enable TCP/IP

1.  In the start menu, click **Programs** and launch **Microsoft SQL Server 2012.**
2.  Click **Configuration Tools** , and then click **SQL Server Configuration Manager** .
3.  Enable **TCP/IP** and disable **Named Pipes** from protocols of your Microsoft SQL server.
4.  Double click **TCP/IP** to open the TCP/IP properties window and set **Listen All** to `Yes` on the **Protocol** tab.
5.  On the **IP Address** tab, disable **TCP Dynamic Ports** by leaving it blank and give a valid TCP port, so that Microsoft SQL server will listen on that port.

        !!! info
    The best practice is to use port 1433, because you can use it in order processing services.


6.  Similarly, enable TCP/IP from **SQL Native Client Configuration** and disable **Named Pipes** . Also, check whether the port is set correctly to 1433.
7.  Restart Microsoft SQL server.

##### Create the database and user

1.  Open the Microsoft SQL Management Studio to create a database and user.
2.  Click **New Database** from the **Database** menu and specify all the options to create a new database.
3.  Click **New Login** from the **Logins** menu, and specify all the necessary options.

##### Grant permissions

Assign newly created users the required grants/permissions to log in and create tables, to insert, index, select, update and delete data in tables in the newly created database. These are the minimum set of SQL server permissions.

### Setting up the JDBC driver

[Download](https://msdn.microsoft.com/en-us/data/aa937724.aspx) and copy the sqljdbc4 Microsoft SQL JDBC driver file to the WSO2 product's `<PRODUCT_HOME>/repository/components/lib/` directory. Use `com.microsoft.sqlserver.jdbc.SQLServerDriver` asthe `<driverClassName>` in your datasource configuration in `<PRODUCT_HOME>/repository/conf/datasources/master-datasources.xml` file as explained in the next section.

!!! info
In WSO2 IoT Server copy the driver file to the `<IOTS_HOME>/lib` directory


## What's next

By default, all WSO2 products are configured to use the embedded H2 database. To configure your product with MSSQL, see [Changing to MSSQL](https://docs.wso2.com/display/ADMIN44x/Changing+to+MSSQL) .

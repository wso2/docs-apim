# admin\_Setting up Embedded H2

The following sections describe how to set up an embedded H2 database to replace the default H2 database in your WSO2 product:

-   [Setting up the database](#admin_SettingupEmbeddedH2-Settingupthedatabase)
-   [Setting up the drivers](#admin_SettingupEmbeddedH2-Settingupthedrivers)

!!! warning
H2 is not recommended in production

The embedded H2 database is NOT recommended in enterprise testing and production environments. It has lower performance, clustering limitations, and can cause file corruption failures. Please use an industry-standard RDBMS such as Oracle, PostgreSQL, MySQL, or MS SQL instead.

You can use the embedded H2 database in development environments and as the local registry in a registry mount.


### Setting up the database

Download and install the H2 database engine on your computer.

!!! info
For instructions on installing DB2 Express-C, see [H2 installation guide.](http://www.h2database.com/html/quickstart.html)


### Setting up the drivers

WSO2 currently ships H2 database engine version h2-1.2.140.\* and its related H2 database driver. If you want to use a different H2 database driver, take the following steps:

1.  Delete the following H2 database-related JAR file, which is shipped with WSO2 products:
`<PRODUCT_HOME>/repository/components/plugins/h2-database-engine_1.2.140.wso2v3.jar`
2.  Find the JAR file of the new H2 database driver ( `<H2_HOME>/bin/h2-*.jar` , where `<H2_HOME>` is the H2 installation directory) and copy it to your WSO2 product's `<PRODUCT_HOME>/repository/components/lib/` directory.

## What's next

Next, you need to configure your product with Embedded H2 database. For more information, see [Changing to Embedded H2](https://docs.wso2.com/display/ADMIN44x/Changing+to+Embedded+H2) .

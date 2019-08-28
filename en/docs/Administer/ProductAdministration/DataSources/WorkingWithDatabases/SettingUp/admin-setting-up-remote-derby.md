# admin\_Setting up Remote Derby

The following sections describe how to set up a remote Derby database to replace the default H2 database in your WSO2 product:

-   [Setting up the database](#admin_SettingupRemoteDerby-Settingupthedatabase)
-   [Setting up the drivers](#admin_SettingupRemoteDerby-Settingupthedrivers)

### Setting up the database

Follow the steps below to set up a remote Derby database.

1.  Download [Apache Derby](http://apache.mesi.com.ar/db/derby/db-derby-10.8.2.2/) .
2.  Install Apache Derby on your computer.

        !!! info
    For instructions on installing Apache Derby, see the [Apache Derby documentation](http://db.apache.org/derby/manuals/) .


3.  Go to the `          <DERBY_HOME>/bin         ` / directory and run the Derby network server start script. Usually, it is named `          startNetworkServer         ` .

### Setting up the drivers

Copy the `         derby.jar        ` , `         derbyclient.jar        ` JAR and the `         derbynet.jar        ` JAR from the &lt; `         DERBY_HOME>/lib/        ` directory to the &lt; `         PRODUCT_HOME>/repository/components/extensions/        ` directory (the classpath of the Carbon web application).

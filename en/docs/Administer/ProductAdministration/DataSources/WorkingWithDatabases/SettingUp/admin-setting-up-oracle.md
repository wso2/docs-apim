# admin\_Setting up Oracle

The following sections describe how to set up an Oracle database to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#admin_SettingupOracle-Settingupthedatabaseandusers)
-   [Setting up the JDBC driver](#admin_SettingupOracle-SettinguptheJDBCdriver)

### Setting up the database and users

Follow the steps below to set up an Oracle database.

1.  Create a new database by using the Oracle database configuration assistant (dbca) or manually.

2.  Make the necessary changes in the Oracle `tnsnames.ora` and `listner.ora` files in order to define addresses of the databases for establishing connections to the newly created database.

3.  After configuring the `.ora` files, start the Oracle instance using the following command:

        $ sudo /etc/init.d/oracle-xe restart

4.  Connect to Oracle using SQL\*Plus as SYSDBA as follows:

`$ ./$<ORACLE_HOME>/config/scripts/sqlplus.sh sysadm/password as SYSDBA          `

5.  Connect to the instance with the username and password using the following command:

        $ connect

6.  As SYSDBA, create a database user and grant privileges to the user as shown below:

    ``` powershell
        Create user <USER_NAME> identified by <PASSWORD> account unlock;
        grant connect to <USER_NAME>;
        grant create session, create table, create sequence, create trigger to <USER_NAME>;
        alter user <USER_NAME> quota <SPACE_QUOTA_SIZE_IN_MEGABYTES> on '<TABLE_SPACE_NAME>';
        commit;
    ```

7.  Exit from the SQL\*Plus session by executing the `quit` command.

### Setting up the JDBC driver

1.  Copy the Oracle JDBC libraries (for example, &lt; `ORACLE_HOME/jdbc/lib/ojdbc14.jar)` to the &lt; `PRODUCT_HOME>/repository/components/lib/` directory.
2.  Remove the old database driver from the `<PRODUCT_HOME>/repository/components/dropins/` directory.

!!! info
If you get a " `timezone region not found"` error when using the `ojdbc6.jar` file with WSO2 servers, set the Java property as follows: `export JAVA_OPTS="-Duser.timezone='+05:30'"        `

The value of this property should be the GMT difference of the country. If it is necessary to set this property permanently, define it inside the `wso2server.sh` as a new `JAVA_OPT` property.


## What's next

By default, all WSO2 products are configured to use the embedded H2 database. To configure your product with Oracle, see [Changing to Oracle](https://docs.wso2.com/display/ADMIN44x/Changing+to+Oracle) .

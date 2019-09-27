# admin\_Setting up MySQL

The following sections describe how to set up a MySQL database to replace the default H2 database in your WSO2 product:

-   [Setting up the database and users](#admin_SettingupMySQL-Settingupthedatabaseandusers)
-   [Setting up the drivers](#admin_SettingupMySQL-Settingupthedrivers)
-   [Executing db scripts on MySQL database](#admin_SettingupMySQL-ExecutingdbscriptsonMySQLdatabase)

### Setting up the database and users

Follow the steps below to set up a MySQL database:

1.  Download and install MySQL on your computer.

2.  Start the MySQL service

3.  Log in to the MySQL client as the root user (or any other user with database creation privileges).

    ``` java
            mysql -u root -p
    ```

4.  Enter the password when prompted.

5.  In the MySQL command prompt, create the database using the following command:

    ```
        mysql> create database <DATABASE_NAME>;
    ```

    !!! info

    If you are using MySQL version - 8.0.x, it is important to specify the character set as latin1 when creating databases. Failure to do this may result in an error
    It is related to the UTF-8 encoding. MySQL version 8.0.x defaults to character set UTF-8 to be friendlier to international users which uses 4 bytes per character. Hence, you must use latin1 as the character set as indicated below in the database creation commands to avoid this problem. Note that this may result in issues with non-latin characters (like Hebrew, Japanese, etc.). The database creation command should be as follows:

        mysql> create database <DATABASE_NAME> character set latin1;

6.  Give authorization to the regadmin user as follows:

    ``` java
        GRANT ALL ON regdb.* TO regadmin@localhost IDENTIFIED BY "regadmin";
    ```

    !!! info

    If you are using MySQL version - 8.0.x, use following commands to create the user and  grant authorization:

    ```
        CREATE USER 'regadmin'@'localhost' IDENTIFIED BY 'regadmin';
    ```

    ```
        GRANT ALL ON APIM.* TO 'regadmin'@'localhost';
    ```

7.  Once you have finalized the permissions, reload all the privileges by executing the following command:

    ``` java
            FLUSH PRIVILEGES;
    ```

8.  Log out from the MySQL prompt by executing the following command:

    ``` java
            quit;
    ```

### Setting up the drivers

Download the MySQL Java connector [JAR file](https://dev.mysql.com/downloads/connector/j/) , and copy it to the &lt; `PRODUCT_HOME>/repository/components/lib/` directory.

!!! tip

Be sure to use the connector version that is supported by the MySQL version you use. If you come across any issues due to version incompatibility, follow the steps below:

1.  Shut down the server and remove all existing connectors from `<PRODUCT_HOME>/repository/components/lib` and `<PRODUCT_HOME>/repository/components/dropins` .
2.  Download the connector JAR that is compatible with your current MySQL version.
3.  Copy the JAR file **only to** `<PRODUCT_HOME>/repository/components/lib` . Files will be copied automatically to the dropins folder during server startup.


### Executing db scripts on MySQL database

To run the database script against the database you created, login to the MySQL client and point to the corresponding database.

``` java
    use regdb;
```

Execute the mysql.sql database script against the pointed database using following command.

``` java
    mysql> source <path to the script>\mysql.sql;
```

##
What's next

By default, all WSO2 products are configured to use the embedded H2 database. To configure your product with MySQL, see [Changing to MySQL](https://docs.wso2.com/display/ADMIN44x/Changing+to+MySQL) .

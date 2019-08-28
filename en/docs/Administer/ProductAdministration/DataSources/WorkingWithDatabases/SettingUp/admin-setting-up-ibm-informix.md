# admin\_Setting up IBM Informix

The following sections describe how to set up IBM Informix to replace the default H2 database in your WSO2 product:

-   [Prerequisites](#admin_SettingupIBMInformix-Prerequisites)
-   [Creating the database](#admin_SettingupIBMInformix-Creatingthedatabase)
-   [Setting up Informix JDBC drivers](#admin_SettingupIBMInformix-SettingupInformixJDBCdrivers)

### Prerequisites

Download the latest version of [IBM Informix](http://www-01.ibm.com/software/data/informix/downloads.html) and install it on your computer.

### Creating the database

Create the database and users in Informix. For instructions on creating the database and users, see [Informix product documentation](http://www-947.ibm.com/support/entry/portal/all_documentation_links/information_management/informix_servers?productContext=-1122713425) [.](http://www-01.ibm.com/software/data/informix/)

!!! tip
Do the following changes to the default database when creating the Informix database.

-   Define the page size as 4K or higher when creating the dbspace as shown in the following command (i.e. denoted by `           -k 4          ` ) :

    ``` java
        onspaces -c -S testspace4 -k 4 -p /usr/informix/logdir/data5.dat -o 100 -s 3000000
    ```

-   Add the following system environment variables.

    ``` text
            export DB_LOCALE=en_US.UTF-8
            export CLIENT_LOCALE=en_US.UTF-8
    ```

-   Create an sbspace other than the dbspace by executing the following command:

    ``` java
            onspaces -c -S testspace4 -k 4 -p /usr/informix/logdir/data5.dat -o 100 -s 3000000
    ```

-   Add the following entry to the `           <INFORMIX_HOME>/etc/onconfig          ` file, and replace the given example sbspace name (i.e. `           testspace4          ` ) with your sbspace name:

    ``` java
            SBSPACENAME testspace4
    ```


### Setting up Informix JDBC drivers

Download the Informix JDBC drivers and copy them to your WSO2 product's `         <PRODUCT_HOME>/repository/components/lib/        ` directory.

!!! info
Use Informix JDBC driver version 3.70.JC8, 4.10.JC2 or higher.


## What's next

By default, all WSO2 products are configured to use the embedded H2 database. To configure your product with IBM Informix, see [Changing to IBM Informix](https://docs.wso2.com/display/ADMIN44x/Changing+to+IBM+Informix) .

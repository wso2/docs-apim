# Using Distributed Transactions in Data Services

!!! Warning
    **The contents on this page are currently under review!**

The data integration feature in WSO2 Micro Integrator supports data
federation, which means that a single data service can expose data from
multiple datasources. However, if you have multiple RDBMSs connected to
your data service, and if you need to perform IN-ONLY operations
(operations that can insert data and modify data in the datasource) in a
coordinated manner, the RDBMSs need to be defined as XA datasources.

Let's consider a scenario where you have two MySQL databases. You can
define a single data service for these databases and insert data into
both as explained below.

## Prerequisites

Let's create a MySQL database with the required data.

1.  Install the MySQL server.
2.  Set up a database for storing information of offices:
    1.  Create a database called **OfficeDetails**.

        ```bash
        CREATE DATABASE OfficeDetails;
        ```

    2.  Create the **Offices** table:

        ```bash
        USE OfficeDetails;

        CREATE TABLE `Offices` (`OfficeCode` int(11) NOT NULL, `AddressLine1` varchar(255) NOT NULL, `AddressLine2` varchar(255) DEFAULT NULL, `City` varchar(255) DEFAULT NULL, `State` varchar(255) DEFAULT NULL, `Country` varchar(255) DEFAULT NULL, `Phone` varchar(255) DEFAULT NULL, PRIMARY KEY (`OfficeCode`));
        ```

3.  Set up a database to store the employee information:
    1.  Create a database called **EmployeeDetails** .

        ```bash
        CREATE DATABASE EmployeeDetails;
        ```

    2.  Create the **Employees** table:

        ```bash
        USE EmployeeDetails;

        CREATE TABLE `Employees` (`EmployeeNumber` int(11) NOT NULL, `FirstName` varchar(255) NOT NULL, `LastName` varchar(255) DEFAULT NULL, `Email` varchar(255) DEFAULT NULL, `JobTitle` varchar(255) DEFAULT NULL, `OfficeCode` int(11) NOT NULL, PRIMARY KEY (`EmployeeNumber`));
        ```

## Synapse configuration

Given below is the data service configuration you need to build. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<data name="distributed_transactions" transports="http https local">
   <config enableOData="false" id="XAoffices">
      <property name="dataSourceClassName">com.mysql.jdbc.jdbc2.optional.MysqlXADataSource</property>
      <property name="dataSourceProps">
         <property name="url">jdbc:mysql://localhost:3306/OfficeDetails</property>
         <property name="user">root</property>
         <property name="password">root</property>
      </property>
   </config>
   <config enableOData="false" id="XAemployees">
      <property name="dataSourceClassName">com.mysql.jdbc.jdbc2.optional.MysqlXADataSource</property>
      <property name="dataSourceProps">
         <property name="url">jdbc:mysql://localhost:3306/EmployeeDetails</property>
         <property name="user">root</property>
         <property name="password">root</property>
      </property>
   </config>
   <query id="InsertOfficeQuery" useConfig="XAoffices">
      <sql>insert into Offices (OfficeCode,AddressLine1,AddressLine2,City,State,Country,Phone) values(:OfficeCode,:AddressLine1,'test','test','test','USA','test')</sql>
      <param name="OfficeCode" sqlType="STRING"/>
      <param name="AddressLine1" sqlType="STRING"/>
   </query>
   <query id="InsertEmployeeQuery" useConfig="XAemployees">
      <sql>insert into Employees (EmployeeNumber,FirstName,LastName,Email,JobTitle,OfficeCode) values(:EmployeeNumber,:FirstName,:LastName,'test','test',:OfficeCode)</sql>
      <param name="EmployeeNumber" sqlType="STRING"/>
      <param name="FirstName" sqlType="STRING"/>
      <param name="LastName" sqlType="STRING"/>
      <param name="OfficeCode" sqlType="STRING"/>
   </query>
   <operation name="InsertOfficeOp">
      <call-query href="InsertOfficeQuery">
         <with-param name="OfficeCode" query-param="OfficeCode"/>
         <with-param name="AddressLine1" query-param="AddressLine1"/>
      </call-query>
   </operation>
   <operation name="InsertEmployeeOp">
      <call-query href="InsertEmployeeQuery">
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
         <with-param name="FirstName" query-param="FirstName"/>
         <with-param name="LastName" query-param="LastName"/>
         <with-param name="OfficeCode" query-param="OfficeCode"/>
      </call-query>
   </operation>
</data>
```

## Build and run

Create the artifacts:

1. [Set up WSO2 Integration Studio]({{base_path}}/integrate/develop/installing-wso2-integration-studio). The path to this folder is referred to as `MI_TOOLING_HOME` throughout this tutorial.
2.  Download the JDBC driver for MySQL from [here](http://dev.mysql.com/downloads/connector/j/) and copy it to the `MI_TOOLING_HOME/Contents/Eclipse/runtime/microesb/lib/` (for MacOS) or 
`MI_TOOLING_HOME/runtime/microesb/lib/` (for Windows) directory. 

    !!! Note
        If the driver class does not exist in the relevant folders when you create the datasource, you will get an exception such as `Cannot load JDBC driver class com.mysql.jdbc.Driver`.
        
3. [Create a Data Service project]({{base_path}}/integrate/develop/create-data-services-configs).
4. [Create the data service]({{base_path}}/integrate/develop/creating-artifacts/data-services/creating-data-services) with the configurations given above.
5. [Deploy the artifacts]({{base_path}}/integrate/develop/deploy-artifacts) in your Micro Integrator. 

Invoke the **request box** operation and see that the data is successfully inserted into the two databases. Go to the MySQL terminal and run the following commands:  

-   Check the office details in the offices table:

    ```bash
    USE OfficeDetails;
    SELECT * FROM Offices;
    ```

-   Check the employee details in the employees table.

    ```bash
    USE EmployeeDetails;
    SELECT * FROM Employees;
    ```

Now, enter another set of values for the two operations but enter an erroneous value for one field. Invoke the operation and check the database tables. You see that no records have been entered into either database.
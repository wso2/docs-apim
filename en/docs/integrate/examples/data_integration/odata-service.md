# Using an OData Service

This example demonstrates how an RDBMS can be exposed as an OData service. When OData is enabled, you do not need to manually define CRUD operations. Therefore, OData services are an easy way to enable CRUD operations for a data service.

!!! Note
    Note that the OData feature can only be used for RDBMS, Cassandra, and MongoDB datasources.

## Prerequisites

Let's create a MySQL database with the required data.

1.  Install the MySQL server.
2.  Create a MySQL database named `CompanyAccounts`.
    .  

    ```bash
    CREATE DATABASE CompanyAccounts;
    ```

3.  Create a table in the `           CompanyAccounts          `
    database as follows.

    ```bash
    CREATE TABLE ACCOUNT(AccountID int NOT NULL,Branch varchar(255) NOT NULL, AccountNumber varchar(255),AccountType ENUM('CURRENT', 'SAVINGS') NOT NULL,
            Balance FLOAT,ModifiedDate DATE,PRIMARY KEY (AccountID)); 
    ```

4.  Enter the following data into the table:  

    ```bash
    INSERT INTO ACCOUNT VALUES (1,"AOB","A00012","CURRENT",231221,'2014-12-02');
    ```

## Synapse configuration

Given below is the data service configuration you need to build. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<data name="odata_service" transports="http https local">
   <config enableOData="true" id="Datasource">
      <property name="driverClassName">com.mysql.jdbc.Driver</property>
      <property name="url">jdbc:mysql://localhost:3306/CompanyAccounts</property>
      <property name="username">root</property>
      <property name="password">password</property>
   </config>
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

Open a command prompt execute the following CURL commands using CRUD operations:

!!! Note
    Note that you should have privileges to perform CRUD operations on the database. If not, the OData service will not work properly.


-   To get the service document:

    ```bash
    curl -X GET -H 'Accept: application/json' http://localhost:8290/odata/odata_service/Datasource
    ```

-   To get the metadata of the service:

    ```bash
    curl -X GET -H 'Accept: application/xml' http://localhost:8290/odata/odata_service/Datasource/$metadata
    ```

-   To read details from the ACCOUNT table:

    ```bash
    curl -X GET -H 'Accept: application/xml' http://localhost:8290/odata/odata_service/Datasource/ACCOUNT
    ```
    
!!! info "Supported functionality"

    - Navigation (e.g. GET /EMPLOYEES(1001)/DEPARTMENTS)
        - One to One
        - One to Many
    - Count
        - Append count to the result set (e.g. GET /EMPLOYEES?$count=true)
        - Get only the count (e.g. GET /EMPLOYEES/$count)
    - Top (e.g. GET /EMPLOYEES?$top=10)
    - Skip (e.g. GET /EMPLOYEES?$skip=5)
    - Select (e.g. GET /EMPLOYEES?$select=emp_no,last_name)
    - Sort
        - Ascending (e.g. GET /EMPLOYEES?$orderby=last_name asc)
        - Descending (e.g. GET /EMPLOYEES?$orderby=last_name desc)
    - Filter (e.g. GET /EMPLOYEES?$filter=dept_no eq 'd001' and emp_no eq 10001)
    - Pagination (e.g. GET /EMPLOYEES?$skiptoken=5)

!!! important 
    Application owners should exist in both WSO2 API Manager and WSO2 Identity Server for this feature to work correctly. There are two approaches to fulfill this requirement:

    1. Share the same user stores between APIM and IS: By sharing the user stores, ensure that the application owners are present in both APIM and IS. For more information on how to configure user stores, refer [Introduction to User Stores](https://apim.docs.wso2.com/en/4.2.0/administer/managing-users-and-roles/managing-user-stores/introduction-to-userstores/).

    2. Create the same application owners in APIM and the IS user stores: Alternatively, you can create identical application owner accounts separately in both APIM and the IS user stores.

    Ensure that either of these options is implemented to enable the proper functioning of the feature.
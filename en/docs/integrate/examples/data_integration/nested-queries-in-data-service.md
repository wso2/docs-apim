# Using Nested Data Queries

Nested queries help you to use the result of one query as an input
parameter of another, and the queries executed in a nested query works
in a transactional manner. Follow the steps given below to add a nested
query to a data service.

## Prerequisites

Let's create a MySQL database with the required data.

1.  Install the MySQL server.
2.  Create the following database: Company

    ```bash
    CREATE DATABASE Company;
    ```

3.  Create the following tables:

    -   **Offices** table:

        ```bash
        USE company;

        CREATE TABLE `OFFICES` (`OfficeCode` int(11) NOT NULL, `AddressLine1` varchar(255) NOT NULL, `AddressLine2` varchar(255) DEFAULT NULL, `City` varchar(255) DEFAULT NULL, `State` varchar(255) DEFAULT NULL, `Country` varchar(255) DEFAULT NULL, `Phone` varchar(255) DEFAULT NULL, PRIMARY KEY (`OfficeCode`)); 
        ```

    -   **Employees** table:

        ```bash
        CREATE TABLE `EMPLOYEES` (`EmployeeNumber` int(11) NOT NULL, `FirstName` varchar(255) NOT NULL, `LastName` varchar(255) DEFAULT NULL, `Email` varchar(255) DEFAULT NULL, `JobTitle` varchar(255) DEFAULT NULL, `OfficeCode` int(11) NOT NULL, PRIMARY KEY (`EmployeeNumber`,`OfficeCode`), CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`OfficeCode`) REFERENCES `OFFICES` (`OfficeCode`));
        ```

4.  Insert the following data into the tables:

    -   Add to the **Offices** table:

        ```bash
        INSERT INTO OFFICES VALUES (1,"51","Glen Street","Norwich","London","United Kingdom","+441523624");
        INSERT INTO OFFICES VALUES (2,"72","Rose Street","Pasadena","California","United States","+152346343");
        ```

    -   Add to the **Employees** table:

        ```bash
        INSERT INTO EMPLOYEES VALUES (1,"John","Gardiner","john@office1.com","Manager",1);
        INSERT INTO EMPLOYEES VALUES (2,"Jane","Stewart","jane@office2.com","Head of Sales",2);
        INSERT INTO EMPLOYEES VALUES (3,"David","Green","david@office1.com","Manager",1); 
        ```

You will now have two tables in the **Company** database as shown below:

-   **Offices** table:  
    To view the data, you can run the following command:
    `          SELECT * FROM Offices;         `  

-   **Employees** table:  
    To view the data, you can run the following command:
    `          SELECT * FROM Employees;         `  

## Synapse configuration
Given below is the data service configuration you need to build. See the instructions on how to [build and run](#build-and-run) this example.

!!! Tip
    Be sure to replace the datasource username and password with the correct values for your MySQL instance.

```xml
<data name="nested_queries" transports="http https local">
   <config enableOData="false" id="Datasource">
      <property name="driverClassName">com.mysql.jdbc.Driver</property>
      <property name="url">jdbc:mysql://localhost:3306/Company</property>
      <property name="username">root</property>
      <property name="password">password</property>
   </config>
   <query id="EmployeeOfficeSQL" useConfig="Datasource">
      <sql>select EmployeeNumber, FirstName, LastName, Email, JobTitle, OfficeCode from EMPLOYEES where OfficeCode=:OfficeCode</sql>
      <result element="Entries" rowName="Entry">
         <element column="EmployeeNumber" name="EmployeeNumber" xsdType="string"/>
         <element column="FirstName" name="FirstName" xsdType="string"/>
         <element column="LastName" name="LastName" xsdType="string"/>
         <element column="Email" name="Email" xsdType="string"/>
         <element column="JobTitle" name="JobTitle" xsdType="string"/>
         <element column="OfficeCode" name="OfficeCode" xsdType="string"/>
      </result>
      <param name="OfficeCode" sqlType="STRING"/>
   </query>
   <query id="listOfficeSQL" useConfig="Datasource">
      <sql>select OfficeCode, AddressLine1, AddressLine2, City, State, Country, Phone from OFFICES where OfficeCode=:OfficeCode</sql>
      <result element="Entries" rowName="Entry">
         <element column="OfficeCode" name="OfficeCode" xsdType="string"/>
         <element column="AddressLine1" name="AddressLine1" xsdType="string"/>
         <element column="AddressLine2" name="AddressLine2" xsdType="string"/>
         <element column="City" name="City" xsdType="string"/>
         <element column="State" name="State" xsdType="string"/>
         <element column="Country" name="Country" xsdType="string"/>
         <element column="Phone" name="Phone" xsdType="string"/>
         <call-query href="EmployeeOfficeSQL" requiredRoles="">
            <with-param column="OfficeCode" name="OfficeCode"/>
         </call-query>
      </result>
      <param name="OfficeCode" sqlType="STRING"/>
   </query>
   <operation name="listOfficeSQLOP">
      <call-query href="listOfficeSQL">
         <with-param name="OfficeCode" query-param="OfficeCode"/>
      </call-query>
   </operation>
   <resource method="GET" path="offices/{OfficeCode}">
      <call-query href="listOfficeSQL">
         <with-param name="OfficeCode" query-param="OfficeCode"/>
      </call-query>
   </resource>
</data>
```

!!! Tip
    If you want to map the query output to JSON, select `JSON` as the output type. The query result for the `listOfficeSQL` query will be as follows:

    ```json
    <query id="listOfficeSQL" useConfig="Datasource">
        <sql>select OfficeCode, AddressLine1, AddressLine2, City, State, Country, Phone from OFFICES where OfficeCode=:OfficeCode</sql>
        <result outputType="json">{ 
           "Offices":{ 
              "Office":[ 
                 { 
                    "OfficeCode":"$OfficeCode(type:integer)",
                    "City":"$City",
                    "Country":"$Country",
                    "Phone":"$Phone",
                    "@EmployeeOfficeSQL":"$OfficeCode->OfficeCode"
                 }
              ]
           }
        }</result>
        <param name="OfficeCode" sqlType="STRING"/>
    </query>
    ```

    As shown above, nested queries are mentioned in the JSON mapping by giving the query details as a JSON object attribute. That is, the name of the target query to be called and the property value (the fields in the result mapped with the target query parameters) are included in the JSON mapping as the object attribute name.

    In the above example:
    
    - The target query name is mentioned by prefixing the query name with "@". Note "@EmployeeOfficeSQL" in the example given above.
    - The parameter mapping is added to the query by giving the following values: The field name in the result prefixed by "$", and the name of the target query parameter.
    - These two values in the parameter mapping are separated by "->". See "$OfficeCode->OfficeCode" in the example given above.
    - Note that the target query name and the parameter mapping are separated by a colon as follows: "@EmployeeOfficeSQL": "$OfficeCode->OfficeCode"

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

The service can be invoked in REST-style via curl (
[http://curl.haxx.se](http://curl.haxx.se/) ). Shown below is the curl
command to invoke the GET resource.  
It gets the details of the office that has the office code 1, and all
the employees that belong to office code 1.

```bash
curl -X GET http://localhost:8290/services/nested_queries/offices/1
```

!!! Tip
    If you configured the output mapping of the `listOfficeSQL` query to be in the JSON format, you need to add the header `-H 'Accept: application/json'` to your curl command to get the output in the JSON format.

```bash
curl -H 'Accept: application/json' -X GET http://localhost:8290/services/nested_queries/offices/1
```

You will now see the following result:

```xml tab='XML result'
<Entries xmlns="http://ws.wso2.org/dataservice">
   <Entry>
      <OfficeCode>1</OfficeCode>
      <AddressLine1>51</AddressLine1>
      <AddressLine2>Glen Street</AddressLine2>
      <City>Norwich</City>
      <State>London</State>
      <Country>United Kingdom</Country>
      <Phone>+441523624</Phone>
      <Entries>
         <Entry>
            <EmployeeNumber>1</EmployeeNumber>
            <FirstName>John</FirstName>
            <LastName>Gardiner</LastName>
            <Email>john@office1.com</Email>
            <JobTitle>Manager</JobTitle>
            <OfficeCode>1</OfficeCode>
         </Entry>
         <Entry>
            <EmployeeNumber>3</EmployeeNumber>
            <FirstName>David</FirstName>
            <LastName>Green</LastName>
            <Email>david@office1.com</Email>
            <JobTitle>Manager</JobTitle>
            <OfficeCode>1</OfficeCode>
         </Entry>
      </Entries>
   </Entry>
</Entries>
```

```json tab='JSON result'
{
   "Offices":{
      "Office":[
         {
            "Phone":"+441523624",
            "Country":"United Kingdom",
            "OfficeCode":1,
            "City":"Norwich",
            "Entries":{
               "Entry":[
                  {
                     "EmployeeNumber":"1",
                     "FirstName":"John",
                     "LastName":"Gardiner",
                     "Email":"john@office1.com",
                     "JobTitle":"Manager",
                     "OfficeCode":"1"
                  },
                  {
                     "EmployeeNumber":"3",
                     "FirstName":"David",
                     "LastName":"Green",
                     "Email":"david@office1.com",
                     "JobTitle":"Manager",
                     "OfficeCode":"1"
                  },
                  {
                     "EmployeeNumber":"1002",
                     "FirstName":"Peter",
                     "LastName":"Parker",
                     "Email":"peter@wso2.com",
                     "JobTitle":null,
                     "OfficeCode":"1"
                  },
                  {
                     "EmployeeNumber":"1003",
                     "FirstName":"Chris",
                     "LastName":"Sam",
                     "Email":"chris@sam.com",
                     "JobTitle":null,
                     "OfficeCode":"1"
                  },
                  {
                     "EmployeeNumber":"1006",
                     "FirstName":"Chris",
                     "LastName":"Sam",
                     "Email":"chris@sam.com",
                     "JobTitle":null,
                     "OfficeCode":"1"
                  },
                  {
                     "EmployeeNumber":"1007",
                     "FirstName":"John",
                     "LastName":"Doe",
                     "Email":"johnd@wso2.com",
                     "JobTitle":null,
                     "OfficeCode":"1"
                  },
                  {
                     "EmployeeNumber":"1008",
                     "FirstName":"Peter",
                     "LastName":"Parker",
                     "Email":"peterp@wso2.com",
                     "JobTitle":null,
                     "OfficeCode":"1"
                  }
               ]
            }
         }
      ]
   }
}
```

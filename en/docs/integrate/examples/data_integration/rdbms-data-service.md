# Exposing an RDBMS Datasource

This example demonstrates how RDBMS data (stored in a MySQL database) can be exposed as a data service.

## Prerequisites

Let's create a MySQL database with the required data.

1.  Install the MySQL server.
2.  Create a database named `Employees` .

    ```bash
    CREATE DATABASE Employees;
    ```

3.  Create the Employee table inside the Employees database:

    ```bash
    USE Employees;

    CREATE TABLE Employees (EmployeeNumber int(11) NOT NULL, FirstName varchar(255) NOT NULL, LastName varchar(255) DEFAULT NULL, Email varchar(255) DEFAULT NULL, Salary varchar(255));
    ```

## Synapse configuration
Given below is the data service configuration you need to build. See the instructions on how to [build and run](#build-and-run) this example.

```xml
<data enableBatchRequests="true" name="RDBMSDataService" serviceGroup="" serviceNamespace="">
    <description/>
    <query id="GetEmployeeDetails" useConfig="Datasource">
        <sql>select EmployeeNumber, FirstName, LastName, Email, Salary from Employees where EmployeeNumber=:EmployeeNumber</sql>
        <param name="EmployeeNumber" paramType="SCALAR" sqlType="STRING"/>
        <result element="Employees" rowName="Employee">
            <element column="EmployeeNumber" name="EmployeeNumber" xsdType="xs:string"/>
            <element column="FirstName" name="FirstName" xsdType="xs:string"/>
            <element column="LastName" name="LastName" xsdType="xs:string"/>
            <element column="Email" name="Email" xsdType="xs:string"/>
            <element column="Salary" name="Salary" xsdType="xs:string"/>
        </result>
    </query>
  <config id="Datasource">
    <property name="driverClassName">com.mysql.jdbc.Driver</property>
    <property name="url">jdbc:mysql://localhost:3306/Employees</property>
    <property name="username">root</property>
    <property name="password"></property>
    <property name="dynamicUserAuthClass">com.mysql.jdbc.Driver</property>
  </config>
    <query id="AddEmployeeDetails" useConfig="Datasource">
        <sql>insert into Employees (EmployeeNumber, FirstName, LastName, Email, Salary) values(:EmployeeNumber,:FirstName,:LastName,:Email,:Salary)</sql>
        <param name="EmployeeNumber" paramType="SCALAR" sqlType="STRING"/>
        <param name="FirstName" paramType="SCALAR" sqlType="STRING"/>
        <param name="LastName" paramType="SCALAR" sqlType="STRING"/>
        <param name="Email" paramType="SCALAR" sqlType="STRING"/>
        <param name="Salary" paramType="SCALAR" sqlType="STRING"/>
    </query>
    <query id="UpdateEmployeeDetails" useConfig="Datasource">
        <param name="EmployeeNumber" paramType="SCALAR" sqlType="STRING"/>
        <sql>update Employees set FirstName=:FirstName, LastName=:LastName, Email=:Email, Salary=:Salary where EmployeeNumber=:EmployeeNumber</sql>
        <param name="FirstName" paramType="SCALAR" sqlType="STRING"/>
        <param name="LastName" paramType="SCALAR" sqlType="STRING"/>
        <param name="Email" paramType="SCALAR" sqlType="STRING"/>
        <param name="Salary" paramType="SCALAR" sqlType="STRING"/>
    </query>
    <resource method="GET" path="Employee/{EmployeeNumber}">
        <call-query href="GetEmployeeDetails">
            <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
        </call-query>
    </resource>
    <resource method="POST" path="Employee">
        <call-query href="AddEmployeeDetails">
            <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
            <with-param name="FirstName" query-param="FirstName"/>
            <with-param name="LastName" query-param="LastName"/>
            <with-param name="Email" query-param="Email"/>
            <with-param name="Salary" query-param="Salary"/>
        </call-query>
    </resource>
    <resource method="PUT" path="Employee">
        <call-query href="UpdateEmployeeDetails">
            <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
            <with-param name="FirstName" query-param="FirstName"/>
            <with-param name="LastName" query-param="LastName"/>
            <with-param name="Email" query-param="Email"/>
            <with-param name="Salary" query-param="Salary"/>
        </call-query>
    </resource>
</data>
```

!!! Tip
    If you use **External** instead of the **Default** as the datasource type, your datasource should be supported by an external provider class, such as `com.mysql.jdbc.jdbc2.optional.MysqlXADataSource`.</br></br>
    After an external datasource is created, it can be used as another datasource in queries. See the example on [handling distributed transactions]({{base_path}}/integrate/examples/data_integration/distributed-trans-data-service) for more information on using external datasources.

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

Let's take a look at the curl commands that are used to send the HTTP
requests for each of the resources:

#### Post new data

1.  Create a file called `           employee-payload.xml          `
    file, and define the XML payload for posting new data as shown
    below.

    ```bash
    <_postemployee>
        <EmployeeNumber>3</EmployeeNumber>
        <FirstName>Will</FirstName>
        <LastName>Smith</LastName>
        <Email>will@google.com</Email>
        <Salary>15500.0</Salary>
    </_postemployee>
    ```

2.  Send the following HTTP request from the location where the
    `           employee-payload.xml          ` file is stored:

    ```bash
    curl -X POST -H 'Accept: application/xml'  -H 'Content-Type: application/xml' --data "@employee-payload.xml" http://localhost:8290/services/RDBMSDataService/employee
    ```

#### Get data

The service can be invoked in REST-style via curl (
[http://curl.haxx.se](http://curl.haxx.se/) ). Shown below is the curl
command to invoke the GET resource:

```bash
curl -X GET http://localhost:8290/services/RDBMSDataService.HTTPEndpoint/Employee/3
```

This generates a response as follows.

```bash
<Entries xmlns="http://ws.wso2.org/dataservice"><Entry><EmployeeNumber>3</EmployeeNumber><FirstName>Will</FirstName><LastName>Smith</LastName><Email>will@google.com</Email><Salary>15500.0</Salary></Entry><Entry><EmployeeNumber>3</EmployeeNumber><FirstName>Will</FirstName><LastName>Smith</LastName><Email>will@google.com</Email><Salary>15500.0</Salary></Entry><Entry><EmployeeNumber>3</EmployeeNumber><FirstName>Will</FirstName><LastName>Smith</LastName><Email>will@google.com</Email><Salary>15500.0</Salary></Entry></Entries>
```

#### Update data

1.  Create a file called
    `           employee-update-payload.xml          ` file, and define
    the XML payload for updating an existing employee record as shown
    below.

    ```bash
    <_putemployee>
        <EmployeeNumber>3</EmployeeNumber>
        <LastName>Smith</LastName>
        <FirstName>Will</FirstName>
        <Email>will@google.com</Email>
        <Salary>30000.0</Salary>
    </_putemployee>
    ```

2.  Send the following HTTP request from the location where the
    `           employee-update-payload.xml          ` file is stored:

    ```bash
    curl -X PUT -H 'Accept: application/xml'  -H 'Content-Type: application/xml' --data "@employee-update-payload.xml" http://localhost:8290/services/RDBMSDataService/employee
    ```

#### Get Swagger definition

-   Copy the following URL to your browser to get the Swagger definition in JSON format:

    ```bash
    http://localhost:8290/services/RDBMSDataService?swagger.json
    ```

-   Copy the following URL to your browser to get the Swagger definition in YAML format:

    ```bash
    http://localhost:8290/services/RDBMSDataService?swagger.yaml
    ```

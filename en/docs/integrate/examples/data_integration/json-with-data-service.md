# Exposing Data in JSON Format

You can send and receive JSON messages by default via WSO2 Micro Integrator. See the topics given below to
understand how data can be exposed in the JSON format, and how data can be changed by sending JSON payloads. In this example, you will use a data service that exposes RDBMS data.

A data service can expose data in one of the following formats: XML,
RDF, or JSON. You can select the required format by specifying
the output type for the data service query. To expose data in JSON, you
need to select JSON as the output type, and map the output to a JSON
template.

## Prerequisites

Let's create a MySQL database with the required data.

1.  Install the MySQL server.
2.  Create a database named `Employees`.

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
<data name="RDBMSDataService" serviceStatus="active" transports="http https local">
   <config enableOData="false" id="Datasource">
      <property name="driverClassName">com.mysql.jdbc.Driver</property>
      <property name="url">jdbc:mysql://localhost:3306/Employees</property>
      <property name="username">root</property>
      <property name="password">password</property>
   </config>
   <query id="GetEmployeeDetails" useConfig="Datasource">
      <sql>select EmployeeNumber, FirstName, LastName, Email, Salary from Employees where EmployeeNumber=:EmployeeNumber</sql>
      <result outputType="json">{
   "Employees":{
      "Employee":[
         {
            "EmployeeNumber":"$EmployeeNumber",
            "FirstName":"$FirstName",
            "LastName":"$LastName",
            "Email":"$Email",
            "Salary":"$Salary"
         }
      ]
   }
}</result>
      <param name="EmployeeNumber" sqlType="STRING"/>
   </query>
   <query id="AddEmployeeDetails" useConfig="Datasource">
      <sql>insert into Employees (EmployeeNumber, FirstName, LastName, Email, Salary) values(:EmployeeNumber,:FirstName,:LastName,:Email,:Salary)</sql>
      <param name="EmployeeNumber" sqlType="STRING"/>
      <param name="FirstName" sqlType="STRING"/>
      <param name="LastName" sqlType="STRING"/>
      <param name="Email" sqlType="STRING"/>
      <param name="Salary" sqlType="STRING"/>
   </query>
   <query id="UpdateEmployeeDetails" useConfig="Datasource">
      <sql>update Employees set LastName=:LastName, FirstName=:FirstName, Email=:Email, Salary=:Salary where EmployeeNumber=:EmployeeNumber</sql>
      <param name="LastName" sqlType="STRING"/>
      <param name="FirstName" sqlType="STRING"/>
      <param name="Email" sqlType="STRING"/>
      <param name="Salary" sqlType="STRING"/>
      <param name="EmployeeNumber" sqlType="STRING"/>
   </query>
   <operation name="GetEmployeeOp">
      <call-query href="GetEmployeeDetails">
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
      </call-query>
   </operation>
   <operation name="AddEmployeeOp">
      <call-query href="AddEmployeeDetails">
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
         <with-param name="FirstName" query-param="FirstName"/>
         <with-param name="LastName" query-param="LastName"/>
         <with-param name="Email" query-param="Email"/>
         <with-param name="Salary" query-param="Salary"/>
      </call-query>
   </operation>
   <operation name="UpdateEmployeeOp">
      <call-query href="UpdateEmployeeDetails">
         <with-param name="LastName" query-param="LastName"/>
         <with-param name="FirstName" query-param="FirstName"/>
         <with-param name="Email" query-param="Email"/>
         <with-param name="Salary" query-param="Salary"/>
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
      </call-query>
   </operation>
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
         <with-param name="LastName" query-param="LastName"/>
         <with-param name="FirstName" query-param="FirstName"/>
         <with-param name="Email" query-param="Email"/>
         <with-param name="Salary" query-param="Salary"/>
         <with-param name="EmployeeNumber" query-param="EmployeeNumber"/>
      </call-query>
   </resource>
</data>
```

Alternatively, you can use one of the following JSON templates for the response mapping:

-   Simple JSON template

    ```json
    { "Employees":
          {"Employee":[
            {"EmployeeNumber":"$EmployeeNumber",                       
             "Details": {
              "FirstName":"$FirstName",
              "LastName":"$LastName",
              "Email":"$Email",
              "Salary":"$Salary"
             }
            }                 
          ]
        }           
    }
    ```

-   Define data types

    In a basic JSON output mapping, we specify the field values that we expect in the query result. You can give additional properties to this field mapping such as data type of the field, the possible content filtering user roles etc. These extended properties for the fields are given in parentheses, with a list of string tokens providing the additional properties, separated by a semicolon (";"). See the sample below.

    ```json
    <result outputType="json">
    { "Employees":
          {"Employee":[
            {"EmployeeNumber":"$EmployeeNumber(type:integer)",                       
             "Details": {
              "FirstName":"$FirstName",
              "LastName":"$LastName",
              "Email":"$Email",
              "Salary":"$Salary(requiredRoles:hr,admin)"
             }
            }                 
          ]
        }           
    }
    </result>
    ```

-   If you want to write a nested query using JSON, see the example on [nested queries]({{base_path}}/integrate/examples/data_integration/nested-queries-in-data-service).

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

### GET data in JSON

The RDBMSDataService that you are using contains the following
resource:

-   **Resource Path**: `Employee/{EmployeeNumber}  `
-   **Resource Method**: `GET`
-   **Query ID**: `GetEmployeeDetails`

You can now RESTfully invoke the above resource. To send a JSON message
to a RESTful resource, you can simply add the “
`         Accept        ` : `         Application/json        ` ” to the
request header when you send the request. The service can be invoked in
REST-style via [curl](http://curl.haxx.se/) .  
Shown below is the curl command to invoke the GET resource:

```bash
curl -X GET -H "Accept: application/json" http://localhost:8290/services/RDBMSDataService/Employee/{EmployeeNumber}
```

Example:

```bash
curl -X GET -H "Accept: application/json" http://localhost:8290/services/RDBMSDataService/Employee/1
```

As a result, you receive the response in JSON format as shown below.

```bash
{"Employees":{"Employee":[{"EmployeeNumber":"1","FirstName":"John","LastName":"Doe","Email":"JohnDoe@gmail.com","Salary":"10000"},{"EmployeeNumber":"1","FirstName":"John","LastName":"Doe","Email":"JohnDoe@gmail.com","Salary":"20000"}]}
```

### POST/UPDATE data using JSON

When a client sends a request to change data (POST/PUT/DELETE) in the
datasource, the HTTP header `         Accept        ` should be set to
`         application/json        ` .  Also, if the data is sent as a
JSON payload, the HTTP header `         Content-Type        ` should be
set to `         application/json        ` .

The RDBMSDataService that you are using contains the following
resources for adding and updating data.

- Resource for adding employee information:
    
    - **Resource Path**: `Employee`
    - **Resource Method**: `POST `
    - **Query ID**: `AddEmployeeDetails`

- Resource for updating employee information:

    - **Resource Path**: `Employee`
    - **Resource Method**: `PUT`
    - **Query ID**: `UpdateEmployeeDetails`

You can RESTfully invoke the above resource by sending HTTP requests as
explained below.

#### Post data

To post new employee information, you need to invoke the resource with
the POST method.

1.  First, create a file named
    `           employee-payload.json          ` , and define the JSON
    payload for posting new data as shown below.

    ```json
    {
      "user_defined_value": {
        "EmployeeNumber" : "14001",
        "LastName": "Smith",
        "FirstName": "Will",
        "Email": "will@google.com",
        "Salary": "15500.0"
      }
    }
    ```

2.  On the terminal, navigate to the location where the
    **`            employee-payload.json           `** file is stored,
    and execute the following HTTP request:

    ```bash
    curl -X POST -H 'Accept: application/json'  -H 'Content-Type: application/json' --data "@employee-payload.json" -k -v http://localhost:8290/services/RDBMSDataService/Employee
    ```

#### Post data in batches

You are able to post JSON data in batches using the
`         RDBMSDataService        ` that you created or uploaded.

!!! Info
    Verify that batch requesting is enabled for the data service.

1.  First, create a file named
    **`            employee-batch-payload.json           `** , and
    define the JSON payload for posting multiple employee records
    (batch) as shown below.

    ```bash
    {
        "user_defined_value": {
            "user_defined_value": [
                {
                    "EmployeeNumber": "5012",
                    "FirstName": "Will",
                    "LastName": "Smith",
                    "Email": "will@smith.com",
                    "Salary": "13500.0"
                },
                {
                    "EmployeeNumber": "5013",
                    "FirstName": "Parker",
                    "LastName": "Peter",
                    "Email": "peter@parker.com",
                    "Salary": "15500.0"
                }
            ]
        }
    }
    ```

2.  On the terminal, navigate to the location where the
    **`            employee-batch-payload.json           `** file is
    stored, and execute the following HTTP request:

    ```bash
    curl -X POST -H 'Accept: application/json'  -H 'Content-Type: application/json' --data "@employee-batch-payload.json" -k -v http://localhost:8290/services/RDBMSDataService/Employee_batch_req
    ```

#### Update data

To update the existing employee records, you need to invoke the resource
with the PUT method.

1.  First, create a file named
    **`            employee-upload-update.json           `** , and
    define the JSON payload for updating an existing employee record as
    shown below.  
    For example, change the salary amount. Make sure that the employee
    number already exists in the database.

    ```bash
    {
      "user_defined_value": {
        "EmployeeNumber" : "1",
        "FirstName": "Will",
        "LastName": "Smith",
        "Email": "will@smith.com",
        "Salary": "78500.0"
      }
    }
    ```

2.  On the terminal, navigate to the location where the
    **`            employee-upload-update.json           `** file is
    stored, and execute the following HTTP request:

    ```bash
    curl -X PUT -H 'Accept: application/json'  -H 'Content-Type: application/json' --data "@employee-upload-update.json" -k -v http://localhost:8290/services/RDBMSDataService/Employee
    ```

#### Post data using Request Box

When the Request Box feature is enabled, you can invoke multiple
operations (consecutively) using one single operation. The process of
posting a JSON payload through a request box transaction is explained
below.

!!! Info
    Verify that batch requesting is enabled for the data service.

1.  First, create a file named
    **`            employee-request-box-payload           `**
    **`            .json           `** , and define the JSON payload for
    posting multiple employee records (batch) as shown below.

    !!! Tip
        The following payload works for this use case. When you create
        payloads for different use cases, be mindful of the tips [given
        here](#UsingJSONwithDataServices-JSON_payloads) .
    

    ```json
    {
     "request_box"  : { 
          "_postemployee" : {
                    "EmployeeNumber"  : "14005", 
                    "LastName" :  "Smith" ,
                    "FirstName" :  "Will" , 
                    "Email" :  "will@google.com" ,
                    "Salary" : "15500.0"
                            },
          "_getemployee_employeenumber":{
                    "EmployeeNumber"  : "14005"
               }
        }
    }
    ```

2.  On the terminal, navigate to the location where the
    **`            employee-request-box-payload.json           `** file
    is stored, and execute the following HTTP request:

    ```bash
    curl -X POST -H 'Accept: application/json'  -H 'Content-Type: application/json' --data "@employee-request-box-payload.json" http://localhost:8290/services/RDBMSDataService/request_box
    ```

!!! Tip
    **Creating JSON payloads for Request Box transactions**

    Note the following when you define a JSON payload for a request box
    transaction: The object name specified in the payload must be in the
    following format: " `         _<HTTP_METHOD><RESOURCE_PATH>        `
    " where `         RESOURCE_PATH        ` represents the path value
    specified in the data service resource. For example, if the
    `         RESOURCE_PATH        ` is "employee", the payload object name
    should be as follows:

    -   For HTTP POST requests: `          _postemployee         `
    -   For HTTP PUT requests: `          _putemployee         `

    The child name/values of the child fields in the payload should be the
    names and values of the input parameters in the target query.

    **Handling a resource path with the "/" symbol**

    If the `         RESOURCE_PATH        ` specified in the data service
    contains the "/" symbol, be sure to replace the "/" symbol with the
    underscore symbol ("\") in the payload object name.

    **Important!** In this scenario, the `         RESOURCE_PATH        ` value should only contain simple letters. For example, the value can be " `         /employee/add"        ` but not " `/Employee/Add"`.

    For example, if the `         RESOURCE_PATH        ` is
    `         /employee/add        ` , the payload object name should be as
    follows:

    -   For HTTP POST requests: `          _post_employee_add         `
    -   For HTTP PUT requests: `          _put_employee_add         `


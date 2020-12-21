# Working with Employee Addresses

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update work contracts of employees

| Operation | Description |
| ------------- |-------------|
|[GET Employee Work Contracts](#retrieving-employee-work-contracts)| Retrieve work contracts used in UK to represent the employee contracted work duration. |
|[POST Employee Work Contracts](#creating-employee-work-contracts)| Create work contracts used in UK to represent the employee contracted work duration. |
|[PATCH Employee Work Contracts](#updating-employee-work-contracts)| Update work contracts used in UK to represent the employee contracted work duration. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Work Contracts
We can use GET Employee Work Contracts operation with required parameters to get the work contracts of employees.

**GET Employee Work Contracts**
```xml
<ceridiandayforce.getEmployeeWorkContracts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeWorkContracts>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* contextDate (Optional): The Context Date value is an “as-of” date used to determine which employee data to search when records have specific start and end dates. The service defaults to the current datetime if the requester does not specify a value. Example: 2017-01-01T13:24:56
* contextDateRangeFrom (Optional): The Context Date Range From value is the start of the range of dates used to determine which employee data to search when records have specific start and end dates. The service defaults to null if the requester does not specify a value. Example: 2017-01-01T13:24:56
* contextDateRangeTo (Optional): The Context Date Range To value is the end of the range of dates to determine which employee data to search when records have specific start and end dates. The service defaults to null if the requester does not specify a value. Example: 2017-01-01T13:24:56

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "contextDateRangeFrom": "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "BaseComplementaryHours": 0.00000,
            "CreateShiftOnHolidays": false,
            "StartDate": "2019-09-01T00:00:00",
            "WorkContract": {
                "XRefCode": "FT Monthly 100%",
                "ShortName": "FT Monthly 100%"
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Work-Contracts/GET-Employee-Work-Contracts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Work-Contracts/GET-Employee-Work-Contracts.aspx)

#### Creating Employee Work Contracts
We can use POST Employee Work Contracts operation with required parameters to create work contracts for employees.

**POST Employee Work Contracts**
```xml
<ceridiandayforce.postEmployeeWorkContracts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeWorkContracts>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* isValidateOnly (Mandatory): When a TRUE value is used in this parameter, POST and PATCH operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "isValidateOnly": "true",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
      "BaseComplementaryHours": 0,
      "CreateShiftOnHolidays": false,
      "StartDate": "2019-09-01T00:00:00",
      "WorkContract": {
        "XRefCode": "FT Monthly 100%",
        "ShortName": "FT Monthly 100%"
      }
    }
}
```

**Sample response**

Dayforce returns 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Work-Contracts/POST-Employee-Work-Contracts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Work-Contracts/POST-Employee-Work-Contracts.aspx)

#### Updating Employee Work Contracts
We can use PATCH Employee Work Contracts operation with required parameters to update the work contracts of employees

**PATCH Employee Work Contracts**
```xml
<ceridiandayforce.patchEmployeeWorkContracts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeWorkContracts>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* isValidateOnly (Mandatory): When a TRUE value is used in this parameter, POST and PATCH operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "isValidateOnly": "true",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
      "BaseComplementaryHours": 0,
      "CreateShiftOnHolidays": false,
      "StartDate": "2019-09-01T00:00:00",
      "WorkContract": {
        "XRefCode": "FT Monthly 100%",
        "ShortName": "FT Monthly 100%"
      }
    }
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Work-Contracts/PATCH-Employee-Work-Contracts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Work-Contracts/PATCH-Employee-Work-Contracts.aspx)

### Sample configuration

Following example illustrates how to connect to Dayforce with the init operation and query operation.

1.Create a sample proxy as below :
```xml
<?xml version="1.0" encoding="UTF-8"?>
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="query"
       startOnLoad="true"
       statistics="disable"
       trace="disable"
       transports="http,https">
   <target>
      <inSequence>
         <log level="full" separator=","/>
         <property expression="json-eval($.username)" name="username"/>
         <property expression="json-eval($.password)" name="password"/>
         <property expression="json-eval($.clientNamespace)" name="clientNamespace"/>
         <property expression="json-eval($.apiVersion)" name="apiVersion"/>
         <property expression="json-eval($.xRefCode)" name="xRefCode"/>
         <property expression="json-eval($.isValidateOnly)" name="isValidateOnly"/>
         <property expression="json-eval($.fieldAndValue)" name="fieldAndValue"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.patchEmployeeWorkContracts>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
         </ceridiandayforce.patchEmployeeWorkContracts>
         <send/>
      </inSequence>
   </target>
   <description/>
</proxy>
```

2.Create a json file named query.json and copy the configurations given below to it:

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "isValidateOnly": "true",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
      "BaseComplementaryHours": 0,
      "CreateShiftOnHolidays": false,
      "StartDate": "2019-09-01T00:00:00",
      "WorkContract": {
        "XRefCode": "FT Monthly 100%",
        "ShortName": "FT Monthly 100%"
      }
    }
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200

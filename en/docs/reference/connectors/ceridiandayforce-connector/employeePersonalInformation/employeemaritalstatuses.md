# Working with Employee Marital Statuses

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update marital status of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Marital Statuses](#retrieving-employee-marital-statuses)| Retrieve an employee's marital statuses information. |
|[POST Employee Marital Statuses](#creating-employee-marital-statuses)| Create an employee's marital statuses information. |
|[PATCH Employee Marital Statuses](#updating-employee-marital-statuses)| Update an employee's marital statuses information. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Marital Statuses
We can use GET Employee Marital Statuses operation with required parameters to retrieve the marital status information of an employee.

**GET Employee Marital Statuses**
```xml
<ceridiandayforce.getEmployeeMaritalStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeMaritalStatuses>
```

**Properties**

* xRefCode (Mandatory): he unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
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
  "isValidateOnly": "true",
  "contextDateRangeFrom": "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "MaritalStatus": {
                "XRefCode": "SINGLE",
                "ShortName": "Single",
                "LongName": "Single"
            },
            "EffectiveStart": "2000-01-01T00:00:00"
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Marital-Statuses/GET-Marital-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Marital-Statuses/GET-Marital-Statuses.aspx)

#### Creating Employee Marital Statuses
We can use POST Employee Marital Statuses operation with required parameters to create the required employee's marital status.

**POST Employee Marital Statuses**
```xml
<ceridiandayforce.postEmployeeMaritalStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeMaritalStatuses>
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
            "MaritalStatus": {
                "XRefCode": "SINGLE",
                "ShortName": "Single",
                "LongName": "Single"
            },
            "EffectiveStart": "2000-01-01T00:00:00"
        }
}
```

**Sample response**

This method returns a HTTP code 200 and no reponse body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Marital-Statuses/POST-Employee-Marital-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Marital-Statuses/POST-Employee-Marital-Statuses.aspx)

#### Updating Employee Marital Statuses
We can use PATCH Employee Marital Statuses operation with required parameters to update the marital status information  of existing employees.

**PATCH Employee Marital Statuses**
```xml
<ceridiandayforce.patchEmployeeMaritalStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeMaritalStatuses>
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
            "MaritalStatus": {
                "XRefCode": "SINGLE",
                "ShortName": "Single",
                "LongName": "Single"
            },
            "EffectiveStart": "2000-01-01T00:00:00"
        }
}
```

**Sample response**

This operation returns HTTP code 200 with no response body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Marital-Statuses/PATCH-Employee-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Marital-Statuses/PATCH-Employee-Statuses.aspx)

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
         <property expression="json-eval($.contextDateRangeFrom)" name="contextDateRangeFrom"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getEmployeeMaritalStatuses>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
         </ceridiandayforce.getEmployeeMaritalStatuses>
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
  "contextDateRangeFrom": "2017-01-01T13:24:56"
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200 with the following response body

```json
{
    "Data": [
        {
            "MaritalStatus": {
                "XRefCode": "SINGLE",
                "ShortName": "Single",
                "LongName": "Single"
            },
            "EffectiveStart": "2000-01-01T00:00:00"
        }
    ]
}
```

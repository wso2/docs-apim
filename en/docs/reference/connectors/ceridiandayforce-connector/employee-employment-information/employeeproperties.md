# Working with Employee Properties

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update properties of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Properties](#retrieving-employee-properties)| Retrieve employee properties that represent custom defined information. |
|[POST Employee Properties](#creating-employee-properties)| Create employee properties that represent custom defined information. |
|[PATCH Employee Properties](#updating-employee-properties)| Update employee properties that represent custom defined information. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Properties
We can use GET Employee Properties operation with required parameters to search and find the required employees' properties.

**GET Employee Properties**
```xml
<ceridiandayforce.getEmployeeProperties>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeProperties>
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
  "contextDate": "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "EffectiveStart": "2000-01-01T00:00:00",
            "EmployeeProperty": {
                "DataType": 1,
                "EmployeeCardinality": 0,
                "GenerateHREvent": false,
                "XRefCode": "EmployeePropertyXrefCode1",
                "ShortName": "Shoe Size",
                "LongName": "Shoe Size"
            },
            "NumberValue": 11.00000
        },
        {
            "EffectiveStart": "2000-01-01T00:00:00",
            "EmployeeProperty": {
                "DataType": 0,
                "EmployeeCardinality": 1,
                "GenerateHREvent": false,
                "XRefCode": "EmployeePropertyXrefCode2",
                "ShortName": "Dietary Restrictions",
                "LongName": "Dietary Restrictions"
            },
            "OptionValue": {
                "XRefCode": "LACTOSE INTOLERANT",
                "ShortName": "Lactose Intolerant",
                "LongName": "Lactose Intolerant"
            }
        },
        {
            "EffectiveStart": "2000-01-01T00:00:00",
            "EmployeeProperty": {
                "DataType": 0,
                "EmployeeCardinality": 1,
                "GenerateHREvent": false,
                "XRefCode": "EmployeePropertyXrefCode2",
                "ShortName": "Dietary Restrictions",
                "LongName": "Dietary Restrictions"
            },
            "OptionValue": {
                "XRefCode": "GLUTEN FREE",
                "ShortName": "Gluten Free",
                "LongName": "Gluten Free"
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Properties/GET-Employee-Properties.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Properties/GET-Employee-Properties.aspx)

#### Creating Employee Properties
We can use POST Employee Properties operation with required parameters to create properties for an employee.

**POST Employee Properties**
```xml
<ceridiandayforce.postEmployeeProperties>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeProperties>
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
      "EffectiveStart": "2000-01-01T00:00:00",
      "EmployeeProperty": {
        "DataType": 1,
        "EmployeeCardinality": 0,
        "GenerateHREvent": false,
        "XRefCode": "EmployeePropertyXrefCode1",
        "ShortName": "Shoe Size",
        "LongName": "Shoe Size"
      },
      "NumberValue": 11
    }
}
```

**Sample response**

Dayforce returns HTTP Code 200.

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Properties/POST-Employee-Properties.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Properties/POST-Employee-Properties.aspx)

#### Updating Employee Properties
We can use PATCH Employee Properties operation with required parameters to update employee properties.

**PATCH Employee Properties**
```xml
<ceridiandayforce.patchEmployeeProperties>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeProperties>
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
      "EffectiveStart": "2000-01-01T00:00:00",
      "EmployeeProperty": {
        "DataType": 1,
        "EmployeeCardinality": 0,
        "GenerateHREvent": false,
        "XRefCode": "EmployeePropertyXrefCode1",
        "ShortName": "Shoe Size",
        "LongName": "Shoe Size"
      },
      "NumberValue": 11
    }
}
```

**Sample response**

Dayforce returns HTTP Code 200.

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Properties/PATCH-Employee-Properties.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Properties/PATCH-Employee-Properties.aspx)

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
         <ceridiandayforce.postEmployeeProperties>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
         </ceridiandayforce.postEmployeeProperties>
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
      "EffectiveStart": "2000-01-01T00:00:00",
      "EmployeeProperty": {
        "DataType": 1,
        "EmployeeCardinality": 0,
        "GenerateHREvent": false,
        "XRefCode": "EmployeePropertyXrefCode1",
        "ShortName": "Shoe Size",
        "LongName": "Shoe Size"
      },
      "NumberValue": 11
    }
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200.
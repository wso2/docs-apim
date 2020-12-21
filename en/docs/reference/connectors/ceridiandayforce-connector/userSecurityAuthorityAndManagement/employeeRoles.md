# Working with Employee Roles

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update roles of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Roles](#retrieving-employee-roles)| Retrieve user roles assigned to an employee. |
|[POST Employee Roles](#creating-employee-roles)| Assign roles to an employee. |
|[PATCH Employee Roles](#updating-employee-roles)| Update the assigned roles to an employee.  |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Roles
We can use GET Employee Roles operation with required parameters to search and find the roles of a required employees.

**GET Employee Roles**
```xml
<ceridiandayforce.getEmployeeRoles>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeRoles>
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
            "IsDefault": true,
            "Role": {
                "XRefCode": "MAssociate",
                "ShortName": "MAssociate",
                "LongName": "MAssociate"
            },
            "EffectiveStart": "2015-12-02T00:00:00",
            "IsPrestartRole": false
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/Roles/GET-Employee-Roles.aspx](https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/Roles/GET-Employee-Roles.aspx)

#### Creating Employee Roles
We can use POST Employee Roles operation with required parameters to assign roles to an employee.

**POST Employee Roles**
```xml
<ceridiandayforce.postEmployeeRoles>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeRoles>
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
  "fieldAndValue": {
            "IsDefault": true,
            "Role": {
                "XRefCode": "MAssociate",
                "ShortName": "MAssociate",
                "LongName": "MAssociate"
            },
            "EffectiveStart": "2015-12-02T00:00:00",
            "IsPrestartRole": false
        }
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/Roles/POST-Employee-Roles.aspx](https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/Roles/POST-Employee-Roles.aspx)

#### Updating Employee Roles
We can use PATCH Employee Roles operation with required parameters to update the roles of an employee

**PATCH Employee Roles**
```xml
<ceridiandayforce.patchEmployeeRoles>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeRoles>
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
  "fieldAndValue": {
            "IsDefault": true,
            "Role": {
                "XRefCode": "MAssociate",
                "ShortName": "MAssociate",
                "LongName": "MAssociate"
            },
            "EffectiveStart": "2015-12-02T00:00:00",
            "IsPrestartRole": false
        }
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/Roles/PATCH-Employee-Roles.aspx](https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/Roles/PATCH-Employee-Roles.aspx)

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
         <ceridiandayforce.patchEmployeeRoles>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
         </ceridiandayforce.patchEmployeeRoles>
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
  "fieldAndValue": {
            "IsDefault": true,
            "Role": {
                "XRefCode": "MAssociate",
                "ShortName": "MAssociate",
                "LongName": "MAssociate"
            },
            "EffectiveStart": "2015-12-02T00:00:00",
            "IsPrestartRole": false
        }
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200

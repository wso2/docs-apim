# Working with User Pay Adjustment Code Groups

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve User Pay Adjustment Code Groups of an employee

| Operation | Description |
| ------------- |-------------|
|[GET User Pay Adjustment Code Groups](#retrieving-user-pay-adjustment-code-groups)| Retrieve User Pay Adjustment Groups assigned to an employee.  These control which pay adjustment codes the employee can assign to timesheets. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving User Pay Adjustment Code Groups
We can use GET User Pay Adjustment Code Groups operation with required parameters to search and find the required employees.

**GET User Pay Adjustment Code Groups**
```xml
<ceridiandayforce.getUserPayAdjustCodeGroups>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
</ceridiandayforce.getUserPayAdjustCodeGroups>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "PayAdjCodeGroup": {
                "XRefCode": "Timesheet",
                "ShortName": "Timesheet",
                "LongName": "Timesheet"
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/User-Pay-Adjustment-Groups/GET-User-Pay-Adjustment-Code-Groups.aspx](https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/User-Pay-Adjustment-Groups/GET-User-Pay-Adjustment-Code-Groups.aspx)

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
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getUserPayAdjustCodeGroups>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getUserPayAdjustCodeGroups>
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
  "xRefCode": "42199"
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
            "PayAdjCodeGroup": {
                "XRefCode": "Timesheet",
                "ShortName": "Timesheet",
                "LongName": "Timesheet"
            }
        }
    ]
}
```

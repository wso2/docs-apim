# Working with Employee Schedules

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve schedules of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Schedules](#retrieving-employee-schedules)| Retrieve the configured schedules for a single employee for every day within a defined period. In order to use this request, an employee XRefCodes is needed. Employee XRefCodes can be retrieved with GET Employees. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Schedules
We can use GET Schedules operation with required parameters to find the schedules of employees.

**GET Schedules**
```xml
<ceridiandayforce.getSchedules>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <filterScheduleStartDate>{$ctx:filterScheduleStartDate}</filterScheduleStartDate>
    <filterScheduleEndDate>{$ctx:filterScheduleEndDate}</filterScheduleEndDate>
    <isPosted>{$ctx:isPosted}</isPosted>
    <expand>{$ctx:expand}</expand>
</ceridiandayforce.getSchedules>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* filterScheduleStartDate (Mandatory): Inclusive period start aligned to the employee business day start date to determine which employee schedule data to retrieve . Example: 2017-01-01T13:24:56
* filterScheduleEndDate (Mandatory): Exclusive period end aligned to the employee business day start to determine which employee schedule data to retrieve . Example: 2017-01-01T13:24:56
* isPosted (Optional - boolean): A flag to determine whether to display posted schedules.By default it searches for published schedules
* expand (Optional - string): This parameter accepts a comma-separated list of top-level entities that contain the data elements needed for downstream processing. When this parameter is not used, only data elements from the primary record will be included. For more information, please refer to the Introduction to Dayforce Web Services document.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "filterScheduleStartDate": "2018-02-04T00:00:00",
  "filterScheduleEndDate": "2018-02-18T00:00:00"
}
```

**Sample response**

Given below is a sample response for this operation.

```json

```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Time-Management/GET-Employee-Schedules.aspx](https://developers.dayforce.com/Build/API-Explorer/Time-Management/GET-Employee-Schedules.aspx)

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
         <property expression="json-eval($.contextDate)" name="contextDate"/>
         <property expression="json-eval($.filterScheduleStartDate)" name="filterScheduleStartDate"/>
         <property expression="json-eval($.filterScheduleEndDate)" name="filterScheduleEndDate"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getSchedules>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <filterScheduleStartDate>{$ctx:filterScheduleStartDate}</filterScheduleStartDate>
            <filterScheduleEndDate>{$ctx:filterScheduleEndDate}</filterScheduleEndDate>
         </ceridiandayforce.getSchedules>
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
  "filterScheduleStartDate": "2018-02-04T00:00:00",
  "filterScheduleEndDate": "2018-02-18T00:00:00"
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200 with the following response body

```json

```

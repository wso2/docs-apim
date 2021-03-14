# Working with Employee Availability

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve the availability of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Availability](#retrieving-employee-availability)| Availabilty represents the periods an employee is available to be scheduled for work. This request allows you to retrieve a single employee's daily availability between two dates. In order to use it, an employee XRefCodes is needed. Employee XRefCodes can be retrieved with GET Employees. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Availability
We can use GET Availability operation with required parameters to search and find availability of required employees.

**GET Availability**
```xml
<ceridiandayforce.getAvailability>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <filterAvailabilityStartDate>{$ctx:filterAvailabilityStartDate}</filterAvailabilityStartDate>
    <filterAvailabilityEndDate>{$ctx:filterAvailabilityEndDate}</filterAvailabilityEndDate>
</ceridiandayforce.getAvailability>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* filterAvailabilityStartDate (Mandatory): Inclusive period start date to determine which employee availability data to retrieve . Example: 2017-01-01T00:00:00
* filterAvailabilityEndDate (Mandatory): Inclusive period end date to determine which employee availability data to retrieve . Example: 2017-01-01T00:00:00

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "filterAvailabilityStartDate": "2018-02-04T00:00:00",
  "filterAvailabilityEndDate": "2018-02-18T00:00:00"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "DateOfRequest": "2018-02-04T00:00:00",
            "UnAvailable": true,
            "IsDefault": true
        },
        {
            "DateOfRequest": "2018-02-05T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-06T00:00:00",
            "IsDefault": true,
            "StartTime1": "07:00:00",
            "EndTime1": "09:00:00",
            "StartTime2": "14:00:00",
            "EndTime2": "20:00:00"
        },
        {
            "DateOfRequest": "2018-02-07T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-08T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-09T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-10T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-11T00:00:00",
            "UnAvailable": true,
            "IsDefault": true
        },
        {
            "DateOfRequest": "2018-02-12T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-13T00:00:00",
            "IsDefault": true,
            "StartTime1": "07:00:00",
            "EndTime1": "09:00:00",
            "StartTime2": "14:00:00",
            "EndTime2": "20:00:00"
        },
        {
            "DateOfRequest": "2018-02-14T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-15T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-16T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-17T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-18T00:00:00",
            "UnAvailable": true,
            "IsDefault": true
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Time-Management/Employee-Availability.aspx](https://developers.dayforce.com/Build/API-Explorer/Time-Management/Employee-Availability.aspx)

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
         <property expression="json-eval($.filterAvailabilityStartDate)" name="filterAvailabilityStartDate"/>
         <property expression="json-eval($.filterAvailabilityEndDate)" name="filterAvailabilityEndDate"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getAvailability>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <filterAvailabilityStartDate>{$ctx:filterAvailabilityStartDate}</filterAvailabilityStartDate>
            <filterAvailabilityEndDate>{$ctx:filterAvailabilityEndDate}</filterAvailabilityEndDate>
         </ceridiandayforce.getAvailability>
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
  "filterAvailabilityStartDate": "2018-02-04T00:00:00",
  "filterAvailabilityEndDate": "2018-02-18T00:00:00"
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200 with the following body

```json
{
    "Data": [
        {
            "DateOfRequest": "2018-02-04T00:00:00",
            "UnAvailable": true,
            "IsDefault": true
        },
        {
            "DateOfRequest": "2018-02-05T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-06T00:00:00",
            "IsDefault": true,
            "StartTime1": "07:00:00",
            "EndTime1": "09:00:00",
            "StartTime2": "14:00:00",
            "EndTime2": "20:00:00"
        },
        {
            "DateOfRequest": "2018-02-07T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-08T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-09T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-10T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-11T00:00:00",
            "UnAvailable": true,
            "IsDefault": true
        },
        {
            "DateOfRequest": "2018-02-12T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-13T00:00:00",
            "IsDefault": true,
            "StartTime1": "07:00:00",
            "EndTime1": "09:00:00",
            "StartTime2": "14:00:00",
            "EndTime2": "20:00:00"
        },
        {
            "DateOfRequest": "2018-02-14T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-15T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-16T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-17T00:00:00",
            "IsDefault": true,
            "StartTime1": "00:00:00",
            "EndTime1": "1.00:00:00"
        },
        {
            "DateOfRequest": "2018-02-18T00:00:00",
            "UnAvailable": true,
            "IsDefault": true
        }
    ]
}
```

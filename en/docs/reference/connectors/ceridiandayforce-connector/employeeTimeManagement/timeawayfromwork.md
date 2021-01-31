# Working with Employee Time Away from Work

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve time away from work of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Time Away from Work](#retrieving-employee-time-away-from-work)| Retrieve the scheduled time away from work (TAFW) periods of a single employee. In order to use this request, an employee XRefCodes is needed. Employee XRefCodes can be retrieved with GET Employees. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Time Away from Work
We can use GET Employee Time Away from Work operation with required parameters to get the time spent by employees away from work.

**GET Employee Time Away from Work**
```xml
<ceridiandayforce.getTimeAwayFromWork>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <filterTAFWStartDate>{$ctx:filterTAFWStartDate}</filterTAFWStartDate>
    <filterTAFWEndDate>{$ctx:filterTAFWEndDate}</filterTAFWEndDate>
    <status>{$ctx:status}</status>
</ceridiandayforce.getTimeAwayFromWork>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* filterTAFWStartDate (Mandatory - string): Inclusive period start date to determine which employee time away from work data to retrieve . Example: 2017-01-01T13:24:56
* filterTAFWEndDate (Mandatory - string): Exclusive period end date to determine which employee time away from work data to retrieve . Example: 2017-01-01T13:24:56
* status (Mandatory - string): A case-sensitive field containing status for time away from work values. Examples: [APPROVED,PENDING,CANCELED,DENIED,CANCELPENDING]

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "filterTAFWStartDate": "2018-02-04T00:00:00",
  "filterTAFWEndDate": "2018-02-18T00:00:00",
  "status": "APPROVED"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "DateOfRequest": "2018-02-07T09:50:00",
            "TimeStart": "2018-02-07T00:00:00",
            "TimeEnd": "2018-02-09T00:00:00",
            "NetHours": 16.000,
            "ReasonName": "Sick",
            "AllDay": true
        },
        {
            "DateOfRequest": "2018-02-07T09:52:00",
            "TimeStart": "2018-02-14T00:00:00",
            "TimeEnd": "2018-02-15T00:00:00",
            "NetHours": 8.000,
            "ReasonName": "Training",
            "AllDay": true
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Time-Management/GET-Employee-TAFW.aspx](https://developers.dayforce.com/Build/API-Explorer/Time-Management/GET-Employee-TAFW.aspx)

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
         <property expression="json-eval($.status)" name="status"/>
         <property expression="json-eval($.filterTAFWStartDate)"
                   name="filterTAFWStartDate"/>
         <property expression="json-eval($.filterTAFWEndDate)" name="filterTAFWEndDate"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getTimeAwayFromWork>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <filterTAFWStartDate>{$ctx:filterTAFWStartDate}</filterTAFWStartDate>
            <filterTAFWEndDate>{$ctx:filterTAFWEndDate}</filterTAFWEndDate>
            <status>{$ctx:status}</status>
         </ceridiandayforce.getTimeAwayFromWork>
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
  "filterTAFWStartDate": "2018-02-04T00:00:00",
  "filterTAFWEndDate": "2018-02-18T00:00:00",
  "status": "APPROVED"
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
            "DateOfRequest": "2018-02-07T09:50:00",
            "TimeStart": "2018-02-07T00:00:00",
            "TimeEnd": "2018-02-09T00:00:00",
            "NetHours": 16.000,
            "ReasonName": "Sick",
            "AllDay": true
        },
        {
            "DateOfRequest": "2018-02-07T09:52:00",
            "TimeStart": "2018-02-14T00:00:00",
            "TimeEnd": "2018-02-15T00:00:00",
            "NetHours": 8.000,
            "ReasonName": "Training",
            "AllDay": true
        }
    ]
}
```

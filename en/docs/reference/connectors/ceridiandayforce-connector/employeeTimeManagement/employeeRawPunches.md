# Working with Employee Raw Punches

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create raw punches of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Raw Punches](#retrieving-employee-raw-punches)| Retrieve raw punches as they are entered at the clock. |
|[POST Employee Raw Punches](#creating-employee-raw-punches)| Insert a raw punch. This raw punch record will be treated as a punch coming from the clock and be validated against configured punch policies. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Raw Punches
We can use GET Employee Raw Punches operation with required parameters to retrieve raw punches of employees.

**GET Employee Raw Punches**
```xml
<ceridiandayforce.getEmployeeRawPunches>
    <filterTransactionStartTimeUTC>{$ctx:filterTransactionStartTimeUTC}</filterTransactionStartTimeUTC>
    <filterTransactionEndTimeUTC>{$ctx:filterTransactionEndTimeUTC}</filterTransactionEndTimeUTC>
    <employeeXRefCode>{$ctx:employeeXRefCode}</employeeXRefCode>
    <employeeBadge>{$ctx:employeeBadge}</employeeBadge>
    <punchState>{$ctx:punchState}</punchState>
    <punchTypes>{$ctx:punchTypes}</punchTypes>
    <pageSize>{$ctx:pageSize}</pageSize>
</ceridiandayforce.getEmployeeRawPunches>
```

**Properties**

* filterTransactionStartTimeUTC (Mandatory): Inclusive transaction period start date in UTC to determine which employee punch data to retrieve. Example: 2017-01-01T00:00:00
* filterTransactionEndTimeUTC (Mandatory): Inclusive transaction period end date in UTC to determine which employee punch data to retrieve. Example: 2017-01-01T00:00:00
* employeeXRefCode (Optional): The unique identifier (external reference code) of the employee to be retrieved. The value provided must be the exact match for an employee
* employeeBadge (Optional): The badge number of the employee to be retrieved. The value provided must be the exact match for a badge
* punchState (Optional): The state of the punch. Examples: [PROCESSED, REJECTED, ALL]
* punchTypes (Optional): Comma separated values of punch types. Example: [Punch_In, Break_Out, Job_Transfer, ALL, etc]
* pageSize (Optional): The number of records returned per page in the paginated response

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "filterTransactionStartTimeUTC": "2019-06-03T00:00:00",
  "filterTransactionEndTimeUTC": "2019-06-05T00:00:00"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "RawPunchXRefCode": "#DF_322",
            "PunchState": "Rejected",
            "EmployeeBadge": "42199",
            "RawPunchTime": "2019-06-04T11:28:28-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Punch_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "RejectedReason": "Employee Badge Validation",
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_323",
            "PunchState": "Rejected",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T11:28:56-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Punch_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "RejectedReason": "Shift Start Validation",
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_324",
            "PunchState": "Processed",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T11:30:00-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Punch_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_325",
            "PunchState": "Processed",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T11:30:18-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Meal_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_326",
            "PunchState": "Processed",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T18:28:28-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Meal_Out",
            "PunchDevice": "API",
            "IsDuplicate": false,
            "IPAddress": "63.235.55.130",
            "PunchOrigin": "C"
        }
    ],
    "Paging": {
        "Next": ""
    }
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Time-Management/GET-Employee-Raw-Punches.aspx](https://developers.dayforce.com/Build/API-Explorer/Time-Management/GET-Employee-Raw-Punches.aspx)

#### Creating Employee Raw Punches
We can use POST Employee Raw Punches operation with required parameters to create raw punches for employees.

**POST Employee Raw Punches**
```xml
<ceridiandayforce.postEmployeeRawPunches>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeRawPunches>
```

**Properties**

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
	  "EmployeeBadge": "33333",
	  "RawPunchTime": "2019-06-04T11:28:28-04:00",
	  "PunchType": "Punch_In",
	  "PunchDevice": "API"
	}
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Time-Management/POST-Employee-Raw-Punches.aspx](https://developers.dayforce.com/Build/API-Explorer/Time-Management/POST-Employee-Raw-Punches.aspx)

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
         <property expression="json-eval($.filterTransactionStartTimeUTC)" name="filterTransactionStartTimeUTC"/>
         <property expression="json-eval($.filterTransactionEndTimeUTC)" name="filterTransactionEndTimeUTC"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getEmployeeRawPunches>
            <filterTransactionStartTimeUTC>{$ctx:filterTransactionStartTimeUTC}</filterTransactionStartTimeUTC>
            <filterTransactionEndTimeUTC>{$ctx:filterTransactionEndTimeUTC}</filterTransactionEndTimeUTC>
         </ceridiandayforce.getEmployeeRawPunches>
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
  "filterTransactionStartTimeUTC": "2019-06-03T00:00:00",
  "filterTransactionEndTimeUTC": "2019-06-05T00:00:00"
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
            "RawPunchXRefCode": "#DF_322",
            "PunchState": "Rejected",
            "EmployeeBadge": "42199",
            "RawPunchTime": "2019-06-04T11:28:28-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Punch_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "RejectedReason": "Employee Badge Validation",
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_323",
            "PunchState": "Rejected",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T11:28:56-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Punch_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "RejectedReason": "Shift Start Validation",
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_324",
            "PunchState": "Processed",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T11:30:00-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Punch_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_325",
            "PunchState": "Processed",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T11:30:18-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Meal_In",
            "PunchDevice": "prdemo500bHTML",
            "IsDuplicate": false,
            "IPAddress": "10.66.25.192",
            "PunchOrigin": "C"
        },
        {
            "RawPunchXRefCode": "#DF_326",
            "PunchState": "Processed",
            "EmployeeXRefCode": "42199",
            "EmployeeBadge": "33333",
            "RawPunchTime": "2019-06-04T18:28:28-04:00",
            "WasOfflinePunch": false,
            "PunchType": "Meal_Out",
            "PunchDevice": "API",
            "IsDuplicate": false,
            "IPAddress": "63.235.55.130",
            "PunchOrigin": "C"
        }
    ],
    "Paging": {
        "Next": ""
    }
}
```

# Working with Employee Punches

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve work  shift data of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Punches](#retrieving-employee-punches)| Extract the worked shift data for several employees at a time. Required parameters for the call include FilterTransactionStartTimeUTC and FilterTransactionEndTimeUTC. The system will search for all employee punch records that were modified between these two dates. The two dates must be 7 days apart or less. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Punches
We can use GET Employee Punches operation with required parameters to get work shift data of an employee.

**GET Employee Punches**
```xml
<ceridiandayforce.getEmployeePunches>
    <filterTransactionStartTimeUTC>{$ctx:filterTransactionStartTimeUTC}</filterTransactionStartTimeUTC>
    <filterTransactionEndTimeUTC>{$ctx:filterTransactionEndTimeUTC}</filterTransactionEndTimeUTC>
    <employeeXRefCode>{$ctx:employeeXRefCode}</employeeXRefCode>
    <locationXRefCode>{$ctx:locationXRefCode}</locationXRefCode>
    <positionXRefCode>{$ctx:positionXRefCode}</positionXRefCode>
    <departmentXRefCode>{$ctx:departmentXRefCode}</departmentXRefCode>
    <jobXRefCode>{$ctx:jobXRefCode}</jobXRefCode>
    <docketXRefCode>{$ctx:docketXRefCode}</docketXRefCode>
    <projectXRefCode>{$ctx:projectXRefCode}</projectXRefCode>
    <payAdjustmentXRefCode>{$ctx:payAdjustmentXRefCode}</payAdjustmentXRefCode>
    <shiftStatus>{$ctx:shiftStatus}</shiftStatus>
    <filterShiftTimeStart>{$ctx:filterShiftTimeStart}</filterShiftTimeStart>
    <filterShiftTimeEnd>{$ctx:filterShiftTimeEnd}</filterShiftTimeEnd>
    <businessDate>{$ctx:businessDate}</businessDate>
    <pageSize>{$ctx:pageSize}</pageSize>
</ceridiandayforce.getEmployeePunches>
```

**Properties**

* filterTransactionStartTimeUTC (Mandatory): Inclusive transaction period start date in UTC to determine which employee punch data to retrieve. Example: 2017-01-01T00:00:00
* filterTransactionEndTimeUTC (Mandatory): Inclusive transaction period end date in UTC to determine which employee punch data to retrieve. Example: 2017-01-01T00:00:00
* employeeXRefCode (Optional): The unique identifier (external reference code) of the employee to be retrieved. The value provided must be the exact match for an employee
* locationXRefCode (Optional): A case-sensitive field that identifies a location or organizational units
* positionXRefCode (Optional): A case-sensitive field that identifies one or more Positions
* departmentXRefCode (Optional): A case-sensitive field that identifies one or more Departments
* jobXRefCode (Optional): A case-sensitive field that identifies one or more Jobs
* docketXRefCode (Optional): A case-sensitive field that identifies one or more dockets
* projectXRefCode (Optional): A case-sensitive field that identifies one or more projects
* payAdjustmentXRefCode (Optional): A case-sensitive field that identifies one or more pay adjustment
* shiftStatus (Optional): A case-sensitive field containing shift status groups. Examples: [ACTIVE, COMPLETED, PROBLEM, ALL]
* filterShiftTimeStart (Optional): Use with FilterTransactionStartTimeUTC to search for shifts with a Start and end time in a given timeframe. Example: Used to include or exclude edits made to historical punches
* filterShiftTimeEnd (Optional): Use with FilterTransactionEndTimeUTC to search for shifts with a Start and end time in a given timeframe. Example: Used to include or exclude edits made to historical
* businessDate (Optional): The Business Date value is intended as a “Timesheet View” to return punch data related to a clients Business day parameter configuration. Example: 2017-01-01T00:00:00
* pageSize (Optional): The number of records returned per page in the paginated response

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "filterTransactionStartTimeUTC": "2019-03-25T00:00:00",
  "filterTransactionEndTimeUTC": "2019-03-29T00:00:00"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "PunchXRefCode": "#DF_1480318",
            "EmployeeXRefCode": "67206",
            "PunchStatus": "c",
            "TimeStart": "2019-03-25T09:00:00",
            "TimeEnd": "2019-03-25T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32014",
            "PositionXRefCode": "Cust. Svc. Dept. Mgr ",
            "DepartmentXRefCode": "14",
            "JobXRefCode": "4",
            "BusinessDate": "2019-03-25T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:29:07.063",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480318",
                    "Type": "m",
                    "TimeStart": "2019-03-25T11:15:00",
                    "TimeEnd": "2019-03-25T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:58.473"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480319",
            "EmployeeXRefCode": "67206",
            "PunchStatus": "c",
            "TimeStart": "2019-03-26T09:00:00",
            "TimeEnd": "2019-03-26T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32014",
            "PositionXRefCode": "Cust. Svc. Dept. Mgr ",
            "DepartmentXRefCode": "14",
            "JobXRefCode": "4",
            "BusinessDate": "2019-03-26T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:29:07.063",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480319",
                    "Type": "m",
                    "TimeStart": "2019-03-26T11:15:00",
                    "TimeEnd": "2019-03-26T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:58.473"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480320",
            "EmployeeXRefCode": "45522",
            "PunchStatus": "c",
            "TimeStart": "2019-03-25T09:00:00",
            "TimeEnd": "2019-03-25T17:00:00",
            "NetHours": 7.000,
            "LocationXRefCode": "Store 32028",
            "PositionXRefCode": "Day Stocker",
            "DepartmentXRefCode": "28",
            "JobXRefCode": "32",
            "BusinessDate": "2019-03-25T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480320",
                    "Type": "m",
                    "TimeStart": "2019-03-25T12:30:00",
                    "TimeEnd": "2019-03-25T13:30:00",
                    "NetHours": 1.000,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480321",
            "EmployeeXRefCode": "45522",
            "PunchStatus": "c",
            "TimeStart": "2019-03-26T09:00:00",
            "TimeEnd": "2019-03-26T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32028",
            "PositionXRefCode": "Day Stocker",
            "DepartmentXRefCode": "28",
            "JobXRefCode": "32",
            "BusinessDate": "2019-03-26T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480321",
                    "Type": "m",
                    "TimeStart": "2019-03-26T11:15:00",
                    "TimeEnd": "2019-03-26T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480322",
            "EmployeeXRefCode": "45522",
            "PunchStatus": "c",
            "TimeStart": "2019-03-28T09:00:00",
            "TimeEnd": "2019-03-28T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32028",
            "PositionXRefCode": "Day Stocker",
            "DepartmentXRefCode": "28",
            "JobXRefCode": "32",
            "BusinessDate": "2019-03-28T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480322",
                    "Type": "m",
                    "TimeStart": "2019-03-28T11:15:00",
                    "TimeEnd": "2019-03-28T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397"
                }
            ]
        }
    ],
    "Paging": {
        "Next": ""
    }
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Time-Management/Employee-Punches.aspx](https://developers.dayforce.com/Build/API-Explorer/Time-Management/Employee-Punches.aspx)

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
         <property expression="json-eval($.status)" name="status"/>
         <property expression="json-eval($.filterTransactionStartTimeUTC)" name="filterTransactionStartTimeUTC"/>
         <property expression="json-eval($.filterTransactionEndTimeUTC)" name="filterTransactionEndTimeUTC"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getEmployeePunches>
            <filterTransactionStartTimeUTC>{$ctx:filterTransactionStartTimeUTC}</filterTransactionStartTimeUTC>
            <filterTransactionEndTimeUTC>{$ctx:filterTransactionEndTimeUTC}</filterTransactionEndTimeUTC>
         </ceridiandayforce.getEmployeePunches>
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
  "filterTransactionStartTimeUTC": "2019-03-25T00:00:00",
  "filterTransactionEndTimeUTC": "2019-03-29T00:00:00"
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200 with  the following response body

```json
{
    "Data": [
        {
            "PunchXRefCode": "#DF_1480318",
            "EmployeeXRefCode": "67206",
            "PunchStatus": "c",
            "TimeStart": "2019-03-25T09:00:00",
            "TimeEnd": "2019-03-25T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32014",
            "PositionXRefCode": "Cust. Svc. Dept. Mgr ",
            "DepartmentXRefCode": "14",
            "JobXRefCode": "4",
            "BusinessDate": "2019-03-25T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:29:07.063",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480318",
                    "Type": "m",
                    "TimeStart": "2019-03-25T11:15:00",
                    "TimeEnd": "2019-03-25T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:58.473"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480319",
            "EmployeeXRefCode": "67206",
            "PunchStatus": "c",
            "TimeStart": "2019-03-26T09:00:00",
            "TimeEnd": "2019-03-26T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32014",
            "PositionXRefCode": "Cust. Svc. Dept. Mgr ",
            "DepartmentXRefCode": "14",
            "JobXRefCode": "4",
            "BusinessDate": "2019-03-26T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:29:07.063",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480319",
                    "Type": "m",
                    "TimeStart": "2019-03-26T11:15:00",
                    "TimeEnd": "2019-03-26T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:58.473"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480320",
            "EmployeeXRefCode": "45522",
            "PunchStatus": "c",
            "TimeStart": "2019-03-25T09:00:00",
            "TimeEnd": "2019-03-25T17:00:00",
            "NetHours": 7.000,
            "LocationXRefCode": "Store 32028",
            "PositionXRefCode": "Day Stocker",
            "DepartmentXRefCode": "28",
            "JobXRefCode": "32",
            "BusinessDate": "2019-03-25T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480320",
                    "Type": "m",
                    "TimeStart": "2019-03-25T12:30:00",
                    "TimeEnd": "2019-03-25T13:30:00",
                    "NetHours": 1.000,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480321",
            "EmployeeXRefCode": "45522",
            "PunchStatus": "c",
            "TimeStart": "2019-03-26T09:00:00",
            "TimeEnd": "2019-03-26T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32028",
            "PositionXRefCode": "Day Stocker",
            "DepartmentXRefCode": "28",
            "JobXRefCode": "32",
            "BusinessDate": "2019-03-26T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480321",
                    "Type": "m",
                    "TimeStart": "2019-03-26T11:15:00",
                    "TimeEnd": "2019-03-26T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397"
                }
            ]
        },
        {
            "PunchXRefCode": "#DF_1480322",
            "EmployeeXRefCode": "45522",
            "PunchStatus": "c",
            "TimeStart": "2019-03-28T09:00:00",
            "TimeEnd": "2019-03-28T17:00:00",
            "NetHours": 7.500,
            "LocationXRefCode": "Store 32028",
            "PositionXRefCode": "Day Stocker",
            "DepartmentXRefCode": "28",
            "JobXRefCode": "32",
            "BusinessDate": "2019-03-28T00:00:00",
            "IsDeleted": false,
            "IsOnCall": false,
            "FuturePunch": false,
            "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397",
            "MealBreaks": [
                {
                    "PunchXRefCode": "#DF_1480322",
                    "Type": "m",
                    "TimeStart": "2019-03-28T11:15:00",
                    "TimeEnd": "2019-03-28T11:45:00",
                    "NetHours": 0.500,
                    "IsAutoInjected": false,
                    "LastModifiedTimestampUtc": "2019-03-28T12:28:59.397"
                }
            ]
        }
    ],
    "Paging": {
        "Next": ""
    }
}
```

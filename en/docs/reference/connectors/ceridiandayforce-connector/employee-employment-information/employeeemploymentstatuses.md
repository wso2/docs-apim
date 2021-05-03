# Working with Employee Employment Statuses

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update employment Statuses of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Employment Statuses](#retrieving-employee-employment-agreement)| Retrieve the employment agreement information of an employee. |
|[POST Employee Employment Statuses](#creating-employee-employment-agreement)| Create the employment agreement information of an employee. |
|[PATCH Employee Employment Statuses](#updating-employee-employment-agreement)| Update the employment agreement information of an employee. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Employment Statuses
We can use GET Employee Contacts operation with required parameters to retrieve the employment status of an employee.

**GET Employee Employee Employment Statuses**
```xml
<ceridiandayforce.getEmployeeEmploymentStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeEmploymentStatuses>
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
  "contextDateRangeFrom": "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "EmployeeNumber": "42199",
            "EffectiveStart": "2014-02-04T00:00:00",
            "EmploymentStatus": {
                "IsBenefitArrearsEnabled": false,
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "EmploymentStatusGroup": {
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "PayType": {
                "XRefCode": "HourlyNon",
                "ShortName": "Hourly(Non-Exempt)",
                "LongName": "Hourly(Non-Exempt)"
            },
            "PayGroup": {
                "PayFrequency": {
                    "PayFrequencyType": "w",
                    "ShortName": "Weekly",
                    "LongName": "Weekly"
                },
                "XRefCode": "USA",
                "ShortName": "USA - Weekly",
                "LongName": "USA - Weekly"
            },
            "PayTypeGroup": {
                "XRefCode": "Hourly",
                "ShortName": "Hourly",
                "LongName": "Hourly"
            },
            "PayClass": {
                "XRefCode": "FT",
                "ShortName": "FT",
                "LongName": "Full Time"
            },
            "PunchPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "PayPolicy": {
                "XRefCode": "MHourly",
                "ShortName": "MHourly ",
                "LongName": "MHourly "
            },
            "PayHolidayGroup": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "EntitlementPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftRotation": {
                "XRefCode": "Morning",
                "ShortName": "Morning",
                "LongName": "Morning"
            },
            "ShiftRotationDayOffset": 0,
            "ShiftRotationStartDate": "2007-12-31T00:00:00",
            "CreateShiftRotationShift": true,
            "TimeOffPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftTradePolicy": {
                "XRefCode": "default",
                "ShortName": "Corporate",
                "LongName": "Corporate"
            },
            "AttendancePolicy": {
                "XRefCode": "DEFAULT",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "SchedulePolicy": {
                "XRefCode": "Manufacturing",
                "ShortName": "Manufacturing",
                "LongName": "Manufacturing"
            },
            "OvertimeGroup": {
                "XRefCode": "OTG1",
                "ShortName": "OT Group 1",
                "LongName": "OT Group 1"
            },
            "PayrollPolicy": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "AlternateRate": 3.00000,
            "AverageDailyHours": 8.0000,
            "BaseRate": 21.50000,
            "BaseSalary": 44720.00000,
            "NormalWeeklyHours": 40.0000,
            "VacationRate": 10.00000
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Statuses/GET-Employee-Employment-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Statuses/GET-Employee-Employment-Statuses.aspx)

#### Creating Employee Employment Statuses
We can use POST Employee Employment Statuses operation with required parameters to create the required employee's employment Status.

**POST Employee Employment Statuses**
```xml
<ceridiandayforce.postEmployeeEmploymentStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeEmploymentStatuses>
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
            "EmployeeNumber": "42199",
            "EffectiveStart": "2014-02-04T00:00:00",
            "EmploymentStatus": {
                "IsBenefitArrearsEnabled": false,
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "EmploymentStatusGroup": {
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "PayType": {
                "XRefCode": "HourlyNon",
                "ShortName": "Hourly(Non-Exempt)",
                "LongName": "Hourly(Non-Exempt)"
            },
            "PayGroup": {
                "PayFrequency": {
                    "PayFrequencyType": "w",
                    "ShortName": "Weekly",
                    "LongName": "Weekly"
                },
                "XRefCode": "USA",
                "ShortName": "USA - Weekly",
                "LongName": "USA - Weekly"
            },
            "PayTypeGroup": {
                "XRefCode": "Hourly",
                "ShortName": "Hourly",
                "LongName": "Hourly"
            },
            "PayClass": {
                "XRefCode": "FT",
                "ShortName": "FT",
                "LongName": "Full Time"
            },
            "PunchPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "PayPolicy": {
                "XRefCode": "MHourly",
                "ShortName": "MHourly ",
                "LongName": "MHourly "
            },
            "PayHolidayGroup": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "EntitlementPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftRotation": {
                "XRefCode": "Morning",
                "ShortName": "Morning",
                "LongName": "Morning"
            },
            "ShiftRotationDayOffset": 0,
            "ShiftRotationStartDate": "2007-12-31T00:00:00",
            "CreateShiftRotationShift": true,
            "TimeOffPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftTradePolicy": {
                "XRefCode": "default",
                "ShortName": "Corporate",
                "LongName": "Corporate"
            },
            "AttendancePolicy": {
                "XRefCode": "DEFAULT",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "SchedulePolicy": {
                "XRefCode": "Manufacturing",
                "ShortName": "Manufacturing",
                "LongName": "Manufacturing"
            },
            "OvertimeGroup": {
                "XRefCode": "OTG1",
                "ShortName": "OT Group 1",
                "LongName": "OT Group 1"
            },
            "PayrollPolicy": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "AlternateRate": 3.00000,
            "AverageDailyHours": 8.0000,
            "BaseRate": 21.50000,
            "BaseSalary": 44720.00000,
            "NormalWeeklyHours": 40.0000,
            "VacationRate": 10.00000
        }
}
```

**Sample response**

This method returns a HTTP code 200 and no reponse body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Statuses/POST-Employee-Employment-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Statuses/POST-Employee-Employment-Statuses.aspx)

#### Updating Employee Employment Statuses
We can use PATCH Employee Employment Statuses operation with required parameters to update the employment status of existing employees.

**PATCH Employee Employment Agreements**
```xml
<ceridiandayforce.patchEmployeeEmploymentStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeEmploymentStatuses>
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
            "EmployeeNumber": "42199",
            "EffectiveStart": "2014-02-04T00:00:00",
            "EmploymentStatus": {
                "IsBenefitArrearsEnabled": false,
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "EmploymentStatusGroup": {
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "PayType": {
                "XRefCode": "HourlyNon",
                "ShortName": "Hourly(Non-Exempt)",
                "LongName": "Hourly(Non-Exempt)"
            },
            "PayGroup": {
                "PayFrequency": {
                    "PayFrequencyType": "w",
                    "ShortName": "Weekly",
                    "LongName": "Weekly"
                },
                "XRefCode": "USA",
                "ShortName": "USA - Weekly",
                "LongName": "USA - Weekly"
            },
            "PayTypeGroup": {
                "XRefCode": "Hourly",
                "ShortName": "Hourly",
                "LongName": "Hourly"
            },
            "PayClass": {
                "XRefCode": "FT",
                "ShortName": "FT",
                "LongName": "Full Time"
            },
            "PunchPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "PayPolicy": {
                "XRefCode": "MHourly",
                "ShortName": "MHourly ",
                "LongName": "MHourly "
            },
            "PayHolidayGroup": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "EntitlementPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftRotation": {
                "XRefCode": "Morning",
                "ShortName": "Morning",
                "LongName": "Morning"
            },
            "ShiftRotationDayOffset": 0,
            "ShiftRotationStartDate": "2007-12-31T00:00:00",
            "CreateShiftRotationShift": true,
            "TimeOffPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftTradePolicy": {
                "XRefCode": "default",
                "ShortName": "Corporate",
                "LongName": "Corporate"
            },
            "AttendancePolicy": {
                "XRefCode": "DEFAULT",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "SchedulePolicy": {
                "XRefCode": "Manufacturing",
                "ShortName": "Manufacturing",
                "LongName": "Manufacturing"
            },
            "OvertimeGroup": {
                "XRefCode": "OTG1",
                "ShortName": "OT Group 1",
                "LongName": "OT Group 1"
            },
            "PayrollPolicy": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "AlternateRate": 3.00000,
            "AverageDailyHours": 8.0000,
            "BaseRate": 21.50000,
            "BaseSalary": 44720.00000,
            "NormalWeeklyHours": 40.0000,
            "VacationRate": 10.00000
        }
}
```

**Sample response**

This operation returns HTTP code 200 with no response body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Statuses/PATCH-Employee-Employment-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Statuses/PATCH-Employee-Employment-Statuses.aspx)

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
         <ceridiandayforce.getEmployeeEmploymentStatuses>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
         </ceridiandayforce.getEmployeeEmploymentStatuses>
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
            "EmployeeNumber": "42199",
            "EffectiveStart": "2014-02-04T00:00:00",
            "EmploymentStatus": {
                "IsBenefitArrearsEnabled": false,
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "EmploymentStatusGroup": {
                "XRefCode": "INACTIVE",
                "ShortName": "Inactive",
                "LongName": "Inactive"
            },
            "PayType": {
                "XRefCode": "HourlyNon",
                "ShortName": "Hourly(Non-Exempt)",
                "LongName": "Hourly(Non-Exempt)"
            },
            "PayGroup": {
                "PayFrequency": {
                    "PayFrequencyType": "w",
                    "ShortName": "Weekly",
                    "LongName": "Weekly"
                },
                "XRefCode": "USA",
                "ShortName": "USA - Weekly",
                "LongName": "USA - Weekly"
            },
            "PayTypeGroup": {
                "XRefCode": "Hourly",
                "ShortName": "Hourly",
                "LongName": "Hourly"
            },
            "PayClass": {
                "XRefCode": "FT",
                "ShortName": "FT",
                "LongName": "Full Time"
            },
            "PunchPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "PayPolicy": {
                "XRefCode": "MHourly",
                "ShortName": "MHourly ",
                "LongName": "MHourly "
            },
            "PayHolidayGroup": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "EntitlementPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftRotation": {
                "XRefCode": "Morning",
                "ShortName": "Morning",
                "LongName": "Morning"
            },
            "ShiftRotationDayOffset": 0,
            "ShiftRotationStartDate": "2007-12-31T00:00:00",
            "CreateShiftRotationShift": true,
            "TimeOffPolicy": {
                "XRefCode": "Default",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "ShiftTradePolicy": {
                "XRefCode": "default",
                "ShortName": "Corporate",
                "LongName": "Corporate"
            },
            "AttendancePolicy": {
                "XRefCode": "DEFAULT",
                "ShortName": "Default",
                "LongName": "Default"
            },
            "SchedulePolicy": {
                "XRefCode": "Manufacturing",
                "ShortName": "Manufacturing",
                "LongName": "Manufacturing"
            },
            "OvertimeGroup": {
                "XRefCode": "OTG1",
                "ShortName": "OT Group 1",
                "LongName": "OT Group 1"
            },
            "PayrollPolicy": {
                "XRefCode": "USA",
                "ShortName": "USA",
                "LongName": "USA"
            },
            "AlternateRate": 3.00000,
            "AverageDailyHours": 8.0000,
            "BaseRate": 21.50000,
            "BaseSalary": 44720.00000,
            "NormalWeeklyHours": 40.0000,
            "VacationRate": 10.00000
        }
    ]
}
```

# Working with Employee Compensation Summary

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operation allows you to retrieve an employee's clock device group

| Operation | Description |
| ------------- |-------------|
|[GET Employee Compensation Summary](#retrieving-employee-compensation-summary)| Retrieve an employee's condensed status information based on compensation changes. |

### Operation details

This section provides more details on the operation.

#### Retrieving Employee Compensation Summary
We can use GET Employee Compensation Summary operation with required parameters to search and find the required employee's compensation summary.

**GET Employee Compensation Summary**
```xml
<ceridiandayforce.getEmployeeCompensationSummary>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeCompensationSummary>
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
  "contextDate": "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "EmployeeNumber": "42199",
            "EffectiveStart": "2007-07-01T00:00:00",
            "PayGrade": {
                "ShortName": "Associates",
                "LongName": "Associates"
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
            "PayClass": {
                "XRefCode": "FT",
                "ShortName": "FT",
                "LongName": "Full Time"
            },
            "AlternateRate": 3.00000,
            "AverageDailyHours": 8.0000,
            "BaseRate": 21.50000,
            "BaseSalary": 44720.00000,
            "NormalWeeklyHours": 40.0000,
            "VacationRate": 10.00000,
            "MinimumRate": 8.00000,
            "ControlRate": 10.50000,
            "MaximumRate": 13.00000,
            "RateMidPoint": 10.50000,
            "MinimumSalary": 16640.00000,
            "ControlSalary": 21840.00000,
            "MaximumSalary": 27040.00000,
            "SalaryMidPoint": 21840.00000,
            "CompRatio": 2.04762,
            "ChangePercent": 0.075,
            "ChangeValue": 1.50000,
            "PreviousBaseSalary": 41600.00000,
            "PreviousBaseRate": 20.00000,
            "PayPolicy": {
                "XRefCode": "MHourly",
                "ShortName": "MHourly ",
                "LongName": "MHourly "
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Compensation-Summary/GET-Employee-Compensation-Summary.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Compensation-Summary/GET-Employee-Compensation-Summary.aspx)

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
         <property expression="json-eval($.contextDate)" name="contextDate"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getEmployeeCompensationSummary>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <contextDate>{$ctx:contextDate}</contextDate>
         </ceridiandayforce.getEmployeeCompensationSummary>
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
  "contextDate": "2017-01-01T13:24:56"
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
            "EffectiveStart": "2007-07-01T00:00:00",
            "PayGrade": {
                "ShortName": "Associates",
                "LongName": "Associates"
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
            "PayClass": {
                "XRefCode": "FT",
                "ShortName": "FT",
                "LongName": "Full Time"
            },
            "AlternateRate": 3.00000,
            "AverageDailyHours": 8.0000,
            "BaseRate": 21.50000,
            "BaseSalary": 44720.00000,
            "NormalWeeklyHours": 40.0000,
            "VacationRate": 10.00000,
            "MinimumRate": 8.00000,
            "ControlRate": 10.50000,
            "MaximumRate": 13.00000,
            "RateMidPoint": 10.50000,
            "MinimumSalary": 16640.00000,
            "ControlSalary": 21840.00000,
            "MaximumSalary": 27040.00000,
            "SalaryMidPoint": 21840.00000,
            "CompRatio": 2.04762,
            "ChangePercent": 0.075,
            "ChangeValue": 1.50000,
            "PreviousBaseSalary": 41600.00000,
            "PreviousBaseRate": 20.00000,
            "PayPolicy": {
                "XRefCode": "MHourly",
                "ShortName": "MHourly ",
                "LongName": "MHourly "
            }
        }
    ]
}
```

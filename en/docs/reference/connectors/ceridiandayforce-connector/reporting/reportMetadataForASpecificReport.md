# Working with Report Metadata for a specific report

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve meta data for a report

| Operation | Description |
| ------------- |-------------|
|[GET Report Metadata for a specific report](#retrieving-report-metadata-for-a-specific-report)| Get detailed information about a specific report including its column metadata, the list of its filter parameters and the different values that can populate these parameters. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Report Metadata for a specific report
We can use GET Employee addresses operation with required parameters to find meta data for a report

**GET Report Metadata for a specific report**
```xml
<ceridiandayforce.getReportMetadataDetails>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
</ceridiandayforce.getReportMetadataDetails>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the report to be retrieved. The value provided must be the exact match for an report; otherwise, a bad request (400) error will be returned.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "Payroll_Earning_Hours_Detail"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "Name": "API-Payroll Earning and hours Detail",
            "XRefCode": "Payroll_Earning_Hours_Detail",
            "MaxRows": 20000,
            "ColumnMetadata": [
                {
                    "CodeName": "Employee.DisplayName",
                    "DisplayName": "Employee",
                    "DataType": "String"
                },
                {
                    "CodeName": "PRPayRunResultPermanent.EmployeeNumber",
                    "DisplayName": "Employee Number",
                    "DataType": "String"
                },
                {
                    "CodeName": "OrgUnit.ShortName",
                    "DisplayName": "Location",
                    "DataType": "String"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.PayDate",
                    "DisplayName": "Pay Date",
                    "DataType": "Date"
                },
                {
                    "CodeName": "Job.ShortName",
                    "DisplayName": "Job Name",
                    "DataType": "String"
                },
                {
                    "CodeName": "PREarningCode.ShortName",
                    "DisplayName": "Earning Code Name",
                    "DataType": "String"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.Rate",
                    "DisplayName": "Earning Rate",
                    "DataType": "Decimal"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.Units",
                    "DisplayName": "Earning Hours",
                    "DataType": "Decimal"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.Amount",
                    "DisplayName": "Earning Earning",
                    "DataType": "Decimal"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.WeekStartDate",
                    "DisplayName": "Week Start Date",
                    "DataType": "Date"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.WeekEndDate",
                    "DisplayName": "Week End Date",
                    "DataType": "Date"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.WeekNumber",
                    "DisplayName": "Week Number",
                    "DataType": "Integer"
                }
            ],
            "Parameters": [
                {
                    "Name": "@EffectiveStart",
                    "DisplayName": "@EffectiveStart",
                    "ReportParameterMetadataId": "32683c04-2d51-4407-ba11-6634f1ae6038",
                    "DataType": "DateTime",
                    "DefaultValue": "2/7/2020 12:00:00 AM",
                    "IsRequired": true
                },
                {
                    "Name": "@EffectiveEnd",
                    "DisplayName": "@EffectiveEnd",
                    "ReportParameterMetadataId": "32683c04-2d51-4407-ba11-6634f1ae6039",
                    "DataType": "DateTime",
                    "IsRequired": false
                }
            ]
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Reporting/GET-Report-Metadata-for-one-reports.aspx](https://developers.dayforce.com/Build/API-Explorer/Reporting/GET-Report-Metadata-for-one-reports.aspx)

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
         <ceridiandayforce.getReportMetadataDetails>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getReportMetadataDetails>
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
  "xRefCode": "Payroll_Earning_Hours_Detail"
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
            "Name": "API-Payroll Earning and hours Detail",
            "XRefCode": "Payroll_Earning_Hours_Detail",
            "MaxRows": 20000,
            "ColumnMetadata": [
                {
                    "CodeName": "Employee.DisplayName",
                    "DisplayName": "Employee",
                    "DataType": "String"
                },
                {
                    "CodeName": "PRPayRunResultPermanent.EmployeeNumber",
                    "DisplayName": "Employee Number",
                    "DataType": "String"
                },
                {
                    "CodeName": "OrgUnit.ShortName",
                    "DisplayName": "Location",
                    "DataType": "String"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.PayDate",
                    "DisplayName": "Pay Date",
                    "DataType": "Date"
                },
                {
                    "CodeName": "Job.ShortName",
                    "DisplayName": "Job Name",
                    "DataType": "String"
                },
                {
                    "CodeName": "PREarningCode.ShortName",
                    "DisplayName": "Earning Code Name",
                    "DataType": "String"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.Rate",
                    "DisplayName": "Earning Rate",
                    "DataType": "Decimal"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.Units",
                    "DisplayName": "Earning Hours",
                    "DataType": "Decimal"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.Amount",
                    "DisplayName": "Earning Earning",
                    "DataType": "Decimal"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.WeekStartDate",
                    "DisplayName": "Week Start Date",
                    "DataType": "Date"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.WeekEndDate",
                    "DisplayName": "Week End Date",
                    "DataType": "Date"
                },
                {
                    "CodeName": "PRPayRunEarningPermanent.WeekNumber",
                    "DisplayName": "Week Number",
                    "DataType": "Integer"
                }
            ],
            "Parameters": [
                {
                    "Name": "@EffectiveStart",
                    "DisplayName": "@EffectiveStart",
                    "ReportParameterMetadataId": "32683c04-2d51-4407-ba11-6634f1ae6038",
                    "DataType": "DateTime",
                    "DefaultValue": "2/7/2020 12:00:00 AM",
                    "IsRequired": true
                },
                {
                    "Name": "@EffectiveEnd",
                    "DisplayName": "@EffectiveEnd",
                    "ReportParameterMetadataId": "32683c04-2d51-4407-ba11-6634f1ae6039",
                    "DataType": "DateTime",
                    "IsRequired": false
                }
            ]
        }
    ]
}
```

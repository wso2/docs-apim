# Working with Reports

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve reports

| Operation | Description |
| ------------- |-------------|
|[GET Reports](#retrieving-reports)| Run a report and receive its results via web services. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Reports
We can use GET Reports operation with required parameters to find reports

**GET Reports**
```xml
<ceridiandayforce.getReports>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <pageSize>{$ctx:pageSize}</pageSize>
    <reportParameters>{$ctx:reportParameters}</reportParameters>
</ceridiandayforce.getReports>
```

**Properties**

* xRefCode (Mandatory - string): The unique identifier (external reference code) of the report to be retrieved. The value provided must be the exact match for an report; otherwise, a bad request (400) error will be returned.
* pageSize (Optional - integer): The number of records returned per page in the paginated response
* reportParameters (Optional - object): A list of key value pairs for those reports which take as input user supplied parameter values.

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "Payroll_Earning_Hours_Detail",
  "pageSize": "1"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": {
        "XRefCode": "Payroll_Earning_Hours_Detail",
        "Rows": [
            {
                "Employee_DisplayName": "Gary Shy",
                "PRPayRunResultPermanent_EmployeeNumber": "8965594",
                "OrgUnit_ShortName": "Plant 2 - Assembly 1",
                "PRPayRunEarningPermanent_PayDate": "2016-01-05T00:00:00.0000000",
                "Job_ShortName": "Process Technician",
                "PREarningCode_ShortName": "Regular",
                "PRPayRunEarningPermanent_Rate": "14.00000",
                "PRPayRunEarningPermanent_Units": "8.00000",
                "PRPayRunEarningPermanent_Amount": "****",
                "PRPayRunEarningPermanent_WeekStartDate": "2015-12-27T00:00:00.0000000",
                "PRPayRunEarningPermanent_WeekEndDate": "2016-01-02T00:00:00.0000000",
                "PRPayRunEarningPermanent_WeekNumber": "1"
            }
        ]
    },
    "Paging": {
        "Next": "https://usconfigr57.dayforcehcm.com:443/Api/ddn/V1/Reports/Payroll_Earning_Hours_Detail?cursor=XQNm%252Fy8QDwwOTVmwS55YIR9dxnzR39EsaiqKsIKTt6dOMJg%252Fbsgm%252B31dDpM5RlnJ"
    }
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Reporting/GET-Reports.aspx](https://developers.dayforce.com/Build/API-Explorer/Reporting/GET-Reports.aspx)

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
         <property expression="json-eval($.pageSize)" name="pageSize"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getReports>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <pageSize>{$ctx:pageSize}</pageSize>
         </ceridiandayforce.getReports>
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
  "xRefCode": "Payroll_Earning_Hours_Detail",
  "pageSize": "1"
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
    "Data": {
        "XRefCode": "Payroll_Earning_Hours_Detail",
        "Rows": [
            {
                "Employee_DisplayName": "Gary Shy",
                "PRPayRunResultPermanent_EmployeeNumber": "8965594",
                "OrgUnit_ShortName": "Plant 2 - Assembly 1",
                "PRPayRunEarningPermanent_PayDate": "2016-01-05T00:00:00.0000000",
                "Job_ShortName": "Process Technician",
                "PREarningCode_ShortName": "Regular",
                "PRPayRunEarningPermanent_Rate": "14.00000",
                "PRPayRunEarningPermanent_Units": "8.00000",
                "PRPayRunEarningPermanent_Amount": "****",
                "PRPayRunEarningPermanent_WeekStartDate": "2015-12-27T00:00:00.0000000",
                "PRPayRunEarningPermanent_WeekEndDate": "2016-01-02T00:00:00.0000000",
                "PRPayRunEarningPermanent_WeekNumber": "1"
            }
        ]
    },
    "Paging": {
        "Next": "https://usconfigr57.dayforcehcm.com:443/Api/ddn/V1/Reports/Payroll_Earning_Hours_Detail?cursor=XQNm%252Fy8QDwwOTVmwS55YIR9dxnzR39EsaiqKsIKTt6dOMJg%252Fbsgm%252B31dDpM5RlnJ"
    }
}
```

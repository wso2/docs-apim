# Working with Report Metadata for a list of reports

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve Report Metadata for a list of reports

| Operation | Description |
| ------------- |-------------|
|[GET Report Metadata for a list of reports](#retrieving-report-metadata-for-a-list-of-reports)| Retrieve base information for all reports available via Web Services. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Report Metadata for a list of reports
We can use GET Report Metadata for a list of reports operation with required parameters to find Report Metadata for a list of reports.

**GET Report Metadata for a list of reports**
```xml
<ceridiandayforce.getReportMetadata/>
```

**Properties**

There are no properties

**Sample request**

Following is a sample request that can be handled by this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1"
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
            "MaxRows": 20000
        },
        {
            "Name": "API - candidates",
            "XRefCode": "API-candidates",
            "MaxRows": 20000
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Reporting/GET-Report-Metadata-for-a-list-of-reports.aspx](https://developers.dayforce.com/Build/API-Explorer/Reporting/GET-Report-Metadata-for-a-list-of-reports.aspx)

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
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.getReportMetadata/>
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
            "Name": "API-Payroll Earning and hours Detail",
            "XRefCode": "Payroll_Earning_Hours_Detail",
            "MaxRows": 20000
        },
        {
            "Name": "API - candidates",
            "XRefCode": "API-candidates",
            "MaxRows": 20000
        }
    ]
}
```

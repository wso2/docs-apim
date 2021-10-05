# Working with US Employee Taxes

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve tax details of a US employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee US Federal Taxes](#retrieving-US-employee-federal-taxes)| Retrieve a US employee's total federal claim amount, resident status and authorized tax credits. |
|[GET Employee US State Taxes](#retrieving-US-employee-state-taxes)| Retrieve a US employee's total state claim amount, prescribed deductions and authorized tax credits. |
|[GET Employee US Tax Statuses](#retrieving-US-employee-tax-statuses)| Retrieve a US employee's provincial tax filing status (e.g. single, married). |

### Operation details

This section provides more details on each of the operations.

#### Retrieving US Employee Federal Taxes
We can use GET Employee US Federal Taxes operation with required parameters to retrieve federal taxes of a US employee.

**GET Employee US Federal Taxes**
```xml
<ceridiandayforce.getEmployeeUSFederalTaxes>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeUSFederalTaxes>
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
  "xRefCode": "42199"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "EffectiveStart": "2019-01-01T00:00:00",
            "FilingStatus": {
                "CountryCode": "USA",
                "FederalFilingStatusCode": "S",
                "CalculationCode": "1",
                "PayrollOutput": "Single",
                "ShortName": "Single",
                "LongName": "Single"
            },
            "Allowances": 50,
            "AdditionalAmount": 100.00000,
            "IsTaxExempt": false,
            "IsLocked": false
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-US-Federal-Taxes/GET-Employee-US-Federal-Taxes.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-US-Federal-Taxes/GET-Employee-US-Federal-Taxes.aspx)

#### Retrieving US Employee State Taxes
We can use GET Employee US State Taxes operation with required parameters to retrieve the state taxes of US employee.

**GET Employee US State Taxes**
```xml
<ceridiandayforce.getEmployeeUSStateTaxes>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeUSStateTaxes>
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
  "contextDateRangeFrom":  "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "EffectiveStart": "2019-01-01T00:00:00",
            "State": {
                "XRefCode": "NJ",
                "LongName": "New Jersey"
            },
            "FilingStatus": {
                "CountryCode": "USA",
                "StateFilingStatusCode": "S",
                "CalculationCode": "1",
                "PayrollOutput": "Single",
                "ShortName": "Single",
                "LongName": "Single"
            },
            "AdditionalAmount": 100.00000,
            "IsTaxExempt": false,
            "IsLocked": false
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-US-State-Taxes/GET-Employee-US-State-Taxes.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-US-State-Taxes/GET-Employee-US-State-Taxes.aspx)

#### Retrieving US Employee Tax Statuses
We can use GET Employee US Employee Tax Statuses operation with required parameters to retrieve tax filing statuses of US employees.

**GET Employee Addresses**
```xml
<ceridiandayforce.getEmployeeUSTaxStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeUSTaxStatuses>
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
  "xRefCode": "42199"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "StateCode": "Federal",
            "EffectiveStart": "2019-01-01T00:00:00",
            "TaxPropertyCollection": {
                "Items": [
                    {
                        "PropertyCodeName": "STANDARD_OCCUPATIONAL_CODE",
                        "PropertyValue": "51-1000"
                    },
                    {
                        "PropertyCodeName": "STATUTORY_EMPLOYEE",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "SS_MED_RELIGIOUS_EXEMPTION",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "RETIREMENT_PLAN_ELIGIBILITY",
                        "PropertyValue": "2"
                    }
                ]
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-US-Tax-Statuses/GET-Employee-US-Tax-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-US-Tax-Statuses/GET-Employee-US-Tax-Statuses.aspx)

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
         <ceridiandayforce.getEmployeeUSTaxStatuses>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getEmployeeUSTaxStatuses>
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
5.Dayforce returns the following response body with code 200

```json
{
    "Data": [
        {
            "StateCode": "Federal",
            "EffectiveStart": "2019-01-01T00:00:00",
            "TaxPropertyCollection": {
                "Items": [
                    {
                        "PropertyCodeName": "STANDARD_OCCUPATIONAL_CODE",
                        "PropertyValue": "51-1000"
                    },
                    {
                        "PropertyCodeName": "STATUTORY_EMPLOYEE",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "SS_MED_RELIGIOUS_EXEMPTION",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "RETIREMENT_PLAN_ELIGIBILITY",
                        "PropertyValue": "2"
                    }
                ]
            }
        }
    ]
}
```

# Working with Canadian Employee Taxes

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve tax details of a Canadian employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee CAN Federal Taxes](#retrieving-canadian-employee-federal-taxes)| Retrieve a Canadian employee's total federal claim amount, resident status and authorized tax credits. |
|[GET Employee CAN State Taxes](#retrieving-canadian-employee-state-taxes)| Retrieve a Canadian employee's total provincial claim amount, prescribed deductions and authorized tax credits. |
|[GET Employee CAN Tax Statuses](#retrieving-canadian-employee-tax-statuses)| Retrieve a Canadian employee's provincial tax filing status (e.g. single, married). |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Canadian Employee Federal Taxes
We can use GET Employee CAN Federal Taxes operation with required parameters to retrieve federal taxes of a Canadian employee.

**GET Employee CAN Federal Taxes**
```xml
<ceridiandayforce.getEmployeeCANFederalTaxes>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeCANFederalTaxes>
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
            "TotalClaimAmount": 12269.00000,
            "IsNonResident": false,
            "MultipleEmployer": false,
            "IncomeLessThanClaim": false,
            "AuthorizedTaxCredits": 50.00000,
            "AdditionalAmount": 1000.00000
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-CAN-Federal-Taxes/GET-Employee-CAN-Federal-Taxes.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-CAN-Federal-Taxes/GET-Employee-CAN-Federal-Taxes.aspx)

#### Retrieving Canadian Employee State Taxes
We can use GET Employee CAN State Taxes operation with required parameters to retrieve the state taxes of Canadian employee.

**GET Employee CAN State Taxes**
```xml
<ceridiandayforce.getEmployeeCANStateTaxes>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeCANStateTaxes>
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
            "State": {
                "Name": "Ontario",
                "XRefCode": "ON",
                "ShortName": "Ontario",
                "LongName": "Ontario"
            },
            "TotalClaimAmount": 1000.00000,
            "AuthorizedTaxCredits": 50.00000,
            "HasQuebecHealthContributionExemption": false,
            "IncomeLessThanClaim": false
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-CAN-State-Taxes/GET-Employee-CAN-State-Taxes.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-CAN-State-Taxes/GET-Employee-CAN-State-Taxes.aspx)

#### Retrieving Canadian Employee Tax Statuses
We can use GET Employee CAN Employee Tax Statuses operation with required parameters to retrieve tax filing statuses of Canadian employees.

**GET Employee Addresses**
```xml
<ceridiandayforce.getEmployeeCANTaxStatuses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeCANTaxStatuses>
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
  "xRefCode": "100421"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "ProvinceCode": "Federal",
            "EffectiveStart": "2019-01-01T00:00:00",
            "TaxPropertyCollection": {
                "Items": [
                    {
                        "PropertyCodeName": "IS_STATUS_INDIAN",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "REGISTRY_NUMBER",
                        "PropertyValue": "123456789"
                    },
                    {
                        "PropertyCodeName": "CPT30_FORM_FILED",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "EMPLOYMENT_CODE_CAN"
                    },
                    {
                        "PropertyCodeName": "BEYOND_PROV_CAN",
                        "PropertyValue": "-1"
                    },
                    {
                        "PropertyCodeName": "NUMBER_OF_DAYS_OUTSIDE_CANADA",
                        "PropertyValue": "15"
                    }
                ]
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-CAN-Tax-Statuses/GET-Employee-CAN-Tax-Statuses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-CAN-Tax-Statuses/GET-Employee-CAN-Tax-Statuses.aspx)

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
         <ceridiandayforce.getEmployeeCANTaxStatuses>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getEmployeeCANTaxStatuses>
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
  "xRefCode": "100421"
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
            "ProvinceCode": "Federal",
            "EffectiveStart": "2019-01-01T00:00:00",
            "TaxPropertyCollection": {
                "Items": [
                    {
                        "PropertyCodeName": "IS_STATUS_INDIAN",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "REGISTRY_NUMBER",
                        "PropertyValue": "123456789"
                    },
                    {
                        "PropertyCodeName": "CPT30_FORM_FILED",
                        "PropertyValue": "False"
                    },
                    {
                        "PropertyCodeName": "EMPLOYMENT_CODE_CAN"
                    },
                    {
                        "PropertyCodeName": "BEYOND_PROV_CAN",
                        "PropertyValue": "-1"
                    },
                    {
                        "PropertyCodeName": "NUMBER_OF_DAYS_OUTSIDE_CANADA",
                        "PropertyValue": "15"
                    }
                ]
            }
        }
    ]
}
```

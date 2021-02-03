# Working with Employee Employment Agreements

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update employment agreements of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Employment Agreements](#retrieving-employee-employment-agreement)| Retrieve the employment agreement information of an employee. |
|[POST Employee Employment Agreements](#creating-employee-employment-agreement)| Create the employment agreement information of an employee. |
|[PATCH Employee Employment Agreements](#updating-employee-employment-agreement)| Update the employment agreement information of an employee. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Employment Agreements
We can use GET Employee Contacts operation with required parameters to retrieve the employment agreement information of an employee.

**GET Employee Employee Employment Agreements**
```xml
<ceridiandayforce.getEmployeeEmploymentAgreements>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeEmploymentAgreements>
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
            "EffectiveStart": "2019-01-01T00:00:00",
            "XRefCode": "dcc714ea-0e89-415c-aad1-242185951438",
            "EmploymentAgreementType": {
                "XRefCode": "BLCO",
                "ShortName": "Blue collar",
                "LongName": "Blue collar"
            },
            "EmploymentAgreementPopulation": {
                "XRefCode": "DKFULI",
                "ShortName": "Funktionaer-ligende (Salaried \"ligende\")",
                "LongName": "Funktionaer-ligende (Salaried \"ligende\")"
            },
            "EmploymentAgreementDetails": {
                "XRefCode": "DKFS",
                "ShortName": "Vacation funktionaer with full salary",
                "LongName": "Vacation funktionaer with full salary"
            },
            "EmploymentAgreementTaxRegime": {
                "XRefCode": "DKBK",
                "ShortName": "BIKORT",
                "LongName": "BIKORT"
            },
            "EmploymentAgreementDuration": {
                "XRefCode": "OE",
                "ShortName": "Open ended",
                "LongName": "Open ended"
            },
            "Country": {
                "Name": "Denmark",
                "XRefCode": "DNK",
                "ShortName": "Denmark",
                "LongName": "Denmark"
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Agreements/GET-Employee-Employment-Agreements.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Agreements/GET-Employee-Employment-Agreements.aspx)

#### Creating Employee Employment Agreements
We can use POST Employee Employment Agreements operation with required parameters to create the required employee's employment agreement information.

**POST Employee Employment Agreements**
```xml
<ceridiandayforce.postEmployeeEmploymentAgreements>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeEmploymentAgreements>
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
            "EffectiveStart": "2019-01-01T00:00:00",
            "XRefCode": "dcc714ea-0e89-415c-aad1-242185951438",
            "EmploymentAgreementType": {
                "XRefCode": "BLCO",
                "ShortName": "Blue collar",
                "LongName": "Blue collar"
            },
            "EmploymentAgreementPopulation": {
                "XRefCode": "DKFULI",
                "ShortName": "Funktionaer-ligende (Salaried \"ligende\")",
                "LongName": "Funktionaer-ligende (Salaried \"ligende\")"
            },
            "EmploymentAgreementDetails": {
                "XRefCode": "DKFS",
                "ShortName": "Vacation funktionaer with full salary",
                "LongName": "Vacation funktionaer with full salary"
            },
            "EmploymentAgreementTaxRegime": {
                "XRefCode": "DKBK",
                "ShortName": "BIKORT",
                "LongName": "BIKORT"
            },
            "EmploymentAgreementDuration": {
                "XRefCode": "OE",
                "ShortName": "Open ended",
                "LongName": "Open ended"
            },
            "Country": {
                "Name": "Denmark",
                "XRefCode": "DNK",
                "ShortName": "Denmark",
                "LongName": "Denmark"
            }
        }
}
```

**Sample response**

This method returns a HTTP code 200 and no reponse body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Agreements/POST-Employee-Employment-Agreements.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Agreements/POST-Employee-Employment-Agreements.aspx)

#### Updating Employee Employment Agreements
We can use PATCH Employee Employment Agreements operation with required parameters to update the employment agreement information of existing employees.

**PATCH Employee Employment Agreements**
```xml
<ceridiandayforce.patchEmployeeEmploymentAgreements>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeEmploymentAgreements>
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
            "EffectiveStart": "2019-01-01T00:00:00",
            "XRefCode": "dcc714ea-0e89-415c-aad1-242185951438",
            "EmploymentAgreementType": {
                "XRefCode": "BLCO",
                "ShortName": "Blue collar",
                "LongName": "Blue collar"
            },
            "EmploymentAgreementPopulation": {
                "XRefCode": "DKFULI",
                "ShortName": "Funktionaer-ligende (Salaried \"ligende\")",
                "LongName": "Funktionaer-ligende (Salaried \"ligende\")"
            },
            "EmploymentAgreementDetails": {
                "XRefCode": "DKFS",
                "ShortName": "Vacation funktionaer with full salary",
                "LongName": "Vacation funktionaer with full salary"
            },
            "EmploymentAgreementTaxRegime": {
                "XRefCode": "DKBK",
                "ShortName": "BIKORT",
                "LongName": "BIKORT"
            },
            "EmploymentAgreementDuration": {
                "XRefCode": "OE",
                "ShortName": "Open ended",
                "LongName": "Open ended"
            },
            "Country": {
                "Name": "Denmark",
                "XRefCode": "DNK",
                "ShortName": "Denmark",
                "LongName": "Denmark"
            }
        }
}
```

**Sample response**

This operation returns HTTP code 200 with no response body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Agreements/GET-Employee-Employment-Agreements-(1).aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Employment-Agreements/GET-Employee-Employment-Agreements-(1).aspx)
(sic)

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
         <property expression="json-eval($.isValidateOnly)" name="isValidateOnly"/>
         <property expression="json-eval($.fieldAndValue)" name="fieldAndValue"/>
         <property expression="json-eval($.xRefCode)" name="xRefCode"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.patchEmployeeEmploymentAgreements>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
         </ceridiandayforce.patchEmployeeEmploymentAgreements>
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
  "isValidateOnly": "true",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
            "EffectiveStart": "2019-01-01T00:00:00",
            "XRefCode": "dcc714ea-0e89-415c-aad1-242185951438",
            "EmploymentAgreementType": {
                "XRefCode": "BLCO",
                "ShortName": "Blue collar",
                "LongName": "Blue collar"
            },
            "EmploymentAgreementPopulation": {
                "XRefCode": "DKFULI",
                "ShortName": "Funktionaer-ligende (Salaried \"ligende\")",
                "LongName": "Funktionaer-ligende (Salaried \"ligende\")"
            },
            "EmploymentAgreementDetails": {
                "XRefCode": "DKFS",
                "ShortName": "Vacation funktionaer with full salary",
                "LongName": "Vacation funktionaer with full salary"
            },
            "EmploymentAgreementTaxRegime": {
                "XRefCode": "DKBK",
                "ShortName": "BIKORT",
                "LongName": "BIKORT"
            },
            "EmploymentAgreementDuration": {
                "XRefCode": "OE",
                "ShortName": "Open ended",
                "LongName": "Open ended"
            },
            "Country": {
                "Name": "Denmark",
                "XRefCode": "DNK",
                "ShortName": "Denmark",
                "LongName": "Denmark"
            }
        }
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200

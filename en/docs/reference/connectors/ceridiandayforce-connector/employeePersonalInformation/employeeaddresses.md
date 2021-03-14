# Working with Employee Addresses

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update addresses of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Addresses](#retrieving-employee-addresses)| Retrieve addresses of an employee |
|[POST Employee Addresses](#create-employee-address)| Create addresses of an employee.|
|[PATCH Employee Addresses](#update-employee-address)| Update addresses of an employee. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Addresses
We can use GET Employee addresses operation with required parameters to search and find the required employee's address.

**GET Employee Addresses**
```xml
<ceridiandayforce.getEmployeeAddresses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeAddresses>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
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
            "Address1": "4114 Yonge St.",
            "City": "North York",
            "PostalCode": "M2P 2B7",
            "Country": {
                "Name": "Canada",
                "XRefCode": "CAN",
                "ShortName": "Canada",
                "LongName": "Canada"
            },
            "State": {
                "Name": "Ontario",
                "XRefCode": "ON",
                "ShortName": "Ontario",
                "LongName": "Ontario"
            },
            "EffectiveStart": "2017-01-15T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "Address",
                    "ShortName": "Address",
                    "LongName": "Address"
                },
                "XRefCode": "PrimaryResidence",
                "ShortName": "Primary Residence",
                "LongName": "Primary Residence"
            },
            "IsPayrollMailing": false
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Addresses/GET-Employee-Addresses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Addresses/GET-Employee-Addresses.aspx)

#### Create Employee Address

We can use POST Employee Addresses operation with required parameters to create address of an employee in Dayforce.

**POST Employee* Addresses*
```xml
<ceridiandayforce.postEmployeeAddresses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
</ceridiandayforce.postEmployeeAddresses>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee for whom the subordinate data will be updated. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* isValidateOnly (Mandatory): When a TRUE value is used in this parameter, POST and PATCH operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by the POST Employee operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "isValidateOnly": "true",
  "fieldAndValue": {
            "Address1": "4114 Yonge St.",
            "City": "North York",
            "PostalCode": "M2P 2B7",
            "Country": {
                "Name": "Canada",
                "XRefCode": "CAN",
                "ShortName": "Canada",
                "LongName": "Canada"
            },
            "State": {
                "Name": "Ontario",
                "XRefCode": "ON",
                "ShortName": "Ontario",
                "LongName": "Ontario"
            },
            "EffectiveStart": "2017-01-15T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "Address",
                    "ShortName": "Address",
                    "LongName": "Address"
                },
                "XRefCode": "PrimaryResidence",
                "ShortName": "Primary Residence",
                "LongName": "Primary Residence"
            },
            "IsPayrollMailing": false
        }
}
```

**Sample response**

There is no response body for this method

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Addresses/POST-Employee-Addresses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Addresses/POST-Employee-Addresses.aspx)

#### Update Employee Address

We can use PATCH employee addresses operation to update the address of an existing employee.


**PATCH Employee Addresses**
```xml
<ceridiandayforce.patchEmployeeAddresses>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
</ceridiandayforce.patchEmployeeAddresses>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee to be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* isValidateOnly (Optional): When a TRUE value is used in this parameter, POST and PATCH operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by the this operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "xRefCode": "42199",
  "isValidateOnly": "true",
  "fieldAndValue": {
            "Address1": "4114 Yonge St.",
            "City": "North York",
            "PostalCode": "M2P 2B7",
            "Country": {
                "Name": "Canada",
                "XRefCode": "CAN",
                "ShortName": "Canada",
                "LongName": "Canada"
            },
            "State": {
                "Name": "Ontario",
                "XRefCode": "ON",
                "ShortName": "Ontario",
                "LongName": "Ontario"
            },
            "EffectiveStart": "2017-01-15T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "Address",
                    "ShortName": "Address",
                    "LongName": "Address"
                },
                "XRefCode": "PrimaryResidence",
                "ShortName": "Primary Residence",
                "LongName": "Primary Residence"
            },
            "IsPayrollMailing": false
        }
}
```

**Sample response**

This operation has no response body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Addresses/PATCH-Employee-Addresses.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Addresses/PATCH-Employee-Addresses.aspx)

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
         <ceridiandayforce.patchEmployeeAddresses>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
         </ceridiandayforce.patchEmployeeAddresses>
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
  "fieldAndValue": {
            "Address1": "4114 Yonge St.",
            "City": "North York",
            "PostalCode": "M2P 2B7",
            "Country": {
                "Name": "Canada",
                "XRefCode": "CAN",
                "ShortName": "Canada",
                "LongName": "Canada"
            },
            "State": {
                "Name": "Ontario",
                "XRefCode": "ON",
                "ShortName": "Ontario",
                "LongName": "Ontario"
            },
            "EffectiveStart": "2017-01-15T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "Address",
                    "ShortName": "Address",
                    "LongName": "Address"
                },
                "XRefCode": "PrimaryResidence",
                "ShortName": "Primary Residence",
                "LongName": "Primary Residence"
            },
            "IsPayrollMailing": false
        }
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200

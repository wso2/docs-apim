# Working with Employee SSO Accounts

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update SSO accounts of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee SSO Accounts](#retrieving-employee-sso-accounts)| Retrieve Single Sign-On (SSO) accounts of an employee. |
|[POST Employee SSO Accounts](#creating-employee-sso-accounts)| Create Single Sign-On (SSO) accounts of an employee. |
|[PATCH Employee SSO Accounts](#updating-employee-sso-accounts)| Update Single Sign-On (SSO) accounts of an employee. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Addresses
We can use GET Employee SSO Accounts operation with required parameters to get the SSO account of an employee.

**GET Employee SSO Accounts**
```xml
<ceridiandayforce.getEmployeeSSOAccounts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeSSOAccounts>
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
            "LoginName": "aaron.glover"
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/SSO-Accounts/GET-Employee-SSO-Accounts.aspx](https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/SSO-Accounts/GET-Employee-SSO-Accounts.aspx)

#### Creating Employee SSO Accounts
We can use POST Employee SSO Accounts operation with required parameters to create SSO account of an employee

**POST Employee SSO Accounts**
```xml
<ceridiandayforce.postEmployeeSSOAccounts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeSSOAccounts>
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
  "fieldAndValue": {
            "LoginName": "aaron.glover"
        }
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/SSO-Accounts/POST-Employee-SSO-Accounts.aspx](https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/SSO-Accounts/POST-Employee-SSO-Accounts.aspx)

#### Updating Employee SSO Accounts
We can use PATCH Employee SSO Accounts operation with required parameters to update the SSO account details of an employee

**PATCH Employee SSO Accounts**
```xml
<ceridiandayforce.getEmployeeAddresses>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.getEmployeeAddresses>
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
  "fieldAndValue": {
            "LoginName": "aaron.glover"
        }
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/SSO-Accounts/PATCH-Employee-SSO-Accounts.aspx](https://developers.dayforce.com/Build/API-Explorer/User-Security,-Authority-Management/SSO-Accounts/PATCH-Employee-SSO-Accounts.aspx)

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
         <ceridiandayforce.getEmployeeSSOAccounts>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getEmployeeSSOAccounts>
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
            "LoginName": "aaron.glover"
        }
    ]
}
```

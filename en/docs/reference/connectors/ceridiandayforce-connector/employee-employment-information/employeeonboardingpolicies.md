# Working with Employee Onboarding Policies

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update onboarding policies of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Onboarding Policies](#retrieving-employee-onboarding-policies)| Retrieve onboarding policies assigned to an employee. |
|[POST Employee Onboarding Policies](#creating-employee-onboarding-policies)| Assign onboarding policies to an employee. |
|[PATCH Employee Onboarding Policies](#updating--employee-onboarding-policies)| Update the onboarding policies assigned to an employee. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Onboarding Policies
We can use GET Employee addresses operation with required parameters to get the onboarding policies of an employee.

**GET Employee Onboarding Policies**
```xml
<ceridiandayforce.getEmployeeOnboardingPolicies>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeOnboardingPolicies>
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
            "OnboardingPolicy": {
                "XRefCode": "db3de97e-f173-442d-86db-0e8bcb259ed0",
                "ShortName": "Default"
            },
            "EffectiveStart": "2019-01-01T00:00:00",
            "EffectiveEnd": "2019-10-12T23:59:00",
            "IsInternalHire": false
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Onboarding-Policies/GET-Employee-Onboarding-Policies.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Onboarding-Policies/GET-Employee-Onboarding-Policies.aspx)

#### Creating Employee Onboarding Policies
We can use POST Employee Onboarding Policies operation with required parameters to assign onboarding policies to an employee.

**POST Employee Onboarding Policies**
```xml
<ceridiandayforce.postEmployeeOnboardingPolicies>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeOnboardingPolicies>
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
      "OnboardingPolicy": {
        "XRefCode": "db3de97e-f173-442d-86db-0e8bcb259ed0",
        "ShortName": "Default"
      },
      "EffectiveStart": "2019-01-01T00:00:00",
      "EffectiveEnd": "2019-10-12T23:59:00",
      "IsInternalHire": false
    }
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Onboarding-Policies/POST-Employee-Onboarding-Policies.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Onboarding-Policies/POST-Employee-Onboarding-Policies.aspx)

#### Updating Employee Onboarding Policies
We can use PATCH Employee addresses operation with required parameters to search and find the required employees.

**PATCH Employee Onboarding Policies**
```xml
<ceridiandayforce.patchEmployeeOnboardingPolicies>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeOnboardingPolicies>
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
      "OnboardingPolicy": {
        "XRefCode": "db3de97e-f173-442d-86db-0e8bcb259ed0",
        "ShortName": "Default"
      },
      "EffectiveStart": "2019-01-01T00:00:00",
      "EffectiveEnd": "2019-10-12T23:59:00",
      "IsInternalHire": false
    }
}
```

**Sample response**

Dayforce returns HTTP Code 200

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Onboarding-Policies/PATCH-Onboarding-Policies.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/Onboarding-Policies/PATCH-Onboarding-Policies.aspx)

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
         <ceridiandayforce.getEmployeeOnboardingPolicies>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
         </ceridiandayforce.getEmployeeOnboardingPolicies>
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
            "OnboardingPolicy": {
                "XRefCode": "db3de97e-f173-442d-86db-0e8bcb259ed0",
                "ShortName": "Default"
            },
            "EffectiveStart": "2019-01-01T00:00:00",
            "EffectiveEnd": "2019-10-12T23:59:00",
            "IsInternalHire": false
        }
    ]
}
```
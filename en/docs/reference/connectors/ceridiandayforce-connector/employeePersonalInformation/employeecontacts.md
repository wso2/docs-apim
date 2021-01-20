# Working with Employee Contacts

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update contacts of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Contacts](#retrieving-employee-contact)| Retrieve an employee's contact information. |
|[POST Employee Contacts](#creating-employee-contact)| Create an employee's contact information. |
|[PATCH Employee Contacts](#updating-employee-contact)| Update an employee's contact information. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Contact
We can use GET Employee Contacts operation with required parameters to retrieve the contact information of an employee.

**GET Employee Employee Contact**
```xml
<ceridiandayforce.getEmployeeContacts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeContacts>
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
  "isValidateOnly": "true",
  "contextDateRangeFrom": "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "ContactNumber": "202 265 8987",
            "Country": {
                "Name": "United States of America",
                "XRefCode": "USA",
                "ShortName": "United States of America",
                "LongName": "United States of America"
            },
            "EffectiveStart": "2000-01-01T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "Phone",
                    "ShortName": "Phone",
                    "LongName": "Phone"
                },
                "XRefCode": "HomePhone",
                "ShortName": "Home",
                "LongName": "Home"
            },
            "IsForSystemCommunications": false,
            "IsPreferredContactMethod": false,
            "IsUnlistedNumber": false,
            "IsVerified": false,
            "IsRejected": false,
            "ShowRejectedWarning": true,
            "NumberOfVerificationRequests": 0
        },
        {
            "ContactNumber": "201 569 8785",
            "Country": {
                "Name": "United States of America",
                "XRefCode": "USA",
                "ShortName": "United States of America",
                "LongName": "United States of America"
            },
            "EffectiveStart": "2000-01-01T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "Phone",
                    "ShortName": "Phone",
                    "LongName": "Phone"
                },
                "XRefCode": "Mobile",
                "ShortName": "Mobile",
                "LongName": "Mobile"
            },
            "IsForSystemCommunications": false,
            "IsPreferredContactMethod": false,
            "IsUnlistedNumber": false,
            "IsVerified": false,
            "IsRejected": false,
            "ShowRejectedWarning": true,
            "NumberOfVerificationRequests": 0
        },
        {
            "ElectronicAddress": "@AaronGloverOfficial",
            "EffectiveStart": "2014-12-17T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "OnlineProfile",
                    "ShortName": "Online Profile",
                    "LongName": "Online Profile"
                },
                "XRefCode": "Twitter",
                "ShortName": "Twitter",
                "LongName": "Twitter"
            },
            "IsForSystemCommunications": false,
            "IsPreferredContactMethod": false,
            "IsUnlistedNumber": false,
            "IsVerified": false,
            "IsRejected": false,
            "ShowRejectedWarning": false,
            "NumberOfVerificationRequests": 0
        },
        {
            "ElectronicAddress": "alok.jesudasen@ceridian.com",
            "EffectiveStart": "2018-09-05T00:00:00",
            "ContactInformationType": {
                "ContactInformationTypeGroup": {
                    "XRefCode": "ElectronicAddress",
                    "ShortName": "Email Address",
                    "LongName": "Email Address"
                },
                "XRefCode": "BusinessEmail",
                "ShortName": "Business Email",
                "LongName": "Business Email"
            },
            "IsForSystemCommunications": true,
            "IsPreferredContactMethod": true,
            "IsUnlistedNumber": false,
            "IsVerified": true,
            "IsRejected": false,
            "ShowRejectedWarning": true,
            "NumberOfVerificationRequests": 0
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Contacts/GET-Employee-Contacts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Contacts/GET-Employee-Contacts.aspx)

#### Creating Employee Contact
We can use POST Employee Contacts operation with required parameters to create the required employee's contact information.

**POST Employee Contacts**
```xml
<ceridiandayforce.postEmployeeContacts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeContacts>
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
  "isValidateOnly": "FALSE",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
      "ContactNumber": "202 265 8987",
      "Country": {
        "Name": "United States of America",
        "XRefCode": "USA",
        "ShortName": "United States of America",
        "LongName": "United States of America"
      },
      "EffectiveStart": "2000-01-01T00:00:00",
      "ContactInformationType": {
        "ContactInformationTypeGroup": {
          "XRefCode": "Phone",
          "ShortName": "Phone",
          "LongName": "Phone"
        },
        "XRefCode": "HomePhone",
        "ShortName": "Home",
        "LongName": "Home"
      },
      "IsForSystemCommunications": false,
      "IsPreferredContactMethod": false,
      "IsUnlistedNumber": false,
      "IsVerified": false,
      "IsRejected": false,
      "ShowRejectedWarning": true,
      "NumberOfVerificationRequests": 0
    }
}
```

**Sample response**

This method returns a HTTP code 200 and no reponse body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Contacts/POST-Employee-Contacts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Contacts/POST-Employee-Contacts.aspx)

#### Updating Employee Contact
We can use PATCH Employee Contacts operation with required parameters to update the contact information of existing employees.

**PATCH Employee Contacts**
```xml
<ceridiandayforce.patchEmployeeContacts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeContacts>
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
  "isValidateOnly": "FALSE",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
      "ContactNumber": "202 265 8987",
      "Country": {
        "Name": "United States of America",
        "XRefCode": "USA",
        "ShortName": "United States of America",
        "LongName": "United States of America"
      },
      "EffectiveStart": "2000-01-01T00:00:00",
      "ContactInformationType": {
        "ContactInformationTypeGroup": {
          "XRefCode": "Phone",
          "ShortName": "Phone",
          "LongName": "Phone"
        },
        "XRefCode": "HomePhone",
        "ShortName": "Home",
        "LongName": "Home"
      },
      "IsForSystemCommunications": false,
      "IsPreferredContactMethod": false,
      "IsUnlistedNumber": false,
      "IsVerified": false,
      "IsRejected": false,
      "ShowRejectedWarning": true,
      "NumberOfVerificationRequests": 0
    }
}
```

**Sample response**

This operation returns HTTP code 200 with no response body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Contacts/PATCH-Employee-Contacts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Contacts/PATCH-Employee-Contacts.aspx)

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
         <property expression="json-eval($.contextDate)" name="contextDate"/>
         <property expression="json-eval($.contextDate)" name="contextDateRangeFrom"/>
         <ceridiandayforce.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <clientNamespace>{$ctx:clientNamespace}</clientNamespace>
            <apiVersion>{$ctx:apiVersion}</apiVersion>
         </ceridiandayforce.init>
         <ceridiandayforce.patchEmployeeContacts>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
         </ceridiandayforce.patchEmployeeContacts>
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
  "isValidateOnly": "FALSE",
  "contextDateRangeFrom": "2017-01-01T13:24:56",
  "fieldAndValue": {
      "ContactNumber": "202 265 8987",
      "Country": {
        "Name": "United States of America",
        "XRefCode": "USA",
        "ShortName": "United States of America",
        "LongName": "United States of America"
      },
      "EffectiveStart": "2000-01-01T00:00:00",
      "ContactInformationType": {
        "ContactInformationTypeGroup": {
          "XRefCode": "Phone",
          "ShortName": "Phone",
          "LongName": "Phone"
        },
        "XRefCode": "HomePhone",
        "ShortName": "Home",
        "LongName": "Home"
      },
      "IsForSystemCommunications": false,
      "IsPreferredContactMethod": false,
      "IsUnlistedNumber": false,
      "IsVerified": false,
      "IsRejected": false,
      "ShowRejectedWarning": true,
      "NumberOfVerificationRequests": 0
    }
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns HTTP Code 200

# Working with Employee Emergency Contacts

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve, create or update emergency contacts of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee Emergency Contacts](#retrieving-employee-emergency-contact)| Retrieve an employee's emergency contact information. |
|[POST Employee Emergency Contacts](#creating-employee-emergency-contact)| Create an employee's emergency contact information. |
|[PATCH Employee Emergency Contacts](#updating-employee-emergency-contact)| Update an employee's emergency contact information. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee Emergency Contact
We can use GET Employee Emergency Contacts operation with required parameters to retrieve the emergency contact information of an employee.

**GET Employee Emergency Addresses**
```xml
<ceridiandayforce.getEmployeeEmergencyContacts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeEmergencyContacts>
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
  "contextDateRangeTo": "2017-01-01T13:24:56"
}
```

**Sample response**

Given below is a sample response for this operation.

```json
{
    "Data": [
        {
            "FirstName": "Alice",
            "LastName": "Glover",
            "IsPrimary": true,
            "Relationship": {
                "XRefCode": "WIFE",
                "ShortName": "Wife",
                "LongName": "Wife"
            },
            "Addresses": {
                "Items": []
            },
            "Contacts": {
                "Items": [
                    {
                        "ContactNumber": "213 658 9654",
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
                    }
                ]
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Emergency-Contacts/GET-Employee-Emergency-Contacts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Emergency-Contacts/GET-Employee-Emergency-Contacts.aspx)

#### Creating Employee Emergency Contact
We can use POST Employee Emergency Contacts operation with required parameters to create the required employee's emergency contact information.

**POST Employee Emergency Contacts**
```xml
<ceridiandayforce.postEmployeeEmergencyContacts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.postEmployeeEmergencyContacts>
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
      "FirstName": "Alice",
      "LastName": "Glover",
      "IsPrimary": true,
      "Relationship": {
        "XRefCode": "WIFE",
        "ShortName": "Wife",
        "LongName": "Wife"
      },
      "Addresses": {
        "Items": []
      },
      "Contacts": {
        "Items": [
          {
            "ContactNumber": "213 658 9654",
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
          }
        ]
      }
    }
}
```

**Sample response**

This method returns a HTTP code 200 and no reponse body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Emergency-Contacts/POST-Employee-Emergency-Contacts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Emergency-Contacts/POST-Employee-Emergency-Contacts.aspx)

#### Updating Employee Emergency Contact
We can use PATCH Employee Emergency Contacts operation with required parameters to update the emergency contact information  of existing employees.

**PATCH Employee Emergency Contacts**
```xml
<ceridiandayforce.patchEmployeeEmergencyContacts>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
</ceridiandayforce.patchEmployeeEmergencyContacts>
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
      "FirstName": "Alice",
      "LastName": "Glover",
      "IsPrimary": true,
      "Relationship": {
        "XRefCode": "WIFE",
        "ShortName": "Wife",
        "LongName": "Wife"
      },
      "Addresses": {
        "Items": []
      },
      "Contacts": {
        "Items": [
          {
            "ContactNumber": "213 658 9654",
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
          }
        ]
      }
    }
}
```

**Sample response**

This operation returns HTTP code 200 with no response body

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Emergency-Contacts/PATCH-Employee-Emergency-Contacts.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Personal-Information/Employee-Emergency-Contacts/PATCH-Employee-Emergency-Contacts.aspx)

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
         <ceridiandayforce.patchEmployeeEmergencyContacts>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
            <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
            <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
         </ceridiandayforce.patchEmployeeEmergencyContacts>
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
      "FirstName": "Alice",
      "LastName": "Glover",
      "IsPrimary": true,
      "Relationship": {
        "XRefCode": "WIFE",
        "ShortName": "Wife",
        "LongName": "Wife"
      },
      "Addresses": {
        "Items": []
      },
      "Contacts": {
        "Items": [
          {
            "ContactNumber": "213 658 9654",
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
          }
        ]
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

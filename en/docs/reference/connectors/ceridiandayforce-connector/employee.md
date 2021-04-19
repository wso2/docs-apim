# Working with Employees

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to work with Employee where you can retrieve employee human resources data and update it.
If the employee is not already in Dayforce, you can add them.

| Operation | Description |
| ------------- |-------------|
|[GET Employees](#retrieving-a-list-of-employees)| Search for employees using a number of parameters including organizational unit, hire dates, and employment status. |
|[GET Employee Details](#retrieving-details-of-employee)|Retrieve detailed data for a given employee.|
|[POST Employee](#create-an-employee)|Create an employee in Dayforce. This includes hiring an employee. Dayforce validates the data you submit and creates a new record for the employee.|
|[PATCH Employee](#update-existing-employee)|Update existing employee records. Supports rehire as well.|

### Operation details

This section provides more details on each of the operations.

#### Retrieving a list of Employees

We can use GET Employees operation with required parameters to search and find the required employees.

**GET Employees**
```xml
<ceridiandayforce.getEmployees>
    <employeeNumber>{$ctx:employeeNumber}</employeeNumber>
    <employmentStatusXRefCode>{$ctx:employmentStatusXRefCode}</employmentStatusXRefCode>
    <orgUnitXRefCode>{$ctx:orgUnitXRefCode}</orgUnitXRefCode>
    <filterHireStartDate>{$ctx:filterHireStartDate}</filterHireStartDate>
    <filterHireEndDate>{$ctx:filterHireEndDate}</filterHireEndDate>
    <filterTerminationStartDate>{$ctx:filterTerminationStartDate}</filterTerminationStartDate>
    <filterTerminationEndDate>{$ctx:filterTerminationEndDate}</filterTerminationEndDate>
    <filterUpdatedStartDate>{$ctx:filterUpdatedStartDate}</filterUpdatedStartDate>
    <filterUpdatedEndDate>{$ctx:filterUpdatedEndDate}</filterUpdatedEndDate>
    <contextDate>{$ctx:contextDate}</contextDate>
</ceridiandayforce.getEmployees>
```

**Properties**

* employeeNumber: Employment identification number assigned to an employee. A partial value can be provided for a wider search.\
* employmentStatusXRefCode: A case-sensitive field containing employment status values, which can be client-specific. Use a ContextDate value to search for employees with a given status as of a point in time. Otherwise, the search will use the current date and time.<br/>
* orgUnitXRefCode: A case-sensitive field that identifies a client's organizational units. Use this to search all levels of the employees’ organization including department, location, region, corporate, etc. Use a ContextDate value to search for employees with a specific value as of a point in time. Otherwise, the search will use the current date and time.<br/>
* filterHireStartDate: Use to search for employees whose most recent hire date is greater than or equal to the specified value (e.g. 2017-01-01T13:24:56). Use with filterHireEndDate to search for employees hired or rehired in a given timeframe.
* filterHireEndDate: This date is used to search for employees whose most recent hire date is less than or equal to the specified value. Typically this parameter is used in conjunction with FilterHireStartDate to search for employees hired or rehired in a given timeframe. Example: 2017-01-01T13:24:56
* filterTerminationStartDate: This date is used to search for employees with termination date values greater than or equal to the specified value. Typically this parameter is used in conjunction with FilterTerminationStartDate to search for employees terminated in a given timeframe. Example: 2017-01-01T13:24:56
* filterTerminationEndDate: This date is used to search for employees with termination date values less than or equal to the specified value. Typically this parameter is used in conjunction with filterTerminationStartDate to search for employees terminated in a given timeframe. Example: 2017-01-01T13:24:56
* filterUpdatedStartDate: The beginning date used when searching for employees with updates (and newly effective records) in a specified timeframe. When a value is provided for this parameter, a filterUpdatedEndDate value must also be provided. Because this search is conducted across all entities in the HR data model regardless of whether the requesting user has access to them, it is possible that the query will return XRefCode of employees with changes in which the consuming application is not interested. Example: 2017-01-01T13:24:56
* filterUpdatedEndDate: The end date used when searching for employees with updates (and newly effective records) in a specified timeframe. When a value is provided for this parameter, a filterUpdatedStartDate value must also be provided. Example: 2017-01-01T13:24:56
* contextDate: The Context Date value is an “as-of” date used to determine which employee data to search when records have specific start and end dates. The service defaults to the current datetime if the requester does not specify a value. Example: 2017-01-01T13:24:56

**Sample request**

Following is a sample request that can be handled by the GET Employees operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "employeeNumber": "42199"
}
```

**Sample response**

Given below is a sample response for the GET Employees operation.

```json
{
  "XRefCode": "42199"
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee/GET-Employees.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee/GET-Employees.aspx)

#### Retrieving details of employee
We can use GET Employee Details operation with required parameters to retrieve information on employees

**GET Employee Details**
```xml
<ceridiandayforce.getEmployeeDetails>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <contextDate>{$ctx:contextDate}</contextDate>
    <expand>{$ctx:expand}</expand>
    <contextDateRangeFrom>{$ctx:contextDateRangeFrom}</contextDateRangeFrom>
    <contextDateRangeTo>{$ctx:contextDateRangeTo}</contextDateRangeTo>
</ceridiandayforce.getEmployeeDetails>
```

**Properties**

* xRefCode: The unique identifier (external reference code) of the employee to be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* contextDate: The Context Date value is an “as-of” date used to determine which employee data to search when records have specific start and end dates. The service defaults to the current datetime if the requester does not specify a value. Example: 2017-01-01T13:24:56
* expand: This parameter accepts a comma-separated list of top-level entities that contain the data elements needed for downstream processing. When this parameter is not used, only data elements from the employee primary record will be included. For more information, please refer to the Introduction to Dayforce Web Services document.
* contextDateRangeFrom: The Context Date Range From value is the start of the range of dates used to determine which employee data to search when records have specific start and end dates. The service defaults to null if the requester does not specify a value. Example: 2017-01-01T13:24:56
* contextDateRangeTo: The Context Date Range To value is end of the range of dates to determine which employee data to search when records have specific start and end dates. The service defaults to null if the requester does not specify a value. Example: 2017-01-01T13:24:56

**Sample request**

Following is a sample request that can be handled by the GET Employee Details operation.

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

Given below is a sample response for the GET Employee Details operation.

```json
{
  "Data": {
    "BioExempt": false,
    "BirthDate": "1969-06-23T00:00:00",
    "ChecksumTimestamp": "2019-10-01T08:21:19.28",
    "ClockSupervisor": false,
    "Culture": {
      "XRefCode": "en-US",
      "ShortName": "English (US)",
      "LongName": "English (US)"
    },
    "EligibleForRehire": "NOTANSWERED",
    "FederatedId": "aaron.glover",
    "Gender": "M",
    "HireDate": "2000-08-23T00:00:00",
    "HomePhone": "202 265 8987",
    "NewHireApprovalDate": "2000-01-01T00:00:00",
    "NewHireApproved": true,
    "NewHireApprovedBy": "System",
    "OriginalHireDate": "2000-08-23T00:00:00",
    "PhotoExempt": false,
    "RegisteredDisabled": "NO",
    "RequiresExitInterview": false,
    "SeniorityDate": "2000-08-23T00:00:00",
    "SocialSecurityNumber": "252013727",
    "StartDate": "2000-08-23T00:00:00",
    "TaxExempt": true,
    "FirstTimeAccessEmailSentCount": 0,
    "FirstTimeAccessVerificationAttempts": 0,
    "SendFirstTimeAccessEmail": false,
    "EmployeeBadge": {
      "BadgeNumber": "33333",
      "EffectiveStart": "2000-01-01T00:00:00"
    },
    "LoginId": "mworker",
    "HomeOrganization": {
      "XRefCode": "500Packaging",
      "ShortName": "Plant 1 - Packaging",
      "LongName": "Plant 1 - Packaging"
    },
    "EmployeeNumber": "42199",
    "BioSensitivityLevel": {
      "XRefCode": "DEFAULT",
      "ShortName": "Default",
      "LongName": "Default"
    },
    "XRefCode": "42199",
    "CommonName": "Aaron",
    "DisplayName": "Aaron Glover",
    "FirstName": "Aaron",
    "LastName": "Glover"
  }
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee/GET-Employee-Details.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee/GET-Employee-Details.aspx)

#### Create an employee

We can use POST Employee operation with required parameters to create a new employee in Dayforce.

**POST Employee**
```xml
<ceridiandayforce.postEmployees>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
</ceridiandayforce.postEmployees>
```

**Properties**

* isValidateOnly: When a TRUE value is used in this parameter, POST (hire and rehire ) and PATCH (employee update) operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by the POST Employee operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "employeeNumber": "42199",
  "isValidateOnly": "true",
  "fieldAndValue": {
  "FirstName": "FSample",
  "LastName": "LSample",
  "XRefCode":"POST0090",
  "BioExempt": false,
  "BirthDate": "1990-05-12T00:00:00",
  "Culture": {
    "XRefCode": "en-US"
  },
  "Gender": "M",
  "HireDate": "2017-01-15T00:00:00",
  "PhotoExempt": false,
  "RequiresExitInterview": false,
  "SocialSecurityNumber": "252012728",
  "SendFirstTimeAccessEmail": false,
  "FirstTimeAccessEmailSentCount": 0,
  "FirstTimeAccessVerificationAttempts": 0,
  "Addresses": {
    "Items": [
      {
        "Address1": "4110 Yonge St.",
        "City": "North York",
        "PostalCode": "M2P 2B7",
        "Country": {
          "XRefCode": "CAN"
        },
        "State": {
          "XRefCode": "ON"
        },
        "ContactInformationType": {
          "XRefCode": "PrimaryResidence"
        },
        "EffectiveStart": "2017-01-15T00:00:00"
      }
    ]
  } ,
  "Contacts": {
    "Items": [
      {
        "ContactInformationType": {
          "XRefCode": "HomePhone"
        },
        "ContactNumber":"4169872987",
        "Country": {
          "XRefCode": "CAN"
        },
        "EffectiveStart": "2017-01-15T00:00:00",
        "ShowRejectedWarning": true,
        "IsForSystemCommunications": false,
        "IsPreferredContactMethod": false,
        "NumberOfVerificationRequests": 0
      }
    ]
  },
  "EmploymentStatuses": {
    "Items": [
      {

        "EffectiveStart": "2017-01-15T00:00:00",
        "EmploymentStatus": {
          "XRefCode": "ACTIVE"
        },
        "PayType": {
          "XRefCode": "HourlyNon"
        },
        "PayClass": {
          "XRefCode": "FT"
        },
        "PayGroup": {
          "XRefCode": "CAN"
        },
        "CreateShiftRotationShift": true,
        "BaseRate": 10.25,
        "EmploymentStatusReason": {
          "XrefCode":"NEWHIRE"
        }
      }
    ]
  },
  "Roles": {
    "Items": [
      {

        "Role": {
          "XRefCode": "CAssociate"
        },
        "EffectiveStart": "2017-01-15T00:00:00",
        "isDefault": true
      }
    ]
  },
  "WorkAssignments": {
    "Items": [
      {
        "Position": {
          "Department": {
            "XRefCode": "6"
          },
          "Job": {
            "XRefCode": "7"
          }
        },
        "Location": {
          "XRefCode": "500Operations"
        },
        "EffectiveStart": "2017-01-15T00:00:00",
        "IsPAPrimaryWorkSite": false,
        "IsPrimary": true,
        "IsVirtual": false,
        "EmploymentStatusReason": {
          "XrefCode":"NEW ASSIGNMENT"
        }

      }
    ]
  }
}
}
```

**Sample response**

Given below is a sample response for the POST Employee operation.

```json
{
    "ProcessResults": [
        {
            "Code": "HR_Employee_ValidSSNRequired",
            "Context": "Employee.SocialSecurityNumber",
            "Level": "WARN",
            "Message": "Valid National ID is required for employee"
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee/POST-Employee.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee/POST-Employee.aspx)

#### Update existing employee

We can use PATCH employee operation to update an existing employee details.


**PATCH Employee**
```xml
<ceridiandayforce.patchEmployee>
    <fieldAndValue>{$ctx:fieldAndValue}</fieldAndValue>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
    <isValidateOnly>{$ctx:isValidateOnly}</isValidateOnly>
</ceridiandayforce.patchEmployee>
```

**Properties**

* xRefCode: The unique identifier (external reference code) of the employee to be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.
* isValidateOnly: When a TRUE value is used in this parameter, POST (hire and rehire ) and PATCH (employee update) operations validate the request without applying updates to the database.

**Sample request**

Following is a sample request that can be handled by the PATCH Employee operation.

```json
{
  "username": "DFWSTest",
  "password": "DFWSTest",
  "clientNamespace": "usconfigr57.dayforcehcm.com/Api/ddn",
  "apiVersion": "V1",
  "employeeNumber": "42199",
  "isValidateOnly": "true",
  "xRefCode": "42199",
  "fieldAndValue": {
  "FirstName": "FSample",
  "LastName": "LSample",
  "XRefCode":"42199",
  "BioExempt": false,
  "BirthDate": "1990-05-12T00:00:00",
  "Culture": {
    "XRefCode": "en-US"
  },
  "Gender": "M",
  "HireDate": "2017-01-15T00:00:00",
  "PhotoExempt": false,
  "RequiresExitInterview": false,
  "SocialSecurityNumber": "252012728",
  "SendFirstTimeAccessEmail": false,
  "FirstTimeAccessEmailSentCount": 0,
  "FirstTimeAccessVerificationAttempts": 0,
  "Addresses": {
    "Items": [
      {
        "Address1": "4110 Yonge St.",
        "City": "North York",
        "PostalCode": "M2P 2B7",
        "Country": {
          "XRefCode": "CAN"
        },
        "State": {
          "XRefCode": "ON"
        },
        "ContactInformationType": {
          "XRefCode": "PrimaryResidence"
        },
        "EffectiveStart": "2017-01-15T00:00:00"
      }
    ]
  } ,
  "Contacts": {
    "Items": [
      {
        "ContactInformationType": {
          "XRefCode": "HomePhone"
        },
        "ContactNumber":"4169872987",
        "Country": {
          "XRefCode": "CAN"
        },
        "EffectiveStart": "2017-01-15T00:00:00",
        "ShowRejectedWarning": true,
        "IsForSystemCommunications": false,
        "IsPreferredContactMethod": false,
        "NumberOfVerificationRequests": 0
      }
    ]
  },
  "EmploymentStatuses": {
    "Items": [
      {

        "EffectiveStart": "2017-01-15T00:00:00",
        "EmploymentStatus": {
          "XRefCode": "ACTIVE"
        },
        "PayType": {
          "XRefCode": "HourlyNon"
        },
        "PayClass": {
          "XRefCode": "FT"
        },
        "PayGroup": {
          "XRefCode": "CAN"
        },
        "CreateShiftRotationShift": true,
        "BaseRate": 10.25,
        "EmploymentStatusReason": {
          "XrefCode":"NEWHIRE"
        }
      }
    ]
  },
  "Roles": {
    "Items": [
      {

        "Role": {
          "XRefCode": "CAssociate"
        },
        "EffectiveStart": "2017-01-15T00:00:00",
        "isDefault": true
      }
    ]
  },
  "WorkAssignments": {
    "Items": [
      {
        "Position": {
          "Department": {
            "XRefCode": "6"
          },
          "Job": {
            "XRefCode": "7"
          }
        },
        "Location": {
          "XRefCode": "500Operations"
        },
        "EffectiveStart": "2017-01-15T00:00:00",
        "IsPAPrimaryWorkSite": false,
        "IsPrimary": true,
        "IsVirtual": false,
        "EmploymentStatusReason": {
          "XrefCode":"NEW ASSIGNMENT"
        }

      }
    ]
  }
}
}
```

**Sample response**

Given below is a sample response for the PATCH Employee operation.

```json
{
    "ProcessResults": [
        {
            "Code": "HR_Employee_ValidSSNRequired",
            "Context": "Employee.SocialSecurityNumber",
            "Level": "WARN",
            "Message": "Valid National ID is required for employee"
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee/PATCH-Employee.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee/PATCH-Employee.aspx)

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
         <ceridiandayforce.getEmployees>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getEmployees>
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
  "employeeNumber": "42199"
}
```
3.Replace the credentials with your values.

4.Execute the following curl command:

```bash
curl http://localhost:8280/services/query -H "Content-Type: application/json" -d @query.json
```
5.Dayforce returns a json response similar to the one shown below:
 
```json
{
  "XRefCode": "42199"
}
```
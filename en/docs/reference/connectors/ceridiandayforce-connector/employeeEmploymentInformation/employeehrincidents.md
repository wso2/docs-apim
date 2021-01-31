# Working with Employee HR Incidents

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve hr incidents of an employee

| Operation | Description |
| ------------- |-------------|
|[GET Employee HR Incidents](#retrieving-employee-hr-incidents)| Retrieve HR incidents attached to an employee. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving Employee HR Incidents
We can use GET Employee HR Incidents operation with required parameters to search and find the hr incidents related to an employee.

**GET Employee HR Incidents**
```xml
<ceridiandayforce.getEmployeeHRIncidents>
    <xRefCode>{$ctx:xRefCode}</xRefCode>
</ceridiandayforce.getEmployeeHRIncidents>
```

**Properties**

* xRefCode (Mandatory): The unique identifier (external reference code) of the employee whose data will be retrieved. The value provided must be the exact match for an employee; otherwise, a bad request (400) error will be returned.

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
            "OrgUnit": {
                "XRefCode": "Plant1",
                "ShortName": "Plant 1",
                "LongName": "Plant 1"
            },
            "HRIncidentState": "CLOSED",
            "OpenDate": "2013-09-23T00:00:00",
            "HRIncidentType": {
                "XRefCode": "SafetyandHealthRecordable",
                "ShortName": "Safety and Health – OSHA Recordable",
                "LongName": "Safety and Health – OSHA Recordable"
            },
            "ClosedDate": "2013-09-23T00:00:00",
            "HRIncidentDate": "2013-09-01T00:00:00",
            "HRIncidentBeganWork": "1900-01-01T09:00:00",
            "HRIncidentEventTime": "1900-01-01T10:00:00",
            "SafetyHealthType": {
                "XRefCode": "Injury",
                "ShortName": "Injury",
                "LongName": "Injury"
            },
            "HRIncidentInjury": {
                "XRefCode": "LimbF",
                "ShortName": "Limb - Fracture",
                "LongName": "Limb - Fracture"
            },
            "HRIncidentBodyPart": {
                "XRefCode": "LimbsKnee",
                "ShortName": "Limbs - Knee",
                "LongName": "Limbs - Knee"
            },
            "Died": false,
            "HRIncidentArea": "Shop floor",
            "TaskBeingPerformed": "moving packages",
            "CausedObject": "Ladder",
            "CausedAction": "fell off ladder.",
            "PrivacyCase": false,
            "DoctorName": "Dr. Jones",
            "EmergencyRoom": true,
            "HospitalOvernight": true,
            "Hospital": "St Josephs",
            "HospitalStreet": "44 Main Street",
            "HospitalCity": "Jersey City",
            "HospitalStateCode": "NJ",
            "HospitalZip": "10017",
            "DateReturnToWork": "2013-09-23T00:00:00",
            "DaysLost": 15.00,
            "IsDaysLost": true
        },
        {
            "OrgUnit": {
                "XRefCode": "Corporate",
                "ShortName": "prd-500b-2018--01-29",
                "LongName": "XYZ Co..PRDemoGold - Jan  29th 2018 -53hf23\r12-22- update UK payrol/ppaca/onboad date\r12-18- Ran update payroll BSI script\rUpdate PPACA calanders"
            },
            "HRIncidentState": "OPEN",
            "OpenDate": "2019-10-01T00:00:00",
            "HRIncidentAction": {
                "ShortName": "Coaching"
            },
            "HRIncidentType": {
                "XRefCode": "Attendance and Punct",
                "ShortName": "Attendance and Punctuality"
            },
            "HRIncidentBeganWork": "1970-01-01T00:00:00",
            "HRIncidentEventTime": "1970-01-01T00:00:00",
            "Died": false,
            "PrivacyCase": false,
            "EmergencyRoom": false,
            "HospitalOvernight": false
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/HR-Incidents/GET-Employee-HR-Incidents.aspx](https://developers.dayforce.com/Build/API-Explorer/Employee-Employment-Information/HR-Incidents/GET-Employee-HR-Incidents.aspx)

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
         <ceridiandayforce.getEmployeeHRIncidents>
            <xRefCode>{$ctx:xRefCode}</xRefCode>
         </ceridiandayforce.getEmployeeHRIncidents>
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
            "OrgUnit": {
                "XRefCode": "Plant1",
                "ShortName": "Plant 1",
                "LongName": "Plant 1"
            },
            "HRIncidentState": "CLOSED",
            "OpenDate": "2013-09-23T00:00:00",
            "HRIncidentType": {
                "XRefCode": "SafetyandHealthRecordable",
                "ShortName": "Safety and Health – OSHA Recordable",
                "LongName": "Safety and Health – OSHA Recordable"
            },
            "ClosedDate": "2013-09-23T00:00:00",
            "HRIncidentDate": "2013-09-01T00:00:00",
            "HRIncidentBeganWork": "1900-01-01T09:00:00",
            "HRIncidentEventTime": "1900-01-01T10:00:00",
            "SafetyHealthType": {
                "XRefCode": "Injury",
                "ShortName": "Injury",
                "LongName": "Injury"
            },
            "HRIncidentInjury": {
                "XRefCode": "LimbF",
                "ShortName": "Limb - Fracture",
                "LongName": "Limb - Fracture"
            },
            "HRIncidentBodyPart": {
                "XRefCode": "LimbsKnee",
                "ShortName": "Limbs - Knee",
                "LongName": "Limbs - Knee"
            },
            "Died": false,
            "HRIncidentArea": "Shop floor",
            "TaskBeingPerformed": "moving packages",
            "CausedObject": "Ladder",
            "CausedAction": "fell off ladder.",
            "PrivacyCase": false,
            "DoctorName": "Dr. Jones",
            "EmergencyRoom": true,
            "HospitalOvernight": true,
            "Hospital": "St Josephs",
            "HospitalStreet": "44 Main Street",
            "HospitalCity": "Jersey City",
            "HospitalStateCode": "NJ",
            "HospitalZip": "10017",
            "DateReturnToWork": "2013-09-23T00:00:00",
            "DaysLost": 15.00,
            "IsDaysLost": true
        },
        {
            "OrgUnit": {
                "XRefCode": "Corporate",
                "ShortName": "prd-500b-2018--01-29",
                "LongName": "XYZ Co..PRDemoGold - Jan  29th 2018 -53hf23\r12-22- update UK payrol/ppaca/onboad date\r12-18- Ran update payroll BSI script\rUpdate PPACA calanders"
            },
            "HRIncidentState": "OPEN",
            "OpenDate": "2019-10-01T00:00:00",
            "HRIncidentAction": {
                "ShortName": "Coaching"
            },
            "HRIncidentType": {
                "XRefCode": "Attendance and Punct",
                "ShortName": "Attendance and Punctuality"
            },
            "HRIncidentBeganWork": "1970-01-01T00:00:00",
            "HRIncidentEventTime": "1970-01-01T00:00:00",
            "Died": false,
            "PrivacyCase": false,
            "EmergencyRoom": false,
            "HospitalOvernight": false
        }
    ]
}
```

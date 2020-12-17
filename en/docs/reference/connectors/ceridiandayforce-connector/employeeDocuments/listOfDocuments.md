# Working with Employee Addresses

[[Overview]](#overview)  [[Operation details]](#operation-details)  [[Sample configuration]](#sample-configuration)

### Overview 

The following operations allow you to retrieve list of documents attached to an employee

| Operation | Description |
| ------------- |-------------|
|[GET a List of Documents](#retrieving-a-list-of-documents)| This request allows to retrieve the list of documents attached to an employee. The response includes the document GUID used to retrieve contents with Get Document Details. |

### Operation details

This section provides more details on each of the operations.

#### Retrieving a List of Documents
We can use GET a List of Documents operation with required parameters to get the list of documents related to an employee.

**GET a List of Documents**
```xml
<ceridiandayforce.getAListOfDocuments>
    <employeeXRefCode>{$ctx:xRefCode}</employeeXRefCode>
</ceridiandayforce.getAListOfDocuments>
```

**Properties**

* employeeXRefCode (Mandatory): Uniquely identifies the employee whose document you want to retrieve. Partial search is not supported, so provide the full value. Otherwise, a 400 error will be returned.

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
            "DocumentGUID": "52dd3956-4ba3-4001-8678-a102757d42eb",
            "DocumentName": "Aaron Glover Employment Contract.jpg",
            "DocumentType": {},
            "FileName": "Aaron Glover Employment Contract.jpg",
            "UploadedDate": "2015-04-15T14:39:20.13",
            "UploadedBy": {
                "DisplayName": "Macon Burke",
                "XRefCode": "62779",
                "LoginId": "CAdmin"
            }
        },
        {
            "DocumentGUID": "696afd0c-5890-4316-9b7e-7ac990189018",
            "DocumentName": "Aaron Glover Birth Certificate.jpg",
            "DocumentType": {},
            "FileName": "Aaron Glover Birth Certificate.jpg",
            "UploadedDate": "2015-04-15T14:39:10.7",
            "UploadedBy": {
                "DisplayName": "Macon Burke",
                "XRefCode": "62779",
                "LoginId": "CAdmin"
            }
        }
    ]
}
```

**Related Dayforce documentation**

[https://developers.dayforce.com/Build/API-Explorer/Documents/GET-a-List-of-Documents-(1).aspx](https://developers.dayforce.com/Build/API-Explorer/Documents/GET-a-List-of-Documents-(1).aspx)

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
         <ceridiandayforce.patchEmployeeRoles>
            <employeeXRefCode>{$ctx:xRefCode}</employeeXRefCode>
         </ceridiandayforce.patchEmployeeRoles>
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
            "DocumentGUID": "52dd3956-4ba3-4001-8678-a102757d42eb",
            "DocumentName": "Aaron Glover Employment Contract.jpg",
            "DocumentType": {},
            "FileName": "Aaron Glover Employment Contract.jpg",
            "UploadedDate": "2015-04-15T14:39:20.13",
            "UploadedBy": {
                "DisplayName": "Macon Burke",
                "XRefCode": "62779",
                "LoginId": "CAdmin"
            }
        },
        {
            "DocumentGUID": "696afd0c-5890-4316-9b7e-7ac990189018",
            "DocumentName": "Aaron Glover Birth Certificate.jpg",
            "DocumentType": {},
            "FileName": "Aaron Glover Birth Certificate.jpg",
            "UploadedDate": "2015-04-15T14:39:10.7",
            "UploadedBy": {
                "DisplayName": "Macon Burke",
                "XRefCode": "62779",
                "LoginId": "CAdmin"
            }
        }
    ]
}
```

# Creatio Connector Example

## What you’ll build 

This example explains how to use the Creatio connector to connect with a CreatioCRM instance and perform the following operations.

- Create contact
- Retrieve information of the created contact
- Update contact
- Delete contact  

These operations will be available as resources of an API (creatioAPITest). 

## Configure the connector in WSO2 Integration Studio

Connectors can be added to integration flows in WSO2 Integration Studio, which is the tooling component of WSO2 MI. Once added, the operations of the connector can be dragged onto your design canvas and added to your sequences.

### Import the connector

Follow these steps to set up the Integration Project and the Connector Exporter Project. 

{!includes/reference/connectors/importing-connector-to-integration-studio.md!} 

Now the connector is added to the palette.

### Configure the connection and the operations

The following example has the Synapse configurations for the contact creation, deletion, update, and retrieve operations. While implementing the integration logic using the ‘design view’ (design canvas) the Synapse configurations will be available in the ‘source view’. 

Alternatively, you can copy and paste the below Synapse configuration in to the source view of the API and save it. 

!!! note 
    The `creatiocrm.init` operation should be configured with values applicable to the CreatioCRM instance you are using. 


```xml

<?xml version="1.0" encoding="UTF-8"?>
<api context="/creatioAPITest" name="creatioAPITest" xmlns="http://ws.apache.org/ns/synapse">
    <resource methods="GET" uri-template="/contact/{id}">
        <inSequence>
            <creatiocrm.init/>
            <creatiocrm.authSession/>
            <respond/>
        </inSequence>
        <outSequence/>
        <faultSequence/>
    </resource>
    <resource methods="POST" uri-template="/contact">
        <inSequence>
            <creatiocrm.init/>
            <creatiocrm.contactCreate/>
            <respond/>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
        <faultSequence/>
    </resource>
    <resource methods="DELETE" uri-template="/contact/{id}">
        <inSequence>
            <creatiocrm.contactDelete>
                <id>{$ctx:uri.var.id}</id>
            </creatiocrm.contactDelete>
            <respond/>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
        <faultSequence/>
    </resource>
    <resource methods="PATCH" uri-template="/contact/{id}">
        <inSequence>
            <creatiocrm.contactUpdate>
                <id>{$ctx:uri.var.id}</id>
            </creatiocrm.contactUpdate>
            <respond/>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
        <faultSequence/>
    </resource>
</api>

```

## Get the project

You can download the ZIP file and extract the contents to get the project code.

<a href="{{base_path}}/assets/attachments/connectors/creatio-test.zip">
    <img src="{{base_path}}/assets/img/integrate/connectors/download-zip.png" width="200" alt="Download ZIP">
</a>

!!! tip
    You may need to update the simulator details and make other such changes before deploying and running this project.

## Deployment

Follow these steps to deploy the exported CApp in the integration runtime. 

{!includes/reference/connectors/deploy-capp.md!}   

## Testing

The following are sample cURL requests and responses related to the operations of the above API. 

### Create contact

This cURL command creates a contact in the Creatio CRM.

**Request**

```curl

curl --location --request POST 'http://mi-hostname:8290/creatiodemo/contact' \
--data-raw '{
   "Name": "API Test",
   "JobTitle": "Marketing manager",
   "BirthDate": "0001-01-01T00:00:00Z",
   "Phone": "",
   "MobilePhone": "+1 213 566 34 22",
   "Email": "test@gmail",
   "Completeness": 30,
   "Age": 19
}'

```

**Response**

```json

{
   "@odata.context": "https://uat-telecom.creatio.com/0/odata/$metadata#Contact/$entity",
   "Id": "603af7c8-5da7-4a30-bc21-dd290256bb73",
   "Name": "API Test",
   "OwnerId": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
   "CreatedOn": "2022-08-28T17:21:01.1395058Z",
   "CreatedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
   "ModifiedOn": "2022-08-28T17:21:01.1395058Z",
   "ModifiedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
   "ProcessListeners": 0,
   "Dear": "",
   "SalutationTypeId": "00000000-0000-0000-0000-000000000000",
   "GenderId": "00000000-0000-0000-0000-000000000000",
   "AccountId": "00000000-0000-0000-0000-000000000000",
   "DecisionRoleId": "00000000-0000-0000-0000-000000000000",
   "TypeId": "00000000-0000-0000-0000-000000000000",
   "JobId": "00000000-0000-0000-0000-000000000000",
   "JobTitle": "Marketing manager",
   "DepartmentId": "00000000-0000-0000-0000-000000000000",
   "BirthDate": "0001-01-01T00:00:00Z",
   "Phone": "",
   "MobilePhone": "+1 213 566 34 22",
   "HomePhone": "",
   "Skype": "",
   "Email": "test@gmail",
   "AddressTypeId": "00000000-0000-0000-0000-000000000000",
   "Address": "",
   "CityId": "00000000-0000-0000-0000-000000000000",
   "RegionId": "00000000-0000-0000-0000-000000000000",
   "Zip": "",
   "CountryId": "00000000-0000-0000-0000-000000000000",
   "DoNotUseEmail": false,
   "DoNotUseCall": false,
   "DoNotUseFax": false,
   "DoNotUseSms": false,
   "DoNotUseMail": false,
   "Notes": "",
   "Facebook": "",
   "LinkedIn": "",
   "Twitter": "",
   "FacebookId": "",
   "LinkedInId": "",
   "TwitterId": "",
   "ContactPhoto@odata.mediaEditLink": "Contact(603af7c8-5da7-4a30-bc21-dd290256bb73)/ContactPhoto",
   "ContactPhoto@odata.mediaReadLink": "Contact(603af7c8-5da7-4a30-bc21-dd290256bb73)/ContactPhoto",
   "ContactPhoto@odata.mediaContentType": "application/octet-stream",
   "TwitterAFDAId": "00000000-0000-0000-0000-000000000000",
   "FacebookAFDAId": "00000000-0000-0000-0000-000000000000",
   "LinkedInAFDAId": "00000000-0000-0000-0000-000000000000",
   "PhotoId": "00000000-0000-0000-0000-000000000000",
   "GPSN": "",
   "GPSE": "",
   "Surname": "Test",
   "GivenName": "API",
   "MiddleName": "",
   "Confirmed": true,
   "IsNonActualEmail": false,
   "Completeness": 30,
   "LanguageId": "6ebc31fa-ee6c-48e9-81bf-8003ac03b019",
   "Age": 19,
   "MTCMStatusId": "00000000-0000-0000-0000-000000000000",
   "MTCMSelfCareRoleNewId": "00000000-0000-0000-0000-000000000000",
   "MTCMInfluencerRatingStr": "",
   "MTCMBudget": 0,
   "MTCMTarget": 0,
   "MTCMRoleId": "00000000-0000-0000-0000-000000000000",
   "MTSGoNogoId": "00000000-0000-0000-0000-000000000000",
   "MTCMVerticalId": "00000000-0000-0000-0000-000000000000",
   "MTCMInfluencerRatingId": "00000000-0000-0000-0000-000000000000"
}

```

### Get contact

This cURL command retrieves a contact from the Creatio CRM.

**Request**

```curl

curl --location --request GET 'http://mi-hostname:8290/creatioAPITest/contact/603af7c8-5da7-4a30-bc21-dd290256bb73' 

```

**Response**

```json

{
   "@odata.context": "https://uat-telecom.creatio.com/0/odata/$metadata#Contact/$entity",
   "Id": "603af7c8-5da7-4a30-bc21-dd290256bb73",
   "Name": "API Test",
   "OwnerId": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
   "CreatedOn": "2022-08-28T17:21:01.139505Z",
   "CreatedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
   "ModifiedOn": "2022-08-28T17:21:02.332303Z",
   "ModifiedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
   "ProcessListeners": 0,
   "Dear": "",
   "SalutationTypeId": "00000000-0000-0000-0000-000000000000",
   "GenderId": "00000000-0000-0000-0000-000000000000",
   "AccountId": "00000000-0000-0000-0000-000000000000",
   "DecisionRoleId": "00000000-0000-0000-0000-000000000000",
   "TypeId": "00000000-0000-0000-0000-000000000000",
   "JobId": "00000000-0000-0000-0000-000000000000",
   "JobTitle": "Marketing manager",
   "DepartmentId": "00000000-0000-0000-0000-000000000000",
   "BirthDate": "0001-01-01T00:00:00Z",
   "Phone": "",
   "MobilePhone": "+1 213 566 34 22",
   "HomePhone": "",
   "Skype": "",
   "Email": "test@gmail",
   "AddressTypeId": "00000000-0000-0000-0000-000000000000",
   "Address": "",
   "CityId": "00000000-0000-0000-0000-000000000000",
   "RegionId": "00000000-0000-0000-0000-000000000000",
   "Zip": "",
   "CountryId": "00000000-0000-0000-0000-000000000000",
   "DoNotUseEmail": false,
   "DoNotUseCall": false,
   "DoNotUseFax": false,
   "DoNotUseSms": false,
   "DoNotUseMail": false,
   "Notes": "",
   "Facebook": "",
   "LinkedIn": "",
   "Twitter": "",
   "FacebookId": "",
   "LinkedInId": "",
   "TwitterId": "",
   "ContactPhoto@odata.mediaEditLink": "Contact(603af7c8-5da7-4a30-bc21-dd290256bb73)/ContactPhoto",
   "ContactPhoto@odata.mediaReadLink": "Contact(603af7c8-5da7-4a30-bc21-dd290256bb73)/ContactPhoto",
   "ContactPhoto@odata.mediaContentType": "application/octet-stream",
   "TwitterAFDAId": "00000000-0000-0000-0000-000000000000",
   "FacebookAFDAId": "00000000-0000-0000-0000-000000000000",
   "LinkedInAFDAId": "00000000-0000-0000-0000-000000000000",
   "PhotoId": "00000000-0000-0000-0000-000000000000",
   "GPSN": "",
   "GPSE": "",
   "Surname": "Test",
   "GivenName": "API",
   "MiddleName": "",
   "Confirmed": true,
   "IsNonActualEmail": false,
   "Completeness": 30,
   "LanguageId": "6ebc31fa-ee6c-48e9-81bf-8003ac03b019",
   "Age": 19,
   "MTCMStatusId": "00000000-0000-0000-0000-000000000000",
   "MTCMSelfCareRoleNewId": "00000000-0000-0000-0000-000000000000",
   "MTCMInfluencerRatingStr": "",
   "MTCMBudget": 0.00,
   "MTCMTarget": 0.00,
   "MTCMRoleId": "00000000-0000-0000-0000-000000000000",
   "MTSGoNogoId": "00000000-0000-0000-0000-000000000000",
   "MTCMVerticalId": "00000000-0000-0000-0000-000000000000",
   "MTCMInfluencerRatingId": "00000000-0000-0000-0000-000000000000"
}

```

### Update contact

This cURL command updates a contact in the Creatio CRM.

**Request**

```curl

curl --location --request PATCH 'http://mi-hostname:8290/creatioAPITest/contact/7d21e3ea-3e78-42ba-bdc2-63a84f0d29a1' \
--data-raw '{
   "Name": "API Test",
   "JobTitle": "Marketing manager",
   "BirthDate": "0001-01-01T00:00:00Z",
   "Phone": "",
   "MobilePhone": "+1 213 566 34 22",
   "Email": "test@gmail",
   "Completeness": 30,
   "Age": 19
}'

```

**Response**

HTTP status - 204 No Content

### Delete contact

This cURL comman deletes a contact in the Creatio CRM.

**Request**

```curl

curl --location --request DELETE 'http://mi-hostname:8290/creatioAPITest/contact/7d21e3ea-3e78-42ba-bdc2-63a84f0d29a1' 

```

**Response**

HTTP status - 204 No Content

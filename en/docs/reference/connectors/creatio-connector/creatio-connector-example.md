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
--header 'Content-Type: application/json' \
--header 'BPMCSRF: g7NHfQtaLKInIMagWIxab.' \
--header 'set-cookie: .ASPXAUTH=922C412B93E9480CF5E95B90B5A7C711086F88115F72BA356BDC58E1092E32C37E5AA480FEC57561CFDEA2D17ABCCE334A76DF224C07292134F3CBE808294B3B705537BCFB0B607DEE1E9725AFCD25806B42796E320C07F577829A595B775C51D47CE9B882191D3EF53D1AB6BDFF9455D3D661460CED48D0FA841A4796C4EBD2E0DD26704EAAB22AFF883A8E4EF2862BCC600D603FFC36BE056E7D17DF9E5626CD6C9EF495D1FFAE624E4DAC062BD04D483548CE2DA6E78F890F2884A50896A1910E9787F054881AFEFFD9B0A43156CFB18796CA09D243BCE5A6061C0FB5BC74D221CC778657D6C7C53993F518C911C4841DA685C9B6D1264FDB513487B42D75392FD87D8B6A5721F56A3A72846274547EF2E1821455DE77D48B1D10EF4980699F3672DF4369C295240F0465DABF6F09A4E9F94972D3988F4D634EB6EF9C10C12F704F32D1F74B37AB5BA96B602F340C28F25AA982372C1148356E6CE315523E6660FE9A351901EE27EDCC8BCC8C5167B478DE37F04C632E3B67CDC27F1E07A6F12EE016CD328A32B49D9521B047495A95B51DC584E5C72A1D2A70D49BA50EE3DCA390B1779A9EEA3870DB20C6E06EA108B3F550C5E66EA50ADD3B66C527E8D13F7FAA65663163443CC92E1E17C7484846B862C0A310C8DB2D807F0F1879F844026EFC737DFE8F4AA93C4DAF17E06D48F42E0D01; path=/; secure; HttpOnly' \
--header 'set-cookie: BPMCSRF=hxCqU6QqGCjPKxehmUhog.; path=/; secure' \
--header 'set-cookie: UserName=83|117|112|101|114|118|105|115|111|114; expires=Fri, 06-May-2022 02:59:15 GMT; path=/; secure; HttpOnly' \
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

curl --location --request GET 'http://mi-hostname:8290/creatioAPITest/contact/603af7c8-5da7-4a30-bc21-dd290256bb73' \
--header 'Accept: application/json;odata=verbose' \
--header 'Content-Type: application/json' \
--header 'ForceUseSession: true' \
--header 'BPMCSRF: bHZfVOIO4.iSuXwMebGibe' \
--header 'set-cookie: UserName=83|117|112|101|114|118|105|115|111|114; expires=Sat, 07-May-2022 08:46:12 GMT; path=/; secure; HttpOnly' \
--header 'Cookie: UserName=83|117|112|101|114|118|105|115|111|114; BPMLOADER=1ndbm4mg3bujyg4syir5gzyw; .ASPXAUTH=DDEF5C8454B7F2DC87B8250B7BB286CCEDB46A5DA6B08BD447E62EC65949BE5C9D37380B095928EB181751D8E6BAB4D8081C3EF7BAF31561BCAF43572BE5E77C7223F411ED9EBED1A369B7835726C464F75FDE56E6D0F2D78BD56671A46561B179A5C93D7D8DB4F04EEB7BF689AA24FB9D348E6E5928318015D45D52CCA9E5B1A597FCE02170EF75235F9B1245042A87F7B0236BF9D39F10235FDEAE0D078C680E0E09362AF91BFCDEDBC0B8CDBBC2858F1652ADAA6CD367C0F9BBBF2F309A2B59E3EC2D310CB457EF17507AEFFE4E6E82F6C1F4994C130E49059408FCC2E3D97ADDF97CB111E9FC9A0E72CC7FD7F560032C56D420FDC898C86E90C406C5A7A27E1CDF65E09502EAD22FFD7DE69EB139E2A3FB13DC5A88ADD894DDD30615D3C5A83012C41CCFECA48C9D34C97EEB4D56FCE13375F78EBFC91A7695DA1335C9EA03AEC108F6EE71D6F8DCEC9E9E0107A4F8A666486D990D809E2F573077FB1736CC29027B0F3B0260DE572B3787046B04170B000B82F10AD8C18231A1BC199D6EC97B436B497F0BCC42C0DF71C2974FBAEC8243B2FB679C7283E27817840FFE19314F07596D95069EDE22741C95B732D426A2F0E08685787FE515AC5795FF684416D81F714B040134F4CD1562C65026D468ADA59AD64E460718A8F465BF780EA897593CCE5627626672BA6BD23D135947BBF7AF8D; BPMCSRF=bHZfVOIO4.iSuXwMebGibe'

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
--header 'Accept: application/json;odata=verbose' \
--header 'Content-Type: application/json' \
--header 'ForceUseSession: true' \
--header 'BPMCSRF: bHZfVOIO4.iSuXwMebGibe' \
--header 'set-cookie: UserName=83|117|112|101|114|118|105|115|111|114; expires=Sat, 07-May-2022 08:46:12 GMT; path=/; secure; HttpOnly' \
--header 'Cookie: UserName=83|117|112|101|114|118|105|115|111|114; BPMLOADER=1ndbm4mg3bujyg4syir5gzyw; .ASPXAUTH=DDEF5C8454B7F2DC87B8250B7BB286CCEDB46A5DA6B08BD447E62EC65949BE5C9D37380B095928EB181751D8E6BAB4D8081C3EF7BAF31561BCAF43572BE5E77C7223F411ED9EBED1A369B7835726C464F75FDE56E6D0F2D78BD56671A46561B179A5C93D7D8DB4F04EEB7BF689AA24FB9D348E6E5928318015D45D52CCA9E5B1A597FCE02170EF75235F9B1245042A87F7B0236BF9D39F10235FDEAE0D078C680E0E09362AF91BFCDEDBC0B8CDBBC2858F1652ADAA6CD367C0F9BBBF2F309A2B59E3EC2D310CB457EF17507AEFFE4E6E82F6C1F4994C130E49059408FCC2E3D97ADDF97CB111E9FC9A0E72CC7FD7F560032C56D420FDC898C86E90C406C5A7A27E1CDF65E09502EAD22FFD7DE69EB139E2A3FB13DC5A88ADD894DDD30615D3C5A83012C41CCFECA48C9D34C97EEB4D56FCE13375F78EBFC91A7695DA1335C9EA03AEC108F6EE71D6F8DCEC9E9E0107A4F8A666486D990D809E2F573077FB1736CC29027B0F3B0260DE572B3787046B04170B000B82F10AD8C18231A1BC199D6EC97B436B497F0BCC42C0DF71C2974FBAEC8243B2FB679C7283E27817840FFE19314F07596D95069EDE22741C95B732D426A2F0E08685787FE515AC5795FF684416D81F714B040134F4CD1562C65026D468ADA59AD64E460718A8F465BF780EA897593CCE5627626672BA6BD23D135947BBF7AF8D’ \
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

curl --location --request DELETE 'http://mi-hostname:8290/creatioAPITest/contact/7d21e3ea-3e78-42ba-bdc2-63a84f0d29a1' \
--header 'Accept: application/json;odata=verbose' \
--header 'Content-Type: application/json' \
--header 'ForceUseSession: true' \
--header 'BPMCSRF: bHZfVOIO4.iSuXwMebGibe' \
--header 'set-cookie: UserName=83|117|112|101|114|118|105|115|111|114; expires=Sat, 07-May-2022 08:46:12 GMT; path=/; secure; HttpOnly' \
--header 'Cookie: UserName=83|117|112|101|114|118|105|115|111|114; BPMLOADER=1ndbm4mg3bujyg4syir5gzyw; .ASPXAUTH=DDEF5C8454B7F2DC87B8250B7BB286CCEDB46A5DA6B08BD447E62EC65949BE5C9D37380B095928EB181751D8E6BAB4D8081C3EF7BAF31561BCAF43572BE5E77C7223F411ED9EBED1A369B7835726C464F75FDE56E6D0F2D78BD56671A46561B179A5C93D7D8DB4F04EEB7BF689AA24FB9D348E6E5928318015D45D52CCA9E5B1A597FCE02170EF75235F9B1245042A87F7B0236BF9D39F10235FDEAE0D078C680E0E09362AF91BFCDEDBC0B8CDBBC2858F1652ADAA6CD367C0F9BBBF2F309A2B59E3EC2D310CB457EF17507AEFFE4E6E82F6C1F4994C130E49059408FCC2E3D97ADDF97CB111E9FC9A0E72CC7FD7F560032C56D420FDC898C86E90C406C5A7A27E1CDF65E09502EAD22FFD7DE69EB139E2A3FB13DC5A88ADD894DDD30615D3C5A83012C41CCFECA48C9D34C97EEB4D56FCE13375F78EBFC91A7695DA1335C9EA03AEC108F6EE71D6F8DCEC9E9E0107A4F8A666486D990D809E2F573077FB1736CC29027B0F3B0260DE572B3787046B04170B000B82F10AD8C18231A1BC199D6EC97B436B497F0BCC42C0DF71C2974FBAEC8243B2FB679C7283E27817840FFE19314F07596D95069EDE22741C95B732D426A2F0E08685787FE515AC5795FF684416D81F714B040134F4CD1562C65026D468ADA59AD64E460718A8F465BF780EA897593CCE5627626672BA6BD23D135947BBF7AF8D; BPMCSRF=bHZfVOIO4.iSuXwMebGibe'

```

**Response**

HTTP status - 204 No Content

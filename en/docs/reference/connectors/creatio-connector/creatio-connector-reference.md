# Creatio Connector Reference

## Authentication implementation

The Creatio connector uses Forms authentication (cookie-based) to authenticate requests with CreatioCRM and the required cookies are retrieved through basic authentication. The Authentication request is created based on the information including the CreatioCRM user credentials configured in the "init" operation of the connector. Once the Creatio REST API provides the authentication response, it is processed by the connector to derive the cookie values.

The authentication response contains two auth cookies (“BPMCSRF” and “Cookie”) as HTTP header values. 

The REST API calls related to CreatioCRM CRUD operations are expected to have the above cookies as HTTP headers. Therefore, the connector will validate if the authentication headers present in the incoming API request.

If the authentication headers are present in the API request, the connector will send the original request as it is.  

If the HTTP status of the response is 401, 403, 301, and 302 (invalid header value or redirection to regenerate the headers), the connector sends the authentication request again and sets the Auth response header back to the original request and perform the original request.

If the HTTP status of the response is not 401, 403, 301, and 302, then the response is returned to the client app.

The reason to retry the API calls when giving HTTP status 401, 403, 301, and 302 by Creatio, it returns those HTTP Status when Authentication fails due to multiple reasons and need to retry one time to succeed the relevant API calls. 

If the headers are not present, the connector sends the authentication request intermediately before the relevant REST API call. After getting the relevant cookie headers, it sends the original request to the Creatio endpoint with the retrieved cookies set as headers and sends back the response.

The authentication request is sent to the Creatio platform and the received response is processed to derive the cookie values that are CSRF token and Cookie header values that contain the necessary auth data for authentication at the Creatio end. These HTTP header values need to be set by the client application when calling any other REST API resource from the Creatio end. After expiry, you will be responsible for getting new CSRF cookie values. 

To use the Creatio connector, add the `<creatiocrm.init>` element in your configuration before carrying out any other Creatio operations.

## Operations

The following operations allow you to work with the Documentum Connector. Click an operation name to see parameter details and samples on how to use it.

### Initialize the connector

??? note "Init"
    This operation is to create an authentication channel after successful authentication, it will respond back with two main cookie values by the WSO2 EI in-order to use subsequent API requests. 

    The init operation has the below configurations that are required to obtain the authentication cookies information for the rest of the operations.

    |parameter Name|Description|Required|Sample Value|
    |:----|:----|:----|:----|
    |hostName|Hostname of the CreatioCRM|Yes|116914-crm-bundle.creatio.com|
    |password|Password for login to CreatioCRM|Yes|Supervisor|
    |username|Username for login to CreatioCRM|Yes|Supervisor|
    |timeout|Timeout value of the Creatio backend|No|6000|

    **Sample Configuration**

    ```xml

    <creatiocrm.init>
        <hostName>https://<hostname>/</hostName>
        <password>password</password>
        <username>username<username>
    </creatiocrm.init>
    <creatiocrm.authSession/>
    
    ```

    This explains how the API request for the init operation should be and the response coming back from the Creatio connector for the Authentication operation.

|Request Header Field|Type|Description|
|:----|:----|:----|
|Content-Type|String|application/json|

|Response Header Field|Type|value|Description|
|:----|:----|:----|:----|
|BPMCSRF|String|The CSRF Token|E.g., bHZfVOIO4.iSuXwMebGibes|
|Cookie|String|Cookie Value|E.g., UserName=83|117|112|101|114|118|105|115|111|114; BPMLOADER=1ndbm4mg3bujyg4syir5gzyw; .ASPXAUTH=DDEF5C8454B7F2DC87B8250B7BB286CCEDB46A5DA6B08BD447E62EC65949BE5C9D37380B095928EB181751D8E6BAB4D8081C3EF7BAF31561BCAF43572BE5E77C7223F411ED9EBED1A369B7835726C464F75FDE56E6D0F2D78BD56671A46561B179A5C93D7D8DB4F04EEB7BF689AA24FB9D348E6E5928318015D45D52CCA9E5B1A597FCE02170EF75235F9B1245042A87F7B0236BF9D39F10235FDEAE0D078C680E0E09362AF91BFCDEDBC0B8CDBBC2858F1652ADAA6CD367C0F9BBBF2F309A2B59E3EC2D310CB457EF17507AEFFE4E6E82F6C1F4994C130E49059408FCC2E3D97ADDF97CB111E9FC9A0E72CC7FD7F560032C56D420FDC898C86E90C406C5A7A27E1CDF65E09502EAD22FFD7DE69EB139E2A3FB13DC5A88ADD894DDD30615D3C5A83012C41CCFECA48C9D34C97EEB4D56FCE13375F78EBFC91A7695DA1335C9EA03AEC108F6EE71D6F8DCEC9E9E0107A4F8A666486D990D809E2F573077FB1736CC29027B0F3B0260DE572B3787046B04170B000B82F10AD8C18231A1BC199D6EC97B436B497F0BCC42C0DF71C2974FBAEC8243B2FB679C7283E27817840FFE19314F07596D95069EDE22741C95B732D426A2F0E08685787FE515AC5795FF684416D81F714B040134F4CD1562C65026D468ADA59AD64E460718A8F465BF780EA897593CCE5627626672BA6BD23D135947BBF7AF8D; BPMCSRF=bHZfVOIO4.iSuXwMebGibe|

### Creatio operations 

When API authentication fails due to expired/invalid cookies, the creatiocrm.init mediator will be used for the regeneration of authentication header values. Therefore, to avoid authentication failures, ‘creatiocrm.init’ and ‘creatiocrm.authSession’ mediators (as shown above under ‘Init Operation’) should be added just before any of the API resources. Any advanced authentication requirements should be addressed through an API Management solution. 

### Contact operations

??? note "Create Contact"
    The REST API of Contact creation operation is triggered by the creatiocrm.contactCreate mediator to create a new Contact with a unique id in the CreatioCRM. 
    
    The message body for the contact creation will be taken from the payload of the existing message context.

    |Field|Type|Description|Remarks|
    |:----|:----|:----|:----|
    |Content-Type|String|application/json|	|
    |BPMCSRF|String|The CSRF Token from the Auth response|E.g., bHZfVOIO4.iSuXwMebGibes|
    |Set-cookie|String|Value of Username cookie from the Auth response|E.g., UserName=83|117|112|101|114|118|105|115|111|114; expires=Sat, 07-May-2022 08:46:12 GMT; path=/; secure; HttpOnly|
    |Cookie|String|Cookie Value from the Auth response|	|

    **Sample Configuration**

    ```xml
    <creatiocrm.init>
        <hostName>https://creatio-hostname</hostName>
        <password>creatio-username</password>
        <username>creatio-password</username>
    </creatiocrm.init>

    <creatiocrm.contactCreate/>
    ```

    **Sample request**

    ```json
    {
        "Name": "API Test",
        "AccountId": "e6574af1-3e92-4099-958e-e798f52ee016",
        "JobTitle": "Marketing manager",
        "BirthDate": "0001-01-01T00:00:00Z",
        "Phone": "",
        "MobilePhone": "+1 213 566 34 22",
        "Email": "test@gmail",
        "Completeness": 30,
        "Age": 19
    }
    ```

    **Sample response**

    ```json

    {
        "@odata.context": "https://116914-crm-bundle.creatio.com/0/odata/$metadata#Contact/$entity",
        "Id": "12d21632-8b20-45d9-942f-20fcbbf2957c",
        "Name": "API Test",
        "OwnerId": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
        "CreatedOn": "2022-04-07T09:37:58.5679414Z",
        "CreatedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
        "ModifiedOn": "2022-04-07T09:37:58.5679414Z",
        "ModifiedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
        "ProcessListeners": 0,
        "Dear": "",
        "SalutationTypeId": "00000000-0000-0000-0000-000000000000",
        "GenderId": "00000000-0000-0000-0000-000000000000",
        "AccountId": "e6574af1-3e92-4099-958e-e798f52ee016",
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
        "ContactPhoto@odata.mediaEditLink": "Contact(12d21632-8b20-45d9-942f-20fcbbf2957c)/ContactPhoto",
        "ContactPhoto@odata.mediaReadLink": "Contact(12d21632-8b20-45d9-942f-20fcbbf2957c)/ContactPhoto",
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
        "IsEmailConfirmed": false
    }
    ```

??? note "Get Contact"
    The contactGet operation is used to retrieve existing contact details from CreatioCRM with the provided ID. If the given ID does not exist in the CreatioCRM, this will return 404 HTTP status code.

    |Field|Type| |Description|Remarks|
    |:----|:----|:----|:----|:----|
    |BPMCSRF|String| |The CSRF Token from the Auth response|Ex: bHZfVOIO4.iSuXwMebGibes|
    |Set-cookie|String| |Value of Username cookie from the Auth response|Ex: UserName=83|117|112|101|114|118|105|115|111|114; expires=Sat, 07-May-2022 08:46:12 GMT; path=/; secure; HttpOnly|
    |Cookie|String| |Cookie Value from the Auth response| |

    **Sample configuration**

    ```xml

    <creatiocrm.init>
        <hostName>https://creatio-hostname</hostName>
        <password>creatio-username</password>
        <username>creatio-password</username>
    </creatiocrm.init>
    <creatiocrm.contactGet>
        <id>{$ctx:id}</id>
    </creatiocrm.contactGet>

    ```

    **Sample Response**

    ```json

    {
        "@odata.context": "https://116914-crm-bundle.creatio.com/0/odata/$metadata#Contact/$entity",
        "Id": "12d21632-8b20-45d9-942f-20fcbbf2957c",
        "Name": "API Test",
        "OwnerId": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
        "CreatedOn": "2022-04-07T09:37:58.5679414Z",
        "CreatedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
        "ModifiedOn": "2022-04-07T09:37:58.5679414Z",
        "ModifiedById": "410006e1-ca4e-4502-a9ec-e54d922d2c00",
        "ProcessListeners": 0,
        "Dear": "",
        "SalutationTypeId": "00000000-0000-0000-0000-000000000000",
        "GenderId": "00000000-0000-0000-0000-000000000000",
        "AccountId": "e6574af1-3e92-4099-958e-e798f52ee016",
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
        "ContactPhoto@odata.mediaEditLink": "Contact(12d21632-8b20-45d9-942f-20fcbbf2957c)/ContactPhoto",
        "ContactPhoto@odata.mediaReadLink": "Contact(12d21632-8b20-45d9-942f-20fcbbf2957c)/ContactPhoto",
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
        "IsEmailConfirmed": false
    }


    ```
    
??? note "Update Contact"
    The contactUpdate operation is  used to update an existing contact details in the CreatioCRM. 

    If the given ID does not exist in the CreatioCRM, this will create a  new contact with the given ID. The message body for the contact update will be taken from the payload of existing message context.

    |Field|Type| |Description|Remarks|
    |:----|:----|:----|:----|:----|
    |BPMCSRF|String| |The CSRF Token from the Auth response|Ex: bHZfVOIO4.iSuXwMebGibes|
    |Set-cookie|String| |Value of Username cookie from the Auth response|Ex: UserName=83|117|112|101|114|118|105|115|111|114; expires=Sat, 07-May-2022 08:46:12 GMT; path=/; secure; HttpOnly|
    |Cookie|String| |Cookie Value from the Auth response| |


    **Sample configuration**

    ```xml
    <creatiocrm.init>
        <hostName>https://creatio-hostname</hostName>
        <password>creatio-username</password>
        <username>creatio-password</username>
    </creatiocrm.init>
    <creatiocrm.contactUpdate>
        <id>{$ctx:id}</id>
    </creatiocrm.contactUpdate>

    ```

    **Sample request** 

    ```json

    {
        "Name": "API Test",
        "AccountId": "e6574af1-3e92-4099-958e-e798f52ee016",
        "JobTitle": "Marketing manager",
        "BirthDate": "0001-01-01T00:00:00Z",
        "Phone": "",
        "MobilePhone": "+1 213 566 34 22",
        "Email": "test@gmail",
        "Completeness": 30,
        "Age": 19
    }

    ```
    




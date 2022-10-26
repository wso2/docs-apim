# API Key Authentication

API Key Authentication in Choreo Connect is a simple authentication scheme that accepts a valid self-contained JWT token issued for accessing APIs. Since self-contained tokens can have all authorization information, the token processing time is fast and more efficient. The common practice is to have a short expiration time for self-contained access tokens.

Select one of the methods given below to enable API Key Authentication for an API depending on the Choreo Connect **mode** you are using.

|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Secure APIs with API Keys via API-M]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[Update the OpenAPI definition of the API](#update-the-openapi-definition-of-the-api) |     

## Update the OpenAPI definition of the API

When deploying via WSO2 API Manager, as you enable API authentication for an API, it will overrides any already existing the API Key Authentication defined in the OpenAPI definition. Therefore, making changes via the API Manager Publisher UI is sufficient. Use the following steps to enable API Key authentication when deploying an API using the apictl, in other words, during standalone mode.

### Step 1  - Define the API Key security scheme

Security schemes must be defined on the OpenAPI definition under `securitySchemes`. One or more API Key security schemes can be used simultaneously, similar to a logical OR operator. Define the API Key security scheme as follows:

| Field Name | Description   |
| -----------| --------------|
| `name`     | Header name or query key for the APIKey. |
| `in`       | This can be either `header` or `query`. |
| `type`     | Specify `apiKey` as the type. |

The following example defines an API Key security scheme named `apiKeyAuth`, which sends `X-API-Key` as a request header. Here, `apiKeyAuth` is the name provided for the security scheme and `X-API-Key` is the name for the header.

!!! note
    The following example shows how to define API Key security schemes in [OAS3](https://swagger.io/docs/specification/authentication/api-keys/). If you are using an OAS2 API definition, go to [this Swagger document](https://swagger.io/docs/specification/2-0/authentication/api-keys/) to get more information on defining API Key security in OAS2.


```
components:
 securitySchemes:
   ApiKeyAuth:        # arbitrary name for the security scheme
     type: apiKey
     in: header       # can be "header" or "query" 
     name: X-API-KEY  # name of the header or query parameter
   appId:             # you can define several API Key security schemas
     type: apiKey
     in: header
     name: X-APP-ID
```

### Step 2 - Apply the API Key Authentication security scheme

A security scheme can be applied at a resource level or to the whole API by using the **`security`** keyword as applicable. A resource-level security scheme will override an API-level security scheme. In the example given below, the `ApiKeyAuth` security scheme that has already been defined is referred from the resource `/pet/{petId}`. For more information, refer to the [Swagger documentation on API Keys](https://swagger.io/docs/specification/authentication/api-keys/).

#### Operation-specific security

The following code snippet is an example of how the API key can be applied to a specific resource.

```
"/pet/{petId}":
 get:
   tags:
     - pet
   summary: Find pet by ID
   description: Returns a single pet
   operationId: getPetById
   parameters:
     - name: petId
       in: path
       description: ID of pet to return
       required: true
       schema:
         type: integer
         format: int64
   security:
     - ApiKeyAuth: []
```

#### API Level security

The following code snippet is an example of how the API key can be applied globally to all operations.

```
security:
- ApiKeyAuth: [] 
```

### Step 3 - Generate an API Key

Currently, only API Keys issued by WSO2 API Manager are allowed. 
Hence, you need a valid API Key issued for the particular API Name and the version from WSO2 API Manager.
Follow the steps mentioned on [generating the API Key documentation]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys/#using-api-keys-to-secure-an-api) to generate an API Key from API Manager.

### Step 4 - Invoke the API using the API Key

Use the following cURL command to invoke the API with API Key. When using API Manager, you can directly use the cURL command that appears in the Developer Portal test console.

``` bash tab="Format"
curl -k -X GET "<API_URL>" -H  "accept: application/json" -H  "<Header name>: <API Key>"
```

``` bash tab="Example"
curl -k -X GET "https://localhost:9095/petstore/v1/pet/1" -H  "accept: application/json" -H  "X-API-KEY: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJqd3QiLCAia2lkIjoiYmFsbGVyaW5hIn0=.eyJzdWIiOiJhZG1pbiIsICJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo5MDk1L2FwaWtleSIsICJpYXQiOjE1ODAxMDUzOTAsICJqdGkiOiI3OTFiNzAyMC1kN2U2LTRmYmEtYmMyMy1lMzk5YTVlNmYzYjciLCAiYXVkIjoiaHR0cDovL29yZy53c28yLmFwaW1ndC9nYXRld2F5IiwgImtleXR5cGUiOiJQUk9EVUNUSU9OIiwgImFsbG93ZWRBUElzIjpbXX0=.f-86LfD7lLq-0oM1V1u1dLW7fWcydH4MElWVxUfRTGGRiXHhh8VrS5q18LdCtH1E1jav5pPZpdDQgQUvhVYNXVqiipydfJFOMbDysA0Jdakmh_TVmeZRHhIYgzcVHQNnXMcYXg7Ns4QPBvJVONfbmDluuiU_uFnOPBiXj2N4HL2OTLgVXkEoVTEpL0mmaO2Ab4ZHqKW5xj32aeK8sEAtU5Nd3rQOGvfEwL7xvx4JAmza8ka0eYt7c4QCPVcDSVOkdas9njlsvEdtka5GRL9PAx3xg370phSD1cji6WSRlZhEGzuq6hjLbCqsf17KvZgK1zbrEbSypjgegEe-any3EQ=="
```

``` bash tab="Response"
{"id":1,"category":{"id":0},"name":"tested","photoUrls":[],"tags":[],"status":"tested"}
```
 
   
## Additional Information

Choreo Connect API Key Authentication supports restrictions for IP address and HTTP referrer. 

{!includes/design/additional-api-key.md!}

## Configurations related to API Key

Following is the default config referred for API Key authentication. The token service name "APIM Publisher" refers to the Control Plane and holds the configurations for API key, and not to be confused with the access token issuer which is the "Resident Key Manager" as defined in the config. Therefore, even if both of the token types (API keys and access tokens) are produced by the same token issuer which is the Resident Key Manager, subscription validation can be enabled independently.

```
[[enforcer.security.tokenService]]
name = "APIM Publisher"
issuer = "https://localhost:9443/publisher"
validateSubscription = true
certificateAlias = ""
certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"
```

!!! info
    Choreo Connect Update 1.1.0.8 onwards, you may use the following to reconfigure API Authentication related configs.

    ```
    [[enforcer.security.tokenService]]
    name = "APIM APIkey"
    validateSubscription = true
    certificateAlias = "apikey_certificate_alias"
    certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"
    ```

    - name - Name of the token service and must not be changed 
    - certificateAlias - Alias name given in Enforcer truststore for the public certificate of the JWT issuer 
    - certificateFilePath - Certificate Filepath within the Enforcer container 
    - validateSubscription 

        Whether to validate subscriptions. **If disabled**, a single API key may be used against any API in the same Choreo Connect instance since only the JWT signature would be validated procedure. When set to true, sunscription validation is done as given below depending on the Choreo Connect mode. 

        - For [Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   - Check against the subscriptions received from the Control Plane in order to validate the mapping between the invoked API and application info in the API key JWT claims.

        - For [Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/) -  Check the metadata of the invoked API against the API details included in the API key claims. 

## See also

- [OAuth 2.0 Authentication]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/oauth2-access-tokens/)
- [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/)
- [Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/subscription-validation)
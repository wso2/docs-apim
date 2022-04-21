# API Key Authentication

API Key Authentication in Choreo Connect is a simple authentication scheme that accepts a valid self-contained JWT token issued for accessing APIs. Since self-contained tokens can have all authorization information, the token processing time is fast and more efficient. The common practice is to have a short expiration time for self-contained access tokens.

Pick a method below to enable API Key Authentication depending on the Choreo Connect **mode** you have selected:

|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Secure APIs with API Keys via API-M]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[Update the OpenAPI definition of the API](#update-the-openapi-definition-of-the-api) |

## Update the OpenAPI definition of the API

Follow the instructions below to enable API Key Authentication using OpenAPI security schemes.

!!! info
    When you enable API authentication for an API and deploy via WSO2 API Manager, it will override the API Key Authentication defined in the OpenAPI definition.
    Therefore, the following steps work for Choreo Connect when the API is not deployed via WSO2 API Manager. 
    So use the following steps when you want to enable API Key authentication when deploying an API using the APICTL.

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

``` yml
# step 1 - Define the API Key security scheme
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

A security scheme can be specified at a resource level or to the whole API by using the **`security`** section as applicable. The following is an example of how to apply a security scheme to a resource. A resource-level security scheme will override an API-level security scheme. The `ApiKeyAuth` security scheme that has been defined has been referred to from the `/pet/{petId}:` resource by using the security section. For more information, refer to the [Swagger documentation on API Keys](https://swagger.io/docs/specification/authentication/api-keys/).

- **Operation-specific security**

   The following code snippet is an example of how the API key can be applied to a specific resource.

  ``` yml
   # step 2 - Specify the API Key security in operation level
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

- **API Level security**

    The following code snippet is an example of how the API key can be applied globally to all operations.

     ``` yml
     # step 2 - Specify the API Key security in api level
     security:
      - ApiKeyAuth: [] 
     ```

### Step 3 - Generate an API Key

Currently, only API Keys issued by WSO2 API Manager are allowed. 
Hence, you need a valid API Key issued for the particular API Name and the version from WSO2 API Manager.
Follow the steps mentioned on [generating the API Key documentation]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys/#using-api-keys-to-secure-an-api) to generate an API Key from API Manager.

### Step 3 - Invoke the API using the API Key

Use one of the following options to invoke APIs using an API key based on the method that you used to define API Key Authentication in [step 1](#step-1-define-api-key-authentication-for-the-api).

- **API key defined in the OpenAPI definition security schemes**

     Execute the following cURL command to invoke APIs when the API key is defined in the OpenAPI definition security schemes.

      ``` bash tab="Format"
      curl -k -X GET "<API_URL>" -H  "accept: application/json" -H  "<Header name>: <API Key>"
      ```

      ``` bash tab="Example"
      curl -k -X GET "https://localhost:9095/petstore/v1/pet/1" -H  "accept: application/json" -H  "X-API-KEY: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJqd3QiLCAia2lkIjoiYmFsbGVyaW5hIn0=.eyJzdWIiOiJhZG1pbiIsICJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo5MDk1L2FwaWtleSIsICJpYXQiOjE1ODAxMDUzOTAsICJqdGkiOiI3OTFiNzAyMC1kN2U2LTRmYmEtYmMyMy1lMzk5YTVlNmYzYjciLCAiYXVkIjoiaHR0cDovL29yZy53c28yLmFwaW1ndC9nYXRld2F5IiwgImtleXR5cGUiOiJQUk9EVUNUSU9OIiwgImFsbG93ZWRBUElzIjpbXX0=.f-86LfD7lLq-0oM1V1u1dLW7fWcydH4MElWVxUfRTGGRiXHhh8VrS5q18LdCtH1E1jav5pPZpdDQgQUvhVYNXVqiipydfJFOMbDysA0Jdakmh_TVmeZRHhIYgzcVHQNnXMcYXg7Ns4QPBvJVONfbmDluuiU_uFnOPBiXj2N4HL2OTLgVXkEoVTEpL0mmaO2Ab4ZHqKW5xj32aeK8sEAtU5Nd3rQOGvfEwL7xvx4JAmza8ka0eYt7c4QCPVcDSVOkdas9njlsvEdtka5GRL9PAx3xg370phSD1cji6WSRlZhEGzuq6hjLbCqsf17KvZgK1zbrEbSypjgegEe-any3EQ=="
      ```

      ``` bash tab="Response"
      {"id":1,"category":{"id":0},"name":"teste","photoUrls":[],"tags":[],"status":"tested"}
      ```

## Additional Information

### API key restriction for IP address and HTTP referrer

Choreo Connect API Key Authentication supports API key restriction for IP address and HTTP referrer. 

{!includes/design/additional-api-key.md!}

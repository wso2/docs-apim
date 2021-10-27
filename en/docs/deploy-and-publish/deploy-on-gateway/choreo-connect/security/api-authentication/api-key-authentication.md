# API Key Authentication

API Key authentication in Choreo Connect is a simple authentication scheme that accepts a valid self-contained JWT token issued for accessing APIs. Since self-contained tokens can have all authorization information, token processing time is fast and more efficient. Common practice is to have a short expiration time for self-contained access tokens.

Following section explains how to use API key authentication with WSO2 Choreo Connect.

### Step 1 - Define API Key authentication for the API

Choreo Connect API key authentication can enable considering one of below two methods.

#### Method 1 - Enable API key Authentication using Open API definition security schemes

Security schemes must be defined on the Open API definition under securitySchemes. One or more API key security schemes can be used (as in logical OR) at the same time. A unique name for "name", query or header for "in"  and apiKey as "type" needs to be given for the defined API Key security scheme. This name will be used to refer to the scheme on API level or resource level.

The below example defines an API Key security scheme named apiKeyAuth which sends X-API-Key as a request header. Here, apiKeyAuth is a name provided for the security scheme and X-API-Key is the name for the header.

!!! note
    The following example shows how to define API Key security schemes in [OAS3](https://swagger.io/docs/specification/authentication/api-keys/) . If you are using an OAS2 API definition, please refer to [this](https://swagger.io/docs/specification/2-0/authentication/api-keys/) [swagger document](https://swagger.io/docs/specification/2-0/authentication/api-keys/) on defining API Key security in OAS2.

``` yml
# 1) Define the apikey security scheme
components:
  securitySchemes:
    ApiKeyAuth:        # arbitrary name for the security scheme
      type: apiKey
      in: header       # can be "header" or "query" 
      name: X-API-KEY  # name of the header or query parameter
    appId:             # you can define several apikey security schemas
      type: apiKey
      in: header
      name: X-APP-ID
```

##### Applying the API Key authentication security scheme

 A security scheme can be specified on a resource level or to the whole API by using the section **security** as applicable. Following is an example of how to apply a security scheme to a resource. A resource-level security scheme will override an API level security scheme.  The security scheme ApiKeyAuth defined has been referred to from the resource "/pet/{petId}: by using the security section. For more information see [swagger docs - API Keys](https://swagger.io/docs/specification/authentication/api-keys/) .

``` yml
# 1) Apply API Key as operation-specific security

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

# 2) Apply the API key globally to all operations
 security:
   - ApiKeyAuth: [] 
```

#### Method 2 - Enable API key Authentication in WSO2 API Manager

After adding API to the APIM publisher, follow third and fourth points in  step 1 described in [here]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys/#step-1-create-and-publish-an-api/).

!!! info
    When you enable API authentication in WSO2 API Manager, API key authentication defined in the Open API definition will override. 

### Step 2 - Generate API Key from APIM Dev Portal
Follow the steps 1 - 9 described in [here]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys/#step-2-generate-the-api-key)

### Step 3 - Invoke the API using the API Key
Depending on the method you used to define API key authentication in step 1 you can select one of below methods to invoke APIs using an API key.

#### Method 1 - Invoking APIs considering API key defined in the Open API definition security schemes

``` bash tab="Format"
curl -k -X GET "<API_URL>" -H  "accept: application/json" -H  "<Header name>: <API Key>"
```

``` bash tab="Example"
curl -k -X GET "https://localhost:9095/petstore/v1/pet/1" -H  "accept: application/json" -H  "X-API-KEY: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJqd3QiLCAia2lkIjoiYmFsbGVyaW5hIn0=.eyJzdWIiOiJhZG1pbiIsICJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo5MDk1L2FwaWtleSIsICJpYXQiOjE1ODAxMDUzOTAsICJqdGkiOiI3OTFiNzAyMC1kN2U2LTRmYmEtYmMyMy1lMzk5YTVlNmYzYjciLCAiYXVkIjoiaHR0cDovL29yZy53c28yLmFwaW1ndC9nYXRld2F5IiwgImtleXR5cGUiOiJQUk9EVUNUSU9OIiwgImFsbG93ZWRBUElzIjpbXX0=.f-86LfD7lLq-0oM1V1u1dLW7fWcydH4MElWVxUfRTGGRiXHhh8VrS5q18LdCtH1E1jav5pPZpdDQgQUvhVYNXVqiipydfJFOMbDysA0Jdakmh_TVmeZRHhIYgzcVHQNnXMcYXg7Ns4QPBvJVONfbmDluuiU_uFnOPBiXj2N4HL2OTLgVXkEoVTEpL0mmaO2Ab4ZHqKW5xj32aeK8sEAtU5Nd3rQOGvfEwL7xvx4JAmza8ka0eYt7c4QCPVcDSVOkdas9njlsvEdtka5GRL9PAx3xg370phSD1cji6WSRlZhEGzuq6hjLbCqsf17KvZgK1zbrEbSypjgegEe-any3EQ=="
```

``` bash tab="Response"
{"id":1,"category":{"id":0},"name":"teste","photoUrls":[],"tags":[],"status":"teste"}
```

#### Method 2 -  Invoking APIs considering API key authentication enabled in WSO2 API Manager

``` bash tab="Format"
curl -k -X GET "<API_URL>" -H  "accept: application/json" -H  "api_key: <API Key>"
```

``` bash tab="Example"
curl -k -X GET "https://localhost:9095/petstore/v1/pet/1" -H  "accept: application/json" -H  "api_key: eyJhbGciOiJSUzI1NiIsICJ0eXAiOiJqd3QiLCAia2lkIjoiYmFsbGVyaW5hIn0=.eyJzdWIiOiJhZG1pbiIsICJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo5MDk1L2FwaWtleSIsICJpYXQiOjE1ODAxMDUzOTAsICJqdGkiOiI3OTFiNzAyMC1kN2U2LTRmYmEtYmMyMy1lMzk5YTVlNmYzYjciLCAiYXVkIjoiaHR0cDovL29yZy53c28yLmFwaW1ndC9nYXRld2F5IiwgImtleXR5cGUiOiJQUk9EVUNUSU9OIiwgImFsbG93ZWRBUElzIjpbXX0=.f-86LfD7lLq-0oM1V1u1dLW7fWcydH4MElWVxUfRTGGRiXHhh8VrS5q18LdCtH1E1jav5pPZpdDQgQUvhVYNXVqiipydfJFOMbDysA0Jdakmh_TVmeZRHhIYgzcVHQNnXMcYXg7Ns4QPBvJVONfbmDluuiU_uFnOPBiXj2N4HL2OTLgVXkEoVTEpL0mmaO2Ab4ZHqKW5xj32aeK8sEAtU5Nd3rQOGvfEwL7xvx4JAmza8ka0eYt7c4QCPVcDSVOkdas9njlsvEdtka5GRL9PAx3xg370phSD1cji6WSRlZhEGzuq6hjLbCqsf17KvZgK1zbrEbSypjgegEe-any3EQ=="
```

``` bash tab="Response"
{"id":1,"category":{"id":0},"name":"teste","photoUrls":[],"tags":[],"status":"teste"}
```

### Additional Information

Choreo Connect API key authentication supports API key restriction for IP address and HTTP referrer. 

#### API key with IP address restriction

After issuing an API key for an application, if you want to allow API invocations only from authorized IP addresses you can generate API key with an IP restriction. To generate an API key with IP restriction, follow the steps described in [here]({{base_path}}/design/api-security/api-authentication/secure-apis-using-api-keys/#1-ip-address-restriction).

#### API key with HTTP referrer restriction

API key with referrer restriction allows only the specific HTTP referrers to use the token. This restriction allows to use an API through only specific web pages when API clients run on web browsers. To generate API key with referrer restriction, follow the steps described in [here]({{base_path}}/latest/design/api-security/api-authentication/secure-apis-using-api-keys/#2-http-referrer-restriction).
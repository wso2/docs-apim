# Vendor Specific Extensions
 
WSO2 API Manager utilizes the vendor extensions support in [Open API specification](#https://swagger.io/docs/specification/openapi-extensions/), to store operations such as throttling, against each API.
As per the current implementation, following extensions are supported by API Manager:

  - [x-auth-type](#x-auth-type)
  - [x-throttling-tier](#x-throttling-tier)
  - [x-wso2-auth-header](#x-wso2-auth-header)
  - [x-wso2-cors](#x-wso2-cors)
  - [x-wso2-production-endpoints](#x-wso2-production-endpoints)
  - [x-wso2-sandbox-endpoints](#x-wso2-sandbox-endpoints)
  - [x-wso2-endpoints](#x-wso2-endpoints)
  - [x-wso2-basePath](#x-wso2-basepath)
  - [x-wso2-transports](#x-wso2-transports)
  - [x-scopes-mappings](#x-scopes-mappings)
  - [x-scopes-bindings](#x-scopes-bindings)
  - [x-wso2-soap](#x-wso2-soap)
  - [x-wso2-mutual-ssl](#x-wso2-mutual-ssl)
  - [x-wso2-response-cache](#x-wso2-response-cache)
  - [x-wso2-pass-request-payload-to-enforcer](#x-wso2-pass-request-payload-to-enforcer)
 
## x-auth-type
 
**x-auth-type** specifies the authentication type of an API resource. It needs to be configured per each resource.
 
x-auth-type could be any of the following values:
 
| Authentication Type            | Description                                                               |
|--------------------------------|---------------------------------------------------------------------------|
| None                           | No token required to invoke the resource                                  |
| Application                    | Token generated specific to the application is required to invoke the API |
| Application User               | Token generated specific to the end-user is required to invoke the API    |
| Application & Application User | Both type of tokens can be used to invoke the API                         |
 
!!! danger "Deprecated feature"
    The Application and Application User separation used in API-M 2.x is deprecated from API-M 3.x and later. Security for the resources is `enabled` or `disabled`(Application and Application User in API definition is treated as security enabled).

    Therefore, it is recommended to use scopes to restrict the API resource invocation. For instructions on how to do this, see [Fine Grained Access Control with OAuth Scopes]({{base_path}}/learn/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#fine-grained-access-control-with-oauth-scopes)

The following example applies Application User authentication type to the given API resource:
       ```
        paths:
            /getOpeation:
                get:
                    responses:
                        200:
                            description: "OK"
                    security:
                        -
                            default: []
                    x-auth-type: "Application User"
       ```
  
## x-throttling-tier
 
**x-throttling tier** specifies the rate limiting policy associated with the API. It can be configured at either API level or Resource level. If rate limiting is at the API level, then x-throttling-tier should be provided at the API level. If rate limiting is per operation, then **x-throttling-tier** should be provided for each resource.
 
The following example applies rate limiting at the operation level:
       ```
        paths:
            /getOpeation:
                get:
                    responses:
                        200:
                            description: "OK"
                    security:
                        -
                            default: []
                    x-auth-type: "Application & Application User"
                    x-throttling-tier: "50KPerMin"
       ```
 
## x-wso2-auth-header
 
**x-wso2-auth-header** specifies the authorization header that should be provided when invoking the API. It applies at the root level API definition.
 
The following example sets the Authorization header as **“AuthHeader”**. The API invocation request should be sent with a header named as **“AuthHeader”** to the Gateway with the access token.
       ```
        paths:
            /sample:
                get:
                    parameters: []
                    responses:
                    200:
                        description: "ok"
                    security:
                    - default: []
                    x-auth-type: "None"
                    x-throttling-tier: "Unlimited"
            components:
            securitySchemes:
                default:
                    type: "oauth2"
                    flows:
                    implicit:
                        authorizationUrl: "https://test.com"
                        scopes: {}
        x-wso2-auth-header: "AuthHeader"
       ```
 
## x-wso2-cors
 
**x-wso2-cors** specifies the configurations related to CORS. It applied at the root level API definition.
 
The following table lists the properties that need to add to configure the CORS configurations:
 
| Properties                    | Type    | Description                                                              |
|-------------------------------|---------|--------------------------------------------------------------------------|
| corsConfigurationEnabled      | Boolean | Specifies whether CORS is enabled                                        |
| accessControlAllowOrigins     | String  | Specifies the allowed origins                                            |
| accessControlAllowCredentials | Boolean | Specifies whether the response to the request can be exposed to the page |
| accessControlAllowHeaders     | String  | Specifies the allowed headers.                                           |
| accessControlAllowMethods     | String  | Specifies the allowed HTTP methods.                                      |
 
The following example enables the CORS configuration of the API, by allowing all origins.
       ```
        x-wso2-cors:
            corsConfigurationEnabled: true
            accessControlAllowOrigins:
                - '*'
            accessControlAllowCredentials: false
            accessControlAllowHeaders:
                - AuthHeader
                - Access-Control-Allow-Origin
                - Content-Type
                - SOAPAction
            accessControlAllowMethods:
                - GET
                - PUT
                - POST
                - DELETE
       ```
 
## x-wso2-production-endpoints
 
**x-wso2-production-endpoints** specifies the production endpoint configuration and is applied at root level or resource 
level in API definitions.
 
The following table lists the attributes that can be configured under x-wso2-production-endpoints:
 
| Properties | Type   | Description                                                                           |
|------------|--------|---------------------------------------------------------------------------------------|
| urls       | String | Specifies the production endpoint URL                                                 |
| type       | String | Specifies the endpoint type (“http” for REST endpoints, “address” for SOAP endpoints) |
 
The following example illustrates how to define **x-wso2-production-endpoints** extension:
       ```
        x-wso2-production-endpoints:
            urls:
                - 'https://petstore.swagger.io/v2'
            type: http
       ```
 
## x-wso2-sandbox-endpoints
 
**x-wso2-sandbox-endpoints** specifies the sandbox endpoint configuration and is applied at root level or resource level 
in API definitions.
 
The following table lists the attributes that can be configured under x-wso2-sandbox-endpoints:
 
| Properties | Type   | Description                                                                           |
|------------|--------|---------------------------------------------------------------------------------------|
| urls       | String | Specifies the sandbox endpoint URL                                                    |
| type       | String | Specifies the endpoint type (“http” for REST endpoints, “address” for SOAP endpoints) |
 
The following example illustrates how to define **x-wso2-sandbox-endpoints** extension:
       ```
        x-wso2-sandbox-endpoints:
            urls:
                - 'https://petstore.swagger.io/v2'
            type: http
       ```

## x-wso2-endpoints

**x-wso2-endpoints** defines the endpoint configuration globally, which thereafter can be referred to using one of the
following extensions.

- **x-wso2-production-endpoints**
- **x-wso2-sandbox-endpoints**

When there are resource level endpoints, the same endpoint can be available in multiple resources - this causes data
duplication in the OpenAPI definition. In order to avoid that, endpoints can be provided under the reference model
(by referring to x-wso2-endpoints).

The following table lists the attributes that can be configured under x-wso2-endpoints:

| Properties    | Type   | Description                                                                           |
|---------------|--------|---------------------------------------------------------------------------------------|
| endpoint name | String | Specifies name for the endpoint                                                       |
| urls          | String | Specifies the endpoint URL                                                            |

The following example illustrates how to define **x-wso2-endpoints** extension:
        ```
        ...
        x-wso2-production-endpoints: "#/x-wso2-endpoints/myEndpoint1"
        ...
        x-wso2-endpoints:
          - myEndpoint1:
              urls:
              - https://localhost:2380/v1
          - myEndpoint2:
              urls:
              - https://localhost:2382/v2
        ...
        ```

## x-wso2-basePath
 
**x-wso2-basePath** specifies the base path of the API which will be prefixed with all API paths. This extension is derived from the context and version while generating the API. It applies to the root level API definition.
 
The basepath for an API can be specified as follows:
       ```
        x-wso2-basePath: "/swaggerPetStore/1.0.0"
       ```
 
## x-wso2-transports
 
**x-wso2-transports** specifies the in which the API will be exposed in the Gateway. It is a string property that applies at the API root level. Possible values for this extension are ***http***, ***https***.
 
As the example given below, the transport layers can be specified for an API:
       ```
        x-wso2-transports:
            - "http"
            - "https"
       ```
 
## x-scopes-mappings
 
**x-scopes-mappings** specifies the scopes associated with the API. It is a root API level extension and can be added in the following syntax:
       ```
        securitySchemes:
            default:
                type: "oauth2"
                flows:
                    implicit:
                        authorizationUrl: "https://test.com"
                        scopes:
                        ManageScope: "This scope is used to invoke Managed APIs"
                        x-scopes-mappings:
                        ManageScope:
                            display-name: "Manage Scope"
                        x-scopes-bindings: {}
       ```
It will result in an API that is associated with a scope named as ManageScope. The extension x-scopes-bindings can be used to associate roles to this scope.
 
## x-scopes-bindings
 
**x-scopes-bindings** specify the scope-role mapping when an API resource is protected with scope bindings. It is a root API level extension.
The following example associates the internal/subscriber role with the given scope.
       ```
        securitySchemes:
            default:
                type: "oauth2"
                flows:
                    implicit:
                        authorizationUrl: "https://test.com"
                        scopes:
                        ManageScope: "This scope is used to invoke Managed APIs"
                        x-scopes-mappings:
                        ManageScope:
                            display-name: "Manage Scope"
                        x-scopes-bindings:
                        ManageScope: "internal/subscriber"
       ```

## x-wso2-soap
 
**x-wso2-soap** is an optional extension that is generated at resource level API definition while generating REST APIs from WSDL.
The following example shows an example extension generated for a given WSDL.
       ```
            paths:
                /lists:
                post:
                    operationId: "listUsers"
                    parameters:
                        -
                            in: "body"
                            name: "Payload"
                            required: true
                            schema:
                            $ref: "#/definitions/listUsers"
                    responses:
                        default:
                                description: ""
                                schema:
                                    $ref: "#/definitions/listUsersOutput"
                        security:
                            -
                                default: []
                        x-wso2-soap:
                            soap-action: ""
                            soap-operation: "listUsers"
                            namespace: "http://com.innovation"
                            x-soap-version: "1.1"
                        x-auth-type: "Application & Application User"
                        x-throttling-tier: “Unlimited”
       ```
## x-wso2-mutual-ssl
 
**x-wso2-mutual-ssl** also used to define a transport-level security protocol as the **x-wso2-transports** extension. 
There are two keywords that bind with this extension. To make mutual-SSL optional user has to use the ***“optional”*** keyword and to make this mutual-SSL mandatory for an API the keyword is ***“mandatory”***.
 
As the example given below, the x-wso2-mutual-ssl extension can be specified for an API:
       ```
        x-wso2-transports:
            - "http"
            - "https"
        x-wso2-mutual-ssl: optional
       ```
 
## x-wso2-response-cache
 
**x-wso2-response-cache** used to enable response caching when creating a new API with cache timeout.
  
The response cache enabling and the timeout for an API can be specified as follows:
       ```
        x-wso2-response-cache:
            enabled: true
            cacheTimeoutInSeconds: 600
       ```

## x-wso2-pass-request-payload-to-enforcer

**x-wso2-pass-request-payload-to-enforcer** is an optional extension used to disable request payload passing from the Router to the Enforcer in Choreo Connect deployments. By default, request payload passing is in **disabled** mode. Without this extension, if request payload passing is enabled, all other APIs will pass the request payloads to the Enforcer. 

If you need to **disable request payload passing for a specific API**, you need to add this extension at the root level of the API definitions and assign the value as `false` as shown below:

```
x-wso2-pass-request-payload-to-enforcer: false
```

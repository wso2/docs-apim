# Choreo Connect as a Standalone Gateway

Choreo Connect can be used as a **standalone** Gateway without the API Manager as the Control Plane. Choreo Connect is considered to be in *standalone mode* when `control-plane` is disabled in the [config]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/control-plane-configurations/#instructions-for-use). In standalone mode, 

- APIs can be deployed via APICTL. 
- APICTL can be used to create API projects based on an open API definition. 
- These API projects can be directly pushed to the adapter, which will deploy the APIs in the enforcer and the router.

When Choreo Connect is used as a standalone Gateway, you can connect it to an external Secure Token Service (STS), which will provide signed JWTs, and Choreo Connect will validate those JWTs in the incoming requests.      

## Defining Gateway specific properties

Not all properties required for an API Gateway can be defined in the OpenAPI specification, since it is meant to be a descriptor of an REST endpoint such as a backend service or microservice. However, in Choreo Connect a developer should be able to define,

- Different types of endpoints

- Gateway security

- Rate limiting

- Retries and timeouts 

and many other Gateway specific features per API or per resource.

Since Choreo Connect is using the OpenAPI definition as the API descriptor, these additional properties should somehow go into OpenAPI definition maintained inside the API project. Choreo Connect utilizes OpenAPI Specification's vendor extensions for this purpose.

So to define the above mentioned additional API/Resource specific Gateway attributes, Choreo Connect introduces a set of open API vendor extensions for developers.

The list of available extensions are documented [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/#openapi-extensions). 

### How to work with standard open API definition

In Choreo Connect, version 3.0.x series of the open API definition requires two mandatory WSO2 specific extensions at least. Those are,

1. `x-wso2-basePath`
2. `x-wso2-production-endpoints`

`x-wso2-basePath` is used to group all HTTP resources of the OpenAPI under a single context. Therefore, it will be exposed as a sub resource of a single API using Choreo Connect. This is how Choreo Connect logically separates one API from the other. The `x-wso2-production-endpoints` refers to the actual backend service implementation of the API. Therefore, the latter mentioned details are mandatory to expose an API using Choreo Connect.

!!! tip
    Also, you can define endpoint configurations globally using the `x-wso2-endpoints` extension as explained [here]({{base_path}}/reference/vendor-extensions-catalog/#x-wso2-endpoints). Then, endpoints available under the `x-wso2-endpoints` can be used with `x-wso2-production-endpoints`. For a detailed example, see the [detailed sample for endpoint definitions.](https://github.com/wso2/product-microgateway/blob/main/samples/openAPI-definitions/endpoint_by_reference_sample.yaml).

Choreo Connect resolves base path and backend URL as follows:

- **For Swagger 2.0**
    The Swagger 2.0 specification defines a way of providing the [base path and the host](https://swagger.io/docs/specification/2-0/api-host-and-base-path/) of the service. If Swagger specifies the combination of **schemes, basePath and host** attributes, Choreo Connect will drive the backend service URL using host and schemes, and derive the base path using the base path attribute.

- **For OpenAPI 3.0**
    The OpenAPI 3.0 specification defines a way of providing the [server](https://swagger.io/docs/specification/api-host-and-base-path/) URL of the API defined by the OpenAPI definition. Choreo Connect derives the base path and the backend service URL using the **servers** object defined in the OpenAPI definition.
    For example, if the server URL is defined as `http://test.com/v2`, Choreo Connect will resolve the backend service URL as the given URL and it will also expose the API using the base path (context) /v2.

### Updating the API

!!! tip
    APIs can be updated as long as Choreo Connect is not meant to be run as an Immutable Gateway. To learn more about running Choreo Connect as an Immutable Gateway, click [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-apis-as-immutable-gateway/).
        

An API can be updated by editing the open API definition and the api.yaml file inside the existing API project, and redeploying the project. The API can be overridden using the `apictl mg deploy` command with the override flag.

Following properties of the open API is not recommended to be edited, as it will behave as a new API if those were edited.

- Title
- Version
- [servers](https://swagger.io/docs/specification/api-host-and-base-path/) objects basePath section if `x-wso2-basePath` is not present in the open API (this is explained in the above section **How to work with standard open API definition** ).

!!! important
    For an example, server's URL can be defined as below.

    **Open API servers object**

    ``` yml
    servers:
    - url: https://api.example.com/v1 
    ```

    Then, Choreo Connect will expose the API using the base path (or context) /v1 if the `x-wso2-basePath` extension is not present. Then editing the last part of the servers URL(/v1) will expose API as a different context.

    If editing the servers URL is a must due to the changes in the actual back end service, then we can use the x-wso2-basePath extension as a fixed context and edit the servers URL. So API will be exposed with the same base bath as it was before.

## OpenAPI extensions
  
Choreo Connect supports the following OpenAPI Extensions. You can use these extensions to override information with regard to API specifications.
  
   | Extension                         | Description                                                                                                            | Required/ Optional                          |
   |-----------------------------------|------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|
   | `x-wso2-basePath`                 | Base path that the Gateway uses to expose the API.                                                                     | Optional → API level only                   |
   | `x-wso2-production-endpoints`     | Specifies the actual backend of the service.                                                                           | Optional → API/Resource level               |
   | `x-wso2-sandbox-endpoints`        | Specifies the sandbox endpoint of the service if available.                                                            | Optional → API/Resource level               |
   | `x-wso2-throttling-tier`          | Specifies the rate limiting for the API or resource.                                                                   | Optional → API/Resource level               |-->
   | `x-wso2-cors`                     | Specifies the Cross-Origin Resource Sharing (CORS) configuration for the API.                                          | Optional → API level only                   |
   | `x-wso2-disable-security`         | Enables the resource to be invoked without authentication.                                                             | Optional → API/Resource/Operation level  |
   | `x-wso2-auth-header`              | Specify the authorization header for the API to which either bearer or basic token is sent                             | Optional → API level only                |

!!! note
    -  Choreo Connect supports  the `"x-auth-type": "None"` option to disable the security. Therefore, the following concepts of the auth types in WSO2 API Manager will not work with the Choreo Connect.
        -   Application & Application User
        -   Application
        -   Application User
    -   However, if you want to expose API/ resource without security, you can also use the `x-wso2-disable-security` extension. Find more information about this extension from [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/disabling-security/#disabling-security).

   You can find an example on how these OpenAPI extensions are used in the [Open API definition](https://github.com/wso2/product-microgateway/blob/main/samples/openAPI-definitions/petstore_basic.yaml).

## Subscription validation for self-contained JWTs

To authorize an API request with the self-contained JWT token under an issuer with subscription validation, the API name and version should be listed under `subscribedAPIs` claim of the JWT token.

## See Also

- [Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/subscription-validation/)
- [Token Caching]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configure-caching/)


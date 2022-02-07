# Choreo Connect as a Standalone Gateway

Choreo Connect can be used as a **standalone** Gateway without the API Manager as the Control Plane. Choreo Connect is considered to be in *standalone mode* when `control-plane` is disabled in the [config]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/control-plane-configurations/#instructions-for-use). In standalone mode, 

- APIs can be deployed via apictl (CLI Tool). 
- apictl can be used to create API projects based on an OpenAPI definition. 
- These API projects can be directly pushed to the adapter, which will deploy the APIs in the Enforcer and the Router.

When Choreo Connect is used as a standalone Gateway, you can connect it to an external Secure Token Service (STS), which will provide signed JWTs, and Choreo Connect will validate those JWTs in the incoming requests.      

## Defining an API with OpenAPI Specification
### Defining Gateway specific properties

Not all properties required for an API Gateway can be defined in the OpenAPI specification since it is meant to be a descriptor of an REST endpoint such as a backend service or microservice. However, in standalone mode, a developer can define the following:

- Different types of endpoints

- Gateway security

- Rate limiting

- Retries and timeouts 

and many other Gateway specific features per API or per resource right within the OpenAPI Specification. Choreo Connect utilizes OpenAPI Specification's vendor extensions for this purpose.

The list of vendor extensions Choreo Connect introduces can be found [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/#openapi-extensions). 

### Defining base path and backend URLs

In Choreo Connect, base path is used to group all HTTP resources (paths) of an API under a single context. This is how Choreo Connect logically separates one API from another. Choreo Connect resolves base path and the backend URLs (also known as Endpoints) from the OpenAPI definition as follows.

#### With Swagger 2.0

The Swagger 2.0 specification defines a way of providing the [base path and the host](https://swagger.io/docs/specification/2-0/api-host-and-base-path/) of the service. If your Swagger definition specifies the combination of **schemes, basePath and host** attributes, Choreo Connect drives the backend service URL from host and schemes, and derives the base path using the base path attribute.

#### With OpenAPI 3.0
    
The OpenAPI 3.0 specification defines a way of providing the [server](https://swagger.io/docs/specification/api-host-and-base-path/) URL of the API. Choreo Connect derives the base path and the backend service URL using this **servers** object. For example, when the last server URL is defined as `http://test.com/v2`, Choreo Connect will add this URL as one of the backend URLs and set `/v2` as the base path (context) `/v2`.

The above behavior exists since WSO2 supports creating an API project simply by pointing to an OpenAPI definition. To simplify defining these attributes a little more, WSO2 recommends using the following two WSO2 specific extensions in the OpenAPI definition.

1. `x-wso2-basePath`
2. `x-wso2-production-endpoints`

The value for `x-wso2-basePath` will be used as the base path there onwards. The extension `x-wso2-production-endpoints` can refer to the backend URLs (actual backend service implementation of the API). `x-wso2-production-endpoints` especially becomes mandatory when **Defining Gateway specific properties** as mentioned above.

!!! info
    When `x-wso2-basePath` is not present in the OpenAPI, the base path is derived from the **servers** object. For an example, when the server's URL is defined as below, Choreo Connect will expose the API with the base path (or context) `/v1`.

    **OpenAPI servers object**

    ``` yml
    servers:
    - url: https://api.example.com/v1 
    ```

    Therefore, editing the last part of the servers URL(`/v1`) will also change the base path. Yet, if you use the extension `x-wso2-basePath`, the base path will not change when you update the **servers**. 

!!! tip
    Also, you can define endpoint configurations globally using the `x-wso2-endpoints` extension as explained [here]({{base_path}}/reference/vendor-extensions-catalog/#x-wso2-endpoints). Then, endpoints available under the `x-wso2-endpoints` can be used with `x-wso2-production-endpoints`. For a detailed example, see the [detailed sample for endpoint definitions.](https://github.com/wso2/product-microgateway/blob/main/samples/openAPI-definitions/endpoint_by_reference_sample.yaml).



## Updating the API

!!! tip
    APIs can be updated as long as Choreo Connect is not meant to be run as an Immutable Gateway. To learn more about running Choreo Connect as an Immutable Gateway, click [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-apis-as-immutable-gateway/).
        
### Step 1 - Update the relevant definition file inside the existing API project

Update the file inside the `Definition` folder with any API related change. The following values can be updated by editing the `api.yaml` file.

- API name (Title)
- Version
- Lifecycle status (e.g., `CREATED`, `BLOCKED`)
- API type (e.g., `HTTP`, `WS`)
- Backend security

!!! important

    The following properties must not be edited once deployed:

    - API name (Title)
    - Version
    
    A combination of these properties represents the identity of the API when in standalone mode and editing these values will make the API behave as a new API, while continuing to keep the previous version of the same API.

### Step 2 -  Redeploy the project

Use apictl to override the API using the `apictl mg deploy` command with the override flag (`-o`).

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
    -   If you want to expose an API or a resource without security, you can use the `x-wso2-disable-security` extension. You can find more information about this extension from [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/disabling-security/#disabling-security).
    -  Choreo Connect also supports the `"x-auth-type": "None"` option to disable the security. This extension has a different functionality when run with WSO2 API Manager and can have the following values which are not supported in standalone mode.
        -   Application & Application User
        -   Application
        -   Application User
    

   See the [petstore_basic.yaml file](https://github.com/wso2/product-microgateway/blob/main/samples/openAPI-definitions/petstore_basic.yaml) to view an example on how these OpenAPI extensions are used in an OpenAPI definition.

## Subscription validation for self-contained JWTs

To authorize an API request with the self-contained JWT token under an issuer with subscription validation, the API name and version should be listed under `subscribedAPIs` claim of the JWT token.

## See Also

- [Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/subscription-validation/)
- [Token Caching]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configure-caching/)


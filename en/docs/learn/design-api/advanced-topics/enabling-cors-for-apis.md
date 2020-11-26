# Enabling CORS for APIs

Cross-Origin Resource Sharing (CORS) is a mechanism that allows accessing restricted resources (i.e., fonts, images, scripts, videos, and iframes) from domains outside the domain from which the requesting resource originated. Browsers define the origin as a combination of Scheme (`http://`, `https://`), Host, and Port. By default, web browsers apply the same-origin policy to avoid interactions between different origins. CORS defines a way in which a browser and a server can interact to determine whether or not it is safe to allow the cross-origin requests.

In API Manager, you can enable Cross-Origin Resource Sharing per API or as a global configuration that is applied across all APIs.

-   [Enabling CORS Globally](#EnablingCORSGlobally)
-   [Enabling CORS Per API](#EnablingCORSPerAPI)

<a name="EnablingCORSGlobally"></a>

## Enabling CORS Globally

You can enable CORS globally for API Manager by configuring the `deployment.toml` file, which is located in the `<API-M_HOME>/repository/conf/` directory.

Follow the instructions below to enable CORS response headers globally. Once this configuration is enabled, it will be applied across all the APIs that are served by the API Gateway.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file.
2.  Locate the following configuration and set the `enable` attribute to `true` with the required CORS headers in the response. 
     After this configuration is applied in the API Gateway, it will affect all the API calls served by the Gateway.

    ``` java
    [apim.cors]
    enable = true
    allow_origins = "*"
    allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
    allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction","apikey","testkey"]
    allow_credentials = false
    ```

!!! info
    CORS configuration is enabled by default. Access control can be done by changing the parameters mentioned above in the `deployment.toml` file.

<a name="EnablingCORSPerAPI"></a>

## Enabling CORS Per API

!!! note
    You need to enable CORS globally before you enable CORS Per API. Therefore, if you have not enabled CORS globally, follow the instructions in [Enabling CORS Globally]({{base_path}}/learn/design-api/advanced-topics/enabling-cors-for-apis/#enabling-cors-globally) before carrying out the following instructions.


1.  Sign in to API Publisher and [create a new API]({{base_path}}/learn/design-api/create-api/create-a-rest-api).

2. Click **Runtime Configurations**.

3.  Enable the switch under **CORS Configuration** to enable CORS for the API.

     [![{base_path}}/assets/img/learn/enable-cors.png]({{base_path}}/assets/img/learn/enable-cors.png)]({{base_path}}/assets/img/learn/enable-cors.png)

     After you enable CORS, you will be able to see the CORS response header configuration section. 

    !!! note
        When creating a new API by using a Swagger or Open API definition, response caching can be set up by defining an API-M supported Open API extension **“x-wso2-cors”**.

        !!! example
            ```yaml
            x-wso2-cors: 
                corsConfigurationEnabled: true
                accessControlAllowOrigins: 
                    - "*"
                accessControlAllowCredentials: false
                accessControlAllowHeaders: 
                    - "authorization"
                    - "Access-Control-Allow-Origin"
                    - "Content-Type"
                    - "SOAPAction"
                    - "apikey"
                accessControlAllowMethods: 
                    - "GET"
                    - "PUT"
                    - "POST"
                    - "DELETE"
                    - "PATCH"
                    - "OPTIONS"
            ```

4. Configure the CORS related configurations.
     
     Listed below are the CORS specific response headers supported by the API Gateway and how to configure them.

    | **Header**                           | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | **Sample** values                                                        |
    |----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
    | Access-Control-Allow-Origin      | Determines whether a resource can be shared with the resource of a given origin. The API Gateway validates the origin request header value against the list of origins defined under the Access Control Allow Origins configuration (this can be `All Allow Origins` or a specific value like `localhost`). If the host is in the allowed origin list, it will be set as the Access-Control-Allow-Origin response header in the response. | All Allow Origins(\*), localhost                                     |
    | Access-Control-Allow-Headers     | Determines, as part of the response to a preflight request (a request that checks to see if the CORS protocol is understood), which header field names can be used during the actual request. The Gateway will set the header values defined under Access Control Allow Headers configurations.                                                                                                                                                                                               | authorization, Access-Control-Allow-Origin, Content-type, SOAPAction, apikey, testkey |
    | Access-Control-Allow-Methods     | This header specifies the method(s) allowed when accessing the resource in response to a preflight request. Required methods can be defined under the Access Control Allow Method configuration.                                                                                                                                                                                                                                                                                                    | GET, PUT, POST, DELETE, PATCH, OPTIONS                               |
    | Access-Control-Allow-Credentials | Determines whether or not the response to the request can be exposed to the page. It can be exposed when the header value is true. The header value can be set to true/false by enabling/disabling the Access Control Allow Credentials configuration.                                                                                                                                                                                                                                              | true, false                                                          |

5.  Click **Save**.

     [![Configure CORS properties]({{base_path}}/assets/img/learn/configure-cors-properties.png)]({{base_path}}/assets/img/learn/configure-cors-properties.png)


You have successfully enabled CORS for a specific API.

## Enabling CORS for OAuth Token related APIs

Enabling CORS configuration via the `api-manager.xml` file is only valid for APIs created via the WSO2 API manager Publisher application. Therefore, you can enable CORS for OAuth token related APIs ( **/authorize, /revoke, /token, /userinfo** ) as follows.

Based on the API that you need to enable CORS, add the following handler configuration to the relevant API's Synapse file, which is in the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/api/` directory. Make sure to add the latter mentioned configuration within the `<handlers>` parent element.

``` java
<handler class="org.wso2.carbon.apimgt.gateway.handlers.security.CORSRequestHandler">
    <property name="apiImplementationType" value="ENDPOINT"/>
</handler>
```

The following are the mappings of the Synapse files corresponding to the OAuth token related APIs.

| **Endpoint**   | **Synapse configuration**                         |
|------------|-----------------------------------------------|
| /authorize | `_AuthorizeAPI_.xml` |
| /revoke    | `_RevokeAPI_.xml`|
| /token     | `_TokenAPI_.xml`|
| /userinfo  | `_UserInfoAPI_.xml`|

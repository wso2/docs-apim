# Enabling CORS for APIs

Cross-Origin Resource Sharing (CORS) is a mechanism that allows accessing restricted resources (i.e., fonts, images, scripts, videos and iframes) from domains outside the domain from which the requesting resource originated. By default, web browsers apply the same-origin policy to avoid interactions between different origins. CORS defines a way in which a browser and a server can interact to determine whether or not it is safe to allow the cross-origin requests.

In API Manager, you can enable Cross-Origin Resource Sharing per API or as a global configuration that is applied across all APIs.

-   [Enabling CORS Globally](#EnablingCORSforAPIs-EnablingCORSGlobally)
-   [Enabling CORS Per API](#EnablingCORSforAPIs-EnablingCORSPerAPI)

### Enabling CORS Globally

You can enable CORS globally for API Manager by configuring deployment.toml located in `<API-M_HOME>` / `repository/conf/` directory.

Follow the steps below to enable CORS response headers globally. Once this configuration is enabled, it will be applied across all the APIs served by the API Gateway.

1.  Open the `<API-M_HOME>/repository/conf/deployment.toml` file.
2.  Locate the following configuration and set the `enable` attribute to `true` with the required CORS headers in the response. Once this configuration is applied in the API Gateway, it will affect all the API calls served by the Gateway.

    ``` java
        [apim.cors]
        enable = true
        allow_origins = "*"
        allow_methods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
        allow_headers = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction"]
        allow_credentials = false
    ```

!!! info
    CORS configuration is enabled by default. Access control can be done by changing the parameters mentioned above in the `deployment.toml` file.


### Enabling CORS Per API

!!! note
    It is required to enable CORS globally before you enable CORS Per API. Therefore if you haven't done it yet, follow the steps in [Enabling CORS Globally](#EnablingCORSforAPIs-EnablingCORSGlobally) before starting the below steps.


1.  Sign in to API Publisher and [create a new API](../../../DesignAPI/CreateAPI/create-a-rest-api/). Go to the **Runtime Configurations** tab.

2.  Enable the switch under **CORS Configuration** to enable CORS for the API.
    <html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/enable-cors.png" alt="Enable CORS for APIs" title="Enable CORS for APIs"/>
     </body>
     </html>

3.  Once you enable CORS, you will be able to see the CORS response header configuration section. Listed below are the CORS specific response headers supported by the API Gateway and how to configure them.

    | Header                           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Sample values                                                        |
    |----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
    | Access-Control-Allow-Origin      | Determines whether a resource can be shared with the resource of a given origin. The API Gateway validates the origin request header value against the list of origins defined under the Access Control Allow Origins configuration(this can be `All Allow Origins` or a specific value like `localhost` ). If the host is in the allowed origin list, it will be set as the Access-Control-Allow-Origin response header in the response. | All Allow Origins(\*), localhost                                     |
    | Access-Control-Allow-Headers     | Determines, as part of the response to a preflight request (a request that checks to see if the CORS protocol is understood), which header field names can be used during the actual request. The gateway will set the header values defined under Access Control Allow Headers configurations.                                                                                                                                                                                                     | authorization, Access-Control-Allow-Origin, Content-type, SOAPAction |
    | Access-Control-Allow-Methods     | This header specifies the method(s) allowed when accessing the resource in response to a preflight request. Required methods can be defined under the Access Control Allow Method configuration.                                                                                                                                                                                                                                                                                                    | GET, PUT, POST, DELETE, PATCH, OPTIONS                               |
    | Access-Control-Allow-Credentials | Determines whether or not the response to the request can be exposed to the page. It can be exposed when the header value is true. The header value can be set to true/false by enabling/disabling the Access Control Allow Credentials configuration.                                                                                                                                                                                                                                              | true, false                                                          |

8.  Once the CORS configurations are done, click **Save**.
    <html>
     <head>
     </head>
     <body>
     <img src="../../../../assets/img/Learn/configure-cors-properties.png" alt="Configure CORS properties" title="Configure CORS properties"/>
     </body>
     </html>

You have successfully enabled CORS for a specific API.



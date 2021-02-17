# Enabling CORS

#### Enable CORS configuration for API resources

You can add CrossOrigin Resource Sharing ( **CORS** ) configurations for each API (at API level) using the OpenAPI extension **x-wso2-cors.** The following code snippet depicts the usage of the `         x-wso2-cors        ` extension. For more information, see the [detailed sample OpenAPI definition with CORS level configuration](https://github.com/wso2/product-microgateway/blob/master/samples/cors_sample.yaml) .

``` java
x-wso2-basePath: /petstore/v1
x-wso2-production-endpoints:
  urls:
  - https://petstore.swagger.io/v2
x-wso2-cors:
  accessControlAllowOrigins:
    - test.com
    - example.com
  accessControlAllowHeaders:
    - Authorization
    - Content-Type
  accessControlAllowMethods:
    - GET
    - PUT
    - POST
  accessControlAllowCredentials: true
```

### Enable CORS configuration for endpoints

You can enable CORs for /authorize, /revoke, /token, /apikey, /userinfo and /health endpoints by enabling the following configuration in `toolkit-config.toml` located in `<MICRO-GW_TOOLKIT_HOME>/conf/.`

``` yml
[corsConfiguration]
    corsConfigurationEnabled = true
    accessControlAllowCredentials = false
    accessControlAllowOrigins = ["*"]
    accessControlAllowHeaders = ["authorization", "Access-Control-Allow-Origin", "Content-Type", "SOAPAction"]
    accessControlAllowMethods = ["GET", "PUT", "POST", "DELETE", "PATCH", "OPTIONS"]
```

# Enabling CORS

### Enable CORS configuration for API resources (API level)

If you are following the dev-first approach ([Deploy API via CLI tool]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/#via-the-cli-tool-apictl))You can add CrossOrigin Resource Sharing ( **CORS** ) configurations for each API (at API level) using the OpenAPI vendor extension **x-wso2-cors** in the API definition. The following code snippet depicts the usage of the `x-wso2-cors` extension. For more information, see the [detailed sample OpenAPI definition with CORS level configuration](https://github.com/wso2/product-microgateway/blob/master/samples/cors_sample.yaml) .

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

If you are following the [Deploy API via API-M]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-api-to-choreo-connect/#via-api-manager) approach, you can add **CORS** configurations for each API using the [API-M]({{base_path}}/design/advanced-topics/enabling-cors-for-apis/#EnablingCORSPerAPI).

### Enable CORS configurations globally

You can enable CORS for Choreo Connect by configuring in the `config.toml` file, which is located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf/` directory.

Follow the instructions below to enable CORS globally. Once this is enabled, it will apply this configurations through all endpoints and APIs deployed in Choreo Connect.

1. Open the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf/config.toml` file.
2. Locate the following configuration set and make the `enabled` attribute to `true` with the required CORS attributes there.

     ``` yml
     [router.cors]
         enabled = true
         allowOrigins = ["*"]
         allowMethods = ["GET","PUT","POST","DELETE","PATCH","OPTIONS"]
         allowHeaders = ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction","apikey", "testKey", "Internal-Key"]
         exposeHeaders = []
         allowCredentials = false
     ```

!!! info 
    Global CORS configuration is enabled by default. Access control can be done by changing the parameters mentioned above in the `config.toml` file.

!!! note 
    If CORS for a certain API is disabled from API Level Configurations, the default global Configurations will apply.

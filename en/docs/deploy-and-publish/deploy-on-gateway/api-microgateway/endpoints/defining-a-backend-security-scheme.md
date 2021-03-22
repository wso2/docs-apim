# Defining a Backend Security Scheme

### Defining a security scheme

The security scheme used for the API must be defined in the `securityConfig` section in the API definition. By default, WSO2 API Microgateway supports OAuth2. The following is an example of how you can define the security scheme as "basic". Multiple security schemes can be defined. For more information on security schemes see [Defining securitySchemes](https://swagger.io/docs/specification/authentication/) .

**Define security scheme**

``` yaml
securityConfig:
    type: basic
    username: kim
```

#### Specifying basic authentication for API / resource level backend endpoints

When an actual backend service of the API is protected using basic authentication, the basic authentication parameters (username and password) must be sent to the backend. Hence, you need to define the endpoint security parameter in the OpenAPI using extensions. After you have defined the endpoint(s) using the `x-wso2-endpoints` extension, an API level or resource level endpoint will be able to refer to the defined endpoint. You need to define a name for the extension when defining an endpoint using the `x-wso2-endpoints` extension. The extension name that you specify will be used to pass the password when running WSO2 API Microgateway. The following is a sample on how to define and use endpoints by reference.

**Define and refer endpoints**

``` yaml
x-wso2-basePath: /petstore/v1
x-wso2-production-endpoints: "#/x-wso2-endpoints/myEndpoint"

paths:
    "/pet/findByStatus":
       get:
       tags:
         - pet
       summary: Finds Pets by status
       description: Multiple status values can be provided with comma separated strings
       operationId: findPetsByStatus
       x-wso2-production-endpoints: "#/x-wso2-endpoints/myEndpoint3"
    
x-wso2-endpoints:
  - myEndpoint:
    urls:
    - https://petstore.swagger.io/v2
    - https://petstore.swagger.io/v5
  securityConfig:
    type: basic
    username: roshan
  - myEndpoint3:
    urls:
    - https://petstore.swagger.io/v3
    - https://petstore.swagger.io/v4
  securityConfig:
    type: basic
    username: kim
```

A complete sample can be found [here.](https://github.com/wso2/product-microgateway/blob/master/samples/endpoint_by_reference_sample.yaml)

##### Invoking an API using basic authentication

When running the micro gateway, you can provide the password as an environment variable.

``` text tab="Format"
bash gateway <path_to_the_jar_file> --<Endpoint Name>_<Endpoint Type>_basic_username=<username> --<Endpoint Name>_<Endpoint Type>_basic_password=<password> 

- Endpoint Name: Name specified in the open API definition under `x-wso2-endpoints`
- Endpoint Type: prod or sand.
```

``` text tab="Example - binary"
bash gateway petstore.jar --myEndpoint3_prod_basic_username=admin --myEndpoint3_prod_basic_password=123456
```
``` text tab="Example - docker"
docker run -d -p 9090:9090 -p 9095:9095 -e myEndpoint3_prod_basic_username=admin -e myEndpoint3_prod_basic_password=123456 docker.wso2.com/petstore:v1
```

!!! note 
    If a username is not specified, the username defined in the API Definition section while implementing the API, will be used.


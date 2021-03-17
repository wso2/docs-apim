# Defining Endpoints in an OpenAPI Definition

You can generate an API Microgateway for your OpenAPI definition, using WSO2 API Microgateway Toolkit. In the latter mentioned process, you need to provide the endpoints for the resources that you included in the OpenAPI definition, so that the inbound request of the Microgateway can be routed to the corresponding backend service. You, as a developer, can state the endpoint URLs for the whole API or a particular resource depending on the requirement. In addition, you can state the corresponding environment (i.e., production or sandbox) as well.

### API level endpoints

It is mandatory for you to define the API Level endpoint at the root level of your OpenAPI definition at the design time, because otherwise WSO2 Microgateway Toolkit shows an error. However, if you have defined endpoints for all the resources at design time, then you do not have to define an API Level endpoint as well. The inbound traffic for all the resources without any specific endpoint is automatically routed to the provided API Level endpoint.

``` yaml tab="Format"
openapi: 
servers:
info:
description: 
version: 
title: 
.
.  
tags: 
.
.
.
x-wso2-basePath: 
x-wso2-production-endpoints:
urls:
.
.
x-wso2-sandbox-endpoints:
urls:
.
.
```

``` yaml tab="Example"
x-wso2-basePath: 
x-wso2-production-endpoints:
urls: 
-  https://localhost:2380/v2
security:
- petstore_auth : []
x-wso2-sandbox-endpoints:
urls:
- https://localhost:2380/v2
```

### Resource level endpoints

In WSO2 API Microgateway, you can define different endpoint URLs for the different resources within the same OpenAPI definition. Therefore, in order to add resource level endpoints, you need to define the endpoint configuration under the respective resource in the OpenAPI definition. When the traffic comes in for a particular resource, it will be routed based on the endpoint configuration under the resource and not according to the API level endpoint configuration.

``` yaml tab="Format"
openapi: 3.0.0
servers:
.
.
info:
.
.
.
tags:
- name: 
description: 
externalDocs:
.
.
x-wso2-basePath: 
x-wso2-production-endpoints:
urls:
- 
paths:
"/pet/findByStatus":
get:
x-wso2-production-endpoints:
urls:
- 
x-wso2-sandbox-endpoints:
urls:
-
    "/pet/{petId}":
get:
.
.
. 
```

``` yaml tab="Example"
openapi: 3.0.0
servers:
.
.
info:
.
.
.
tags:
- name: 
description: 
externalDocs:
.
.
x-wso2-basePath: 
x-wso2-production-endpoints:
urls:
- 
paths:
"/pet/findByStatus":
get:
tags:
- pets
summary: Finds Pets by status
description: Multiple status values can be provided with comma separated strings
operationId: findPetsByStatus
x-wso2-production-endpoints:
urls:
-  https://localhost:2380/v1 
parameters:
- name: status
in: query
description: Status values that need to be considered for filter
.
.
.
"/pet/{petId}":
get:
.
.
. 
```

In the above example `/pet/findByStatus ` `- GET` resource has a separate endpoint configuration compared to the `/pet/{petId} - GET` resource. Therefore, the inbound traffic for the `/pet/findByStatus- GET` resource will be routed based on its specific endpoint object, whereas the requests coming to the `/pet/{petId} - GET` resource are routed to the API Level endpoint.

### Endpoint object

An endpoint can either belong to a production environment or sandbox environment. Therefore, an endpoint is listed under the extension ` x-wso2-production-endpoints` or `x-wso2-sandbox-endpoints` accordingly.

The following is the basic structure of an endpoint.

``` yaml
x-wso2-production-endpoints:
urls:
- <endpoint_URL>
type: #optional
```

 The purpose of URLs field is to include the backend service URLs. If multiple URLs are provided without assigning the type field, WSO2 API Microgateway will act as a load balancer. If multiple endpoints are provided and the type field is defined as `failover` , the endpoints are considered as failover endpoints. For more details, see [supported endpoint types]({{base_path}}/deploy/api-microgateway/endpoints/defining-a-backend-security-scheme/#supported-endpoint-types) .

 If you have added resource level endpoints and you have repeated the same endpoint in multiple resources, it will cause data duplication in the OpenAPI definition. Therefore, in order to avoid the latter mentioned error, you need to provide the endpoints under the reference model. In addition, if you need to override endpoints or use Basic Auth protected backend services, you need to define the endpoints in the following manner.

``` yaml tab="Format"
paths:
"/pet/findByStatus":
get:
tags:
- 
summary: 
description: 
operationId: 
x-wso2-production-endpoints: "#/x-wso2-endpoints/<endpoint-name>"
    ...

x-wso2-endpoints:
- myEndpoint:
urls:
- <endpoint-URL-1>
- <endpoint-URL-2>
type: #Optional
securityConfig: #Optional
type: basic
Username: <username>
```

``` yaml tab="Example"
paths:
"/pet/findByStatus":
get:
tags:
- pet
summary: Finds Pets by status
description: Multiple status values can be provided with comma separated strings
operationId: findPetsByStatus
x-wso2-production-endpoints: "#/x-wso2-endpoints/myEndpoint1"
    ...

x-wso2-endpoints:
- myEndpoint1:
urls:
- https://localhost:2380/v1
- myEndpoint2:
urls:
- https://localhost:2380/v2
- myEndpoint3:
urls:
- https://localhost:2380/v1
- https://localhost:2380/v2
- myEndpoint4:
urls:
- https://non.existant.host:2380/v1
- https://localhost:2380/v2
type: failover
```

 In the above code block you can see that there is an additional field named security object. This needs to be defined only if the backend service is protected via BasicAuth Authentication. For more information on using WSO2 API Microgateway with protected backend services, see [defining a backend security scheme]({{base_path}}/publish/endpoints/defining-endpoints-in-an-openapi-definition/) . The other fields such as `urls` and `type` behave in the same manner as mentioned above.
     
### Supported endpoint types

There are three types of endpoints supported in WSO2 API Microgateway.

   -   **`http`**
    In this case, there is only one backend service URL under the production or sandbox endpoint for the API or Resource.

       ``` yaml tab="Format"
        paths:
        "/pet/findByStatus":
        get:
        x-wso2-production-endpoints:
        urls:
        - <endpoint-URL>
       ```
    
       ``` yaml tab="Example"
        paths:
        "/pet/findByStatus":
        get:
        x-wso2-production-endpoints:
        urls:
        - https://localhost:2380/v2
       ```

   - **`LoadBalance`**
        The traffic that comes to the resource is routed to the mentioned endpoint addresses based on the round-robin algorithm. In this case you need to define more than one endpoint .

       ``` yaml
        x-wso2-basePath: <base-path>
        x-wso2-production-endpoints:
        urls:
        - <endpoint-URL-1>
        - <endpoint-URL-2>
       ```

       ``` yaml
        x-wso2-basePath: /petstore/v2
        x-wso2-production-endpoints:
        urls:
        - https://localhost:2380/v1
        - https://localhost:2380/v2
       ```

   -   **Failover**
        Similar to the load balance scenario, you need to define multiple endpoints to cater to a failover scenario. When failover is enabled, the traffic that comes to the relevant resource is always routed to the first endpoint. Thereafter, the traffic is routed to second endpoint only if the first endpoint is not available.
    
       ``` yaml
        x-wso2-basePath: /petstore/v3
        x-wso2-production-endpoints:
        urls:
        - https://non.existant.host:2380/v1
        - https://localhost:2380/v2
        type: failover
       ```

### Related Links

!!! info
        -   [Overriding Endpoint Information]({{base_path}}/deploy/api-microgateway/endpoints/overriding-endpoint-information/overriding-endpoints-for-developer-first-approach-apis/)
        The above section explains as to how you can add endpoints at design time. However, this link is useful when developers need to override the provided endpoint URL when starting WSO2 API Microgateway.
        -   [Defining a Backend Security Scheme]({{base_path}}/deploy/api-microgateway/endpoints/defining-a-backend-security-scheme/)
        You may have to protect your backend using BasicAuth Authentication. The above link provides information on how to generate a Microgateway that supports BasicAuth Authentication.
        -   [Service Discovery]({{base_path}}/deploy/api-microgateway/service-discovery/)
        The API developer can have endpoints that change dynamically over time. In such situations, you can use Service Discovery with etcd to make sure that the Microgateway is aware of the latest endpoint.


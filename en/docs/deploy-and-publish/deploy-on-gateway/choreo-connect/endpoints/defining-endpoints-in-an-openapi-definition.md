# Defining Endpoints in an OpenAPI Definition

You can use an existing OpenAPI definition to create an API project using APICTL, and deploy that project directly to Choreo Connect. When following this path, the endpoints must be included in the OpenAPI definition itself, so that the inbound request of Choreo Connect can be routed to the corresponding backend service. You, as a developer, can state the endpoint URLs for, 

- the whole API or 
- a particular resource 

depending on the requirement. In addition, you can state the corresponding environment (i.e., production or sandbox) as well.

### API Level Endpoints

It is mandatory for you to define the API Level endpoint at the root level of your OpenAPI definition at the design time. However, if you have defined resource level endpoints for all the resources, then defining an API Level endpoint is not necessary. For resources without a specific endpoint, the inbound traffic is automatically routed to the provided API level endpoint.

``` yaml tab="Format"
.
.
info:
.
.
x-wso2-basePath: <base_path>
x-wso2-production-endpoints:
    urls: 
    - <API_level_endpoint>
x-wso2-sandbox-endpoints:
    urls:
    - <API_level_endpoint>
security:
- petstore_auth : []
```

``` yaml tab="Example"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls: 
    - https://localhost:2380/v2
x-wso2-sandbox-endpoints:
    urls:
    - https://localhost:2380/v2
security:
- petstore_auth : []

```

### Resource Level Endpoints

In Choreo Connect, you can define different endpoint URLs for different resources within the same OpenAPI definition. Defining an endpoint under a resource in the OpenAPI definition, will make the endpoint a resource level endpoint. When the traffic comes in for a particular resource, it will be routed based on the endpoint configuration under the resource, and not according to the API level endpoint configuration.

``` yaml tab="Format"
.
.
info:
.
.
x-wso2-basePath: 
x-wso2-production-endpoints:
    urls:
    - 
paths:
    /pet/findByStatus:
        x-wso2-production-endpoints:
            urls:
            - 
        x-wso2-sandbox-endpoints:
            urls:
            -
        get:
    /pet/{petId}:
        get:
.
. 
```

``` yaml tab="Example"
.
.
info:
.
.
x-wso2-basePath: 
x-wso2-production-endpoints:
    urls:
    - 
paths:
    /pet/findByStatus:
        x-wso2-production-endpoints:
            urls:
            -  https://localhost:2380/v1 
        get:
            tags:
            - pets
            summary: Finds Pets by status
            description: Multiple status values can be provided with comma separated strings
            operationId: findPetsByStatus
            parameters:
            - name: status
              in: query
              description: Status values that need to be considered for filter
        .
        .
    /pet/{petId}:
        get:
.
.
```

In the above example `/pet/findByStatus` resource has a separate endpoint configuration compared to the `/pet/{petId}` resource. Therefore, the inbound traffic for the `/pet/findByStatus` resource are routed based on its specific endpoint object, whereas the requests coming to the `/pet/{petId}` resource are routed to the API Level endpoint.

### Production and Sandbox Endpoints

Choreo Connect supports Production and Sandbox endpoints at both the API level and resource level. You can define two completely different endpoints with different host addresses, ports, and basepaths as the production and sandbox endpoints for a particular API/resource.

``` yaml tab="Format"
.
.
info:
.
.
x-wso2-basePath: <base_path>
x-wso2-production-endpoints:
    urls: 
    - <API_level_endpoint>
x-wso2-sandbox-endpoints:
    urls:
    - <API_level_endpoint>
security:
- petstore_auth : []
```

``` yaml tab="Example"
.
.
info:
  version: 1.0.5
  title: PizzaShackAPI
x-wso2-basePath: /v2
x-wso2-production-endpoints:
    urls: 
    - https://localhost:2380/v2/prod
x-wso2-sandbox-endpoints:
    urls:
    - https://localhost:2381/v2/sand
security:
- petstore_auth : []

```

!!! info

        - If a resource level production endpoint is provided but no resource level sandbox endpoint is provided, Choreo Connect will use the API level sandbox endpoint as the resource level sandbox endpoint for that particular resource.

        In the following example, `https://localhost:2380/v1` will be used as the production level endpoint and `https://localhost:2381/v2/sand` will be used as the sandbox level endpoint for the resource `/pet/findByStatus`.

        ``` yaml tab="Example"
        .
        .
        info:
        .
        .
        x-wso2-basePath: 
        x-wso2-production-endpoints:
            urls: 
            - https://localhost:2380/v2/prod
        x-wso2-sandbox-endpoints:
            urls:
            - https://localhost:2381/v2/sand
        paths:
            /pet/findByStatus:
                x-wso2-production-endpoints:
                    urls:
                    -  https://localhost:2380/v1
                get:
                    tags:
                    - pets
                    summary: Finds Pets by status
                    description: Multiple status values can be provided with comma separated strings
                    operationId: findPetsByStatus
                    parameters:
                    - name: status
                    in: query
                    description: Status values that need to be considered for filter
                .
                .
        ```

        - If a resource level sandbox endpoint is provided but no resource level production endpoint is provided, Choreo Connect will use the API level production endpoint as the resource level production endpoint for that particular resource.

        In the following example, `https://localhost:2380/v1` will be used as the sandbox level endpoint and `https://localhost:2381/v2/prod` will be used as the production level endpoint for the resource `/pet/findByStatus`.

        ``` yaml tab="Example"
        .
        .
        info:
        .
        .
        x-wso2-basePath: 
        x-wso2-production-endpoints:
            urls: 
            - https://localhost:2380/v2/prod
        x-wso2-sandbox-endpoints:
            urls:
            - https://localhost:2381/v2/sand
        paths:
            /pet/findByStatus:
                x-wso2-sandbox-endpoints:
                    urls:
                    -  https://localhost:2380/v1
                get:
                    tags:
                    - pets
                    summary: Finds Pets by status
                    description: Multiple status values can be provided with comma separated strings
                    operationId: findPetsByStatus
                    parameters:
                    - name: status
                    in: query
                    description: Status values that need to be considered for filter
                .
                .
        ```


### Endpoint Objects

An endpoint can either belong to a production environment or sandbox environment. Therefore, an endpoint is listed under the extension ` x-wso2-production-endpoints` or `x-wso2-sandbox-endpoints` accordingly.

The following is the basic structure of an endpoint.

``` yaml
x-wso2-production-endpoints:
    urls:
    - <endpoint_URL>
```

The purpose of URLs field is to include the backend service URLs.

If you have added resource level endpoints and you have repeated the same endpoint in multiple resources, it will cause data duplication in the OpenAPI definition. In order to avoid repetition, the endpoints can be provided under a reference model as shown below. 

``` yaml tab="Format"
paths:
    /pet/findByStatus:
        x-wso2-production-endpoints: "#/x-wso2-endpoints/<endpoint-name>"
        get:
            tags:
            - 
            summary: 
            description: 
            operationId: 
.
.
x-wso2-endpoints:
- myEndpoint:
    urls:
    - <endpoint-URL-1>
    - <endpoint-URL-2>
```

``` yaml tab="Example"
paths:
    /pet/findByStatus:
        x-wso2-production-endpoints: "#/x-wso2-endpoints/myEndpoint1"
        get:
            tags:
            - pet
            summary: Finds Pets by status
            description: Multiple status values can be provided with comma separated strings
            operationId: findPetsByStatus
.
.
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
```     
### Related Links

Choreo Connect supports the following endpoint features.

- [Load Balanced Endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/load-balanced-endpoints/): Provides load balancing for the whole API or for a given resource.

- [Failover Endpoints]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/failover-endpoints/): Handles failover scenarios for the whole API or for a given resource.

!!! info
        -   [Overriding Endpoint Information]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/overriding-endpoints-for-imported-apis/)
        This link will be useful when you need to override the endpoint URL of an API just before starting Choreo Connect, since the original endpoint that was added while it was in a different environment does not suit the current environment.
        -   [Defining a Backend Security Scheme]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/defining-a-backend-security-scheme/)
        This link provides information on how to setup Choreo Connect to support BasicAuth Authentication.
        -   [Service Discovery]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/service-discovery/choreo-connect-and-service-discovery/)
        There can be endpoints that change dynamically over time. In such situations, you can use Service Discovery with Consul service registry to make sure that Choreo Connect is aware of the latest endpoint.

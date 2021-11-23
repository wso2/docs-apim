# Failover Endpoints

When you use Failover Endpoints, even though a failure may occur in a given API Endpoint it provides users with an uninterrupted API invocation experience. When failover is enabled, the traffic that comes to the relevant resource is always routed to the first endpoint. Thereafter, the traffic is routed to second endpoint only if the first endpoint is not available.

You can enable load balancing capabilities with Choreo Connect (CC) when working with the following two WSO2 products.

- [Failover Endpoints With API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/failover-endpoints/#failover-endpoints-with-apim). 
- [Failover Endpoints With APICTL]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/failover-endpoints/#failover-endpoints-with-apictl).

The following section explains how to configure failover endpoints considering the above products.

## Failover Endpoints With APIM

!!! Important
    Currently WSO2 API Manager allows you to add failover endpoints only to the API level.

### Step 1 - Define Failover Endpoints In Publisher

After creating an API in the API Publisher, select the API you want to provide the failover capability.

1.  Click **Develop -> API Configurations -> Endpoints**.

    1. 1. Under the **Load balance and Failover Configurations** and select the endpoint type as **Failover**.

    1. 2. Provide the service URLs that you want to use with failover scenarios.

    !!! info
        Click the + sign in the text box after adding each service URL to provide multiple service endpoints.

    [![Add load balance endpoints in APIM]({{base_path}}/assets/img/learn/load-balance-and-fail-over.png)](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/load-balance-and-fail-over.png)

    [![Add failover endpoints addition in APIM]({{base_path}}/assets/img/learn/failover-configured.png)](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/load-balanced-configurations.png)
    
2.  Click **Save & Deploy**.

### Step 2 - Invoke API Endpoint Via The Choreo Connect.

After obtaining a valid JWT token, you can invoke the API as described in [the Choreo Connect Quick Start Guide with Docker]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/#step-6-invoke-the-api-via-choreo-connect). 

An example is given below:

``` java
curl -k -X GET "https://localhost:9095/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer <COPIED_TOKEN>"
```

## Failover Endpoints With APICTL

In this approach you can define failover endpoints in API level as well as in resource level. The following section demonstrates how to add failover endpoints in those two levels.

### Step 1 - Define Failover Endpoints In The OpenAPI Definition file.

### Failover Endpoints In API Level

The following configuration demonstrates how to define failover endpoints for API level in an OpenAPI definition file.

``` yaml tab="Format"
openapi: <version>
...
x-wso2-production-endpoints:
  urls:
  -  <URL1>
  -  <URL2>
  type: failover
...
```

``` yaml tab="Example"
...
x-wso2-production-endpoints:
  urls:
    - http://localhost:2380/v2
    - http://localhost:2381/v2
  type: failover
...
```

### Failover Endpoints In Resource Level

The following configuration demonstrates how to define failover endpoints for resource level in an Open API definition file.

``` yaml tab="Format"
openapi: <version>
...
paths:
  "/<path>":
    <operation>:
  x-wso2-production-endpoints:
    urls:
    - <URL1>
    - <URL2>
  type: failover
```

``` yaml tab="Example"
paths:
  "/pet/findByStatus":
    get:
      responses:
        '200':
          description: OK
    ...
    x-wso2-production-endpoints:
      urls:
        - http://localhost:2380/v1
        - http://localhost:2380/v1
      type: failover
  "/pet/{petId}":
    get:
      responses:
        '200':
          description: OK
...
```

### Step 2 - Deploy the API Project And Invoke With failover Endpoints

After defining an API in the Open API definition file, deploy it in the Choreo Connect as described in [the Choreo Connect Quick Start Guide for Docker]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker/#step-1-download-and-setup-choreo-connect-distribution-zip-and-apictl-command-line-tool).

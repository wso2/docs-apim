# Failover Endpoints

When you use Failover Endpoints, even though a failure may occur in a given API Endpoint it provides users with an uninterrupted API invocation experience. When failover is enabled, the traffic that comes to the relevant resource is always routed to the first endpoint. Thereafter, the traffic is routed to second endpoint only if the first endpoint is not available.

You can enable failover endpoints when working with Choreo Connect in the following two modes.

- [Choreo Connect with WSO2 API Manager as a Control Plane](#choreo-connect-with-wso2-api-manager-as-a-control-plane)
- [Choreo Connect as a Standalone Gateway](#choreo-connect-as-a-standalone-gateway)

## Choreo Connect with WSO2 API Manager as a Control Plane

Follow the instructions below to enable Failover Endpoints when using Choreo Connect with WSO2 API Manager as the Control Plane:

!!! Important
    Currently WSO2 API Manager allows you to add failover endpoints only to the API level.

### Step 1 - Define Failover Endpoints in Publisher

After creating an API in the API Publisher, select the API you want to provide the failover capability.

1.  Click **Develop -> API Configurations -> Endpoints**.

    1. 1. Under the **Load balance and Failover Configurations** and select the endpoint type as **Failover**.

    1. 2. Provide the service URLs that you want to use with failover scenarios.

    !!! info
        Click the + sign in the text box after adding each service URL to provide multiple service endpoints.

    [![Add load balance endpoints in APIM]({{base_path}}/assets/img/learn/load-balance-and-fail-over.png)]({{base_path}}/assets/img/learn/load-balance-and-fail-over.png)

    [![Add failover endpoints addition in APIM]({{base_path}}/assets/img/learn/failover-configured.png)]({{base_path}}/assets/img/learn/load-balanced-configurations.png)
    
2.  Click **Save & Deploy**.

!!! warning
    The endpoint URLs that you provide as failover endpoints should have the same base path as in the `x-wso2-production-endpoints`.
    If you define some other base path, it will not result in the expected behaviour.

### Step 2 - Invoke API Endpoint Via The Choreo Connect

After obtaining a valid JWT token, you can invoke the API as described in [the Choreo Connect Quick Start Guide with Docker Compose]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/#step-6-invoke-the-api-via-choreo-connect). 

An example is given below:

``` java
curl -k -X GET "https://localhost:9095/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer <COPIED_TOKEN>"
```

## Choreo Connect as a Standalone Gateway

In this approach you can define failover endpoints in API level as well as in resource level. The following section demonstrates how to add failover endpoints in those two levels.

### Step 1 - Define Failover Endpoints in the OpenAPI definition file

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

### Failover Endpoints at Resource Level

The following configuration demonstrates how to define failover endpoints for resource level in an OpenAPI definition file.

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
!!! warning
    The endpoint URLs that you provide as failover endpoints should have the same base path as in the `x-wso2-production-endpoints`.
    If you define some other base path, it will not result in the expected behaviour.
    

### Step 2 - Deploy the API project and invoke the API with failover endpoints

After defining an API in the OpenAPI definition file, deploy it in Choreo Connect as described in the [Choreo Connect Deployed on Docker Compose with WSO2 API Controller Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-as-a-standalone-gateway-on-docker/#step-1-download-and-setup-choreo-connect-distribution-zip-and-apictl-command-line-tool).

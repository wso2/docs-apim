# Load Balanced Endpoints

When you use Load Balanced API Endpoints, the traffic that comes to the resource will route to the mentioned endpoint addresses based on the round-robin algorithm. You can enable load balancing capabilities with Choreo Connect (CC) when working with the following two WSO2 products.

- [Load Balanced Endpoints With WSO2 API Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/load-balanced-endpoints/#load-balanced-endpoints-with-apim)
- [Load Balanced Endpoints With APICTL (WSO2 API Controller)]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/load-balanced-endpoints/#load-balanced-endpoints-with-apictl)

## Load Balanced Endpoints with APIM

!!! Important
    Currently WSO2 API Manager allows to add load balanced endpoints only to the API level.

### Step 1 - Define the Load Balanced Endpoints in the Publisher

After creating an API in the APIM publisher, select the API you want to apply load balanced capability.
 
1.  Click **Develop -> API Configurations -> Endpoints**.

    1. Under the **Load balanced and Failover Configurations** and select the endpoint type as **Load Balanced**.

    2. Provide the service URLs that you want to handle load balancing.

    !!! info
        Click the + sign in the text box after adding each service URL to provide multiple service endpoints.

    [![Add load balanced endpoints in APIM]({{base_path}}/assets/img/learn/load-balance-and-fail-over.png)]({{base_path}}/assets/img/learn/load-balance-and-fail-over.png)

    [![Add load balanced endpoints addition in APIM]({{base_path}}/assets/img/learn/load-balanced-configurations.png)]({{base_path}}/assets/img/learn/load-balanced-configurations.png)
    
2.  Click **Save & Deploy**.

### Step 2 - Invoke API Endpoint Via The Choreo Connect.

After obtaining a valid JWT token, you can invoke APIs as described [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/#step-6-invoke-the-api-via-choreo-connect). 
When invoking the API, traffic will route to the load balanced endpoints you defined above.

Example is given below:

``` java
curl -k -X GET "https://localhost:9095/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer <COPIED_TOKEN>"
```

## Load Balanced Endpoints With APICTL

In this approach you can define load balanced endpoints in API level as well as in resource level. The below section demonstrates how load balanced endpoints can be defined in those two levels.

### Step 1 - Define Load Balanced Endpoints In The OpenAPI Definition file.

### Load Balanced Endpoints In API Level

Below section demonstrates how to define load balanced endpoints for API level in an OpenAPI definition file.

``` yaml tab="Format"
openapi: <version>
...
x-wso2-production-endpoints:
  urls:
    - <URL1>
    - <URL2>
  type: load_balance
...
```

``` yaml tab="Example"
...
x-wso2-production-endpoints:
  urls:
    - http://localhost:2380/v2
    - http://localhost:2381/v2
  type: load_balance
...
```

### Load Balanced Endpoints In Resource Level

Below section demonstrates how to define load balanced endpoints for resource level in an Open API definition file.

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
    type: load_balance
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
    type: load_balance
  "/pet/{petId}":
    get:
      responses:
        '200':
          description: OK
...
```

### Step 2 - Deploy the API Project And Invoke With Load Balanced Endpoints

After defining API in the OpenAPI definition file, you can deploy it and invoke as explained in [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/deploy/cc-on-docker-with-api-controller/#step-1-download-and-setup-choreo-connect-distribution-zip-and-apictl-command-line-tool).

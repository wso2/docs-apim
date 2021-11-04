# High Availability For Endpoints With Choreo Connect (Load Balance Endpoints With Choreo Connect).

In load balance enabled API endpoints, the traffic that comes to the resource is routed to the mentioned endpoint addresses based on the round-robin algorithm.
Choreo Connect (CC) provides load balancing capability with below two WSO2 product combinations.

- [Choreo Connect Load Balance Endpoints With APIM]({{base_path}}deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/high-availability-for-endpoints-with-choreo-connect/#step-1-define-load-balance-endpoints-in-publisher). 
- [Choreo Connect Load Balance Endpoints with APICTL]({{base_path}}deploy-and-publish/deploy-on-gateway/choreo-connect/endpoints/high-availability-for-endpoints-with-choreo-connect/#step-1-define-load-balance-endpoints-in-publisher).

Below section explains how to configure load balancing endpoints considering above products.

## Choreo Connect Load Balance Endpoints With APIM

!!! Important
    Currently WSO2 API Manager allows to add load balancing endpoints only to the API level.

### Step 1 - Define Load Balance Endpoints In Publisher

After creating an API in the APIM publisher, select the API you want to apply load balancing capability.

1.  Click **Develop -> API Configurations -> Endpoints**.

    1.1. Under the **Load balance and Failover Configurations** and select the endpoint type as **Load Balanced**.

    1.2. Provide the service URLs that you want to handle load balancing.

    !!! info
        Click the + sign in the text box after adding each service URL to provide multiple service endpoints.

    [![Add load balance endpoints in APIM](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/load-balance-and-fail-over.png)](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/load-balance-and-fail-over.png)

    [![Add load balance endpoints addition in APIM](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/load-balanced-configurations.png)](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/load-balanced-configurations.png)
    
2.  Click **Save & Deploy**.

### Step 2 - Invoke API Endpoint Via The Choreo Connect.

After obtaining a valid JWT token, you can invoke APIs as described in [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/#step-6-invoke-the-api-via-choreo-connect). 

Example is given below:

``` java
curl -k -X GET "https://localhost:9095/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer <COPIED_TOKEN>"
```

## Choreo Connect Load Balance Endpoints With APICTL

In this approach you can define load balance endpoints in API level as well as in resource level. Below section demonstrates how load balance endpoints in those two levels.

### Step 1 - Define Load Balance Endpoints In The OpenAPI Definition file.

### Choreo Connect Load Balance Endpoints In API Level

Below section demonstrates how to define load balance endpoints for API level in an OpenAPI definition file.

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

### Choreo Connect Load Balance Endpoints In Resource Level

Below section demonstrates how to define load balance endpoints for resource level in an Open API definition file.

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

### Step 2 - Deploy the API Project And Invoke the API With Load Balance Endpoints

After defining API in the Open API definition file deploy it in the Choreo Connect as described in [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker/#step-1-download-and-setup-choreo-connect-distribution-zip-and-apictl-command-line-tool).

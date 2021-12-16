# Defining a Backend Security Scheme

## Secure Endpoint with Basic Auth

When an actual backend service of the API is protected using basic authentication, the basic authentication parameters (username and password) must be sent to the backend. 
Hence, you need to define the endpoint security parameter in the OpenAPI using extensions.

The security scheme used for the API must be defined in the `securityConfig` under `x-wso2-production-endpoints` and `x-wso2-sandbox-endpoints` vendor extension in the API definition.
This is supported at the API level only. 
Security configs can be applied to production and sandbox endpoints separately. 
API level security configurations will be applied to all API level and resource level production and sandbox endpoints.

```yaml
x-wso2-basePath: /petstore/v1
x-wso2-production-endpoints: 
  urls:
    - https://petstore.swagger.io/v2
    - https://petstore.swagger.io/v5
  securityConfig:
    type: BASIC # mandatory
    username: admin #optional here, as you can provide credentials as environment variables
    password: admin #optional here, as you can provide credentials as environment variables
```

## Invoking an API using basic authentication

When running the Choreo Connect, you can provide the username, password as Adapter environment variables in the following configurations files based on the deployment that you are using.

| **Deployment** | **Configuration file** |
| Docker | `docker-composer.yaml` file. |
| Kubernetes | `adapter-deployment.yaml` file. |


!!! note 
    If a username/password is not specified as environment variables, the username, password defined in the API Definition section will be used while deploying the API to Choreo Connect.

```yaml tab="Format"
api_<API-ID>_<endpoint-type>_basic_username=<username>
api_<API-ID>_<endpoint-type>_basic_password=<password>
```

``` yaml tab="Docker Example"
  services:
      adapter:
          environment:
          - api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_username="admin"
          - api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_password="admin"
```

``` yaml tab="Kubernetes Example"

containers:
    - name: choreo-connect-adapter
      env:
        - name: api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_username
          value: "admin"
        - name: api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_password
          value: "admin"

```

- API-ID - `SHA1(<apiName>:<apiVersion>)`
- endpoint-type - `prod` or `sand`.
- username - Basic Auth username.
- password - Basic Auth username.

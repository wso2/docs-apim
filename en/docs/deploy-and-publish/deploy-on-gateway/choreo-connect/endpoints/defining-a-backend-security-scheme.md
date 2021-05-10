# Defining a Backend Security Scheme

### Defining a security scheme

The security scheme used for the API must be defined in the `securityConfig` section in the API definition. By default, Choreo Connect supports OAuth2.

#### Specifying basic authentication for backend endpoints

When an actual backend service of the API is protected using basic authentication, the basic authentication parameters (username and password) must be sent to the backend. Hence, you need to define the endpoint security parameter in the api.yaml as follows.

  ```
  endpointConfig:
    endpoint_security
      production:
        type: "BASIC"
        username: "admin"
        password: "admin"
      sandbox:
        type: "BASIC"
        username: "admin"
        password: "admin"
  ```
## Invoking an API using basic authentication

When running the Choreo Connect, you can provide the username, password as adapter environment variables at docker-composer.yaml file.

!!! note 
    If a username/password is not specified as environment variables, the username, password defined in the API Definition section will be used while deploying the 
    API to Choreo Connect.

```
<API-ID>_<endpoint-type>_basic_username=<username>
<API-ID>_<endpoint-type>_basic_password=<password>
```

- API-ID : `api_SHA1(<apiName>:<apiVersion>)`
- endpoint-type: prod or sand.
- username : basic auth username
- password : basic auth username

  ``` java tab="Example"
    services:
        adapter:
            environment:
            - api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_username="admin"
            - api_60f7111f-fdc5-4cc7-b497-1cea64c6a97f_prod_basic_password="admin"
  ```


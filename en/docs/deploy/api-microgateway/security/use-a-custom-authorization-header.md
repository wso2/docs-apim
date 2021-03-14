# Use a Custom Authorization Header

By default Microgateway uses **Authorization** header to receive the authorization token to secure the APIs. However there can be scenarios where this header needs to be reserved for some other purposes. For example if the backend endpoint of an API requires Authorization header to be present in the request to do perform its own authentication step. For scenarios like this you can configure microgateway to use a different header to recieve the authorization token.

## Per API Configuration

Below extension can be used to do above configuration per API. This extension is not supported in resource level.

``` java tab="Adding open API extension inside the definition"
x-wso2-auth-header: "XAuth"
```

## Global configuration

This configuration should be done in the micro-gw.conf file. Configuration is global for all API in a specific runtime.

``` java tab="Adding configuration"
[authConfig]
    authorizationHeader = "XAuth"
```

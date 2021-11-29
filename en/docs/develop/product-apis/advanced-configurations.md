# Advanced Configurations

The following sections explain the advanced configurations with regard to WSO2 API Manager REST APIs.

## Configuring Allowed Origins

The Cross Origin Resource Sharing (CORS) `allowedOrigins` property can be used to specify the origins which should be allowed access to the Publisher, Developer Portal and API Gateway REST APIs of WSO2 API Manager (WSO2 API-M). The `allowedOrigins` property reads values from the system parameters. The defined system parameters are as follows:

| **REST API** | **Parameter** |
|----------|-----------|
| Publisher | `rest.api.publisher.allowed.origins` |
| Developer Portal | `rest.api.devportal.allowed.origins` |
| API Gateway | `rest.api.gateway.allowed.origins` |

By default, each of the above Product REST APIs allows requests from all origins. However, if you need to only allow a specific set of origins to access a Product REST API, you need to configure the allowed origins as a system parameter for that particular REST API. You can use one of the following methods:

The origin will have the following syntax.

``` tab="Format"
<scheme>"://"<hostname>[ ":" <port> ]
```

``` tab="Example"
https://myorg1.publisher.example.com
```

### Method 1 - Defining the allowed origins before starting the server

1. Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.
2. Enter the following configuration under the `[system.parameter]` configurations.

     ``` tab="Format"
     [system.parameter]
     'rest.api.publisher.allowed.origins' = "<comma-separated-origins>"
     'rest.api.devportal.allowed.origins' = "<comma-separated-origins>"
     'rest.api.gateway.allowed.origins' = "<comma-separated-origins>"
     ```

     ``` tab="Example"
     [system.parameter]
     'rest.api.publisher.allowed.origins' = "https://myorg1.publisher.example.com"
     'rest.api.devportal.allowed.origins' = "https://myorg1.devportal.example.com,https://myorg2.devportal.example.com"
     'rest.api.gateway.allowed.origins' = "https://myorg1.gateway.example.com,https://myorg3.gateway.example.com"
     ```

### Method 2 - Defining the allowed origins when starting the server

You can start the WSO2 API Manager server as follows so that the allowed origins are defined at the point of starting the server.

``` tab="Format"
sh wso2server.sh -Drest.api.publisher.allowed.origins=<comma-separated-origins> -Drest.api.devportal.allowed.origins=<comma-separated-origins> -Drest.api.gateway.allowed.origins=<comma-separated-origins>
```

``` tab="Example"
sh wso2server.sh -Drest.api.publisher.allowed.origins=https://myorg1.publisher.example.com -Drest.api.devportal.allowed.origins=https://myorg1.devportal.example.com,https://myorg2.devportal.example.com -Drest.api.gateway.allowed.origins=https://myorg1.gateway.example.com,https://myorg3.gateway.example.com
```

# Migrate from Ballerina API Microgateway to Choreo Connect

Earlier versions of the Choreo Connect were named as WSO2 API Microgateway (Ballerina MGW). The final version of API Microgateway is 3.X.X and it is compatible with WSO2 API Manager 3.0 series only. With the release of WSO2 API Manager 4.0.0 Choreo Connect 1.0.0 released as the new version of API Microgateway. This document explains how you can migrate from API Microgateway to the Choreo Connect.

!!! note
    Choreo Connect 4.2.0 is only compatible with WSO2 API Manager 4.2.0.

## Feature Comparison (Ballerina MGW vs Choreo Connect)

| **Feature**          | **Ballerina MGW**                                   | **Choreo Connect**                                  |
|----------------------|:---------------------------------------------------:|:---------------------------------------------------:|
| SOAP  backends       | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| REST APIs            | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| gRPC APIs            | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(No)]({{base_path}}/assets/img/deploy/error.svg)  |
| Websocket APIs       | ![(No)]({{base_path}}/assets/img/deploy/error.svg)  | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| Custom mediation/transformation| ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)  |
| Advanced throttling (header, IP, query param, JWT claims)| ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)  |
| Schema validation    | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(No)]({{base_path}}/assets/img/deploy/error.svg)  |
| JWT revocation       | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| Per resource endpoints| ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg)|
| Custom filters       | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| OAuth2 self-contained tokens| ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| Mutual SSL           | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(No)]({{base_path}}/assets/img/deploy/error.svg)  |
| Basic Auth           | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(No)]({{base_path}}/assets/img/deploy/error.svg)  |
| API keys             | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) |
| OAuth2 opaque tokens (Introspect)| ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(No)]({{base_path}}/assets/img/deploy/error.svg)  |
| Local throttling (node level)| ![(Yes)]({{base_path}}/assets/img/deploy/check.svg) | ![(No)]({{base_path}}/assets/img/deploy/error.svg)  |

## Message Transformation (Request/Response interceptors)

### API Microgateway v3.x.x
Message transformation is possible with request/response interceptors in API Microgateway. Interceptors can be written in the Ballerina or Java programming languages. These interceptors are operative within the gateway. You can obtain more information from [here](https://mg.docs.wso2.com/en/latest/how-tos/message-transformation/message-transformation-overview/).

### Choreo Connect v1.2.0
Choreo Connect allows to do message transformation with request/response interceptors. In contrast to the API microgateway, users are required to maintain a separate interceptor microservice.  Choreo Connect provides an Open API specification to create a custom request/response interceptor microservice in any programming language. Sample implementations are available in Ballerina, Java, Golang, and Node js. You can obtain more information about Choreo Connect interceptors from [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/message-transformation-overview/).

## Custom filters

### API Microgateway v3.x.x
Filters are execution points in the request and response flow that intercept the request before it reaches the backend service and intercept the response before it reaches the client. Filters are applied to all APIs available via Microgateway. Default filters include authentication, rate limiting, analytics, and so forth. In addition to the default filters, users may create their own custom filters, which can be injected in whatever order they choose. The custom filter can be written in Ballerina language. More information about custom filters available in [here]( https://mg.docs.wso2.com/en/latest/how-tos/extensions/custom-filters/).

### Choreo Connect v1.2.0
The initial version of Choreo Connect only supports request flow that intercept the request before it reaches the backend service. Filters are applied to all APIs available via Choreo Connect. Default filters include authentication, rate limiting, analytics, and so forth. In addition to the default filters, users may create their own custom filters, which can be injected in whatever order they choose.  You can obtain more information about Choreo Connect filters from [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/extensions/custom-filters/#adding-a-custom-filter).


## Immutable API Gateway

### API Microgateway v3.x.x
The API Microgateway is intended to function as an immutable API gateway, where you must construct the API Microgateway to update existing deployed APIs. The API microgateway does not allow API hot updates. The custom filter can be written in Ballerina language. More information available in [here]( https://mg.docs.wso2.com/en/latest/faqs/#building-a-microgateway-project).

### Choreo Connect v1.2.0
Choreo Connect is designed to be a mutable API gateway that publishes API modifications in real time. If necessary, it additionally supports the Immutable API gateway, which loads the API projects only during Adapter startup if they are located in `/home/wso2/artifacts/apis`. The workflow can be created in the following manner.

1. Commit the API projects to the source version control (eg: Github)
2. This triggers the CI pipeline such as Jenkins.
3. It creates the Adapter Docker image placing the API projects in  `/home/wso2/artifacts/` apis location.
4. Once the Docker image creation is done, it rolls out the Adapter deployment.
5. When the new Adapter gets deployed, it deploys the new API or updated APIs in the
production environment.

## Endpoint Retry Configurations

### API Microgateway v3.x.x

The API microgateway accepts the following configurations for retry policy.

``` yaml
 x-wso2-production-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      retryConfig:
        count: 1
        intervalInMillis: 1000
        backOffFactor: 1.2
        statusCodes:
          - 504
```

You can obtain more information about retry and timeout configurations from [here](https://mg.docs.wso2.com/en/latest/how-tos/endpoints/resiliency/retry-and-timeout-configs/#retry-config).

### Choreo Connect v1.2.0

Choreo Connect accepts the following configurations for retry policy.

``` yaml
x-wso2-production-endpoints:
    urls:
      - https://localhost:2380/v3
    advanceEndpointConfig:
      retryConfig:
        count: 3
        statusCodes:
          - 504

```

- **`retryConfig`** given under prod or sandbox endpoint only has `count` and `statusCode`. 
- Envoy uses a fully jittered exponential back-off algorithm for retries. Therefore the interval between the retries is always a random number. More information available in [here](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#x-envoy-max-retries).
- A param called **`backOffFactor`** does not exist in the envoy’s retry interval equation, therefore is not expected in the config. 
- **`intervalInMillis`** can only be configured via envoy route configs (not configurable via header) which is common to both prod and sandbox. Thus, we have made **`intervalInMillis`** configurable via a parameter **`BaseIntervalInMillis`** in the `config.toml` which is the base interval for the Envoy's exponential retry back off algorithm.
- An upper bound can be set for the retry count taken from all API definitions. It can be set via **`MaxRetryCount`** set in `config.toml`. When the configured retry count in the API definition is larger than the `MaxRetryCount`, `MaxRetryCount` will be assigned as the count.
- Only a range of (401 - 598) status codes can be used to enable retry. If a status code out of this range is given in an API definition, that status code will get dropped when deploying the API. If this leads to an empty array of status codes, the default status codes configured in `config.toml` will be used. 

## Moving APIs from Ballerina MGW to Choreo Connect

### Standalone Gateway

There is no straightforward way to migrate APIs from Ballerina MGW to Choreo Connect. Users need to create the APIs from scratch using the OpenAPI/Swagger definitions.

Using the apictl command line tool, users can generate apictl projects as follows.

``` bash
apictl init project-1 --oas <Path_to_OpenAPI_File>
```

Step by step guide includes in [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/deploy-api/deploy-rest-api-in-choreo-connect/#choreo-connect-as-a-standalone-gateway).

### Choreo Connect with WSO2 API Manager 4.2.0

Choreo Connect v4.2.0 is only compatible with WSO2 API Manager 4.2.0. Hence you need to upgrade to 4.2.0.

1. Upgrade WSO2 API Manager version to 4.2.0. 

    A detailed explanation regarding the above includes in  [here]({{base_path}}/install-and-setup/upgrading-wso2-api-manager/320-to-410/upgrading-from-320-to-410/).

2. Connect Choreo Connect microgateway to API Manager 4.2.0 as a gateway.




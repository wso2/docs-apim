# Interceptor Context and Invocation Context

## Interceptor Context

Interceptor context is a string to string map that can be shared with request flow interceptor and response flow interceptor.
From the request interceptor, you can set it in the response body of the request interceptor, and Choreo Connect Router will add them
to the request it made to the response interceptor. Following is a sample interceptor context.

```json
{
  "interceptorContext": {
    "key1": "value1"
  }
}
```

## Invocation Context

Invocation context describes the request information. This is an optional object that you can request from
Choreo Connect Router to your interceptor service by referring it in the `includes` in Open API Definition.
Invocation context has the following information.

``` json tab="Format"
{
  "invocationContext": {
    "requestId": "<unitaque_id_for_request>",
    "protocol": "<HTTP_protocol>",
    "scheme": "<secheme_http_or_https>",
    "apiName": "<API_name>",
    "apiVersion": "<API_version>",
    "vhost": "<virtual_host>",
    "basePath": "/petstore",
    "supportedMethods": "<supported_HTTP_methods_for_the_resource>",
    "method": "<invoked_HTTP_method>",
    "path": "<invoked_resource_path>",
    "pathTemplate": "<invoked_resource_path_template>",
    "source": "<client_IP>",
    "prodClusterName": "<production_endpoint_cluster_name>",
    "sandClusterName": "<sandbox_endpoint_cluster_name",
    "authenticationContext": {
      "token": "<raw_auth_token>",
      "tokenType": "<one of [API Key|JWT|Internal Key]>",
      "keyType": <"one of [PRODUCTION|SANDBOX]">
    }
  }
}
```

``` json tab="Sample"
{
  "invocationContext": {
       "requestId": "75269e44-f797-4432-9906-cf39e68d6ab8",
       "protocol": "HTTP/1.1",
       "scheme": "https",
       "apiName": "PetStore",
       "apiVersion": "v1.0.0",
       "vhost": "localhost",
       "basePath": "/petstore",
       "supportedMethods": "GET POST",
       "method": "POST",
       "path": "/petstore/pet/1",
       "pathTemplate": "/pet/{petID}",
       "source": "192.168.8.332:8080",
       "prodClusterName": "carbon.super_clusterProd_localhost_Online-Storev1.0.0",
       "sandClusterName": "",
       "authenticationContext": {
           "token": "xxxxxxxxxxxxxxxx",
           "tokenType": "API Key|JWT Auth|Internal Key",
           "keyType": "PRODUCTION|SANDBOX",
       }
  }
}
```

| Field Name            | Description                                                                        |
|-----------------------|------------------------------------------------------------------------------------|
| requestId             | Unique Id for the request                                                          |
| protocol              | HTTP protocol of the request (eg: HTTP/1, HTTP/1.1, HTTP/2)                        |
| scheme                | http or https                                                                      |
| apiName               | Name of the API                                                                    |
| apiVersion            | Version of the API                                                                 |
| vhost                 | Virtual Host of the invoked API                                                    |
| basePath              | API base path                                                                      |
| supportedMethods      | HTTP methods supported by the invoked resource                                     |
| method                | Invoked HTTP method                                                                |
| path                  | Invoked resource path                                                              |
| pathTemplate          | Path template defined in the Open API Specification that the invoked resource path |
| source                | Client IP                                                                          |
| prodClusterName       | Name of the production endpoint cluster                                            |
| sandClusterName       | Name of the sandbox endpoint cluster                                               |
| authenticationContext | Authentication information of the request                                          |

# Interceptor Microservice

Interceptor microservice defines your logic of the transformation. You can update the payload body, headers and trailers
of the *request to/response from* the backend. You can also use interceptors to directly respond to the client without letting the request
reach the backend or even dynamically change the endpoint of the request.

Use the following Open API Definition to build your interceptor service with a programming language of your choice.

- [Interceptor Open API Definition](https://raw.githubusercontent.com/wso2/product-microgateway/main/resources/interceptor-service-open-api-v1.yaml)

Choreo Connect Router makes requests to your interceptor service in the following paths. You can define which handler
(request/response) should be get called, which information should be included in the request body of the interceptor
service when [Defining Interceptors in an OpenAPI Definition]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition/) 

1. [Request Flow Interceptor]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/request-flow-interceptor/)
2. [Response Flow Interceptor]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/response-flow-interceptor/)

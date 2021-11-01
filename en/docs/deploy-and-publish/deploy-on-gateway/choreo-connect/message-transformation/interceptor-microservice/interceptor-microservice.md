# Interceptor Microservice

Interceptor microservice defines your logic of the transformation. You can update payload body, headers and trailers
of the *request to/response from* the backend. In case if you want to direct respond to the client without the request
reach to the backend or change the endpoint dynamically that request should reach you can use interceptors.

Use the following Open API Definition to build your interceptor service with a programming language of your choice.

- [Interceptor Open API Definition]()

Choreo Connect Router makes requests to your interceptor service in following paths. You can define which flow should be called
which information should be included in the request body of interceptor service when
[Defining Interceptors in an OpenAPI Definition]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptora-in-an-open-api-definition/) 

1. [Request Flow Interceptor]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/request-flow-interceptor/)
2. [Response Flow Interceptor]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/request-flow-interceptor/)

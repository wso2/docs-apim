# Message Transformation

You can use interceptors in the Choreo Connect to carry out transformations and mediation on the requests and responses. 
Request interceptor get triggered before sending the request to the backend. The response interceptor get triggered before responding to the client.
Here interceptor is a separate microservice which handle the request, response or both request and response transformations.

If you are an API developer, you can write custom request/response interceptor microservice in any programming language of
your choice by following [the Interceptor Open API Definition](TODO: path the swagger).
Thereafter, in order for the interceptor to be engaged in Choreo Connect, define the corresponding interceptors using
the following OpenAPI extensions in the OpenAPI definition.

| Interceptor          | Corresponding OpenAPI Extension   |
|----------------------|-----------------------------------|
| Request interceptor  | **`x-wso2-request-interceptor`**  |
| Response interceptor | **`x-wso2-response-interceptor`** |

You can define interceptors on an API level (per API) and on a resource level (per resource).
If you define a request/response interceptor on an API level **and** a resource level, the API level interceptor will be
overridden by the resource level interceptor for that resource.

The flow of the request from client to backend through the request interceptor service and the response from backend to client through
the response interceptor service is shown in the following diagram.

<img src="{{base_path}}/assets/img/deploy/mgw/interceptors-overview.png" alt="Choreo Connect Interceptors request flow" width="650px"/>

| Numbers | Description                                                                                                                                    |
|---------|------------------------------------------------------------------------------------------------------------------------------------------------|
| 1        | Client request                                                                  |
| 2,3     | Request validation flow via the Enforcer                          |
| 4,5     | If the request is valid (i.e. authenticated, not rate-limited etc.) then the Router forwards the request to the Interceptor Service and allows the request to be transformed |
| 6,7     | Response from the backend                                                                                                                    |
| 8,9     | Response also goes through the Interceptor Service just like during the request flow                            |
| 10      | Response to the client                                                                                                                             |

Adding an interceptor requires following 2 steps. </br>

1. [Implement an interceptor microservice adhering to the Interceptor Open API Definition.]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/interceptor-microservice/interceptor-microservice-open-api-definition.md)
2. [Refer to the interceptor service from the client facing API definition to engage with it in the request/response flow.]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/message-transformation/defining-interceptors-in-an-open-api-definition.md)

!!! info
    Following are not supported during request/response body manipulation.

    - Large payload manipulation. Maximum supported payload size is 1MiB.
    - Content types (eg: `multipart/form-data`) with binary payloads.

    However you can use interceptors to modify headers, trailers with above mentioned scenarios.




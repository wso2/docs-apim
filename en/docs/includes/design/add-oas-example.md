    With OpenAPI 3.0 you can provide the expected payloads and headers in the following formats. 

    **Single Example for an Operation**

    ```yaml tab='Format'
    <resource path>:
      <operation>:
        responses:
          <response code>:
            description: <description>
            headers:
              <header>:
                example: <header example value>
            content:
              <media type>:
                example: <example>
    ```

    ```yaml tab='Example'
    /pet/findByStatus:
      get:
        responses:
          '200':
            description: OK
            headers:
              x-wso2-example:
                example: example header value
            content:
              application/json:
                example:
                  mock response: hello world
    ```

    **Multiple Examples for an Operation**

    ```yaml tab='Format'
    <resource path>:
      <operation>:
        responses:
          <response code>:
            description: <description>
            headers:
              <header>:
                example: <header example value>
            content:
              <media type>:
                examples: 
                  <example reference>
                    value: <example>
    ```

    ```yaml tab='Example'
    /pet/findByStatus:
      get:
        responses:
          50X:
            description: Service Unavailable
            headers:
              x-wso2-example:
                example: example header value
            content:
              application/json:
                examples:
                  ref1:
                    value:
                      mock response: hello world
                  ref2:
                    value:
                      mock response: Welcome
          default:
            description: default response
            headers:
              x-wso2-example:
                example: default header value
            content:
              application/json:
                examples:
                  ref1:
                    value:
                      mock response: default hello world
                  ref2:
                    value:
                      mock response: default Welcome
    ```

    | **Place Holder** | **Usage** |
    |-----------------|--------------------|
    | `response code` | Can be 3 digit status code or a wildcard format like 2XX. `default` can be also provided instead of a particular status code. |   
    | `header` | Header name. You can provide multiple headers similarly under `headers`. |   
    | `media type` | Mock response content type. Provide allowed content types for the resource. When accept header is presented in a request, Choreo Connect will return the content which suited to accepted media type among them. |   
    | `example` | Provide the content body as a simple string or as an object. If an object is given as the `example`, it will be parsed to JSON format. |   

    <!-- TODO(amali): add examples in swagger 2.0-->

    For more information on OpenAPI response body example specifications, visit [Request and Response Body Examples](https://swagger.io/docs/specification/adding-examples/).

    !!! example
        You can find a complete OpenAPI example for Mock Implementation here: [OpenAPI for Mock Implementation](https://github.com/wso2/product-microgateway/blob/main/samples/openAPI-definitions/mock-impl-sample.yaml)

        If you take the example in **Multiple Examples for an Operation** mentioned previously and update the OpenAPI definition with it, you can use `Prefer` header and `Accept` header to get different examples for same resource operation.
        Using `Prefer` header you can specify which `code` and/or `example` should be returned as the response.

        Invoking `GET` for `/pet/findByStatus` will return the default example as given below.

        ```bash tab='Request'
        curl -X GET https://localhost:9095/v3/1.0.6/pet/findByStatus
        ```

        ```bash tab='Response'
        < HTTP/1.1 200 OK
        < content-type: application/json
        < x-wso2-example: "default header value"
        < 
        {"mock response":"default hello world"}
        ```

        Invoking `GET` for `/pet/findByStatus` with the header `Prefer` will return the matched example for the particular code and the example reference.

        ```bash tab='Request'
        curl -H 'Prefer: code=503, example=ref2' -X GET https://localhost:9095/v3/1.0.6/pet/findByStatus
        ```

        ```bash tab='Response'
        < HTTP/1.1 503 Service Unavailable
        < content-type: application/json
        < x-wso2-example: "example header value"
        < 
        {"mock response":"Welcome"}
        ```

    <!-- TODO(amali): add more examples-->

    !!! tip "Behavioral Characteristics"

        The following are the behavioral characteristics of Mock Implementation with Choreo Connect.

        **Preferred Status Code in the Prefer Header**   

        - If the request has a valid integer value as the **code** preference, 
          Choreo Connect picks the most matched response example from the OpenAPI specification by checking the exact codes and
          wild cards matches. Status code of the response will be same as the code preference given in the request. 
          
        - If the request does not have a code preference,
          Choreo Connect will check for examples under `default` responses. If no default responses are defined, 
          then picks a one out of the response examples. 
          
        **Accept Type in the Accept Header** 
          
        - If the request has accept-types,
          Choreo connect will pick examples defined under a matching media type. 
          
        - If the request does not have accept-types, 
          Choreo connect will check for examples with 'application/json' as the media type. If there are no examples for 'application/json', then picks one out of available media-type examples.

        **Preference not found** or **Example not provided**
            
        - If the request has an example preference provided with the `Prefer` or `Accept` header, but does not match any of the cases above or has no matching examples, then `501, Not Implemented` status code would be returned with `900871` error code. The same error response will be returned if the invoked resource does not contain any mock response examples in the OpenAPI definition.


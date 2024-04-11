With OpenAPI 3.0 you can provide the expected payloads and headers in the following formats. 

  **Single Example for an Operation**

=== "Format"
    ```yaml
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

=== "Example"
    ```yaml
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

=== "Format"
    ```yaml
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

=== "Example"
    ```yaml
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
    | `media type` | Mock response content type. Provide allowed content types for the resource. |   
    | `example` | Provide the content body as a simple string or as an object. If an object is given as the `example`, it will be parsed to JSON format. |   

  <!-- TODO(amali): add examples in swagger 2.0-->

  For more information on OpenAPI response body example specifications, visit [Request and Response Body Examples](https://swagger.io/docs/specification/adding-examples/).

!!! example
        You can find a complete OpenAPI example for Mock Implementation here: [OpenAPI for Mock Implementation](https://github.com/wso2/product-microgateway/blob/main/samples/openAPI-definitions/mock-impl-sample.yaml)

        If you take the example in **Multiple Examples for an Operation** mentioned previously and update the OpenAPI definition with it, you can use `Prefer` header and `Accept` header to get different examples for same resource operation.
        Using `Prefer` header you can specify which `code` and/or `example` should be returned as the response.

        Invoking `GET` for `/pet/findByStatus` will return the default example as given below.

        === "Request"
            ```bash
            curl -X GET https://localhost:9095/v3/1.0.6/pet/findByStatus
            ```

        === "Response"
            ```bash
            < HTTP/1.1 200 OK
            < content-type: application/json
            < x-wso2-example: "default header value"
            < 
            {"mock response":"default hello world"}
            ```

        Invoking `GET` for `/pet/findByStatus` with the header `Prefer` will return the matched example for the particular code and the example reference.

        === "Request"
            ```bash
            curl -H 'Prefer: code=503, example=ref2' -X GET https://localhost:9095/v3/1.0.6/pet/findByStatus
            ```

        === "Response"
            ```bash
            < HTTP/1.1 503 Service Unavailable
            < content-type: application/json
            < x-wso2-example: "example header value"
            < 
            {"mock response":"Welcome"}
            ```

    <!-- TODO(amali): add more examples-->

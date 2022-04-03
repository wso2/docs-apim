    With OpenAPI 3.0 provide mock response body and headers following the below formats. 

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

    !!! note 
        For more information on defining response body examples in open API specification, follow [Request and Response Body Examples](https://swagger.io/docs/specification/adding-examples/).

    !!! example

        If you take **Example 2** and update the API definition with it.
        <!-- TODO(amali): paste ss of editor-->

        You can use `Prefer` header and `Accept` header to get different examples for a resource if multiple examples were defined for the resource.
        Using `Prefer` header you can specify which `code` and/or `example` should be returned as the response for the mock request.

        If you invoke `/pet/findByStatus` resource's `GET` operation. it will be responded with default example as below.

        ```bash tab='Request'
        curl -X GET https://localhost:9095/petstore/pet/findByStatus
        ```

        ```bash tab='Response'
        < HTTP/1.1 200 OK
        < content-type: application/json
        < x-wso2-example: "default header value"
        < 
        {"mock response":"default hello world"}
        ```

        If you invoke `/pet/findByStatus` resource's `GET` operation with `Prefer` header.
        It will select the matching example for the particular code and the example reference.

        ```bash tab='Request'
        curl -H 'Prefer: code=503, example=ref2' -X GET https://localhost:9095/petstore/pet/findByStatus
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

        The following are the behavioral characteristics of the Mock Implementation with Choreo Connect.

        **Example not provided**   
            
        - If the invoked resource does not contain mock response examples provided in the api definition, then a response with `501, Not Implemented` status code would be returned with `900871` error code.
          
        **Preferred Status Code in the Prefer Header**   

        - If the request has a valid integer value as the code preference, 
          Choreo connect picks the most matched response examples from the OpenAPI specification checking on the exact codes and
          wild cards matches. Status code of the response will be same as the code preference given in the request. 
          However, if there are no response examples matching the preferred status code, then `501, Not Implemented` status code 
          would be returned with `900871` error code.
          
        - If the request does not have a code preference,
          Choreo Connect will check for examples under `default` responses, if even no default responses are defined, 
          then picks a one out of the response examples. 
          
        **Accept Type in the Accept Header** 
          
        - If the request has accept-types,
          Choreo connect will pick examples defined under a matching media type. However, if there are no matches for accept 
          types in the examples, then `501, Not Implemented` status code would be returned with `900871` error code.
          
        - If the request does not have accept-types, 
          Choreo connect will check for examples with 'application/json' as the media type. If there are no examples for 'application/json', then picks one out of available media-type examples.

        **Preference not found**
            
        - If the request has an example preference,
          Choreo Connect will pick the example content with the matching example name from the example list we got after applying above steps. If there's no matching example found, then `501, Not Implemented` status code would be returned with `900871` error code.


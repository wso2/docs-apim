**Add response examples to OpenAPI Specification**

With OpenAPI 3.0 provide mock response body and headers following the below formats. 

```yaml tab='Format 1'
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

```yaml tab='Format 2'
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

```yaml tab='Example 1'
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

```yaml tab='Example 2'
/pet/findByStatus:
   get:
       responses:
           '50X': 
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
           'default': 
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

```
- response code - it can be 3 digit status code or a wildcard format like 2XX. `default` can be also provided instead of a particular status code.
- header - header name. You can provide multiple headers similarly under `headers`.
- media type - mock response content type. Provide allowed content types for the resource. When accept header is presented in a request, Choreo Connect will return the content which suited to accepted media type among them. 
- example - provide the content body as a simple string or as an object. If an object is given as the `example`, it will be parsed to JSON format.
```

<!-- TODO(amali): add examples in swagger 2.0-->

!!! note 
    For more information on defining response body examples in open API specification, follow [Request and Response Body Examples](https://swagger.io/docs/specification/adding-examples/).

**Additional Information**


For this tutorial, let's take **Example 2** and update the API definition with it.
<!-- TODO(amali): paste ss of editor-->

You can use `Prefer` header and `Accept` header to get different examples for a resource if multiple examples were defined for the resource.
Using `Prefer` header you can specify which `code` and/or `example` should be returned as the response for the mock request.

If you invoke `/pet/findByStatus` resource's `GET` operation. it will be responded with default example as below.
```bash tab='Example 1'
    curl -X GET https://localhost:9095/petstore/pet/findByStatus
```
```bash tab='Response - Example 1'
< HTTP/1.1 200 OK
< content-type: application/json
< x-wso2-example: "default header value"
< 
{"mock response":"default hello world"}
```

If you invoke `/pet/findByStatus` resource's `GET` operation with `Prefer` header.
It will select the matching example for the particular code and the example reference.
`-H 'Prefer: code=503, example=ref2'`

```bash tab='Example 2'
    curl -X GET https://localhost:9095/petstore/pet/findByStatus
```

```bash tab='Response - Example 2'
< HTTP/1.1 503 Service Unavailable
< content-type: application/json
< x-wso2-example: "example header value"
< 
{"mock response":"Welcome"}
```
<!-- TODO(amali): add more examples-->

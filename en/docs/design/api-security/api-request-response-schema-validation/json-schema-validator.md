# JSON Schema Validator

Attackers may try malicious payloads to break the API Gateway. Therefore, it is vital to have thorough client-side validation to validate all the requests and responses to reduce backend failures. 

The JSON Schema Validator in WSO2 API Manager evaluates the payload and checks whether it is compatible with the defined JSON schema, which is defined in the `swagger.json` file, by ensuring that the required properties and the additional constraints (e.g., a price never being less than one dollar) are present.

The JSON Schema Validator uses the `swaggerSchemavalidator` handler to validate the API schema. When the users enable schema validation either via the API Publisher Portal or via REST API, the `swaggerSchemavalidator` handler is enabled for the API Synapse configuration file. The JSON Schema Validator validates the requests before forwarding them to the backend, and it also validates all the response payloads against the defined response schema before responding to the client. 

If the request fails the validations, the JSON Schema Validator sends a bad request error (status code = 400) and blocks the request from reaching the backend. Likewise, if the response fails the validations, the JSON Schema Validator sends an internal server error (status code = 500) to the client.

## Request Validation

**Sending a valid request**

The following diagram illustrates the message flow when sending a valid request.

![JSON schema validator - Sending a valid request]({{base_path}}/assets/img/learn/json-validator-send-valid-request.png)

**Sending an invalid request**

The following diagram illustrates the message flow when sending an invalid request.

![JSON schema validator - Sending an invalid request]({{base_path}}/assets/img/learn/json-validator-send-invalid-request.png)

**Example:**

The following is an invalid request based on the [Petstore API](https://github.com/OAI/OpenAPI-Specification/blob/master/examples/v2.0/json/petstore.json).

```
curl -X POST "https://localhost:8243/rfrf/1.0.0/pet" -H "accept: */*" -H "Content-Type: application/json" -H "Authorization: Bearer c06e0cb0-af4a-3e5e-b8c3-99449ff7e3e5" -d "{\"id\":0,\"category\":{\"id\":0,\"name\":\"string\"},\"name\":\"doggie\",\"photoUrls\":[\"string\"],\"tags\":[{\"id\":0,\"name\":\"string\"}],\"status\":\"available\"}"
```

The following response is displayed.

```
<am:fault xmlns:am="http://wso2.org/apimanager">
  <am:code>400</am:code>
  <am:message>Bad Request</am:message>
  <am:description>Schema validation failed in the Request: #/photoUrls: expected type: JSONArray, found: String, #/tags: expected type: JSONArray, found: JSONObject</am:description>
</am:fault>
```

## Response Validation

**Valid response from the backend**

The following diagram illustrates the message flow when sending a valid response.

![JSON schema validator - Sending a valid response]({{base_path}}/assets/img/learn/json-validator-send-valid-response.png)

**Invalid response from the backend**

The following diagram illustrates the message flow when sending an invalid response.

![JSON schema validator - Sending an invalid response]({{base_path}}/assets/img/learn/json-validator-send-invalid-response.png)

**Example**

The following is a sample request from the client based on the [Petstore API](https://github.com/OAI/OpenAPI-Specification/blob/master/examples/v2.0/json/petstore.json).

```
curl -X GET "https://localhost:8243/rfrf/1.0.0/pet/1" -H "accept: application/xml" -H "Authorization: Bearer c06e0cb0-af4a-3e5e-b8c3-99449ff7e3e5"
```

The following validation response from the Gateway is displayed.

```
<am:fault xmlns:am="http://wso2.org/apimanager">
  <am:code>500</am:code>
  <am:message>Bad Response</am:message>
  <am:description>Schema validation failed in the Response: #: required key [name] not found, #: required key [photoUrls] not found, </am:description>
</am:fault>
```

## Enabling the JSON Schema Validator

  <html>
  <div class="admonition note">
  <p class="admonition-title">Note</p>
  <p>When the JSON schema validation is enabled, it will trigger the payload to be built for all requests and responses. Therefore, this will have an impact on the round trip time of an API request. </p>
  </div> 
  </html> 

1. Sign in to the API Publisher Portal.
   
    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    Use your username and password to sign in.

2. Click on the API for which you need to enable JSON validation.

3. Click **Runtime Configurations**.

4. Enable **Schema Validation**.

     By default, the schema validation property is set to `false`.

     ![Enable API schema validation]({{base_path}}/assets/img/learn/api-runtime-config.png)

5. Click **SAVE**.

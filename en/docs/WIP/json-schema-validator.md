# JSON Schema Validator

Attackers may try malicious payloads to break the API Gateway. Therefore, it is vital to have thorough client-side validation to validate all the requests and responses to reduce backend failures. 

The JSON Schema Validator in WSO2 API Manager evaluates the payload and checks whether it is compatible with the defined JSON schema, which is defined in the `swagger.json` file, by ensuring that the required properties and the additional constraints (e.g., a price never being less than one dollar) are present.

The JSON Schema Validator uses the `swaggerSchemavalidator` handler to validate the API schema. When the users enable schema validation either via the API Publisher Portal or via REST API, the `swaggerSchemavalidator` handler is enabled for the API Synapse configuration file. The JSON Schema Validator validates the requests before forwarding them to the backend, and it also validates all the response payloads against the defined response schema before responding to the client. 

If the request fails the validations, the JSON Schema Validator sends a bad request error (status code = 400) and blocks the request from reaching the backend. Likewise, if the response fails the validations, the JSON Schema Validator sends an internal server error (status code = 500) to the client.

## Request Validation

**Sending a valid request**

The following diagram illustrates the message flow when sending a valid request.

![JSON schema validator - Sending a valid request](../../WIP/assets/img/json-validator-send-valid-request.png)

**Sending an invalid request**

The following diagram illustrates the message flow when sending an invalid request.

![JSON schema validator - Sending an invalid request](../../WIP/assets/img/json-validator-send-invalid-request.png)

## Response Validation

**Valid response from the backend**

The following diagram illustrates the message flow when sending a valid response.

![JSON schema validator - Sending a valid response](../../WIP/assets/img/json-validator-send-valid-response.png)

**Invalid response from the backend**

The following diagram illustrates the message flow when sending an invalid response.

![JSON schema validator - Sending an invalid response](../../WIP/assets/img/json-validator-send-invalid-response.png)

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

     ![Enable API schema validation](../../WIP/assets/img/api-runtime-config.png)

5. Click **SAVE**.

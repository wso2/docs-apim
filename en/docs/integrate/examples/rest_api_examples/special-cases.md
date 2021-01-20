## GET request with a Message Body
Normally, a GET request does not contain a body, and the Micro Integrator will not consume the payload even if there is one. The payload will not go through the mediation or to the backend.

## Using POST with an Empty Body
Typically, POST request is used to send a message that has data enclosed as a payload. However, you can also use POST without a payload. WSO2 Micro Integrator considers such messages as normal messages and forwards them to the endpoint without any additional configurations.

## Using POST with Query Parameters
Sending a POST message with query parameters is an unusual scenario, but the Micro Integrator supports it with no additional configuration. The Micro Integrator forwards the message like any other POST message and includes the query parameters.
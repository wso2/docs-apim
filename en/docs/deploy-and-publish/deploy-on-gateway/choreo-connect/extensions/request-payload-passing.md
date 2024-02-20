# Request Payload Passing

By default, the payload of a request will not be passed to the Enforcer. Therefore, when using custom filters, you will not be able to update a request based on the payload. 

However, if you [enable passing the request payload](#enable-request-payload-passing-for-all-apis), the Enforcer will get the request data submitted with the API call. Thereafter, you can implement a custom filter to perform customized operations based on the input data provided with the API call.

## Enable request payload passing for all APIs

Follow the instructions below to enable request payload passing for all APIs:

1. Open the `config.toml` file in Choreo Connect.
2. Add the following configurations under the `router` section to enable request payload passing.

      ```
      # Configs for request payload passing from Router to Enforcer.
      [router.payloadPassingToEnforcer]
        # Enable/Disable request payload passing.
        passRequestPayload = true
        # Sets the allowed maximum size of a request payload in bytes.
        maxRequestBytes = 10240
        # If enabled, the request payload will be buffered until maxRequestBytes is reached.
        allowPartialMessage = false
        # If enabled, the request payload will send as raw bytes, otherwise it will be a UTF-8 string request payload.
        packAsBytes = false
      ```
      
       This will enable all the APIs to pass the request payload to the Enforcer in a single Choreo Connect deployment. If you want to avoid passing the request payload to the Enforcer for a given API, you can [Disable request payload passing for a specific API](#disable-request-payload-passing-for-a-specific-api).

## Disable request payload passing for a specific API

Follow the instructions below to disable request payload passing for a specific API:

1. [Enable global request payload passing](#enable-request-payload-passing-for-all-apis) if you have not configured this already.

2. Add the `x-wso2-pass-request-payload-to-enforcer` vendor extension in the APIs Swagger or OAS3 definition at the root level and assign the value as `false`.

       ```
       x-wso2-pass-request-payload-to-enforcer: false
       ```

       All the APIs that do not have the above extension value defined as `false` will pass the request payload to the Enforcer.

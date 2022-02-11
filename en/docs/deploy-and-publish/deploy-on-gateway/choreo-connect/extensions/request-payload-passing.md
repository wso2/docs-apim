By default, the payload of a request will not be passed to the enforcer. Therefore, when using custom filters, updating a request based on the payload 
will not be possible. You can use the following configurations to enable passing the request payload to the enforcer. Once enabled, enforcer will get 
the request data submitted with the API call. 
Then, you can implement a custom filter to perform customized operations based on the input data provided with the API call.

Follow the instructions below to enable request payload passing feature:

1. Add following configurations under `router` section in `config.toml` of Choreo Connect to enable request payload passing feature.
``` toml
     # Configs for request payload passing from router to enforcer.
     [router.payloadPassingToEnforcer]
        # Enable/Disable request payload passing feature.
        passRequestPayload = true
        # Sets the allowed maximum size of a request payload in bytes.
        maxRequestBytes = 10240
        # If enabled, request payload will be buffered until maxRequestBytes is reached.
        allowPartialMessage = false
        # If enabled, request payload will send as raw bytes, otherwise it will be a UTF-8 string request payload.
        packAsBytes = false
```
This will enable all the APIs to pass request payload to the enforcer in a single Choreo Connect deployment.
If you want to avoid using this feature for a given API, you can follow the step explained below.

## Disable request payload passing for a specific API

1. Add below vendor extension in swagger or OAS3 definition's root level to disable request payload passing feature for the API.


      ```yaml
      x-wso2-pass-request-payload-to-enforcer: false
      ```
Assigning above extension value as `false` will disable the request payload passing feature for a given API. All the APIs that do not have above extension
value as `false` will pass request payload to the enforcer (compulsory to add above `config.toml` configuration).


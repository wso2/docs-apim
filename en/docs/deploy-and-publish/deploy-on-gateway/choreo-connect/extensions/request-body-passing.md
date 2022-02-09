You can enable request body passing in Choreo Connect using below configurations.
After enabling the request body passing feature, enforcer will get the request data 
submitted with the API call. Then, you can implement a custom filter to perform customized
operations based on the input data provided with the API call.

Follow the instructions below to enable request body passing feature:

1. Add following configurations under `router` section in `config.toml` of Choreo Connect to enable request body passing feature.
``` toml
     # Configs for request body passing from router to enforcer.
     [router.payloadPassing]
        # Enable/Disable request body passing feature.
        passRequestBodyToEnforcer = true
        # Sets the allowed maximum size of a request body in bytes.
        maxRequestBytes = 10240
        # If enabled, request body will buffer the message until maxRequestBytes is reached.
        allowPartialMessage = false
        # If enabled, request body will send as raw bytes, otherwise it will be a UTF-8 string request body.
        packAsBytes = false
```
This will enable all the APIs to pass request body to the enforcer in a single Choreo Connect deployment.
If you want to avoid using this feature for a given API you can follow the step explained below.

## Disable request body passing for a specific API

1. Add below vendor extension in swagger or OAS3 definition's root level to disable request body passing feature for the API.


      ```yaml
      x-wso2-pass-request-body-to-enforcer: false
      ```
Assigning above extension value as `false` will disable the request body passing feature for a given API. All the APIs that do not have above extension
value as `false` will pass request body to the enforcer (compulsory to add above `config.toml` configuration).


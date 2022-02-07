You can enable request body passing in Choreo Connect using below configurations.
After enabling the request body passing feature, enforcer will get the request data 
submitted with the API call. Then, you can implement a custom filter to perform customized
operations based on the input data provided with the API call.

Follow the instructions below to enable request body passing feature:

1. Use the following configurations to enable request body passing in the router.
``` toml
     # Request body passing configurations
     [router.bodyPassing]
        # Enables request body passing feature
        passRequestBodyToEnforcer = true
        # Sets the maximum size of a message body that the ext_authz filter allowed hold in memory
        maxRequestBytes = 1024
        # Enabling sends request body as raw bytes to the enforcer
        packAsBytes = true
```
2. Add below vendor extension in swagger or OAS3 definition's root level to enable request body passing feature for the API.


      ```yaml
      x-wso2-enforcer-request-body-passer: true
      ```



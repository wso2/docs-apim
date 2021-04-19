# Define Security using extension

By default, the APIs and resources are protected via OAuth2 in the WSO2 API Microgateway.  You (API consumer) will need a valid OAuth2 access token (JWT or opaque) to invoke an API(s).  However, APIs can be exposed without any authentication using the [swagger security scheme definition](https://swagger.io/docs/specification/authentication/) or OpenAPI extension `                   x-wso2-application-security                 ` . This extension is supported in API level and resource level. The following is an example of how you can define security at the resource level of an API.

``` java
paths:
  "/pet/findByStatus":
    get:
      tags:
        - pet
      summary: Finds Pets by status
      description: Multiple status values can be provided with comma separated strings
      operationId: findPetsByStatus
      x-wso2-application-security: 
        security-types:
          - "oauth2"
          - "basic_auth"
          - "api_key"
```

!!! note
    If you provided both swagger security types and x-wso2-application-security extension for a resource/ API then, the extension will override the swagger security schemes for the resource or API.



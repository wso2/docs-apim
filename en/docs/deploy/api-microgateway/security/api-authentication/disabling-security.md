# Disabling Security

APIs can be exposed without requiring any authentication (i.e. disable transport security and application security) using the OpenAPI extension `                   x-wso2-disable-security                 ` . This extension is supported at both API and Resource levels. Following is an example of how you can disable security an API.

``` yml tab="API Level"
openapi: 3.0.0
info:
  version: 1.0.0
  title: Petstore
x-wso2-disable-security: true
  paths:
    "/pet/findByStatus":
    get:
```

``` yml tab="Resource Level"
paths:
 "/pet/findByStatus":
  get:
    tags:
    - pet
    summary: Finds Pets by status
    description: Multiple status values can be provided with comma separated strings
    operationId: findPetsByStatus
    x-wso2-disable-security: true
```



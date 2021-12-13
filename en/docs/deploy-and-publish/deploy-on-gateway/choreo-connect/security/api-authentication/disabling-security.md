# Disabling Security

APIs can be exposed without requiring any authentication (i.e. disable transport security and application security) using the OpenAPI extension `                   x-wso2-disable-security                 ` . This extension is supported at API, resource and operation levels. Following is an example of how you can disable security for an API.

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
    x-wso2-disable-security: true
    get:
      tags:
      - pet
      summary: Finds Pets by status
      description: Multiple status values can be provided with comma separated strings
      operationId: findPetsByStatus
```

``` yml tab="Operation Level"
paths:
 "/pet/findByStatus":
    get:
      x-wso2-disable-security: true
      tags:
      - pet
      summary: Finds Pets by status
      description: Multiple status values can be provided with comma separated strings
      operationId: findPetsByStatus
```

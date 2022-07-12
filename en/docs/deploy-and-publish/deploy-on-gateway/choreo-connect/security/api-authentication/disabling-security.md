# Disabling Security for APIs

An API can be invoked without authentication by disabling security. Pick one of the following methods to disable security depending on the Choreo Connect **mode** you have chosen.


|**Mode**         | **Method**    |
|--------------|-----------|
|[Choreo Connect with WSO2 API Manager as a Control Plane]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/)   | [Via WSO2 API Manager Publisher Portal](#via-wso2-api-manager-publisher-portal)  |
|[Choreo Connect as a Standalone Gateway]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/)  |[By Updating the OpenAPI Definition](#by-updating-the-openapi-definition) |

## Via WSO2 API Manager Publisher Portal

1. Select the API from the Publisher Portal.

2. Click **Resources** listed under **API Configurations** in the left menu to navigate to the Resources page in the Publisher.

3. Expand any method and switch the security slidebar off to disable security for that specific resource.

     [![Disable security for a Prototype API resource]({{base_path}}/assets/img/design/api-security/desable-security-for-resource.png)]({{base_path}}/assets/img/design/api-security/desable-security-for-resource.png)

## By updating the OpenAPI definition

APIs can be exposed without requiring any authentication (i.e. disable transport security and application security) using the OpenAPI extension `x-wso2-disable-security` . This extension is supported at API, resource, and operation levels. The following is an example of how you can disable security for an API.

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

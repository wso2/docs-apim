# Prototyped APIs (Pre-Released APIs)

Prototyped APIs (Pre-Released APIs) allow subscribers to try out APIs without monetizations, allowing them to provide feedback to improve APIs. 

**PRE-RELEASED** (previously **PROTOTYPED**) is a lifecycle state of the API that disallows adding monetizations to the API. After a period of time, the publishers can make changes requested by the users and publish the API (change the lifecycle state of the API to PUBLISHED) to add monetizations as required.

[![PRE-RELEASED lifecycle status]({{base_path}}/assets/img/learn/prototype-api/prototype-api-lifecycle.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-lifecycle.png)

In the Developer Portal, these APIs will be the labelled as **PRE-RELEASED** and therefore can be clearly identified.

[![PRE-RELEASED to Developer Portal]({{base_path}}/assets/img/learn/prototype-api/prototype-api-devportal.png)]({{base_path}}/assets/img/learn/prototype-api/prototype-api-devportal.png)

WSO2 API Manager allows prototyping an API at two different stages. 

1. At an initial stage, before implementing the actual backend, the backend responses can be mocked with a Prototype API by changing the **Endpoint Type** to **Mock Implementation**. You can use the these APIs to get feedback before you start implementing the actual service.

	[![Select Mock Implementation]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-mock-impl-swagger-petstore.png)]({{base_path}}/assets/img/learn/prototype-api/create-api-prototype-mock-impl-swagger-petstore.png)

2. Once a backend is implemented, the endpoint can be updated to an actual backend URL type, which then can be used for testing purposes and for an early promotion.

Follow a link below to Prototype an API.

1. [Mock responses based on the OpenAPI specification with API Gateway]({{base_path}}/design/prototype-api/create-mocked-js-api/)    
2. [Mock responses based on the OpenAPI specification with Choreo Connect]({{base_path}}/design/prototype-api/create-mocked-oas-api/)    
3. [Expose an existing backend implementation as a Pre-Released API]({{base_path}}/design/prototype-api/backend-url-prototype-api/) (Supported with both API Gateway and Choreo Connect)




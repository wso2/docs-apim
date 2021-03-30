# Consumer API - Overview

An API Consumer is typically an application developer who may be internal or external to your organization. Consuming APIs is the process by which the application developer accesses the various APIs that are exposed by you (the API provider) and then uses those APIs to develop one’s own software applications and products. 

API consumers discover and access APIs from the **Developer Portal** of your WSO2 API Manager as shown below.

<img src="{{base_path}}/assets/img/get_started/architecture/developer-portal-overview.png" alt="developer portal of wso2 api manager">

## API Consumer Tasks

The process of consuming an API from WSO2 API Manager involves the following steps:

<img src="{{base_path}}/assets/img/consume/api-consumer-workflow.png" alt="main tasks for an api consumer">

### Discover APIs

When APIs are created and published through the **Publisher**, they become available through the **Developer Portal**. By default, the AI technologies of the Developer Portal recommends APIs based on the developer’s interests. Developers can also use the search option to find APIs of interest.

-   <a href="{{base_path}}/consume/discover-apis/search">Searching for APIs</a>
-   <a href="{{base_path}}/consume/discover-apis/api-recommendations">AI-based API recommendations</a>

### Subscribe to APIs

Before using an API, the developer must first subscribe to the APIs and obtain the required authentication keys through an **application**.

**Applications**

An application is a logical representation of a physical application such as a mobile app, webapp, device, etc. An API subscription is created, authenticated, and managed through an application. Find out more about [applications]({{base_path}}/consume/manage-application/create-application).

**Authentication**

The subscription process is authenticated using OAuth2 by default. The authentication keys are generated for each application per gateway environment (Production or Sandbox). When the subscribing developer invokes the API through an application, the access token for the relevant gateway environment should be used.

**Business Plans**

Developers need to select a business plan for each API subscription. The business plan determines the number of requests that are allowed to be sent to the API per minute. Therefore, this is also the [throttling policy]({{base_path}}/design/rate-limiting/introducing-throttling-use-cases) that applies to a subscription.

### Test APIs

Before using an API for development, the API consumer may want to test it’s capabilities. The following options are available in the Developer Portal for testing:

-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console">Invoke APIs using the Integrated API Console</a>
    -   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/include-additional-headers-in-the-api-console">Include Additional Headers in the API Console</a>
-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console">Invoke GraphQL APIs using the Integrated GraphQL Console</a>
-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-a-soap-client">Invoke an API using a SOAP Client</a>
-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/try-out-using-postman">Invoke an API using Postman</a>

## Rate and Support APIs

As members of the API consumer community, developers can rate and support the APIs through the Developer Portal. This is also a forum where API consumers can give feedback to the API providers.

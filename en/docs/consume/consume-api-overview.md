WSO2 API Manager enables a comprehensive API marketplace. API providers can expose APIs using the Publisher and API consumers can easily discover the APIs and consume them using the Developer Portal. 

<img src="{{base_path}}/assets/img/get_started/architecture/developer-portal-overview.png" alt="developer portal of wso2 api manager">

## API Consumer

An API Consumer is typically an application developer who may be internal or external to your organization. Consuming APIs is the process by which the application developer accesses the various APIs that are exposed by an API provider and then uses those APIs to develop one’s own software applications and products. 

With the strong enterprise integration capabilities introduced with WSO2 API Manager 4.0.0, API consumers can now have access to APIs that trigger complex mediation logic.

If you are a developer who is interested in consuming APIs that are exposed through the WSO2 API management platform, follow the documentation in this section.

## API Consumer Tasks

The process of consuming an API from WSO2 API Manager involves the following steps. As a developer, you also need to perform various other supporting tasks before you start using an API for your development.

<!--
<img src="{{base_path}}/assets/img/consume/intro/api-consumer-workflow.png" alt="main tasks for an api consumer">
-->

<!--
<img src="{{base_path}}/assets/img/consume/intro/api-consumer-supporting-tasks.png" width="500" alt="supporting taks for an api consumer">
-->

### Discover APIs

When APIs are created and published through the **Publisher**, they become available through the **Developer Portal**. By default, the AI technologies of the Developer Portal recommends APIs based on the developer’s interests. Developers can also use the search option to find APIs of interest. 

-   <a href="{{base_path}}/consume/discover-apis/search">Searching for APIs</a>
-   <a href="{{base_path}}/consume/discover-apis/api-recommendations">AI-based API recommendations</a>

### Subscribe to APIs

Before using an API, you must first subscribe to the APIs and obtain the required authentication keys.

**Applications**

An API subscription is created, authenticated, and managed through a consumer application. The subscription process is authenticated using OAuth by default.

**Business Plans**

When you subscribe to an API, you need to select a business plan for your subscription.

### Test APIs

Before using an API (that you discover from the developer portal) in your development, you may want to test it’s capabilities. You can use the following options in the Developer Portal for testing:

-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console">Invoke APIs using the Integrated API Console</a>
    -   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/include-additional-headers-in-the-api-console">Include Additional Headers in the API Console</a>
-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console">Invoke GraphQL APIs using the Integrated GraphQL Console</a>
-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-a-soap-client">Invoke an API using a SOAP Client</a>
-   <a href="{{base_path}}/consume/invoke-apis/invoke-apis-using-tools/try-out-using-postman">Invoke an API using Postman</a>

## Rate and Support APIs

As members of the API consumer community, you can rate and support the APIs by using the Developer Portal. You can also use this as a forum to give feedback to the API providers.

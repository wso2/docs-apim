# About this Release

WSO2 API Manager is a platform for creating, managing, consuming, and monitoring APIs. It employs proven SOA best practices to solve a wide range of API management challenges such as API provisioning, API governance, API security, and API monitoring. It combines some of the most powerful and mature components of the WSO2's state-of-the-art Carbon platform to deliver a smooth and end-to-end API management experience while catering to both API publisher and API consumer requirements.

WSO2 API Manager comprises of the following modules:

- **API Publisher**: Allows API creators to design, implement, and document APIs and allows API product managers to manage the lifecycle of APIs and create API products by using one or more APIs.

- **Developer Portal**: A portal for onboarding application creators. It allows application creators to discover, subscribe, test and consume APIs through their applications.

- **API Gateway**: Allows access to APIs/services by routing application traffic to the relevant endpoints. The API Gateway is the component that enforces security, rate-limiting and transformations on API requests while feeding valuable information of these requests to API Analytics.

- **Key Manager**: The security token service of the API Manager which is responsible for handling everything related to authentication and authorization of API requests. It supports a wide variety of security protocols such as OAuth2.0/OIDC, Basic Auth, API Key, SAML based single-sign-on.

- **Traffic Manager**: Controls the traffic flow of the API gateway. This is used to apply request quotas on APIs for monetization, access control or security-related matters. In addition to configuring the available policies, users can deploy their own policies on the traffic manager which will control the rate of traffic on the API gateways.

- **API Analytics**: Monitors all traffic that's routed through the API gateways to analyze usage patterns, SLA violations, consumer behaviors, to provide business insights and so on.


For more information on WSO2 API Manager, see the [overview in the WSO2 API Manager 3.2.0 documentation]({{base_path}}/getting-started/overview/) and go to the [product page on WSO2 API Manager on the WSO2 website.](https://wso2.com/api-management/)

## What is new in this release

The **WSO2 API Manager 3.2.0** is the **latest** **WSO2 API Manager release** and is the successor of **WSO2 API Manager 3.1.0**. It contains the following new features and enhancements:

### WSO2 API-M related new features

- **[Multiple Third-party Key Manager support]({{base_path}}/administer/key-managers/overview/)**

    Until API Manager 3.1.0, the only possible way to extend the key management functionality was to configure WSO2 Identity Server. But with this new feature, WSO2 API Manager supports multiple third-party key managers such as Okta and Keycloak. This offers more flexibility when integrating with third-party identity management systems. All tokens and keys will be managed by the respective third-party key manager.

- **[Inbuilt workflow support]({{base_path}}/learn/consume-api/manage-application/advanced-topics/adding-an-application-creation-workflow/)**

     API Manager 3.2.0 supports in-built workflow approvals. It is specifically designed to facilitate a simple approval/rejection process without integrating with a business process server. The Approval Workflow Executor can be enabled for application creation, subscription creation, application key generation, user self sign up, and API state change.

- **[Test console for API Publisher]({{base_path}}/learn/design-api/create-api/test-a-rest-api/)**

     The new test Console in the API Publisher allows you to try out APIs from the API Publisher. API creators and publishers can verify functions and behaviors and fix issues  before publishing them to the Gateway and making it available for subscribers.

- **[Query complexity analysis for GraphQL APIs]({{base_path}}/learn/rate-limiting/graphql-api/query-complexity-limitation/#adding-a-new-subscription-policy-with-graphql-max-complexity-value)**

    WSO2 API Manager introduces the Static Query Analyser to which can be used to protect the backend endpoint from GraphQL queries that are more complex than a specified depth limit. Since GraphQL APIs offer the flexibility to fetch data using expensive queries, users might send requests with complex queries. Sometimes, this will create a significant workload for the backend and make it vulnerable to DOS attacks (in the worst case). With this feature, the API Manager server will analyze the complexity of the query before sending it to the backend and will make sure that the backend is safe from complex queries.

    

- **[Support for exposing OAuth 2.0 secure endpoints]({{base_path}}/learn/design-api/endpoints/endpoint-security/oauth-2.0/)**

     WSO2 API Manager 3.2.0 supports OAuth 2.0 Endpoint Security out-of-the-box. An API can be created to access a backend protected using OAuth 2.0 security standards. The required parameters can be specified via the UI.

- **Horizontal Pod Auto-Scaling with Custom-Metrics in the Kubernetes API-Operator**

     You can now auto-scale backend or managed API horizontally based on custom metrics. For more information, see the [sample scenario (v1.2.0)](https://github.com/wso2/k8s-api-operator/tree/master/scenarios/scenario-20) with detailed configurations in the GitHub page of the K8s API-Operator.

- **[Private Jet mode for Microgateways]({{base_path}}/learn/kubernetes-operators/k8s-api-operator/enabling-privatejet-mode-to-deploy-apis/)**

     WSO2 API Manager now provides cloud-native API management, where users can expose microservices as secure managed APIs in cloud environments with the support of the K8s API-Operator. 

- **[Gateway Runtime Artifact Synchronizer]({{base_path}}/install-and-setup/setup/distributed-deployment/synchronizing-artifacts-in-a-gateway-cluster/)**

     This feature allows you to sync nodes seamlessly in a Multi-Gateway setup with an extension point that can be configured to store these Synapse artifacts in a pre-configured storage location. 

- **[Git integration support for API Controller]({{base_path}}/learn/api-controller/ci-cd-with-wso2-api-management/)**

     From API Manager 3.2 onwards, the API Controller can operate on top of a Git repository and identify all the APIs/API Products and application projects that are committed to it. It provides a single command to detect and deploy all the projects to the given environment.

- **Support for API products from API Controller**

     The API Controller now supports handling API products in addition to APIs. With this new feature, a CI/CD pipeline can be implemented using API products (a package of APIs or selected resources from multiple APIs).
 
- **Support for Different Endpoint Types from API Controller**   
    The API controller supports a wide range of endpoint types in addition to HTTP/REST endpoints. This feature, gives the API controller the ability to not only support HTTP/SOAP endpoints but to also support load balancing, failover, dynamic endpoints, and AWS lambda endpoints.
   

- **API Lifecycle Status Change Support from API Controller**

     API lifecycle status change support in WSO2 API Controller 3.2 provides users the ability to modify the lifecycle status of an API easily without accessing the Publisher UI. 

- **API/Application delete support using the API Controller**

     WSO2 API Controller 3.2 provides the ability to delete an API/application using a single command, allowing users to easily remove an unwanted API or an application in an environment without signing in to the Publisher or Developer Portal.

- **[API Key Authentication support for API Operator]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-api-keys/#api-key-restriction-for-ip-address-and-http-referer)**

     API key authentication support in API Operator provides a simple authentication scheme that accepts a valid self-contained JWT token issued for accessing APIs.

- **[APIKey Restriction for IP and Referrer]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-api-keys/#api-key-restriction-for-ip-address-and-http-referer)**

     Ability to define authorized parties when generating a token using an IP address restriction or a HTTP referer restriction.

### WSO2 API-M Analytics related new features

- **Monitoring dashboard for operational statistics**

      Having an idea about the overall health status of APIs and services is essential for the proper functioning of an API-driven business. The Monitoring Dashboard helps to achieve this objective by showing contextual information on APIs such as latency, throughput, errors, and traffic volume. Operational and management users can use this dashboard to identify operational errors, narrow down the root cause, or to identify common traffic trends. The overview page provides a holistic view by aggregating different views on APIs, and by using the drill-downs user can get a detailed picture of different perspectives. 

- **Dashboard for business analytics**
        
      Significant changes have been done on the Publisher Analytics Dashboard to improve the experience of different audiences. The newly available Business Analytics Dashboard has been created by combining several new widgets with the widgets that initially existed in the Publisher Analytics Dashboard to provide an unrestricted view on the APIs for Managerial users. A user with an *internal/analytics* role can access the new dashboard to view the statistics for all APIs irrespective of whether those APIs are access-controlled or not. Further, a specific set of widgets chosen from the Publisher Analytics Dashboard has been used to create an API Analytics Dashboard, which now shows a limited set of Statistics relevant to a Publisher. A Publisher can use this dashboard to view the statistics of APIs created by them or visible to them.
      The Developer portal Dashboard has been renamed to the Application Analytics Dashboard and the Admin Dashboard has been renamed to Reports Dashboard, to reflect their functionality better.
     
- **API Usage Comparison**    
  Users can compare multiple APIs on a single screen and get a clear idea about those APIs in various matrices such as the number of API hits
                                                                         
- **Exporting data in CSV, PDF formats**
    
      This new feature is introduced to widgets in order to export data as a CSV or PDF. It supports all the widgets with tabular data. Users can export the current view and can share, analyze, or compare it with different views. It helps to export custom or selected data sets.
      
- **New alert page in Monitoring Dashboards**

      As information related to API availability and alert listing is more related to analytics, it has been moved to the Monitoring Dashboard from the API Manager Admin Portal. It provides an overview of the API availability and filtering based on the availability status. The alert listing widgets have additional improvements to provide filtering and better API-wise comparison. Interactive widgets are provided and support to narrow down alerts.

- **New summary charts for monitoring dashboards**

      Summarised information of the API requests is present in these widgets. There are 4 summary widgets to depict the total API invocation count, faulty count, throttled out request count, and highest API latency time within the last 24 hours. These widgets help to identify the above parameters of the system and it also allows users to do a drill-down analysis on appropriate widgets in order to narrow down the issues.


## What has changed in this release

### Improvements to existing WSO2 API-M features

- **Shared scopes within the tenant**

     Adds more improvements for this by supporting shared scopes per tenant and allowing multiple scopes to be attached to each API resource. This feature ensures that only privileged users can create, modify, and manage the shared scopes in a particular tenant space

- **Re-skinned admin portal UI**

     WSO2 API Manager’s Admin Portal has got a whole new and exciting look with the use of ReactJS, which is a popular JavaScript library for building user interfaces. The new Admin Portal UI clearly defines the administrative tasks that can be performed, and it also makes the workflows of API administrators simple and more efficient. It has a dashboard view that shows the summary of the administrative tasks and any pending workflow approvals. This makes it easier for administrators to keep track of pending or already-performed tasks. Similar to the Publisher and Developer Portal, the Admin Portal is a OAuth2.0 client application, which authenticates to the WSO2 API Manager’s backend via Open ID Connect. Users now have the ability to customize and enhance the look and feel of the Admin Portal by extending the React components in the portal. 

- **[Accessibility compliance of the Developer Portal]({{base_path}}/reference/accessibility-compliance)**
  
     WSO2 API Manager’s Developer Portal now conforms to the Level A and Level AA success criteria of the conformance requirements of the Web Content Accessibility Guidelines 2.1 (WCAG 2.1).  This will make content more accessible to a wider range of people.

- **Subscription upgrade**

     The subscription tier upgrade feature provides the capability to change the subscription tier of an already existing subscription without having to delete the subscription and resubscribe to the same API.

- **In-Memory subscription validation**

     The In-Memory subscription validation provides  support to remove runtime dependencies between the Gateway and the Key Manager node and validates the request by accessing the metadata in the In-Memory data store. As a result, WSO2 API Manager can serve the request even in a situation where the database is inaccessible.

- **Mock Response Payload Generation for API Prototyping**
 
     The Mock Response Payload Generation has been improved to allow API Publishers to generate complex inline scripts. This offers consumers the flexibility to obtain any response that is supported by a particular resource of the API. Furthermore, the publishers and consumers no longer have to face the limitation of being able to define and retrieve only a single response per resource.

- **Support for Public Certificate Installation for Secure HTTP Communication for the Controller**

     Ability to import SSL certificates related to WSO2 API Manager that are used in different environments. Certificates that are trusted by the operating system, which includes certificates of different Certificate Authority (CA), will be imported by default. If there are any additional certificates needed for controller operations of different environments, they can be imported manually. As a result, any DER or PEM encoded certificates can be imported.

- **Improve Search for an API / Application in Controller**

     WSO2 API Controller 3.2 allows users to search for APIs, applications, or API products during the listing process, which can be searched by name, version, provider, context, status, description, subcontext, doc, and label with `-q` or `--query` optional flag.
     
### Improvements to existing WSO2 API-M Analytics features

- **Improved charts for interactive presentations**
    The new API Manager 3.2.0 is powered with a collection of interactive charts. These charts allow users to have a detailed view of a specific aspect of the analytics. Moreover, it provides the option to export data in CSV format as well.

     
### Deprecated features and functionalities

- **Local scopes**

     The local scopes feature allows users to create per API scopes locally. Even though the local scope usage is limited to the API that it belongs to, the same scope key cannot be used for a local scope of any other API. Local scopes are created and updated in the Key Manager; thereby, making the number of Key Manager calls comparatively high. Therefore, this feature provides inferior support during scope update and scope validation when used across multiple versions of the same API. 
     
     From API Manager 3.2 onwards, it is recommended to use the [shared scopes]({{base_path}}/learn/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#shared-scopes) feature to create scopes per tenant and share them across multiple APIs in the tenant. Shared scopes will address these limitations by sharing the same scope across multiple APIs (including multiple versions of the same API) while making the management of scopes separate from API creation/update.

- **Cross tenant Subscription**

- **[Admin Portal](https://apim.docs.wso2.com/en/3.2.0/develop/product-apis/admin-apis/admin-v0.17/admin-v0.17/) v0.17 based REST APIs**.

### Removed features and functionalities

- **Tag wise grouping**

     API categories are used for API grouping, similar to Tag wise grouping. However, the user does not have to go through the hassle of following a naming convention when creating API categories. Therefore, with the introduction of the API categories, the Tag wise grouping feature has been removed. 

- **[Developer Portal](https://apim.docs.wso2.com/en/3.1.0/develop/product-apis/devportal-apis/devportal-v0.16/devportal-v0.16/), [Publisher](https://apim.docs.wso2.com/en/3.1.0/develop/product-apis/publisher-apis/publisher-v0.16/publisher-v0.16/), and [Admin Portal](https://apim.docs.wso2.com/en/3.1.0/develop/product-apis/admin-apis/admin-v0.16/admin-v0.16/) v0.16 based REST APIs**.

- **Developer Portal and Publisher v0.17 based REST APIs**.

- **Out-of-the-box support for the opaque access token in the Developer Portal**

     Out-of-the-box support to generate an opaque access token via the Developer Portal has been removed. Application Developers can create applications that only generate a **JWT** type access tokens. Applications that are migrated from older versions, will have the support to generate either an opaque access token or a JWT type access token. 
     
     Similar to previous versions, application developers will get the OAuth2 bearer tokens while generating tokens via the Developer Portal. The only difference is the format of the token as the JWT type token is self-contained.  
     
- **WSO2 Identity Server as a Key Manager** 
     
       The prepackaged WSO2 Identity Server as a Key Manager has been removed. When needed, make sure to use WSO2 Identity Server 5.10.0 as the Key Manager.

## Compatible WSO2 product versions

WSO2 API-M 3.2.0 is based on WSO2 Carbon 4.6.0 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version, except when using [WSO2 Identity Server as a Key Manager]({{base_path}}/install-and-setup/setup/distributed-deployment/configuring-wso2-identity-server-as-a-key-manager/), you need to specifically use WSO2 Identity Server 5.10.0 when working with WSO2 API-M 3.2.0. If you get any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For information on the third-party software required with API-M 3.2.0, see [Installation Prerequisites]({{base_path}}/install-and-setup/installation-guide/installation-prerequisites/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

## Fixed issues

-   [WSO2 API Manager 3.2.0 - Fixed Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues?q=is%3Aissue+is%3Aclosed+closed%3A2020-03-20..2020-08-15)
-   [WSO2 API Manager 3.2.0 - Fixed Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/milestone/29?closed=1)

## Known issues

-   [WSO2 API Manager 3.2.0 - Known Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues)
-   [WSO2 API Manager 3.2.0 - Known Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/issues)

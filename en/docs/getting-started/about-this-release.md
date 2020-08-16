# About this Release

WSO2 API Manager is a platform for creating, managing, consuming, and monitoring APIs. It employs proven SOA best practices to solve a wide range of API management challenges such as API provisioning, API governance, API security, and API monitoring. It combines some of the most powerful and mature components of the WSO2's state-of-the-art Carbon platform to deliver a smooth and end-to-end API management experience while catering to both API publisher and API consumer requirements.

WSO2 API Manager comprises of the following modules:

-   **Publisher Portal**: Define new APIs and manage them.
-   **Developer Portal**: Browse published APIs and subscribe to them.
-   **API Gateway**: The underlying API runtime based on [WSO2 Enterprise Integrator (WSO2 EI) 6.6.0](https://docs.wso2.com/display/EI660)
-   **API Key Manager**: Performs key generation and key validation functionalities.
-   **API Traffic Manager**: Performs rate limiting of API requests.

For more information on WSO2 API Manager, see the [overview in the WSO2 API Manager 3.2.0 documentation]({{base_path}}/getting-started/overview/) and go to the [product page on WSO2 API Manager on the WSO2 website.](https://wso2.com/api-management/)

## What is new in this release

The **WSO2 API Manager 3.2.0** is the **latest** **WSO2 API Manager release** and is the successor of **WSO2 API Manager 3.1.0**. It contains the following new features and enhancements:

### WSO2 API-M related new features

- **[Third-Party Key Manager Support]({{base_path}}/administer/key-managers/overview/)**

     WSO2 API Manager provides an admin functionality for admins/tenant admins to configure different authorization servers as Key Managers. This brings the capability of supporting multiple Key Managers for a given API.

- **[Approval Workflow Executor to API Manager]({{base_path}}/learn/consume-api/manage-application/advanced-topics/adding-an-application-creation-workflow/)**

     The Approval Workflow Executor can be enabled for application creation, subscription creation, application key generation, user self sign up, and API state change.

- **[API Publisher Test Console]({{base_path}}/learn/design-api/create-api/test-a-rest-api/)**

     The new Test Console in the API Publisher allows you to try out APIs from the publisher itself and verify functions and behaviors before publishing them to the gateway for subscribers.

- **GraphQL Query Complexity Analysis**

     You can request more data with increased flexibility using GraphQL queries. WSO2 API Manager introduces the Static Query Analyser to handle complex queries. 

- **OAuth 2.0 Endpoint Security**

     APIs created in WSO2 API Manager can directly access OAuth 2.0-protected endpoints without any extension to WSO2 API Manager.

- **Horizontal Pod Auto-Scaling with Custom-Metrics in the K8s API-Operator**

     You can now auto-scale backend or managed API horizontally based on custom metrics. A [sample scenario (v1.2.0)](https://github.com/wso2/k8s-api-operator/tree/master/scenarios/scenario-20) with detailed configurations can be found in the GitHub page of the K8s API-Operator.

- **[Private Jet mode for Micro Gateways]({{base_path}}/learn/api-microgateway/deploy-apis-in-privatejet-mode/)**

     WSO2 API Manager now provides cloud-native API management, where users can expose microservices as managed APIs in cloud environments with the support of the K8s API-Operator.

- **[Gateway Runtime Artifact Synchronizer]({{base_path}}/install-and-setup/setup/distributed-deployment/configuring-multi-gateway-setup-with-artifact-synchronization)**

     This feature allows you to sync nodes seamlessly in a Multi-Gateway setup using NFS with an extension point which can be configurable to store these synapse artifacts. 

- **[GIT Integration Support for API Controller]({{base_path}}/learn/api-controller/ci-cd-with-wso2-api-management/)**

     From API Manager 3.2 onwards, the API Controller can operate on top of a Git repository and identify all the APIs/API Products and Application Projects that are committed to it. And it gives a single command to detect and deploy all the projects to the given environment.

- **Support for API Products from API Controller**

     WSO2 API Manager enables users to utilize not only HTTP/REST endpoints but also HTTP/SOAP endpoints with endpoint routing policies such as load balancing and failover. Also, this incorporates support for dynamic endpoints and AWS Lambda endpoints as well.

- **API Lifecycle Status Change Support**

     API lifecycle status change support in WSO2 API Controller 3.2 provides users the ability to modify the lifecycle status of an API easily without accessing the Publisher UI. 

- **API/Application Delete Support for Controller**

     WSO2 API Controller 3.2 provides the ability to delete an API/application using a single command, allowing users to easily remove an unwanted API or application in an environment without login into the Publisher or Developer Portal.

- **[API Key Authentication Support for API Operator]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-api-keys/#api-key-restriction-for-ip-address-and-http-referer)**

- **[API Key Restriction for IP and Referrer]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-api-keys/#api-key-restriction-for-ip-address-and-http-referer)**


### WSO2 API-M Analytics related new features

- Monitoring dashboard

      Having an idea about the overall health status of APIs and Services is essential for the proper functioning of an API-driven business. Monitoring dashboard helps to achieve this objective by showing contextual information on APIs such as latency, throughput, errors, and traffic volume. Operational and Management users can use this dashboard to identify operational errors, narrow down the root cause, or to identify common traffic trends. The overview page provides a holistic view by aggregating different views on APIs, and by following the drill-downs user can get a detailed picture of different perspectives. 

- Re-organized Analytics dashboards
        
      Significant changes have been done on the Publisher Analytics dashboard to better suit it to different audiences. A new dashboard named Business Analytics has been created by combining several new widgets with those which initially existed in Publisher Analytics dashboard to provide an unrestricted view on the APIs for Managerial users. A user with an internal/analytics role can access the new dashboard to see Statistics for all APIs irrespective of whether those are access-controlled or not. Further, a specific set of widgets chosen from Publisher Analytics has been used to create an API Analytics dashboard, which now shows a limited set of Statistics relevant to a Publisher. A Publisher can use this dashboard to view statistics for both APIs created by them or visible to them.
      The Developer portal dashboard has been renamed to Application Analytics and the Admin dashboard has been renamed to Reports, to reflect their functionality better.
                                                                         
- Exporting data in CSV, PDF formats 
    
      This new feature is introduced to widgets to export data as a CSV or PDF. It supports all the widgets with tabular data. Users can be export the current view and can be share, analyze, or compare with different views. It helps to export custom or selected data sets.
      
- New Alert Page in Monitoring Dashboards

      API Availability and Alert listing capabilities implemented in Monitoring dashboards. Since this information is more related to analytics, it has been moved to the montoring dashboard from the API Manager admin portal. It provides an overview of the API availability and filtering based on the availability status. 
      Additional improvements are made to the alert listing widgets to provide filtering and better API wise comparison. Interactive widgets are provided and support narrow down alerts. 

- New Summary Charts for Monitoring Dashboards

      Summarised information of the API requests is present in these widgets. There are 4 summary widgets to show total API invocation count, faulty count, throttled out request count, and highest API latency time within the last 24 hours. These widgets help to identify the above parameters of the system and support drill down to appropriate widgets for narrow down issues.         


## What has changed in this release

### Improvements to existing WSO2 API-M features

- [Language Switch]({{base_path}}/learn/consume-api/customizations/adding-internationalization/#enabling-the-language-switch)
    
    A language switch allows the Developer Portal users to select the language in which they want to read the content. The Developer Portal theming architecture lets developers to add a language switch in different ways.

- [Changing the layout direction in the Developer Portal]({{base_path}}/learn/consume-api/customizations/adding-internationalization/#changing-the-layout-direction)

    You can switch the Developer Portal layout direction from its default LTR to RTL using a single configuration.

- Custom URL feature improvements

- Tracing feature improvements

- Multiple JWT issuer support

### Improvements to existing WSO2 API-M features

- Custom data publishing via a sequence

     The Gateway component publishes attributes related to each API call to the WSO2 API-M Analytics Server. These details are published in the form of events and then summarized and persisted in the database. But all the information related to the request is not published to the Analytics Server by default. This feature allows you to publish custom attributes related to an API call for later analysis. Based on your requirement, you can engage a custom mediation sequence in the request or response path.

- White labeling dashboard for tenants

     This feature  provides the system admins an easier approach to white label the analytics dashboard by changing the logo image and the favicon. The system admin does not need to have React, CSS, or HTML knowledge to do this customization. All you need to do is to place the required images inside the respective tenant folder and update the directives in the configuration file so that the server will pick those directives and display the respective images based on the tenant who is currently logged in to the system.

### Deprecated features and functionalities

- Tag wise grouping

     API categories are used for API grouping, similar to Tag wise grouping. However, the user does not have to go through the hassle of following a naming convention when creating API categories. Therefore, with the introduction of the API categories, Tag wise grouping has been deprecated, and WSO2 recommends users to use the 

- [Developer Portal]({{base_path}}/develop/product-apis/devportal-v0.15/) and [Publisher]({{base_path}}/develop/product-apis/publisher-v0.15) v0.15 based REST APIs.

### Removed features and functionalities

- [Monitoring message flows](https://apim.docs.wso2.com/en/3.0.0/administer/product-administration/monitoring/monitoring-message-flows/)

     This feature was removed due to low usage of the feature.

## Compatible WSO2 product versions

WSO2 API-M 3.2.0 is based on WSO2 Carbon 4.6.0 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version, except when using [WSO2 Identity Server as a Key Manager]({{base_path}}/install-and-setup/deploying-wso2-api-manager/ThirdPartyKeyManager/configuring-wso2-identity-server-as-a-key-manager/), you need to specifically use WSO2 Identity Server 5.10.0 when working with WSO2 API-M 3.2.0. If you get any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For information on the third-party software required with API-M 3.2.0, see [Installation Prerequisites]({{base_path}}/install-and-setup/installation-guide/installation-prerequisites/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

## Fixed issues

-   [WSO2 API Manager 3.2.0 - Fixed Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues?q=is%3Aissue+is%3Aclosed+closed%3A2019-11-01..2020-03-12+label%3A3.1.0+)
-   [WSO2 API Manager 3.2.0 - Fixed Issues in the carbon-apim GitHub repository](https://github.com/wso2/carbon-apimgt/issues?q=is%3Aissue+is%3Aclosed+closed%3A2019-11-01..2020-03-12)
-   [WSO2 API Manager 3.2.0 - Fixed Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/milestone/18?closed=1)

## Known issues

-   [WSO2 API Manager 3.2.0 - Known Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues?q=is%3Aopen+is%3Aissue+label%3A3.1.0)
-   [WSO2 API Manager 3.2.0 - Known Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/issues)

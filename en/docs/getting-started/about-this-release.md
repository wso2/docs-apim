# About this Release

WSO2 API Manager is a platform for creating, managing, consuming, and monitoring APIs. It employs proven SOA best practices to solve a wide range of API management challenges such as API provisioning, API governance, API security, and API monitoring. It combines some of the most powerful and mature components of the WSO2's state-of-the-art Carbon platform to deliver a smooth and end-to-end API management experience while catering to both API publisher and API consumer requirements.

WSO2 API Manager comprises of the following modules:

* **Publisher Portal**: Define new APIs and manage them.
* **Developer Portal**: Browse published APIs and subscribe to them.
* **API Gateway**: The underlying API runtime based on [WSO2 Enterprise Integrator (WSO2 EI) 6.6.0](https://docs.wso2.com/display/EI660)
* **API Key Manager**: Performs key generation and key validation functionalities.
* **API Traffic Manager**: Performs rate limiting of API requests.

For more information on WSO2 API Manager, see the [Overview in the WSO2 API Manager 3.1.0 documentation]({{base_path}}/getting-started/overview/) and go to the [Product page on WSO2 API Manager on the WSO2 website.](https://wso2.com/api-management/)

## What is new

The **WSO2 API Manager 3.1.0** is the **latest** **WSO2 API Manager release** and is the successor of **WSO2 API Manager 3.0.0**. It contains the following new features and enhancements:

### WSO2 API-M related new features

* **[Integrating AWS Lambda with APIM]({{base_path}}/learn/tutorials/create-and-publish-awslambda-api)**

    When using AWS Lambda to create and publish APIs, you can execute your code without having to manage or provision servers.

* **[API Security Audit Integration]({{base_path}}/learn/api-security/configuring-api-security-audit)**

    WSO2 API-M has partnered with [42Crunch](https://42crunch.com/), which is the only enterprise API security platform, in order to be able to conduct a security audit on the OpenAPI Specification definition and to obtain an audit report.

* **[API Categories]({{base_path}}/develop/customizations/customizing-the-developer-portal/customize-api-listing/categorizing-and-grouping-apis/api-category-based-grouping)**

    API categories are similar to Tag wise grouping. However, admins need to define API categories that Publishers can use when creating APIs. Furthermore, unlike Tag wise grouping API categories do not use a naming convention. Therefore, with the introduction of this feature, WSO2 has deprecated the Tag wise grouping feature.

* **[AI-based recommendations for the Developer Portal]({{base_path}}/learn/consume-api/discover-apis/api-recommendations)**

    The AI-based recommendations for the Developer Portal use a specialized recommendation engine to process recommendation related events and produce recommendations.

* **[API Mocking]({{base_path}}/learn/design-api/mock-api/create-a-mock-api-with-an-inline-script)**

    Ability to create a prototype API using a mock payload that is generated for inline scripts.

### WSO2 API-M Analytics related new features

* PDF Report Generation

    Many users have constantly requested for the feature that enables reported based on statistical data to be generated. The first cut of the implementation of this feature has been included in this release, and it enables users to generate the Monthly API Usage Report.

    Users can select the year and month of their choice and generate the Monthly API Usage Report via the API-M Admin dashboard. Furthermore, the default implementation of this feature can be extended if the organization that the user is attached to requires different data than the ones provided by the default report.

* Widget generator tool

    In addition to the default widgets that are shipped with the analytics dashboards, the Widget generator tool makes it easier to implement your own custom widget and use them across the dashboards. The widget generator tool automatically generates the widget skeleton by taking into account the user preferences via a command-line tool and guides the user until the widget is deployed in the dashboard.

* GraphQL Analytics

    GraphQL Analytics requirements differ from standard API analytics. The existing charts have been improved to be able to view statistics for GraphQL operations. A single API call for a GraphQL API can have multiple operations associated with it. In this release, analytics charts will have the in-built capability to filter these API calls by GraphQL operation.

## What has changed in this release

### Improvements to existing WSO2 API-M features

* [Language Switch]({{base_path}}/develop/customizations/adding-internationalization/#enabling-the-language-switch)

    A language switch allows the Developer Portal users to select the language in which they want to read the content. The Developer Portal theming architecture lets developers to add a language switch in different ways.

* [Changing the layout direction in the Developer Portal]({{base_path}}/develop/customizations/adding-internationalization/#changing-the-direction-of-the-ui)

    You can switch the Developer Portal layout direction from its default LTR to RTL using a single configuration.

* Custom URL feature improvements
* Tracing feature improvements
* Multiple JWT issuer support
* Custom data publishing via a sequence

    The Gateway component publishes attributes related to each API call to the WSO2 API-M Analytics Server. These details are published in the form of events and then summarized and persisted in the database. But all the information related to the request is not published to the Analytics Server by default. This feature allows you to publish custom attributes related to an API call for later analysis. Based on your requirement, you can engage a custom mediation sequence in the request or response path.

* White labeling dashboard for tenants

    This feature  provides the system admins an easier approach to white label the analytics dashboard by changing the logo image and the favicon. The system admin does not need to have React, CSS, or HTML knowledge to do this customization. All you need to do is to place the required images inside the respective tenant folder and update the directives in the configuration file so that the server will pick those directives and display the respective images based on the tenant who is currently logged in to the system.

### Deprecated features and functionalities

* Tag wise grouping

    API categories are used for API grouping, similar to Tag wise grouping. However, the user does not have to go through the hassle of following a naming convention when creating API categories. Therefore, with the introduction of the API categories, Tag wise grouping has been deprecated, and WSO2 recommends users to use the API Categories feature for API Grouping.

* [Developer Portal]({{base_path}}/develop/product-apis/devportal-v0.15/) and [Publisher]({{base_path}}/develop/product-apis/publisher-v0.15) v0.15 based REST APIs.

### Removed features and functionalities

* [Monitoring message flows](https://apim.docs.wso2.com/en/3.0.0/administer/product-administration/monitoring/monitoring-message-flows/)

    This feature was removed due to low usage of the feature.

## Compatible WSO2 product versions

WSO2 API-M 3.1.0 is based on WSO2 Carbon 4.6.0 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version, except when using [WSO2 Identity Server as a Key Manager]({{base_path}}/install-and-setup/setup/distributed-deployment/configuring-wso2-identity-server-as-a-key-manager), you need to specifically use WSO2 Identity Server 5.10.0 when working with WSO2 API-M 3.1.0. If you get any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For information on the third-party software required with API-M 3.1.0, see [Installation Prerequisites]({{base_path}}/install-and-setup/install/installation-prerequisites).

For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

## Fixed issues

* [WSO2 API Manager 3.1.0 - Fixed Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues?q=is%3Aissue+is%3Aclosed+closed%3A2019-11-01..2020-03-12+label%3A3.1.0+)
* [WSO2 API Manager 3.1.0 - Fixed Issues in the carbon-apim GitHub repository](https://github.com/wso2/carbon-apimgt/issues?q=is%3Aissue+is%3Aclosed+closed%3A2019-11-01..2020-03-12)
* [WSO2 API Manager 3.1.0 - Fixed Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/milestone/18?closed=1)

## Known issues

* [WSO2 API Manager 3.1.0 - Known Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues?q=is%3Aopen+is%3Aissue+label%3A3.1.0)
* [WSO2 API Manager 3.1.0 - Known Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/issues)

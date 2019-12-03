# About this Release

WSO2 API Manager is a platform for creating, managing, consuming, and monitoring APIs. It employs proven SOA best practices to solve a wide range of API management challenges such as API provisioning, API governance, API security, and API monitoring. It combines some of the most powerful and mature components of the WSO2's state-of-the-art Carbon platform to deliver a smooth and end-to-end API management experience while catering to both API publisher and API consumer requirements.

WSO2 API Manager comprises of the following modules:

-   **Publisher Portal**: Define new APIs and manage them.
-   **Developer Portal**: Browse published APIs and subscribe to them.
-   **API Gateway**: The underlying API runtime based on [WSO2 Enterprise Integrator (WSO2 EI) 6.5.0](https://docs.wso2.com/display/EI650)
-   **API Key Manager**: Performs key generation and key validation functionalities.
-   **API Traffic Manager**: Performs rate limiting of API requests.

For more information on WSO2 API Manager, see the [overview in the WSO2 API Manager 3.0.0 documentation](../../GettingStarted/overview/) and go to the [product page on WSO2 API Manager on the WSO2 website.](https://wso2.com/api-management/)

## What is new in this release

The **WSO2 API Manager 3.0.0** is the **latest** **WSO2 API Manager release** and is the successor of **WSO2 API Manager 2.6.0**. It contains the following new features and enhancements:

### New features

- **[API Monetization](../../Learn/APIMonetization/monetizing-an-api/)**
    
    WSO2 API Manager provides support for API monetization out of the box. Thereby making it possible to integrate with any third-party billing engine using the available pluggable extension points in WSO2 API Manager.

- **[JWT Authentication](../../Learn/APISecurity/Authentication/jwt-token-based-authentication/)**

    JWT Authentication allows users to use self-contained tokens when invoking APIs. When an API is secured using the OAuth2 security scheme, the JWT tokens that are issued for the users from the Developer Portal can be used to invoke APIs.

- **[API Schema Validator](../../Learn/APISecurity/SchemaValidation/json-schema-validator/)**

    WSO2 API Manager allows users to use their Open API definitions and enforce the request and response validations without any additional work (i.e., implementing custom mediations, etc.)

- **[GraphQL API support](../../Learn/DesignAPI/CreateAPI/create-a-graphql-api/)**

    Users can use Schema Definition Language (SDL) schemas to design GraphQL APIs in WSO2 API Manager. Thereby, API Manager users can manage their GraphQL services as APIs.

- **[Bot Detection](../../Learn/APISecurity/ThreatProtection/bot-detection/)**

    The bot detection capability in WSO2 API Manager detects context scanning and internal service scanning. It notifies admin users via email about such threats and potentially problematic API calls, which are carried out by bots and attackers. 

- **[API Product](../../Learn/DesignAPI/CreateAPIProduct/api-product-overview/)**

    API Product allows users to integrate several APIs and expose them as a single product. Thereby helping to package different services in different ways and exposing them as separate products.

- **[API Key](../../Learn/APISecurity/APIKeys/secure-apis-using-api-keys)**

    WSO2 API Manager allowed users to use a self-contained token as the API key. An API Key is the simplest form of app-based security that a user will be able to configure via WSO2 API Manager's Developer Portal (API Store). The Gateway will validate the API Key before allowing the resources to be consumed.

### Improvements to existing features

- **Revamped UIs**

    The Publisher Portal and the Developer Portal have been completely redesigned using ReactJS to enhance the user experience.

- **Search by tags**

    The search function in the Publisher Portal has been improved so that API providers can search using tags.

- **[A new configuration model](../../Reference/ConfigCatalog/)**

    Until WSO2 API Manager 2.6.0, users had to update multiple configuration files to configure the product. This overhead is removed with the new configuration model because now users only have to update a single file (`deployment.toml`).

## What has changed in this release

### Removed features and functionalities

- The previously deprecated Jaggery based APIs.

    - [Jaggery based Publisher APIs](https://docs.wso2.com/display/AM260/Publisher+APIs)

    - [Jaggery based Store APIs](https://docs.wso2.com/display/AM260/Store+APIs)


## Compatible WSO2 product versions

WSO2 API-M 3.0.0 is based on WSO2 Carbon 4.5.1 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.5.x version, except when using [WSO2 Identity Server as a Key Manager](../../InstallAndSetup/DeployingWSO2APIManager/ThirdPartyKeyManager/configuring-wso2-identity-server-as-a-key-manager/), you need to specifically use WSO2 Identity Server 5.9.0 when working with WSO2 API-M 3.0.0. If you get any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For information on the third-party software required with API-M 3.0.0, see [Installation Prerequisites](../../InstallAndSetup/InstallationGuide/installation-prerequisites/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

## Fixed issues

-   [WSO2 API Manager 3.0.0 - Fixed Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aclosed+closed%3A2018-09-16..2019-10-24)
-   [WSO2 API Manager 3.0.0 - Fixed Issues in the carbon-apim GitHub repository](https://github.com/wso2/carbon-apimgt/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aclosed+closed%3A2018-09-16..2019-10-24+)
-   [WSO2 API Manager 3.0.0 - Fixed Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aclosed+closed%3A2018-09-16..2019-10-24)

## Known issues

-   [WSO2 API Manager 3.0.0 - Known Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+label%3A3.0.0+)
-   [WSO2 API Manager 3.0.0 - Known Issues in the carbon-apim GitHub repository](https://github.com/wso2/product-apim/issues?utf8=%E2%9C%93&q=is%3Aopen+is%3Aissue+label%3A3.0.0+)
-   [WSO2 API Manager 3.0.0 - Known Issues in the analytics-apim GitHub repository](https://github.com/wso2/analytics-apim/issues?q=is%3Aopen+is%3Aissue)

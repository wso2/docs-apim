# About this Release

WSO2 API Manager is a platform for creating, managing, consuming, and monitoring APIs. It employs proven SOA best practices to solve a wide range of API management challenges such as API provisioning, API governance, API security, and API monitoring. It combines some of the most powerful and mature components of the WSO2's state-of-the-art Carbon platform to deliver a smooth and end-to-end API management experience while catering to both API publisher and API consumer requirements.

WSO2 API Manager comprises of the following modules:

- **API Publisher**: Allows API creators to design, implement, and document APIs and allows API product managers to manage the lifecycle of APIs and create API products by using one or more APIs.

- **Developer Portal**: A portal for onboarding application creators. It allows application creators to discover, subscribe, test and consume APIs through their applications.

- **API Gateway**: Allows access to APIs/services by routing application traffic to the relevant endpoints. The API Gateway is the component that enforces security, rate-limiting and transformations on API requests while feeding valuable information of these requests to API Analytics.

- **Key Manager**: The security token service of the API Manager which is responsible for handling everything related to authentication and authorization of API requests. It supports a wide variety of security protocols such as OAuth2.0/OIDC, Basic Auth, API Key, SAML based single-sign-on.

- **Traffic Manager**: Controls the traffic flow of the API gateway. This is used to apply request quotas on APIs for monetization, access control or security-related matters. In addition to configuring the available policies, users can deploy their own policies on the traffic manager which will control the rate of traffic on the API gateways.

- **API Analytics**: Monitors all traffic that's routed through the API gateways to analyze usage patterns, SLA violations, consumer behaviors, to provide business insights and so on.


For more information on WSO2 API Manager, see the [overview in the WSO2 API Manager 4.0.0 documentation]({{base_path}}/getting-started/overview/) and go to the [product page on WSO2 API Manager on the WSO2 website.](https://wso2.com/api-management/)

## What is new in this release

The **WSO2 API Manager 4.0.0-M1** is the **latest** **WSO2 API Manager release** and is the successor of **WSO2 API Manager 3.2.0**. It contains the following new features and enhancements:

### WSO2 API-M related new features

- **[Synchronizing Throttle Policies within Traffic Manager nodes]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup/#step-62-configure-and-start-the-traffic-manager)**

- **[Configuring PingFederate as KeyManager]({{base_path}}/administer/key-managers/configure-pingfederate-connector/)**

- **[Configuring Auth0 as KeyManager]({{base_path}}/administer/key-managers/configure-auth0-connector/)**

- **[Downloading Postman collection for OpenAPI or GraphQL Schema]({{base_path}}/consume-api/invoke-apis/invoke-apis-using-tools/try-out-using-postman/)**

## What has changed in this release
### Improvements to existing WSO2 API-M features

- **[Changing Default Token Expiry Time in Developer Portal]({{base_path}}/learn/consume-api/manage-application/generate-keys/obtain-access-token/changing-the-default-token-expiration-time/)**

- **Role-based scope validation for WSO2 IS connector**

- **API UUID migration from Registry to AM_API table in APIM database**

### Deprecated features and functionalities

### Removed features and functionalities

## Compatible WSO2 product versions

WSO2 API-M 4.0.0-M1 is based on WSO2 Carbon 4.6.1 and is expected to be compatible with any of the WSO2 products that are based on any Carbon 4.6.x version, except when using [WSO2 Identity Server as a Key Manager]({{base_path}}/install-and-setup/setup/distributed-deployment/configuring-wso2-identity-server-as-a-key-manager/), you need to specifically use WSO2 Identity Server 5.11.0 when working with WSO2 API-M 4.0.0-M1. If you get any compatibility issues, please [contact team WSO2](http://wso2.com/support/). For information on the third-party software required with API-M 4.0.0-M1, see [Installation Prerequisites]({{base_path}}/install-and-setup/installation-guide/installation-prerequisites/). For more information on the products in each Carbon platform release, see the [Release Matrix](http://wso2.com/products/carbon/release-matrix/).

## Fixed issues

-   [WSO2 API Manager 4.0.0-M1 - Fixed Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/milestone/84?closed=1)

## Known issues

-   [WSO2 API Manager 4.0.0-M1 - Known Issues in the product-apim GitHub repository](https://github.com/wso2/product-apim/issues)
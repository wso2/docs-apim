# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.3.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.2.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New features

??? note "API level policy support for API Manager"

    This feature enhances the functionality of the existing system by supporting multiple policies at both the operation and API levels as opposed to just attaching a single policy for the whole API. Additionally, it introduces the capability to set the order of these policies, ensuring precise control over their execution. In cases where both operation-level and API-level policies are applied, the API-level policies take precedence, providing a hierarchical approach to policy management.

??? note "Gateway Specific Global Level Policies"

    In WSO2 API Manager, managing Global Level Policies within the gateway infrastructure is made easier. This streamlines policy handling, eliminating the need for administrators to manually create XML-type policy files. This feature facilitates a user-friendly approach to handling policies, eliminates the requirement for manual XML creation and placement in specific directories, and enhances control by providing a clear interface for creating, deploying, and undeploying policies, offering administrators better control over policy management.

??? note "Role based access control for Admin Portal"

    This feature enables administrators to restrict access to specific sections within the admin portal based on predefined scopes.

??? note "Improved revision descriptions display for API revisions"

    This feature provides an improved revision description display in API Publisher portal.

??? note "Support defining a custom API-Key header name at API level"

    This feature aims to introduce functionality that allows users to utilize custom header names for the API-Key header.  

??? note "Key Manager visibility support in Developer portal"

    Using this feature, access to Key Managers can be restricted based on user roles from the admin portal.

??? note "Versioning support for API Products"

    This feature entails the addition of versioning support for API Products, enabling users to manage different versions of their API offerings more effectively.

??? note "Application level policies with burst control support"

    This feature involves the implementation of application-level burst control by incorporating burst control configurations into application policies. With this functionality, users can define specific burst control settings at the application level, enabling them to manage and regulate the rate at which requests are allowed to burst through the system.

??? note "Distributed backend throttling mechanism, a shared counter-based algorithm to efficiently manage API traffic"

    This feature helps to improve synchronization frequency during distributed backend throttling and minimize slippage, ensuring better accuracy, especially in critical high-load use cases.

??? note "Approval workflow for deploying a revision"

    With the revision deployment workflow enabled, revisions transition into a pending state, awaiting approval from an admin before deployment. This process ensures that admins can review and approve revisions before they are deployed to gateways, enhancing governance, and enabling better management of API changes. 

??? note "JWKS endpoint support, enabling seamless validation of backend access tokens send by API gateway"

    Backend JWTs can be signed with RSA to ensure their validity when being sent between 2 parties. To verify the JWT on the backend, we need the public certificate of the private key used to sign the JWT at the Gateway. The JWKS endpoint is a way to get this public certificate.

??? note "Enhanced API tiles to support optional properties like business-related information"

    This feature enhances API tiles by adding support for optional properties such as business-related information and monetization status. With this enhancement, users have the flexibility to include additional details relevant to their specific business context directly within the API tiles.

??? note "Support configuring resource attributes for OpenTelemetry connection"

    OpenTelemetry provides a standardized framework for tracing requests as they traverse across distributed systems. With this integration, users can leverage environment-specific attributes such as deployment environment and service name through `OTEL_RESOURCE_ATTRIBUTES`. This allows for more granular control over tracing configurations, enabling users to tailor tracing behavior according to their specific deployment environments and service contexts within WSO2 API Manager.

??? note "Removal of token persistence"

    This feature enhances token management by eliminating the persistence of tokens in the database. In large-scale deployments, the persistence layer can become a bottleneck, leading to decreased throughput (TPS) for token generation. This reduction in TPS can significantly impair the overall performance of the deployment. This optimization enhances the scalability and performance of WSO2 API Manager deployments, ensuring efficient token management even under heavy loads.

??? note "Allow empty spaces for API names"

    With this feature, it is possible to define API names with spaces. This was not possible in previous versions.

??? note "OpenAPI 3.1.0 support"

    WSO2 API Manager supports the latest version of the Open API Specification, which is OpenAPI 3.1.0. This allows the developers to create more standardized, well-documented APIs, streamlining the API development process and enhancing the overall developer experience.

??? note "Allow changing the owner of an API"

    This feature allows users to transfer ownership of their API to another user within the same organization. Upon transfer, the new owner gains permissions to delete or edit the API as needed, ensuring seamless management and continuity within the organization.

??? note "Configurable Crypto Provider support"

    APIM supports the configuration of crypto provider to either Bouncy Castle (default) or Bouncy Castle FIPS which is a crypto provider and depdencies from Bouncy Castle adhering to the FIPS 140-2 compliance.

??? note "Global Key Manager support"

    With this feature, a single token generated using the global key manager can be used to invoke cross-tenant APIs without generating a token in that specific tenant's key manager. This global key manager will be visible in the devportal of all the tenants and this can be used to generate a token which can be used to invoke APIs across tenants. Any third party key manager can be configured as a global key manager.

??? note "AI-powered Marketplace Assistant"

    This feature is designed to assist API consumers in finding the most suitable API for their specific needs given the large number of APIs to choose from.

??? note "AI-powered API Chat for testing APIs using Natural Language"

    This feature is designed to streamline the process of testing APIs for consumers who possess a specific user story or scenario that needs validation. This feature harnesses the power of artificial intelligence to enable users to interact with APIs using natural language, eliminating the need for complex testing frameworks or coding knowledge.

## Compatible WSO2 product versions

- WSO2 API Manager 4.3.0 is compatible with WSO2 Identity Server 6.1.0.
- WSO2 API Manager 4.3.0 is compatible with WSO2 API Platform for Kubernetes (APK) version 1.1.0.

## Fixed issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPIM+closed%3A2023-03-22..2024-03-31)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPICTL+label%3AType%2FBug++closed%3A2023-03-22..2024-03-31+)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)

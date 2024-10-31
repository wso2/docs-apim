# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.3.0** is the successor of **WSO2 API Manager 4.2.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New features

??? note "Integrating WSO2 API Platform with Kubernetes (APK) 1.1.0"

    The WSO2 API Platform for Kubernetes (APK) boasts gateway functionalities, serving as a comprehensive data plane. This permits effortless deployment of lightweight, container-native data plane instances using APK. It harnesses Kubernetes' capabilities to streamline API management, facilitating the creation of scalable, sturdy, and adaptable API ecosystems with reduced overhead. The latest release empowers users to administer the APK data plane via the API Manager 4.3.0 control plane. Additionally, it offers the flexibility to utilize API Manager 4.3.0 as the control plane for managing the APK data plane. Refer the [Setting APK as Gateway in APIM]({{base_path}}/install-and-setup/setup/distributed-deployment/configuring-apim-as-a-gateway/) documentation for more information.

??? note "AI-powered API Chat for testing APIs using Natural Language"

    This feature is designed to simplify API testing for consumers with minimal prior knowledge. This innovative tool allows users to interact and test APIs through natural language, making the exploration and testing process effortless and intuitive.

    **[Learn more]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/test-apis-with-apichat)**

??? note "AI-powered API Marketplace Assistant"

    Enhance your API discovery process through intuitive natural language conversations, harnessing AI to receive personalized recommendations. This approach ensures you swiftly and accurately identify the most appropriate API, optimizing your search process for efficiency and effectiveness.

    **[Learn more]({{base_path}}/consume/discover-apis/marketplace-assistant)**

??? note "Ephemeral Access Tokens Support"

    This feature enhances token management by eliminating the persistence of tokens in the database. In large-scale deployments, the persistence layer can become a bottleneck, leading to decreased throughput (TPS) for token generation. This reduction in TPS can significantly impair the overall performance of the deployment. This optimization enhances the scalability and performance of WSO2 API Manager deployments, ensuring efficient token management even under heavy loads.

    **[Learn more]({{base_path}}/consume/token-management/token-persistence)**

??? note "Versioning support for API Products"

    The API product feature enables the creation of a marketable API product by combining different resources from multiple APIs. The new feature includes the addition of versioning support for these API products, allowing users to more effectively manage and maintain various versions of their API offerings.

??? note "OpenAPI 3.1.0 support"

    WSO2 API Manager supports the latest version of the Open API Specification, which is OpenAPI 3.1.0. This allows the developers to create more standardized, well-documented APIs, streamlining the API development process and enhancing the overall developer experience.

??? note "Advanced Runtime Diagnostics"

    A cutting-edge diagnostic tool, now available, offers deep insights into the API gateway runtime, identifying and resolving issues with unprecedented ease and efficiency.

    **[Learn more]({{base_path}}/troubleshooting/utilizing-runtime-diagnostic-tool)**

??? note "API level policy support for API Manager"

    This feature enhances the functionality of the existing system by supporting multiple policies at both the operation and API levels as opposed to just attaching a single policy for the whole API. Additionally, it introduces the capability to set the order of these policies, ensuring precise control over their execution. In cases where both operation-level and API-level policies are applied, the API-level policies take precedence, providing a hierarchical approach to policy management.

    **[Learn more]({{base_path}}/design/api-policies/overview)**

??? note "Gateway Specific Global Level Policies"

    In WSO2 API Manager, managing Global Level Policies within the gateway infrastructure is made easier. This streamlines policy handling, eliminating the need for administrators to manually create XML-type policy files. This feature facilitates a user-friendly approach to handling policies, eliminates the requirement for manual XML creation and placement in specific directories, and enhances control by providing a clear interface for creating, deploying, and undeploying policies, offering administrators better control over policy management.
    
    **[Learn more]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/gateway-policies)**

??? note "Support Azure AD as a third-party Key Manager"

    WSO2 API Manager, known for its robust support for multiple key manager integrations, has further expanded its capabilities in the latest release. Now, it allows for the seamless configuration of Azure Active Directory (AzureAD) as a third-party Key Manager. This enhancement not only broadens the scope of external key manager support but also leverages AzureAD's comprehensive security and identity management features.

    **[Learn more]({{base_path}}/administer/key-managers/configure-azure-ad-key-manager)**

??? note "Role based access control for Admin Portal"

    The API Manager admin portal caters to various administrative roles, such as workflow administrators, policy administrators, and those managing key management features. A new functionality within the portal allows for the assignment of access levels to different sections, tailored to specific administrative scopes. Consequently, multiple administrators can be designated within the application, each with permissions to manage only the tasks pertinent to their specific roles, ensuring role-focused efficiency and security.

    **[Learn more]({{base_path}}/administer/role-based-access-control)**

??? note "Key Manager visibility support in Developer portal"

    Organizations often deploy multiple key management servers tailored to their specific use cases. When users create an application and generate access tokens, they are typically given the freedom to select their preferred key manager. However, it may be necessary to limit access to certain key management servers depending on the user's role. This functionality allows for the restriction of key manager access directly from the admin portal, with permissions set according to the user roles, ensuring appropriate access control and security measures are in place.

    **[Learn more]({{base_path}}/administer/key-managers/overview/#role-based-key-manager-restriction)**

??? note "Approval workflow for deploying a revision"

    With the revision deployment workflow enabled, revisions transition into a pending state, awaiting approval from an admin before deployment. This process ensures that admins can review and approve revisions before they are deployed to gateways, enhancing governance, and enabling better management of API changes. 

    **[Learn more]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/revision-deployment-workflow)**

??? note "Enhanced API tiles to support optional properties like business-related information"

    This feature enhances API tiles by adding support for optional properties such as business-related information and monetization status. With this enhancement, users have the flexibility to include additional details relevant to their specific business context directly within the API tiles.

    **[Learn more]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api)**

??? note "Application level policies with burst control support"

    This feature involves the implementation of application-level burst control by incorporating burst control configurations into application policies. With this functionality, users can define specific burst control settings at the application level, enabling them to manage and regulate the rate at which requests are allowed to burst through the system.

    **[Learn more]({{base_path}}/design/rate-limiting/setting-throttling-limits/#burst-control_1)**

??? note "Distributed backend throttling mechanism, a shared counter-based algorithm to efficiently manage API traffic"

    The backend rate limit feature is designed to safeguard backend systems from unexpected surges in API call bursts. For organizations utilizing multiple gateways within a cluster, managing this rate limiting becomes complex as the count needs to be consistent across all nodes, ensuring the backend does not exceed the specified limit. This feature enhances the synchronization process during distributed backend throttling, reducing discrepancies and improving precision in maintaining the defined rate limits.

    **[Learn more]({{base_path}}/design/rate-limiting/advanced-topics/configuring-rate-limiting-api-gateway-cluster/#2-async-sync-hybrid-mode)**

??? note "JWKS endpoint support, enabling seamless validation of backend access tokens send by API gateway"

    Backend JWTs can be signed with RSA to ensure their validity when being sent between 2 parties. To verify the JWT on the backend, we need the public certificate of the private key used to sign the JWT at the Gateway. The JWKS endpoint is a way to get this public certificate.

    **[Learn more]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway/#validating-backend-jwt-using-jwks-endpoint)**

??? note "Support configuring resource attributes for OpenTelemetry connection"

    OpenTelemetry provides a standardized framework for tracing requests as they traverse across distributed systems. With this integration, users can leverage environment-specific attributes such as deployment environment and service name through OTEL_RESOURCE_ATTRIBUTES. This allows for more granular control over tracing configurations, enabling users to tailor tracing behavior according to their specific deployment environments and service contexts within WSO2 API Manager.

    **[Learn more]({{base_path}}/observe/api-manager/traces/monitoring-with-opentelemetry)**

??? note "Configurable Crypto Provider support"

    APIM allows users to configure their cryptographic provider, offering a choice between the default Bouncy Castle and Bouncy Castle FIPS, the latter being in compliance with FIPS 140-2 standards. This enhancement ensures that WSO2 API Manager users can achieve FIPS compliance in their deployments, enhancing the security and compliance of their cryptographic operations.

    **[Learn more]({{base_path}}/install-and-setup/setup/advance-configurations/configuring-the-crypto-provider)**

??? note "Global Key Manager support"

    With this feature, a single token generated using the global key manager can be used to invoke cross-tenant APIs without generating a token in that specific tenant's key manager. This global key manager will be visible in the devportal of all the tenants and this can be used to generate a token which can be used to invoke APIs across tenants. Any third party key manager can be configured as a global key manager.

    **[Learn more]({{base_path}}/administer/key-managers/configure-global-key-manager)**

??? note "Improved revision descriptions display for API revisions"

    The API revision feature enables the creation and management of multiple versions of the same API, allowing for selective deployment to different gateways. Users benefit from the capability to easily revert to previous versions if necessary, effectively using these revisions as restore points for their APIs. A notable enhancement to this feature is the addition of revision descriptions, which are displayed within the API Publisher portal, providing detailed context about each specific revision.

??? note "Allow changing the owner of an API"

    This feature allows users to transfer ownership of their API to another user within the same organization. Upon transfer, the new owner gains permissions to delete or edit the API as needed, ensuring seamless management and continuity within the organization.

    **[Learn more]({{base_path}}/consume/manage-application/advanced-topics/changing-the-provider-of-an-api)**

??? note "Support defining a custom API-Key header name at API level"

    This feature aims to introduce functionality that allows users to utilize custom header names for the API-Key header.

    **[Learn more]({{base_path}}/includes/design/create-publish-api)**  

## Deprecated features and functionalities

These features are deprecated and will be removed from subsequent versions of WSO2 API Manager.

- **SSE Streaming API support**

    The support for creating and using Server Sent Events (SSE) Streaming APIs will be deprecated from APIM 4.3.0.

## Removed features and functionalities

These features are unsupported and removed from WSO2 API Manager 4.3.0 onwards.

- **Choreo Connect**

    In previous releases, Choreo Connect was used as a cloud-native, decentralized, lightweight API Gateway designed especially for microservices. This is no longer supported from APIM 4.3.0 onwards. The recommendation is to use WSO2 API Platform for Kubernetes ([APK](https://wso2.com/api-platform-for-k8s/)).

## Compatible WSO2 product versions

- WSO2 API Manager 4.3.0 is compatible with WSO2 Identity Server 6.1.0.
- WSO2 API Manager 4.3.0 is compatible with WSO2 API Platform for Kubernetes ([APK](https://wso2.com/api-platform-for-k8s/)) version 1.1.0.

## Fixed issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPIM+closed%3A2023-03-22..2024-04-10)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPICTL+label%3AType%2FBug++closed%3A2023-03-22..2024-04-10)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)

# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems. It also serves streaming-based integrations. The product comes with command-line tools and developer tooling that enable easy design, development, and testing.

**WSO2 API Manager 4.4.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.3.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New features

??? note "Egress API Management Capability with support for AI/LLMs"

    This release of API Manager introduces the capability to integrate AI services and large language models (LLMs) with APIs. It offers token-based rate limits and flexible business plans, making it simpler to manage. You also get detailed analytics on token usage, request counts, and performance, helping you make smart business decisions around AI models and vendors. With full API lifecycle management, you have complete control over your AI APIs. Plus, the optimized API gateways are designed to handle AI services efficiently, boosting overall performance.

    **[Learn more]({{base_path}}/design/create-api/create-ai-api/create-an-ai-api/)**

??? note "WSO2 Identity Server 7.0 Authorization Server Support"

    Integration with WSO2 Identity Server 7.x as an authorization server (key manager) is now supported, providing a unified key management solution for your API management requirements.

    **[Learn more]({{base_path}}/administer/key-managers/configure-wso2is7-connector/)**

??? note "Support for Consuming APIs without Subscriptions"

    API Manager now has the capability to disable the subscription requirement for consuming APIs. This simplifies the user experience by allowing users to avoid subscription approval and application creation processes.

    **[Learn more]({{base_path}}/design/advanced-topics/disable-subscriptions-for-an-api/)**

??? note "API Microgateway / Immutable Gateway Support with APIM 4.x"

    API Manager 4.4.0 and other members of the 4.x family can now be seamlessly integrated with the WSO2 Microgateway 3.2.0 allowing users to choose the most suitable gateway solution for their needs.

??? note "Dynamic API Flow Orchestration Support"

    This feature lets developers easily manage messages, connect multiple services, and gather responses right within the API Gateway. With Synapse sequences as endpoints, you can route requests, add custom business logic, and orchestrate multiple services seamlessly, all without changing your backend APIs. It’s a straightforward way to handle complex API workflows and integrations.

    **[Learn more]({{base_path}}/tutorials/create-and-publish-a-sequencebackend-api/)**

??? note "Enhanced Security with Client-Side mTLS Authentication"

    This feature boosts security with customized mTLS settings tailored for different environments, ensuring stronger protection. It also supports compliance by allowing environment-specific security configurations to meet various regulatory requirements. API consumers benefit from the flexibility to use different mTLS settings for production and sandbox environments without causing conflicts

??? note "Business Plan Updates for Existing Subscriptions"

    This approach offers flexibility to the users by allowing changes to business plans through API calls without requiring customers to unsubscribe and resubscribe.

??? note "Application Level Throttle Policy Reset Support"

    The latest version of API Manager introduces the capability to reset the Application level rate limiting policies once the throttling limit has been exceeded. With this, you no longer have to wait until the next access time if your API got throttled due to request spikes or unintended requests.

    **[Learn more]({{base_path}}/design/rate-limiting/resetting-application-throttling-policies/)**

??? note "Subscription Approval Support from API Publisher Portal"

    The latest version of API Manager allows API product managers more control by letting them directly manage and approve subscription requests

??? note "Audience Validation Support for JWTs"

    This feature improves the API security by introducing an extra level of validation to the JWTs. This approach is particularly useful when you need to restrict the API access to a particular audience when APIs are shared among multiple clients or services.

    **[Learn more]({{base_path}}/design/api-security/oauth2/access-token-types/jwt-tokens/#audience-validation)**

??? note "Enhanced Content Search Support"

    The latest version of API Manager expands its content search capabilities by allowing the users to search within the OpenAPI/Swagger, GraphQL schema, AsyncAPI, and WSDL definitions of the APIs.

??? note "Multi DC Replication Support for PostgreSQL"

    API Manager has database replication support with Oracle and SQL Server. With the introduction of support to PostgreSQL in the latest version, users have more options to deploy API Manager in multiple data centers with database replication.

??? note "Filtering Support for Denylist Throttling Policies"

    This feature allows users to filter denylist throttling policies through the REST APIs.

## Deprecated Features and Functionalities

These features are deprecated and will be removed from subsequent versions of WSO2 API Manager.

## Removed Features and Functionalities

These features are unsupported and removed from WSO2 API Manager 4.4.0 onwards.

## Key Changes

- With WSO2 API Manager 4.5.0, we introduce a Modular API Management Component Structure allowing independent deployment and lifecycle management of key components while maintaining compatibility across these different components. With this capability, users can update or upgrade different components as per their requirement without impacting the entire deployment. The components include,
    1. The WSO2 API Control Plane (ACP) equivalent to the Control Plane (CP) in previous APIM releases without the traffic manager component, which manages the design, lifecycle, and governance of APIs at scale and consists of the Publisher, Developer Portal, Admin Portal and the Key management capabilities,
    2. The WSO2 Universal Gateway which can secure and proxy API traffic with enterprise-grade features,
    3. The Traffic Manager which handles API traffic policies and rate limiting at high volumes,
    4. Other supporting components such as the WSO2 Kubernetes Gateway, API Controller and Immutable Gateway.

- Product profiles are no longer available in the All-in-one distribution of WSO2 API Manager. Previously the API-M server allowed you to run the product on a selected profile so that only the features specific to that profile, along with common features, started with the server. Therefore if there is a requirement to configure a distributed deployment of WSO2 API Manager, you can use the Modular component architecture as mentioned above. The following table shows the component distributions you can use as a deployment alternative to the previous deployment architecture of your environment.

<table>
    <colgroup>
        <col />
        <col />
        <col />
        <col />
        <col />
        <col />
    </colgroup>
    <thead>
        <tr>
            <th>Previous Deployment Pattern</th>
            <th colspan="5">New Deployment Alternative</th>
        </tr>
        <tr>
            <th></th>
            <th>All-in-one</th>
            <th>API Control Plane (ACP)</th>
            <th>Universal Gateway</th>
            <th>Traffic Manager</th>
            <th>Key Manager of ACP</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>All-in-one</td>
            <td style="text-align: center;">&#x2713;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Control Plane + Gateway</td>
            <td style="text-align: center;">&#x2713;</td>
            <td></td>
            <td style="text-align: center;">&#x2713;</td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Control Plane + Gateway + Traffic Manager</td>
            <td></td>
            <td style="text-align: center;">&#x2713;</td>
            <td style="text-align: center;">&#x2713;</td>
            <td style="text-align: center;">&#x2713;</td>
            <td></td>
        </tr>
        <tr>
            <td>Control Plane + Gateway + Key Manager</td>
            <td style="text-align: center;">&#x2713;</td>
            <td></td>
            <td style="text-align: center;">&#x2713;</td>
            <td></td>
            <td style="text-align: center;">&#x2713;</td>
        </tr>
        <tr>
            <td>Control Plane + Gateway + Traffic Manager + Key Manager</td>
            <td></td>
            <td style="text-align: center;">&#x2713;</td>
            <td style="text-align: center;">&#x2713;</td>
            <td style="text-align: center;">&#x2713;</td>
            <td style="text-align: center;">&#x2713;</td>
        </tr>
    </tbody>
</table>

## Compatible WSO2 product versions

{!includes/compatibility-matrix.md!}

## Fixed issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPIM+closed%3A2024-04-11..2024-10-30+)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPICTL+label%3AType%2FBug++closed%3A2024-04-11..2024-10-30+)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)

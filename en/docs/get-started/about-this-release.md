# About this Release

WSO2 API Manager is a complete platform for building, integrating, and exposing your digital services as managed APIs in the cloud, on-premise, and hybrid architectures to drive your digital transformation strategy. It comes with a cloud-native, standards-based messaging engine, and an integration framework for integrating APIs, services, data, SaaS, proprietary, and legacy systems and it can also serve streaming-based integrations. The product comes with command-line and developer tools that enable easy design, development, and testing.

**WSO2 API Manager 4.5.0** is the latest **WSO2 API Manager release** and is the successor of **WSO2 API Manager 4.4.0**.

For more information on WSO2 API Manager, see the [overview]({{base_path}}/getting-started/overview/).

## Downloads

<a href="https://wso2.com/api-manager/#"><img src="{{base_path}}/assets/img/get_started/download-apim.png" title="Download WSO2 API Manager" width="25%" alt="Download WSO2 API Manager"/></a>

## New features

??? note "API Governance"

    API Management Governance enables organizations to effectively govern APIs throughout their lifecycle, ensuring compliance with standards for API standardization, security, and consistency. This capability fosters a more robust, secure, and well-managed API ecosystem, enhancing overall operational efficiency and reliability.

    **[Learn more]({{base_path}}/governance/overview/)**

??? note "Gateway Federation And Multi-Gateway Management"

    With the gateway federation feature, API developers can create APIs to be deployed in third party gateways via WSO2 APIM control plane. With the 4.5.0 release we have added OOTB support to deploy APIs into AWS API gateway.

    **[Learn more]({{base_path}}/deploy-and-publish/deploy-on-gateway/federated-gateways/deploy-on-aws-api-gateway/)**

??? note "Multi-Model Routing Support for AI APIs"

    The Multi-Model Routing feature allows seamless switching of AI API requests between multiple models within the same provider. API creators can define routing strategies using our built-in AI API policies, which support round-robin and failover-based routing.

    **[Learn more]({{base_path}}/ai-gateway/multi-model-routing/overview/)**

??? note "Generative AI Powered Design Assistant"

    API Manager enables chat-based API creation through the AI-powered API Design Assistant. This tool requires minimal coding or API expertise, allowing users to design REST, GraphQL, and Async APIs effortlessly. It streamlines API development by reducing manual effort and providing interactive guidance, making it suitable for both technical and non-technical users.

    **[Learn more]({{base_path}}/design/create-api/create-api-with-ai/)**

??? note "B2B API Management with Organization Support"

    B2B API management addresses the need for controlled API access across diverse organizations by implementing role-based access, hierarchical structures, and organization-specific policies, ultimately enhancing security, simplifying management, and improving visibility for various business stakeholders.

    **[Learn more]({{base_path}}/design/b2b-api-management/api-consumption/)**

## Improvements

??? note "Simplified GraphQL API Creation with Schema Introspection & URL Import"

    WSO2 API Manager now makes it easier to create GraphQL APIs by allowing users to automatically deduce schemas from an existing API endpoint using GraphQL introspection. Additionally, users can import schema definitions directly via a URL, alongside the existing file-based import method. These enhancements streamline the GraphQL API onboarding process, reducing manual effort and improving efficiency.

    **[Learn more]({{base_path}}/design/create-api/create-graphql-api/create-a-graphql-api-using-introspection/)**

??? note "Granular Access Control for Gateway Environments"

    WSO2 API Manager now enables role-based access control for API gateway environments, allowing organizations to restrict API deployment to specific gateways based on user roles. This feature enhances security and governance, ensuring that only authorized users can deploy APIs to designated gateway environments. This enhancement also provides security, and operational efficiency by aligning API deployments with organizational policies and compliance requirements.

    **[Learn more]({{base_path}}/administer/multiple-gateways/configure-gateway-visibility/)**

??? note "Enhanced WebSocket Logging for Improved Monitoring & Troubleshooting"

    WSO2 API Manager now supports comprehensive WebSocket API logging, enabling users to monitor real-time WebSocket invocations and efficiently debug or troubleshoot issues. With this enhancement, organizations gain deeper insights into API usage patterns, connection health, and potential failures, ensuring better visibility and faster issue resolution. These logs can be enabled using multiple configurations, offering flexibility and control over WebSocket monitoring within WSO2 API Manager.

    **[Learn more]({{base_path}}/observe/api-manager/monitoring-websocket-logs/)**

??? note "Enhanced Audit Logging for API Document Management"

    WSO2 API Manager now provides improved audit logging by capturing actions related to adding, removing, or updating documents attached to an API. Previously, these actions were only recorded in access logs, but with this enhancement, organizations can maintain better traceability and governance over API documentation changes. This ensures greater security, compliance, and visibility into API lifecycle activities.

    **[Learn more]({{base_path}}/observe/api-manager/monitoring-audit-logs/)**

??? note "Improved Proxy Support for OAuth Endpoints"

    WSO2 API Manager now extends its OAuth token retrieval capabilities to support invocation through a configured proxy server. This enhancement ensures seamless authentication for OAuth-protected APIs in environments where outbound API traffic is routed through proxies. By enabling secure token retrieval via proxy, organizations can maintain better security, compliance, and network control without impacting API functionality.

    **[Learn more]({{base_path}}/design/endpoints/endpoint-security/oauth-2.0/#securing-an-endpoint-with-oauth-20-in-wso2-api-manager)**

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

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+is%3Aclosed+label%3AComponent%2FAPIM+closed%3A2024-10-31..2025-03-07)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue%20is%3Aclosed%20label%3AComponent%2FAPICTL%20closed%3A2024-10-31..2025-03-10%20)

## Known issues

- [API Manager](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPIM+is%3Aopen)
- [API Controller](https://github.com/wso2/api-manager/issues?q=is%3Aissue+label%3AComponent%2FAPICTL+is%3Aopen)

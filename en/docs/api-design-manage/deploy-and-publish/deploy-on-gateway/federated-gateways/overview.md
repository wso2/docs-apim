# Federated Gateways Overview

WSO2 API Manager supports deploying APIs to external third-party API Gateways, enabling a federated API gateway architecture. This approach separates the control plane from the runtime gateways, allowing centralized API governance while enabling APIs to run closer to users or services for improved performance and resilience.

## What is a Federated Gateway?

A federated gateway is an external API gateway that operates independently but is managed centrally through WSO2 API Manager. In this architecture:

- **Central API Management**: WSO2 API Manager serves as the control plane where you define, version, secure, and monitor your APIs.
- **Distributed API Gateways**: APIs are deployed to multiple runtime gateways across different environments such as cloud platforms (AWS, Azure), on-premises systems, or Kubernetes clusters.

This architectural pattern enables organizations to:

- **Improve Performance**: Route API traffic to the nearest or most optimal gateway, reducing latency.
- **Enhance Resilience**: Isolate failures so that issues in one gateway don't affect others.
- **Maintain Governance**: Enforce policies and lifecycle management centrally across all federated gateways.
- **Enable Cloud Flexibility**: Deploy APIs across AWS, Azure, on-premises, or in hybrid/multi-cloud environments.

## Supported Gateway Types

WSO2 API Manager provides built-in support for deploying APIs to the following federated gateways:

### AWS API Gateway
Deploy and manage APIs on Amazon Web Services API Gateway. WSO2 API Manager comes prepackaged with an AWS gateway connector that enables seamless deployment and management of APIs on AWS infrastructure.

**Key Features:**
- Deploy APIs to AWS API Gateway
- Discover existing APIs from AWS API Gateway
- OAuth 2.0 security via Lambda Authorizer
- Centralized management through WSO2 API Manager

[Learn more about AWS API Gateway deployment]({{base_path}}/api-design-manage/deploy-and-publish/federated-gateways/aws/deploy-on-aws-api-gateway/)

### Azure API Gateway
Deploy and manage APIs on Microsoft Azure API Management Service. The built-in Azure gateway connector facilitates deployment and discovery of APIs on Azure infrastructure.

**Key Features:**
- Deploy APIs to Azure API Management
- Discover existing APIs from Azure API Gateway
- Integration with Microsoft Entra ID
- Centralized governance from WSO2 API Manager

[Learn more about Azure API Gateway deployment]({{base_path}}/deploy-and-publish/federated-gateways/azure/deploy-on-azure-api-gateway/)

### Kong Gateway
Discover and manage APIs deployed on Kong Gateway. WSO2 API Manager supports both Kong Kubernetes and Kong Standalone deployments.

**Key Features:**
- Discover APIs from Kong Dev Portal
- Discover gateway services deployed in Kong
- Support for Kong Kubernetes and Standalone modes
- Unified management through WSO2 API Manager Control Plane

[Learn more about Kong Gateway integration]({{base_path}}/api-design-manage/deploy-and-publish/federated-gateways/kong/kong-standalone/discover-apis-on-kong-gateway/)

### Envoy Gateway
Discover and manage APIs deployed on Envoy Gateway in Kubernetes environments. 

**Key Features:**
- Discover APIs from Envoy Gateway
- Kubernetes-native integration
- Centralized API governance

[Learn more about Envoy Gateway integration]({{base_path}}/api-design-manage/deploy-and-publish/federated-gateways/EnvoyGateway/eg-k8s/discover-apis-on-eg-gateway-in-kubernetes/)

## Gateway Modes

Federated gateways can operate in different modes depending on your requirements:

- **Write-Only Mode**: Deploy and manage APIs from WSO2 API Manager to the federated gateway.
- **Read-Only Mode**: Discover and import existing APIs from the federated gateway into WSO2 API Manager.
- **Read-Write Mode**: Both deploy new APIs and discover existing APIs, providing full bidirectional synchronization.

## Custom Gateway Agents

If you need to integrate with a third-party gateway that is not supported out-of-the-box, WSO2 API Manager provides the flexibility to create custom gateway agents. This allows you to extend the federated gateway capabilities to any external gateway.

[Learn more about configuring custom gateway agents]({{base_path}}/api-design-manage/deploy-and-publish/federated-gateways/configure-custom-gateway-agent/)

## Architecture Benefits

Implementing a federated gateway architecture with WSO2 API Manager provides several key benefits:

1. **Centralized Control**: Manage all APIs from a single control plane regardless of where they are deployed.
2. **Operational Independence**: Teams can operate their own runtime gateways while maintaining centralized governance.
3. **Reduced Latency**: Deploy APIs closer to consumers for better performance.
4. **High Availability**: Distribute API traffic across multiple gateways for improved resilience.
5. **Cloud Agnostic**: Deploy APIs across multiple cloud providers and on-premises infrastructure.
6. **Regulatory Compliance**: Keep data and API traffic within specific geographic regions while maintaining central governance.

## Getting Started

To get started with federated gateways:

1. **Choose Your Gateway**: Select the appropriate federated gateway based on your infrastructure (AWS, Azure, Kong, Envoy, or custom).
2. **Configure Credentials**: Set up the necessary credentials and permissions in your chosen gateway platform.
3. **Register Gateway**: Add the federated gateway as a new gateway environment in the WSO2 API Manager Admin Portal.
4. **Deploy APIs**: Create APIs in the Publisher Portal and deploy them to your federated gateway.
5. **Monitor and Manage**: Use WSO2 API Manager to monitor and manage your APIs across all federated gateways.

## Additional Resources

- [Tutorial: Deploying APIs to AWS API Gateway]({{base_path}}/tutorials/deploying-apis-to-federated-gateways-with-wso2/)
- [WSO2 API Manager Architecture]({{base_path}}/get-started/apim-architecture/)

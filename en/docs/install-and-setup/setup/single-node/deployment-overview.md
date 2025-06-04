# Overview

WSO2 API Manager 4.5.0 introduces a modular component architecture with separate distributions for API Control Plane, Universal Gateway, and Traffic Manager. This document provides an overview of various deployment patterns to help you choose the optimal configuration for deployment on virtual machines (VMs) based on your specific requirements.

## All-in-One Deployment Patterns

### Pattern 0: Single Node Deployment

One all-in-one instance containing all API Manager components (API Control Plane, Gateway, and Traffic Manager).

**Documentation**: [Configuring a Single Node](./configuring-a-single-node.md)


### Pattern 1: Active-Active Deployment

Two all-in-one instances of WSO2 API Manager in active-active configuration providing high availability.

**Documentation**: [Configuring an Active-Active Deployment](./configuring-an-active-active-deployment.md)

## Distributed Deployment Patterns

WSO2 API Manager 4.5.0 offers separate component distributions:

- **WSO2 API Control Plane (ACP)**: Includes Key Manager, Publisher Portal, and Developer Portal
- **WSO2 Universal Gateway**: Handles API traffic and security
- **WSO2 Traffic Manager**: Manages rate limiting decisions

### Pattern 2: Simple Scalable Setup

Separates Gateway from Control Plane for independent scaling of API traffic handling.

**Components**: All-in-One, Universal Gateway  
**Use Case**: Environments with higher API traffic needing gateway scalability  
**Documentation**: [Deploy on VM](../distributed-deployment/)

### Pattern 3: Distributed Deployment with Gateway and Traffic Manager Separated

Recommended pattern for production environments with high traffic that separates all three main components.

**Components**: API Control Plane (ACP), Universal Gateway (GW), Traffic Manager (TM)  
**Use Case**: Production environments with high traffic requiring component-level scalability  
**Documentation**: [Deploy on VM](../distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup.md)

### Pattern 4: Fully Distributed Setup

Extends Pattern 3 by separating the Key Manager component

**Components**: API Control Plane (ACP), Universal Gateway (GW), Traffic Manager (TM), Key Manager (KM)  
**Use Case**: Large-scale production environments with complex security requirements  
**Documentation**: [Deploy on VM]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-km-separated.md)

### Pattern 5: Simple Scalable Setup with Key Manager Separated

Combines Pattern 2 with a separated Key Manager component for enhanced API security.

**Components**: API Control Plane, Universal Gateway, Key Manager  
**Use Case**: Environments focusing on API security with dedicated Key Manager component  
**Documentation**: [Deploy on Kubernetes]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/am-pattern-5-all-in-one-gw-km.md)

## Multi-DC Deployment Patterns

WSO2 API Manager supports multi-datacenter (multi-DC) deployment patterns for global or region-specific deployments.

### Pattern 1: Geo-Regional Synchronized API Management

Full API Management capabilities in each region with synchronized databases.

**Key Features**:
- Multiple complete API-M deployments in different regions
- Database replication for synchronization
- Interconnected control planes via event hubs
- Suitable for environments requiring autonomous operation in each region

**Documentation**: [Configure Multi-DC Deployment - Pattern 1]({{base_path}}/install-and-setup/setup/multi-dc-deployment/configuring-multi-dc-deployment-pattern-1.md)

### Pattern 2: Centralized API Management with Regional Data Planes

Centralizes API management in one region with regional data planes for traffic handling.

**Key Features**:
- One region serves as the central control point (main region)
- Other regions act as data planes (sub regions)
- No database replication required
- Cost-effective solution for multi-region deployments

**Documentation**: [Configure Multi-DC Deployment - Pattern 2]({{base_path}}/install-and-setup/setup/multi-dc-deployment/configuring-multi-dc-deployment-pattern-2.md)

# WSO2 API Manager Deployment Patterns

This directory contains documentation and sample values for deploying WSO2 API Manager in various deployment patterns using Helm charts. Each subdirectory represents a different deployment pattern with specific configuration options and deployment topologies.

## Overview

WSO2 API Manager is a complete solution for designing and publishing APIs, creating and managing a developer community, and for securing and monetizing APIs. It offers various deployment options to suit different organizational needs, from simple all-in-one deployments to complex distributed architectures.

## Available Deployment Patterns

### Pattern 0: All-in-One Single Node
- **Directory**: `am-pattern-0-all-in-one`
- **Description**: Simple deployment with a single API Manager node handling all functionality
- **Use Case**: Development environments or small deployments with low traffic
- **Components**: Single API-M node with all functionality
- **Resources**: [README](am-pattern-0-all-in-one/README.md), [Sample Values](am-pattern-0-all-in-one/default_values.yaml)

### Pattern 1: All-in-One HA (High Availability)
- **Directory**: `am-pattern-1-all-in-one-HA`
- **Description**: High availability deployment with multiple API Manager nodes in active-active configuration
- **Use Case**: Production environments requiring high availability but with moderate traffic
- **Components**: Multiple API-M nodes with all functionality in each node
- **Resources**: [README](am-pattern-1-all-in-one-HA/README.md), [Sample Values 1](am-pattern-1-all-in-one-HA/default_values_1.yaml), [Sample Values 2](am-pattern-1-all-in-one-HA/default_values_2.yaml)

### Pattern 2: All-in-One with Separate Gateway
- **Directory**: `am-pattern-2-all-in-one_GW`
- **Description**: Deployment with separate gateway nodes and a control plane
- **Use Case**: Environments with higher API traffic needing gateway scalability
- **Components**: API Control Plane, Universal Gateways
- **Resources**: [README](am-pattern-2-all-in-one_GW/README.md), [Sample Control Plane Values](am-pattern-2-all-in-one_GW/default_values.yaml), [Sample Gateway Values](am-pattern-2-all-in-one_GW/default_gw_values.yaml)

### Pattern 3: Distributed Deployment with ACP, TM, and GW *(Recommended)*
- **Directory**: `am-pattern-3-ACP_TM_GW`
- **Description**: Distributed deployment with separate API Control Plane, Traffic Manager, and Gateway components
- **Use Case**: Production environments with high traffic needing component-level scalability
- **Components**: API Control Plane (ACP), Traffic Manager (TM), Universal Gateway (GW)
- **Resources**: [README](am-pattern-3-ACP_TM_GW/README.md), [ACP Values](am-pattern-3-ACP_TM_GW/default_acp_values.yaml), [Gateway Values](am-pattern-3-ACP_TM_GW/default_gw_values.yaml), [Traffic Manager Values](am-pattern-3-ACP_TM_GW/default_tm_values.yaml)

### Pattern 4: Fully Distributed Deployment (ACP, TM, GW, KM)
- **Directory**: `am-pattern-4-ACP_TM_GW_KM`
- **Description**: Fully distributed deployment with separate Key Manager component
- **Use Case**: Large-scale production environments with complex security requirements
- **Components**: API Control Plane (ACP), Traffic Manager (TM), Universal Gateway (GW), Key Manager (KM)
- **Resources**: [README](am-pattern-4-ACP_TM_GW_KM/README.md), [ACP Values](am-pattern-4-ACP_TM_GW_KM/default_acp_values.yaml), [Gateway Values](am-pattern-4-ACP_TM_GW_KM/default_gw_values.yaml), [Key Manager Values](am-pattern-4-ACP_TM_GW_KM/default_km_values.yaml), [Traffic Manager Values](am-pattern-4-ACP_TM_GW_KM/default_tm_values.yaml)

### Pattern 5: All-in-One with Separate Gateway and Key Manager
- **Directory**: `am-pattern-5-all-in-one_GW_KM`
- **Description**: Deployment with separate Gateway and Key Manager components
- **Use Case**: Environments focusing on API security with dedicated Key Manager component
- **Components**: API Control Plane, Universal Gateway, Key Manager
- **Resources**: [README](am-pattern-5-all-in-one_GW_KM/README.md), [Control Plane Values](am-pattern-5-all-in-one_GW_KM/default_values.yaml), [Gateway Values](am-pattern-5-all-in-one_GW_KM/default_gw_values.yaml), [Key Manager Values](am-pattern-5-all-in-one_GW_KM/default_km_values.yaml)

## How to Use

Each pattern directory contains:
1. A detailed README.md with deployment instructions
2. Sample values.yaml files for configuring the Helm deployment
3. Documentation on prerequisites and configuration options

### General Steps for Deployment:

1. **Prerequisites**:
   - Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Helm](https://helm.sh/docs/intro/install/), and [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
   - Set up a [Kubernetes cluster](https://kubernetes.io/docs/setup)
   - Install [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)
   - Add the WSO2 Helm chart repository: `helm repo add wso2 https://helm.wso2.com && helm repo update`

2. **Build Docker Images**:
   - Use WSO2 product Docker images from [DockerHub](https://hub.docker.com/u/wso2/) or [WSO2 Private Docker Registry](https://docker.wso2.com/)
   - Include necessary JDBC drivers and customizations in your Docker images

3. **Configuration**:
   - Configure ingress controller
   - Set up databases
   - Configure keystores and truststores
   - Update Helm chart values

4. **Deployment**:
   - Follow the pattern-specific deployment instructions

## Deploy on Kubernetes

The Helm charts include cloud provider-specific configurations for:
- AWS (EKS, EFS, RDS, Secrets Manager)
- Azure (AKS, Azure Files, Azure Database, Key Vault)
- GCP (GKE, GCS, Cloud SQL, Secret Manager)

## Deploy on OpenShift

- **Note:** Default Helm chart configurations are intended for Kubernetes deployment.  
- If you are deploying on OpenShift, additional configurations are required for both Docker images and the deployment process. For comprehensive instructions, refer to the [OpenShift Deployment Guide](openshift_deployment.md).

## Additional Resources

- [WSO2 API Manager Documentation](https://apim.docs.wso2.com/)
- [WSO2 Helm Charts Repository](https://github.com/wso2/helm-apim/)
- [WSO2 Updates](https://wso2.com/updates/)
- [WSO2 Subscription](https://wso2.com/subscription/)

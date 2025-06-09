# Prerequisites

To successfully deploy WSO2 API Manager (WSO2 API-M) in your Kubernetes environment, you'll need a Kubernetes cluster, a Kubernetes client (`kubectl`), and Helm for package management. Additionally, your environment must meet specific requirements across managed Kubernetes services, resource allocations, and supported Kubernetes distributions. Each section below outlines these requirements for a successful deployment.

### Supported Versions
#### Managed Kubernetes Services

WSO2 API-M supports several managed Kubernetes services. To ensure compatibility, verify that your service's Kubernetes version falls within the specified range.

| Platform | Cluster Version |
| -------- | --------------- |
| EKS      | 1.27 - 1.30.3   |
| GKE      | 1.27.3 - 1.30.3 |
| AKS      | 1.27 - 1.30.3   |

#### Kubernetes Distributions

WSO2 API-M is compatible with a variety of Kubernetes distributions. Check the compatible versions for each distribution below to ensure proper functionality.

| Software Application | Cluster Version | Software Version |
| -------------------- | --------------- | ---------------- |
| Minikube             | 1.26.3 - 1.30.3 | 1.30.1 - 1.34.0  |
| Rancher              | 1.27.2 - 1.30.3 | 1.9.1 - 1.16.0   |
| Kind                 | 1.26.3 - 1.30.3 | 0.24.0           |
| OpenShift            | 1.28   - 1.30.3 | 4.15 - 4.15      |

#### Helm

Below is the version requirement for Helm to be compatible with WSO2 API-M.

| Package Manager | Version         |
| --------------- | --------------- |
| Helm            | 3.10.0 - 3.16.1 |

### Resource Requirements

We recommend the following minimum resource requirements for running WSO2 API-M on a Kubernetes cluster. These requirements are based on the deployment pattern you choose. For single node, minimum requirement is 2 cores and 4 GB memory.


### Deployment Patterns

WSO2 API-M offers several deployment patterns for Kubernetes

For detailed instructions on deploying each pattern, refer to their respective documentation:

- [Pattern 0: All-in-One Setup](am-pattern-0-all-in-one.md)
- [Pattern 1: All-in-One HA Setup](am-pattern-1-all-in-one-ha.md)
- [Pattern 2: Simple Scalable Setup](am-pattern-2-all-in-one-gw.md)
- [Pattern 3: Distributed with Gateway and Traffic Manager Separated](am-pattern-3-acp-tm-gw.md)
- [Pattern 4: Fully Distributed Setup](am-pattern-4-acp-tm-gw-km.md)
- [Pattern 5: Simple Scalable with Key Manager Separated](am-pattern-5-all-in-one-gw-km.md)
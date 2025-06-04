# WSO2 API Manager Deployment Overview

WSO2 API Manager consists of an API management layer and an integration layer. The API management layer contains several components, which you can use in your deployment according to your requirement. The integration layer includes either the Micro Integrator runtime (for services integration) and the Streaming Integrator runtime (for streaming requirements) or both runtimes.

You can select one of the following deployment patterns depending on the workload of each component and the traffic that is expected to each of the components and runtimes.

!!! note
    From WSO2 API Manager 4.5.0 onwards, we no longer support API-M profiles such as, `-Dprofile=control-plane`, `-Dprofile=gateway-worker` and `-Dprofile=traffic-manager`. Instead, we now have separate distributions namely, **WSO2 API Control Plane**, **WSO2 Universal Gateway** and **WSO2 Traffic Manager** components which should be used for configuring a distributed deployment. For alternative deployment options, please refer the table below. See more information in [Key Changes]({{base_path}}/get-started/about-this-release/#key-changes).

    ??? info "New Deployment Alternatives"

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

## Deployment Options

### Deploy on VM

The WSO2 API Manager can be deployed on virtual machines (VMs) using the provided product packs. The deployment can be done in various patterns, depending on your requirements.
For comprehensive instructions, refer to the [VM Deployment Guide](../setup/single-node/deployment-overview.md).

### Deploy on Kubernetes

The Helm charts include cloud provider-specific configurations for:

- AWS (EKS, EFS, RDS, Secrets Manager)
- Azure (AKS, Azure Files, Azure Database, Key Vault)
- GCP (GKE, GCS, Cloud SQL, Secret Manager)

For comprehensive instructions, refer to the [K8s Deployment Guide](../setup/kubernetes-deployment/kubernetes/kubernetes-overview.md).

### Deploy on OpenShift

- **Note:** Default Helm chart configurations are intended for Kubernetes deployment.  
- If you are deploying on OpenShift, additional configurations are required for both Docker images and the deployment process. For comprehensive instructions, refer to the [OpenShift Deployment Guide](../setup/kubernetes-deployment/openshift/openshift-deployment-overview.md).

## Available Deployment Patterns

### Pattern 0: API-M Deployment with All-in-One Setup
- **Description**: Simple deployment with a single API Manager node handling all functionality
- **Use Case**: Suitable for development environments or small-scale deployments with low traffic; not recommended for production use.
- **Components**: Single API-M node with all functionality
- **Guides** - [Deploy on VM](../setup/single-node/configuring-a-single-node.md), [Deploy on Kubernetes](../setup/kubernetes-deployment/kubernetes/am-pattern-0-all-in-one.md)

<a href="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/single-node-apim-deployment.png" alt="single-node api-m deployment" width="60%"></a>

### Pattern 1: API-M Deployment with All-in-One HA Setup
- **Description**: High availability deployment with multiple API Manager nodes in active-active configuration
- **Use Case**: Production environments requiring high availability but with moderate traffic
- **Components**: Multiple API-M nodes with all functionality in each node
- **Guides** - [Deploy on VM](../setup/single-node/configuring-an-active-active-deployment.md), [Deploy on Kubernetes](../setup/kubernetes-deployment/kubernetes/am-pattern-1-all-in-one-ha.md)

<a href="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png"><img src="{{base_path}}/assets/img/setup-and-install/active-active-apim-deployment.png" alt="active-active api-m deployment" width="60%"></a>

### Pattern 2: API-M Deployment with Simple Scalable Setup
- **Description**: Deployment with separate gateway nodes and a control plane
- **Use Case**: Environments with higher API traffic needing gateway scalability
- **Components**: API Control Plane, Universal Gateways
- **Guides** - [Deploy on Kubernetes](../setup/kubernetes-deployment/kubernetes/am-pattern-2-all-in-one-gw.md)

<a href="{{base_path}}/assets/img/setup-and-install/deployment-cp-gw.png"><img src="{{base_path}}/assets/img/setup-and-install/deployment-cp-gw.png" alt="simple scalable api-m deployment" width="60%"></a>

### Pattern 3: Distributed API-M Deployment with Gateway and Traffic Manager Separated from the Control Plane *(Recommended)*
- **Description**: Distributed deployment with separate API Control Plane, Traffic Manager, and Gateway components
- **Use Case**: Production environments with high traffic needing component-level scalability
- **Components**: API Control Plane (ACP), Traffic Manager (TM), Universal Gateway (GW)
- **Guides** - [Deploy on VM](../setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup.md), [Deploy on Kubernetes](../setup/kubernetes-deployment/kubernetes/am-pattern-3-acp-tm-gw.md)

<a href="{{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png"><img src="{{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png" alt="simple scalable api-m deployment" width="60%"></a>

### Pattern 4: API-M Deployment with Fully Distributed Setup
- **Description**: Fully distributed deployment with separate Key Manager component
- **Use Case**: Large-scale production environments with complex security requirements
- **Components**: API Control Plane (ACP), Traffic Manager (TM), Universal Gateway (GW), Key Manager (KM)
- **Guides** - [Deploy on VM](../setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-km-separated.md), [Deploy on Kubernetes](../setup/kubernetes-deployment/kubernetes/am-pattern-4-acp-tm-gw-km.md)

<a href="{{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png"><img src="{{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png" alt="fully distributed deployment" width="60%"></a>

### Pattern 5: API-M Deployment with Simple Scalable Setup with Key Manager Separated
- **Description**: Deployment with separate Gateway and Key Manager components
- **Use Case**: Environments focusing on API security with dedicated Key Manager component
- **Components**: API Control Plane, Universal Gateway, Key Manager
- **Guides** - [Deploy on Kubernetes](../setup/kubernetes-deployment/kubernetes/am-pattern-5-all-in-one-gw-km.md)

<a href="{{base_path}}/assets/img/setup-and-install/deployment-cp-gw-km.png"><img src="{{base_path}}/assets/img/setup-and-install/deployment-cp-gw-km.png" alt="Simple Scalable Deployment with Key Manager Seperation" width="100%"></a>

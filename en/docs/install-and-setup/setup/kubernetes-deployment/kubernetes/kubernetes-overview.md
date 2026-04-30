# Deploying WSO2 API Manager on Kubernetes

WSO2 API Manager (WSO2 API-M) can be deployed on Kubernetes using Helm charts, making it easy to manage, scale, and maintain in cloud-native environments.

!!! tip "Just want to try it out?"
    Follow the [Quick Start Guide](kubernetes-quick-start.md) to get WSO2 API Manager running on Kubernetes in minutes with zero configuration.

## Deployment Patterns

WSO2 API-M offers several deployment patterns to suit different use cases — from local evaluation to large-scale production environments.

### All-in-One Deployments

All components — Control Plane, Gateway, Traffic Manager, and Key Manager — run together in each node. Simpler to set up and operate.

| Pattern | Use Case |
| ------- | -------- |
| [Pattern 0 - All-in-One Setup](am-pattern-0-all-in-one.md) | Local evaluation or testing |
| [Pattern 1 - All-in-One HA Setup](am-pattern-1-all-in-one-ha.md) | Production with basic high availability |

### Distributed Deployments

Components are separated into dedicated nodes for independent scaling and fault isolation. Suitable for large-scale production environments.

| Pattern | Use Case |
| ------- | -------- |
| [Pattern 2 - Simple Scalable Setup](am-pattern-2-all-in-one-gw.md) | Production with independently scalable Gateway |
| [Pattern 3 - Distributed Setup](am-pattern-3-acp-tm-gw.md) | Production with dedicated rate limiting control |
| [Pattern 4 - Fully Distributed Setup](am-pattern-4-acp-tm-gw-km.md) | Fully distributed production setup |
| [Pattern 5 - Simple Scalable with Dedicated Key Manager](am-pattern-5-all-in-one-gw-km.md) | Production with a separately deployed Key Manager |
| [Pattern 6 - All-in-One with WSO2 IS as Key Manager](am-pattern-6-all-in-one-is-as-km.md) | Production with WSO2 Identity Server as the Key Manager |

## Prerequisites

Ensure the following tools are installed before proceeding:

| Tool | Purpose | Install Guide |
| ---- | ------- | ------------- |
| `kubectl` | Kubernetes CLI | [Install](https://kubernetes.io/docs/tasks/tools/) |
| `helm` (v3) | Package manager for Helm charts | [Install](https://helm.sh/docs/intro/install/) |
| `docker` | Required if using a custom image (e.g. external database) | [Install](https://docs.docker.com/get-docker/) |

Verify your tools and cluster are ready:

```bash
kubectl version --client   # check kubectl is installed
helm version               # check Helm is installed
kubectl cluster-info       # verify the cluster is reachable
kubectl get nodes          # verify all nodes are in Ready status
```

Don't have a cluster yet? See [Minikube](https://minikube.sigs.k8s.io/docs/start/) or [Rancher Desktop](https://rancherdesktop.io/) for local options.

## Supported Versions

### Managed Kubernetes Services

| Platform | Cluster Version |
| -------- | --------------- |
| EKS      | 1.27 - 1.30.3   |
| GKE      | 1.27.3 - 1.30.3 |
| AKS      | 1.27 - 1.30.3   |

### Kubernetes Distributions

| Distribution | Cluster Version | Software Version |
|-------------|-----------------|------------------|
| Minikube             | 1.26.3 - 1.30.3 | 1.30.1 - 1.34.0  |
| Rancher Desktop      | 1.27.2 - 1.30.3 | 1.9.1 - 1.16.0   |
| Rancher Enterprise   | 1.32.3 (RKE2)   | 2.11.1           |
| Kind                 | 1.26.3 - 1.30.3 | 0.24.0           |
| OpenShift            | 1.28   - 1.30.3 | 4.15 - 4.15      |

### Helm

| Package Manager | Version         |
| --------------- | --------------- |
| Helm            | 3.10.0 - 3.16.1 |

## Resource Requirements { #resource-requirements }

The tables below show the minimum resources required per component for each pattern, based on the default replica counts in the Helm chart.

=== "Pattern 0 — All-in-One"

    | Component | Replicas | CPU (min) | Memory (min) |
    | --------- | -------- | ----------- | -------------- |
    | All-in-One | 1 | 2000m | 3 Gi |
    | **Total** | | **2000m** | **3 Gi** |

=== "Pattern 1 — All-in-One HA"

    | Component | Replicas | CPU (min) | Memory (min) |
    | --------- | -------- | ----------- | -------------- |
    | All-in-One | 2 | 2000m each | 3 Gi each |
    | **Total** | | **4000m** | **6 Gi** |

=== "Pattern 2 — Simple Scalable"

    | Component | Replicas | CPU (min) | Memory (min) |
    | --------- | -------- | ----------- | -------------- |
    | All-in-One (Control Plane) | 1 | 2000m | 3 Gi |
    | Universal Gateway | 1 | 1000m | 2 Gi |
    | **Total** | | **3000m** | **5 Gi** |

=== "Pattern 3 — Distributed"

    | Component | Replicas | CPU (min) | Memory (min) |
    | --------- | -------- | ----------- | -------------- |
    | API Control Plane | 1 | 2000m | 3 Gi |
    | Traffic Manager | 1 | 1000m | 2 Gi |
    | Universal Gateway | 1 | 1000m | 2 Gi |
    | **Total** | | **4000m** | **7 Gi** |

=== "Pattern 4 — Fully Distributed"

    | Component | Replicas | CPU (min) | Memory (min) |
    | --------- | -------- | ----------- | -------------- |
    | API Control Plane | 1 | 2000m | 3 Gi |
    | Traffic Manager | 1 | 1000m | 2 Gi |
    | Universal Gateway | 1 | 1000m | 2 Gi |
    | Key Manager | 1 | 1000m | 2 Gi |
    | **Total** | | **5000m** | **9 Gi** |

=== "Pattern 5 — Simple Scalable + Dedicated KM"

    | Component | Replicas | CPU (min) | Memory (min) |
    | --------- | -------- | ----------- | -------------- |
    | All-in-One (Control Plane) | 1 | 2000m | 3 Gi |
    | Universal Gateway | 1 | 1000m | 2 Gi |
    | Key Manager | 1 | 1000m | 2 Gi |
    | **Total** | | **4000m** | **7 Gi** |

=== "Pattern 6 — All-in-One + IS as KM"

    | Component | Replicas | CPU (min) | Memory (min) |
    | --------- | -------- | ----------- | -------------- |
    | All-in-One | 1 | 2000m | 3 Gi |
    | WSO2 Identity Server | 1 | 2000m | 3 Gi |
    | **Total** | | **4000m** | **6 Gi** |

!!! note
    These are minimum values based on default replica counts. Actual consumption may be higher under load. If you scale up replica counts, multiply the per-component values by the number of replicas.

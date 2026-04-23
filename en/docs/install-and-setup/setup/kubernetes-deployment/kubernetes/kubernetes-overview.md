# Deploying WSO2 API Manager on Kubernetes

WSO2 API Manager (WSO2 API-M) can be deployed on Kubernetes using Helm charts, making it easy to manage, scale, and maintain in cloud-native environments. This guide provides an overview of the available deployment patterns and the prerequisites needed to get started.

!!! tip "Just want to try it out?"
    Follow the [Quick Start Guide](kubernetes-quick-start.md) to get WSO2 API Manager running on Kubernetes in minutes with zero configuration.

## Deployment Patterns

WSO2 API-M offers several deployment patterns for Kubernetes to suit different use cases — from local evaluation to large-scale production environments. Use the decision guide below to pick the pattern that best fits your needs.

### All-in-One Deployments

All components — Control Plane, Gateway, Traffic Manager, and Key Manager — run together in each node. Simpler to set up and operate.

| Pattern | Use Case |
| ------- | -------- |
| [Pattern 0: Single Node](am-pattern-0-all-in-one.md) | Local evaluation or testing |
| [Pattern 1: Active-Active HA](am-pattern-1-all-in-one-ha.md) | Production with basic high availability |

### Distributed Deployments

Components are separated into dedicated nodes for independent scaling and fault isolation. Suitable for large-scale production environments.

| Pattern | Use Case |
| ------- | -------- |
| [Pattern 2: Simple Scalable](am-pattern-2-all-in-one-gw.md) | Production with independently scalable Gateway |
| [Pattern 3: Distributed](am-pattern-3-acp-tm-gw.md) | Production with dedicated rate limiting control |
| [Pattern 4: Fully Distributed](am-pattern-4-acp-tm-gw-km.md) | Fully distributed production setup |
| [Pattern 5: Simple Scalable with Key Manager](am-pattern-5-all-in-one-gw-km.md) | Production with dedicated Key Manager |

## Prerequisites

Before deploying WSO2 API Manager on Kubernetes, ensure the following tools are installed and configured on your machine:

- **kubectl** — Kubernetes CLI. [Install guide](https://kubernetes.io/docs/tasks/tools/)
- **Helm v3** — Package manager for Kubernetes. [Install guide](https://helm.sh/docs/intro/install/)
- **A running Kubernetes cluster** — Use Minikube for local testing or EKS/GKE/AKS for cloud deployments. See [Setting Up a Local Kubernetes Cluster](#setting-up-a-local-kubernetes-cluster) below if you don't have one yet.
- **Docker** — Required to pull WSO2 images. [Install guide](https://docs.docker.com/get-docker/)
- **A container registry account** — Required only if you are using custom images.

Run the following to verify all tools are ready before proceeding:

```bash
kubectl version
helm version
docker info
```

Verify your cluster is up and running:

```bash
kubectl cluster-info
kubectl get nodes
```

Refer to the [Supported Versions](#supported-versions) section below to confirm your installed versions are compatible.

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
|----------------------|-----------------|------------------|
| Minikube             | 1.26.3 - 1.30.3 | 1.30.1 - 1.34.0  |
| Rancher Desktop      | 1.27.2 - 1.30.3 | 1.9.1 - 1.16.0   |
| Rancher Enterprise   | 1.32.3 (RKE2)   | 2.11.1           |
| Kind                 | 1.26.3 - 1.30.3 | 0.24.0           |
| OpenShift            | 1.28   - 1.30.3 | 4.15 - 4.15      |

#### Helm

Below is the version requirement for Helm to be compatible with WSO2 API-M.

| Package Manager | Version         |
| --------------- | --------------- |
| Helm            | 3.10.0 - 3.16.1 |

### Resource Requirements

The minimum resource requirements vary depending on the deployment pattern you choose. Use the table below as a guide when sizing your cluster.

| Pattern | CPU (min) | Memory (min) | Notes |
| ------- | --------- | ------------ | ----- |
| Pattern 0 (All-in-One) | 4 cores | 7.5 GB | Single node, suitable for development/evaluation |
| Pattern 1 (All-in-One HA) | 4 cores | 8 GB | Two API-M nodes for high availability |
| Pattern 2 (Simple Scalable) | 4 cores | 8 GB | Control Plane + independently scalable Gateway |
| Pattern 3 (Distributed) | 6 cores | 12 GB | ACP + Traffic Manager + Gateway separated |
| Pattern 4 (Fully Distributed) | 8 cores | 16 GB | ACP + TM + Gateway + Key Manager separated |
| Pattern 5 (Simple Scalable + KM) | 6 cores | 12 GB | Control Plane + Gateway + dedicated Key Manager |

## Setting Up a Local Kubernetes Cluster

If you don't have a cluster yet, use one of the following options to get one running locally.

=== "Minikube"

    1. [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)

    2. Start a cluster with enough resources for your chosen pattern. Use the values from the [Resource Requirements](#resource-requirements) table above — for example, Pattern 0 requires 4 CPUs and 7.5 GB:

        ```bash
        minikube start --cpus=4 --memory=7500 --kubernetes-version=v1.30.3
        ```

        For Pattern 1 and above, increase the memory accordingly — for example, Pattern 1 needs 8 GB:

        ```bash
        minikube start --cpus=4 --memory=8192 --kubernetes-version=v1.30.3
        ```

    3. Verify the cluster is up and running:

        ```bash
        kubectl cluster-info
        kubectl get nodes
        ```

=== "Rancher Desktop"

    1. [Install Rancher Desktop](https://rancherdesktop.io/)

    2. Open Rancher Desktop and go to **Preferences → Virtual Machine**. Set the CPU and memory based on your chosen pattern using the [Resource Requirements](#resource-requirements) table above — for example, Pattern 1 needs at least 4 CPUs and 8 GB memory. Click **Apply** and wait for the cluster to restart.

    3. Ensure **Kubernetes** is enabled under *Preferences → Kubernetes*. Rancher Desktop starts the cluster automatically on launch.

    4. Verify the cluster is up and running:

        ```bash
        kubectl cluster-info
        kubectl get nodes
        ```

!!! note
    Ensure your cluster's Kubernetes version is within the supported ranges listed in the [Supported Versions](#supported-versions) section above.

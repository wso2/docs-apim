# Quick Start Guide: WSO2 API Manager on Kubernetes

This guide gets WSO2 API Manager running on Kubernetes in minutes using default settings — an embedded H2 database, default keystores, and a single node. It is intended for evaluation only.

For production deployments, see the [deployment patterns](kubernetes-overview.md#deployment-patterns).

---

## Prerequisites

Ensure the following are installed:

| Tool | Install Guide |
| ---- | ------------- |
| `kubectl` | [Install](https://kubernetes.io/docs/tasks/tools/) |
| `helm` (v3) | [Install](https://helm.sh/docs/intro/install/) |
| A running Kubernetes cluster | [Set one up](kubernetes-overview.md#setting-up-a-local-kubernetes-cluster) |

Verify all tools are installed:

```bash
kubectl version --client
helm version
```

Check that your versions fall within the supported ranges:

| Tool | Supported Version |
| ---- | ----------------- |
| Helm | 3.10.0 - 3.16.1 |
| Kubernetes | 1.26.3 - 1.30.3 |

Verify your cluster is up and all nodes are ready:

```bash
kubectl cluster-info
kubectl get nodes
```

All nodes should show a `Ready` status before proceeding. If you don't have a cluster yet, see [Setting Up a Local Kubernetes Cluster](kubernetes-overview.md#setting-up-a-local-kubernetes-cluster).

!!! note
    For local evaluation, Pattern 0 requires a minimum of **4 CPUs** and **7.5 GB memory**. If using Minikube, start it with:
    ```bash
    minikube start --cpus=4 --memory=7500 --kubernetes-version=v1.30.3
    ```

---

## Step 1 — Add the WSO2 Helm Repository

```bash
helm repo add wso2 https://helm.wso2.com && helm repo update
```

## Step 2 — Install the NGINX Ingress Controller

```bash
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace
```

Wait until the NGINX pod is running:

```bash
kubectl get pods -n ingress-nginx
```

## Step 3 — Deploy WSO2 API Manager

```bash
helm install apim wso2/wso2am-all-in-one \
  --version 4.6.0-1 \
  --namespace wso2 --create-namespace \
  -f https://raw.githubusercontent.com/wso2/helm-apim/4.6.x/docs/am-pattern-0-all-in-one/default_values.yaml
```

Wait for the pod to be ready:

```bash
kubectl get pods -n wso2 -w
```

The pod should show `1/1 Running` before proceeding.

## Step 4 — Configure Local DNS

=== "Minikube"

    Run in a **separate terminal** and keep it running:

    ```bash
    minikube tunnel
    ```

    Then add to your `/etc/hosts`:

    ```
    127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
    ```

=== "Rancher Desktop"

    Get the external IP:

    ```bash
    kubectl get ing -n wso2
    ```

    Add to your `/etc/hosts`, replacing `<EXTERNAL-IP>`:

    ```
    <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
    ```

## Step 5 — Access the Portals

| Portal | URL |
| ------ | --- |
| Publisher | `https://am.wso2.com/publisher` |
| Developer Portal | `https://am.wso2.com/devportal` |
| Carbon Console | `https://am.wso2.com/carbon` |

Default credentials: **admin / admin**

!!! note "Chrome may block access"
    Chrome enforces HSTS for `*.wso2.com` domains. Use Firefox instead and click **Advanced → Accept the Risk and Continue** when prompted about the self-signed certificate.

---

## Next Steps

This deployment uses an embedded H2 database and self-signed certificates — not suitable for production. Choose a deployment pattern based on your requirements:

- [Pattern 0: Single Node](am-pattern-0-all-in-one.md) — full configuration options for this setup
- [Pattern 1: Active-Active HA](am-pattern-1-all-in-one-ha.md) — production-ready with external database and high availability
- [All patterns overview](kubernetes-overview.md#deployment-patterns)

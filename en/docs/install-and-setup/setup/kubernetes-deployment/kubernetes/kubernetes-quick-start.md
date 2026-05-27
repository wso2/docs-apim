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
| A running Kubernetes cluster | [Minikube](https://minikube.sigs.k8s.io/docs/start/) or [Rancher Desktop](https://rancherdesktop.io/) |

Verify all tools are installed:

```bash
kubectl version --client
helm version
```

Check that your versions fall within the supported ranges:

| Tool | Supported Version |
| ---- | ----------------- |
| Helm | 3.10.0 or later |
| Kubernetes | 1.26.3 or later |

Verify your cluster is up and all nodes are ready:

```bash
kubectl cluster-info
kubectl get nodes
```

All nodes should show a `Ready` status before proceeding.

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

=== "Local cluster (Minikube / Rancher Desktop)"

    ```bash
    helm upgrade --install ingress-nginx ingress-nginx \
      --repo https://kubernetes.github.io/ingress-nginx \
      --namespace ingress-nginx --create-namespace
    ```

=== "Managed cluster (AKS / GKE)"

    ```bash
    helm upgrade --install ingress-nginx ingress-nginx \
      --repo https://kubernetes.github.io/ingress-nginx \
      --namespace ingress-nginx --create-namespace \
      --set controller.service.externalTrafficPolicy=Local
    ```

    !!! note
        `externalTrafficPolicy=Local` is required on managed Kubernetes services. Without it, the cloud load balancer health probes fail and traffic never reaches the ingress controller.

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

## Step 4 — Configure DNS

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

=== "Managed cluster (AKS / GKE)"

    Get the external IP assigned to the ingress:

    ```bash
    kubectl get ing -n wso2
    ```

    For quick testing, add the `ADDRESS` value to your `/etc/hosts`:

    ```
    <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
    ```

    For a production setup, create a DNS record in your DNS provider (e.g. Route 53, Azure DNS, Cloud DNS) mapping the hostnames to the external IP instead of using `/etc/hosts`.

## Step 5 — Access the Portals

| Portal | URL |
| ------ | --- |
| Publisher | `https://am.wso2.com/publisher` |
| Developer Portal | `https://am.wso2.com/devportal` |
| Carbon Console | `https://am.wso2.com/carbon` |

Default credentials: **admin / admin**

!!! note "Chrome may block access"
    Chrome enforces HSTS preloading for `*.wso2.com` domains, which removes the option to bypass the self-signed certificate warning entirely. Use Firefox or Safari instead, and click through the certificate warning when prompted.

---

## Next Steps

This deployment uses an embedded H2 database and self-signed certificates — not suitable for production. Choose a deployment pattern based on your requirements:

- [Pattern 0: Single Node](am-pattern-0-all-in-one.md) — full configuration options for this setup
- [Pattern 1: Active-Active HA](am-pattern-1-all-in-one-ha.md) — production-ready with external database and high availability
- [All patterns overview](kubernetes-overview.md#deployment-patterns)

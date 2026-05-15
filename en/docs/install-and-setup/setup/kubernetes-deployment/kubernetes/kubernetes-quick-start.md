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

## Step 2 — Install Envoy Gateway

```bash
helm install envoy-gateway oci://docker.io/envoyproxy/gateway-helm \
  --version v1.7.0 -n envoy-gateway-system \
  --set config.envoyGateway.extensionApis.enableBackend=true \
  --set envoyGateway.gateway.experimentalFeatures.enabled=true \
  --create-namespace
```

Create the `apim` namespace and apply the sample Gateway manifest:

```bash
kubectl create namespace apim
kubectl apply \
  -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/resources/assets/sample-gateway.yaml \
  -n apim
```

!!! warning
    The `apim` namespace must exist before applying the Gateway manifest. Run `kubectl create namespace apim` first — applying the manifest without the namespace will fail.

## Step 3 — Deploy WSO2 API Manager

```bash
helm install apim wso2/wso2am-all-in-one \
  --version 4.7.0-1 \
  --namespace apim --create-namespace \
  -f https://raw.githubusercontent.com/wso2/helm-apim/4.7.x/docs/am-pattern-0-all-in-one/default_values.yaml \
  --set wso2.apim.configurations.encryption.key=$(openssl rand -hex 32)
```

!!! warning "Encryption key is mandatory"
    WSO2 API Manager 4.7.0 requires a 256-bit encryption key before first startup. The command above generates one automatically. For production or shared environments, generate the key separately and store it securely — you will need the same key if you redeploy.

Wait for the pod to be ready:

```bash
kubectl get pods -n apim -w
```

The pod should show `1/1 Running` before proceeding.

## Step 4 — Configure DNS

=== "Minikube"

    Run in a **separate terminal** and keep it running:

    ```bash
    minikube tunnel
    ```

    Get the external IP assigned to the gateway:

    ```bash
    kubectl get gateway -n apim
    ```

    Then add to your `/etc/hosts`:

    ```
    127.0.0.1 am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
    ```

=== "Rancher Desktop"

    Get the external IP assigned to the gateway:

    ```bash
    kubectl get gateway -n apim
    ```

    Add to your `/etc/hosts`, replacing `<EXTERNAL-IP>`:

    ```
    <EXTERNAL-IP> am.wso2.com gw.wso2.com websocket.wso2.com websub.wso2.com
    ```

=== "Managed cluster (AKS / GKE)"

    Get the external IP assigned to the gateway:

    ```bash
    kubectl get gateway -n apim
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

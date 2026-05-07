# Setting Up

This guide provides detailed instructions for deploying API Platform Gateway in production environments. Choose the infrastructure option that matches your environment.

!!! tip "Quick Start"
    If you are just getting started, see the [Getting Started]({{base_path}}/api-gateway/api-platform-gateway/getting-started/) guide for a quick setup.

## Setup Instructions

=== "Virtual Machine"

    ### Prerequisites

    - cURL installed
    - unzip installed
    - A Docker-compatible container runtime such as:
        - Docker Desktop (Windows / macOS)
        - Rancher Desktop (Windows / macOS)
        - Colima (macOS)
        - Docker Engine + Compose plugin (Linux)

    Ensure that `Docker` and `Docker Compose` are installed and available:

    ```bash
    docker --version
    docker compose version
    ```

    ### Step 1: Download the Gateway

    Use the download command from the Admin Portal for your gateway, or run the following after replacing `<gateway-version>` with the release tag shown there (for example, `v1.0.0`):

    ```bash
    curl -sLO https://github.com/wso2/api-platform/releases/download/gateway/<gateway-version>/wso2apip-api-gateway-<gateway-version>.zip && \
    unzip wso2apip-api-gateway-<gateway-version>.zip
    ```

    ### Step 2: Configure the Gateway

    Run this command to create `wso2apip-api-gateway-<gateway-version>/configs/keys.env` with the required environment variables:

    ```bash
    cat > wso2apip-api-gateway-<gateway-version>/configs/keys.env << 'ENVFILE'
    GATEWAY_CONTROLPLANE_HOST=<your-control-plane-host>:9443
    GATEWAY_REGISTRATION_TOKEN=<your-gateway-token>
    ENVFILE
    ```

    ### Step 3: Start the Gateway

    1. Navigate to the gateway folder:

        ```bash
        cd wso2apip-api-gateway-<gateway-version>
        ```

    2. Run this command to start the gateway using the `configs/keys.env` file created in Step 2:

        ```bash
        docker compose --env-file configs/keys.env up
        ```

    To run in detached mode (background):

    ```bash
    docker compose --env-file configs/keys.env up -d
    ```

    ### Step 4: Verify the Gateway

    Check that the gateway is running:

    ```bash
    docker compose ps
    ```

    ### Stopping the Gateway

    To stop the gateway:

    ```bash
    docker compose down
    ```

=== "Docker"

    ### Prerequisites

    - cURL installed
    - unzip installed
    - Docker installed and running
    - Docker Compose installed

    ### Step 1: Download the Gateway

    Use the download command from the Admin Portal for your gateway, or run the following after replacing `<gateway-version>` with the release tag shown there (for example, `v1.0.0`):

    ```bash
    curl -sLO https://github.com/wso2/api-platform/releases/download/gateway/<gateway-version>/wso2apip-api-gateway-<gateway-version>.zip && \
    unzip wso2apip-api-gateway-<gateway-version>.zip
    ```

    ### Step 2: Configure the Gateway

    Run this command to create `wso2am-universal-gw-<gateway-version>/configs/keys.env` with the required environment variables:

    ```bash
    cat > wso2apip-api-gateway-<gateway-version>/configs/keys.env << 'ENVFILE'
    GATEWAY_CONTROLPLANE_HOST=<your-control-plane-host>:9443
    GATEWAY_REGISTRATION_TOKEN=<your-gateway-token>
    ENVFILE
    ```

    !!! warning "Important"
        Replace `<your-gateway-token>` with the Gateway Registration Token from the Admin Portal. This token is shown only once, so ensure you copy it before leaving the page.

    ### Step 3: Start the Gateway

    1. Navigate to the gateway folder:

        ```bash
        cd wso2apip-api-gateway-<gateway-version>
        ```

    2. Run this command to start the gateway using the `configs/keys.env` file created in Step 2:

        ```bash
        docker compose --env-file configs/keys.env up
        ```

    To run in detached mode (background):

    ```bash
    docker compose --env-file configs/keys.env up -d
    ```

    ### Step 4: Verify the Gateway

    Check that the gateway is running:

    ```bash
    docker compose ps
    ```

    ### Stopping the Gateway

    To stop the gateway:

    ```bash
    docker compose down
    ```

=== "Kubernetes"

    ### Prerequisites

    - cURL installed
    - Kubernetes 1.32+ cluster
    - Helm 3.18+ installed
    - Either permissions to install cert-manager in the cluster or an existing cert-manager installation

    ### Install cert-manager (optional)

    If cert-manager is not already installed, run these commands before installing the gateway chart:

    ```bash
    helm repo add jetstack https://charts.jetstack.io --force-update
    helm repo update

    helm install cert-manager jetstack/cert-manager \
      --namespace cert-manager \
      --create-namespace \
      --set crds.enabled=true
    ```

    ### Installing the Chart

    Use the Helm install command shown in the Admin Portal for your gateway where possible so chart and image versions stay in sync. Alternatively, run the following after replacing `<gateway-chart-version>` with the chart version recommended there (for example, `1.0.0`):

    ```bash
    helm install gateway oci://ghcr.io/wso2/api-platform/helm-charts/gateway --version <gateway-chart-version> \
      --set gateway.controller.controlPlane.host="<your-control-plane-host>" \
      --set gateway.controller.controlPlane.port=9443 \
      --set gateway.controller.controlPlane.token.value="<your-gateway-token>" \
      --set gateway.config.analytics.publishers.moesif.application_id="<your-moesif-key>" \
      --set gateway.config.analytics.enabled=true
    ```

    !!! warning "Important"
        Replace `<your-gateway-token>` with the Gateway Registration Token from the Admin Portal. This token is shown only once, so ensure you copy it before leaving the page.

    ### Verifying the Installation

    Check that the gateway pods are running:

    ```bash
    kubectl get pods
    ```

    ### Upgrading the Gateway

    To upgrade to a new version:

    ```bash
    helm upgrade gateway oci://ghcr.io/wso2/api-platform/helm-charts/gateway --version <new-version> \
      -f values.yaml
    ```

    ### Uninstalling the Gateway

    To remove the gateway from your cluster:

    ```bash
    helm uninstall gateway
    ```

## What's Next?

- [Adding and Managing Policies]({{base_path}}/api-gateway/api-platform-gateway/adding-and-managing-policies/)

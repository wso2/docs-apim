# Setting Up a Local Kubernetes Cluster

If you don't have a Kubernetes cluster yet, use one of the following options to get one running locally. Refer to the [Resource Requirements](kubernetes-overview.md#resource-requirements) table to size your cluster correctly for the pattern you plan to deploy.

=== "Minikube"

    1. [Install Minikube](https://minikube.sigs.k8s.io/docs/start/)

    2. Start a cluster with enough resources for your chosen pattern — for example, Pattern 0 requires 4 CPUs and 7.5 GB:

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

    2. Open Rancher Desktop and go to **Preferences → Virtual Machine**. Set the CPU and memory based on your chosen pattern. Click **Apply** and wait for the cluster to restart.

    3. Ensure **Kubernetes** is enabled under **Preferences → Kubernetes**. Rancher Desktop starts the cluster automatically on launch.

    4. Verify the cluster is up and running:

        ```bash
        kubectl cluster-info
        kubectl get nodes
        ```

!!! note
    Ensure your cluster's Kubernetes version is within the supported ranges listed in the [Supported Versions](kubernetes-overview.md#supported-versions) section.

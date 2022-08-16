# Installation Prerequisites

- Choreo Connect can be deployed in [Docker Compose](https://docs.docker.com/compose/) for trying out purposes. You need to install [Docker](https://docs.docker.com/get-docker/) in your machine.
  Allocate the following resources for Docker.

    - Minimum CPU : 4vCPU
    - Minimum Memory : 4GB


- In order to deploy Choreo Connect in Kubernetes, ensure that the appropriate prerequisites are fulfilled.

    - Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
    - Set up a [Kubernetes](https://Kubernetes.io/docs/setup/) cluster v1.20 or above.

### Minimum CPU and memory requirements for Choreo Connect components

| **Component** | **CPUs (vCPU)** | **Memory (MB)** |
|-----------|------------|------------|
| Adapter   | 0.5        | 500        |
| Enforcer  | 1          | 1000       |
| Router    | 1          | 500        |
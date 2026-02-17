# Deployment Platforms

Choosing the right platform is the first step in planning your WSO2 API Manager deployment. The platform is the underlying environment where the API Manager will run. Each platform has distinct characteristics, and your choice will depend on your organization's infrastructure strategy, scalability needs, and operational capacity.

WSO2 API Manager is flexible and can be deployed on traditional virtual machines or modern containerized environments.

---

## On-Premises / Virtual Machines (VMs)

Deploying on Virtual Machines is the traditional approach, where you install and run WSO2 API Manager directly on operating systems hosted on your own infrastructure or on IaaS cloud providers (like AWS EC2, Azure VMs, or Google Compute Engine).

This model gives you full control over the network, storage, and operating system, and it supports the full range of architectural patterns. You can run a simple **[All-in-One pattern](./deployment-patterns.md)** on a single VM for development, or scale up to a fully **[Distributed](./deployment-patterns.md)** or **[Multi-Datacenter](./deployment-patterns.md)** architecture across multiple VMs for a robust, production-grade environment.

> **Next Steps:** [View the VM Installation Guides]({{base_path}}/install-and-setup/setup/deployment-overview/)

### Key Characteristics

*   **High Control**: You have complete authority over the hardware, software, and network configuration. This is ideal for organizations with strict security, compliance, or data residency requirements.
*   **Architectural Flexibility**: Supports all deployment patterns, from the simplest to the most complex, allowing you to tailor the architecture to your specific needs on your own infrastructure.
*   **Infrastructure Management**: Your team is responsible for provisioning, maintaining, and scaling the virtual machines, as well as handling backups, disaster recovery, and system updates.

### When to Choose VMs

*   You have an existing data center or a significant investment in on-premises infrastructure.
*   Your organization has strict regulatory or security policies that require full control over the environment.
*   You require architectural flexibility (e.g., complex network topologies) that is easier to implement on VMs than on a container platform.
*   Your operational teams are more experienced with traditional infrastructure management.

---

## Kubernetes and Cloud-Native

A cloud-native deployment involves running WSO2 API Manager in containers, orchestrated by a platform like Kubernetes. This is the modern, recommended approach for scalable, resilient, and automated deployments.

WSO2 API Manager is deployed to Kubernetes using **Helm charts**, which package all the necessary Kubernetes resources (such as Deployments, Services, and Ingresses) for each [Deployment Pattern](./deployment-patterns.md).

> **Next Steps:** [View the Kubernetes Installation Guides]({{base_path}}/install-and-setup/setup/kubernetes-deployment/kubernetes/kubernetes-overview/)

### Key Characteristics

*   **Scalability and Resilience**: Kubernetes can automatically scale the number of API Manager component instances (pods) based on traffic load. It can also automatically restart failed instances, providing high availability.
*   **Declarative Configuration**: You define the desired state of your deployment in configuration files (YAML), and Kubernetes works to maintain that state. This enables Infrastructure as Code (IaC) and GitOps practices.
*   **Resource Efficiency**: Containers are more lightweight than VMs, allowing for more efficient use of computing resources and faster startup times.
*   **Platform Portability**: A containerized API Manager can run consistently across different environments, from a developer's laptop to on-premises data centers and multiple public clouds like **Amazon EKS**, **Azure AKS**, and **Google GKE**.

### Deploying on OpenShift

**OpenShift** is an enterprise-grade Kubernetes platform with stricter, built-in security policies. While the deployment concepts are the same as standard Kubernetes, deploying to OpenShift requires specific adjustments:

*   **Security Contexts**: The Helm charts must be configured to work with OpenShift's security model, which often runs containers with an arbitrary user ID.
*   **Custom Docker Images**: The standard Docker images may need to be modified to ensure correct file permissions and group ownership (GID 0) to function within OpenShift's security constraints.
WSO2 provides specific instructions and Helm chart configurations to address these requirements for a smooth OpenShift deployment.

### Advanced Cloud-Native Patterns
The flexibility of Kubernetes also allows for advanced patterns, such as deploying WSO2 Identity Server (IS) as a containerized, external Key Manager within the same cluster, providing a fully cloud-native identity and API management solution.

### When to Choose Kubernetes

*   Your organization has adopted a cloud-native or microservices strategy.
*   You require high scalability and automated failover for your API traffic.
*   You want to automate your deployment, scaling, and management processes through CI/CD pipelines.
*   You are deploying in a public or hybrid cloud environment and want to leverage managed Kubernetes services.

## What's Next

- Ready to set up your environment? Read the comprehensive [Deployment Patterns]({{base_path}}/get-started/deployment-patterns/) guide.

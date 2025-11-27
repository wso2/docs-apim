# Choosing Your Deployment Strategy

Selecting the right deployment strategy for WSO2 API Manager involves making two key, independent decisions based on your specific needs:

1.  **[Deployment Platform]({{base_path}}/get-started/deployment-platforms)**: *Where* will your system run?
2.  **[Deployment Pattern]({{base_path}}/get-started/deployment-patterns)**: *How* will the components be architected?

This guide presents common scenarios to help you choose the best combination of platform and pattern.

---

## Key Factors to Consider

Before choosing, evaluate your requirements based on these factors:

| Factor | Description |
| :--- | :--- |
| **Scalability** | How much API traffic do you expect? Will it grow over time? Do you need to handle sudden traffic spikes? |
| **High Availability (HA)** | Can your business tolerate downtime? Do you need automatic failover and redundancy for all components? |
| **Security & Compliance**| What are your organization's security policies? Do you need to isolate traffic-facing components? |
| **Operational Overhead** | What is your team's expertise and preferred workflow (traditional infrastructure vs. cloud-native DevOps)? |

---

## Common Deployment Scenarios

### Scenario 1: Development and Testing
*   **If your primary need is...** simplicity and speed of setup for a non-production environment.
*   **Then the recommended approach is...**
    *   **Pattern**: **[Pattern 0: Single Node]({{base_path}}/get-started/deployment-patterns#pattern-0-single-node)**
    *   **Platform**: Either **[Virtual Machines]({{base_path}}/get-started/deployment-platforms#on-premises--virtual-machines-vms)** for a traditional setup or a lightweight **[Kubernetes]({{base_path}}/get-started/deployment-platforms#kubernetes-and-cloud-native)** cluster.

### Scenario 2: Small-Scale Production with High Availability
*   **If your primary need is...** fault tolerance and reliability with minimal operational complexity.
*   **Then the recommended approach is...**
    *   **Pattern**: **[Pattern 1: All-in-One HA]({{base_path}}/get-started/deployment-patterns#pattern-1-all-in-one-high-availability-ha)**
    *   **Platform**: Either **[Virtual Machines]({{base_path}}/get-started/deployment-platforms#on-premises--virtual-machines-vms)** or **[Kubernetes]({{base_path}}/get-started/deployment-platforms#kubernetes-and-cloud-native)**.

### Scenario 3: Scalable Gateway with a Simple Control Plane
*   **If your primary need is...** to scale only the API Gateway for traffic, while keeping the management components unified and simple.
*   **Then the recommended approach is...**
    *   **Pattern**: **[Pattern 2: Simple Scalable Deployment]({{base_path}}/get-started/deployment-patterns#pattern-2-simple-scalable-deployment)**
    *   **Platform**: **[Kubernetes]({{base_path}}/get-started/deployment-platforms#kubernetes-and-cloud-native)** or **[Virtual Machines]({{base_path}}/get-started/deployment-platforms#on-premises--virtual-machines-vms)**.

### Scenario 4: Standard Production with High Traffic
*   **If your primary need is...** to independently scale multiple components (Gateway, Traffic Manager) to handle high API traffic with strong isolation.
*   **Then the recommended approach is...**
    *   **Pattern**: **[Pattern 3: Recommended Distributed]({{base_path}}/get-started/deployment-patterns#pattern-3-recommended-distributed-deployment)**
    *   **Platform**: **[Kubernetes]({{base_path}}/get-started/deployment-platforms#kubernetes-and-cloud-native)** is ideal for its auto-scaling capabilities, but **[Virtual Machines]({{base_path}}/get-started/deployment-platforms#on-premises--virtual-machines-vms)** are also fully supported.

### Scenario 5: Ultimate Scalability & Isolation
*   **If your primary need is...** maximum security, full component isolation, or integration with a central corporate IdP.
*   **Then the recommended approach is...**
    *   **Pattern**: **[Pattern 4: Fully Distributed with Key Manager Seperation]({{base_path}}/get-started/deployment-patterns#pattern-4-fully-distributed-deployment-with-key-manager-separation)**
    *   **Platform**: **[Kubernetes]({{base_path}}/get-started/deployment-platforms#kubernetes-and-cloud-native)** or **[Virtual Machines]({{base_path}}/get-started/deployment-platforms#on-premises--virtual-machines-vms)**.

### Scenario 6: Targeted Scaling for Gateway & Identity
*   **If your primary need is...** to scale the Gateway and also isolate the Key Manager for security or heavy authentication loads.
*   **Then the recommended approach is...**
    *   **Pattern**: **[Pattern 5: Simple Scalable with Key Manager Separation]({{base_path}}/get-started/deployment-patterns#pattern-5-simple-scalable-with-key-manager-separation)**
    *   **Platform**: **[Kubernetes]({{base_path}}/get-started/deployment-platforms#kubernetes-and-cloud-native)** or Virtual Machines. 

---

### Summary Matrix

This matrix provides a quick reference for choosing a pattern based on your primary requirement.

| Primary Requirement | Recommended Pattern | Common Platform(s) |
| :--- | :--- | :--- |
| **Simplicity (Dev/Test)** | [Pattern 0: All-in-One]({{base_path}}/get-started/deployment-patterns#pattern-0-single-node) | VM, Kubernetes |
| **Basic HA (Small Prod)** | [Pattern 1: All-in-One HA]({{base_path}}/get-started/deployment-patterns#pattern-1-all-in-one-high-availability-ha) | VM, Kubernetes |
| **Balanced Gateway Scaling** | [Pattern 2: Simple Scalable]({{base_path}}/get-started/deployment-patterns#pattern-2-simple-scalable-deployment) | VM, Kubernetes |
| **Standard Production** | [Pattern 3: Distributed]({{base_path}}/get-started/deployment-patterns#pattern-3-recommended-distributed-deployment) | Kubernetes, VM |
| **Ultimate Scalability & Isolation**| [Pattern 4: Fully Distributed]({{base_path}}/get-started/deployment-patterns#pattern-4-fully-distributed-deployment) | Kubernetes, VM |
| **Targeted Scaling for Gateway & Identity** | [Pattern 5: Simple Scalable with KM Separation]({{base_path}}/get-started/deployment-patterns#pattern-5-simple-scalable-with-key-manager-separation) | Kubernetes, VM |
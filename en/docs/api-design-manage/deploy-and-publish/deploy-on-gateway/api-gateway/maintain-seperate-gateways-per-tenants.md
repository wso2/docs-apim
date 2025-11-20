# Maintain Separate Gateways per Single or Multiple Tenants

## Overview

In enterprise environments, organizations often require isolated API gateway infrastructure for different business units, departments, or customer segments. WSO2 API Manager's multi-tenant architecture combined with its flexible gateway deployment options enables you to maintain separate Universal Gateways for single or multiple tenants, providing enhanced security, performance isolation, and operational independence.

This approach allows you to:

- **Isolate tenant traffic** - Ensure complete separation of API traffic between different tenant domains
- **Provide dedicated resources** - Allocate specific gateway resources for high-priority tenants or applications
- **Enhance security** - Implement tenant-specific security policies and access controls
- **Improve performance** - Prevent resource contention by isolating tenant workloads
- **Enable custom configurations** - Apply different gateway configurations, policies, and extensions per tenant

## Architecture Overview

### Single Tenant per Gateway

In this deployment pattern, each tenant gets its own dedicated Universal Gateway instance. This provides the highest level of isolation but requires more infrastructure resources.

[![Single Tenant Per Gateway]({{base_path}}/assets/img/deploy/single-gateway-per-tenant.png)]({{base_path}}/assets/img/deploy/single-gateway-per-tenant.png)

### Multiple Tenants per Gateway
This pattern allows multiple tenants to share gateway resources while maintaining logical separation through configuration and policies.

[![Multiple Tenants Per Gateway]({{base_path}}/assets/img/deploy/multiple-tenant-per-gateway.png)]({{base_path}}/assets/img/deploy/multiple-tenant-per-gateway.png)

## Configuration Approaches

### Gateway Environment Configuration

#### Single Tenant per Gateway

Add following configuration into gateway deployment.toml and start the server.
```
[apim.sync_runtime_artifacts.tenant_loading]
enable = true
tenants= "Tenant A"
```

#### Multiple Tenants per Gateway

Add following configuration into gateway deployment.toml and start the server.
```
[apim.sync_runtime_artifacts.tenant_loading]
enable = true
tenants= "Tenant A,Tenant B,Tenant C"
```
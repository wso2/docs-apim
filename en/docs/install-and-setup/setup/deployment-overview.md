# WSO2 API Manager Deployment Overview

WSO2 API Manager includes multiple components. This allows you set up the API Manager following a range of deployment patterns. This section describes all the possible deployment patterns and guides you how to select the most appropriate pattern based on your requirement.

## Basic deployment

![Basic Deployment]({{base_path}}/assets/img/setup-and-install/basic-deployment.png)

You can use this pattern when you are working with low throughput.

## Basic multi-tenant deployment

![Basic Multi Tenant Deployment]({{base_path}}/assets/img/setup-and-install/basic-multi-tenant-deployment.png)

You can use this pattern in a multi-tenant environment where you need to direct the traffic of each tenant to a separate Micro Integrator/Streaming cluster.

## Simple scalable deployment

![Simple Scalable Deployment]({{base_path}}/assets/img/setup-and-install/simple-scalable-deployment.png)

You can use this pattern if you want to maintain the API Manager deployment with minimum resources, but be able to scale it to meet any increase in throughput that may occur after setting it up.
    
## Extended patterns

![Extended Deployment]({{base_path}}/assets/img/setup-and-install/extended-deployment.png)

The above diagram shows a deployment created by extending the simple scalable deployment. Similarly the other deploymet patterns coukld also be extended by adding the EI and Service catalog components.


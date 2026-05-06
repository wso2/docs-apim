# WSO2 API Manager Deployment Guide for AWS

This guide provides an overview of deploying WSO2 API Manager on Amazon Web Services (AWS) using a highly available architecture across multiple availability zones.

## Contents

- [Overview](#overview)
- [Supported Deployment Models](#supported-deployment-models)
    - [Kubernetes Deployment Using Amazon EKS](#kubernetes-deployment-using-amazon-eks)
    - [Virtual Machine Deployment Using EC2](#virtual-machine-deployment-using-ec2)
- [AWS Infrastructure Architecture](#aws-infrastructure-architecture)
    - [Public Access Layer](#public-access-layer)
    - [Application Layer](#application-layer)
    - [Database Layer](#database-layer)
    - [Management Layer](#management-layer)
    - [Observability and Security Services](#observability-and-security-services)
- [AWS Billable Services Used in the Deployment](#aws-billable-services-used-in-the-deployment)
- [WSO2 Licensing and Cost Model](#wso2-licensing-and-cost-model)
    - [WSO2 Licensing](#wso2-licensing)
    - [AWS Infrastructure Costs](#aws-infrastructure-costs)
    - [Managing AWS Service Limits](#managing-aws-service-limits)
- [High Availability](#high-availability)

## Overview

WSO2 API Manager is an enterprise API management platform used to design, publish, secure, monitor, and manage APIs.

The platform can be deployed on Amazon Web Services using a highly available architecture across multiple availability zones. The architecture supports:

- High availability API gateway clusters
- Secure API exposure via load balancers
- Centralized API lifecycle management
- Scalable control plane and gateway nodes

The deployment architecture uses a multi-AZ VPC design with separate subnets for:

- public traffic
- application components
- management components
- database services

## Supported Deployment Models

### Kubernetes Deployment Using Amazon EKS

WSO2 API Manager can be deployed as containerized workloads orchestrated by Amazon Elastic Kubernetes Service.

In this deployment model:

- API Manager components run as containers
- Kubernetes manages scaling and scheduling
- Worker nodes run on Amazon Elastic Compute Cloud
- Container images are stored in Amazon Elastic Container Registry

This approach provides:

- Cloud-native scalability
- automated container orchestration
- simplified infrastructure operations
- improved resilience and scaling capabilities

### Virtual Machine Deployment Using EC2

WSO2 API Manager can also be deployed directly on Amazon Elastic Compute Cloud instances using the standard WSO2 installation packages.

In this model:

- API gateway and control plane nodes run on EC2 instances
- instances are placed behind Elastic Load Balancing
- infrastructure scaling can be managed using Auto Scaling Groups

This deployment model is suitable for:

- traditional VM-based environments
- lift-and-shift migrations
- environments not yet adopting container orchestration

## AWS Infrastructure Architecture

WSO2 API Manager runs inside an AWS Virtual Private Cloud (VPC) and is designed to support secure and scalable API management.
The deployment typically spans multiple availability zones and contains the following infrastructure layers.

### Public Access Layer

External API consumers access APIs through an internet-facing load balancer.

Components include:

- Elastic Load Balancing (Application Load Balancer)
- Amazon Route 53 for DNS routing
- AWS Certificate Manager for TLS certificates
- Internet Gateway for internet connectivity

The Application Load Balancer routes HTTPS requests to API gateway nodes running inside the application tier.

### Application Layer

WSO2 API gateway, control plane and traffic manager components run inside private subnets.

These components may be deployed either:

- as container workloads orchestrated by Amazon EKS, or
- as application nodes running on EC2 instances.

In container deployments, Kubernetes orchestrates container scheduling and scaling across worker nodes.

!!! info 
    For more details on deployment patterns and architecture, refer to the [WSO2 API Manager Kubernetes Deployment Guide](../kubernetes/kubernetes-overview.md#deployment-patterns) and the [WSO2 API Manager on EKS Deployment Guide](./deploying-wso2-api-m-on-eks.md).

### Database Layer

Persistent data for WSO2 API Manager is stored using Amazon Relational Database Service (Amazon RDS) or Amazon Aurora.

The architecture can include:

- RDS/Aurora instances deployed in private subnets
- RDS Proxy to manage database connection pooling and improve scalability

!!! tip
    We recommend using **Amazon Aurora** (MySQL or PostgreSQL compatible) for production environments due to its high performance, scalable storage, and high availability capabilities (such as multi-AZ deployments with fast replication and automated failover).


### Management Layer

Operational access to the environment is provided through a management subnet.

Components may include:

- EC2 instances for administrative access
- EC2 Instance Connect Endpoint (EIC) for secure SSH access without exposing public endpoints

### Observability and Security Services

Additional AWS services provide monitoring, logging, and auditing capabilities.

These include:

- Amazon CloudWatch for monitoring and logs
- AWS CloudTrail for API activity auditing
- Amazon S3 for storage and backups
- Amazon Elastic Container Registry for container image storage
- VPC Flow Logs for network visibility

## AWS Billable Services Used in the Deployment

The following AWS services are used in the reference architecture and may incur charges.

| AWS Service | Purpose | Mandatory / Optional |
| --- | --- | --- |
| Amazon VPC | Network isolation for the deployment | Mandatory |
| Amazon EC2 | Compute infrastructure for API Manager nodes | Mandatory |
| Amazon EKS | Kubernetes orchestration platform | Optional |
| Amazon ECR | Container image registry | Optional |
| Elastic Load Balancing (ALB) | API traffic routing | Mandatory |
| Amazon Route 53 | DNS routing for API endpoints | Recommended |
| AWS Certificate Manager | TLS certificate management | Recommended |
| NAT Gateway | Internet access for private subnets | Mandatory |
| Amazon RDS | Persistent data storage | Mandatory |
| RDS Proxy | Database connection pooling | Optional |
| Amazon EBS | Persistent storage for compute instances | Mandatory |
| Amazon CloudWatch | Monitoring and logs | Recommended |
| AWS CloudTrail | AWS API activity auditing | Recommended |
| Amazon S3 | Backup and artifact storage | Optional |
| EC2 Instance Connect Endpoint | Secure administrative access | Optional |

!!! note
    Actual services used depend on the deployment configuration selected by the customer.

## WSO2 Licensing and Cost Model

### WSO2 Licensing

WSO2 API Manager is available under both open-source and enterprise licensing models.

**Open Source Edition:**

- Distributed under the Apache 2.0 license
- Free to use
- Community support

**Enterprise Subscription:**

Enterprise subscriptions from WSO2 provide:

- Enterprise technical support
- Security updates and patches
- Production deployment support
- Long-term maintenance releases

**Transaction-Based Billing Model:**

Enterprise deployments are typically licensed using a transaction-based pricing model.

A transaction represents a single API invocation processed by the API gateway.

Subscription tiers are determined based on the total number of API transactions processed during a billing period.

### AWS Infrastructure Costs

Running WSO2 API Manager on AWS incurs infrastructure costs associated with the AWS services used in the deployment.

Typical infrastructure cost drivers include:

| Cost Component | Description |
| --- | --- |
| EC2 instances | Compute resources for application nodes |
| EKS cluster | Kubernetes control plane and worker nodes |
| RDS database | Managed database infrastructure |
| Application Load Balancer | API traffic routing |
| NAT Gateway | Outbound internet connectivity |
| EBS volumes | Persistent storage |
| CloudWatch | Monitoring and logging |
| S3 storage | Backup and artifact storage |

!!! tip
    Customers can estimate infrastructure costs using the [AWS Pricing Calculator](https://calculator.aws/). Actual costs depend on infrastructure size, API traffic volume, and availability requirements.

## Managing AWS Service Limits

AWS services enforce service quotas that may affect the scalability of the API management platform. Before deploying WSO2 API Manager, customers should review relevant AWS service quotas.

| AWS Service | Relevant Limits |
| --- | --- |
| Amazon EC2 | Regional vCPU limits |
| Elastic Load Balancing | Load balancers per region |
| Amazon EKS | Kubernetes clusters per region |
| Amazon RDS | Database instances per region |
| NAT Gateway | NAT gateway limits per availability zone |
| Elastic IPs | Public IP allocation limits |

!!! info
    Application Load Balancers scale automatically based on traffic demand using Load Balancer Capacity Units (LCU). Customers should monitor LCU utilization when operating high-traffic API platforms.

!!! tip
    If expected infrastructure usage exceeds default quotas, customers can request quota increases through the AWS Service Quotas console.

## High Availability

The reference architecture distributes infrastructure across multiple availability zones to provide high availability.

Resilience is achieved through:

- load-balanced API gateway nodes
- multi-AZ database deployments
- container orchestration using Kubernetes when deployed on EKS
- redundant networking infrastructure

This architecture ensures the API platform remains available even during infrastructure failures.


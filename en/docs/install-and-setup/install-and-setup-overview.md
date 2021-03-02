# Install and Setup Overview

The installation and the setup of API Manager involves installing the product, deploying it in the method that is best suited for your requirements, and setting it up to run in the production environment. If you already have an older version of WSO2 API Manager or one of it's components, you can follow the upgrading instructions in this guide.

## Install

The installation guide of WSO2 API Manager explains how to set the API Manager and its components on a single node or in a container. For installation prerequisites for a single API Manager node, see [Installation Prerequisites]({{base_path}}/install-and-setup/install/installation-prerequisites).

For instructions to install each component, see the topics below:

- [Installing API Manager]({{base_path}}/install-and-setup/install/installing-the-product)
- [Installing Micro Integrator]({{base_path}}/install-and-setup/install/installing-mi)
- [Installing Streaming Integrator]({{base_path}}/install-and-setup/install/installing-si)


## Deploy

You can deploy WSO2 API Manager and its components in a virtual machine or in a containerized environment. 

To get started with deployment, see [Deployment Overview]({{base_path}}/install-and-setup/setup/deployment-overview)

## Setup

Setting up involves doing the required configurations for the API Manager and its components before running them in the production environment. The following are some common set up tasks that you are required to do separately for each component.

In addition, there are component-specific setup tasks. For more information, see [Setup Overview]({{base_path}}/install-and-setup/setup/setup-overview).

## SSO

This section explains how to configure Single Sign On (SSO) for the WSO2 API Manager.

WSO2 API Manager uses the OIDC Single Sign-On feature by default. Alternatively, you can configure WSO2 Identity Server or OKTA as the external identity provider.
## Advanced confuguration

## References

This subsection contains some reference information related to installing and setting up WSO2 API Manager

## Upgrade

This covers several scenarios that involve upgrading from an older version of WSO2 API Manager to a newer version.

## Kubernetes operators

This covers all topics related to the Kubernetes API Operator.

## API Controller

WSO2 API Controller(CTL) is a command-line tool for managing API Manager environments, listing APIs, API products and applications, creating API projects, importing and exporting APIs, API products and applications, generating tokens for APIs and API products for testing purposes, etc. and managing WSO2 Micro Integrator.

This section covers how to download, install and set up the API Controller.
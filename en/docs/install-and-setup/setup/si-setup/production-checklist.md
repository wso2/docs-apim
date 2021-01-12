# Production Checklist

Once you download and install WSO2 Streaming Integrator, you may need to update its default configurations based on your requirements.

The changes that you need to make include the following:

## Providing access

Multiple users with various roles in your organization can require access to your WSO2 Streaming Integrator installation to carry out different activities. In order to manage the level of access provided to each user based on their roles, you are required to configure users roles and permissions. For instructions, see [User Management]({{base_path}}/install-and-setup/setup/si-setup/user-management).

## Securing the Streaming Integrator

WSO2 SI is an open-source product. Therefore, anyone who downloads it has access to the default users and passwords, default keystore settings, etc. Therefore, you are required to update the configurations related to security in order to ensure that your data is secure when you run WSO2 SI in a production environment. For more information, see the following topics:

- WSO2 uses key stores to store cryptographic keys and certificates that are used for various purposes. For more information on how to configure and manage them, see [Working with Keystores]({{base_path}}/install-and-setup/setup/si-setup/working-with-keystores).
- To protect sensitive data, see [Protecting Sensitive Data via the Secure Vault](https://ei.docs.wso2.com/en/latest/streaming-integrator/admin/protecting-sensitive-data-via-the-secure-vault/).
- To understand how WSO2 Streaming Integrator complies with GDPR(General Data Protection Regulations) and how you can comply with the same when you are using WSO2 Streaming Integrator, see [General Data Protection Regulations]({{base_path}}/install-and-setup/setup/si-setup/general-data-protection-regulations).

## Opening the required ports

This involves configuring the network firewall for opening the ports used by WSO2 Streaming Integrator. For more information about the required ports, see [Configuring Default Ports]({{base_path}}/install-and-setup/setup/si-setup/configuring-default-ports).

## Setting up databases

If you are integrating data stores in your Streaming Integration flows, you need to set up databases. For information about supported database types and how to configure data sources for them, see [Configuring Datasources]({{base_path}}/install-and-setup/setup/si-setup/configuring-data-sources.).

## Configuring Transports

In order to use certain transports to receive and send data, you are required to configure them with WSO2 Streaming Integrator. For more information, see [Supporting Different Transports]({{base_path}}/install-and-setup/setup/si-setup/supporting-different-transports).

## Minimizing the impact of system failure

In order to minimize the loss of data that can result from a system failure, you can configure WSO2 Streaming Integrator to periodically save its state in a database. For more information, see [Configuring Database and File System State Persistence]({{base_path}}/install-and-setup/setup/si-setup/configuring-database-and-file-system-state-persistence).

## Creating Business Rules templates

If you want to allow business users with limited coding knowledge to write business rules, you can template Siddhi applications and queries. For more information, see [Working with Business Rules]({{base_path}}/install-and-setup/setup/si-setup/creating-business-rules-templates).

## Monitoring the Streaming Integrator

To monitor the performance of your Streaming Integrator setup, configure WSO2 SI to publish its statistics in Dashboards as described in [Configuring Grafana Dashboards]({{base_path}}/install-and-setup/setup/si-setup/setting-up-grafana-dashboards).




 

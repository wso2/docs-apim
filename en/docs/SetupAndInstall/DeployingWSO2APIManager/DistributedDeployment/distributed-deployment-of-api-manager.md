# Distributed Deployment of API Manager

[WSO2 API Manager](http://wso2.com/products/api-manager/) (WSO2 API-M) is a complete API management solution, used for creating and publishing APIs, creating and managing a developer community, and routing API traffic scalably. The WSO2 API-M includes the following five components: Publisher, Store, Gateway, Key Manager, and Traffic Manager.

Typically, when you get started with WSO2 API Manager in a development environment, you deploy WSO2 API Manager as a single instance with all its components on a single server. For details, see \_Deploying API Manager using Single Node Instances .

However, in a production deployment, these components are deployed in a distributed manner. Therefore, you can create a distributed deployment of WSO2 API-M's five main components. This page describes how to set up and deploy WSO2 API-M as a distributed deployment.

!!! note
Note that your configurations may vary depending on the WSO2 API Manager deployment pattern that you choose. If you are using multi-tenancy, all nodes should use the same user store, as all servers are servicing the same set of tenants, and it has to share the same Governance Registry space across all nodes.


-   [Understanding the Distributed Deployment of WSO2 API-M](_Understanding_the_Distributed_Deployment_of_WSO2_API-M_)
-   [Deploying WSO2 API-M in a Distributed Setup](_Deploying_WSO2_API-M_in_a_Distributed_Setup_)


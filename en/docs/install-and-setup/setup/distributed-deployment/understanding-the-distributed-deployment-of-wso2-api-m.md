# API-M Distributed Deployment - Overview

Before deploying WSO2 API Manager (WSO2 API-M), let's understand how the WSO2 API-M distributed deployment works.
According to the recommended [deployment patterns]({{base_path}}/install-and-setup/setup/deployment-overview/#simple-scalable-deployment), a distributed deployment includes the WSO2 API Control Plane, WSO2 Universal Gateway and WSO2 Traffic Manager distributions. The relevant distributions only run specific components of API-M.

## API-M Component Distributions

Listed below are the different component distributions available in WSO2 API Manager solution. 

<table>
    <tr>
        <th>
            Distribution
        </td>
        <th>
            Description
        </td>
    </tr>
    <tr>
        <td>
            WSO2 API Control Plane
        </td>
        <td>
            Starts all the API-M components (Key Manager, Publisher, Developer Portal) excluding the Gateway and Traffic Manager.
        </td>
    </tr>
    <tr>
        <td>
            WSO2 Universal Gateway
        </td>
        <td>
            <p>Only starts the components related to the API Gateway.</p>
            <p>This distribution starts the back-end features for data processing.</p>
        </td>
    </tr>
    <tr>
        <td>
            WSO2 Traffic Manager
        </td>
        <td>
            Only starts the Traffic Manager component.
        </td>
    </tr>
</table>

## Databases used by API-M Component Distributions

When you run the different distributions of API-M, databases are used as shown below.

<table>
<thead>
<tr class="header">
<th><br />
</th>
<th><p><strong>API Manager<br />
database</strong></p>
<p><code>              apimgtdb             </code></p>
<p><code>              WSO2_AM_DB             </code></p></th>
<th><p><strong>Shared Database</strong></p>
<p><code>                                            shareddb                           </code></p>
<p><code>              WSO2_SHARED_DB             </code></p></th>

</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><strong>WSO2 API Control Plane</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
</tr>
<tr class="even">
<td><p><strong>WSO2 Universal Gateway</strong></p></td>
<td><p>Not used</p></td>
<td><p>Used (in multi-tenancy mode/ in multiple gateway mode when Google Analytics is used)</p></td>

</tr>
<tr class="odd">
<td><strong>WSO2 Traffic Manager</strong></td>
<td>Used</td>
<td>Used</td>
</tr>
</tbody>
</table>

!!! Warning "WSO2 Universal Gateway - `shared_db` configuration"
    Note that the registry data source **should not** be completely removed from the gateway node, although the `shared_db` is not required for certain use cases. During server initialization, the user core and registry modules rely on the registry and user store pointing to the default H2 shared db or the H2-based carbon DB. Therefore, ensure that at least the registry and user store configurations are appropriately set.

## API-M Components

Listed below are the five main components in the API-M server. When you run the recommended API-M component distributions, the components (from the below list) that are required for operating the functionalities related to each distribution are used.

<table>
    <tr>
        <th>
            Component
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            Gateway
        </td>
        <td>
            Responsible for securing, protecting, managing, and scaling API calls.
        </td>
    </tr>
    <tr>
        <td>
            Key Manager
        </td>
        <td>
            Responsible for all security and key-related operations.
        </td>
    </tr>
    <tr>
        <td>
            Traffic Manager
        </td>
        <td>
            Responsible for making rate limiting decisions.
        </td>
    </tr>
    <tr>
        <td>
            Publisher Portal
        </td>
        <td>
            Enables API providers to easily publish their APIs, share documentation, provision API keys, and gather feedback on API features, quality, and usage.
        </td>
    </tr>
    <tr>
        <td>
            Developer Portal
        </td>
        <td>
            Enables consumers to self-register, discover API functionality, subscribe to APIs, evaluate them, and interact with API publishers.
        </td>
    </tr>
</table>

## Understanding the distributed deployment

In a typical distributed deployment, you only have the WSO2 API Control Plane, WSO2 Universal Gateway and WSO2 Traffic Manager distributions running as separate nodes. However, you have the option of separating the Key Manager from the WSO2 API Control Plane. With this, there are two patterns under which we can configure a distributed deployment for API-M. They are as follows.

### Simple Scalable Deployment

The following diagram depicts how the WSO2 API Control Plane, WSO2 Universal Gateway and WSO2 Traffic Manager communicate in a distributed deployment setup. It also depicts the database connections of each node.

[![Distributed deployment]({{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png){: style="width:78%"}]({{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png)

### Simple Scalable Deployment with Key Manager Separation

The following diagram depicts how the WSO2 API Control Plane, WSO2 Universal Gateway, WSO2 Traffic Manager nodes and WSO2 API Control Plane's Key Manager profile communicate in a distributed deployment setup. It also depicts the database connections of each node. Separating out the Key Manager Component from the API Control plane might be needed if any deployment complexities are present in your environment. To learn how to configure this deployment, refer [configuring a distributed API-M deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-km-separated).

[![Distributed deployment]({{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png){: style="width:78%"}]({{base_path}}/assets/img/setup-and-install/distributed-deployment-km.png)

## What's Next?

-   See the instructions on [configuring a distributed API-M deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).
-   See the instructions on [configuring a distributed API-M deployment with Key Manager separated]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-km-separated).

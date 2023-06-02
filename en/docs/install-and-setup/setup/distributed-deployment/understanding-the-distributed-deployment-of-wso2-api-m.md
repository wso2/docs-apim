# API-M Distributed Deployment - Overview

Before deploying WSO2 API Manager (WSO2 API-M), let's understand how the WSO2 API-M distributed deployment works.
According to the recommended [deployment patterns]({{base_path}}/install-and-setup/setup/deployment-overview/#simple-scalable-deployment), a distributed deployment includes API-M server nodes that separately run the [API-M profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles). An API-M profile is a server instance that only runs specific components of the API-M server.

## API-M Profiles

Listed below are the different profiles available in WSO2 API Manager. 

<table>
    <tr>
        <th>
            Profile
        </td>
        <th>
            Description
        </td>
    </tr>
    <tr>
        <td>
            Gateway Profile
        </td>
        <td>
            <p>Only starts the components related to the API Gateway.</p>
            <p>This profile starts the back-end features for data processing.</p>
        </td>
    </tr>
    <tr>
        <td>
            Control Plane Profile
        </td>
        <td>
            Starts all the API-M components (Traffic Manager, Key Manager, Publisher, Developer Portal) excluding the Gateway.
        </td>
    </tr>
    <tr>
        <td>
            Traffic Manager Profile
        </td>
        <td>
            Only starts the Traffic Manager component.
        </td>
    </tr>
</table>

## Databases used by API-M profiles

When you run the API-M server as separate profiles, databases are used as shown below.

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
<td><p><strong>Control Plane profile</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
</tr>
<tr class="even">
<td><p><strong>Gateway profile</strong></p></td>
<td><p>Not used</p></td>
<td><p>Used (in multi-tenancy mode/ in multiple gateway mode when Google Analytics is used)</p></td>

</tr>
<tr class="odd">
<td><strong>Traffic Manager profile</strong></td>
<td>Used</td>
<td>Used</td>

</tr>
</tbody>
</table>

!!! Warning "Gateway Profile - `shared_db` configuration"
    Note that the registry data source **should not** be completely removed from the gateway node, although the `shared_db` is not required for certain use cases. During server initialization, the user core and registry modules rely on the registry and user store pointing to the default H2 shared db or the H2-based carbon DB. Therefore, ensure that at least the registry and user store configurations are appropriately set.

## API-M Components

Listed below are the five components in the API-M server. When you run the recommended API-M profiles, the components (from the below list) that are required for operating the functionalities related to each profile are used.

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
            Used to make a decision on throttling. It also works as an event hub for broadcasting controller events such as throttling events, block conditions, revoke token retrieval events, API events, API policy events, application events, application policy events, application keys events, subscription events, and subscription policy events.
        </td>
    </tr>
    <tr>
        <td>
            Publisher
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

In a typical distributed deployment, all API-M components (excluding the API-M Gateway) run in the Control Plane. However, you have the option of separating the Traffic Manager from the Control Plane. With this, there are two patterns under which we can configure a distributed deployment for API-M. They are as follows.

### Simple Scalable Deployment

The following diagram depicts how the Control Plane and Gateway profiles communicate in a distributed deployment setup, and also the database connections of each node. To learn how to configure this deployment, refer [configuring a distributed API-M deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).

[![Distributed deployment]({{base_path}}/assets/img/setup-and-install/distributed-deployment-no-tm.png){: style="width:57%"}]({{base_path}}/assets/img/setup-and-install/distributed-deployment-no-tm.png)

### Simple Scalable Deployment with Traffic Manager Separation

The following diagram depicts how the Control Plane, Traffic Manager, and Gateway profiles communicate in a distributed deployment setup. It also depicts the database connections of each node. Separating out the Traffic Manager Component from the Control plane might be needed if any deployment complexities are present in your environment. To learn how to configure this deployment, refer [configuring a distributed API-M deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-tm-separated).

[![Distributed deployment]({{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png){: style="width:78%"}]({{base_path}}/assets/img/setup-and-install/distributed-deployment-tm.png)

## What's Next?

-   Find out more about [running API-M profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles).
-   See the instructions on [configuring a distributed API-M deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).
-   See the instructions on [configuring a distributed API-M deployment with Traffic Manager separated]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup-with-tm-separated).

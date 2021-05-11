# API-M Distributed Deployment - Overview

Before deploying WSO2 API Manager (WSO2 API-M), let's understand the WSO2 API-M distributed deployment better. 

## API-M Components

The WSO2 API-M runtime consists of five main components, which carry out different functions.

<a href="{{base_path}}/assets/img/setup-and-install/api-m-components.png"><img src="{{base_path}}/assets/img/setup-and-install/api-m-components.png" alt="api-m components"></a>

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

## Databases for API-M components

WSO2 API Manager components use the databases given below. Find out more about [databases in API-M]({{base_path}}/install-and-setup/setup/setting-up-databases/overview).

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
<td><p><strong>Publisher</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>

</tr>
<tr class="even">
<td><p><strong>Developer Portal</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>

</tr>
<tr class="odd">
<td><p><strong>Key Manager</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
</tr>
<tr class="even">
<td><p><strong>Gateway</strong></p></td>
<td><p>Not used</p></td>
<td><p>Used (in multi-tenancy mode/ in multiple gateway mode when Google Analytics is used)</p></td>

</tr>
<tr class="odd">
<td><strong>Traffic Manager</strong></td>
<td>Used</td>
<td>Used</td>

</tr>
</tbody>
</table>

## How the API-M components work

In a distributed deployment, some of these components are run in separate API-M servers as [API-M profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles). The Gateway component is always run on one server. The Key Manager, Publisher Portal, Developer Portal, and the Traffic Manager components are typically run in one API-M server. However, you have the option of running the Traffic Manager component in a separate API-M server. 

For high availability, these API-M servers are deployed in clusters. 

-   Find out more about [API-M profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles).
-   See the instructions on [Configuring a Distributed API-M Deployment]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).

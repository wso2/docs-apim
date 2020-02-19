# Understanding the Distributed Deployment of WSO2 API-M

Before understanding how to deploy WSO2 API Manager (WSO2 API-M), let's understand the WSO2 API-M distributed deployment better.

## Understanding the WSO2 API-M architecture

WSO2 API Manager uses the following main components:

|                     |                                                                                                                                                       |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Publisher**       | Enables API providers to easily publish their APIs, share documentation, provision API keys, and gather feedback on API features, quality, and usage. |
| **Developer Portal**           | Enables consumers to self-register, discover API functionality, subscribe to APIs, evaluate them, and interact with API publishers.                   |
| **Key Manager**     | Responsible for all security and key-related operations.                                                                                              |
| **Gateway**         | Responsible for securing, protecting, managing, and scaling API calls.                                                                                |
| **Traffic Manager** | Used to make a decision on throttling.                                                                                                                |

For more information on the above, see the main components of a distributed system.

Additionally, API Manager uses the following databases, which are shared among the server nodes.

-   **User Manager database** - Stores information related to users and user roles. This information is shared among the Key Manager Server, Developer Portal, and Publisher. Users can access the Publisher for API creation and the Developer Portal for consuming the APIs. The User Manager database is also referred to as **WSO2UM\_DB** and **userdb**.
-   **API Manager database** - Stores information related to the APIs along with the API subscription details. The Key Manager Server uses this database to store user access tokens that are used for verification of API calls. The API Manager database is also referred to as **WSO2\_AM\_DB** and **apimgtdb**.
-   **Registry database** - Shares information between the Publisher and Developer Portal. When an API is published through the Publisher, it is made available in the Developer Portal via the shared registry database. Although you would normally share information between the Publisher and Developer Portal components only, if you are planning to create this setup for a multi-tenanted environment (create and work with tenants), it is required to share the information in this database between the Gateway and Key Manager components as well. The Registry database is also referred to as **WSO2REG\_DB** and **regdb**.
-   **Statistics database** - Stores information related to API statistics. After you [configure API-M analytics]({{base_path}}/Learn/Analytics/configuring-apim-analytics/), it writes summarized data to this database. The Publisher and Developer Portal can then query this database to display the statistics data. The **Statistics database** is also referred to as **WSO2\_STAT\_DB** and **statdb**.
-   **Message Broker database** - Traffic Manager uses this database as the message store for broker when [advanced throttling]({{base_path}}/Learn/RateLimiting/introducing-throttling-use-cases/) is used. The Message Broker DB is also referred to as **WSO2\_MB\_STORE\_DB** and **mbstoredb**.

WSO2 API Manager components use the databases as follows:

<table>
<thead>
<tr class="header">
<th><br />
</th>
<th><p><strong>API Manager<br />
database</strong></p>
<p><code>              apimgtdb             </code></p>
<p><code>              WSO2_AM_DB             </code></p></th>
<th><p><strong>User Manager<br />
</strong> <strong>Database<br />
</strong></p>
<p><strong><code>               userdb              </code></strong></p>
<p><code>                             WSO2UM_DB                           </code></p></th>
<th><p><strong>Registry Database</strong></p>
<p><code>                                            regdb                           </code></p>
<p><code>              WSO2REG_DB             </code></p></th>
<th><p><strong>Statistics<br />
Database</strong><br />
<br />
<strong>statdb</strong></p>
<p><code>              WSO2_STAT_DB             </code></p></th>
<th><p><strong>Message Broker<br />
Database<br />
</strong><br />
<strong>mbstoredb</strong></p>
<p><code>              WSO2_MB_STORE_DB             </code></p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><strong>Publisher</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
<td>Used</td>
<td>Not used</td>
</tr>
<tr class="even">
<td><p><strong>Developer Portal</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
<td>Used</td>
<td>Not used</td>
</tr>
<tr class="odd">
<td><p><strong>Key Manager</strong></p></td>
<td><p>Used</p></td>
<td><p>Used</p></td>
<td><p>Used (in multi-tenancy mode)</p></td>
<td>Not used</td>
<td>Not used</td>
</tr>
<tr class="even">
<td><p><strong>Gateway</strong></p></td>
<td><p>Not used</p></td>
<td><p>Used (in multi-tenancy mode)</p></td>
<td><p>Used (in multi-tenancy mode/ in multiple gateway mode when Google Analytics is used)</p></td>
<td>Not used</td>
<td>Not used</td>
</tr>
<tr class="odd">
<td><strong>Traffic Manager</strong></td>
<td>Not used</td>
<td>Not used</td>
<td>Not used</td>
<td>Not used</td>
<td>Used</td>
</tr>
</tbody>
</table>

!!! note
    -   Although the Gateway does not use the WSO2 API Manager database, this connection is required; therefore, do not remove the default configuration in the `<API-M_HOME>/repository/conf/datasources/master-datasources.xml` file. This connection should be your default database.
    -   The Gateway node creates a connection at the startup with the WSO2 API Manager database, but this connection will not be used later on.
    -   If you have more than one Traffic Manager node, each Traffic Manager node must have its own Message Broker database (`WSO2_MB_STORE_DB)`.

When we consider a distributed deployment of WSO2 API Manager, we have the option of separating the five components and clustering each component as needed. Let's look more closely at how the API Manager components are deployed separately.

## Understanding the distributed deployment

In the following diagram, the five components are set up in a distributed deployment, and the five databases are connected to the relevant components respectively. The entire setup is also fronted by a load balancer.

!!! note
    In a clustered setup, if the **Key Manager** is **NOT fronted by a load balancer**, you have to set the `KeyValidatorClientType` element to `ThriftClient` in the `<API-M_HOME>/repository/conf/api-manager.xml` file, to enable Thrift as the communication protocol. You need to configure this in all the Gateway and Key Manager components.


![]({{base_path}}/assets/attachments/103334484/103334485.png)



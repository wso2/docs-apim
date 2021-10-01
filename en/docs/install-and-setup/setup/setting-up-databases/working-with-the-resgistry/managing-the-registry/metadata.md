# Metadata

**The Metadata panel** allows you to manage resource metadata and revisions using the [Create Checkpoint](#Metadata-Checkpoint) and [View Versions](#Metadata-Versions) options. Each time you create a check point, it is added as a new reversion of the resource. Revisions is a useful way to facilitate Disaster Recovery and Fault Tolerance in the registry. By creating a revision, a user essentially saves a snapshot of the current state of a resource or collection that can be restored at a later date. The registry's checkpoint and restoration mechanisms are similar to that of System Restore of Microsoft Windows.

The **Metadata** panel displays the following properties of the resource or the collection:

-   **Created** - Time the resource was created and the author of the resource.
-   **Last Updated** - Time the resource was updated and the author of the alterations.
-   **Media Type** - An associated Media type of the resource/collection. For more information about Media types, see [Adding a Resource](https://docs.wso2.com/display/ADMIN44x/Adding+a+Resource) .
-   **Checkpoint** - Allows to create a checkpoint (URL for the permanent link) of a resource/collection.
-   **Versions** - Allows to view versions of a resource/collection.
-   **Permalink** - Holds the resource URL in both HTTP and HTTPS. (e.g., `http://10.100.2.76:9763/registry/resource/_system/governance/trunk/services/test` )
-   **Description** - Description of the resource/collection.

For example,

![]({{base_path}}/assets/attachments/22185146/22514191.png)
#### Creating a checkpoint

To create a checkpoint, click on the **Create Checkpoint** link:

![]({{base_path}}/assets/attachments/126562605/126562606.png)

!!! info
**NOTE** : When checkpoints are created, properties, comments, ratings and tags will also be taken into consideration. If you do not want them to be versioned along with resource content, you can disable it by making changes to the [Static Configuration](https://docs.wso2.com/display/Governance460/Configuration+for+Static+%28One-time%29+and+Auto+Versioning+Resources) . However, these changes need to be done before the server starts for the first time.


#### Viewing Versions

To view the resource versions, click on the **View versions** link:

![]({{base_path}}/assets/attachments/126562605/126562611.png)

It opens the versions. For example,

![]({{base_path}}/assets/attachments/22185146/22514195.png)
This page gives the following information:

-   The number of a resource/collection version
-   Last date of modifications and the author who did the last alterations
-   **Actions**
    -   **Details** - Opens the **Browse** page of a resource/collection version to view its details
    -   **Restore** - Restores a selected version
    -   **Delete Version History** - Delete the version history

!!! info
    To learn more about restoring to a previous version, see  read [here](https://docs.wso2.com/display/Governance460/Managing+Versions+of+a+Resource).

!!! info
    **NOTE**: Versions and checkpoints are not available for [Symbolic Links](https://docs.wso2.com/display/Governance460/Link+Creation#LinkCreation-ASymbolicLink) and [Remote Links](https://docs.wso2.com/display/Governance460/Link+Creation#LinkCreation-ARemoteLink).


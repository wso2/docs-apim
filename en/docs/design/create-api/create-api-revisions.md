# Create API Revisions

If you are an API Publisher there can be a situation where you need to keep track of the different deployments of your API. For this purpose, a new concept called **Revisions** has been introduced. The revisions of your API can be **deployed** to specific Gateway Environment(s) as needed. These revisions cannot be edited and you can even **restore** your API to a specific revision if you want to discard latest changes.

## Create a new revision

You can follow the steps below to create a new revision from your existing API.

1.  Access the Publisher Portal [https://localhost:9443/publisher](https://localhost:9443/publisher)
2.  From the Left Menu go to **Deployments**.
3.  Click on the **Create a new revision** button.

    ![Create New Revision Button]({{base_path}}/assets/img/design/revision/create-new-revision-button.png)

4.  Provide a description for the revision if required.
5.  Click on **Create**.

    ![Create New Revision]({{base_path}}/assets/img/design/revision/create-revision.png)

!!! warning
    You cannot create more than 5 revisions. If you want to create a new revision after the maximum allowed number of revisions is reached, a previous revision should be deleted.

    ![Delete revision if max count is reached]({{base_path}}/assets/img/design/revision/delete-and-create-revision.png)

## Deploy a revision

You can either deploy a new revision or deploy an existing revision in a given Gateway Environment.

### Deploy a new revision

Follow the steps below if you need to **deploy a new revision** on a given Gateway Environment.

1. From the Left Menu in the Publisher Portal, go to **Deployments**.
2. Click on the **Deploy New Revision** button.

    ![Deploy a new revision]({{base_path}}/assets/img/design/revision/deploy-new-revision.png)

3. Provide a description for the new revision.
4. Select one or more Gateway Environments from the environments listed.
5. Click on **Deploy**.

    ![Deploy a new revision view]({{base_path}}/assets/img/design/revision/deploy-new-revision-example.png)

### Deploy an existing revision

Follow the steps below if you need to **deploy an existing revision** on a given Gateway Environment.

1. From the Left Menu in the Publisher Portal, go to **Deployments**.
2. Select the required revision from the drop down menu under **Deployed Revision** column under API Gateways or Gateway Labels.
3. Click on the **Deploy** button.

![Deploy an existing revision]({{base_path}}/assets/img/design/revision/deploy-existing-revision.png)

## Undeploy a revision

Follow the steps below if you need to undeploy a revision from a Gateway Environment.

1. From the Left Menu in the Publisher Portal, go to **Deployments**.
2. Click on the **Undeploy** button against the specific Gateway Environment from which you want to undeploy the revision.

![Undeploy a revision]({{base_path}}/assets/img/design/revision/undeploy-revision.png)

## Delete a revision

If you need to delete a specific revision click on the **Delete** button in the revision list as shown below. If a revision is already deployed in a specific environment, you cannot delete it. You should first undeploy the revision from the Gateway Environment and then delete.

![Delete a revision]({{base_path}}/assets/img/design/revision/delete-revision.png)

## Restore a revision

If you need to restore a specific revision click on the **Restore** button in the revision list as shown below. This will restore the revision in to the working copy.

![Restore a revision]({{base_path}}/assets/img/design/revision/restore-revision.png)

# Create API Revisions

If you are an API Publisher, there can be a situation where you need to keep track of the different deployments of your API. For this purpose, a new concept named **Revisions** has been introduced. The revisions of your API can be **deployed** to specific Gateway Environment(s) as needed. These revisions cannot be edited and you can even **restore** your API to a specific revision if you want to discard the latest changes.

## Create a new revision

Follow the instructions below to create a new revision from your existing API:

1.  Sign in to the Publisher.

     [https://localhost:9443/publisher](https://localhost:9443/publisher)

2.  Click **Deployments**.
3.  Click **Create a new revision**.

     [![Create a new revision button]({{base_path}}/assets/img/design/revision/create-new-revision-button.png)]({{base_path}}/assets/img/design/revision/create-new-revision-button.png)

4.  Provide a description for the revision if required.
5.  Click on **Create**.

     [![Create new revision]({{base_path}}/assets/img/design/revision/create-revision.png)]({{base_path}}/assets/img/design/revision/create-revision.png)

!!! warning
    You cannot create more than 5 revisions. If you want to create a new revision after the maximum allowed number of revisions are reached, you need to delete a previous revision.

     [![Delete revision if max count is reached]({{base_path}}/assets/img/design/revision/delete-and-create-revision.png)]({{base_path}}/assets/img/design/revision/delete-and-create-revision.png)

## Deploy a revision

Follow the instructions below to either deploy a new revision or deploy an existing revision in a given Gateway Environment:

### Deploy a new revision

Follow the steps below if you need to **deploy a new revision** on a given Gateway Environment:

1. Sign in to the Publisher.

     [https://localhost:9443/publisher](https://localhost:9443/publisher)

2. Click **Deployments**.

3. Click **Deploy New Revision**.

     [![Deploy a new revision]({{base_path}}/assets/img/design/revision/deploy-new-revision.png)]({{base_path}}/assets/img/design/revision/deploy-new-revision.png)

4. Provide a description for the new revision.
5. Select one or more Gateway Environments from the environments listed.
6. Click **Deploy**.

     [![Deploy a new revision view]({{base_path}}/assets/img/design/revision/deploy-new-revision-example.png)]({{base_path}}/assets/img/design/revision/deploy-new-revision-example.png)

### Deploy an existing revision

Follow the instructions below if you need to **deploy an existing revision** on a given Gateway Environment:

1. Sign in to the Publisher.

     [https://localhost:9443/publisher](https://localhost:9443/publisher)

2. Click **Deployments**.
3. Select the required revision from the **Deployed Revision** drop-down menu.
4. Click on the **Deploy** button.

     [![Deploy an existing revision]({{base_path}}/assets/img/design/revision/deploy-existing-revision.png)]({{base_path}}/assets/img/design/revision/deploy-existing-revision.png)

## Undeploy a revision

Follow the instructions below if you need to undeploy a revision from a Gateway Environment:

1. Sign in to the Publisher.

     [https://localhost:9443/publisher](https://localhost:9443/publisher)

2. Click **Deployments**.
3. Click on the **Undeploy** button that appears against the respective Gateway Environment from which you want to undeploy the revision.

     [![Undeploy a revision]({{base_path}}/assets/img/design/revision/undeploy-revision.png)]({{base_path}}/assets/img/design/revision/undeploy-revision.png)

## Delete a revision

If you need to delete a specific revision, click on the **Delete** button in the revision list as shown below. If a revision is already deployed in a specific environment, you cannot delete it. You should first undeploy the revision from the Gateway Environment and then delete it.

[![Delete a revision]({{base_path}}/assets/img/design/revision/delete-revision.png)]({{base_path}}/assets/img/design/revision/delete-revision.png)

## Restore a revision

If you need to restore a specific revision, click on the **Restore** button in the revision list as shown below. This will restore the revision in to the working copy.

[![Restore a revision]({{base_path}}/assets/img/design/revision/restore-revision.png)]({{base_path}}/assets/img/design/revision/restore-revision.png)

# API Revisions

In previous versions of WSO2 API Manager, API publishing and deployment in Gateways were tightly coupled. 
[Publishing]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api/) will display the 
API in the Developer Portal and [deployment]({{base_path}}/deploy-and-publish/deploy-on-gateway/deploy-api/deploy-an-api/) 
will make the API available for invocation via a Gateway. With the API Life cycle, whenever the publisher promote an API to published state, 
API will be displayed in the Developer Portal as well as deployed in the specified Gateway environments. Publisher only had two 
options regarding the deployment. Either to deploy the current state of the API in a Gateway or not deploy at all. 
With the Publisher Test Console, there was a space to test the API before publish and deployment, however it does not provide the option to test in an 
actual Gateway with the runtime configurations. Making such changes to an API without proper testings and especially if 
the changes are reflected instantly in the Developer Portal and all the serving Gateways, is not a good approach for a production setup.  

With the introduction of API and API Product Revisions, previously coupled publishing and deployment operations have been **decoupled**.
The API publisher has more control over the API deployments and has the ability to introduce recoverable changes to the API project. 
API revisions are similar to a checkpoint in time capturing the current state of the API when the revision is created. If the changes
has an adverse effect to the API once it is deployed in an Gateway environment, you can quickly recover to the previous state of the API.
In addition to that, even if the you want to test out a new run time configuration, this concept provides the ability to test it in
an independent Gateway before applying the same change to all the Gateways.  

## Architectural changes and key features

The revision feature brings few architectural changes to the previous versions of WSO2 API Manager.

1. Changing the life cycle state to publish will only display the API in Developer Portal and will not handle the deployment anymore.
2. Deploying an API in a Gateway requires an additional step. Publisher has to create a revision and deploy that revision in the required Gateway environments.
3. A single API or API Product can have multiple revisions (a maximum of 5 and once the max limit is reached, you have to delete a revision before creating a new one). 
4. If there are multiple Gateways, you have the option to deploy the same revision across all the Gateways or different revisions of the API in each. (each Gateway will handle the API requests differently based on the deployed revision).
5. Create and deploy the API in a Gateway without changing the lifecycle state to Published.
6. The revisions cannot be edited.
7. To discard the latest changes, you have the ability to **restore** the API to a specific revision.

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

When you are updating the API from the Publisher console, you are updating the working copy of the API. A change in a mediation policy, 
a change in security configurations, a change to a documentation or simply changing the description of the API will deviate 
the working copy of the API from the latest revision. If the API is in published state, working copy of the API is 
displayed at the Developer Portal. If you need to revert these changes and restore a specific revision, click on the **Restore** 
button in the revision list as shown below. This will restore the revision in to the working copy overriding the changes done in the working copy.
Since restore will only update the working copy in the the Publisher and Developer Portal, it does not have any effect on the deployed revisions. 

[![Restore a revision]({{base_path}}/assets/img/design/revision/restore-revision.png)]({{base_path}}/assets/img/design/revision/restore-revision.png)

!!!note
        If you have not made a revision of the latest changes before restoring a previous revision, changes in the working copy will be lost. 

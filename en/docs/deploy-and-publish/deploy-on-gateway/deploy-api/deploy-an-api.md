# Deploy an API

**API Deploying** is the process of making the API available for invocation via a gateway. You can deploy an API to a selected API Gateway environment via the Publisher Portal. To invoke an API, it needs to be PUBLISHED on the developer portal as well as deployed on a gateway environment. You need to create a revision of an API in order to deploy it.

**Undeploying an API**  will remove the API from the API Gateway Environment.

Follow the steps below to deploy an API using WSO2 API Manager.

# Step 1 - Create a new revision

1.  Sign in to the Publisher.

     [https://localhost:9443/publisher](https://localhost:9443/publisher)

2.  Click **Deployments**.
3.  Click **+**.

     [![Create a new revision button]({{base_path}}/assets/img/design/revision/create-new-revision-button.png)]({{base_path}}/assets/img/design/revision/create-new-revision-button.png)

4.  Provide a description for the revision if required.
5.  Click on **Create**.

     [![Create new revision]({{base_path}}/assets/img/design/revision/create-revision.png)]({{base_path}}/assets/img/design/revision/create-revision.png)

!!! warning
    You cannot create more than 5 revisions. If you want to create a new revision after the maximum allowed number of revisions are reached, you need to delete a previous revision.

     [![Delete revision if max count is reached]({{base_path}}/assets/img/design/revision/delete-and-create-revision.png)]({{base_path}}/assets/img/design/revision/delete-and-create-revision.png)

# Step 2 -  Deploy the revision

1. Sign in to the Publisher.

     [https://localhost:9443/publisher](https://localhost:9443/publisher)

2. Click **Deployments**.

3. Click **Deploy New Revision**.

     [![Deploy a new revision]({{base_path}}/assets/img/design/revision/deploy-new-revision.png)]({{base_path}}/assets/img/design/revision/deploy-new-revision.png)

4. Provide a description for the new revision.
5. Select one or more Gateway Environments from the environments listed.
6. Click **Deploy**.

     [![Deploy a new revision view]({{base_path}}/assets/img/design/revision/deploy-new-revision-example.png)]({{base_path}}/assets/img/design/revision/deploy-new-revision-example.png)


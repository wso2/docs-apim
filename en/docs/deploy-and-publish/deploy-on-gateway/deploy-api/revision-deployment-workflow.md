# Revision Deployment Workflow

This section let's see how to add a simple approval workflow to control the deployment of revisions in WSO2 API Manager. With revisions deployment workflow enabled a gateway can have a deployed revision and a pending revision. The developer has the ability to send a revision deployment request to a desired gateway.

## Engaging the Approval Workflow Executor in API Manager

1. Enable the API state change workflow for the **Approval Workflow Executor**.

    1. Sign in to the API-M management console(`https://<Server Host>:9443/carbon`).

    2. Click **Resources** --> **Browse**.

       [![Resources Browse Menu]({{base_path}}/assets/img/learn/wf-extensions-browse.png)]({{base_path}}/assets/img/learn/wf-extensions-browse.png)

    3. Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource.

    4. Disable the `Simple Workflow Executor` and enable the `Approval Workflow Executor`.

       <a name="config"></a>
       ```
       <WorkFlowExtensions>
           ....
       <!--APIRevisionDeployment executor="org.wso2.carbon.apimgt.impl.workflow.
       APIRevisionDeploymentSimpleWorkflowExecutor"/-->
        <APIRevisionDeployment executor="org.wso2.carbon.apimgt.impl.workflow.
       APIRevisionDeploymentApprovalWorkflowExecutor"/>
           ....
       </WorkFlowExtensions>
       ```

       You have now engaged the revision deployment approval Workflow.

2.  Trigger an deploy a revision request.

    1. Sign in to the API Publisher (`https://<Server-Host>:9443/publisher`) and click the relevant API and go to deployments tab.

    2. Select a revision and click the deploy button.

    A pending revision chip will be displayed in the next revision column because the workflow is enabled for deploy a revision.

    ![Deployment Pending]({{base_path}}/assets/img/deploy/pending-revision.png)

    !!! info
    Note that when clicking the Deploy New Revision button, a gateway with a pending request will be disabled for selection until the workflow task is completed or deleted.
    ![Deploy New Revision Disabled]({{base_path}}/assets/img/deploy/pending-deploy-new-revision-tab.png)

    4. Optionally, you can revoke the deployment revision change by clicking **Cancel**.

       [![Delete pending task]({{base_path}}/assets/img/deploy/delete-revision-deployment-request.png)]({{base_path}}/assets/img/deploy/delete-revision-deployment-request.png)

3. Approve or reject the API state change pending request.

    1. Sign in to the Admin Portal(`https://<Server Host>:9443/admin`)

    2. Click **Tasks** --> **API Revision Deployment**.

       The list of API revision deployment tasks awaiting for approval appears.

    3. Click on **Approve** or **Reject** to approve or reject the pending API revision deployment request(s).

       [![API revision deployment pending list]({{base_path}}/assets/img/deploy/revision-deployment-pending-list.png)]({{base_path}}/assets/img/deploy/revision-deployment-pending-list.png)

4. View the outcome of the updated API revision deployment request.

    1. Navigate to the API Publisher (`https://<Server-Host>:9443/publisher`).

    2. Click **Deployments**.

       Notice that the API revision deployment is updated.

        - If the request was approved, the revision will be deployed to the selected gateway.
        - If the request was rejected, the deployment to the gateway will not happen.

       [![API revision deployment updated list]({{base_path}}/assets/img/deploy/revision deployment-updated-status.png)]({{base_path}}/assets/img/deploy/revision deployment-updated-status.png)

   !!! info
   You can send another pending request while there is a deployment is done to certain gateway. This will not undeploy the current revision until the new request is approved. As mentioned above you can cancel the second pending request or undeploy the current revision as you like.
   [![API gateway with a deployed and a pending revision]({{base_path}}/assets/img/deploy/deployed-and-pending-revisions.png)]({{base_path}}/assets/img/deploy/deployed-and-pending-revisions.png)
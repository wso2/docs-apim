# Adding an API State Change Workflow

This section explains how to add a custom workflow to control the API state changes in the API Manager. Before you begin, see [Workflow Extensions]({{base_path}}/learn/extensions/managing-workflow-extension/invoking-the-api-manager-from-the-bpel-engine) for more information on the different types of workflow executors, and also, see [API Lifecycle]({{base_path}}/getting-started/key-concepts#api-lifecycle) to get a better understanding on the API states.


### Engaging the Approval Workflow Executor in the API Manager

First, enable the API state change workflow for **Approval Workflow Executor**.

1.  Sign in to the APIM management console (`https://<Server Host>:9443/carbon`).

2. Click **Resources** --> **Browse**.
     
     [![Resources Browse Menu]({{base_path}}/assets/img/learn/wf-extensions-browse.png)]({{base_path}}/assets/img/learn/wf-extensions-browse.png)

3.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the Simple Workflow Executor and enable Approval Workflow Executor.

    ```
    <WorkFlowExtensions>
        ....
    <!--APIStateChange executor="org.wso2.carbon.apimgt.impl.workflow.APIStateChangeSimpleWorkflowExecutor" /-->
    <APIStateChange executor="org.wso2.carbon.apimgt.impl.workflow.APIStateChangeApprovalWorkflowExecutor">
        <Property name="stateList">Created:Publish,Published:Block</Property>
    </APIStateChange>
        ....
    </WorkFlowExtensions>
    ```

    You have now engaged the API state change approval Workflow. The default configuration is set for the **Created to Publish** and **Published to Block** state changes. See [Advanced Configurations](#advanced-configurations) for information on configuring more state changes.

4.  Sign in to the API Publisher (`https://<Server Host>:9443/publisher`) and publish an API. 

     For more information, see [Create a REST API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) and [Publish an API]({{base_path}}/learn/design-api/publish-api/publish-an-api/). 
     
5. Click **Lifecycle**.

     A message related to the publish workflow will be displayed because the workflow is enabled for **Created to Publish** state change. 
     
     ![Lifecycle change pending]({{base_path}}/assets/img/learn/api-state-change-workflow-pending.png)

    !!! info
        Note that the **publish** button will be disabled in the overview page until the workflow task is completed or deleted. 
        ![Publish Disabled]({{base_path}}/assets/img/learn/api-state-change-publish-pending.png)

6.  You can revoke the state change by clicking **Delete Task**.

     ![Delete pending task]({{base_path}}/assets/img/learn/delete-api-state-change-request.png)

7.  Sign in to the Admin Portal (`https://<Server Host>:9443/admin`) 

8. Click **Tasks** --> **API State Change** to see the list of api state change tasks awaiting for approval.Click on approve or reject to approve or reject the API state change pending request.

     ![]({{base_path}}/assets/img/learn/api-state-change-pending-list.png)

9. Go back to the API Publisher Portal and see that the API state is updated. (If you approve the request it will update the status to new status and if you reject the request the status will stay unchanged.)

    ![]({{base_path}}/assets/img/learn/api-state-change-updated-status.png)

    !!! info
        Changes of the API state can be easily viewed through **Lifecycle**. 
        ![Lifecycle State]({{base_path}}/assets/img/learn/api-lifecycle-state.png)

The elements of the above configuration are explained below.

| Element name                                       | Description                                                                                                                                               |
|----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Enabled`| Enables the Admin Portal to approve state change tasks.                                                                                                   |
| `ServerUrl`| The URL of the BPMN server.                                                                                                                               |
| `ServerUser`| User accessing the BPMN REST API.                                                                                                                         |
| `ServerPassword`| Password of the user accessing the BPMN REST API.                                                                                                         |
| `WorkflowCallbackAPI` | The REST API invoked by the BPMN to complete the workflow.                                                                                                |
| `TokenEndPoint`| The API call to generate the access token is passed to the BPMN process. Once the access token is received, it is used to call the workflow callback API. |
| `DCREndPoint`| Endpoint to generate OAuth application. This application is used by the BPMN process to generate the token.                                               |
| `DCREndPointUser`| Endpoint user.                                                                                                                                            |
| `DCREndPointPassword` | Endpoint password.                                                                      f                                                                  |
| `stateList`| Mandatory          | This is a comma separated list of the current state and intended action. For example, Created:Publish,Published:Block 

The elements of the above configuration are explained below.
                                                                |

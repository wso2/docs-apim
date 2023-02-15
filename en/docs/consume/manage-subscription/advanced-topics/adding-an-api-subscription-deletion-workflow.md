# Adding an API Subscription Deletion Workflow

[Subscription Deletion]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/) will provide the capability to remove an already existing subscription. Attaching a custom workflow to the API subscription deletion, enables an admin to approve/reject the subscription deletion request made for an existing subscription. Note that only an admin is able to approve/reject a subscription deletion request.

When the API subscription deletion workflow is enabled, when the subscription deletion request is made, the subscription status is changed to the `DELETE_PENDING` state. In this state, a consumer can still invoke the API with the same subscription, using its production or sandbox keys, until the subscription deletion is approved. Once the subscription deletion request is approved the subscription will be deleted.

#### Engaging the Approval Workflow Executor in the API Manager

1.  Sign in to API Manager Management Console (`https://<Server Host>:9443/carbon`) and go to **Browse** under **Resources**.

    [![Workflow Extensions Browse]({{base_path}}/assets/img/learn/wf-extensions-browse.png)]({{base_path}}/assets/img/learn/wf-extensions-browse.png)

2.  Open the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource and click **Edit as text**. Disable the SubscriptionDeletionSimpleWorkflowExecutor and enable SubscriptionDeletionApprovalWorkflowExecutor. 
    ``` 
        <WorkFlowExtensions>
        ...
            <!--SubscriptionDeletion executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionDeletionSimpleWorkflowExecutor"/-->
            <ubscriptionDeletion executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionDeletionAprrovalWorkflowExecutor"/>
        ...
        </WorkFlowExtensions>
    ```

    The subscription deletion approval workflow executor is now engaged.


3.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click **Applications**. Select the application which has the subscriptions you wish to delete.

    [![Applications Overview Tab]({{base_path}}/assets/img/learn/application-overview.png)]({{base_path}}/assets/img/learn/application-overview.png)


4. Click **Subscriptions** to list the subscriptions of the application.
    
    [![Subscriptions Overview Tab]({{base_path}}/assets/img/learn/subscriptions-overview-tab.png)]({{base_path}}/assets/img/learn/subscriptions-overview-tab.png)

     
5.  Select the subscription which needs to be deleted and click the **DELETE** icon to open the **Subscription Delete** popup.

    [![Subscription Delete Popup]({{base_path}}/assets/img/learn/subscription-delete-popup-start.png)]({{base_path}}/assets/img/learn/subscription-delete-popup-start.png)

6.  Click **DELETE** to continue. After that you will see the subscription status as **DELETE_PENDING**.

    [![Subscription Delete Before Approval]({{base_path}}/assets/img/learn/subscription-delete-before-approval.png)]({{base_path}}/assets/img/learn/subscription-delete-before-approval.png)
    
7.  Sign in to the Admin Portal (`https://<Server Host>:9443/admin`), list all the tasks for API subscription delete from **Tasks** --> **Subscription Deletion** and click on approve (or reject) to approve (or reject) the workflow pending request.

    [![Subscription Delete Admin]({{base_path}}/assets/img/learn/subscription-delete-admin-entry.png)]({{base_path}}/assets/img/learn/subscription-delete-admin-entry.png)

8.  After approving go back to the API Developer Portal Application Subscriptions tab, the subscription will be removed.

    

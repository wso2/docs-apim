# Adding an API Subscription Tier Update Workflow

[Subscription Tier update]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api/) will provide the capability to change the subscription tier of an already existing subscription. Attaching a custom workflow to the API subscription update, enables an admin to approve/reject the subscription tier change request made for an active subscription. Note that only an admin is able to approve/reject a subscription tier change request.

When the API subscription update workflow is enabled, when the subscription tier change request is made, the subscription status is changed to the `TIER_UPDATE_PENDING` state. In this state, a consumer can still invoke the API with the same subscription (with the previous existing subscription tier), using its production or sandbox keys, until the subscription update to a new tier is approved. Once the subscription status change request is approved the subscription status is updated to the `UNBLOCKED` state.

#### Engaging the Approval Workflow Executor in the API Manager

1.  Sign in to API Manager Management Console ( `https://<Server Host>:9443/carbon` ) and go to **Browse** under **Resources** .

    ![]({{base_path}}/assets/img/learn/wf-extensions-browse.png)

2.  Open the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource and click **Edit as text**. Disable the SubscriptionUpdateSimpleWorkflowExecutor and enable SubscriptionUpdateApprovalWorkflowExecutor. 
    ``` 
        <WorkFlowExtensions>
        ...
            <!--SubscriptionUpdate executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionUpdateSimpleWorkflowExecutor"/-->
            <SubscriptionUpdate executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionUpdateApprovalWorkflowExecutor"/>
        ...
        </WorkFlowExtensions>
    ```

    The subscription update approval workflow executor is now engaged.


3.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click **Applications**. Select the application which has the subscriptions you wish to modify.

    ![[applications overview_tab]({{base_path}}/assets/img/learn/application-overview.png)]


4. Click **Subscriptions** to list the subscriptions of the application.
    
   ![[subscriptions overview_tab]({{base_path}}/assets/img/learn/subscriptions-overview-tab.png)]

     
5.  Select the subscription which the tier needs to be changed and click the **EDIT** icon to open the **Subscription Update** popup.

    ![subscriptions update popup]({{base_path}}/assets/img/learn/subscription-update-popup-start.png)

6.  Select the throttling tier that needs to be updated and click **Update** to continue. After updating you will see the subscription status as **TIER_UPDATE_PENDING**.

    ![subscription_update_before_approval]({{base_path}}/assets/img/learn/subscription-update-before-approval.png)
    
7.  (Optional) if the consumer need to update the requested tier to a different tier, click **EDIT** icon and select the new requested tier and click **Update**.
    
    ![subscription_update_new_tier_request]({{base_path}}/assets/img/learn/subscription-update-new-tier-request.png)
    
8.  Sign in to the Admin Portal (`https://<Server Host>:9443/admin`), list all the tasks for API subscription update from **Tasks** --> **Subscription Update** and click on approve (or reject) to approve (or reject) the workflow pending request.

    ![subscription_update_admin_entry]({{base_path}}/assets/img/learn/subscription-update-admin-entry.png)

9.  After approving go back to the API Devportal Application Subscriptions tab, the subscription status will be **UNBLOCKED** and, the requested tier will also be assigned.
     
    ![subscription_update_completed]({{base_path}}/assets/img/learn/subscription-update-completed.png)

    Now the consumer can use the existing subscription with the newly assigned throttling tier.

    
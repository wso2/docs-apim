# Adding an API Subscription Tier Update Workflow

Subscription Tier upgrade feature will provide the capability to change the subscription tier of an already existing subscription without having to delete the subscription and resubscribing to the same API. 
In the previous WSO2 API Manager releases API Consumers didn't have the capability to upgrade their API subscription to a different tier, if a new subscription tier is required, the current subscription needed to be deleted, and a re-subscription with the new tier was required. Therefore, with the introduction of this new subscription upgrade feature above mentioned issue has been mitigated.

This section explains how to attach a custom workflow to the API subscription update operation in the API Manager. First, see [Workflow Extensions](_Managing_Workflow_Extensions_) for information on different types of workflows executors.

Attaching a custom workflow to API subscription update enables you to approve the throttling tier which the consumer has requested for the existing subscription. Only admins can approve and set the new tier for the existing subscription. However, when API subscription update workflow is enabled, when the consumer tries to update the tier of an active existing subscription to an API, it initially is in the `TIER_UPDATE_PENDING` state, and consumer can still use the API with the subscription with this state which still engages the previous existing tier, using its production or sandbox keys, until their subscription update to new tier is approved. Once approval happens the new requested tier will be assigned to the existing subscription with `UNBLOCKED` status.

#### Engaging the Approval Workflow Executor in the API Manager

First, enable the API subscription update workflow for **Approval Workflow Executor.**

1.  Sign in to API Manager Management Console ( `https://<Server Host>:9443/carbon` ) and select **Browse** under **Resources** .

    ![]({{base_path}}/assets/img/learn/wf-extensions-browse.png)

2.  Go to the `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the SubscriptionUpdateSimpleWorkflowExecutor and enable SubscriptionUpdateApprovalWorkflowExecutor. 
    ``` 
        <WorkFlowExtensions>
        ...
            <!--SubscriptionUpdate executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionUpdateSimpleWorkflowExecutor"/-->
            <SubscriptionUpdate executor="org.wso2.carbon.apimgt.impl.workflow.SubscriptionUpdateApprovalWorkflowExecutor"/>
        ...
        </WorkFlowExtensions>
    ```

    The subscription update approval workflow executor is now engaged.


3.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click on **Applications** and select the application which has the subscriptions you wish to modify. Go to the **Subscriptions** tab.
    
    ![[subscriptions overview_tab]({{base_path}}/assets/img/learn/subscriptions-overview-tab.png)]
     
4.  Select the subscription which the tier needs to be changed and click the **EDIT** icon to enter the **Subscription Update** popup.

    ![subscriptions update popup]({{base_path}}/assets/img/learn/subscription-update-popup-start.png)

5.  Select the throttling tier that needs to be updated and click **Update** to continue. After updating you will see the subscription status as **TIER_UPDATE_PENDING**.

    ![subscription_update_before_approval]({{base_path}}/assets/img/learn/subscription-update-before-approval.png)
    
6.  (Optional) if the consumer need to update the requested tier to a different tier, click **EDIT** icon and select the new requested tier and click **Update** button.
    
    ![subscription_update_new_tier_request]({{base_path}}/assets/img/learn/subscription-update-new-tier-request.png)
    
6.  Sign in to the Admin Portal ( `https://<Server Host>:9443/admin` ), list all the tasks for API subscription update from **Tasks** --> **Subscription Update** and click on  approve or reject to approve or reject workflow pending request.

    ![subscription_update_admin_entry]({{base_path}}/assets/img/learn/subscription-update-admin-entry.png)

7.  After approving go back to the API Devportal Application Subscriptions tab, the subscription status will be **UNBLOCKED** and, the requested tier will also be assigned.
     
    ![subscription_update_completed]({{base_path}}/assets/img/learn/subscription-update-completed.png)

    Now the consumer can use the existing subscription with the newly assigned throttling tier.

    
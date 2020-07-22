# Update API Subscription Tier

Subscription Tier upgrade feature will provide the capability to change the subscription tier of an already existing subscription without having to delete the subscription and resubscribing to the same API. 
In the previous WSO2 API Manager releases API Consumers didn't have the capability to upgrade their API subscription to a different tier, if a new subscription tier is required, the current subscription needed to be deleted, and a re-subscription with the new tier was required. Therefore, with the introduction of this new subscription upgrade feature above mentioned issue has been mitigated.

Once you have an active approved subscription you can update the existing selected tier of the subscription. 
You can follow the steps provided in [Subscribe to an API]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api) document to create an active subscription. 

## Steps to Update Subscription Tier

1.  Sign in to the WSO2 API Developer Portal (`https://<hostname>:<port>/devportal`) and click on the Applications and select the relevant application and go to the Subscriptions tab.

    ![[Subscriptions overview_tab]({{base_path}}/assets/img/learn/subscriptions-overview-tab.png)]
 
2.  Select the subscription which the tier needs to be changed and click the **EDIT** icon to enter the subscription update popup.

    ![[Subscriptions update_popup]({{base_path}}/assets/img/learn/subscription-update-popup-start.png)]

3.  Select the throttling tier that needs to be updated and click **Update** to continue.
    
    [![Subscription_update_completed]({{base_path}}/assets/img/learn/subscription-update-completed.png)]
     
     Note that the existing subscripion has been updated with the newly selected throttling tier once you click **Update**. 
     
Follow the steps mentoined in [Adding an API Subscription Update Workflow]({{base_path}}/learn/consume-api/manage-subscription/advanced-topics/adding-an-api-subscription-tier-update-workflow)  document if you need to configure the relevant subscription update approval process. 

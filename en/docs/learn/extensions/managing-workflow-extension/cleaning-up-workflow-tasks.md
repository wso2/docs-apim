# Cleaning Up Workflow Tasks

When workflow extensions are enabled using default workflow executors, they create respective approval tasks in [WSO2 Business Process Server](http://wso2.com/products/business-process-server/) (BPS). Each of these tasks are visible to administrators in the Admin Portal. The administrator has the option to accept or reject each of the requests made by other users. At the same time, users have the option to delete the application, subscription or key they created before the administrator accepts or rejects their requests. This leaves unnecessary approval requests in the Admin Portal, which can confuse the administrator.

API Manager provides a task clean up feature to prevent deleted items from showing up in the Admin Portal. The `WorkflowExecutor` class is introduced with the `cleanUpPendingTask(String workflowExtRef)` method, which is triggered by application or subscription deletion. This method implements the logic to notify WSO2 BPS that a task with the `workflowExtRef` ID has been deleted.

The BPEL process in WSO2 BPS should contain a cancel event to support process cancellation. Each BPEL process should support correlation and event cancellation in order to successfully cleanup unnecessary tasks. For more information on BPEL correlation, see [Process Correlation](https://docs.wso2.com/display/BPS350/Process+Correlation) and the [BPEL Correlation Guide](http://wso2.com/library/presentations/2015/07/screencast-wso2-business-process-server-bpel-correlation-guide/) .

The final BPEL should have a design similar to the following diagram,

![]({{base_path}}/assets/attachments/103334735/103334736.png)

Follow the steps below to test this out.


1.  Log in to the Developer Portal and create two new applications.
2.  Log in to the Admin Portal ( `https://<Server Host>:9443/admin` ) and approve the creation of one application.
3.  In the Developer Portal, subscribe an API to the approved application.
4.  Generate production and/or sandbox key(s) for the approved application.
5.  Check the pending approval tasks in the Admin Portal. You see tasks pending for application creation, application registration and subscription creation.
6.  Delete the items you created from the Developer Portal and notice that the respective administrator approval tasks are removed.
7.  If the application with pending subscription and key generation approvals is deleted from the Developer Portal, all the pending subscription and key generation approval tasks are deleted for that application.


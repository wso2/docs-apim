# Adding a User Signup Workflow

## Engaging the Approval Workflow Executor in API Manager

!!! important
    When there are multiple tenants, first enable self sign up for tenant admin for each tenant by following the steps mentioned in [Enabling self signup]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/enabling-or-disabling-self-signup/#enabling-self-signup). 
    Then to add a user sign-up workflow with regard to the Developer Portal, follow the below instructions from step 2 after sign in to the API-M Management Console as tenant admin for each tenant.

Follow the instructions below to add a user sign-up workflow with regard to the Developer Portal.

1. Sign in to the API-M Management Console.

     `https://<Server-Host>:9443/carbon`

     `https://localhost:9443/carbon`

2. Select **Browse** under **Resources**.

    ![Browse resources]({{base_path}}/assets/img/learn/wf-extensions-browse.png)

3.  Go to `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` resource, disable the **UserSignUpSimpleWorkflowExecutor** and enable **UserSignUpApprovalWorkflowExecutor** for user self sign up.

    ```
    <WorkFlowExtensions>
        ...
            <!--UserSignUp executor="org.wso2.carbon.apimgt.impl.workflow.UserSignUpSimpleWorkflowExecutor"/-->
            <UserSignUp executor="org.wso2.carbon.apimgt.impl.workflow.UserSignUpApprovalWorkflowExecutor"/>
        ...
    </WorkFlowExtensions>
    ```

4.  Navigate to the Developer Portal.

5.  Sign up/register as a new user. 

     Click **Sign in**, then click **Create Account**, and add the details of the new user.
   
     ![Create new  Account]({{base_path}}/assets/img/learn/devportal-create-account.png)

     Note that the following message appears if the Approval Workflow Executor is invoked correctly.

     ![Browse resources]({{base_path}}/assets/img/learn/user-registration-success.png)

6.  Sign in to the API Manager Admin Portal using the admin username and password.

     `https://<Server-Host>:9443/admin`

     `https://localhost:9443/admin`

7.  Click **Tasks**, then click **User Creation**, and approve or reject the user signup task listed by clicking on approve or reject.

     ![Browse resources]({{base_path}}/assets/img/learn/user-creation-pending-list.png)

8.  Navigate back to the Developer Portal.

     You will see that the user is now registered. If the user is successfully registered, then the user can log in to Developer Portal successfully using that account.

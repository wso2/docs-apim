# Scenario 4 - Signing up a new user

## User Story

**Quantis allows external users to access their APIs. To take the full benefit out of these APIs, they have decided to open the registration to outside users since it can be a burden to enter all the details for every single user/consumer. Therefore, they request an approval workflow for user registration in such a way that the users will be registered to the system when a user with administrative privileges approves their registration after a manual validation of the user.  By allowing external parties to register to their system under a supervision, Quantis expects higher revenue in future. **

**_Time to Complete : 3 mins_**

![Signup description]({{base_path}}/assets/img/tutorials/scenarios/signup-desc.png)

WSO2 API Manager provides extension points to trigger workflow tasks for many operations such as Application creation, subscription creation, user signup, etc. Out of the box WSO2 API Manager ships with simple approval workflow. 

This demo setup already comes with self-signup and signup workflow enabled for the Qantis tenant domain. If you need to check how to configure this check [enabling self-signup](https://apim.docs.wso2.com/en/latest/develop/customizations/customizing-the-developer-portal/enabling-or-disabling-self-signup/) and [enabling signup workflow](https://apim.docs.wso2.com/en/latest/develop/customizations/adding-a-user-signup-workflow/) documentation. 

!!! Note
    You could see **UserSignUpApprovalWorkflowExecutor** is now engaged if you login to the [https://localhost:9443/carbon](https://localhost:9443/carbon) portal using Qantis admin credentials (admin@qantis.com:admin) and navigate to `/_system/governance/apimgt/applicationdata/workflow-extensions.xml` location

    ![Signup config]({{base_path}}/assets/img/tutorials/scenarios/signup-config.png)


To try this out,

1. Go to the Dev portal [https://localhost:9443/devportal/](https://localhost:9443/devportal/) and select Qantis tenant domain.
2. Select Sign In button on the top right corner. This will show a signup page.
3. Select **Create Account** Link.
4. Add the desired username (with the tenant domain) and proceed to self register.

    ![Signup config]({{base_path}}/assets/img/tutorials/scenarios/signup-start-pg.png)

5. Fill the required fields and proceed with the registration.
6. If you try to login using this credentials, you will be shown an unauthorized-access page
   
    ![Not allowed]({{base_path}}/assets/img/tutorials/scenarios/login-forbidden.png)


To approve the signup request, 

1. Log in to the [https://localhost:9443/admin/](https://localhost:9443/admin/) admin portal using admin@quantis.com and password _admin_
2. Under the **Task → User Creation** you will notice a pending task. Approve it.

    ![Approve]({{base_path}}/assets/img/tutorials/scenarios/approve.png)
3. Now you will be able to login to the dev portal using **raj@quantis.com** user and his credentials.































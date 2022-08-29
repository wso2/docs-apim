# Disabling or Enabling Self Signup

#### Disabling Self Signup

In a multi-tenanted API Manager setup, self-signup to the Developer Portal works out-of-the-box for all the tenants, including the super tenant. **In order to disable self-signup for a particular tenant, follow the steps below.**.

1. Sign in to the management console ( `https://<HostName>:9443/carbon` ) as tenant admin.

2. Click **Resident** under **Identity Providers** on the Main tab

    ![Identity Provider Resident]({{base_path}}/assets/img/learn/idp-resident.png)

3. Expand the **User Onboarding** tab and expand the **Self Registration** tab

    ![Account Management Policies]({{base_path}}/assets/img/learn/user-onboarding-self-onboarding.png)

4. Deselect the **User self registration** property and update the content.

    ![Deselect User Self Registration]({{base_path}}/assets/img/learn/deselect-user-self-registration.png)

5. Sign in to the admin portal  ( `https://<HostName>:9443/admin` ) as tenant admin and navigate to **Advance Configurations** by clicking **Advance** under **Settings**.

    ![Advance Configuration Admin Portal Self Signup]({{base_path}}/assets/img/learn/advance-configuration-admin-portal-self-signup.png)

6. Remove the following configuration and save the content.
    ``` json
       "SelfSignUp": {
            "SignUpRoles":["Internal/subscriber"]
       }
    ```
7. When trying to register as a new user on the particular tenant domain, you will see the following message notifying that self registration is disabled.

    ![Self registration disabled]({{base_path}}/assets/img/learn/self-signup-disabled.png)

#### Enabling Self Signup


1. Sign in to the management console ( `https://<HostName>:9443/carbon` ) as tenant admin.

2. Click **Resident** under **Identity Providers** on the Main tab

3. Expand the **User Onboarding** tab and expand the **Self Registration** tab

4. Select the **User self registration** property and update the content.

5. Sign in to the admin portal  ( `https://<HostName>:9443/admin` ) as tenant admin and navigate to **Advance Configurations** by clicking **Advance** under **Settings**.

6. Add the following configuration and save the content.

    ``` json
       "SelfSignUp": {
            "SignUpRoles":["Internal/subscriber"]
       }
    ```

!!! tip
    To engage your own signup process, see [Adding a User Signup Workflow]({{base_path}}/develop/customizations/adding-a-user-signup-workflow).

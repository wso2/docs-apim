# Setup WSO2 Identity Server as a Federated Authenticator

WSO2 Identity Server 7.1.0 includes B2B organization support. The following instructions detail how to configure it as a federated authenticator for WSO2 API Manager.

## Configure WSO2 Identity Server

1. Download [WSO2 Identity Server 7.1.0](https://wso2.com/identity-server/).
2. Add the following configuration to the `<IS7_HOME>/repository/conf/deployment.toml` file.
    ```toml
    [oauth]
    authorize_all_scopes = true

    [oauth.oidc.user_info]
    remove_internal_prefix_from_roles=true

    [[resource.access_control]]
    context="(.*)/scim2/Me"
    secure=true
    http_method="GET"
    cross_tenant=true
    permissions=[]
    scopes=[]

    [role_mgt]
    allow_system_prefix_for_role = true
    ```
3. Start WSO2 Identity Server with a port offset. Port offset is required only if you are running both API-M and IS 7.x in the same JVM.

    `sh wso2server.sh -DportOffset=1`

4. Log in to the IS Console at [https://localhost:9444/console](https://localhost:9444/console) and create a new application.
    - Select `Traditional Web Application` and complete the form.
    - Set the Redirect URL to [https://localhost:9443/commonauth](https://localhost:9443/commonauth).

    ![Create new application]({{base_path}}/assets/img/design/b2b/create-new-app.png) 

5. Select the `Allow sharing with organizations` option.

    ![Allow sharing with organizations]({{base_path}}/assets/img/design/b2b/allow-sharing-with-orgs.png) 

6. Once the application is created, go to the `Protocol` tab and copy the Client ID and Client Secret for later use.
7. Go to the **User Attributes** tab and select **Groups**.

    ![Select roles]({{base_path}}/assets/img/design/b2b/select-roles.png) 

8. Under the **Subject** sub-section, select **Assign alternate subject identifier** and then select **Username**.

    ![Select subject ]({{base_path}}/assets/img/design/b2b/sub_alt.png) 

9. Go to the **User Management** menu item, navigate to the **Groups** sub-menu item, and add the following groups: **developer**, **publisher**, and **creator**.

    ![Add new groups - Super organization]({{base_path}}/assets/img/design/b2b/super-org-groups.png) 

10. Go to the **User Management** menu item, navigate to the **Users** sub-menu item, and create three users—one for each portal. Make sure to assign the respective group to each user during user creation.

    In this example:

    - `orgadmin` → **admin** (Assign predefined **admin** group, or create a new group intended for administrative access in API-M)
    - `larry` → **publisher**, **creator**
    - `david` → **developer**

    ![Organization users ]({{base_path}}/assets/img/design/b2b/org-users.png) 

11. Next, create organizations. Select **Organization** and create a few new organizations. Note down the organization IDs.

    ![Create organizations ]({{base_path}}/assets/img/design/b2b/create-organizations.png) 

12. Select the organization and click **Switch to Organization**.

    ![Switch organizations ]({{base_path}}/assets/img/design/b2b/switch-organization.png) 

13. Navigate to the **Groups** sub-menu item under **User Management**, and add a new group that will be assigned to users who access the API-M Developer Portal.

    ![Add new groups - Sub organization]({{base_path}}/assets/img/design/b2b/sub-org-groups.png) 

14. Under the **Users** menu item in **User Management**, add new users such as `emily` and `robert`. Make sure to assign the group created previously to each user during user creation.

    !!! note
        Organization restriction capability is not supported in the Admin and Publisher portals in this release. To prevent organization users from logging in to these portals, do not assign Admin or Publisher/Creator groups to users in sub-organizations.

15. Similarly, create a user in another organization and assign the developer group created in that sub-organization.

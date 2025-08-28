# Setup WSO2 Identity Server as a Federated Authenticator

WSO2 Identity Server 7.1.0 includes B2B organization support. The following instructions detail how to configure it as a federated authenticator for WSO2 API Manager.

## Configure WSO2 Identity Server

1. Download [WSO2 Identity Server 7.1.0](https://wso2.com/identity-server/).
2. Add following configurations in the <IS7_HOME>/repository/conf/deployment.toml file.
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
    - Select "Traditional Web Application" and complete the form.
    - Set the Redirect URL to [https://localhost:9443/commonauth](https://localhost:9443/commonauth) 

    ![Create new application]({{base_path}}/assets/img/design/b2b/create-new-app.png) 

5. Select ‘Allow sharing with organizations’ option.

    ![Allow sharing with organizations]({{base_path}}/assets/img/design/b2b/allow-sharing-with-orgs.png) 

6. Once the application is created, go to the 'Protocol' tab and copy the Client ID and Secret for later use.
7. Under `User Attributes` section, select `Roles`

    ![Select roles]({{base_path}}/assets/img/design/b2b/select-roles.png) 

8. Under `Subject` section, select `Assign alternate subject identifier` and select `Username`.

    ![Select subject ]({{base_path}}/assets/img/design/b2b/sub_alt.png) 

9. Under User `Roles` section, add Application roles `devportal` , `publisher`, `creator`, `admin`

    ![Application roles ]({{base_path}}/assets/img/design/b2b/app-roles.png) 

10. Go to the `User Management` section, navigate to the `Users` tab, and create three users—one for each portal.

    ![Organization users ]({{base_path}}/assets/img/design/b2b/org-users.png) 

11. Go to the `Roles` section under `User Management` section and assign application roles to users. (Check audience column and get the application/<application name> roles)

    ![Organization users ]({{base_path}}/assets/img/design/b2b/org-users-with-roles.png) 

12. Select role and go to the `Users` tab and assing users to the role.
In this example
    admin → orgadmin
    publisher, creator → larry
    devportal → david

13. Now let's create organizations. For that select `Organization` and create a couple of  new organizations. Note down the organization Ids

    ![Create organizations ]({{base_path}}/assets/img/design/b2b/create-organizations.png) 

14. Select the organization and click `Switch to Organization`.

    ![Switch organizations ]({{base_path}}/assets/img/design/b2b/switch-organization.png) 

15. Under `Users` section in `User Management` add a new user.  Let’s say `emily` and `robert`

16. Under `Roles` section in `User Management` find the previously created `devportal` role and select it. Select `Users` tab and set the user to this role

    ![Dev portal roles ]({{base_path}}/assets/img/design/b2b/dev-portal-roles.png) 

    !!! note
        Organization restriction capability is not supported in the Admin and Publisher portals in this release. To prevent organization users from logging into these portals, do not assign them Admin or Publisher/Creator roles to the users in sub organizations.

17. Similarly create user in another organization and assign developer role.

# Setup WSO2 Identity Server as a Federated Authenticator

WSO2 Identity Server 7.1.0 includes B2B organization support. The following instructions detail how to configure it as a federated authenticator for WSO2 API Manager.

## Configure WSO2 Identity Server

1. Download [WSO2 Identity Server 7.1.0](https://wso2.com/identity-server/).
2. Add following configurations in the <IS7_HOME>/repository/conf/deployment.toml file.
    ```toml
    [oauth]
    authorize_all_scopes = true

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

15. Similarly create user in another organization and assign developer role.


## Set Up WSO2 API Manager

1. Import Keymanager certificate to WSO2 API Manager client-truestore.jks. Use following steps.

    Export WSO2 IS certificate.
    ``` bash
    openssl s_client -connect localhost:9444 -servername wso2is7 | openssl x509 > is7.cert
    ```

    Import this certificate to the `client-truststore.jks` in `AM_HOME/repository/resources/security/`

    ``` bash
    keytool -import -alias wso2is7cert -file is7.cert -keystore client-truststore.jks -storepass wso2carbon
    ```


2. Need to add new local claim to store organization id. For that go to  Home > Identity > Claims> Add and select `Add Local Claim` and fill the form. Use Claim URI as [http://wso2.org/claims/organizationId](http://wso2.org/claims/organizationId )

    ![Add new clam]({{base_path}}/assets/img/design/b2b/claims.png) 


3. Need to add `org_id` and `org_name` to oidc claims and map them to [http://wso2.org/claims/organizationId](http://wso2.org/claims/organizationId ) and [http://wso2.org/claims/organization](http://wso2.org/claims/organization) local claims. For that go to  Home > Identity > Claims> Add and select `Add External Claim`

    ![Add new clam]({{base_path}}/assets/img/design/b2b/add-claim-1.png) 
      
    ![Add new clam]({{base_path}}/assets/img/design/b2b/add-claim-2.png) 

4. Once added, it will be visible under the http://wso2.org/oidc/claim claim

    ![Add new clam]({{base_path}}/assets/img/design/b2b/claim-view.png) 

5. Now we need to configure WSO2 IS 7.1 as a federated IDP for API Manager. For that. Create a new Identity provider by selecting `Identity Providers` → `Add`. Set a name to the IDP

6. Expand `Claim Configuration` and then `Basic Claim Configuration`. Select ‘Define Custom Claim Dialect’ radio button and add following claim mapping using `add claim mapping` button.

7. Set the user id claim as `username` and Role claim URI as `roles`

    ![Claim config]({{base_path}}/assets/img/design/b2b/claim-config.png) 

    !!! note
        `org_name`, `org_id`, `username`, `roles` are oidc claims sent from WSO2 IS. If external IDP is configured, map the corresponding claims.


8. Under the `Role Configuration`, Map IDP role `devportal` to local role `Internal/subscriber` . Do similar configurations to other roles as below.

    ![Role config]({{base_path}}/assets/img/design/b2b/role-config.png) 

9. Under the `Federated Authenticators` section, configure IS 7 as the federated authenticator using oauth2 application related information.

    ```
    Enable Oauth2/OpenIDConnect : true
    Scopes : openid profile roles
    Callback URl: https://localhost:9443/commonauth
    ```

    ![Federated authenticator]({{base_path}}/assets/img/design/b2b/federated-authenticator.png) 

    Urls for other endpoints can be found in ‘info’ tab in the application created in identity server.

    ![Well-known URLs]({{base_path}}/assets/img/design/b2b/url-list.png) 

10. Under `Just-in-Time Provisioning` Set provisioning as below. Finish the IDP configuration by clicking on the Register button.

    ![JIT Provisioning]({{base_path}}/assets/img/design/b2b/jit.png) 

11. Now you need to configure authenticators for the service providers. Go to the `service providers` section and select the edit button in  `apim_devportal`. 

    ![Service providers]({{base_path}}/assets/img/design/b2b/service-providers.png) 

    !!! note
        If these service providers are not available, you need to first login to the developer portal and this will be created automatically.

12. Under the `Local & Outbound Authentication Configuration` section, set the identity provider we created previously under the `Federated Authentication’ section.

    ![Configure federated authenticator]({{base_path}}/assets/img/design/b2b/configure-federated-authenticator.png) 

13. Similarly do the same for other portal’s service providers
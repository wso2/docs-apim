# B2B API Consumption

Before this release, WSO2 API Manager operated without a defined organizational structure, maintaining a flat hierarchy. This led to limitations, including a lack of control over API visibility, business-specific subscriptions, and business-level insights. With the introduction of B2B features, you can now achieve a more structured approach.

!!! note
    This release only provides support for organization-based restrictions in the Developer Portal.



## Set Up an Organization-Supported Identity Server

The WSO2 API Manager B2B Organization feature is compatible with any Identity Server that supports organization hierarchies. To utilize the Identity Server's organization hierarchy within API Manager, we need to configure it as a federated identity provider. This documentation uses WSO2 Identity Server 7.1.0 as an example, due to its built-in organization support.

For more information on setting up WSO2 Identity Server 7.1.0, see [Setup WSO2 Identity Server as a federated authenticator]({{base_path}}/design/b2b-api-management/setup-identity-server/)


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

2. Configure the `logoutSessionStateAppender` setting to `OIDC` in each portal if WSO2 API Manager and WSO2 Identity Server are running on different hosts. Skip this step if both servers are running on the same host.

    Modify the `logoutSessionStateAppender` value to `OIDC` in these settings.json files:

    - `<AM_HOME>/repository/deployment/server/webapps/publisher/site/public/conf/settings.json`
    - `<AM_HOME>/repository/deployment/server/webapps/admin/site/public/conf/settings.json`
    - `<AM_HOME>/repository/deployment/server/webapps/devportal/site/public/theme/settings.json`

    !!! warning
        Skipping this configuration in production environments will cause logout functionality issues.

3. Add new local claim to store organization ID. For that go to  Home > Identity > Claims > Add and select `Add Local Claim` and fill the form. Use Claim URI as  [http://wso2.org/claims/organizationId](http://wso2.org/claims/organizationId )

    ![Add new claim]({{base_path}}/assets/img/design/b2b/claims.png) 


4. Add `org_id` and `org_name` to oidc claims and map them to [http://wso2.org/claims/organizationId](http://wso2.org/claims/organizationId ) and [http://wso2.org/claims/organization](http://wso2.org/claims/organization) local claims. For that go to  Home > Identity > Claims> Add and select `Add External Claim`

    ![Add new claim]({{base_path}}/assets/img/design/b2b/add-claim-1.png) 
      
    ![Add new claim]({{base_path}}/assets/img/design/b2b/add-claim-2.png) 

5. Once added, it will be visible under the http://wso2.org/oidc/claim claim

    ![Add new claim]({{base_path}}/assets/img/design/b2b/claim-view.png) 

6. Now we need to configure WSO2 IS 7.1 as a federated IDP for API Manager. For that. Create a new Identity provider by selecting `Identity Providers` → `Add`. Set a name to the IDP

7. Expand `Claim Configuration` and then `Basic Claim Configuration`. Select ‘Define Custom Claim Dialect’ radio button and add following claim mapping using `add claim mapping` button.

8. Set the user id claim as `username` and Role claim URI as `roles`

    ![Claim config]({{base_path}}/assets/img/design/b2b/claim-config.png) 

    !!! note
        `org_name`, `org_id`, `username`, `roles` are oidc claims sent from WSO2 IS. If external IDP is configured, map the corresponding claims.


9. Under the `Role Configuration`, Map IDP role `devportal` to local role `Internal/subscriber` . Do similar configurations to other roles as below.

    ![Role config]({{base_path}}/assets/img/design/b2b/role-config.png) 

10. Under the `Federated Authenticators` section, configure IS 7 as the federated authenticator using oauth2 application related information.

    ```
    Enable Oauth2/OpenIDConnect : true
    Scopes : openid profile roles
    Callback URl: https://localhost:9443/commonauth
    ```

    ![Federated authenticator]({{base_path}}/assets/img/design/b2b/federated-authenticator.png) 

    Urls for other endpoints can be found in ‘info’ tab in the application created in identity server.

    ![Well-known URLs]({{base_path}}/assets/img/design/b2b/url-list.png) 

11. Under `Just-in-Time Provisioning` Set provisioning as below. Finish the IDP configuration by clicking on the Register button.

    ![JIT Provisioning]({{base_path}}/assets/img/design/b2b/jit.png) 

12. Now you need to configure authenticators for the service providers. Go to the `service providers` section and select the edit button in  `apim_devportal`. 

    ![Service providers]({{base_path}}/assets/img/design/b2b/service-providers.png) 

    !!! note
        If these service providers are not available, you need to first login to the developer portal and this will be created automatically.

13. Under the `Local & Outbound Authentication Configuration` section, set the identity provider we created previously under the `Federated Authentication’ section.

    ![Configure federated authenticator]({{base_path}}/assets/img/design/b2b/configure-federated-authenticator.png) 

14. Similarly do the same for other portal’s service providers

## Register Organizations in API Manager 

First you need to map the organization in the identity server in the API manager. For that, 

1. log in to Admin portal [https://localhost:9443/admin/](https://localhost:9443/admin/)  using `orgadmin`. 

	!!! note 
        You cannot use admin/admin for this because locally created admin user does not belong to any organization.

2. Go to `Organizations` Tab and select `Register Organization` . Use the organization ids you got during organization registration step in WSO2 IS.

    ![Register organizations]({{base_path}}/assets/img/design/b2b/register-org.png) 


## Register Organization-specific key managers

WSO2 IS 7.1 provides the capability to register OAuth applications within organizations. As a result, it will have organization-specific URLs for OAuth-related operations. We will register organization-specific key managers and set visibility exclusively for users within the organization.

1. Login to admin portal using `orgadmin` and go to `Key Managers` section and add new keymanager.
2. Add name and display name. Select keymanager type as `WSO2 Identity Server 7`
3. Fill the form using following. Replace the `org_id` with the `external reference Id` used during org registration. You could use  [https://localhost:9444/oauth2/token/.well-known/openid-configuration](https://localhost:9444/oauth2/token/.well-known/openid-configuration) as the well-known url and then replace the following

    | Endpoint | URL |
    |----------|-----|
    | Issuer | `https://localhost:9444/oauth2/token` |
    | Client Registration Endpoint | `https://localhost:9444/t/carbon.super/o/<org_id>/api/identity/oauth2/dcr/v1.1/register` |
    | Introspect Endpoint | `https://localhost:9444/t/carbon.super/o/<org_id>/oauth2/introspect` |
    | Token Endpoint | `https://localhost:9444/t/carbon.super/o/<org_id>/oauth2/token` |
    | Token Display Endpoint | `https://localhost:9444/t/carbon.super/o/<org_id>/oauth2/token` |
    | Revoke Endpoint | `https://localhost:9444/t/carbon.super/o/<org_id>/oauth2/revoke` |
    | Display Revoke Endpoint | `https://localhost:9444/t/carbon.super/o/<org_id>/oauth2/revoke` |
    | Authorize Endpoint | `https://localhost:9444/t/carbon.super/o/<org_id>/oauth2/authorize` |
    | Scope Management Endpoint | `https://localhost:9444/api/identity/oauth2/v1.0/scopes` |
    | WSO2 Identity Server 7 API Resource Management Endpoint | `https://localhost:9444/api/server/v1/api-resources` |
    | WSO2 Identity Server 7 Roles Endpoint | `https://localhost:9444/scim2/v2/Roles` |


4. Under the `Available Organizations` section, select the organization

    ![Key Manager visibility]({{base_path}}/assets/img/design/b2b/key-manager-visibility.png) 

5. Under `Advanced Configurations` section, set `Token Handling Options` as JWT and set the organization id used previoiusly for keymanager registration as below.

    ![Key Manager config]({{base_path}}/assets/img/design/b2b/key-manager-conf.png) 

## Set Organization Visibility for APIs

We can set APIs to be visible for users in all organizations, current organization, or set of organizations.

1. Login to publisher portal using a user with creator and publisher roles. In this example, `larry`
2. Create an API and fill the required data.
3. Go to the `Lifecycle` page and publish the API
4. At the top bar, select 'Share' button.

    ![Share with Organizations]({{base_path}}/assets/img/design/b2b/share.png) 

5. Select which organization you need to share and select organization specific business plans as well and save.

    ![Share with Organizations]({{base_path}}/assets/img/design/b2b/share-with-plans.png) 

    !!!note
        APIs with Developer Portal visibility set to 'public' are still not visible on the anonymous Developer Portal page if they have been shared with an organization. To make them visible in the Developer Portal without user login, set the organization visibility to 'All Organizations'.

    !!!note
        Organization visibility is not supported for API product for this release.

## Login to developer portal and invoke the API.

1. Go to developer portal and click login button

2. Use the SSO option and give the organization name. 

    ![Login with SSO]({{base_path}}/assets/img/design/b2b/login.png) 
    
    ![Login with SSO]({{base_path}}/assets/img/design/b2b/login-orgname.png) 

3. You should be able to see APIs shared with this organization.

4. Lets create an application. You have the option to share the application with all the users within the organization as well.

    ![Share Application]({{base_path}}/assets/img/design/b2b/share-app.png) 

5. Under the application keys sections, you would see the keymanager specifically set for this organization.

    ![Application Keys]({{base_path}}/assets/img/design/b2b/key-page.png) 

6. You should be able to generate an access token and invoke the API now.

!!! tip 
    Although this feature is enabled by default, organization visibility features are only available after you register organizations. You could specifically disable this feature by adding 

    ```
    [apim.organization_based_access_control]
    enable = true
    ```

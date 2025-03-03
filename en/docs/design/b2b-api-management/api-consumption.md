# B2B API Consumption

Before this release, WSO2 API Manager operated without a defined organizational structure, maintaining a flat hierarchy. This led to limitations, including a lack of control over API visibility, business-specific subscriptions, and business-level insights. With the introduction of B2B features, you can now achieve a more structured approach.

!!! note
    This release only provides support for organization-based restrictions in the Developer Portal.



## Set Up an Organization-Supported Identity Server

The WSO2 API Manager B2B Organization feature is compatible with any Identity Server that supports organization hierarchies. To utilize the Identity Server's organization hierarchy within API Manager, we need to configure it as a federated identity provider. This documentation uses WSO2 Identity Server 7.1.0 as an example, due to its built-in organization support.

For more information on setting up WSO2 Identity Server 7.1.0, see [Setup WSO2 Identity Server as a federated authenticator]({{base_path}}/design/b2b-api-management/setup-identity-server/)


## Register Organizations in API Manager 

First you need to map the organization in the identity server in the API manager. For that, 

1. log in to Admin portal [https://localhost:9443/admin/](https://localhost:9443/admin/)  using `orgadmin`. 

	!!! note 
        You cannot use admin/admin for this because locally created admin user does not belong to any organization.

2. Go to `Organizations` Tab and select `Register Organization` . Use the organization ids you got during organization registration step in WSO2 IS.

    ![Register organizations]({{base_path}}/assets/img/design/b2b/register-org.png) 

!!! tip 
    Although this feature is enabled by default, organization visibility features are only available after you register organizations. You could specifically disable this feature by adding 

    ```
    [apim.organization_based_access_control]
    enable = true
    ```

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

7. Logout and attempt to log in again with a different user from another organization.

    !!!note
        When running both API Manager and WSO2 Identity Server on the same host (localhost), you may encounter an issue where a Developer Portal user does not log out when switching between two users within the same organization. This occurs due to both servers sharing the same host. In a production setup, this issue does not arise as the servers are hosted separately. To overcome this issue, you can use a private browser window for testing locally or set up WSO2 Identity Server on a different host.

        If the Identity Server is running on a **different host** and you encounter an issue with logout session removal, set the `logoutSessionStateAppender` to an empty value in the following configuration.

            <AM_HOME>/repository/deployment/server/webapps/publisher/site/public/conf/settings.json
            <AM_HOME>/repository/deployment/server/webapps/admin/site/public/conf/settings.json
            <AM_HOME>/repository/deployment/server/webapps/devportal/site/public/theme/settings.json


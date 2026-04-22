# B2B API Consumption

Before API-M 4.5.0, WSO2 API Manager operated without a defined organizational structure, maintaining a flat hierarchy. This led to limitations, including a lack of control over API visibility, business-specific subscriptions, and business-level insights. With the introduction of B2B features, you can now achieve a more structured approach.

!!! note
    This release only provides support for organization-based restrictions in the Developer Portal.



## Set Up an Organization-Supported Identity Server

The WSO2 API Manager B2B Organization feature is compatible with any Identity Server that supports organization hierarchies. To utilize the Identity Server's organization hierarchy within API Manager, we need to configure it as a federated identity provider. This documentation uses WSO2 Identity Server 7.1.0 as an example, due to its built-in organization support.

For more information on setting up WSO2 Identity Server 7.1.0, see [Setup WSO2 Identity Server as a federated authenticator]({{base_path}}/manage-apis/design/b2b-api-management/setup-identity-server/)


## Set Up WSO2 API Manager

1. Import the Key Manager certificate into the WSO2 API Manager `client-truststore.jks` file.

    Export the WSO2 Identity Server certificate.
    ``` bash
    openssl s_client -connect localhost:9444 -servername wso2is7 | openssl x509 > is7.cert
    ```

    Import this certificate into the `client-truststore.jks` file in `AM_HOME/repository/resources/security/`.

    ``` bash
    keytool -import -alias wso2is7cert -file is7.cert -keystore client-truststore.jks -storepass wso2carbon
    ```


2. Add a new local claim to store the organization ID. Go to **Home > Identity > Claims > Add**, select `Add Local Claim`, and fill in the form. Use `http://wso2.org/claims/organizationId` as the claim URI.

    ![Add new local claim]({{base_path}}/assets/img/design/b2b/claims.png) 


3. Add `org_id` and `org_name` to the OIDC claims and map them to the local claims `http://wso2.org/claims/organizationId` and `http://wso2.org/claims/organization`. To do this, go to **Home > Identity > Claims > Add** and select `Add External Claim`.

    ![Add new external claim]({{base_path}}/assets/img/design/b2b/add-claim-1.png) 
      
    ![Add new external claim]({{base_path}}/assets/img/design/b2b/add-claim-2.png) 

4. Once added, the claims will be visible under the `http://wso2.org/oidc/claim` claim dialect.

    ![Claim view]({{base_path}}/assets/img/design/b2b/claim-view.png) 

5. Configure WSO2 IS 7.1 as a federated identity provider for API Manager. Create a new identity provider by selecting `Identity Providers` → `Add`, and then set a name for the IDP.

6. Expand `Claim Configuration` and then `Basic Claim Configuration`. Select the `Define Custom Claim Dialect` radio button, and add the required claim mappings using the `Add Claim Mapping` button.

7. Set the `User ID Claim URI` to `username` and the `Role Claim URI` to `groups`.

    ![Claim config]({{base_path}}/assets/img/design/b2b/claim-config.png) 

    !!! note
        `org_name`, `org_id`, `username`, and `groups` are OIDC claims sent from WSO2 IS. If an external IDP is configured, map the corresponding claims.


8. Under `Role Configuration`, map the IDP group `developer` to the local role `Internal/subscriber`. Configure the other groups similarly.

    ![Role config]({{base_path}}/assets/img/design/b2b/role-config.png) 

9. Under the `Federated Authenticators` section, configure IS 7 as the federated authenticator using the OAuth2 application details.


    | Setting                         | Value                                 |
    |---------------------------------|---------------------------------------|
    | Enable OAuth2/OpenIDConnect     | true (check the checkbox)                                  |
    | Scopes                          | openid groups                         |
    | Callback URL                    | https://localhost:9443/commonauth     |


    ![Federated authenticator]({{base_path}}/assets/img/design/b2b/federated-authenticator.png) 

    You can find the URLs for the other endpoints in the `Info` tab of the application created in Identity Server.

    ![Well-known URLs]({{base_path}}/assets/img/design/b2b/url-list.png) 

10. Under `Just-in-Time Provisioning`, configure provisioning as shown below. Finish the IDP configuration by clicking `Register`.

    ![JIT Provisioning]({{base_path}}/assets/img/design/b2b/jit.png) 

11. Next, configure authenticators for the service providers. Go to the `Service Providers` section and select the edit button for `apim_devportal`. 

    ![Service providers]({{base_path}}/assets/img/design/b2b/service-providers.png) 

    !!! note
        If these service providers are not available, first log in to the respective portal. They will be created automatically.

12. Under the `Local & Outbound Authentication Configuration` section, set the identity provider you created earlier under the `Federated Authentication` section.

    ![Configure federated authenticator]({{base_path}}/assets/img/design/b2b/configure-federated-authenticator.png) 

13. Repeat the same configuration for the service providers of the other portals.

## Register Organizations in API Manager 

First, map the organizations in the Identity Server to API Manager.

1. Log in to the Admin Portal at [https://localhost:9443/admin/](https://localhost:9443/admin/) using `orgadmin`. 

	!!! note 
        You cannot use `admin/admin` for this step because the locally created admin user does not belong to any organization.

2. Go to the `Organizations` tab and select `Register Organization`. Use the organization IDs that you obtained during the organization registration step in WSO2 IS.

    ![Register organizations]({{base_path}}/assets/img/design/b2b/register-org.png) 


## Register Organization-specific key managers

WSO2 IS 7.1 provides the capability to register OAuth applications within organizations. As a result, it will have organization-specific URLs for OAuth-related operations. We will register organization-specific key managers and set visibility exclusively for users within the organization.

1. Log in to the Admin Portal using `orgadmin`, go to the `Key Managers` section, and add a new key manager.
2. Provide a name and display name. Select the key manager type as `WSO2 Identity Server 7`.
3. Fill in the form as follows. Replace `org_id` with the external reference ID used during organization registration. You can use [https://localhost:9444/oauth2/token/.well-known/openid-configuration](https://localhost:9444/oauth2/token/.well-known/openid-configuration) as the well-known URL and then update the following endpoints.

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


4. Under the `Available Organizations` section, select the organization.

    ![Key Manager visibility]({{base_path}}/assets/img/design/b2b/key-manager-visibility.png) 

5. Under `Advanced Configurations`, set `Token Handling Options` to JWT and set the organization ID used previously for key manager registration as shown below.

    ![Key Manager config]({{base_path}}/assets/img/design/b2b/key-manager-conf.png) 

## Set Organization Visibility for APIs

You can set APIs to be visible to users in all organizations, the current organization, or a selected set of organizations.

1. Log in to the Publisher Portal using a user with the creator and publisher roles. In this example, `larry`.
2. Create an API and fill the required data.
3. Go to the `Lifecycle` page and publish the API.
4. On the top bar, click `Share`.

    ![Share with Organizations]({{base_path}}/assets/img/design/b2b/share.png) 

5. Select the organizations to share the API with, choose the organization-specific business plans, and save the changes.

    ![Share with Organizations]({{base_path}}/assets/img/design/b2b/share-with-plans.png) 

    !!! note
        APIs with Developer Portal visibility set to `public` are still not visible on the anonymous Developer Portal page if they have been shared with an organization. To make them visible in the Developer Portal without user login, set the organization visibility to `All Organizations`.

    !!! note
        Organization visibility is not supported for API products in this release.

## Log in to the Developer Portal and invoke the API

1. Go to the Developer Portal and click the login button.

2. Use the SSO option and enter the organization name. 

    ![Login with SSO]({{base_path}}/assets/img/design/b2b/login.png) 
    
    ![Login with SSO]({{base_path}}/assets/img/design/b2b/login-orgname.png) 

3. You should be able to see APIs shared with this organization.

4. Create an application. You also have the option to share the application with all users within the organization.

    ![Share Application]({{base_path}}/assets/img/design/b2b/share-app.png) 

5. Under the application keys section, you will see the key manager configured specifically for this organization.

    ![Application Keys]({{base_path}}/assets/img/design/b2b/key-page.png) 

6. You should be able to generate an access token and invoke the API now.

7. Logout and attempt to log in again with a different user from another organization.

    !!! note
        When running both API Manager and WSO2 Identity Server on the same host (localhost), you may encounter an issue where a Developer Portal user does not log out when switching between two users within the same organization. This occurs due to both servers sharing the same host. In a production setup, this issue does not arise as the servers are hosted separately. To overcome this issue, you can use a private browser window for testing locally or set up WSO2 Identity Server on a different host.

        If the Identity Server is running on a **different host** and you encounter an issue with logout session removal, set `logoutSessionStateAppender` to an empty value in the following files.

            <AM_HOME>/repository/deployment/server/webapps/publisher/site/public/conf/settings.json
            <AM_HOME>/repository/deployment/server/webapps/admin/site/public/conf/settings.json
            <AM_HOME>/repository/deployment/server/webapps/devportal/site/public/theme/settings.json


!!! tip 
    Although this feature is enabled by default, organization visibility features are available only after you register organizations. You can explicitly disable this feature by adding the following configuration.

    ```
    [apim.organization_based_access_control]
    enable = false
    ```

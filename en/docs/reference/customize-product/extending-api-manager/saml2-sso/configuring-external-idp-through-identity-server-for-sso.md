# Configuring External IDP through Identity Server for SSO

!!! note
    Please follow [Configuring Identity Server as IDP for SSO]({{base_path}}/develop/extending-api-manager/saml2-sso/configuring-identity-server-as-idp-for-sso) to configure WSO2 Identity Server.
    This guide will assume you have already followed the above tutorial and configured the Identity Server as IDP for SSO.

1. Add a new Identity Provider in WSO2 Identity Server. For more details on configuring external IDPs in WSO2 IS, see [Adding and Configuring a SAML Identity Provider](https://is.docs.wso2.com/en/latest/guides/authentication/standard-based-login/add-saml-idp-login/).

    -   **Identity Provider Name**: ExternalIS
    -   Do the following changes under **Federated Authenticators** &gt; **SAML2 Web SSO Configurations**
        -   **Enable SAML2 Web SSO**
        -   Check **Default**
        -   Set **Service Provider Entity ID**
        -   Set **SSO URL for the external IDP** (e.g., https://localhost:9453/samlsso)
        -   **Enable Logout**

2. Enable **Just-In-Time Provisioning** for the external IDP. For more information, see [Configuring Just-In-Time Provisioning for an Identity Provider](https://is.docs.wso2.com/en/latest/guides/authentication/jit-user-provisioning/).

3. Map the external IDP roles to the roles configured in API Manager. For more information on mapping roles, see [Configuring Roles for an Identity Provider](https://is.docs.wso2.com/en/latest/guides/organization-management/organization-roles/).
    ![role-config]({{base_path}}/assets/img/learn/extensions/saml2-sso/role-config.png)
4. Log in to the Identity Server console (https://{is-ip}:9444/console), navigate to **Applications**, and click **Edit** on the Service Provider you configured.

5. Under **Local & Outbound Authentication Configuration** select **Federated Authentication** . Select the newly created external IDP.
    ![local-inbound-auth]({{base_path}}/assets/img/learn/extensions/saml2-sso/local-inbound-auth.png)

6. Add `http://wso2.org/claims/role` as the Claim URI under **Claim Configuration.** Select the **Mandatory Claim** check box. Add `http:/wso2.org/claims/username` as the Subject Claim URI.
    ![claim-config]({{base_path}}/assets/img/learn/extensions/saml2-sso/claim-config.png)

!!! tip
    Additionally, you might need to configure claims to map them to the available claims in WSO2 Identity Server. For more details, see [Configuring Claims for an Identity Provider](https://is.docs.wso2.com/en/latest/references/idp-settings/).



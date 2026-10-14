# Multi-factor Authentication (MFA) for Publisher and Developer Portals

Multi-factor authentication provides multiple layers of security for a user's identity. Even if one factor is compromised, an attacker cannot gain full access to the target system due to the remaining authentication factors.

You can configure MFA for the Publisher and Developer Portal using WSO2 Identity Server (WSO2 IS) as the Identity Provider (IdP). MFA operates independently of the single sign-on protocol, meaning you can set up WSO2 IS using either **SAML 2.0 Web SSO** or **OpenID Connect (OIDC)**.

Follow the steps below to configure MFA:

1. Configure Single Sign-On (SSO) with WSO2 Identity Server using your preferred protocol:
    - **SAML 2.0 Web SSO**: See [Configure Identity Server as IDP for SSO]({{base_path}}/reference/customize-product/extending-api-manager/saml2-sso/configuring-identity-server-as-idp-for-sso).
    - **OpenID Connect (OIDC)**: See [Configure Identity Server as External IDP Using OIDC]({{base_path}}/install-and-setup/setup/sso/configuring-identity-server-as-external-idp-using-oidc).

2. Configure Multi-factor Authentication in WSO2 Identity Server.  
    For more information and step-by-step instructions, see the [WSO2 Identity Server Multi-Factor Authentication Documentation](https://is.docs.wso2.com/en/latest/guides/mfa/).
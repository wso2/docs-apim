# WSO2 Key Manager

Production API deployments face authentication and authorization challenges: token management complexity, OAuth application lifecycle overhead, inconsistent security policies across providers, and the need for enterprise-grade access control systems.

**WSO2 Key Manager** provides comprehensive authentication and authorization infrastructure within the WSO2 API Manager platform.

As the central security authority for API access, it delivers:

- **Unified Authentication**: Centralized OAuth2, OpenID Connect, and custom authentication schemes
- **Token Lifecycle Management**: Complete token generation, validation, renewal, and revocation workflows
- **Multi-Provider Support**: Built-in key manager with third-party authorization server integration
- **Enterprise Security**: Fine-grained access control with scopes, roles, and policy enforcement
- **Application Management**: OAuth application lifecycle with client credentials and secret management
- **Standards Compliance**: Full OAuth2, OpenID Connect, SAML, and Kerberos protocol support

## Architecture

The Key Manager operates as the authorization server within WSO2 API Manager, providing both built-in key management capabilities and seamless integration with external authorization servers for enterprise identity provider scenarios.

[![Multiple Key Manager Support]({{base_path}}/assets/img/administer/add-km-overview.png){: style="width:80%"}]({{base_path}}/assets/img/administer/add-km-overview.png)

## Built-in Key Manager

The **Built-in Key Manager** provides comprehensive OAuth2 and OpenID Connect capabilities without requiring external dependencies. It handles all authentication and authorization operations internally within the API Manager platform.

### Use Built-in Key Manager when you need
- Self-contained API Manager deployment without external dependencies
- Full control over token generation and validation policies
- Custom grant type implementations and token formats
- Simplified deployment and maintenance requirements

### Built-in Key Manager Features

#### OAuth2 Token Management
- **[JWT Access Tokens]({{base_path}}/key-manager/oauth2/access-token-types/jwt-tokens/)**: Self-contained tokens with embedded claims for gateway validation
- **[Token Persistence]({{base_path}}/key-manager/oauth2/token-persistence/)**: Optimized storage strategies for JWT and opaque tokens
- **[Token Expiration]({{base_path}}/key-manager/oauth2/token-expiration/)**: Configurable token lifetimes and automatic cleanup
- **[Token Revocation]({{base_path}}/key-manager/oauth2/token-revocation/)**: Immediate token invalidation for security incidents
- **[Multiple Active Access Tokens]({{base_path}}/key-manager/oauth2/multiple-active-access-tokens/)**: Concurrent token management per application

#### Grant Type Support
- **[Authorization Code Grant]({{base_path}}/key-manager/oauth2/grant-types/authorization-code-grant/)**: Web application authentication flows with user consent
- **[Client Credentials Grant]({{base_path}}/key-manager/oauth2/grant-types/client-credentials-grant/)**: Service-to-service authentication without user interaction
- **[Password Grant]({{base_path}}/key-manager/oauth2/grant-types/password-grant/)**: Direct credential authentication for trusted applications
- **[Refresh Token Grant]({{base_path}}/key-manager/oauth2/grant-types/refresh-token-grant/)**: Token renewal without re-authentication
- **[JWT Bearer Grant]({{base_path}}/key-manager/oauth2/grant-types/jwt-grant/)**: Token exchange using signed JWT assertions
- **[SAML Extension Grant]({{base_path}}/key-manager/oauth2/grant-types/saml-extension-grant/)**: SAML assertion-based authentication
- **[Kerberos OAuth2 Grant]({{base_path}}/key-manager/oauth2/grant-types/kerberos-oauth2-grant/)**: Windows authentication integration
- **[NTLM Grant]({{base_path}}/key-manager/oauth2/grant-types/ntlm-grant/)**: Windows domain authentication support

#### Security & Access Control
- **[OAuth2 Scopes]({{base_path}}/key-manager/oauth2/oauth2-scopes/scope-whitelisting/)**: Fine-grained permission management with scope whitelisting
- **[Token Encryption]({{base_path}}/key-manager/oauth2/encrypting-oauth2-tokens/)**: Encrypt tokens at rest and in transit
- **[OAuth Key Hashing]({{base_path}}/key-manager/oauth2/hashing-oauth-keys/)**: Secure storage of client credentials
- **[HMAC Token Validation]({{base_path}}/key-manager/oauth2/securing-oauth-token-with-hmac-validation/)**: Additional token integrity verification

#### Application & Client Management
- **[Out-of-Band OAuth Clients]({{base_path}}/key-manager/oauth2/provisioning-out-of-band-oauth-clients/)**: Register applications outside standard flows
- **[OAuth Application Federation]({{base_path}}/key-manager/oauth2/federating-oauth-applications/)**: Cross-tenant application sharing

#### Identity Integration
- **[OpenID Connect]({{base_path}}/key-manager/openid-connect/obtaining-user-profile-information-with-openid-connect/)**: User profile information retrieval with standard claims

## Third-Party Key Manager Integration

**Third-Party Key Manager Integration** enables organizations to leverage existing enterprise identity providers while maintaining centralized API access control through WSO2 API Manager.

### Use Third-Party Key Managers when you need
- Integration with existing enterprise identity infrastructure
- Compliance with organizational authentication policies
- Centralized user management across multiple systems
- Specialized authentication capabilities (hardware tokens, biometrics)

### Supported Third-Party Key Managers

#### Enterprise Identity Providers
- **[WSO2 Identity Server]({{base_path}}/administer/key-managers/configure-wso2is-connector/)**: Full-featured identity and access management platform
- **[WSO2 Identity Server 7.x]({{base_path}}/administer/key-managers/configure-wso2is7-connector/)**: Latest identity server with enhanced capabilities
- **[Keycloak]({{base_path}}/administer/key-managers/configure-keycloak-connector/)**: Open-source identity and access management solution
- **[Okta]({{base_path}}/administer/key-managers/configure-okta-connector/)**: Cloud-based identity service integration

#### Custom Integration
- **[Custom Key Manager]({{base_path}}/administer/key-managers/configure-custom-connector/)**: Build connectors for proprietary authorization servers
- **[Global Key Manager]({{base_path}}/administer/key-managers/configure-global-key-manager/)**: Cross-tenant key manager configuration

#### Cloud Provider Integration
- **[Azure AD Key Manager]({{base_path}}/administer/key-managers/configure-azure-ad-key-manager/)**: Microsoft Azure Active Directory integration
- **[ForgeRock]({{base_path}}/administer/key-managers/configure-forgerock-connector/)**: ForgeRock Identity Platform integration

## Getting Started

### Choose Your Key Manager Strategy

**Built-in Key Manager - Self-Contained Deployment**
Start here for simplified deployment without external identity provider dependencies.

1. Deploy API Manager with built-in key manager capabilities
2. Configure OAuth2 grant types for your application types
3. Set up token policies and security configurations

**Third-Party Integration - Enterprise Identity**
Start here to integrate with existing enterprise identity infrastructure.

1. Assess current identity provider capabilities and requirements
2. Configure appropriate third-party key manager connector
3. Test authentication flows and token validation
4. Gradually migrate applications to centralized authentication

**Hybrid Approach - Mixed Environment**
Start here for organizations with diverse authentication requirements.

1. Configure built-in key manager for internal applications
2. Add third-party key managers for enterprise systems
3. Implement API-level key manager selection policies

## Best Practices

### Start with JWT Tokens for Production
Always use [JWT access tokens]({{base_path}}/key-manager/oauth2/access-token-types/jwt-tokens/) in production deployments. JWT tokens enable gateway-side validation without key manager round-trips, significantly improving performance and reducing latency. Start with standard JWT configurations and customize claims as needed for your applications.

### Implement Token Lifecycle Management Early
Configure appropriate [token expiration]({{base_path}}/key-manager/oauth2/token-expiration/) and implement [token revocation]({{base_path}}/key-manager/oauth2/token-revocation/) capabilities from day one. Set conservative token lifetimes initially and monitor usage patterns to optimize refresh cycles. This prevents token sprawl and security incidents.

### Plan for Multi-Key Manager Scenarios
Even with a single key manager initially, design your API security policies to support [multiple key managers]({{base_path}}/administer/key-managers/overview/). This provides flexibility for future enterprise integrations and enables different authentication strategies for different API consumers without architectural changes.

### Choose Grant Types Based on Application Architecture
Map [OAuth2 grant types]({{base_path}}/key-manager/oauth2/grant-types/overview/) to your application types: use client credentials for service-to-service, authorization code for web applications, and password grant only for highly trusted internal applications. Avoid the implicit grant type in production environments.

### Implement Comprehensive Scope Management
Use [OAuth2 scopes]({{base_path}}/key-manager/oauth2/oauth2-scopes/scope-whitelisting/) to implement fine-grained access control from the beginning. Design your scope hierarchy to match your API resource structure and business permissions. Implement scope whitelisting to prevent privilege escalation.

## Next Steps

Choose your path based on your authentication requirements:

- **[OAuth2 Grant Types Overview]({{base_path}}/key-manager/oauth2/grant-types/overview/)** - For understanding authentication flows and choosing appropriate grant types
- **[Multiple Key Manager Support]({{base_path}}/administer/key-managers/overview/)** - For integrating with existing enterprise identity providers
# Third-Party Key Manager Integration

WSO2 API Manager supports integration with external authorization servers as Key Managers, enabling organizations to leverage existing enterprise identity providers alongside the built-in Key Manager.

## Multiple Key Manager Support

Organizations can configure multiple Key Managers within a single tenant, allowing different APIs and applications to use different authorization servers based on business requirements. Administrators configure these through the Admin Portal, making them available for developers and API creators.

[![Add new Key Manager]({{base_path}}/assets/img/administer/add-km-overview.png){: style="width:80%"}]({{base_path}}/assets/img/administer/add-km-overview.png)

## Supported Third-Party Key Managers

### Enterprise Identity Providers
- **[WSO2 Identity Server]({{base_path}}/key-manager/third-party-key-managers/configure-wso2is-connector/)**: Full-featured identity and access management platform
- **[WSO2 Identity Server 7.x]({{base_path}}/key-manager/third-party-key-managers/configure-wso2is7-connector/)**: Latest identity server with enhanced capabilities  
- **[Keycloak]({{base_path}}/key-manager/third-party-key-managers/configure-keycloak-connector/)**: Open-source identity and access management solution

### Cloud Identity Services
- **[Okta]({{base_path}}/key-manager/third-party-key-managers/configure-okta-connector/)**: Cloud-based identity service integration
- **[Auth0]({{base_path}}/key-manager/third-party-key-managers/configure-auth0-connector/)**: Developer-focused identity platform
- **[Azure AD]({{base_path}}/key-manager/third-party-key-managers/configure-azure-ad-key-manager/)**: Microsoft Azure Active Directory integration

### Enterprise Platforms
- **[PingFederate]({{base_path}}/key-manager/third-party-key-managers/configure-pingfederate-connector/)**: Enterprise federation and single sign-on
- **[ForgeRock]({{base_path}}/key-manager/third-party-key-managers/configure-forgerock-connector/)**: ForgeRock Identity Platform integration

### Custom Integration
- **[Custom Key Manager]({{base_path}}/key-manager/third-party-key-managers/configure-custom-connector/)**: Build connectors for proprietary authorization servers
- **[Global Key Manager]({{base_path}}/key-manager/third-party-key-managers/configure-global-key-manager/)**: Cross-tenant key manager configuration
- **[Application Scopes]({{base_path}}/key-manager/third-party-key-managers/application-scopes/)**: Fine-grained application scope management

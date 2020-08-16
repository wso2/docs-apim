API authentication is a way of protecting API access from unidentified or anonymous access. It ensures that the API is secured and accessible only by the consumers who prove an identity and whose identities are found within the API Management Platform. 

WSO2 API offers following authentication mechanisms to secure your API from unauthenticated access.

[Securing APIs using OAuth2 Access Tokens]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-oauth2-tokens)

   - [JWT(Self Contained) Access Tokens]({{base_path}}/learn/api-security/oauth2/access-token-types/jwt-tokens)
    
   - [Opaque(Reference) Access Tokens]({{base_path}}/learn/api-security/oauth2/access-token-types/opaque-tokens)

[Secure APIs Using API Keys]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-api-keys)

[Secure APIs Using Mutual SSL]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-mutual-ssl)

[Secure APIs Using Basic Authentication]({{base_path}}/learn/api-security/api-authentication/secure-apis-using-basic-authentication)


WSO2 API Manager supports enabling multiple key managers for authentication.

Tenant admin can configure preferred key managers from the admin console. Please refer
[Configuring Key Managers]({{base_path}}/administer/key-managers/overview) for details.

These enabled key managers can be disabled for a given API from the publisher portal by navigating to
`Runtime Configurations -> Application Level Security -> Key Managers`

![Disable Key Managers]({{base_path}}/assets/img/learn/multiple-km-publisher.png)

Application users are able to generate keys for an application using a preferred key manager as shown below.

![Disable Key Managers]({{base_path}}/assets/img/learn/multiple-km-devportal.png)







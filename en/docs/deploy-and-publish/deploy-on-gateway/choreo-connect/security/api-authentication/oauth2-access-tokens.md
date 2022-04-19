# OAuth 2.0 Authentication

By default all APIs expect an access token during invocation, unless [security has been disabled]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/disabling-security/) for the API.

When API-M acts as the Control Plane for Choreo Connect, you can generate an access token and invoke the API by following the steps in [here]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/). This is an access token retrieved from the Resident Key Manager packaged in an API Manager pack (of profile `control-plane`). 

## Access Token (JWT) Validation

Choreo Connect can accept JWTs issued by a **trusted** Key Manager as a valid access token to invoke the APIs. JWT tokens are self-validated by Choreo Connect without validating it against the Authorization Server (Key Manager) that issued the JWT.

When an access token (JWT) issued by a trusted Key Manager is used, Choreo Connect validates the following attributes/claims of the JWT.

-   **Signature** - After validating the signature, Choreo Connect checks whether the JWT was issued by a trusted Key Manager, and has not been tampered. This signature validation is done by using the public certificate of the Key Manager that issued the JWT. 
-   **Issuer(iss)** - The issuer claim is a mandatory claim. Choreo Connect validates the **iss** claim present in the JWT against the issuer provided by the control plane or configured in config.toml.
-   **Subject(sub)** - The subject claim is also a mandatory claim in a token. Choreo Connect uses the value of the **sub** claim as the user of the secured API.
-   **Expiry time(exp)** - "exp" claim is also a mandatory claim. Choreo Connect validates the validity period of the token using the **exp** claim

## JWT Validation Configuration

When [Control Plane is enabled]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/), configurations for all Key Managers are fetched from API-M. For [Standalone Mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/), trusted Key Managers can be configured in `config.toml`. Refer to [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/) to learn more.

Following is an example standalone mode configuration for a trusted Key Manager. When Choreo Connect has API-M as the Control Plane, these configurations will be overridden with the Key Manager configurations retrieved from API Manager if the issuers (Key Managers) are identical. Furthermore, if the corresponding Key Manager is removed from the API Manager Admin portal, the token service added from the configuration will be used.

``` toml
# Issuer 1
[[enforcer.security.tokenService]]
  name="Resident Key Manager"
  issuer = "https://localhost:9443/oauth2/token"
  certificateAlias = "wso2carbon"
  # URL of the JWKs endpoint
  jwksURL = ""
  # Validate subscribed APIs
  validateSubscription = false
  # The claim in which the consumer key of the application is coming
  consumerKeyClaim = "azp"
  # Certificate Filepath within enforcer
  certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"
```

The `issuer` of the above configuration will be used to validate the "iss" claim of the JWT. 

The JWT signature can be validated either by the certificate in `certificateFilePath` (which the alias is defined in `certificateAlias`) or using the issuer's `jwksURL` endpoint. When configured both properties, if the JWT contains the kid (key ID), the token will be validated through the JWKS endpoint.
Importing the public certificate into the Choreo Connect trust store and configuring the certificate alias in the JWT validation configuration section is explained in the [importing certificates to the Choreo Connect truststore]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/importing-certificates-to-the-choreo-connect-truststore/).

To enable [subscription validation](#subscription-validation), enable `validateSubscription` and set `consumerKeyClaim` to the name of the claim in JWT which contains the consumer key of the application.

### Subscription Validation
The [subscription]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/) validation is configurable for JWT tokens.

If an external key manager is used directly with Choreo Connect, which will not know about the subscription details then, subscription validation can be turned off for that particular JWT issuers.

For information on the subscription model and configuration steps, please refer to [the document on Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/subscription-validation).

### Configure Multiple JWT issuers

 There can be use cases in certain organizations, where multiple JWT issuers or key managers are used. In that case, Choreo Connect can be configured to work with JWTs issued by all of them. In the case of multiple JWT issuers are provided, Choreo Connect will sequentially check a JWT with all the available issuers. Valid JWT tokens will be cached and then expiry time only will be validated in the subsequent calls with the same token.

 **Multiple JWT Issuers**

Please refer [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/)


## See Also

- [Access Token Configurations in API-M]({{base_path}}/design/api-security/api-authentication/secure-apis-using-oauth2-tokens/) 
- [Disable Security]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/disabling-security/)
- [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/)
- [Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/subscription-validation)
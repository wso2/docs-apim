# OAuth 2.0 Authentication

Choreo Connect can accept JWTs issued by **trusted** Key Managers as valid Access Tokens to invoke the APIs. JWTs are self-validated by Choreo Connect without validating it against the Authorization Server (Key Manager) that issued the JWT. This is done by validating based on the following attributes/claims of the JWT.
 
-   **Issuer(iss)** - The issuer claim is a mandatory claim and is used to check whether the JWT was issued by a Key Manager trusted by Choreo Connect. The **iss** claim present in the JWT is validated against the issuer map, sent via the control plane or provided in config.toml.
-   **Signature** - Signature validation is done to check if the token was actually issued by the issuer mentioned in the **iss** claim and has not being tampered with. Choreo Connect validates the signature by using the public certificate of the issuer of the JWT (based on the iss value in the token). If a JWKS URL is provided, validation will be done by referring to the JWKS endpoint.
-   **Subject(sub)** - The subject claim is also a mandatory claim in a token. Choreo Connect uses the value of the **sub** claim as the user of the secured API.
-   **Expiry time(exp)** - "exp" claim is also a mandatory claim. Choreo Connect validates the validity period of the token using the **exp** claim

By default all APIs expect an access token during invocation, unless [security has been disabled]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/disabling-security/) for the API.

When API-M acts as the Control Plane for Choreo Connect, you can generate an access token and invoke the API by following the steps [here]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-api-using-the-integrated-api-console/). This is an access token retrieved from the Resident Key Manager packaged in an API Manager pack (of profile `control-plane`).

## JWT validation configuration

- When [Control Plane is enabled]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/apim-as-control-plane/), configurations for all Key Managers are fetched from API-M. 
- For [Standalone Mode]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/as-a-standalone-gateway/), trusted Key Managers can be configured in `config.toml`. 

Refer to [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/) to learn more.

The following is an example standalone mode configuration for a trusted Key Manager. When Choreo Connect has API Manager as the Control Plane, these configurations will be overridden with the Key Manager configurations retrieved from API Manager if the issuers (Key Managers) are identical. This means the value for `issuer` in both configurations is the same. Furthermore, if the corresponding Key Manager is removed from the API Manager Admin Portal, the token service added from the configuration will be used.


``` toml
# Issuer 1
[[enforcer.security.tokenService]]
  name="Resident Key Manager"
  issuer = "https://localhost:9443/oauth2/token"
  certificateAlias = "wso2carbon"
  jwksURL = ""
  validateSubscription = false
  consumerKeyClaim = "azp"
  certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"
```

- The `issuer` of the above configuration will be used to validate the "iss" claim of the JWT. 

- The JWT signature can be validated either by the certificate in `certificateFilePath` (which the alias is defined in `certificateAlias`) or using the issuer's `jwksURL` endpoint. When configured both properties, if the JWT contains the kid (key ID), the token will be validated through the JWKS endpoint. Importing the public certificate into the Choreo Connect trust store and configuring the certificate alias in the JWT validation configuration section is explained in the [importing certificates to the Choreo Connect truststore]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/importing-certificates-to-the-choreo-connect-truststore/).
- To enable [subscription validation](#subscription-validation), set `validateSubscription` to true and set `consumerKeyClaim` to the name of the claim in JWT which contains the consumer key of the application.

Refer to [Token Service in Enforcer Configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/enforcer-configurations/#token-service) to learn about the remaining parameters.

### Enable subscription validation
As mentioned above, [subscription]({{base_path}}/consume/manage-subscription/subscribe-to-an-api/) validation is configurable for tokens issued by each issuer.

If an external key manager is used directly with Choreo Connect, and does not know about the subscription details then, subscription validation can be turned off for that particular JWT issuer. Enable subscription validation to make sure only a token retrieved after subscribing to an API can be used to invoke that specific API.

For information on the subscription model and configuration steps, please refer to [the document on Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/subscription-validation).

### Configure multiple JWT issuers

 There can be use cases in certain organizations, where multiple JWT issuers or key managers are used. In that case, Choreo Connect can be configured to work with JWTs issued by all of them. In the case of multiple JWT issuers are provided, Choreo Connect will sequentially check a JWT with all the available issuers (based on the iss value in the token). Valid JWT tokens will be cached and then expiry time only will be validated in the subsequent calls with the same token.

 **Multiple JWT Issuers**

Please refer [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/)


## See also

- [Access Token Configurations in API-M]({{base_path}}/design/api-security/api-authentication/secure-apis-using-oauth2-tokens/) 
- [Disable Security]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/disabling-security/)
- [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/)
- [Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/subscription-validation)
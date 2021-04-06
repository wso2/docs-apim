# Secure APIs using JWT - Self Contained JWT

Choreo Connect can accept JWTs issued by a **trusted** key manager as a valid token to invoke the APIs.  JWT tokens are self-validated by the API Choreo Connect without validating it against the authorization server(key manager) that issued the JWT.

When a JWT is used as an access token, Choreo Connect validates the following attributes/claims of the JWT.

-   **Signature** - after validating the signature, Choreo Connect checks whether the JWT is issued by a trusted key manager, and JWT has not tampered in the middle. This signature validation is done by using the public certificate of the key manager who issued the JWT. Importing the public certificate into the Choreo Connect trust store and configuring the certificate alias in the JWT validation config section is explained in the [importing certificates to the Choreo Connect truststore]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/importing-certificates-to-the-choreo-connect-truststore/)
-   **Issuer(iss)** - The issuer claim is a mandatory claim when JWT is used as a security token. Choreo Connect validates the **iss** claim present in the JWT against the issuer provided in the **jwtTokenConfig** section of the configuration.
-   **Subject(sub)** - The subject claim is also a mandatory claim in a token. Choreo Connect uses the value of the **sub** claim as the user of the secured API.
-   **Expiry time(exp)** - "exp" claim is also a mandatory claim. Choreo Connect validates the validity period of the token using the **exp** claim

**Jwt token validation config**

``` toml
# JWT token authorization configurations. You can provide multiple JWT issuers
# Issuer 1
[[enforcer.jwtTokenConfig]]
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

The `certificateFilePath`, `issuer` of the above configuration will be used to validate the signature, iss claim of the JWT respectively. This configuration should be added to the `config.toml` file located in `<MG_DISTRIBUTION_HOME>/resources/conf/`.

The JWT signature can be validated either by the certificate (which the alias is defined in certificateAlias) or using the issuer's JWKS endpoint. When configured both properties, if the JWT contains the kid, the token will be validated through the JWKS endpoint.

To enable [subscription validation](#subscription-validation), enable `validateSubscription` and set `consumerKeyClaim` to the name of the claim in JWT which contains the consumer key of the application.

### Subscription Validation
The [subscription]({{apim_path}}/consume/manage-subscription/subscribe-to-an-api/) validation is configurable for JWT tokens.

If an external key manager is used directly with Choreo Connect, which will not know about the subscription details then, subscription validation can be turned off for that particular JWT issuers.

For information on the subscription model and configuration steps, please refer to [the document on Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/subscription-validation).

### Configure Multiple JWT issuers

 There can be use cases in certain organizations, where multiple JWT issuers or key managers are used. In that case, Choreo Connect can be configured to work with JWTs issued by all of them. Multiple JWT issuer feature allows configuring multiple JWT token configurations in the `config.toml` file. Configurations allows to specify array of **jwtTokenConfig** sections. In the case of multiple JWT issuers are provided Choreo Connect will sequentially check a JWT with all the available issuers. Valid JWT tokens will be cached and then expiry time only will be validated in the subsequent calls with the same token.

 **Multiple JWT Issuers**

``` toml
# JWT token authorization configurations. You can provide multiple JWT issuers
# Issuer 1
[[enforcer.jwtTokenConfig]]
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
# Issuer 2
[[enforcer.jwtTokenConfig]]
    name="External Key Manager"
    issuer = "https://<EXTERNAL_KM_URL>/token"
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

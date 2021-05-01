# Secure APIs using JWT - Self Contained JWT

Choreo Connect can accept JWTs issued by a **trusted** key manager as a valid token to invoke the APIs.  JWT tokens are self-validated by the API Choreo Connect without validating it against the authorization server(key manager) that issued the JWT.

When a JWT is used as an access token, Choreo Connect validates the following attributes/claims of the JWT.

-   **Signature** - After validating the signature, Choreo Connect checks whether the JWT is issued by a trusted key manager, and JWT has not tampered in the middle. This signature validation is done by using the public certificate of the key manager who issued the JWT. 
-   **Issuer(iss)** - The issuer claim is a mandatory claim when JWT is used as a security token. Choreo Connect validates the **iss** claim present in the JWT against the issuer provided in the **jwtTokenConfig** section of the configuration.
-   **Subject(sub)** - The subject claim is also a mandatory claim in a token. Choreo Connect uses the value of the **sub** claim as the user of the secured API.
-   **Expiry time(exp)** - "exp" claim is also a mandatory claim. Choreo Connect validates the validity period of the token using the **exp** claim

**JWT validation config**

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
This configuration should be added to the `config.toml` file located in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/`.

The `issuer` of the above configuration will be used to validate the "iss" claim of the JWT. 

The JWT signature can be validated either by the certificate in `certificateFilePath` (which the alias is defined in `certificateAlias`) or using the issuer's `jwksURL` endpoint. When configured both properties, if the JWT contains the kid, the token will be validated through the JWKS endpoint.
Importing the public certificate into the Choreo Connect trust store and configuring the certificate alias in the JWT validation config section is explained in the [importing certificates to the Choreo Connect truststore]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/importing-certificates-to-the-choreo-connect-truststore/).

To enable [subscription validation](#subscription-validation), enable `validateSubscription` and set `consumerKeyClaim` to the name of the claim in JWT which contains the consumer key of the application.

### Subscription Validation
The [subscription]({{apim_path}}/consume/manage-subscription/subscribe-to-an-api/) validation is configurable for JWT tokens.

If an external key manager is used directly with Choreo Connect, which will not know about the subscription details then, subscription validation can be turned off for that particular JWT issuers.

For information on the subscription model and configuration steps, please refer to [the document on Subscription Validation]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authorization/subscription-validation).

### Configure Multiple JWT issuers

 There can be use cases in certain organizations, where multiple JWT issuers or key managers are used. In that case, Choreo Connect can be configured to work with JWTs issued by all of them. Multiple JWT issuer feature allows configuring multiple JWT token configurations in the `config.toml` file. Configurations allows to specify array of **jwtTokenConfig** sections. In the case of multiple JWT issuers are provided Choreo Connect will sequentially check a JWT with all the available issuers. Valid JWT tokens will be cached and then expiry time only will be validated in the subsequent calls with the same token.

 **Multiple JWT Issuers**

``` toml
# Issuer 1
[[enforcer.security.tokenService]]
  name="Resident Key Manager"
  issuer = "https://localhost:9443/oauth2/token"
  certificateAlias = "wso2carbon"
  # URL of the JWKs endpoint
  jwksURL = "https://apim:9443/t/wso2.com/oauth2/jwks"
  # Validate subscribed APIs
  validateSubscription = false
  # The claim in which the consumer key of the application is coming
  consumerKeyClaim = "azp"
  # Certificate Filepath within enforcer
  certificateFilePath = "/home/wso2/security/truststore/wso2carbon.pem"

# Issuer 2
[[enforcer.security.tokenService]]
    name="MGW"
    issuer = "https://localhost:9095/testkey"
    certificateAlias = "mgw"
    # URL of the JWKs endpoint
    jwksURL = ""
    # Validate subscribed APIs
    validateSubscription = false
    # The claim in which the consumer key of the application is coming
    consumerKeyClaim = ""
    # Certificate Filepath within enforcer
    certificateFilePath = "/home/wso2/security/truststore/mg.pem"
```

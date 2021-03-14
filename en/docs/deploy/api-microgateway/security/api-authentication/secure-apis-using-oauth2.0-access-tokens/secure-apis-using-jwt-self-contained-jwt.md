# Secure APIs using JWT - Self Contained JWT

Microgateway can accept JWTs issued by a **trusted** key manager as a valid token to invoke the APIs.  JWT tokens are self-validated by the API Microgateway without validating it against the authorization server(key manager) that issued the JWT.

When a JWT is used as an access token, API Microgateway validates the following attributes/claims of the JWT.

-   **Signature** - after validating the signature, API Microgateway checks whether the JWT is issued by a trusted key manager, and JWT has not tampered in the middle. This signature validation is done by using the public certificate of the key manager which issued the JWT. Importing the public certificate into the API Microgateway trust store and configuring the certificate alias in the JWT validation config section is explained in the [importng certificates to the microgateway truststore]({{base_path}}/deploy/api-microgateway//security/importing-certificates-to-the-api-microgateway-truststore/)
-   **Issuer(iss)** - The issuer claim is a mandatory claim when JWT is used as a security token. Microgateway validates the **iss** claim present in the JWT against the issuer provided in the **jwtTokenConfig** section of the configuration.
-   **Subject(sub)** - The subject claim is also a mandatory claim in a token. Microgateway uses the value of the **sub** claim as the user of the secured API.
-   **Expiry time(exp)** - "exp" claim is also a mandatory claim. Microgateway validates the validity period of the token using the **exp** claim

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

 The JWT signature can be validated either by the certificate (which the alias is defined in certificateAlias) or using the JWKS endpoint of the issuer. When configured both properties, if the JWT contain the kid, the token will be validated through the JWKS endpoint.

<!-- TODO: Enable once the feature is completed for MGW 4.0.0
### Subscription Validation
  The [subscription]({{apim_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api/) validation is configurable for JWT tokens.

!!! note
    When using WSO2 API Manager 3.0.0 or 3.1.0 as the key manager, the JWTs contain the subscribed APIs as a list in the JWT under the **subscribedAPIs** claim. In order to mandate the subscriptions, subscription validation can be enabled. Microgateway will validate the list under the subscribedAPIs claim and check if the user is currently invoking one of the APIs in the list. If not it will send an error message with error code 900908.

In WSO2 API Manager 3.2.0, the JWT token does not contain the Application and Subscribed API claims and the Subscription validation is done in gateway by using a set of maps. API Manager exposes the existing application and subscription details via a REST endpoint and the new API, Application for subscription creations are deploy/api-microgateway/ed via a jms topic as events. When the Microgateway configured to receive these data, it fetches the existing API, Application and Subscription data via the REST endpoint and also subscribes to the JMS topic during the startup.

If an external key manager is used directly with Microgateway, which will not know about the subscription details then, subscription validation can be turned off for that particular JWT issuers.

For information on the subscription model and configuration steps, please refer to [the document on Subscription Validation]({{base_path}}/deploy/api-microgateway//security/api-authorization/subscription-validation/).

--> 

### Configure Multiple JWT issuers

 There can be use cases in certain organizations, where multiple JWT issuers or key managers are used. In that case, Microgateway can be configured to work with JWTs issued by all of them. Multiple JWT issuer feature allows to configure multiple JWT token configurations in the `config.toml` file. Configurations allows to specify array of **jwtTokenConfig** sections. In the case of multiple JWT issuers are provided Microgateway will sequentially check a JWT with all the available issuers. Valid JWT tokens will be cached and then expiry time only will be validated in the subsequent calls with the same token.

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


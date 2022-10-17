# Enforcer Test Key Authentication

Choreo Connect itself provides the ability to generate a JWT as a test key to access the APIs deployed.

### Generating a Test JWT

You can obtain a test JWT with the default configuration using a request similar to the following.

``` java tab="Format"
curl -X POST "https://<hostname>:<port>/testkey" -H "Authorization: Basic <Base64_Encoded(username:password)>" -k
```

``` java tab="Example"
curl -X POST "https://localhost:9095/testkey" -H "Authorization: Basic YWRtaW46YWRtaW4=" -k
```

!!! info
    Here the basic authentication header is the base64 encoded username and password. For an example, `Base64_Encoded(admin:admin)`. This is required because the test key generation service (/testkey) is protected with basic authentication as explained below.

### Configuring Choreo Connect for Test JWT Generation

To configure test JWT generation, open `<CHOREO-CONNECT_HOME>/resources/conf/config.toml` file in a text editor and configure the parameters as described below.

``` yaml
[enforcer.jwtIssuer]
  enabled = true
  issuer = "https://localhost:9095/testkey" # https://<host>:<port>/testkey
  encoding = "base64" # base64,base64url
  claimDialect = ""
  signingAlgorithm = "SHA256withRSA"
  publicCertificatePath = "/home/wso2/security/truststore/mg.pem"
  privateKeyPath = "/home/wso2/security/keystore/mg.key"
  validityPeriod = 3600 # seconds
  [[enforcer.jwtIssuer.jwtUser]]
    username = "admin"
    password = "admin"
  [[enforcer.jwtIssuer.jwtUser]]
    username = "user"
    password = "user123"
```

To allow users to invoke the test key service endpoint with basic authentication, it is required to define the users under `enorfcer.jwtIssuer.jwtUser` providing the username and the password of each user as given above.

!!! Warn
    In production environments, disable the `/testkey` endpoint and remove the issuer "https://localhost:9095/testkey" from the trusted token services list in the config.toml. Set `enabled` to false to disable the endpoint.

To accept these test keys generated from the Enforcer as trusted tokens, the following is added to config.toml by default, giving the same `issuer` and the `publicCertificatePath` parameter values used when configuring `enforcer.jwtIssuer` above.

``` yaml
# Issuer 2
[[security.enforcer.tokenService]]
    name="MGW"
    issuer = "https://localhost:9095/testkey"
    certificateAlias = "mgw"
    jwksURL = ""
    validateSubscription = false
    consumerKeyClaim = ""
    certificateFilePath = "/home/wso2/security/truststore/mg.pem"
```

Refer to [Configuring an External Key Manager]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/security/api-authentication/configuring-an-external-key-manager/) to learn more.

# Passing Enduser Attributes to the Backend Using JWT 

You can use JWT Generation in API Microgateway to send a customized JWT to the backend with user preferred claims. You have 2 possible options when selecting a method to send a JWT to the backend.

- [Generating a JWT in Microgateway](#generating-a-jwt-in-microgateway)
- [Extract backed token from the JWT access token](#extract-backed-token-from-the-jwt-access-token)

### Generating a JWT in Microgateway

Microgateway defines an [AbstractMGWJWTGenerator class](https://github.com/wso2/product-microgateway/blob/master/components/micro-gateway-jwt-generator/src/main/java/org/wso2/micro/gateway/jwt/generator/AbstractMGWJWTGenerator.java) to support developers to write custom JWT generator classes whereas they can extend this abstract class to implement their logic to generate the JWT. There are two abstract methods named `populateStandardClaims` and `populateCustomClaims` where you can write your logic to populate claims in the JWT. Furthermore, you have the capability to write your own logic overriding any of the current methods in the abstract class.

#### Writing a JWT generator

You can find a sample implementation of a JWT generator from [here](https://github.com/wso2/product-microgateway/tree/master/samples/sample-jwt-generator) where the `populateCustomClaims` method is used to add a new claim `"custom": "claim"` to the token apart from the claims which were already available in the authentication token. Developers can import the mgw-jwt-generator dependency as a jar to their local maven repository (The jar for the corresponding dependency is at `<MGW-TOOLKIT_HOOME>/lib/dependencies` directory). 

Apart from writing a JWT generator, developers have the capability to use the default [MGWJWTGeneratorImpl class](https://github.com/wso2/product-microgateway/blob/master/components/micro-gateway-jwt-generator/src/main/java/org/wso2/micro/gateway/jwt/generator/MGWJWTGeneratorImpl.java) without implementing a custom class for JWT generation and manipulate the token, only tweaking the properties of the token using [JWT generator configurations](#jwt-generator-configurations).

#### Adding a custom JWT generator to the project

Once the custom JWT generator is written, the custom JWT generator project should be built and the output jar should be placed in the `<MGW-project>/lib` directory. If third-party libraries are used when writing the JWT generator, these custom jars should also be placed in the same directory.

You can provide the classpath of the custom JWT generator in the `generatorImpl` configuration in the `<MICRO-GW-RUNTIME_HOME>/conf/micro-gw.conf` file. 
    
```toml
[jwtGeneratorConfig]
  jwtGeneratorEnabled=true
  generatorImpl="sample.jwt.generator.SampleJWTGenerator"
```
Since there are getters and setters for all the configuration properties in the abstract class you can use any of the configuration values to implement your logic in the custom JWT generator.

After enabling JWT generation by setting `jwtGeneratorEnabled` configuration property to `true`, start the API Microgateway runtime. When invoking a resource with a JWT token, you will be able to obtain the generated backend JWT.

### Extract backend token from the JWT access token

When you are using JWT authentication, you can pass an already generated JWT token in the 'backendJwt' claim in the authentication JWT token. Therefore, if the authentication token consists the `backendJwt` claim in the payload, the value of the `backendJwt` claim will be set as the backend token in the [desired header](#setting-the-header-of-the-backend-request). This will avoid generating the JWT token within the gateway.

####Sample payload

```json
{
    "sub": "admin@carbon.super",
    "aud": "JzCLuJq6kHIpMhK7C5OhiWN7cPsa",
    "nbf": 1595447942,
    "azp": "JzCLuJq6kHIpMhK7C5OhiWN7cPsa",
    "scope": "am_application_scope default",
    "iss": "https://localhost:9443/oauth2/token",
    "exp": 1595451542,
    "iat": 1595447942,
    "jti": "0987c6d3-f11a-402c-8eb2-b21fb7b97f4d",
    "backendJwt": "eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhdWQiOiJKekNMdUpxNmtISXBNaEs3QzVPaGlXTjdjUHNhIiwibmJmIjoxNTk1NDQ3OTQyLCJhenAiOiJKekNMdUpxNmtISXBNaEs3QzVPaGlXTjdjUHNhIiwic2NvcGUiOiJhbV9hcHBsaWNhdGlvbl9zY29wZSBkZWZhdWx0IiwiaXNzIjoiaHR0cHM6XC9cL2xvY2FsaG9zdDo5NDQzXC9vYXV0aDJcL3Rva2VuIiwiZXhwIjoxNTk1NDUxNTQyLCJpYXQiOjE1OTU0NDc5NDIsImp0aSI6IjA5ODdjNmQzLWYxMWEtNDAyYy04ZWIyLWIyMWZiN2I5N2Y0ZCJ9.Ewz50wbRkFnod4-l5iQzuayHG6O5820Ykg8fQcj_7mIBDAOnWCk7j2a9KOFlJtMyqUXfkchgZEOM0sN9o7GmyYPxpw7x0pjHalNlrdNX8uwnrwaRfgn7G_9d57iFEUTyo7RHfR8uYNJYzSjHgd4x-Vy0-8fZm2OErtoVA0gH7pwnhnE8x3AQOTnBKbGEsWRoR6UmRNGCDwr23GlQ5v7GbPj4puJiE5Z-p5DNOtWuWX1BOpn9IpNn3nio-9wvE9DQUssDojn2G6t8BlM9vv9gMJJT3zK64tfCoWuhTMPn74vs3zGuYy2KO7x7dtULcv2o56slFCqHAID44KuB93vS7A"
}
```

### JWT Generator Configurations

You have the ability customize the token generation from the Microgateway runtime configuration in `<MICRO-GW-RUNTIME_HOME>/conf/micro-gw.conf`.

```toml
# JWT Generator configurations
[jwtGeneratorConfig]
  # Enable jwt generator
  jwtGeneratorEnabled=false
  # Dialect prefix that can be added to the claims
  claimDialect="http://wso2.org/claims"
  # Signature algorithm used to sign the JWT token (only SHA256withRSA and NONE is supported)
  signingAlgorithm="SHA256withRSA"
  # Certificate alias from the keystore
  certificateAlias="ballerina"
  # Private key alias from the keystore
  privateKeyAlias="ballerina"
  # JWT token expiry time - ms (valid only if the jwt generator caching mechanism is disabled)
  tokenExpiry=900000
  # Restricted claims as an array that should not be included in the backend JWT token
  # Example: restrictedClaims=["claim1","claim2","claim3"]
  restrictedClaims=[]
  # Token issuer standard claim
  issuer="wso2.org/products/am"
  # Token audience standard claim
  audience=["http://org.wso2.apimgt/gateway"]
  # JWT token generator implementation
  generatorImpl="org.wso2.micro.gateway.jwt.generator.MGWJWTGeneratorImpl"
  # JWT Generator cache configurations
  [jwtGeneratorConfig.jwtGeneratorCaching]
    # Enable jwt generator token caching
    tokenCacheEnable=true
    # Token cache expiry time (ms)
    tokenCacheExpiryTime=900000
    # Token cache capacity
    tokenCacheCapacity=10000
    # Token cache eviction factor
    tokenCacheEvictionFactor=0.25
```

Outer `[jwtGeneratorConfig]` configuration contains the properties and the customizations of the generated JWT token whereas the inner `[jwtGeneratorConfig.jwtGeneratorCaching]` configuration handles the caching aspects of the generated JWT tokens.

  <table>
    <thead>
    <tr>
    <th style="width: 30%">Configuration</th>
    <th style="width: 35%">Description</th>
    <th style="width: 25%">Default</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td>`jwtGeneratorEnabled`</td>
    <td>Enable JWT Generation process. (Generation will be skipped even though it is enabled if 'backendJwt' claim is present in the authentication JWT token)</td>
    <td>`false`</td>
    </tr>
    <tr>
    <td>`claimDialect`</td>
    <td>Add a claim dialect to the standard claims. (By default it is used in the standard claims generated by an APIM instance)</td>
    <td>`http://wso2.org/claims`</td>
    </tr>
    <tr>
    <td>`signingAlgorithm`</td>
    <td>Signing algorithm used to sign the JWT. When algorithm is specified as NONE, the token will not be signed. (This configuration can only have two values 'SHA256withRSA' or 'NONE')</td>
    <td>`SHA256withRSA`</td>
    </tr>
    <tr>
    <td>`certificateAlias`</td>
    <td>Alias of the certificate from keystore which is included on the JWT header section 'x5t'.</td>
    <td>`ballerina`</td>
    </tr>
    <tr>
    <td>`privateKeyAlias`</td>
    <td>Alias of the key from the keystore which is used to sign the JWT.</td>
    <td>`ballerina`</td>
    </tr>
    <tr>
    <td>`tokenExpiry`</td>
    <td>Validity period of the generated JWT token. (Valid only if the JWT generator caching is disabled, else cache expiry time will be set as the token validity period)</td>
    <td>`900000`</td>
    </tr>
    <tr>
    <td>`restrictedClaims`</td>
    <td>Array of custom claims that should be omitted in the generated JWT token.</td>
    <td>`[ ]`</td>
    </tr>
    <tr>
    <td>`issuer`</td>
    <td>Issuer of the generated JWT. ('iss' standard claim)</td>
    <td>`wso2.org/products/am`</td>
    </tr>
    <tr>
    <td>`audience`</td>
    <td>Audience array of the generated JWT. ('aud' standard claim)</td>
    <td>`["http://org.wso2.apimgt/gateway"]`</td>
    </tr>
    <tr>
    <td>`generatorImpl`</td>
    <td>JWT Generator implementation. (By default a JWT generator implementation is provided in Microgateway whereas you can add your custom implementation here)</td>
    <td>`org.wso2.micro.gateway.jwt.generator.MGWJWTGeneratorImpl`</td>
    </tr>
    <tr>
    <td>`tokenCacheEnable`</td>
    <td>Enable JWT Generator caching which enables to cache generated JWT so that it is not generating separate JWTs for each invocation.</td>
    <td>`true`</td>
    </tr>
    <tr>
    <td>`tokenCacheExpiryTime`</td>
    <td>Expiry time of the JWT Generator cache</td>
    <td>`900000`</td>
    </tr>
    <tr>
    <td>`tokenCacheCapacity`</td>
    <td>Capacity of the JWT Generator cache</td>
    <td>`10000`</td>
    </tr>
    <tr>
    <td>`tokenCacheEvictionFactor`</td>
    <td>Eviction factor of the JWT Generator cache</td>
    <td>`0.25`</td>
    </tr>
    </tbody>
  </table>

#### Adding Claims Retrieved from a remote endpoint

If the user needs to retrieve user claims from a remote endpoint, the microgateway can be configured to support that 
as well. The microgateway has an inbuilt implementation to get user claims from 
`<WSO2 Key Manager URL>/keymanager-operations/user-info/claims/generate` endpoint. If you are willing to use the same 
implementation, you can add the following configuration to the `micro-gw.conf` file.

```toml
[jwtGeneratorConfig.claimRetrieval]
      retrieverImpl="org.wso2.micro.gateway.jwt.generator.MGWClaimRetrieverImpl"
      [jwtGeneratorConfig.claimRetrieval.configuration]
          # The User can provide any key-value pair here. These are the properties used by default.
          # serverUrl = "https://localhost:9443"
          # username = "admin"
          # password = "admin"
```

The `retrieveImpl` Key is used to provide the claim retriever Implementation. Since the value given here denotes an 
inbuilt implementation, the user does not need to add any additional jar files to the project. Under the 
`[jwtGeneratorConfig.claimRetrieval.configuration]`, the user can customize the properties as required. 

In addition to that, it is required to enable claimRetrieval in `[[jwtTokenConfig]]` (per JWT issuer) and 
`[keyManager]` Configurations based on user requirement. 

``` toml tab="jwtTokenConfig"
[[jwtTokenConfig]]
    remoteUserClaimRetrievalEnabled = true
```

<!---To separate the two tabs--->
``` toml tab="keyManager"
[keyManager]
    remoteUserClaimRetrievalEnabled = true
```

!!! note
    If you do not declare the `jwtGeneratorConfig.claimRetrieval.retrieverImpl` property in `micro-gw.conf`, 
    the classloading operation will not happen within the microgateway. Hence, the claim retrieval process will 
    not be executed.
        

There can be usecases where the users need to come up with their own claim retrieval Implementation. In such 
a scenario, the user needs to implement the specific class extended from 
[AbstractMGWClaimRetriever](https://github.com/wso2/product-microgateway/blob/v3.2.0/components/micro-gateway-jwt-generator/src/main/java/org/wso2/micro/gateway/jwt/generator/AbstractMGWClaimRetriever.java) class.
For that, the user can have the same maven dependency used for custom JWT Generation implementation. A sample 
implementation is available [here](https://github.com/wso2/product-microgateway/tree/master/samples/sample-jwt-generator).
In the end, you can add the corresponding jar file to the microgateway project's `/lib` directory prior to executing 
`micro-gw build` command.

```xml tab="Maven dependency"
<dependencies>
    <dependency>
        <groupId>org.wso2.am.microgw</groupId>
        <artifactId>mgw-jwt-generator</artifactId>
        <version>3.2.0</version>
    </dependency>
</dependencies>
```

!!! note
    Please note that if you have used any additional dependencies to the customized implementation, you may need to add all
    of them to the microgateway project's `/lib` directory. This is because if the microgateway can't find 
    those dependencies within the project, the functionality will not be available.

### Setting the authentication header of the backend request

When you are passing a token to the backend or when you are generating a JWT inside Microgateway, you can configure the header in which the JWT token will be passed to the backend. The following configuration should be added to the Microgateway runtime configuration in `micro-gw.conf`. (By default the header is set to X-JWT-Assertion)

```toml
[jwtConfig]
    # JWT header when forwarding the request to the backend
    header = "X-JWT-Assertion"
```

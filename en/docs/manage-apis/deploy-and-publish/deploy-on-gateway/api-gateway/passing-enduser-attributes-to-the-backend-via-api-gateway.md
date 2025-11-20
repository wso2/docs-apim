# Passing End User Attributes to the Backend

There can be scenarios where a backend service needs to make different decisions or respond with different data, depending on the application end-user that consumes an API. To achieve this the backend service needs to have access to the respective end-user's data at the time an API call takes place.

This can be facilitated by the Gateway by sending the end user attributes that are defined in the respective user store, in a JWT via an HTTP header, to the backend service when the API call is being forwarded.

## How does it work?

The backend JSON Web Token (JWT) contains the claims that are transferred between two parties, such as the end-user and the backend. A claim is an attribute of the user that is mapped to the underlying user store. A set of claims is referred to as a dialect (e.g., http://wso2.org/claims).

If you enable backend JWT generation in the Gateway, each API request will carry a digitally signed JWT, which is in the following format to the backend service.

`{token header}.{claims list}.{signature}`

When the request goes through the Gateway, the backend JWT is appended as a transport header to the outgoing message. The backend service fetches the JWT and retrieves the required information about the user, application, or token.

## Sample backend JWT

The following is an example of a backend JWT:

``` json
{
    "typ":"JWT",
    "alg":"RS256",
    "x5t":"ODE3Y2ZhMTBjMDM4ZTBmMjAyYzliYTI2YjRhYTZlOGIyZmUxNWE3YQ==",
    "kid":"Q049bG9jYWxob3N0LCBPVT1XU08yLCBPPVdTTzIsIEw9TW91bnRhaW4gVmlldywgU1Q9Q0EsIEM9VVMjMTY3NzA4OTI4Mw"
}
{
    "iss":"wso2.org/products/am",
    "exp":1345183492181,
    "http://wso2.org/claims/subscriber":"admin",
    "http://wso2.org/claims/applicationname":"app2",
    "http://wso2.org/claims/apicontext":"/placeFinder",
    "http://wso2.org/claims/version":"1.0.0",
    "http://wso2.org/claims/tier":"Silver",
    "http://wso2.org/claims/enduser":"sumedha"
}
```

The above JSON Web Token (JWT) contains the following information.

**JWT Header :**

- `"typ"` - Declares that the encoded object is a JWT access token
- `"alg"` - This defines the specific algorithm intended for use with the key
- `"x5t"` - Thumbprint of the x.509 cert (SHA-1 thumbprint)
- `"kid"` - Key ID parameter is a unique identifier used to match a specific key

**JWT Claims set :**

-   `"iss"` - The issuer of the JWT
-   `"exp"` - The token expiration time
-   `"http://wso2.org/claims/subscriber"` - Subscriber to the API, usually the app developer
-   `"http://wso2.org/claims/applicationname"` - Application through which API invocation is done
-   `"http://wso2.org/claims/apicontext"` - Context of the API
-   `"http://wso2.org/claims/version "` - API version
-   `"http://wso2.org/claims/tier"` - Tier/price band for the subscription
-   `"http://wso2.org/claims/enduser"` - End-user of the app whose action invoked the API

## Changing the JWT encoding to Base64URL encoding

The default backend JWT generator, `org.wso2.carbon.apimgt.impl.token.JWTGenerator`, encodes the value of the JWT using Base64 encoding. However, for certain apps you might need to have it in Base64URL encoding.

Use the following format to encode the JWT using Base64URL encoding, by adding the `base64url` in the `apim.jwt.encoding` element, which is in the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` toml
[apim.jwt]
...
encoding = "base64url"
```

## Validating backend JWT using JWKS endpoint

Backend JWTs can be signed with RSA to ensure their validity when being sent between 2 parties. To verify the JWT on the backend, we need the public certificate of the private key used to sign the JWT at the Gateway. The JWKS endpoint is a way to get this public certificate.

The JWKS endpoint can be accessed via the following URL depending on the tenant.

=== "Super Tenant"
    ```url
    https://<hostname>:8243/jwks
    ```

=== "Tenant"
    ```url
    https://<hostname>:8243/t/<tenant domain>/jwks
    ```

Refer to the following sample JWKS response.

```
{
    "keys": [
        {
            "kty": "RSA",
            "e": "AQAB",
            "use": "sig",
            "kid": "Q049bG9jYWxob3N0LCBPVT1XU08yLCBPPVdTTzIsIEw9TW91bnRhaW4gVmlldywgU1Q9Q0EsIEM9VVMjMTY3NzA4OTI4Mw",
            "alg": "RS256",
            "n": "zNqjfB4ypY0QkM4QnrtcFlRmFjdJYTzeTEzZj3PaJtNmcOCxVNwomUwbkISogv4O4J0lDVAyq6aapDNY9JzxsoLehosqyuKar3IGSJhm8IM8N7uVfT0mLQ-rho3zXE7_FahS-rwIp-OUPqJvRH8enc2mpfghG8cvBx4qq6VzMS3B72CfNAPyEeFJwi4R4ZgXzslbr_oGMJBHSQDhVEoA8ukQzUsLafbt3sFMDVy0t5KNSazRBLcHSPlx5B0W4JSWf_vv1A_c1v9AJSksxrSsRqRjoaHgp3AzhZw7LDsowfxqHZ5bF0Thxq4OXEOsk_rSPIHvRilk7OP-epTXwZpw4Q"
        }
    ]
}
```

The above JWKS response contains an array of public keys available from the gateway, where each key is described using the following parameters:

- `"kty"` - Key type identifies the cryptographic family this key belongs to.
- `"e"` - The exponent value of the public key.
- `"use"` - This defines the use of the key, whether it is used for signing or encryption.
- `"kid"` - This is an ID parameter used to match a specific key(s).
- `"alg"` - This defines the specific algorithm intended for use with the key.
- `"n"` - The modulus value of the public key.

In order to validate the backend JWT using JWKS, you will need to invoke the JWKS endpoint and retrieve the kid property. Also, you need the extract the kid property from the Header of the decoded JWT. Thus extracted kid values are expected to be identical.

## Expiry time of the JWT

The JWT expiry time depends directly on whether caching is enabled in the Gateway Manager or Key Manager. The WSO2 Universal Gateway caching is enabled by default. However, if required, you can enable or disable the caching for the Gateway Manager or the Key Manager using the `apim.cache.gateway_token.enable` or `apim.cache.km_token.enable` elements respectively in the `<API-M_HOME>/repository/conf/deployment.toml` file. If caching is enabled for the Gateway Manager or the Key Manager, the JWT expiry time will be the same as the default cache expiry time.

The claims that are retrieved for the JWT access token generation are cached. You can set the expiry time of these JWT claims by setting the `apim.cache.jwt_claim.expiry_time` in the `<API-M_HOME>/repository/conf/deployment.toml` file:

``` toml
[apim.cache.jwt_claim]
enable = true
expiry_time = "900"
```

## Enabling the default backend JWT generator

Before passing end user attributes, you need to enable and configure the JWT implementation, as mentioned below in the default Universal Gateway.

1. Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.

2. Enable and configure the JWT implementation.

     ```toml
     [apim.jwt]
     enable = true
     ```

     For more information, see [JWT generation configuration details](#backend-jwt-generator-configuration-details).

3. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

      This will start WSO2 API Manager in the all-in-one mode, which includes the default Gateway as well.

## Enabling a customized backend JWT generator

!!! note
    WSO2 API Manager comes with the default JWT generator. This JWT generator will generate specific claims based on the specifications and the user demands at the time the product is released. When you update the products, you will need to add/change some of the claims based on the specification updates. This means that even with the given released version, standard claims that come from the API Manager are subjected to change. Therefore, if you have planned to use specific claims in the backend, it is always recommended to implement a custom JWT generator with mandatory claims you wish to consume at your backend.

### Customizing the JWT Generation completely

The JWT that is generated by default ([see example above](#sample-jwt)) has predefined attributes that are passed to the backend. These include basic application-specific details, subscription details, and user information that are defined in the JWT generation class that comes with WSO2 API Manager by the name `org.wso2.carbon.apimgt.keymgt.token.JWTGenerator`. 

Follow the instructions below if you want to pass additional attributes to the backend with the JWT or completely change the default JWT generation logic:

1.  Write your own custom JWT implementation class by extending the default `JWTGenerator` class. 

     A typical example of implementing your own claim generator is given below. It implements the `populateCustomClaims()` method to generate some custom claims and adds them to the JWT.  

    ``` java
    import org.wso2.carbon.apimgt.impl.APIConstants;
    import org.wso2.carbon.apimgt.impl.dto.APIKeyValidationInfoDTO;
    import org.wso2.carbon.apimgt.keymgt.token.JWTGenerator;
    import org.wso2.carbon.apimgt.api.*;

    import java.util.Map;

    public class CustomTokenGenerator extends JWTGenerator {
        public Map<String, String> populateStandardClaims(TokenValidationContext validationContext)
                throws APIManagementException {
            Map<String, String> claims = super.populateStandardClaims(validationContext);
            boolean isApplicationToken =
                    validationContext.getValidationInfoDTO().getUserType().equalsIgnoreCase(APIConstants.ACCESS_TOKEN_USER_TYPE_APPLICATION) ? true : false;
            String dialect = getDialectURI();
            if (claims.get(dialect + "/enduser") != null) {
                if (isApplicationToken) {
                    claims.put(dialect + "/enduser", "null");
                    claims.put(dialect + "/enduserTenantId", "null");
                } else {
                    String enduser = claims.get(dialect + "/enduser");
                    if (enduser.endsWith("@carbon.super")) {
                        enduser = enduser.replace("@carbon.super", "");
                        claims.put(dialect + "/enduser", enduser);
                    }
                }
            }
            return claims;
        }

        public Map<String, String> populateCustomClaims(TokenValidationContext tokenValidationContext) throws APIManagementException {
            Long time = System.currentTimeMillis();
            String text = "This is custom JWT";
            Map map = new HashMap();
            map.put("current_timestamp", time.toString());
            map.put("message" , text);
            return map;
        }
    }
    ```

     Click here for a sample [Custom JWT Generator](https://github.com/wso2/samples-apim/tree/master/CustomJWTGenerator).

2.  [Build your class](https://dzone.com/articles/custom-jwt-generator-in-wso2-api-manager) and add the JAR file to the `<API-M_HOME>/repository/components/lib` directory where the node works as the Key Manager node.

3.  Add your class in the `apim.jwt.generator_impl` element of the `<API-M_HOME>/repository/conf/deployment.toml` file.

     ``` toml
     [apim.jwt]
     ...
     generator_impl = "org.wso2.carbon.test.CustomTokenGenerator"
     ```
     
    !!! note
         Note that `CustomTokenGenerator` is for opaque tokens only and public class `CustomGatewayJWTGenerator` is for JWT.

4.  Set the `apim.jwt.enable` element to **true** in the `deployment.toml` file.

5.  [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

     This will start WSO2 API Manager in the all-in-one mode, which includes the default Gateway as well.

### Customizing the user-related claims in JWT

The JWT contains the list of user claims added when you enable the `apim.jwt.enable_user_claims` to `true` via the user store.

Follow the instructions below to change the existing functionality of retrieving end user related claims to the JWT:

1. Write your own Claim Retriever implementation by implementing `org.wso2.carbon.apimgt.impl.token.ClaimsRetriever`.

    ``` java
    package org.wso2.carbon.test;

    import org.wso2.carbon.apimgt.api.APIManagementException;
    import org.wso2.carbon.apimgt.impl.token.ClaimsRetriever;

    import java.util.SortedMap;
    import java.util.TreeMap;
    import java.util.UUID;

    public class CustomClaimRetriever implements ClaimsRetriever {

        public void init() throws APIManagementException {
        //  Todo : initialize any variable for Claim retriever.
        }

        public SortedMap<String, String> getClaims(String endUserName) throws APIManagementException {

            SortedMap<String, String> claimsMap = new TreeMap();
            claimsMap.put("token-uuid", UUID.randomUUID().toString());
            if ("user1".equals(endUserName)){
                claimsMap.put("privileged", "true");
            }
            return claimsMap;
        }

        public String getDialectURI(String s) throws APIManagementException {

            return "http://wso2.org/claims";
        }
    }
    ```

    Click here for a sample [Custom Claim Retriever](https://github.com/wso2/samples-apim/tree/master/CustomJWTGenerator).

2. Build your class and JAR file in the `<API-M_HOME>/repository/components/lib` directory where the node works as the Key Manager node.

3. Set the `apim.jwt.claims_extractor_impl` to you class name.

     ```toml
     [apim.jwt]
     ....
     claims_extractor_impl="org.wso2.carbon.test.CustomClaimRetriever"
     ....
     ```

4. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

      This will start WSO2 API Manager in the all-in-one mode, which includes the default Gateway as well.

## JWT (Self Contained) Access Tokens

By default, the backend JWT is generated by the Gateway. When generating the backend JWT, it retrieves the claims from the invoked JWT.

If you need to change the way that JWT is generated in the Gateway, such as by adding additional claims or by completely changing the JWT, follow the instructions below to implement the Gateway JWT generation:

1. Write your own JWTGenerator class extending the `org.wso2.carbon.apimgt.common.gateway.jwtgenerator.APIMgtGatewayJWTGeneratorImpl` class.

    ```java
    package org.wso2.carbon.test;
    
    import org.osgi.service.component.annotations.Component;
    import org.wso2.carbon.apimgt.gateway.dto.JWTInfoDto;
    import org.wso2.carbon.apimgt.common.gateway.jwtgenerator.APIMgtGatewayJWTGeneratorImpl;
    import org.wso2.carbon.apimgt.common.gateway.jwtgenerator.AbstractAPIMgtGatewayJWTGenerator;
    import java.util.Map;
    import java.util.UUID;

    @Component(
    enabled = true,
    service = AbstractAPIMgtGatewayJWTGenerator.class,
    name = "customgatewayJWTGenerator"
    )
    
    public class CustomGatewayJWTGenerator extends APIMgtGatewayJWTGeneratorImpl {
    @Override
    public Map<String, Object> populateStandardClaims(JWTInfoDto jwtInfoDto) {
    return super.populateStandardClaims(jwtInfoDto);
    }
    @Override
    public Map<String, Object> populateCustomClaims(JWTInfoDto jwtInfoDto) {
    Map<String, Object> claims = super.populateCustomClaims(jwtInfoDto);
    claims.put("uuid", UUID.randomUUID().toString());
    return claims;
    }
    }
    ```

    Click here for a sample [Custom Gateway JWTGenerator](https://github.com/wso2/samples-apim/tree/master/CustomGatewayJWTGenerator).

2. Build your class and the JAR file in the `<API-M_HOME>/repository/components/dropins` directory where the node works as the Gateway node.

3. Set `apim.jwt.gateway_generator.impl` to your class name in the `<API-M_HOME>/repository/conf/deployment.toml`.

    ```toml
    [apim.jwt.gateway_generator]
    impl = "org.wso2.carbon.test.CustomGatewayJWTGenerator"
    ```

4. Start the server.

## Backend JWT generator configuration details

!!! note
    Enable JWT in all Gateway nodes. For more information on setting up a distributed deployment of API Manager, see [Deploying WSO2 API-M in a Distributed Setup]({{base_path}}/install-and-setup/setup/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).

<table>
<thead>
<tr class="header">
<th><b>Element</b></th>
<th><b>Description</b></th>
<th><b>Default Value</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>apim.jwt.enable</code></pre></td>
<td>Uncomment this property and set this value to <strong><code>true</code></strong> to enable JWT.</td>
<td><code>false</code></td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.header</code></pre></td>
<td>The name of the HTTP header to which the JWT is attached.</td>
<td><code>X-JWT-Assertion</code></td>
</tr>
<tr class="odd">
<td><pre><code>apim.jwt.enable_user_claims</code></pre></td>
<td>Uncomment this property and set this value to <strong><code>true</code></strong> to enable user claims in JWT in opaque Token</td>
<td><code>false</code></td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.claims_extractor_impl</code></pre></td>
<td>
Uncomment this configuration and configure custom Claim Retriever to add
custom claims into JWT when invocation token in opaque mode.
</td>
<td><code>org.wso2.carbon.apimgt.impl.token.ExtendedDefaultClaimsRetriever</code></td>
</tr>
<tr class="odd">
<td><pre><code>apim.jwt.claim_dialect</code></pre></td>
<td><div class="content-wrapper">
<p>The dialect URI under which the user's claims are be looked for. Only works with the default value of the <code>apim.jwt.claims_extractor_impl</code> element defined above.</p>
<p>The JWT access token contains all claims that are defined in the <code>apim.jwt.claim_dialect</code> element. The default value of this element is <code>http://wso2.org/claims</code>. To get the list of a specific user's claims that need to be included in the JWT, simply uncomment this element after enabling the JWT. It will include all claims in <code>http://wso2.org/claims</code> to the JWT access token.</p>
</div></td>
<td><code>http://wso2.org/claims</code></td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.use_sha256_hash</code></pre></td>
<td><p>Specifies whether the certificate header is signed using the SHA256 algorithm. The default algorithm used to generate the header value is SHA1.</p></td>
<td><code>false</code></td>
</tr>
<tr class="odd">
<td><pre><code>apim.jwt.signing_algorithm</code></pre></td>
<td><p>The signing algorithm used to sign the JWT. The general format of the JWT is <code>{token infor}.{claims list}.{signature}</code>. When NONE is specified as the algorithm, signing is turned off and the JWT looks as <code>{token infor}.{claims list}</code> with two strings delimited by a period and a period at the end.</p>
<p>This element can have only two values - the default values are <code>SHA256withRSA</code> or <code>NONE</code>.</p></td>
<td><code>SHA256withRSA</code></td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.gateway_generator.impl</code></pre></td>
<td><p>Fully qualified custom JWT generator to used in JWT(Self Contained) Access Tokens</p></td>
<td><code>org.wso2.carbon.apimgt.gateway.handlers.security.jwt.generator.APIMgtGatewayJWTGeneratorImpl</code></td>
</tr>
<tr class="odd">
<td><pre><code>apim.jwt.gateway_generator.excluded_claims</code></pre></td>
<td><p>List of claims that are not supposed to be included in the Backend JWT when using JWT (Self Contained) Access Tokens</p></td>
<td>N/A</td>
</tr>
<tr class="even">
<td><pre>
<code>
apim.jwt.binding_federated_user_claims</code></pre></td>
<td><p>This disables the binding federated user claims to the backend JWT generator.</p></td>
<td><code>false</code></td>
</tr>
<tr class="odd">
<td><pre><code>apim.jwt.use_kid_property</code></pre></td>
<td><p>Specifies whether the backend JWT header should include the kid claim</p></td>
<td><code>true</code></td>
</tr>
</tbody>
</table>

!!! tip
    You can use TCPMon or Universal Gateway debug logs to capture the JWT access token header with end user details. Follow the instructions below to enable the Gateway DEBUG logs for wire messages:

    1.  Go to the `<APIM_GATEWAY>/repository/conf` directory and open the `log4j2.properties` file with a text editor.
    2.  Add these two loggers to the list of loggers:<br/>
    <code>loggers = AUDIT_LOG, trace-messages,... <strong>, synapse-headers, synapse-wire</strong></code>

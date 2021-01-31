# Passing Enduser Attributes to the Backend Using JWT

**JSON Web Token (JWT)** is used to represent claims that are transferred between two parties such as the end-user and the backend.

A claim is an attribute of the user that is mapped to the underlying user store. It is encoded as a JavaScript Object Notation (JSON) object that is used as the payload of a JSON Web Signature (JWS) structure or as the plain text of a JSON Web Encryption (JWE) structure. This enables claims to be digitally signed.

A set of claims is referred to as a dialect (e.g., `http://wso2.org/claims`). The general format of a JWT is `{token infor}.{claims list}.{signature}`. The API implementation uses information such as logging, content filtering, and authentication/authorization that is stored in this token. The token is Base64-encoded and sent to the API implementation in an HTTP header variable. The JWT is self-contained and is divided into three parts as the header, the payload, and the signature. For more information on JWT, see [JSON Web Token (JWT) Overview](http://openid.net/specs/draft-jones-json-web-token-07.html#anchor3).

The API Manager passes attributes of the API invoker to the backend API implementation using JWT to authenticate end-users. In most production deployments, service calls go through WSO2 API Manager or a proxy service. If you enable JWT generation in WSO2 API Manager, each API request will carry a JWT to the back-end service. When the request goes through the API Manager, the JWT is appended as a transport header to the outgoing message. The back-end service fetches the JWT and retrieves the required information about the user, application, or token.

An example of a JWT is given below:

``` java
{
    "typ":"JWT",
    "alg":"NONE"
    }{
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

**JWT Header :** The header section declares that the encoded object is a JWT access token and the JWT is in plain text, that is not signed using any encryption algorithm.

**JWT Claims set :**

-   `"iss"` - The issuer of the JWT
-   `"exp"` - The token expiration time
-   `"http://wso2.org/claims/subscriber"` - Subscriber to the API, usually the app developer
-   `" http://wso2.org/claims/applicationname"` - Application through which API invocation is done
-   `" http://wso2.org/claims/apicontext"` - Context of the API
-   `" http://wso2.org/claims/version "` - API version
-   `" http://wso2.org/claims/tier"` - Tier/price band for the subscription
-   `" http://wso2.org/claims/enduser"` - End-user of the app who's action invoked the API

Let's see how to enable and pass information in the JWT or completely alter the JWT generation logic in WSO2 API Manager:

## Configuring JWT

Before passing end-user attributes, you need to enable and configure the JWT implementation in the `<API-M_HOME>/repository/conf/deployment.toml` file. The relevant elements are described below. If you do not configure these elements, they take their default values.

!!! note
    Enable JWT in all Gateway nodes. For more information on setting up a distributed deployment of API Manager, see [Deploying WSO2 API-M in a Distributed Setup]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).


<table>
<thead>
<tr class="header">
<th>Element</th>
<th>Description</th>
<th>Default Value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>apim.jwt.enable</code></pre></td>
<td>Uncomment this property and set this value to <strong><code>true</code></strong> to enable JWT.</td>
<td>false</td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.header</code></pre></td>
<td>The name of the HTTP header to which the JWT is attached.</td>
<td>X-JWT-Assertion</td>
</tr>
<tr class="odd">
<td><pre><code>apim.jwt.enable_user_claims</code></pre></td>
<td>Uncomment this property and set this value to <strong><code>true</code></strong> to enable user claims in JWT in opaque Token</td>
<td>false</td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.claims_extractor_impl</code></pre></td>
<td>
Uncomment this configuration and configure custom Claim Retriever to add
custom claims into JWT when invocation token in opaque mode.
</td>
<td>org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever</td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.claim_dialect</code></pre></td>
<td><div class="content-wrapper">
<p>The dialect URI under which the user's claims are be looked for. Only works with the default value of the <code>apim.jwt.claims_extractor_impl</code> element defined above.</p>
<p>The JWT access token contains all claims that are defined in the <code>apim.jwt.claim_dialect</code> element. The default value of this element is <code>http://wso2.org/claims</code>. To get the list of a specific user's claims that need to be included in the JWT, simply uncomment this element after enabling the JWT. It will include all claims in <code>http://wso2.org/claims</code> to the JWT access token.</p>
</div></td>
<td>http://wso2.org/claims</td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.convert_dialect</code></pre></td>
<td><div class="content-wrapper">
<p>In the Authorization code grant flow, backend JWT token contains claims from OIDC dialect even though
 <code>apim.jwt.claim_dialect</code> has been configured with the value <code>http://wso2.org/claims</code>. The
  reason is that claims are taken from AuthorizationGrantCache, which contains the OIDC claim dialect values. And
   this is happening due to a modification done to avoid the getUserClaimValues call to WSO2 user store during JWT
    generation. So, AuthorizationGrantCache is used for retrieving user claims.</p>
<p>In order to remap the OIDC claims into the configured dialect (by <code>apim.jwt.claim_dialect</code> value
), the <code>apim.jwt.convert_dialect</code> configuration value should be set to <code>true</code>.</p>
</div>
</td>
<td>false</td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.signing_algorithm</code></pre></td>
<td><p>The signing algorithm used to sign the JWT. The general format of the JWT is <code>              {token infor}.{claims list}.{signature}</code>. When NONE is specified as the algorithm, signing is turned off and the JWT looks as <code>{token infor}.{claims list}</code> with two strings delimited by a period and a period at the end.</p>
<p>This element can have only two values - the default values are `SHA256withRSA` or `NONE`.</p></td>
<td>SHA256withRSA</td>
</tr>
<tr class="odd">
<td><pre><code>apim.jwt.gateway_generator.impl</code></pre></td>
<td><p>Fully qualified custom JWT generator to used in JWT(Self Contained) Access Tokens</p></td>
<td>org.wso2.carbon.apimgt.gateway.handlers.security.jwt.generator.APIMgtGatewayJWTGeneratorImpl</td>
</tr>
<tr class="even">
<td><pre><code>apim.jwt.gateway_generator.excluded_claims</code></pre></td>
<td><p>List of claims that are not supposed to be included in thee Backend JWT when using JWT (Self Contained) Access Tokens</p></td>
<td>N/A</td>
</tr>
</tbody>
</table>

!!! tip
    You can use TCPMon or API Gateway debug logs to capture the JWT access token header with end-user details. Follow the instructions below to enable the Gateway DEBUG logs for wire messages:

    1.  Go to the `<APIM_GATEWAY>/repository/conf` directory and open the `log4j2.properties` file with a text editor.
    2.  Add these two loggers to the list of loggers:<br/>
    <code>loggers = AUDIT_LOG, trace-messages,... <strong>, synapse-headers, synapse-wire</strong></code>

## Changing the JWT encoding to Base64URL encoding

The default JWT generator, `org.wso2.carbon.apimgt.impl.token.JWTGenerator`, encodes the value of the JWT using Base64 encoding. However, for certain apps you might need to have it in Base64URL encoding.

Use the following format to encode the JWT using Base64URL encoding, by adding the `base64url` in the `apim.jwt.encoding` element, which is in the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` toml
[apim.jwt]
...
encoding = "base64url"
```

## Expiry time of the JWT

JWT expiry time depends directly on whether caching is enabled in the Gateway Manager or Key Manager. The WSO2 API-M Gateway caching is enabled by default. However, if required, you can enable or disable the caching for the Gateway Manager or the Key Manager using the `apim.cache.gateway_token.enable` or `apim.cache.km_token.enable` elements respectively in the `<API-M_HOME>/repository/conf/deployment.toml` file. If caching is enabled for the Gateway Manager or the Key Manager, the JWT expiry time will be the same as the default cache expiry time.

The claims that are retrieved for the JWT access token generation are cached. The expiry time of these JWT claims can be set by setting the **apim.cache.jwt_claim.expiry_time** in the `deployment.toml` file:

``` toml
[apim.cache.jwt_claim]
enable = true
expiry_time = "900"
```

## Customizing the JWT generation - (Opaque (Reference) Access Tokens)

### Customizing the JWT Generation completely

The JWT that is generated by default (see example above) has predefined attributes that are passed to the backend. These include basic application-specific details, subscription details, and user information that are defined in the JWT generation class that comes with WSO2 API Manager by the name `org.wso2.carbon.apimgt.keymgt.token.JWTGenerator`. 

Follow the instructions below if you want to pass additional attributes to the backend with the JWT or completely change the default JWT generation logic:

1.  Write your own custom JWT implementation class by extending the default `JWTGenerator` class. A typical example of implementing your own claim generator is given below. It implements the `populateCustomClaims()` method to generate some custom claims and adds them to the JWT.  

    ``` java
    import org.wso2.carbon.apimgt.keymgt.APIConstants;
    import org.wso2.carbon.apimgt.keymgt.dto.APIKeyValidationInfoDTO;
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
            map.put("messge" , text);
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

4.  Set the `apim.jwt.enable` element to **true** in the `deployment.toml` file.

5.  Restart the server.

### Customizing the user-related claims in JWT

The JWT contains the list of user claims added when you enable the `apim.jwt.enable_user_claims` to `true` via the user store.

Follow the instructions below to change the existing functionality of retrieving end-user related claims to the JWT:

1. Write your own Claim Retriever implementation by implmenting `org.wso2.carbon.apimgt.impl.token.ClaimsRetriever`.

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

4. Start the server.

### Customizing the JWT generation - (JWT (Self Contained) Access Tokens)

By default, the backend JWT is generated by the Gateway. When generating the backend JWT, it retrieves the claims from the invoked JWT.

If you need to change the way that JWT is generated in the Gateway such as by adding additional claims or by completely changing the JWT, follow the instructions below to implement the Gateway JWT generation:

1. Write your own JWTGenerator class extending the `org.wso2.carbon.apimgt.gateway.handlers.security.jwt.generator.AbstractAPIMgtGatewayJWTGenerator` class.

    ```java
    package org.wso2.carbon.test;

    import org.osgi.service.component.annotations.Component;
    import org.wso2.carbon.apimgt.gateway.dto.JWTInfoDto;
    import org.wso2.carbon.apimgt.gateway.handlers.security.jwt.generator.APIMgtGatewayJWTGeneratorImpl;
    import org.wso2.carbon.apimgt.gateway.handlers.security.jwt.generator.AbstractAPIMgtGatewayJWTGenerator;

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

!!! note
    WSO2 API Manager comes with the default JWT generator. This JWT generator will generate specific claims according to the specifications and the user demands by the time we release the product. And when we update the products, we will need to add/change some of the claims according to the specification updates. That means even with the given released version, standard claims that come from the API Manager subjected to change. So if you have planned to use specific claims at the backend side it is always recommended to implement a custom JWT generator with mandatory claims you wish to consume at your backend.

# Passing Enduser Attributes to the Backend Using JWT

**JSON Web Token (JWT)** is used to represent claims that are transferred between two parties such as the end user and the backend.

A claim is an attribute of the user that is mapped to the underlying user store. It is encoded as a JavaScript Object Notation (JSON) object that is used as the payload of a JSON Web Signature (JWS) structure, or as the plain text of a JSON Web Encryption (JWE) structure. This enables claims to be digitally signed.

A set of claims is referred to as a dialect (e.g., `http://wso2.org/claims`). The general format of a JWT is `{token infor}.{claims list}.{signature}`. The API implementation uses information such as logging, content filtering and authentication/authorization that is stored in this token. The token is Base64-encoded and sent to the API implementation in a HTTP header variable. The JWT is self-contained and is divided into three parts as the header, the payload and the signature. For more information on JWT, see [JSON Web Token (JWT) Overview](http://openid.net/specs/draft-jones-json-web-token-07.html#anchor3).

The API Manager passes attributes of the API invoker to the backend API implementation using JWT to authenticate end users. In most production deployments, service calls go through WSO2 API Manager or a proxy service. If you enable JWT generation in WSO2 API Manager, each API request will carry a JWT to the back-end service. When the request goes through the API Manager, the JWT is appended as a transport header to the outgoing message. The back-end service fetches the JWT and retrieves the required information about the user, application, or token.

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

The above JWT access token contains the following information.

**JWT Header :** The header section declares that the encoded object is a JSON Web Token (JWT) and the JWT is in plain text, that is not signed using any encryption algorithm.

**JWT Claims set :**

-   "iss" - The issuer of the JWT
-   "exp" - The token expiration time
-   "http://wso2.org/claims/subscriber" - Subscriber to the API, usually the app developer
-   " http://wso2.org/claims/applicationname " - Application through which API invocation is done
-   " http://wso2.org/claims/apicontext " - Context of the API
-   " http://wso2.org/claims/version " - API version
-   " http://wso2.org/claims/tier " - Tier/price band for the subscription
-   " http://wso2.org/claims/enduser " - End-user of the app who's action invoked the API

Let's see how to enable and pass information in the JWT or completely alter the JWT generation logic in WSO2 API Manager:

## Configuring JWT

Before passing end-user attributes, you need to enable and configure the JWT implementation in the `<API-M_HOME>/repository/conf/deployment.toml` file. The relevant elements are described below. If you do not configure these elements, they take their default values.

!!! note
    Enable JWT in all Gateway and Key Manager nodes. For more information on setting up a distributed deployment of API Manager, see [Deploying WSO2 API-M in a Distributed Setup]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/deploying-wso2-api-m-in-a-distributed-setup).


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
<td><pre><code>apim.jwt.claims_extractor_impl</code></pre></td>
<td><div class="content-wrapper">
<p>By default, the <code>claims_extractor_impl</code> parameter is commented out in the <code>deployment.toml</code> file. Enable it to add all user claims in the JWT access token:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<code>claims_extractor_impl = "org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever"</code>
</div>
</div>
<p>By default, the following are encoded to the JWT:</p>
<ul>
<li>subscriber name</li>
<li>application name</li>
<li>API context</li>
<li>API version</li>
<li>authorized resource owner name</li>
</ul>
<p>In addition, you can also write your own class by extending the interface <code> org.wso2.carbon.apimgt.impl.token.ClaimsRetriever</code> and implementing the following methods of the interface:</p>
<div class="table-wrap">
<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Method</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>void init() throws APIManagementException;</code></p></td>
<td>Used to perform initialization tasks. Is executed once, right before the very first request.</td>
</tr>
<tr class="even">
<td><p><code>SortedMap&lt;String,String&gt; getClaims(String endUserName) throws APIManagementException;</code></p></td>
<td>Returns a sorted map of claims. The key of the map indicates the user attribute name and the value indicates the corresponding user attribute value. The order in which these keys and values are encoded depends on the ordering defined in the sorted map.</td>
</tr>
<tr class="odd">
<td><p><code>String getDialectURI(String endUserName);</code></p></td>
<td><p>The dialect URI to which the attribute names returned by the <code>getClaims()</code> method are appended. For example,<br />
if the <code>getClaims</code> method returns <code>{email:user1@wso2.com, gender:male}</code> and the <code>getDialectURI()</code> returns <code>http://wso2.org/claims</code>, the JWT will contain <code>&quot;http://wso2.org/claims/gender&quot;:&quot;male&quot;,&quot;http://wso2.org/claims/email&quot;:&quot;user1@wso2.com&quot;</code> as part of the body.</p>
<p>The default implementation (<code>org.wso2.carbon.apimgt.impl.token.DefaultClaimsRetriever</code>) returns the user's attributes defined under the dialect URI <code>                                         http://wso2.org/claims</code> and the JWT will also be encoded with the same dialect URI. The order of encoding the user's attributes is the natural order of the attributes. If no value is specified, no additional claims will be encoded, except the 6 default attributes.</p></td>
</tr>
</tbody>
</table>
</div>
</div></td>
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
<tr class="odd">
<td><pre><code>apim.jwt.signing_algorithm</code></pre></td>
<td><p>The signing algorithm used to sign the JWT. The general format of the JWT is <code>              {token infor}.{claims list}.{signature}</code>. When NONE is specified as the algorithm, signing is turned off and the JWT looks as <code>{token infor}.{claims list}</code> with two strings delimited by a period and a period at the end.</p>
<p>This element can have only two values - the default values are `SHA256withRSA` or `NONE`.</p></td>
<td>SHA256withRSA</td>
</tr>
</tbody>
</table>

!!! tip
    You can use TCPMon or API Gateway debug logs to capture the JWT access token header with end-user details. Follow the instructions below to enable the Gateway DEBUG logs for wire messages:

    1.  Go to the `<APIM_GATEWAY>/repository/conf` directory and open the `log4j2.properties` file with a text editor.
    2.  Add these two loggers to the list of loggers:<br/>
    <code>loggers = AUDIT_LOG, trace-messages,... <strong>, synapse-headers, synapse-wire</strong></code>


## Customizing the JWT generation

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

2.  [Build your class](https://dzone.com/articles/custom-jwt-generator-in-wso2-api-manager) and add the JAR file to the `<API-M_HOME>/repository/components/lib` directory.

3.  Add your class in the `apim.jwt.generator_impl` element of the `<API-M_HOME>/repository/conf/deployment.toml` file.

    ``` toml
    [apim.jwt]
    ...
    generator_impl = "org.wso2.carbon.test.CustomTokenGenerator"
    ```

4.  Set the `apim.jwt.enable` element to **true** in the `deployment.toml` file.

5.  Restart the server.

## Changing the JWT encoding to Base64URL encoding

The default JWT generator, `org.wso2.carbon.apimgt.impl.token.JWTGenerator`, encodes the value of the JWT using Base64 encoding. However, for certain apps you might need to have it in Base64URL encoding. 

Use the following format to encode the JWT using Base64URL encoding, by adding the `URLSafeJWTGenerator` class in the `apim.jwt.generator_impl` element, which is in the `<API-M_HOME>/repository/conf/deployment.toml` file.

``` toml
[apim.jwt]
...
generator_impl = "org.wso2.carbon.apimgt.keymgt.token.URLSafeJWTGenerator"
```

## Expiry time of the JWT

JWT expiry time depends directly on whether caching is enabled in the Gateway Manager or Key Manager. The WSO2 API-M Gateway caching is enabled by default. However, if required, you can enable or disable the caching for the Gateway Manager or the Key Manager using the `apim.cache.gateway_token.enable` or `apim.cache.km_token.enable` elements respectively in the `<API-M_HOME>/repository/conf/deployment.toml` file. If caching is enabled for the Gateway Manager or the Key Manager, the JWT expiry time will be the same as the default cache expiry time.

The claims that are retrieved for the JWT access token generation are cached. The expiry time of these JWT claims can be set by setting the **apim.cache.jwt_claim.expiry_time** in the `deployment.toml` file:

``` toml
[apim.cache.jwt_claim]
enable = true
expiry_time = "900"
```
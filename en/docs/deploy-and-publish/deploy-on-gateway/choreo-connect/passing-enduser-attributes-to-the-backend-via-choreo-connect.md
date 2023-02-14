# Passing End User Attributes to the Backend

{!./includes/deploy/backend-jwt-intro.md!}

## Enabling the default backend JWT generator

Before passing end user attributes, you need to enable and configure the JWT implementation, as mentioned below in Choreo Connect.

1. {!includes/deploy/cc-configuration-file.md!}

2. Enable and configure the backend JWT implementation.

     The following is the basic configuration that you need to have in place to enable backend JWT. For more information, on the other backend JWT configurations, see [JWT generation configuration details](#backend-jwt-generator-configuration-details).

    ```toml
    [enforcer.jwtGenerator]
       enabled = true
    ```

3. Start the server.
 
     For more information, see the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/).

## Enabling a customized backend JWT generator

{!./includes/deploy/backend-jwt-note.md!}

When generating the backend JWT, it retrieves the claims from the invoked JWT. If you need to change the way that JWT is generated in Choreo Connect, such as by adding additional claims or by completely changing the JWT, follow the instructions below to implement the customized Gateway JWT generation:

1. Write your own JWTGenerator class extending the `org.wso2.carbon.apimgt.common.gateway.jwtgenerator.AbstractAPIMgtGatewayJWTGenerator` class.

    !!! info
        Choreo Connect uses the [AbstractAPIMgtGatewayJWTGenerator](https://github.com/wso2/carbon-apimgt/blob/master/components/apimgt/org.wso2.carbon.apimgt.common.gateway/src/main/java/org/wso2/carbon/apimgt/common/gateway/jwtgenerator/AbstractAPIMgtGatewayJWTGenerator.java) class to support JWT generation within Choreo Connect.

    ```java
    package org.wso2.carbon.test;

    import org.osgi.service.component.annotations.Component;
    import org.wso2.carbon.apimgt.common.gateway.dto.JWTInfoDto;
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

2. Build your class and add the JAR file in the `<CHOREO-CONNECT_HOME>/resources/enforcer/dropins` directory.

    !!! note 
         If you use Choreo Connect with Helm Charts, please refer to the documentation in [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/production-deployment-guideline/#mount-files-into-the-dropins-directory-optional) to add a JAR file into the dropins directory.

   
4. Enable and configure the JWT implementation.

     - For more information, see [JWT generation configuration details](#backend-jwt-generator-configuration-details).

     - Set `enforcer.jwtGenerator.gatewayGeneratorImpl` to your customized class name.

        ```toml
        [enforcer.jwtGenerator]
           gatewayGeneratorImpl = "org.wso2.carbon.test.CustomGatewayJWTGenerator"
        ```

5. Start the server.

     For more information, see the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide-docker-with-apim/).
    
## Backend JWT generator configuration details

The following is a sample configuration.

```toml
[enforcer.jwtGenerator]
   enabled = true
   encoding = "base64" # base64,base64url
   claimDialect = "http://wso2.org/claims"
   convertDialect = false
   header = "X-JWT-Assertion"
   signingAlgorithm = "SHA256withRSA"
   enableUserClaims = false
   gatewayGeneratorImpl = "org.wso2.carbon.test.CustomGatewayJWTGenerator"
   claimsExtractorImpl = "org.wso2.carbon.apimgt.impl.token.ExtendedDefaultClaimsRetriever"
   publicCertificatePath = "/home/wso2/security/truststore/mg.pem"
   privateKeyPath = "/home/wso2/security/keystore/mg.key"
```

The relevant elements in the JWT generation configuration are described below. If you do not configure these elements, they take their default values.

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
<td><pre><code>enforcer.jwtGenerator.enable</code></pre></td>
<td>Uncomment this property and set this value to <strong><code>true</code></strong> to enable JWT.</td>
<td>false</td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.header</code></pre></td>
<td>The name of the HTTP header to which the JWT is attached.</td>
<td>X-JWT-Assertion</td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.claimDialect</code></pre></td>
<td><div class="content-wrapper">
<p>The JWT access token contains all claims that are defined in the <code>enforcer.jwtGenerator.claimDialect</code> element. The default value of this element is <code>http://wso2.org/claims</code>. To get the list of a specific user's claims that need to be included in the JWT, uncomment this element after enabling the JWT. It will include all claims in <code>http://wso2.org/claims</code> to the JWT access token.</p>
</div></td>
<td>http://wso2.org/claims</td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.convertDialect</code></pre></td>
<td>Remap the OIDC claims into the configured dialect.</td>
<td>false</td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.signingAlgorithm</code></pre></td>
<td><p>The signing algorithm is used to sign the JWT. The general format of the JWT is <code>              {token header}.{claims list}.{signature}</code>. When `NONE` is specified as the algorithm, signing is turned off and the JWT looks as <code>{token header}.{claims list}</code> with two strings delimited by a period and a period at the end.</p>
<p>This element can have only two values - the default values are <code>SHA256withRSA</code> or <code>NONE</code>.</p></td>
<td>SHA256withRSA</td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.enableUserClaims</code></pre></td>
<td><p>Enable/disable user claims in the token.</p></td>
<td><code>false</code></td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.gatewayGeneratorImpl</code></pre></td>
<td><p>Fully qualified custom JWT generator to used in JWT(Self Contained) Access Tokens.</p></td>
<td><code>org.wso2.carbon.apimgt.common.gateway.jwtgenerator.APIMgtGatewayJWTGeneratorImpl</code></td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.claimsExtractorImpl</code></pre></td>
<td><p>Fully qualified custom Claim Retriever to add custom claims into JWT.</p></td>
<td><code>org.wso2.carbon.apimgt.impl.token.ExtendedDefaultClaimsRetriever</code></td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.jwksRateLimitQuota</code></pre></td>
<td><p>How many requests to the JWKS endpoint can be served in the time window.</p></td>
<td><code>1000</code></td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.jwksRateLimitTimeWindow</code></pre></td>
<td><p>Time window for the rate limit to reset.</p></td>
<td><code>false</code></td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.jwksRateLimitQuota</code></pre></td>
<td><p>How many requests to the JWKS endpoint can be served in the time window</p></td>
<td><code>1000</code></td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.keypair</code></pre></td>
<td><p>An object containing the paths to public certificate and private key of an RSA keypair and specifying whether to use it for signing or not.</p></td>
<td><code>{
            privateKeyPath = "/home/wso2/security/keystore/mg.key"
            publicCertificatePath = "/home/wso2/security/truststore/mg.pem"
            useForSigning = true
}</code></td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.keypair.publicCertificatePath</code></pre></td>
<td><p>Path of the public certificate</p></td>
<td><code>/home/wso2/security/truststore/mg.pem</code></td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.keypair.privateKeyPath</code></pre></td>
<td><p>Path of the private key</p></td>
<td><code>/home/wso2/security/keystore/mg.key</code></td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.keypair.useForSigning</code></pre></td>
<td><p>Whether to use key for signing.</p></td>
<td><code>false</code></td>
</tr>
</tbody>
</table>

## JWKS endpoint for backend JWTs

Backend JWTs can be signed with RSA to ensure their validity when being sent between 2 parties. To verify the JWT on the backend we need the public certificate of the private key used to sign the JWT at the Gateway. The JWKS endpoint is a way to get this public certificate.

### Usage

The JWKS endpoint is:

``` java tab="Format"
"https://<hostname>:<port>/.wellknown/jwks"
```


``` java tab="Example"
"https://localhost:9095/.wellknown/jwks"
```

The public keys can be recieved from this endpoint with a <code>GET</code> or <code>POST</code> request.


### Sample JWKS response

```json
{
	"keys": [
		{
			"kty": "RSA",
			"e": "AQAB",
			"use": "sig",
			"kid": "ZjcwNmI2ZDJmNWQ0M2I5YzZiYzJmyNg",
			"alg": "RS256",
			"n": "8vjeHzRhvpfMystncPnLBWy_t5F3eCxbcLbdugWnzfnIgaV6TWnqPBUagJBKpzRZs4A9Qja_ZrSVJjYsbARzCS_qiWp0Cdwkqn6ZCXpmbpfjYnKORq8N8M-zWaSZYbNvWJ5oSO4kH-LKWzODaFebwTJBpsR1vChHH95doxFuUjiZaisVaQgUJ6drRdlDtImp9r9EAX36YROuYFPouD-dQ1sdJOa11P_yMs-glfQ"
		}
	]
}
```

## JWKS Parameters

<table>
<thead>
<tr class="header">
<th><b>Parameter</b></th>
<th><b>Description</b></th>
</tr>
<tbody>
<tr class="odd">
<td><pre><code>kty</code></pre></td>
<td>Key type identifies the cryptographic family this key belongs to.</td>
</tr>
<tr class="even">
<td><pre><code>e</code></pre></td>
<td>The exponent value of the public key.</td>
</tr>
<tr class="odd">
<td><pre><code>use</code></pre></td>
<td>This defines the use of the key, whether it is used for signing or encryption.</td>
</tr>
<tr class="even">
<td><pre><code>kid</code></pre></td>
<td>This is an ID parameter used to match a specific key(s).</td>
</tr>
<tr class="odd">
<td><pre><code>alg</code></pre></td>
<td>This defines the specific algorithm intended for use with the key.</td>
</tr>
<tr class="even">
<td><pre><code>n</code></pre></td>
<td>The modulus value of the public key.</td>
</tr>
<tr class="odd">
<td><pre><code>keys</code></pre></td>
<td>An array of the public keys available from the gateway.</td>
</tr>
</tbody>
</table>

## Code Example in Ballerina

```bal
import ballerina/http;
import ballerina/jwt;

service / on new http:Listener(8080) {

    resource function get hello(http:Request request) returns string|error {
        
        // JWT Validator config configured with the Issuer and the Signature config which points at the JWKS URL
        jwt:ValidatorConfig validatorConfig = {
        issuer: "wso2.org/products/am",
        clockSkew: 60,
        signatureConfig: {
            jwksConfig: {url: "https://gateway.e1-us-east-azure.preview-dv.choreoapis.dev/.wellknown/jwks", cacheConfig: {}}
        }
        };
        var jwt = request.getHeader("x-jwt-assertion");

        if !(jwt is string) {
            return error("JWT header not available");
            
        }
        // Validating the JWT based on its signature and expiration time
        jwt:Payload|jwt:Error result = check jwt:validate(jwt, validatorConfig);

        if result is jwt:Error {
            return error("Failed to authenticate " + result.message());
        }
        
        return result.toBalString();
    }
}
```

In this example we create a hello route on port 8080 and secure it with JWT. This hello function returns the JWT claims or the error that occurred during validation. 

## See Also

If you want to learn how you can pass end user attributes to the backend when working with the default API Gateway, see [Passing Enduser Attributes to the Backend]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway), which is under the API Gateway documentation section.

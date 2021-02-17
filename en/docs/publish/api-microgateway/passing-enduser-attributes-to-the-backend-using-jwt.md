# Passing Enduser Attributes to the Backend Using JWT 

JSON Web Token (JWT) is used to represent claims that are transferred between two parties, such as the end-user and the backend.

A claim is an attribute of the user that is mapped to the underlying user store. It is encoded as a JavaScript Object Notation (JSON) object that is used as the payload of a JSON Web Signature (JWS) structure or as the plain text of a JSON Web Encryption (JWE) structure. This enables claims to be digitally signed.

A set of claims is referred to as a dialect (e.g., http://wso2.org/claims). The general format of a JWT is {token infor}.{claims list}.{signature}. The API implementation uses information, such as logging, content filtering, and authentication/authorization that is stored in this token. The token is Base64-encoded and sent to the API implementation in an HTTP header variable. The JWT is self-contained and is divided into three parts as the header, the payload, and the signature.

If you enable JWT generation in WSO2 API Microgateway, each API request will carry a JWT to the back-end service. When the request goes through the API Microgateway, the JWT is appended as a transport header to the outgoing message. The back-end service fetches the JWT and retrieves the required information about the user, application, or token.

### Generating a JWT in Microgateway

Microgateway uses [AbstractAPIMgtGatewayJWTGenerator](https://github.com/wso2/carbon-apimgt/blob/master/components/apimgt/org.wso2.carbon.apimgt.common.gateway/src/main/java/org/wso2/carbon/apimgt/common/gateway/jwtgenerator/AbstractAPIMgtGatewayJWTGenerator.java) class to support jwt generation within Microgateway.

####Configuring JWT generation

Before passing end-user attributes, you need to enable and configure the JWT implementation in the <MG_HOME>/resources/conf/config.toml file. The relevant elements are described below. If you do not configure these elements, they take their default values.

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
<td><pre><code>enforcer.jwtGenerator.enable</code></pre></td>
<td>Uncomment this property and set this value to <strong><code>true</code></strong> to enable JWT.</td>
<td>false</td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.header</code></pre></td>
<td>The name of the HTTP header to which the JWT is attached.</td>
<td>X-JWT-Assertion</td>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.claimDialect</code></pre></td>
<td><div class="content-wrapper">
<p>The JWT access token contains all claims that are defined in the <code>enforcer.jwtGenerator.claimDialect</code> element. The default value of this element is <code>http://wso2.org/claims</code>. To get the list of a specific user's claims that need to be included in the JWT, simply uncomment this element after enabling the JWT. It will include all claims in <code>http://wso2.org/claims</code> to the JWT access token.</p>
</div></td>
<td>http://wso2.org/claims</td>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.signingAlgorithm</code></pre></td>
<td><p>The signing algorithm used to sign the JWT. The general format of the JWT is <code>              {token infor}.{claims list}.{signature}</code>. When NONE is specified as the algorithm, signing is turned off and the JWT looks as <code>{token infor}.{claims list}</code> with two strings delimited by a period and a period at the end.</p>
<p>This element can have only two values - the default values are `SHA256withRSA` or `NONE`.</p></td>
<td>SHA256withRSA</td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.gatewayGeneratorImpl</code></pre></td>
<td><p>Fully qualified custom JWT generator to used in JWT(Self Contained) Access Tokens</p></td>
<td>org.wso2.carbon.apimgt.common.gateway.jwtgenerator.APIMgtGatewayJWTGeneratorImpl</td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.publicCertificatePath</code></pre></td>
<td><p>Path of the public certificate</p></td>
<td>/home/wso2/security/truststore/mg.pem</td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.privateKeyPath</code></pre></td>
<td><p>Path of the private key</p></td>
<td>/home/wso2/security/keystore/mg.key</td>
</tr>
</tbody>
</table>

Following is a sample configuration.
```toml
[enforcer.jwtGenerator]
    enable = true
    encoding = "base64" # base64,base64url
    claimDialect = "http://wso2.org/claims"
    header = "X-JWT-Assertion"
    signingAlgorithm = "SHA256withRSA"
    enableUserClaims = false
    gatewayGeneratorImpl = "org.wso2.carbon.test.CustomGatewayJWTGenerator"
    publicCertificatePath = "/home/wso2/security/truststore/mg.pem"
    privateKeyPath = "/home/wso2/security/keystore/mg.key"
```
###Customizing the JWT generation

When generating the backend JWT, it retrieves the claims from the invoked JWT.
If you need to change the way that JWT is generated in the Microgateway, such as by adding additional claims or by completely changing the JWT, follow the instructions below to implement the Gateway JWT generation:
1. Write your own JWTGenerator class extending the `org.wso2.carbon.apimgt.common.gateway.jwtgenerator.AbstractAPIMgtGatewayJWTGenerator` class.
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

2. Build your class and the JAR file in the `<MG_HOME>/resources/enforcer/droppings` directory.


3. Set `enforcer.jwtGenerator.gatewayGeneratorImpl` to your class name in the `<MG_HOME>/resources/conf/config.toml` file.

    ```toml
    [enforcer.jwtGenerator]
    gatewayGeneratorImpl = "org.wso2.carbon.test.CustomGatewayJWTGenerator"
    ```


4. Start the server.

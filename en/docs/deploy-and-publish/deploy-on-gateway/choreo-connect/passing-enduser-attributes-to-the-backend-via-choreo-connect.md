# Passing End User Attributes to the Backend

{!./includes/deploy/backend-jwt-intro.md!}

## Enabling the default backend JWT generator

Before passing end user attributes, you need to enable and configure the JWT implementation, as mentioned below in Choreo Connect.

1. Navigate to the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf/config.toml` file.

2. Enable and configure the backend JWT implementation.

     The following is the basic configuration that you need to have in place to enable backend JWT. For more information, on the other backend JWT configurations, see [JWT generation configuration details](#jwt-generation-configuration-details).

    ```toml
    [enforcer.jwtGenerator]
        enable = true
    ```

3. Start the server.
 
     For more information, see the [Quick Start Guide]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-overview/).

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

2. Build your class and add the JAR file in the `<MG_HOME>/resources/enforcer/dropins` directory.

3. Enable and configure the JWT implementation.

     - For more information, see [JWT generation configuration details](#jwt-generation-configuration-details).

     - Set `enforcer.jwtGenerator.gatewayGeneratorImpl` to your customized class name.

        ```toml
        [enforcer.jwtGenerator]
        gatewayGeneratorImpl = "org.wso2.carbon.test.CustomGatewayJWTGenerator"
        ```

4. Start the server.

     For more information, see the [Quick Start Guide]({{base_path}}/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-overview/).
    
## Backend JWT generator configuration details

{!./includes/deploy/backend-jwt-gw-note.md!}

The following is a sample configuration.

```toml
[enforcer.jwtGenerator]
    enable = true
    encoding = "base64" # base64,base64url
    claimDialect = "http://wso2.org/claims"
    header = "X-JWT-Assertion"
    signingAlgorithm = "SHA256withRSA"
    gatewayGeneratorImpl = "org.wso2.carbon.test.CustomGatewayJWTGenerator"
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
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.claimDialect</code></pre></td>
<td><div class="content-wrapper">
<p>The JWT access token contains all claims that are defined in the <code>enforcer.jwtGenerator.claimDialect</code> element. The default value of this element is <code>http://wso2.org/claims</code>. To get the list of a specific user's claims that need to be included in the JWT, uncomment this element after enabling the JWT. It will include all claims in <code>http://wso2.org/claims</code> to the JWT access token.</p>
</div></td>
<td>http://wso2.org/claims</td>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.signingAlgorithm</code></pre></td>
<td><p>The signing algorithm is used to sign the JWT. The general format of the JWT is <code>              {token header}.{claims list}.{signature}</code>. When `NONE` is specified as the algorithm, signing is turned off and the JWT looks as <code>{token header}.{claims list}</code> with two strings delimited by a period and a period at the end.</p>
<p>This element can have only two values - the default values are <code>SHA256withRSA</code> or <code>NONE</code>.</p></td>
<td>SHA256withRSA</td>
</tr>
<tr class="odd">
<td><pre><code>enforcer.jwtGenerator.gatewayGeneratorImpl</code></pre></td>
<td><p>Fully qualified custom JWT generator to used in JWT(Self Contained) Access Tokens.</p></td>
<td><code>org.wso2.carbon.apimgt.common.gateway.jwtgenerator.APIMgtGatewayJWTGeneratorImpl</code></td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.publicCertificatePath</code></pre></td>
<td><p>Path of the public certificate</p></td>
<td><code>/home/wso2/security/truststore/mg.pem</code></td>
</tr>
<tr class="even">
<td><pre><code>enforcer.jwtGenerator.privateKeyPath</code></pre></td>
<td><p>Path of the private key</p></td>
<td><code>/home/wso2/security/keystore/mg.key</code></td>
</tr>
</tbody>
</table>

## See Also

If you want to learn how you can pass end user attributes to the backend when working with the default API Gateway, see [Passing Enduser Attributes to the Backend]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/passing-enduser-attributes-to-the-backend-via-api-gateway), which is under the API Gateway documentation section.

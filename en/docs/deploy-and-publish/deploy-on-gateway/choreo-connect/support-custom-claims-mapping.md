# Custom Claims Mapping

Choreo Connect provides the capability to map any claims in an incoming authentication JWT token, to claims expected by the backend upstream service using the custom claim mapping feature.

When JWT tokens are retrieved from multiple identity providers, Choreo Connect can map the relevant claims to the supported claims in order to validate the JWT. The claims of the incoming authentication JWT can differ based on the Authorization server that issued the JWT token. This feature maps the incoming JWT remote claims to the local claims of the Choreo Connect, and the transformed local claims will be sent to the back-end service as well. You can use custom claim mapping transformation in Choreo Connect when you have different keys or values of claims in your JWT token to make it compatible with Choreo Connect as well as your back-end service.

## Example

Let's assume that you generated a JWT token with the claim `"scp": [“write”, “read”]` to represent the scope of the token. Choreo Connect only validates scopes when they are available in the token with the claim key `scope` and when the scopes are separated by spaces as a string. Therefore, you need to use a custom claim mapping to transform the remote claim to a local claim. In this scenario, you can do either one of the following actions:

- [Change the claim key](#configuring-claim-keys) by only using the configuration.
- [Change the claim values](#configuring-claim-values) using a custom JWT transformer. 

## Configuring claim keys

The following instructions are based on the [above example](#example). Let's change the key `scp` in the remote claim to the key `scope`.

If the key of the remote claim is different from the custom claim, you can configure claim mapping as follows:

1. Navigate to the `<CHOREO-CONNECT_HOME>/docker-compose/<choreo-connect-with-apim OR choreo-connect>/conf/config.toml` file.

2. Add the following configuration under the `enforcer.jwtTokenConfig` tag.

     You need to add the claim mapping configurations under the respective JWT issuer that the claim mapping should be applied to. You can define multiple keys of the remote claims and local claims.

    ```toml
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
        [[enforcer.security.tokenService.claimMapping]]
            remoteClaim = "scp"
            localClaim = "scope"
    ```

## Configuring claim values

The following instructions are based on the [above example](#example). Let's change the `scope` claim value to a space separated string from an array.

If the format of the remote claim value differs from the required format, you can use a custom JWT transformer to transform the claims as mentioned in the following instructions:

### Step 1 - Write a JWT claim value transformer

Choreo Connect uses the `org.wso2.carbon.apimgt.common.gateway.jwttransformer.JWTTransformer` Java interface when writing a custom JWT value transformer. Developers can use the following interface to write a custom JWT transformer to achieve custom transformation logic. The following JWT transformer will append the `CustomClaim:` string to the local claim key.

```` java
package org.wso2.carbon.apimgt.common.gateway.jwttransformer;

import com.nimbusds.jwt.JWTClaimsSet;
import org.wso2.carbon.apimgt.common.gateway.dto.TokenIssuerDto;
import org.wso2.carbon.apimgt.common.gateway.exception.JWTGeneratorException;

import java.util.List;

/**
 * This Class will be used to transform JWT claims to local claims
 */
public interface JWTTransformer {

    /**
     * This method used to retrieve ConsumerKey From JWT
     * @param jwtClaimsSet retrieved JwtClaimSet
     * @return consumerKey of JWT
     */
    public String getTransformedConsumerKey(JWTClaimsSet jwtClaimsSet) throws JWTGeneratorException;

    /**
     * This method used to retrieve Scopes From JWT
     * @param jwtClaimsSet retrieved JwtClaimSet
     * @return scopes of JWT
     */
    public List<String> getTransformedScopes(JWTClaimsSet jwtClaimsSet) throws JWTGeneratorException;


    /**
     * This method used to transform JWT claimset from given JWT into required format
     *
     * @param jwtClaimsSet jwtClaimSet from given JWT
     * @return transformed JWT Claims.
     */
    public JWTClaimsSet transform(JWTClaimsSet jwtClaimsSet) throws JWTGeneratorException;

    /**
     * This method returns issuer name which used the implementation to transform JWT.
     *
     * @return issuer url.
     */
    public String getIssuer();

    public void loadConfiguration(TokenIssuerDto tokenIssuerConfiguration);

    /**
     * This method used to retrieve whether authorized user type of the JWT token is Application or not. The default
     * implementation returns null.
     *
     * @param jwtClaimsSet jwtClaimSet from given JWT
     * @return transformed JWT Claims
     * @throws JWTGeneratorException if an error occurs while retrieving whether token type is Application
     */
    default Boolean getTransformedIsAppTokenType(JWTClaimsSet jwtClaimsSet) throws JWTGeneratorException {

        return false;
    }
}
````

The following `CustomJwtTransformer` class is the implementation of the JWT transformer interface.

``` java
package org.wso2.caron.test;

import com.nimbusds.jwt.JWTClaimsSet;
import org.apache.commons.lang3.StringUtils;
import org.wso2.carbon.apimgt.common.gateway.jwttransformer.JWTTransformer;
import org.wso2.carbon.apimgt.common.gateway.exception.JWTGeneratorException;
import org.wso2.carbon.apimgt.common.gateway.dto.TokenIssuerDto;
import org.wso2.carbon.apimgt.common.gateway.dto.ClaimMappingDto;
import org.wso2.micro.gateway.enforcer.security.jwt.JwtTransformerAnnotation;

import java.text.ParseException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@JwtTransformerAnnotation(
        // make enable true to enable the custom claim mapping class for the issuer.
        enabled = true,
        // Name of the class.
        name = "CustomJWTTransformer",
         // Specify the issuer
        issuer = "https://localhost:9443/oauth2/token"
)
public class CustomJWTTransformer implements JWTTransformer {

    protected TokenIssuerDto tokenIssuer = null;

    @Override
    public String getTransformedConsumerKey(JWTClaimsSet jwtClaimsSet) throws JWTGeneratorException {

        try {
            if (tokenIssuer.getConsumerKeyClaim() == null) {
                if (jwtClaimsSet.getClaim("consumerKey") != null) {
                    return jwtClaimsSet.getStringClaim("consumerKey");
                } else if (jwtClaimsSet.getClaim("azp") != null) {
                    return jwtClaimsSet.getStringClaim("azp");
                }
            } else {
                if (jwtClaimsSet.getClaim(tokenIssuer.getConsumerKeyClaim()) != null) {
                    return jwtClaimsSet.getStringClaim(tokenIssuer.getConsumerKeyClaim());
                }
            }
        } catch (ParseException e) {
            throw new JWTGeneratorException("Error while parsing JWT claims", e);
        }

        return null;
    }

    @Override
    public List<String> getTransformedScopes(JWTClaimsSet jwtClaimsSet) throws JWTGeneratorException {

        try {
            String scopeClaim = "scope";
            if (StringUtils.isNotEmpty(tokenIssuer.getScopesClaim())) {
                scopeClaim = tokenIssuer.getScopesClaim();
            }
            if (jwtClaimsSet.getClaim(scopeClaim) instanceof String) {
                return Arrays.asList(jwtClaimsSet.getStringClaim(scopeClaim)
                        .split(" "));
            } else if (jwtClaimsSet.getClaim(scopeClaim) instanceof List) {
                return jwtClaimsSet.getStringListClaim(scopeClaim);
            }
        } catch (ParseException e) {
            throw new JWTGeneratorException("Error while parsing JWT claims", e);
        }
        return Arrays.asList("default");
    }

    @Override
    public JWTClaimsSet transform(JWTClaimsSet jwtClaimsSet) {

        JWTClaimsSet.Builder transformedJWT = new JWTClaimsSet.Builder();
        if (tokenIssuer != null) {
            Map<String, ClaimMappingDto> claimConfigurations = tokenIssuer.getClaimConfigurations();
            for (Map.Entry<String, Object> claimEntry : jwtClaimsSet.getClaims().entrySet()) {
                ClaimMappingDto claimMappingDto = claimConfigurations.get(claimEntry.getKey());
                String claimKey = claimEntry.getKey();
                if (claimMappingDto != null) {
                    claimKey = claimMappingDto.getLocalClaim();
                    claimKey = "CustomClaim: " + claimKey;
                }
                transformedJWT.claim(claimKey, claimEntry.getValue());
            }
            return transformedJWT.build();
        }
        return jwtClaimsSet;
    }

    @Override
    public String getIssuer() {

        return "";
    }

    @Override
    public void loadConfiguration(TokenIssuerDto tokenIssuerConfiguration) {

        this.tokenIssuer = tokenIssuerConfiguration;
    }

    /**
     * Returns whether the token type is Application or not by checking if 'aut' claim is APPLICATION or not. If 'aut'
     * claim is not present, returns null.
     *
     * @param jwtClaimsSet JWT Claim set
     * @return Boolean whether Application token type or not
     */
    @Override
    public Boolean getTransformedIsAppTokenType(JWTClaimsSet jwtClaimsSet) throws JWTGeneratorException {

        try {
            if (jwtClaimsSet.getClaim("aut") != null) {
                String aut = jwtClaimsSet.getStringClaim("aut");
                return StringUtils.equalsIgnoreCase(aut, "application");
            }
        } catch (ParseException e) {
            throw new JWTGeneratorException("Error while parsing JWT claims", e);
        }
        return false;
    }
}

```

!!! info
    Add the `org.wso2.carbon.apimgt` dependency. The Java JWT transformer project will require the following dependency.

```xml
<dependency>
    <groupId>org.wso2.carbon.apimgt</groupId>
    <artifactId>org.wso2.carbon.apimgt.common.gateway</artifactId>
    <version>9.0.0</version>
</dependency>
```    
        
### Step 2 - Add a JWT transformer to the project 

1. Build the JWT transformer project after the JWT claim value transformer is written.

2. Add the output JAR in the `<CHOREO-CONNECT_HOME>/docker-compose/resources/enforcer/dropins` directory. 

     If any third-party libraries are used when writing the JWT claim value transformer, these custom JARs too should also be placed in the same directory.

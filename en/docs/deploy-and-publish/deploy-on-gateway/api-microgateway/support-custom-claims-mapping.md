# Support Custom Claims Mapping

Microgateway provides the capability to map any claims in an incoming authentication JWT token to, claims expected by the backend upstream service using the custom claim mapping feature.

When JWT tokens are retrieved from multiple identity providers, Microgateway can map the relevant claims to supported claims in order to validate the JWT. The claims of the incoming authentication JWT can differ based on the Authorization server that issued the JWT token. This feature maps the incoming JWT remote claims to the local claims of the Microgateway, and the transformed local claims will be sent to the back-end service as well. You can use custom claims mapping transformation in Microgateway when you have different keys or values of claims in your JWT token to make it compatible with microgateway as well as your back-end service.

For example, if you generate a JWT token with the claim `"scp": [“write”, “read”]` to represent the scope of the token, since Microgateway validates scopes only when they are available in the token with the claim key 'scope' and when the scopes are separated by spaces as a string. Therefore, a custom claim mapping can be used to transform the remote claim to a local claim.

You can either change the claim key only using the configuration or change the claim values using a custom JWT transformer. 

### Configuring claim keys

If the key of the remote claim is different from the custom claim, you can add the following configuration under `enforcer.jwtTokenConfig` tag (claim mapping configurations should be added under the respective JWT issuer that the claim mapping should be applied) in `config.toml` file which is located in the `<MG_HOME>/resources/conf` directory. (You can define multiple keys of the remote claims and local claims.)

The following configuration is to change the key 'scp' in the remote claim to the key 'scope'.

```toml
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
    [[enforcer.jwtTokenConfig.claimMapping]]
        remoteClaim = "scp"
        localClaim = "scope"
```
         

### Configuring claim values using a custom JWT transformer

If the format of the remote claim value differs from the required format, you can write a class to transform the claim value into the correct format of your desire and put the built `.jar` file to the `MG_HOME/resources/enforcer/dropins` folder location.

The following subsections explain how you can work with claim value transformation. The following example is based on changing the 'scope' claim value to a space separated string from an array.

#### Writing a JWT claim value transformer

Microgateway uses `org.wso2.carbon.apimgt.common.gateway.jwttransformer.JWTTransformer` java interface  when writing a custom JWT value transformer. Developers can use the following interface to write a custom JWT transformer to achieve custom transformation logic. The following jwt transformer will append `CustomClaim:` string to the loacl claim key.

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

Following `CustomJwtTransformer` class is the implementation of the JWT transformer interface.

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
    Add the `org.wso2.carbon.apimgt` dependency. The java JWT transformer project will require the following dependency
```xml
    <dependency>
        <groupId>org.wso2.carbon.apimgt</groupId>
        <artifactId>org.wso2.carbon.apimgt.common.gateway</artifactId>
        <version>9.0.0</version>
    </dependency>
```    
        
#### Adding JWT transformer to the project 

Once the JWT claim value transformer is written, then the JWT transformer project should be built and the output jar should be placed in the `MG_HOME/resources/enforcer/dropins` directory. If any third-party libraries are used when writing the JWT claim value transformer, these custom jars should also be placed in the same directory.



# Support Custom Claims Mapping

Microgateway provides the capability to map any claims in an incoming authentication JWT token to, claims expected by the backend upstream service using the custom claim mapping feature.

When JWT tokens are retrieved from multiple identity providers, Microgateway can map the relevant claims to supported claims in order to validate the JWT. The claims of the incoming authentication JWT can differ based on the Authorization server that issued the JWT token. This feature maps the incoming JWT remote claims to the local claims of the Microgateway, and the transformed local claims will be sent to the back-end service as well. You can use custom claims mapping transformation in Microgateway when you have different keys or values of claims in your JWT token to make it compatible with microgateway as well as your back-end service.

For example, if you generate a JWT token with the claim `"scp": [“write”, “read”]` to represent the scope of the token, since Microgateway validates scopes only when they are available in the token with the claim key 'scope' and when the scopes are separated by spaces as a string. Therefore, a custom claim mapping can be used to transform the remote claim to a local claim.

You can either change the claim key only using the configuration or change the claim values using a custom JWT transformer. 

### Configuring claim keys

If the key of the remote claim is different from the custom claim, you can add the following configuration under `jwtTokenConfig` tag (claim mapping configurations should be added under the respective JWT issuer that the claim mapping should be applied) in `micro-gw.conf` file which is located in the `<MGW-RUNTIME-HOME>/conf` directory. (You can define multiple keys of the remote claims and local claims.)

The following configuration is to change the key 'scp' in the remote claim to the key 'scope'.

```toml
[[jwtTokenConfig]]
     issuer = "https://localhost:9443/oauth2/token"
     audience = "http://org.wso2.apimgt/gateway"
     certificateAlias = "wso2apim310"
     #support custom claim mapping
     claimMapperClassName = "org.wso2.micro.gateway.jwtTransformer.DefaultJwtTransformer"
     [[jwtTokenConfig.claims]]
       remoteClaim = "scp"
       localClaim = "scope" 
```
         

### Configuring claim values using a custom JWT transformer

If the format of the remote claim value differs from the required format, you can write a class to transform the claim value into the correct format of your desire and add the claim mapping class name in the config file.

The following subsections explain how you can work with claim value transformation. The following example is based on changing the 'scope' claim value to a space separated string from an array.

#### Writing a JWT claim value transformer

Microgateway provides a java interface to implement when writing a JWT value transformer. Developers can use the following interface to write a custom JWT transformer to achieve custom transformation logic. 

```` java
package org.wso2.micro.gateway.jwt.transformer;
 
import java.util.Map;
 
/**
 * Defines the interface for writing the  jwt tranformation.
 */
public interface JWTValueTransformer {
 
    /**
     *  Transform the custom claims  into required format.
     * @param jwtClaims jwtClaims from given JWT
     * @return transformed JWT Claims
     */
    Map<String, Object> transformJWT(Map<String, Object> jwtClaims);
}
````

Following `CustomJwtTransformer` class is the implementation of the JWT transformer interface.

``` java
package org.mgw.jwt.jwtvaluetransformer;
 
import org.wso2.micro.gateway.jwt.transformer.JWTValueTransformer;
 
import java.util.Map;
 
/**
 * This class is for default Jwt transformer.
 */
public class CustomJwtTransformer implements JWTValueTransformer {
 
    @Override
    public Map<String, Object> transformJWT(Map<String, Object> jwtClaims) {
        String scope = "";
        if (jwtClaims.containsKey("scope")) {
            if (jwtClaims.get("scope") instanceof Object[]) {
                for (int i = 0; i < ((Object[]) jwtClaims.get("scope")).length; i++) {
                    scope += ((Object[]) jwtClaims.get("scope"))[i] + " ";
                }
                scope = scope.trim();
            }
            jwtClaims.put("scope", scope);
        }
        return jwtClaims;
    }
}
```

!!! info
    Add the microgateway JWT transformer dependency.
    The java JWT transformer project will require the following dependency.
    ```xml
        <dependency>
            <groupId>org.wso2.am.microgw</groupId>
            <artifactId>mgw-jwt-transformer</artifactId>
            <version>3.2.0</version>
        </dependency>
    ```
        
#### Adding JWT transformer to the project 

Once the JWT claim value transformer is written, then the JWT transformer project should be built and the output jar should be placed in the `<MGW-project>/lib` directory. If any third-party libraries are used when writing the JWT claim value transformer, these custom jars should also be placed in the same directory.

#### Configuring claims Mapper class Name

```toml
[[jwtTokenConfig]]
  issuer = "https://host:port/issuer"
  audience = "http://org.wso2.apimgt/gateway"
  certificateAlias = "alias"
  #class name of JWT claim value mapper transformer.
  claimMapperClassName = "org.mgw.jwt.jwtvaluetransformer.customJwtTransformer"
```


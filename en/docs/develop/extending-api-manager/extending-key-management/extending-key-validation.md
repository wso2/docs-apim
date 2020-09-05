# Extending Key Validation

In WSO2 API Manager (WSO2 API-M) versions prior to 3.2.0, the key manager was loosely coupled with other components and could [plug different OAuth2 providers](https://docs.wso2.com/display/AM260/Configuring+a+Third-Party+Key+Manager) for the key validation. However, since API-M 3.2.0 further improving this functionality it has removed the key manager call altogether for key validation at runtime by making the default token type to JWT(JSON Web Token). JWT Token validation happens at the gateway itself and the subsequent subscription validation also happens in the gateway as required meta information is available in the gateway memory. 

When you call an API providing an access token, the execution flows through the handlers specified in the API. Among them, the API authentication handler extracts the token from the header and determines whether the token is a JWT. If so it validates through  `JWTValidator`. 


### Extending JWTValidator Interface


When you need to write your own JWT Validation logic , you should implement org.wso2.carbon.apimgt.impl.jwt.JWTValidator Interface


The following are the methods that the `JWTValidator` interface uses to carry out operations.

<table>
<colgroup>
<col width="30%" />
<col width="70%" />
</colgroup>
<thead>
<tr class="header">
<th>Method</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>validateToken</strong></td>
<td><p>Provide the way to validate JWT token in Self mode.</p></td>
</tr>
<tr class="even">
<td><strong>loadTokenIssuerConfiguration</strong></td>
<td><p>Provide the way to load JWT related configurations.</p></td>
</tr>
</tbody>
</table>

You can implement this JWTValidator inside a custom the key manager connector.
You may refer [writing custom key manager connector]({{base_path}}/administer/key-managers/configure-custom-connector).
Once you implement the JWTValidator interface the eimplementation class can be instantiated using the KeyManagerConnectorConfiguration Interface.

```java
    @Override
    public String getJWTValidator() {

        // If you need to implement a custom JWT validation logic you need to implement
        // org.wso2.carbon.apimgt.impl.jwt.JWTValidator interface and instantiate it in here.
        return null;
    }

```

### Extending KeyValidationHandler Interface

If you still using reference tokens and need to extend the key validation according to the way that was presented prior to 3.2.0, you can do it by implementing the `org.wso2.carbon.apimgt.keymgt.handlers.KeyValidationHandler` 

Upon validating the token, the API Gateway receives `APIKeyValidationInforDTO` as the response, using which the rest of the operations are performed.

The `KeyValidationHandler` has four main operations that are executed in the following order:

-   **validateToken** - Validates the token. The existing implementation should work for most cases.
-   **validateSubscription** - Skips/changes the domain validation.
-   **validateScopes** - Relaxes/reduces scope restrictions.
-   **GenerateConsumerToken** - Creates different types of tokens.

The default implementation of the `KeyValidationService` is written in a way where you are able to complete the entire key validation flow only by extending the `getTokenMetaData()` method in the `KeyManagerInterface` .

However, there are situations where you need to customize the default key validation flow according to different requirements. In such situations, WSO2 API-M provides the facility to extend the `KeyValidationHandler` and its methods.

A few examples are listed below.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Requirement</th>
<th>Extension</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>You need to skip trivial steps, because its validation does not add value.</td>
<td><p>When creating a key via the API Devportal, the subscriber can specify which domains are allowed to make calls using a token granted against a particular consumer key. If this validation does not add any value, these trivial steps can be ignored and skipped by extending the <strong><code>               KeyValidationHandler              </code></strong> .</p>
!!! info
<p>For another example scenario, see <a href="_Extending_Scope_Validation_">Skipping Role Validation for Scopes</a> .</p>
</td>
</tr>
<tr class="even">
<td>You need to avoid going into detail when validating scopes</td>
<td><p>Consider a situation where a scope is assigned to a resource and you only need to verify if the token that is used to access the API has at least one or more scopes defined for that API without going into much detail. This requirement can be achieved by extending the <strong><code>               validateScope()              </code></strong> method.</p></td>
</tr>
<tr class="odd">
<td>You need to send a different type of token instead of JSON Web Token (JWT) to pass details of API invocation to the backend</td>
<td>A JSON Web Token (JWT) is used to pass details of an API invocation to the backend. If a different type of token is required, you can extend the <strong><code>              generateConsumerToken()             </code></strong> method to achieve this purpose.</td>
</tr>
</tbody>
</table>



# Extending the Key Validation Interface

Previously, in WSO2 API Manager (WSO2 API-M) the Key Manager was loosely coupled with other components and the users could [plug in different OAuth2 providers]({{base_path}}/install-and-setup/setup/distributed-deployment/configure-a-third-party-key-manager/) for the purpose of key validation. However, now, the Key Manager call that was used in the key validation process at runtime has been removed altogether and the default token type has been set to JWT (JSON Web Token). Now, the JWT Token validation takes place at the Gateway itself and the subsequent subscription validation also takes place in the Gateway as the required meta-information is available in the Gateway memory. 

When you call an API providing an access token, the execution flows through the handlers specified in the API. The API authentication handler extracts the token from the header and determines whether the token is a JWT. If the token is a JWT, it validates it via the `JWTValidator` interface. 

## Extending the JWTValidator Interface

When you need to write your own JWT Validation logic, you should implement the `org.wso2.carbon.apimgt.impl.jwt.JWTValidator` interface.

The following are the methods that the `JWTValidator` interface uses to carry out operations.

<table>
<colgroup>
<col width="30%" />
<col width="70%" />
</colgroup>
<thead>
<tr class="header">
<th><b>Method</b></th>
<th><b>Description</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>validateToken</strong></td>
<td><p>Validates the JWT token in self mode.</p></td>
</tr>
<tr class="even">
<td><strong>loadTokenIssuerConfiguration</strong></td>
<td><p>Loads the JWT related configurations.</p></td>
</tr>
</tbody>
</table>

You can implement the `JWTValidator` interface inside a custom Key Manager connector. For more information, see [writing a custom key manager connector]({{base_path}}/administer/key-managers/configure-custom-connector).

After you implement the `JWTValidator` interface the implementation class can be instantiated using the `KeyManagerConnectorConfiguration`interface.

```java
@Override
public String getJWTValidator() {

     // If you need to implement a custom JWT validation logic you need to implement
     // org.wso2.carbon.apimgt.impl.jwt.JWTValidator interface and instantiate it in here.
     return null;
}
```

## Extending the KeyValidationHandler Interface

If you are still using reference tokens and you need to extend the key validation similar to the way it was implemented before API-M 3.2.0, you can do so by implementing `org.wso2.carbon.apimgt.keymgt.handlers.KeyValidationHandler`.

After validating the token, the API Gateway receives the `APIKeyValidationInforDTO` as the response, and the API Gateway uses it to perform the rest of the operations.

The `KeyValidationHandler` has four main operations that are executed in the following order:

-   **validateToken** - Validates the token. The existing implementation should work for most cases.
-   **validateSubscription** - Skips/changes the domain validation.
-   **validateScopes** - Relaxes/reduces scope restrictions.
-   **GenerateConsumerToken** - Creates different types of tokens.

The default implementation of the `KeyValidationService` is written in a way where you can complete the entire key validation flow only by extending the `getTokenMetaData()` method in the `KeyManagerInterface`.

However, there are situations where you need to customize the default key validation flow according to different requirements. In such situations, WSO2 API-M provides the facility to extend the `KeyValidationHandler` and its methods.

A few examples are listed below.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th><b>Requirement</b></th>
<th><b>Extension</b></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>You need to skip trivial steps because the validation does not add value.</td>
<td>When creating a key via the API Developer Portal, the subscriber can specify which domains are allowed to make calls using a token granted against a particular consumer key. If this validation does not add any value, these trivial steps can be ignored and skipped by extending the <code>KeyValidationHandler</code>.
<div class="admonition info">
<p class="admonition-title">Info</p>
<p>For another example scenario, see <a href="{{base_path}}/develop/extending-api-manager/extending-key-management/extending-scope-validation/">Skipping Role Validation for Scopes</a>.</p>
</div>
</td>
</tr>
<tr class="even">
<td>You need to avoid going into detail when validating scopes</td>
<td><p>Consider a situation where a scope is assigned to a resource and you only need to verify if the token that is used to access the API has at least one or more scopes defined for that API without going into much detail. This requirement can be achieved by extending the <code>validateScope()</code> method.</p></td>
</tr>
<tr class="odd">
<td>You need to send a different type of token instead of JSON Web Token (JWT) to pass details of the API invocation to the backend</td>
<td>A JSON Web Token (JWT) is used to pass details of the API invocation to the backend. If a different type of token is required, you can extend the <code>generateConsumerToken()</code> method to achieve this purpose.</td>
</tr>
</tbody>
</table>

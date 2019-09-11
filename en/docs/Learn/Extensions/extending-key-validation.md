# Extending Key Validation

In WSO2 API Manager (WSO2 API-M) versions prior to 1.9.0, the components were tightly coupled with the [Key Manager](https://docs.wso2.com/display/AM200/Key+Concepts#KeyConcepts-KeyManager) and token validation was done by directly accessing the databases. However, from WSO2 API-M 1.9.0 onwards, you can [plug different OAuth2 providers](https://docs.wso2.com/display/AM260/Configuring+a+Third-Party+Key+Manager) to the key validation. When you call an API providing an access token, the execution flows through the handlers specified in the API. Among them, the API authentication handler extracts the token from the header and calls `APIKeyValidationService` to get the token validated. Upon validating the token, the API Gateway receives `APIKeyValidationInforDTO` as the response, using which the rest of the operations are performed.

Before decoupling was done, the entire key validation process was executed inside a single method named `validateKey()` , which performed all the operations by running a single query. After decoupling, that single query was broken down into smaller parts by introducing `KeyValidationHandler` , which runs inside the `validateKey()` operation, providing a way to extend each step.

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
<td><p>When creating a key via the API Store, the subscriber can specify which domains are allowed to make calls using a token granted against a particular consumer key. If this validation does not add any value, these trivial steps can be ignored and skipped by extending the <strong><code>               KeyValidationHandler              </code></strong> .</p>
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



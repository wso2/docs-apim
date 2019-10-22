# JWT Authentication

JSON Web Token (JWT) is an open standard of transmitting information securely between two parties. The integrity of information is secured since the tokens are digitally signed. JWT tokens can be used for authentication and authorization purposes. The ability of tokens to carry claims (data) required for the authentication and authorization of a request makes it a suitable candidate to be used as an API credential.

With version 3.0 of the WSO2 API Manager, it now supports the use of self-contained and signed JWT formatted OAuth2.0 access tokens as API credentials. JWT formatted OAuth2.0 access tokens can be used to authenticate to any API that is secured by the OAuth2 security scheme. The respective application governs the type of token being issued to it by the API Manager. The application representation on the developer portal (API Store) has an attribute that allows the app developer to control the type of token being issued to it. This is known as the 'Token Type'. The allowed values are 'JWT' and 'OAuth2.0'. When the token type is set to 'JWT' API Manager will issue self-contained, signed JWT formatted access tokens to the application.

When an API is invoked using a JWT token the API gateway validates the request by itself. In the case of regular opaque access tokens, the API gateway communicates with the key manager (in a distributed deployment) to validate the token.\
The following requirements must be satisfied for JWT based tokens to work.

-   Only signed JWT tokens are allowed

-   The expected token format is : base64(header).base64(payload).base64(signature) 

-   The public certificate of the private key that is used to sign the tokens should be added to the trust store under the alias '"gateway_certificate_alias"'. If default certs (ones that are shipped with the product itself) are being used this step is not necessary.

-   To import the public certificate into the client trust store

-   Go to <API-M_HOME>/repository/resources/security/ directory

-   Run this command to export public certificate from API Manager's Key store (wso2carbon.jks) 

-   keytool -export -alias wso2carbon -file wso2.crt -keystore wso2carbon.jks

-   Use wso2carbon as the default password of the key store when prompted

-   Run this command to import the public certificate into the trust store 

-   keytool -import -trustcacerts -keystore client-truststore.jks -alias gateway_certificate_alias -file wso2.crt

-   Use wso2carbon as the default password of the trust store when prompted

### Mandatory attributes of a JWT token

-   Header

-   typ - the type of the token (as 'JWT') 

-   alg - the algorithm used to sign the token (e.g.- RS256)

-   Payload

-   sub - Subject (whom the token refers to)

-   application - application for which the token is generated

-   consumerKey

-   iat - token issued time

-   exp - token expiry time

### Validation of API subscriptions.

The subscription validation applies only if the JWT payload contains attribute 'subscribedAPIs'. The default Key Manager in API Manager ensures that this property is added to all tokens it issues even if the relevant applications have no APIs subscribed to it (it will be an empty array in that case). Tokens generated before an application subscribed to an API will not contain that API under its subscription details. These tokens will not be allowed to access the specific API. JWT tokens should therefore be generated after the application has subscribed to the required API.

Setup
=====

The following sections explain how to work with JWT Authentication on the WSO2 API Manager.

### Generating a JWT token

Create an application of token type "JWT" and generate a token optionally providing the scope and expiration time.

<ADD SCREENSHOT OF TOKEN GENERATION>

### Invoking an API using a JWT token

Invoking an API with a JWT formatted access token is done just as invoking the API with a regular opaque access token. Use the cURL command below to invoke the API via the gateway.

Format

`
curl -k -X GET  "<API_URL>" -H "accept: application/json" -H "Authorization: Bearer <JWT_TOKEN>"
`

Example

```
curl -k -X GET  "https://localhost:9095/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
```
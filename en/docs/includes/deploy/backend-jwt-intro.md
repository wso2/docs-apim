
There can be scenarios where a backend service needs to make different decisions or respond with different data, depending on the application end-user that consumes an API. To achieve this the backend service needs to have access to the respective end-user's data at the time an API call takes place.

This can be facilitated by the Gateway by sending the end user attributes that are defined in the respective user store, in a JWT via an HTTP header, to the backend service when the API call is being forwarded.

## How does it work?

The backend JSON Web Token (JWT) contains the claims that are transferred between two parties, such as the end-user and the backend. A claim is an attribute of the user that is mapped to the underlying user store. A set of claims is referred to as a dialect (e.g., http://wso2.org/claims).

If you enable backend JWT generation in the Gateway, each API request will carry a digitally signed JWT, which is in the following format to the backend service.
 
`{token header}.{claims list}.{signature}`

When the request goes through the Gateway, the backend JWT is appended as a transport header to the outgoing message. The backend service fetches the JWT and retrieves the required information about the user, application, or token.

## Sample JWT

The following is an example of a JWT:

``` java
{
    "typ":"JWT",
    "alg":"NONE"
    }{
    "iss":"wso2.org/products/am",
    "exp":1345183492181,
    "http://wso2.org/claims/subscriber":"admin",
    "http://wso2.org/claims/applicationname":"app2",
    "http://wso2.org/claims/apicontext":"/placeFinder",
    "http://wso2.org/claims/version":"1.0.0",
    "http://wso2.org/claims/tier":"Silver",
    "http://wso2.org/claims/enduser":"sumedha"
    }
```

The above JSON Web Token (JWT) contains the following information.

**JWT Header :** The header section declares that the encoded object is a JWT access token and the JWT is in plain text, that is not signed using any encryption algorithm.

**JWT Claims set :**

-   `"iss"` - The issuer of the JWT
-   `"exp"` - The token expiration time
-   `"http://wso2.org/claims/subscriber"` - Subscriber to the API, usually the app developer
-   `" http://wso2.org/claims/applicationname"` - Application through which API invocation is done
-   `" http://wso2.org/claims/apicontext"` - Context of the API
-   `" http://wso2.org/claims/version "` - API version
-   `" http://wso2.org/claims/tier"` - Tier/price band for the subscription
-   `" http://wso2.org/claims/enduser"` - End-user of the app who's action invoked the API
# Getting Started

WSO2 API Manager is a complete API Management solution that addresses all aspects of API management including API development, productization, consumption, security, rate limitation, monetization and analytics.

The REST API is implemented based on the REST specification and best practices as a CXF REST web application running on WSO2 API Manager. A contract-first approach could be utilized for API development starting with an OpenAPI specification.  

See the Gateway API's [Swagger definition](https://raw.githubusercontent.com/wso2/carbon-apimgt/v6.8.8/components/apimgt/org.wso2.carbon.apimgt.rest.api.gateway.v1/src/main/resources/gateway-api.yaml) , which is written using Open API 3.0.
Alternatively, this API definition can be accessed using the product URL as well `https://<host-name[:port]>/api/am/gateway/v1/swagger.json`.
The API comes with a pluggable security mechanism. Since API security is implemented as a CXF handler, if you need to plug a custom security mechanism, you can write your own handler and add it to the web service.
In the default flow, when an API is invoked with an access token, first the CXF handler gets engaged and calls an introspection API to validate the token.
Follow the instructions below to generate keys and obtain a token to invoke an API.

##Generate Keys

Obtain the application keys (consumer key/consumer secret) by invoking the dynamic client registration endpoint. Refer to the sample below to obtain application keys via cURL. The generated keys can then be used to obtain an access token to invoke an API.

```tab="Example"
curl -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @payload.json https://localhost:9443/client-registration/v0.17/register
```
Sample request:

```
{
   "callbackUrl":"www.google.lk",
   "clientName":"rest_api_admin",
   "owner":"admin",
   "grantType":"password refresh_token",
   "saasApp":true
}
```

Sample response:

```
{
   "callBackURL":"www.google.lk",
   "jsonString":"{ \"username\":\"admin\", \"redirect_uris\":\"www.google.lk\", \"client_name\":\"admin_rest_api_admin\", \"grant_types\":\"authorization_code password refresh_token iwa:ntlm urn:ietf:params:oauth:grant-type:saml2-bearer client_credentialsimplicit\" }",
   "clientName":null,
   "clientId":"HfEl1jJPdg5tbtrxhAwybN05QGoa",
   "clientSecret":"l6c0aoLcWR3fwezHhc7XoGOht5Aa"
}
```

##Generate an access token

Generate an access token using the keys obtained from the step above. Refer to the sample below to invoke the token endpoint.

Note: Access token must be generated using correct scope for the resource. Scope for each resource is given in resource documentation.


``` tab="Format"
curl -k -d "grant_type=password&username=<username>&password=<password>&scope=<scope>" -H "Authorization: Basic base64encode(consumer_key:consumer_secret)" https://localhost:8243/token
```

``` tab="Example"
curl -k -d "grant_type=password&username=admin&password=admin&scope=apim:tier_view" -H "Authorization: Basic SGZFbDFqSlBkZzV0YnRyeGhBd3liTjA1UUdvYTpsNmMwYW9MY1dSM2Z3ZXpIaGM3WG9HT2h0NUFh" https://localhost:8243/token
```

Token response:

```
{
   "scope":"apim:tier_view",
   "token_type":"Bearer",
   "expires_in":3600,
   "refresh_token":"33c3be152ebf0030b3fb76f2c1f80bf8",
   "access_token":"292ff0fd256814536baca0926f483c8d"
}
```

Now, you have a valid access token which you can use to invoke an API. If you wish to use a different grant type refer to the [Grant types](https://apim.docs.wso2.com/en/next/learn/api-security/oauth2/grant-types/overview/) document to learn more.
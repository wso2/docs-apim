# Getting Started - Developer Portal API v1

WSO2 API Manager is a complete API Management solution that addresses all aspects of API management including API development, productization, consumption, security, rate limitation, monetization and analytics.

The REST API is implemented based on the REST specification and best practices as a CXF REST web application running on WSO2 API Manager. A contract-first approach could be utilized for API development starting with a OpenAPI specification. 

For more information, see the Developer Portal APIs [Swagger definition](https://raw.githubusercontent.com/wso2/carbon-apimgt/v6.7.177/components/apimgt/org.wso2.carbon.apimgt.rest.api.store.v1/src/main/resources/store-api.yaml) that are written using OpenAPI 3.0. Alternatively, you can access this API definition using the product URL as well `https://<host-name[:port]>/api/am/store/v1/swagger.yaml`.

Before invoking the API with the access token, obtain the consumer key/secret key pair by calling the dynamic client registration endpoint. You can request an access token with the preferred grant type. An example is shown below,

```
curl -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @payload.json https://localhost:9443/client-registration/v0.17/register
```

Sample request:

```
{
   "callbackUrl":"www.google.lk",
   "clientName":"rest_api_store",
   "owner":"admin",
   "grantType":"password refresh_token",
   "saasApp":true
}
```

Sample response:

```
{
   "callBackURL":"www.google.lk",
   "jsonString":"{ \"username\":\"admin\", \"redirect_uris\":\"www.google.lk\", \"client_name\":\"admin_rest_api_store\", \"grant_types\":\"authorization_code password refresh_token iwa:ntlm urn:ietf:params:oauth:grant-type:saml2-bearer client_credentialsimplicit\" }",
   "clientName":null,
   "clientId":"HfEl1jJPdg5tbtrxhAwybN05QGoa",
   "clientSecret":"l6c0aoLcWR3fwezHhc7XoGOht5Aa"
}
```

During the API invocation process request, click the CXF handler first, which calls an introspection API to validate the token. Generate the access token using the already created OAuth application. A sample call to generate the access token is shown below.

Note: Access token must be generated using correct scope for the resource. Scope for each resource is given in resource documentation.

```
curl -k -d "grant_type=password&username=admin&password=admin&scope=apim:subscribe" -H "Authorization: Basic SGZFbDFqSlBkZzV0YnRyeGhBd3liTjA1UUdvYTpsNmMwYW9MY1dSM2Z3ZXpIaGM3WG9HT2h0NUFh" https://localhost:8243/token
```

Token response:

```
{
   "scope":"apim:subscribe",
   "token_type":"Bearer",
   "expires_in":3600,
   "refresh_token":"33c3be152ebf0030b3fb76f2c1f80bf8",
   "access_token":"292ff0fd256814536baca0926f483c8d"
}
```

Now you have a valid access token, which you can use to invoke an API. Navigate through the API descriptions to find the required API, obtain an access token as described above and invoke the API with the authentication header. If you use a different authentication mechanism, this process may change.

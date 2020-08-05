# Getting Started - Admin API v0.17

!!! warning
    - The Admin v0.17 REST APIs will be deprecated in the next WSO2 API Manager release.
    - **[WSO2 recommends that you use the Admin v1 REST APIs]({{base_path}}/develop/product-apis/admin-apis/admin-v1/admin-v1)** as it is up to date and has support for the latest WSO2 API Manager 3.2.0 features with regard to the Admin Portal.

WSO2 API Manager is a complete API Management solution that addresses all aspects of API management including API development, productization, consumption, security, rate limitation, monetization and analytics.

The REST API is implemented based on the REST specification and best practices as a CXF REST web application running on WSO2 API Manager. A contract-first approach could be utilized for API development starting with a OpenAPI specification. 

For more information, see the Publisher APIs [OpenAPI definition](https://raw.githubusercontent.com/wso2/carbon-apimgt/v6.7.177/components/apimgt/org.wso2.carbon.apimgt.rest.api.admin/src/main/resources/admin-api.yaml) that are written using OpenAPI Specification 3.0. Alternatively, you can access this API definition using the product URL as well `https://<host-name[:port]>/api/am/admin/v0.17/swagger.json`.

Before invoking the API with the access token, obtain the consumer key/secret key pair by calling the dynamic client registration endpoint. You can request an access token with the preferred grant type. An example is shown below:

```
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

During the API invocation process request, click the CXF handler first, which calls an introspection API to validate the token. Generate the access token using the already created OAuth application. A sample call to generate the access token is shown below.

Note: Access token must be generated using correct scope for the resource. Scope for each resource is given in resource documentation.

```
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

Now, you have a valid access token, which you can use to invoke an API. Navigate through the API descriptions to find the required API, obtain an access token as described above and invoke the API with the authentication header. If you use a different authentication mechanism, this process may change.
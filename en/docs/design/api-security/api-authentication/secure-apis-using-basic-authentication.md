#Securing APIs with Basic Authentication

Basic authentication is a simple HTTP authentication scheme in which the request will contain an authorization header with a valid  base64 encoded username and password. The WSO2 API Manager is able to authenticate requests using Basic and OAuth2 authentication 
schemes. In addition to using these schemes individually, it is also possible to use 
the OAuth2 and Basic schemes at the same time. 

The subsequent sections explain how you can work with Basic Authentication on the WSO2 API Gateway.

## Enabling Basic Authentication for an API
Basic Authentication is an API level configuration. Please sign in to the API Publisher and click on the API that you need to configure the 
Basic Authentication. Under the Application Level Security section in the Runtime Configuration of the API Details page allow users to configure
the Basic Authentication as follow.

[ ![]({{base_path}}/assets/img/learn//basic_authentication.png) ]({{base_path}}/assets/img/learn//basic_authentication.png)

## Understanding multiple authentication schemes

The WSO2 API Gateway is able to authenticate requests using Mutual SSl, Basic, OAuth2 and API Key authentication schemes. 
In addition to using these schemes  individually, it is also possible to use the multiple schemes at the same time.

 
If someone enable multiple schemes, the priority will be given in the order of Mutual SSL, OAuth2, Basic Auth and API Key. 
Between oauth2/Basic Auth and API Key, it will authenticate with only one authentication type based on the above order.

Mutual SSL treats as a transport level authentication scheme and it's separate out from the Application security schemes.

Additionally, the user will required to specify either one of Mutual SSL or oauth2/Basic Auth/API Key mandatory as without 
anyone of mandatory will skip the authentication.
 
Note : If oauth2/Basic Auth is set as mandatory, the request is need to be authenticated using only one of them. If OAuth2 failed only, the Basic Authentication will be applied.


## Invoking an API using Basic Authentication

Use the cURL command below to invoke the API via the gateway.

``` bash tab="Format"
curl -k -X GET "<API_URL>" -H  "accept: application/json" -H  "Authorization: Basic base64(username:password)"
```

``` bash tab="Example"
curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H  "accept: application/json" -H  "Authorization: Basic c2hhbmk6c2hhbmkxMjM="
```

##Basic Authentication with Scopes
WSO2 API Manager allow users to configure [Scopes](learn/api-security/oauth2/AOuth2Scopes/fine-grained-access-control-with-oauth-scopes) with role bindings which can associate with API Resources. Basic authentication
uses credentials of the user to authenticate with the Basic Authentication protected API.

If a user associate API resources with scopes which protected with Basic Authentication scheme, API Manager will perform the 
role validation of the defined scopes in the resources against the authenticated user roles.
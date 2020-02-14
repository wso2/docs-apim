#Application Keys

An API Access Token/Key is a string that is being passed as a HTTP header of an API request. WSO2 APIM provides OAuth2.0 
bearer token based authentication for API access and the API key has to be submitted alongside the API request in 
order to authenticate the access.

When an Application Developer registers an Application in the Developer Portal, a consumer-key 
and consumer-secret pair is generated, which represents the credentials of the Application that is 
being registered. The consumer-key becomes the unique identifier of the Application, similar to a user's username, and is used to authenticate the application/user. When an API key or an API access token is issued for the Application, it is issued against the latter mentioned consumer-key. When sending an API request, the access token has to be passed as the Authorization HTTP header value. 

Example:
`Authorization: Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a`
 
## Generate application keys

Follow the instructions below to generate/renew application keys:

1.  Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).
            
2.  Click **Applications** to navigate to the applications listing page and click on the respective application for which you want to generate keys.

     [![Application view]({{base_path}}/assets/img/Learn/application-select.png)]({{base_path}}/assets/img/Learn/application-select.png)
 
3.  Click **Production Keys** and click **Generate Keys** to create an application access token. 

     The access token will be generated along with application consumer key and secret.

     [![Generate Application Keys]({{base_path}}/assets/img/Learn/application-key-generation.png)]({{base_path}}/assets/img/Learn/application-key-generation.png)
    
     - If the application type is **JWT**, a JWT access token is generated. Make sure to copy the JWT access token that appears so that you can use it in the future.

        <a href="{{base_path}}/assets/img/Learn/jwt-access-token.png" ><img src="{{base_path}}/assets/img/Learn/jwt-access-token.png" alt="JWT Token" 
          title="JWT Token" width="60%" /></a>
     
     -  If the application type is **OAuth**, the generated access token will be an Opaque token.
     
         [![OAuth Token]({{base_path}}/assets/img/Learn/oauth-access-token.png)]({{base_path}}/assets/img/Learn/oauth-access-token.png)
     
     After the keys are generated, you can find the consumer key and consumer secret pair via the application details page.
     
     [![Application Consumer Key Secret]({{base_path}}/assets/img/Learn/application-key-secret-view.png)]({{base_path}}/assets/img/Learn/application-key-secret-view.png)
     
!!! tip
    In the Access token validity period field, you can set an expiration period to determine the validity period of 
    the token after generation. Set this to a negative value to ensure that the token never expires. For more information, see [Changing the default token expiration time]({{base_path}}/Learn/ConsumeAPI/ManageApplication/GenerateKeys/ObtainAccessToken/changing-the-default-token-expiration-time/).

!!! tip
    When you generate access tokens for APIs that are protected by scopes, you can select the respective [scopes]({{base_path}}/Learn/APISecurity/OAuth2/OAuth2Scopes/fine-grained-access-control-with-oauth-scopes/) and thereafter, generate the token for it.


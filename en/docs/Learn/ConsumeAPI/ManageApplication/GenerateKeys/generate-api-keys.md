#### Overview

An API Access Token/Key is a string that is being passed as a HTTP header of an API request. WSO2 APIM provides OAuth2.0 
bearer token based authentication for API access and the API key has to be submitted alongside the API request in 
order to authenticate the access.

When an Application Developer registers an Application in the API 
Portal, it is given with a consumer-key 
and consumer-secret pair, which represents the credentials of the Application that is 
being registered. The 
consumer-key becomes the unique identifier of the Application, similar to a user's username, and is used to 
authenticate the application/user. When an API key or an API access token is issued for the Application, it is issued 
against the 
latter mentioned consumer-key. When sending an API request, the access token has to be passed as  Authorization 
HTTP 
header value. 

Example:
`Authorization: Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a`
 
#### Generate Application Keys

The steps below describe how to generate/renew application keys.

1.  Sign in to WSO2 API developer portal ( `https://<hostname>:9443/devportal`).
            
2.  Navigate to applications listing page and click on the application which you want to 
generate keys.

    <a href="../../../../../assets/img/Learn/application-select.png" ><img src="../../../.
    ./../assets/img/Learn/application-select.png" alt="Application View" 
         Keys" 
         title="Application View" width="70%" /></a>
 
3.  Click the Production Keys tab and click Generate Keys to create an application access token. Then the access 
token will be generated along with application consumer key and secret.

    <a href="../../../../../assets/img/Learn/application-key-generation.png" ><img src="../../../../../assets/img/Learn/application-key-generation.png" alt="Generate Application 
     Keys" 
     title="Generate Application Keys" width="70%" /></a>
    
    If the application type is JWT, the generated access token will be an JWT token and it has to be copied just 
after the generation.

     <a href="../../../../../assets/img/Learn/jwt-access-token.png" ><img src="../../../../../assets/img/Learn/jwt-access-token.png" alt="JWT Token" 
          title="JWT Token" width="40%" /></a>
     
     If the application type is OAuth, the generated access token will be an Opaque token.
     
     <a href="../../../../../assets/img/Learn/oauth-access-token.png" ><img src="../../../../../assets/img/Learn/oauth-access-token.png" alt="OAuth Token" 
               title="OAuth Token" width="70%" /></a>
     
     Once the keys are generated, you can find the consumer key and consumer secret pair from the application detail 
     page.
     
     <a href="../../../../../assets/img/Learn/application-key-secret-view.png" ><img src="../../../../../assets/img/Learn/application-key-secret-view.png" alt="Application Consumer Key Secret" title="Application
      Consumer Key Secret" width="70%" /></a>
     
!!! tip
    In the Access token validity period field, you can set an expiration period to determine the validity period of 
    the token after generation. Set this to a negative value to ensure that the token never expires. Please refer 
    [Changing the default token expiration time](ObtainAccessToken/changing-the-default-token-expiration-time.md) for
     more information

!!! tip
    When you generate access tokens to APIs protected by scope/s, you can select the [scope/s](../../.
    ./APISecurity/OAuth2/Outh2Scopes/) and then generate the 
    token for it.


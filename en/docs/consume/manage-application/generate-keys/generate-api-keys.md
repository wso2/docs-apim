# Application Keys

An API Access Token/Key is a string that is being passed as an HTTP header of an API request. WSO2 APIM provides OAuth2.0 bearer token-based authentication for API access and the API key has to be submitted alongside the API request in order to authenticate the access.

When an Application Developer registers an Application in the Developer Portal, a consumer-key 
and consumer-secret pair is generated, which represents the credentials of the Application that is 
being registered. The consumer-key becomes the unique identifier of the Application, similar to a user's username, and is used to authenticate the application/user. When an API key or an API access token is issued for the Application, it is issued against the latter mentioned consumer-key. When sending an API request, the access token has to be passed as the Authorization HTTP header value. 

Example:
`Authorization: Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a`
 
## Generate application keys

Follow the instructions below to generate/renew application keys:

1.  Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).
            
2.  Click **Applications** to navigate to the applications listing page and click on the respective application for which you want to generate keys.

     [![Application view]({{base_path}}/assets/img/learn/application-select.png)]({{base_path}}/assets/img/learn/application-select.png)
 
3.  Click **Production Keys** and click **Generate Keys** to create an application access token. 

     The access token will be generated along with the application consumer key and secret.

     [![Generate Application Keys]({{base_path}}/assets/img/learn/application-key-generation.png)]({{base_path}}/assets/img/learn/application-key-generation.png)
    
     - Make sure to copy the generated JWT access token that appears so that you can use it in the future.

        <a href="{{base_path}}/assets/img/learn/jwt-access-token.png" ><img src="{{base_path}}/assets/img/learn/jwt-access-token.png" alt="JWT access token" title="JWT access token" width="60%" /></a>
     
     After the keys are generated, you can find the consumer key and consumer secret pair via the application details page.
     
     [![Application Consumer Key Secret]({{base_path}}/assets/img/learn/application-key-secret-view.png)]({{base_path}}/assets/img/learn/application-key-secret-view.png)
     

!!! tip
    When you generate access tokens for APIs that are protected by scopes, you can select the respective [scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/) and thereafter, generate the token for it.

## Generate application keys with PKCE Enabled.

PKCE is a commonly used security measure to secure the applications that are executing in the same domain. As an example to mobile applications running on a single device can get the other application’s auth code and request a token if the domain is the same. To overcome this issue Proof Key for Code Exchange is introduced.

To enable PKCE you need to ticke the option as blow when generating the keys.

[![Enabling PKCE]({{base_path}}/assets/img/learn/key_generation_with_pkce.png)]({{base_path}}/assets/img/learn/key_generation_with_pkce.png)

Following are the options associated with when enabling PKCE

1.  Support PKCE Plain text 

     When this option is enabled the code chanllenger and code verifier used will be in plain text. The recomanded way is to use SHA 256 algorythm which is the default when this option is not selected.

     [![Enabling plain text support for PKCE]({{base_path}}/assets/img/learn/key_generation_with_pkce_bypass_secret.png)]({{base_path}}/assets/img/learn/key_generation_with_pkce_bypass_secret.png)


2. Public client

     This option will allow client to authenticate without secret.

     [![Enabling Public client for PKCE]({{base_path}}/assets/img/learn/key_generation_with_pkce_plain.png)]({{base_path}}/assets/img/learn/key_generation_with_pkce_plain.png)


## Generate application keys using Okta Key Manager

Follow the instructions below to generate keys using the Okta Key Manager:

Let's assume that you are working in a production environment.

1. Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).

2. Click **Production Keys** and then click **Okta**.

3. Click **Generate Keys** to create an application access token.

     [![Generate Okta application keys]({{base_path}}/assets/img/learn/okta-application-key-generation.png)]({{base_path}}/assets/img/learn/okta-application-key-generation.png)

!!! info
    For more information on the client application properties that need to be set, see the [Okta documentation](https://developer.okta.com/docs/reference/api/oauth-clients/#client-application-properties).

!!! note
    If you need an Access Token with scopes, make sure that you have created the scopes in advance on the Okta side.

## Generate application keys using Keycloak Key Manager

Follow the instructions below to generate keys using the Keycloak Key Manager:

1. Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).

2. Click **Production Keys** and then click **Keycloak**.

3. Click **Generate Keys** to create an application access token.

     [![Generate Keycloak application keys]({{base_path}}/assets/img/learn/keycloak-generate-keys.png)]({{base_path}}/assets/img/learn/keycloak-generate-keys.png)

# Application Keys

An API Access Token/Key is a string that is passed as an HTTP header of an API request. WSO2 API-M provides OAuth2.0 bearer token-based authentication for API access, and the API key has to be submitted alongside the API request in order to authenticate the access.

When an Application Developer registers an Application in the Developer Portal, a consumer key and consumer secret pair are generated, which represents the credentials of the application that is being registered. The consumer key becomes the unique identifier of the application, similar to a user's username, and is used to authenticate the application/user. When an API Key or an API Access Token is issued for the application, it is issued against the latter mentioned consumer key. When sending an API request, the access token has to be passed as the Authorization HTTP header value. 

!!! example
    `Authorization: Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a`
 
## Generating application keys

Follow the instructions below to generate/renew application keys:

1.  Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).
            
2.  Click **Applications** to navigate to the applications listing page and click on the respective application for which you want to generate keys.

     [![Application view]({{base_path}}/assets/img/learn/application-select.png)]({{base_path}}/assets/img/learn/application-select.png)
 
3.  Click **Production Keys** or **Sandbox Keys** based on the environment for which you need to generate keys.
      
      Let's assume that you are working in a production environment. Therefore, click **Production Keys**.

4.  Click **Generate Keys** to create an application Access Token. 

     The Access Token will be generated along with the application consumer key and secret.

     [![Generate Application Keys]({{base_path}}/assets/img/learn/application-key-generation.png)]({{base_path}}/assets/img/learn/application-key-generation.png)
    
5. Copy the generated JWT Access Token that appears so that you can use it in the future.

      <a href="{{base_path}}/assets/img/learn/jwt-access-token.png" ><img src="{{base_path}}/assets/img/learn/jwt-access-token.png" alt="JWT access token" title="JWT access token" width="60%" /></a>
     
     After the keys are generated, you can find the consumer key and consumer secret pair via the application details page.
     
     [![Application Consumer Key Secret]({{base_path}}/assets/img/learn/application-key-secret-view.png)]({{base_path}}/assets/img/learn/application-key-secret-view.png)
     

!!! tip
    When you generate Access Tokens for APIs that are protected by scopes, you can select the respective [scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/) and, thereafter, generate the token for it.

## Generating application keys with PKCE enabled

Proof Key for Code Exchange (PKCE) is a commonly used security measure to secure the applications that are executing in the same domain. For example, two mobile applications running on a single device can get the other application's Auth code and request a token if the domain is the same. You can use PKCE to overcome the latter mentioned issue.

To enable PKCE, you need to select the **Enable PKCE** option as shown below when generating the keys.

[![Enabling PKCE]({{base_path}}/assets/img/learn/key-generation-with-pkce.png)]({{base_path}}/assets/img/learn/key-generation-with-pkce.png)

The following are the associated options when enabling PKCE.

-  Support PKCE Plain Text 

      When this option is enabled, the code challenger and code verifier used will be in plain text. The recommended way is to use a SHA 256 algorithm, which is the default value when this option is not selected.

      [![Enabling Public client for PKCE]({{base_path}}/assets/img/learn/key-generation-with-pkce-plain.png)]({{base_path}}/assets/img/learn/key-generation-with-pkce-plain.png)

- Public Client

      This option will allow the client to be authenticated without the secret.

      [![Enabling plain text support for PKCE]({{base_path}}/assets/img/learn/key-generation-with-pkce-bypass-secret.png)]({{base_path}}/assets/img/learn/key-generation-with-pkce-bypass-secret.png)

## Generating application keys using Okta

!!! note
     Before you begin, make sure to follow [steps 1 and 2 in Configure Okta as a Key Manager]({{base_path}}/administer/key-managers/configure-okta-connector/) guide.

Follow the instructions below to generate keys using Okta as the Key Manager:

1. Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).

2. Click **Production Keys** or **Sandbox Keys** based on the environment for which you need to generate keys.
      
      If you are working in a production environment, click **Production Keys**.

3. Click **Okta**.

4. Click **Generate Keys** to create an application Access Token.

     [![Generate Okta application keys]({{base_path}}/assets/img/learn/okta-application-key-generation.png)]({{base_path}}/assets/img/learn/okta-application-key-generation.png)

!!! info
    For more information on the client application properties that need to be set, see the [Okta documentation](https://developer.okta.com/docs/reference/api/oauth-clients/#client-application-properties).

!!! note
    If you need an Access Token with scopes, make sure that you have created the scopes in advance on the Okta side.

## Generating application keys using Keycloak

!!! note
     Before you begin, make sure to follow [steps 1 and 2 in Configure Keycloak as a Key Manager]({{base_path}}/administer/key-managers/configure-keycloak-connector/) guide.

Follow the instructions below to generate keys using the Keycloak as the Key Manager:

1. Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).

2. Click **Production Keys** or **Sandbox Keys** based on the environment for which you need to generate keys.
      
      If you are working in a production environment, click **Production Keys**.

3. Click **Keycloak**.

4. Click **Generate Keys** to create an application access token.

     [![Generate Keycloak application keys]({{base_path}}/assets/img/learn/keycloak-generate-keys.png){: style="width:70%"}]({{base_path}}/assets/img/learn/keycloak-generate-keys.png)

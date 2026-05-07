# Application Keys

An API Access Token/Key is a string that is passed as an HTTP header of an API request. WSO2 API-M provides OAuth2.0 bearer token-based authentication for API access, and the API key has to be submitted alongside the API request in order to authenticate the access.

When an Application Developer registers an Application in the Developer Portal, a consumer key and consumer secret pair are generated, which represents the credentials of the application that is being registered. The consumer key becomes the unique identifier of the application, similar to a user's username, and is used to authenticate the application/user. When an API Key or an API Access Token is issued for the application, it is issued against the latter mentioned consumer key. When sending an API request, the access token has to be passed as the Authorization HTTP header value. 

!!! example
    `Authorization: Bearer NtBQkXoKElu0H1a1fQ0DWfo6IX4a`

From WSO2 API Manager 4.7.0 onwards, applications support multiple consumer secrets. Each consumer secret can optionally include a description and expiry time. Consumer secrets are masked in the Developer Portal and are displayed only at the time of generation

!!! important
    **Securely store consumer secrets after generation.**
    Once a consumer secret is generated, it **cannot be viewed again**. Make sure to **record all existing and newly generated secrets securely**, as previously generated secrets will not be retrievable from the Developer Portal.

To configure this behavior, see [Configure Multiple Consumer Secrets](#configure-multiple-consumer-secrets). To disable multiple consumer secrets and have the previous behaviour of having a single consumer secret per application, see [Disable Multiple Consumer Secrets](#disable-multiple-consumer-secrets).
 
## Generating application keys

Follow the instructions below to generate/renew application keys:

1.  Sign in to WSO2 API Developer Portal (`https://<hostname>:9443/devportal`).
            
2.  Click **Applications** to navigate to the applications listing page and click on the respective application for which you want to generate keys.

     [![Application view]({{base_path}}/assets/img/learn/application-listing.png)]({{base_path}}/assets/img/learn/application-listing.png)
 
3.  Click **Production Keys** or **Sandbox Keys** based on the environment for which you need to generate keys.
      
      Let's assume that you are working in a production environment. Therefore, click **Production Keys**.

4.  Click **Generate Keys** to create the consumer key and secret pair.

     An optional description and expiry time can be provided for the consumer secret which will be generated.

     [![Consumer Secret Meta Data Form]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secret-metadata-form.png)]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secret-metadata-form.png)

5.  The generated consumer secret will be displayed.

    !!! Important
        Make sure to copy the generated consumer secret as it will be displayed only once.

     [![Generated Consumer Secret]({{base_path}}/assets/img/consume/consumer-secrets/generated-consumer-secret.png)]({{base_path}}/assets/img/consume/consumer-secrets/generated-consumer-secret.png)

6.  The consumer secret list will be displayed in a table.

     [![Consumer Secrets Table View]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secrets-table-view.png)]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secrets-table-view.png)

7.  To generate another consumer secret, click **+ NEW SECRET** button. A form will be shown where an optional description and expiry time can be provided
    for the consumer secret which will be generated.

     [![New Consumer Secret Generation Form]({{base_path}}/assets/img/consume/consumer-secrets/new-consumer-secret-generation-form.png)]({{base_path}}/assets/img/consume/consumer-secrets/new-consumer-secret-generation-form.png)

     The generated consumer secret will be displayed. Make sure to copy the generated consumer secret as it will be displayed only once.

8.  Two consumer secrets are now available for the application. Access tokens can be generated using any of the available consumer secrets associated with the application. To generate an access token, click **GENERATE ACCESS TOKEN**. When prompted, provide one of the consumer secrets associated with the application.

     <a href="{{base_path}}/assets/img/consume/consumer-secrets/access-token-generation-with-consumer-secret.png">
        <img src="{{base_path}}/assets/img/consume/consumer-secrets/access-token-generation-with-consumer-secret.png" alt="Access Token Generation With Consumer Secret" width="60%">
    </a>

9.  Copy the generated JWT Access Token that appears so that you can use it in the future.

     <a href="{{base_path}}/assets/img/learn/jwt-access-token.png" ><img src="{{base_path}}/assets/img/learn/jwt-access-token.png" alt="JWT access token" title="JWT access token" width="60%" /></a>

!!! tip
    When you generate Access Tokens for APIs that are protected by scopes, you can select the respective [scopes]({{base_path}}/api-security/runtime/authorization/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/) and, thereafter, generate the token for it.

### Deleting a Consumer Secret

1.  To delete a consumer secret, click the **DELETE** icon under the **Actions** column corresponding to the consumer secret which should be deleted.

     [![Delete Consumer Secret]({{base_path}}/assets/img/consume/consumer-secrets/delete-consumer-secret.png)]({{base_path}}/assets/img/consume/consumer-secrets/delete-consumer-secret.png)

2.  A confirmation box will be opened to verify whether the action was intended. Click **DELETE** to delete the consumer secret.

     [![Delete Consumer Secret Confirmation]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secret-deletion-confirmation.png)]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secret-deletion-confirmation.png)

!!! note
     The most recently added consumer secret cannot be deleted because an application must always retain at least one consumer secret.

     [![Consumer Secret Deletion Constraint]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secret-deletion-constraint.png)]({{base_path}}/assets/img/consume/consumer-secrets/consumer-secret-deletion-constraint.png)

!!! Important
     Deleting a consumer secret does **not** revoke access tokens that were generated using that secret. These tokens will continue to remain valid until their configured expiry time. Therefore, it is recommended to use access tokens with the **minimum required expiry time**.

## Configure multiple consumer secrets

You can configure multiple consumer secret behavior in `<API-M_HOME>/repository/conf/deployment.toml`.

### Limit the number of consumer secrets per application

By default, an application can have an unlimited number of consumer secrets. To limit the number of secrets that can be created for an application, add the `secret_count` configuration:

```toml
[oauth.multiple_client_secrets]
secret_count = <SECRET_COUNT>
```

For example, to allow up to 5 consumer secrets per application, add the following configuration:

```toml
[oauth.multiple_client_secrets]
secret_count = 5
```

### Disable multiple consumer secrets

To disable multiple consumer secrets and use the previous behavior (single consumer secret per application), add the following configuration:

```toml
[oauth.multiple_client_secrets]
enable = false
```

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

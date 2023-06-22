# Creating the Client ID, Access Token and Refresh Token

In this documentation, you will learn how to create the Client ID, Access Token and Refresh Token for the Twitter connector using the Twitter developer portal.

For the Twitter connector 3.0.x version, **OAuth 2.0 Authorization Code Flow with PKCE** is used to authenticate the user. Therefore, obtaining credentials is different from the Twitter connector 2.0.x version as it uses **OAuth 1.0a** authentication mechanism. For more information about the authentication mechanism, see [Twitter OAuth 2 guide](https://developer.twitter.com/en/docs/authentication/oauth-2-0/authorization-code). 

## Steps to follow

1. To get started with the new Twitter API, you need a developer account. If you do not have one yet, you can [sign up](https://developer.twitter.com/en/portal/petition/essential/basic-info) for one. 

2. Then log into the [developer portal](https://developer.twitter.com/en/portal/dashboard). 

!!! info
    The Twitter **Free tier** subscription is only sufficient for **createTweet, deleteTweet**, and **getMe** operations. If you want to use other operations, you need to upgrade your subscription to **Basic Tier**.

3. Create a new project and create an app inside the project.
  <img src="{{base_path}}/assets/img/integrate/connectors/twitter-connector-newproject.png" title="New Project" width="800" alt="New Project" />

4. In the app, you will need to set up the OAuth 2.0 as the WSO2 Twitter connector uses this authentication mechanism. 
  <img src="{{base_path}}/assets/img/integrate/connectors/twitter-connector-auth-setup.png" title="OAuth setup" width="800" alt="OAuth setup" />

5. Provide necessary variables. The Access tokens and refresh tokens will be sent to the callback URL.
  <img src="{{base_path}}/assets/img/integrate/connectors/twitter-connector-callbackurl.png" title="Callback URL" width="400" alt="Callback URL" />

6. After successfully setting up the user authentication you can obtain the client ID of the Twitter app which is used for the Twitter connector configuration.
  <img src="{{base_path}}/assets/img/integrate/connectors/twitter-connector-clientid.png" title="Client ID" width="800" alt="Client ID" />

7. To obtain the Access Token and Refresh Token, follow the [Twitter OAuth 2 guide](https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token#:~:text=Steps%20to%20connect%20using%20OAuth%202.0). 

!!! info
    The Twitter access token is valid for 2 hours. The refresh token is valid until a new access token is created from the refresh token.

!!! warning
    By default the Twitter App provides an access token for OAuth 1.0a flow which is not used in the Twitter connector. You need to create a new access token for OAuth 2.0 flow. 
    
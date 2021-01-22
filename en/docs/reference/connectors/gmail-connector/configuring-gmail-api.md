## Creating the Client ID and Client Secret

1. Navigate to [API Credentials Page](https://console.developers.google.com/projectselector/apis/credentials) and sign in with your Google account.

2. Click on **Select a Project** and click **NEW PROJECT**, to create a project.
 <img src="{{base_path}}/assets/img/integrate/connectors/create-project.png" title="Creating a new Project" width="800" alt="Creating a new Project" />

3. Enter `GmailConnector` as the name of the project and click **Create**.

4. Click **Configure consent screen** in the next screen.
  <img src="{{base_path}}/assets/img/integrate/connectors/consent-screen.png" title="Consent Screen" width="800" alt="Consent Screen" />

5. Provide the Application Name as `GmailConnector` in the Consent Screen.
  <img src="{{base_path}}/assets/img/integrate/connectors/consent-screen2.png" title="Consent Screen" width="800" alt="Consent Screen" />

6. Click Create credentials and click OAuth client ID.
  <img src="{{base_path}}/assets/img/integrate/connectors/create-credentials.png" title="Create Credentials" width="800" alt="Create Credentials" />

7. Enter the following details in the Create OAuth client ID screen and click Create.

  | Type                        | Name                                             | 
  | ------------------          | -------------------------------------------------|
  | Application type            | Web Application                                  |
  | Name                        | GmailConnector                                   |
  | Authorized redirect URIs    | https://developers.google.com/oauthplayground    |

  
8. A Client ID and a Client Secret are provided. Keep them saved.
  <img src="{{base_path}}/assets/img/integrate/connectors/credentials.png" title="Credentials" width="800" alt="Credentials" />

9. Click Library on the side menu, search for **Gmail API** and click on it.

10. Click **Enable** to enable the Gmail API.


## Obtaining Access Token and Refresh Token
1. Navigate to [OAuth 2.0 Playground](https://developers.google.com/oauthplayground/) and click OAuth 2.0 Configuration button in the Right top corner.

2. Select **Use your own OAuth credentials**, and provide the obtained Client ID and Client Secret values as above click on Close.
  <img src="{{base_path}}/assets/img/integrate/connectors/oath-configuration.png" title="Obtaining Oauth-configuration" width="800" alt="Obtaining Oauth-configuration" />

3. Under Step 1, select `Gmail API v1` from the list of APIs, select all the scopes expect the [gmail.metadata scope](https://www.googleapis.com/auth/gmail.metadata) scope.

  <img src="{{base_path}}/assets/img/integrate/connectors/select-scopes.png" title="Selecting Scopes" width="800" alt="Selecting Scopes" />

4. Click on **Authorize APIs** button and select your Gmail account when you are asked and allow the scopes.
  <img src="{{base_path}}/assets/img/integrate/connectors/grant-permission.png" title="Grant Permission" width="800" alt="Grant Permission" />

5.  Under Step 2, click **Exchange authorization code for tokens** to generate an display the Access Token and Refresh Token. Now we are done with configuring the Gmail API.
  <img src="{{base_path}}/assets/img/integrate/connectors/refreshtoken.png" title="Getting Tokens" width="800" alt="etting Tokens" />

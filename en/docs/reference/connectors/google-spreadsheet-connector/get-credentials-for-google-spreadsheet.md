# Get Credentials for Google Spreadsheet

To obtain the Access Token, Client Id, Client Secret and Refresh Token, we need to follow the below steps. 

1. Open the [Google API Console Credentials](https://console.developers.google.com/apis/credentials) page. You will be prompted to log in to a Google Account. Log in to your relevant Google Account. 

2. Click on **Select a Project** and click **NEW PROJECT**, to create a project.
 <img src="{{base_path}}/assets/img/integrate/connectors/create-project.png" title="Creating a new Project" width="800" alt="Creating a new Project" />

3. Enter `SpreadsheetConnector` as the name of the project and click **Create**.

4. Click **Configure consent screen** in the next screen.
  <img src="{{base_path}}/assets/img/integrate/connectors/consent-screen.png" title="Consent Screen" width="800" alt="Consent Screen" />

5. Provide the Application Name as `SpreadsheetConnector` in the Consent Screen.
  <img src="{{base_path}}/assets/img/integrate/connectors/consent-screen2.png" title="Consent Screen" width="800" alt="Consent Screen" />

6. Click Create credentials and click OAuth client ID.
  <img src="{{base_path}}/assets/img/integrate/connectors/create-credentials.png" title="Create Credentials" width="800" alt="Create Credentials" />

7. Enter the following details in the Create OAuth client ID screen and click Create.

  | Type                        | Name                                             | 
  | ------------------          | -------------------------------------------------|
  | Application type            | Web Application                                  |
  | Name                        | SpreadsheetConnector                                   |
  | Authorized redirect URIs    | https://developers.google.com/oauthplayground    |

  
8. A Client ID and a Client Secret are provided. Keep them saved.
  <img src="{{base_path}}/assets/img/integrate/connectors/credentials.png" title="Credentials" width="800" alt="Credentials" />

9. Click Library on the side menu, search for **Google Sheets API** and click on it.

10. Click **Enable** to enable the Google Sheets API.
  <img src="{{base_path}}/assets/img/integrate/connectors/sheetsapi.png" title="Enable Google Sheets API" width="800" alt="Enable Google Sheets API" />


## Obtaining Access Token and Refresh Token
1. Navigate to [OAuth 2.0 Playground](https://developers.google.com/oauthplayground/) and click the OAuth 2.0 Configuration button in the top right corner of your screen.

2. Select **Use your own OAuth credentials**, and provide the obtained Client ID and Client Secret values. Click on **Close**.
  <img src="{{base_path}}/assets/img/integrate/connectors/oath-configuration.png" title="Obtaining Oauth-configuration" width="800" alt="Obtaining Oauth-configuration" />

3. Under Step 1, select `Google Sheets API v4` from the list of APIs and select all the scopes. 
  <img src="{{base_path}}/assets/img/integrate/connectors/sheetsapi2.png" title="Selecting Scopes" width="800" alt="Selecting Scopes" />

4. Click on **Authorize APIs** button and select your Gmail account when you are asked and allow the scopes.
  <img src="{{base_path}}/assets/img/integrate/connectors/sheetsapi4.png" title="Grant Permission" width="800" alt="Grant Permission" />

5.  Under Step 2, click **Exchange authorization code for tokens** to generate and display the Access Token and Refresh Token. Now we are done with configuring the Google Sheets API.
  <img src="{{base_path}}/assets/img/integrate/connectors/refreshtoken.png" title="Getting Tokens" width="800" alt="Getting Tokens" />


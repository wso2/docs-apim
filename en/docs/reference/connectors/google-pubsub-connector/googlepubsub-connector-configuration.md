# Setting up the Google PubSub Environment  

The Google Pub/Sub connector allows you to access the [Google Cloud Pub/Sub API Version v1](https://cloud.google.com/pubsub/docs/reference/rest/) using an integration sequence.

To work with the Google Pub/Sub connector, you need to have a Google Cloud Platform account. If you do not have a Google Cloud Platform account, go to [console.cloud.google.com](https://console.cloud.google.com/freetrial), and create a Google Cloud Platform trial account.

Google Pub/Sub uses the OAuth 2.0 protocol for authentication and authorization. All requests to the Google Cloud Pub/Sub API must be authorized by an authenticated user. For information on how to obtain authentication and authorization user credentials, see the following section.

### Obtaining user credentials 

Follow the steps below to generate user credentials.

**Obtaining a client ID and client secret**

1. Go to [https://console.developers.google.com/projectselector/apis/credentials](https://console.developers.google.com/apis/credentials), and sign in to your **Google account**.
    
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-credentials-page.png" title="Google pubsub-credentials-page" width="600" alt="Google pubsub-credentials-page"/>   
   
2. If you do not already have a project, you create a new project, click **Create credentials** and then select **OAuth client ID**.     
   
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-create-credentials.png" title="Select OAuth client ID" width="600" alt="Select OAuth client ID"/> 
   
3. Next, **select** Web Application, and **create a client**.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-select-web-application.png" title="Select web application" width="600" alt="Select web application"/> 

4. Add [https://developers.google.com/oauthplayground](https://developers.google.com/oauthplayground/) as the redirect URL under **Authorized redirect URIs**, and then click **Create**. This displays the **client ID** and **client secret**.

    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-authorization-redirect-uri.png" title="Authorization-redirect-URI" width="600" alt="Authorization-redirect-URI"/> 
   
5. Make a note of the **client ID** and **client secret** that is displayed, and then **click OK**.   
   
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-authorization-redirect-uri.png" title="Authorization-redirect-URI" width="600" alt="Authorization-redirect-URI"/> 

6. Click **Library** on the left navigation pane.

    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-select-library.png" title="Select library" width="600" alt="Select library"/> 

7. Search **Google Cloud Pub/Sub API** under the **Big data or Networking category**.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-select-api.png" title="Pubsub API" width="600" alt="Pubsub API"/> 

8. Click **Enable**. This enables the Google Cloud Pub/Sub API.   
   
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-enable-api.png" title="Pubsub enable API" width="600" alt="Pubsub enable API"/> 

**Obtaining an access token and refresh token**

1. Navigate to [OAuth playground](https://developers.google.com/oauthplayground), click the gear icon on the top right corner of the screen, and select **Use your own OAuth credentials**.

    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-apply-playground-credentials.png" title="playground-credentials" width="600" alt="playground-credentials"/> 
   
2. Specify the **client ID** and **client secret** that you obtained in step 3 above, and click **Close**.

3. Under Step 1 on the screen, select **Google Cloud Pub/Sub API** from the list of APIs, and select all the **scopes** that are listed down under Google Cloud Pub/Sub API.
   
    <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-authorize-api.png" title="Authorize API" width="600" alt="Authorize API"/>  

4. Click **Authorize APIs**. This requests for permission to access your profile details.

5. Click **ALLOW**.

6. In Step 2 on the screen, click **Exchange authorization code for tokens** to generate and view the access token and refresh token.
   
     <img src="{{base_path}}/assets/img/integrate/connectors/pubsub-exchange-authorization-code.png" title="Exchange-authorization-code" width="600" alt="Exchange-authorization-code"/> 
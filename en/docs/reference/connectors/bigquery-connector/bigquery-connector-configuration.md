# Setting up the BigQuery Environment  

The BigQuery connector allows you to access the [BigQuery REST API](https://cloud.google.com/bigquery/docs/reference/rest) through WSO2 EI.

To work with the BigQuery connector, you need to have a Google Cloud Platform account. If you do not have a Google Cloud Platform account, go to [console.cloud.google.com](https://console.cloud.google.com/freetrial), and create a Google Cloud Platform trial account.

BigQuery uses the OAuth 2.0 protocol for authorization. All requests to the BigQuery REST API will be authorized against a registered user. Developers can generate user credentials from the Google Cloud Platform using two different mechanisms. See the following sections for detail.

### Obtaining user credentials 

Follow the steps below to generate user credentials.

**Obtaining a client ID and client secret**

1. Go to [https://accounts.google.com/SignUphttps://accounts.google.com/SignUp](https://accounts.google.com/SignUp) and create a Google account.

2. Go to [https://console.developers.google.com/projectselector/apis/credentials](https://console.developers.google.com/apis/credentials), and sign in to your **Google account**.
    
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-credentials-page.png" title="Bigquery-credentials-page" width="600" alt="Bigquery-credentials-page"/>   
   
3. If you do not already have a project, you can create a new project. Click **Create credentials** and then select **OAuth client ID**.     
   
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-credentials.png" title="Select OAuth client ID" width="600" alt="Select OAuth client ID"/> 
   
4. Next, **select** Web Application, and **create a client**.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-select-web-application.png" title="Select web application" width="600" alt="Select web application"/> 

5. Add [https://www.google.com](https://www.google.com) as the redirect URI (you can add any URI that you need as redirect URI) under **Authorized redirect URIs**, and then click **Create**. This displays the **client ID** and **client secret**.

    <img src="{{base_path}}/assets/img/integrate/connectors/biguery-authorization-redirect-URI.png" title="Authorization-redirect-URI" width="600" alt="Authorization-redirect-URI"/> 
   
6. Make a note of the **client ID** and **client secret** that is displayed, and then **click OK**.   
   
7. Click **Library** on the left navigation pane.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-select-library.png" title="Select library" width="600" alt="Select library"/> 

8. Search  **BigQuery API** under the **Big data category**.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-select-api.png" title="Bigquery API" width="600" alt="Pubsub API"/> 

9. Click **Enable**. This enables the BigQuery API.   
   
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-enable-api.png" title="Bigquery enable API" width="600" alt="Pubsub enable API"/> 
    
10. Get the authorization code by sending a GET request to the following URL. Replace the `<redirect_uri>` and `<client_ID>` with the redirect uri and client ID values noted in the previous steps. Enter the following URL in your web browser.
 
    ```
    https://accounts.google.com/o/oauth2/auth?redirect_uri=<redirect_uri>&response_type=code&client_id=<client_ID>&scope=https://www.googleapis.com/auth/bigquery&approval_prompt=force&access_type=offline
    ```
    Note the authorization code for future use.
    
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-get-authorization-code.png" title="Get authorization code" width="600" alt="Get authorization code"/> 
    
11. Get the `access token` and `refresh token` by sending a POST request to the URL given below. Be sure to use an **x-www-form-urlencoded** body with the `<authorization_code>`, `<client_id>`, `<client_secret>`, and `<redirect_uri>` values noted before, and also set the `grant_type` to **authorization_code**. You will need them to configure WSO2 EI Big Query Connector. 
    
    ```
    https://www.googleapis.com/oauth2/v3/token.
    ```
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-gettoken-postman.png" title="Bigquery get token using postman" width="800" alt="Bigquery get token using postman"/> 

### Obtaining credentials using the service account

1. Open the [Service Accounts](https://console.cloud.google.com/projectselector2/iam-admin/serviceaccounts) page in the GCP console.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-service-account.png" title="Bigquery service account" width="600" alt="Bigquery service account"/> 

2. Select your project and click **Open**.

3. Click **Create Service Account**.
  
    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-service-account.png" title="Bigquery create service account" width="600" alt="Bigquery create service account"/> 

4. Enter **Service account details**, and then click **Create**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-enter-service-account-details.png" title="Bigquery enter service account" width="600" alt="Bigquery enter service account"/> 

5. Select a **role** you wish to grant to the service account and click **Continue**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-service-account-role.png" title="Bigquery enter service account role" width="600" alt="Bigquery enter service account role"/> 

6. Grant users access to this service account (optional) and click **Done**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-service-account-grant-user-access.png" title="Bigquery enter service account grant user access" width="600" alt="Bigquery enter service account grant user access"/> 

7. Go to the service account for which you wish to create a key and **click** the created Service account in that row.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-select-created-service-account.png" title="Bigquery enter service account grant user access" width="600" alt="Bigquery enter service account grant user access"/> 

8. Click **Create key**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-key.png" title="Bigquery service account create key" width="600" alt="Bigquery service account create key"/> 

9. Select the key type as **P12** and click **Create**. Then the created key will be downloaded.

### Creating Project, Dataset and Table

**Creating Project**

1. Open the BigQuery console.

2. Click **down arrow key** shown in the following image.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-project1.png" title="Bigquery create project step1" width="600" alt="Bigquery create project step1"/> 

3.  Click **New Project**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-project2.png" title="Bigquery create project step2" width="600" alt="Bigquery create project step2"/> 

3.  Enter new project details.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-project3.png" title="Bigquery create project step3" width="600" alt="Bigquery create project step3"/> 

**Creating Dataset**

1. After creating the Project, click the created **project**. You can see the following details. Then click Create **Dataset**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-dataset1.png" title="Bigquery create Dataset step1" width="600" alt="Bigquery create Dataset step1"/> 

2. Enter required Dataset details and click **Create Dataset**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-dataset2.png" title="Bigquery create Dataset step2" width="600" alt="Bigquery create Dataset step2"/> 

**Creating Table**

1. After creating the Dataset, click the created **Dataset**. You can see the following details. Then click **Create Table**.  

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-table1.png" title="Bigquery create Table step1" width="600" alt="Bigquery create Table step1"/> 

2. Enter required Table details and click **Create**.

    <img src="{{base_path}}/assets/img/integrate/connectors/bigquery-create-table2.png" title="Bigquery create Table step2" width="600" alt="Bigquery create Table step2"/> 

For more information about these operations, please refer to the [BigQuery connector reference guide]({{base_path}}/reference/connectors/bigquery-connector/bigquery-connector-reference/).

1. Sign in to the Developer Portal.  
    
     `https://<hostname>:9443/devportal`

2. Click **APIs** and click on the respective API (e.g., `PizzaShackAPI`). Please note that the API Key option should be enabled for the API when deploying the API at the Publisher portal as below.

     [![Enable API Key](../../../../assets/img/learn/api-keys/enable-api-key-option.png)](../../../../assets/img/learn/api-keys/enable-api-key-option.png)

3. Click **Subscriptions**.

4. Select an application and select a throttling policy.

      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>API Keys can work with any application, which is either JWT or OAuth. </p>
      </div> 
     </html>

5. Click **Subscribe**.

     [![Subscribe to the API](../../../../assets/img/learn/subscribe-to-api.png)](../../../../assets/img/learn/subscribe-to-api.png)

6. Click **MANAGE APP**, corresponding to the application that you used to subscribe to the API.

     [![View list of credentials](../../../../assets/img/learn/view-credentials-manage-app.png)](../../../../assets/img/learn/view-credentials-manage-app.png)

7. Go back to **API Keys** from the left menu of the API. 

     [![Generate API Key Left Menu](../../../../assets/img/learn/api-keys/api-api-key-left-menu.png){: style="width:80%"}](../../../../assets/img/learn/api-keys/api-api-key-left-menu.png)

8. Click **Generate API Key**. Provide a Key Name and click **GENERATE API KEY** button.

     [![Generate API key](../../../../assets/img/learn/api-keys/generate-api-api-key.png){: style="width:80%"}](../../../../assets/img/learn/api-keys/generate-api-api-key.png)

9. Optionally, define a validity period for the token.

     By default, the API Key does not expire. However, optionally, you can define a validity period for the token as follows:

    1. When you click **Generate API Key** Select the required validity period option from the drop down.

    2. For the custom validity period, enter the expiry time in **seconds**.
     
10.  Copy the API key.

     [![Copy API key](../../../../assets/img/learn/api-keys/generate-api-api-key-response.png){: style="width:80%"}](../../../../assets/img/learn/api-keys/generate-api-api-key-response.png)

11. Click **Associate** button to associate the created API key to a subscribed application.

     [![Associate API key button](../../../../assets/img/learn/api-keys/associate-api-key-button.png){: style="width:60%"}](../../../../assets/img/learn/api-keys/associate-api-key-button.png)

12. Select an application from the drop down and click **ASSOCIATE**.

     [![Associate API key](../../../../assets/img/learn/api-keys/associate-api-key.png){: style="width:60%"}](../../../../assets/img/learn/api-keys/associate-api-key.png)

13. Additionally, you have the option to associate an application from the subscribed application's API Keys page as below.

     [![Associate API key from App button](../../../../assets/img/learn/api-keys/app-associate-buttopn.png){: style="width:60%"}](../../../../assets/img/learn/api-keys/app-associate-buttopn.png)

14. Select the API and generated API Key for the selected API to associate.

      [![Associate API key from App](../../../../assets/img/learn/api-keys/associate-api-key-from-app.png){: style="width:60%"}](../../../../assets/img/learn/api-keys/associate-api-key-from-app.png)

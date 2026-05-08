
1. Sign in to the Developer Portal.

     `https://<hostname>:9443/devportal`

2. Click **APIs** and click on the respective API (e.g., `PizzaShackAPI`).

3. Click **API Keys** from the left menu of the API.

     [![Generate API Key Left Menu](../../../../assets/img/learn/api-keys/api-api-key-left-menu.png)](../../../../assets/img/learn/api-keys/api-api-key-left-menu.png)

4. Click **Generate API Key** and provide a Key Name.

     [![Generate API key](../../../../assets/img/learn/api-keys/generate-api-api-key.png){: style="width:80%"}](../../../../assets/img/learn/api-keys/generate-api-api-key.png)

5. Optionally, configure the validity period before generating the key.

     By default, the API Key does not expire. To set an expiry, select the required validity period option from the drop-down. For a custom validity period, enter the expiry time in **days**.

6. Click **GENERATE API KEY**.

7. Copy the generated API key.

     [![Copy API key](../../../../assets/img/learn/api-keys/generate-api-api-key-response.png){: style="width:80%"}](../../../../assets/img/learn/api-keys/generate-api-api-key-response.png)

Once the API key is generated, the steps to use it depend on whether the API requires a subscription. Follow the relevant section below.

### For subscription-enabled APIs

A valid subscription must exist and the generated API key must be associated with a subscribed application before it can be used to invoke the API.

1. Click **Subscriptions** from the left menu of the API.

2. Select an application and a throttling policy.

     <html>
     <div class="admonition note">
     <p class="admonition-title">Note</p>
     <p>API Keys can be associated with any application type — JWT or OAuth.</p>
     </div>
     </html>

3. Click **Subscribe**.

     [![Subscribe to the API](../../../../assets/img/learn/subscribe-to-api.png)](../../../../assets/img/learn/subscribe-to-api.png)

4. Click **Associate** on the API key to link it to the subscribed application.

     [![Associate API key button](../../../../assets/img/learn/api-keys/associate-api-key-button.png)](../../../../assets/img/learn/api-keys/associate-api-key-button.png)

5. Select the application from the drop-down and click **ASSOCIATE**.

     [![Associate API key](../../../../assets/img/learn/api-keys/associate-api-key.png){: style="width:80%"}](../../../../assets/img/learn/api-keys/associate-api-key.png)

     Alternatively, you can associate the API key from the subscribed application's **API Keys** page.

     [![Associate API key from App button](../../../../assets/img/learn/api-keys/app-associate-buttopn.png)](../../../../assets/img/learn/api-keys/app-associate-buttopn.png)

     Select the API and the generated API key from the drop-down and associate.

     [![Associate API key from App](../../../../assets/img/learn/api-keys/associate-api-key-from-app.png){: style="width:80%"}](../../../../assets/img/learn/api-keys/associate-api-key-from-app.png)

### For subscriptionless APIs

The generated API key can be used directly to invoke a subscriptionless API without any subscription or application association.

Optionally, you can associate the API key with an application to gain usage insights and analytics. To do so, follow steps 4–5 above.


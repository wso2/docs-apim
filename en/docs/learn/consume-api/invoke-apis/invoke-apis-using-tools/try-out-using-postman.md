# Try out using Postman

Let`s see how to download a Postman collection.

1.  Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`) and click an API (e.g., `Pizza` ) to go to the API overview.

    ![[API overview]({{base_path}}/assets/img/learn/postman_api_overview.png)]({{base_path}}/assets/img/learn/postman_api_overview.png)

2.  Click **Try Out** to go to the Try out section.

    ![[Postman try out]({{base_path}}/assets/img/learn/postman_try_out.png)]({{base_path}}/assets/img/learn/postman_try_out.png)

3.  If you haven't subscribed to this API, you should [Subscribe to an API]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api).

    Then choose the application name and click the `Postman collection` button to download the Postman collection.

    ![[Collection download]({{base_path}}/assets/img/learn/postman_download_collection.png)]({{base_path}}/assets/img/learn/postman_download_collection.png)
    
## Try out collection in postman


1.  As there's a security for the Postman collection, you have to get the authentication code. First go to `Subscriptions`.

2. Then click the `PROD KEYS` to generate an Access Token.

    ![[Subscriptions]({{base_path}}/assets/img/learn/postman_subscriptions.png)]({{base_path}}/assets/img/learn/postman_subscriptions.png)

3. Click on `Generate Access Token` to generate a new token. 

    ![[Generate token]({{base_path}}/assets/img/learn/postman_generate_token.png)]({{base_path}}/assets/img/learn/postman_generate_token.png)
    
4. Click `Generate` in the popup dialog you get.

    ![[Generate dialog]({{base_path}}/assets/img/learn/postman_generate_dialog.png)]({{base_path}}/assets/img/learn/postman_generate_dialog.png)
    
5. **Copy** the access token you generted.

6. Open the Postman application and **Import** the Postman collection file you downloaded.

    ![[Import Postman]({{base_path}}/assets/img/learn/postman_import.png)]({{base_path}}/assets/img/learn/postman_import.png)

7. Select a resource from the Postman collection to test.

8. Click the **Authorization** tab and select `Bearer Token` as the token type.

    ![[Token type]({{base_path}}/assets/img/learn/postman_token_type.png)]({{base_path}}/assets/img/learn/postman_token_type.png)

9. Paste the copied token.

10. Click **Send** to proceed.

    ![[Put token]({{base_path}}/assets/img/learn/postman_put_token.png)]({{base_path}}/assets/img/learn/postman_put_token.png)

11. You can see the result under the `Body` tab.

    ![[Postman result]({{base_path}}/assets/img/learn/postman_result.png)]({{base_path}}/assets/img/learn/postman_result.png)
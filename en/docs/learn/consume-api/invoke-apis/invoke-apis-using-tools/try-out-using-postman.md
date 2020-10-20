# Try out using Postman.

Let`s see how to download a postman collection.

1.  Sign in to the WSO2 Developer Portal (`https://<hostname>:9443/devportal`) and click an API (e.g. `Pizza` ) to go to the API overview.

    ![({{base_path}}/assets/attachments/postman/postman_api_overview.png)]({{base_path}}/assets/attachments/postman/postman_api_overview.png)


2.  Click `Try Out`to go to the Try out section.

    ![({{base_path}}/assets/attachments/postman/postman_try_out.png)]({{base_path}}/assets/attachments/postman/postman_try_out.png)

3.  If you haven`t subscribed to this API, you should [Subscribe to an API]({{base_path}}/learn/consume-api/manage-subscription/subscribe-to-an-api).

    Then choose the application name and click the `postman collection` button to download the postman collection.

    ![({{base_path}}/assets/attachments/postman/postman_download_collection.png)]({{base_path}}/assets/attachments/postman/postman_download_collection.png)
    
## Try out collection in postman.


1.  As there's a security for the postman collection, we have to get the authentication code. First go to `Subscriptions`.

2. Then click the `PROD KEYS` to generate an Access Token.

    ![({{base_path}}/assets/attachments/postman/postman_subscriptions.png)]({{base_path}}/assets/attachments/postman/postman_subscriptions.png)

3. Click on `Generate Access Token` to generate a new token. 

    ![({{base_path}}/assets/attachments/postman/postman_generate_token.png)]({{base_path}}/assets/attachments/postman/postman_generate_token.png)
    
4. Click `Generate` in the popup dialog you get.

    ![({{base_path}}/assets/attachments/postman/postman_generate_dialog.png)]({{base_path}}/assets/attachments/postman/postman_generate_dialog.png)
    
5. **Copy** the access token you generted.

6. Open the postman application and **Import** the postman collection file you downloaded.

    ![({{base_path}}/assets/attachments/postman/postman_import.png)]({{base_path}}/assets/attachments/postman/postman_import.png)

7. Select a resource from the postman collection to test.

8. Click the **Authorization** tab and select `Bearer Token` as the token type.

    ![({{base_path}}/assets/attachments/postman/postman_token_type.png)]({{base_path}}/assets/attachments/postman/postman_token_type.png)

9. Paste the copied token.

10. Press **Send** to proceed.

    ![({{base_path}}/assets/attachments/postman/postman_put_token.png)]({{base_path}}/assets/attachments/postman/postman_put_token.png)

11. You can see the result under the `Body` tab.

    ![({{base_path}}/assets/attachments/postman/postman_result.png)]({{base_path}}/assets/attachments/postman/postman_result.png)
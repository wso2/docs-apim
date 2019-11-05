# Secure APIs with API Keys

An API key is the simplest form of application-based security that you can configure for an API. You can obtain an API key for a client application from WSO2 API Manager's Developer Portal, via the UI, or via REST APIs. Thereafter, the client application can use the API key to invoke the APIs that are secured with the API key security scheme.

WSO2 API Manager uses a self-contained JWT token as the API key, and this JWT token is generated via the Developer Portal without communicating with the Key Manager.

When an API is invoked specifying an API key as the authentication method, the APIM Gateway performs the following two basic validations.

- Signature validation
- Subscription validation

## Prerequisites for API keys

- The API key should be a valid JWT signed using the primary KeyStore private key of the API Store. 

- The expected token format is as follows:

     `base64(header).base64(payload).base64(signature)`

- The public certificate of the private key that is used to sign the tokens should be added to the trust store under the `"gateway_certificate_alias"` alias. For more information, see [Import the public certificate into the client trust store.](#import) 

     <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The latter mentioned prerequisite is not applicable if you use the default certificates, which are the certificates that are shipped with the product itself. </p>
      </div> 
     </html>

## Validation of API subscriptions

The subscription validation is mandatory for the API keys, and the keys generated before an application subscribes to an API will not contain the subscription information under the token details. As a result, these keys will not be allowed to access that specific API. Therefore, API Keys should be generated after the application has subscribed to the required API.

## Using API keys to secure an API

Follow the instructions below to use API key Authentication in WSO2 API Manager.

### Step 1 - Create and publish an API

Create and publish an API that is secured with the API key security scheme as the application-level security. Let's work with the sample app for this purpose.

1. Sign in to the Publisher Portal.  
    
     `https://<hostname>:9443/publisher`

2. Click **DEPLOY SAMPLE APP** to deploy the sample PizzaShack API.

     ![Configure API key authentication](../../../assets/img/Learn/api-key-option.png)

3. Click **Runtime Configurations**.

4. Select **API Key** and click **SAVE**.

### Step 2 - Generate the API Key

1. Click **APIs** and click on the respective API (`PizzaShackAPI`).

2. Click **Credentials**.

3. Select an application and select a throttling policy.

      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>API Keys can work with any application, which is either JWT or OAuth. </p>
      </div> 
     </html>

4. Click **Subscribe**.
     ![Subscribe to the API](../../../assets/img/Learn/subscribe-to-api.png)

5. Click **MANAGE APP**, which corresponds to the application that you used to subscribe to the API.

     ![View list of credentials](../../../assets/img/Learn/view-credentials-manage-app.png)

6. Click **APIKEY** and click **GENERATE KEY**.

     ![Generate API key](../../../assets/img/Learn/generate-api-key.png)

7. Optionally, define a validity period for the token.

     By default, the API Key does not expire. However, optionally, you can define a validity period for the token as follows:

    1. Uncheck **Api Key with infinite validity period**.

    2. Enter the expiry time in seconds.
     
8. Copy the API key.

     ![Copy API key](../../../assets/img/Learn/copy-api-key.png)

### Step 4 - Invoke the API

Invoke the API using the API key. 

You can use any one of the following methods to invoke the API.

- Specify the API Key in the `apikey` header 

     ``` bash tab="Format"
     curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H "accept: application/json" -H "apikey: <API_key_value>"
     ```

     ``` bash tab="Example"
        curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H "accept: application/json" -H "apikey: eyJ4NXQiOiJaalJtWVRNd05USmpPV1U1TW1Jek1qZ3pOREkzWTJJeU1tSXlZMkV6TWpkaFpqVmlNamMwWmc9PSIsImtpZCI6ImdhdGV3YXlfY2VydGlmaWNhdGVfYWxpYXMiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJrYW5jaGFuYSIsImFwcGxpY2F0aW9uIjp7Im93bmVyIjoia2FuY2hhbmEiLCJ0aWVyIjoiVW5saW1pdGVkIiwibmFtZSI6IkRlZmF1bHRBcHBsaWNhdGlvbiIsImlkIjozNSwidXVpZCI6IjFmYjBiYjZlLTNiNWUtNDVmZS04Y2I1LTEwN2QzMGJmOTU0NyJ9LCJ0aWVySW5mbyI6eyJVbmxpbWl0ZWQiOnsic3RvcE9uUXVvdGFSZWFjaCI6dHJ1ZSwic3Bpa2VBcnJlc3RMaW1pdCI6MCwic3Bpa2VBcnJlc3RVbml0IjpudWxsfX0sImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOiJjYXJib24uc3VwZXIiLCJuYW1lIjoiUGl6emFTaGFja0FQSSIsImNvbnRleHQiOiJcL3Bpenphc2hhY2tcLzEuMC4wIiwicHVibGlzaGVyIjoiYWRtaW4iLCJ2ZXJzaW9uIjoiMS4wLjAiLCJzdWJzY3JpcHRpb25UaWVyIjoiVW5saW1pdGVkIn0seyJzdWJzY3JpYmVyVGVuYW50RG9tYWluIjoiY2FyYm9uLnN1cGVyIiwibmFtZSI6IlBpenphU2hhY2tBUEkiLCJjb250ZXh0IjoiXC9waXp6YXNoYWNrXC8xLjAuMCIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEuMC4wIiwic3Vic2NyaXB0aW9uVGllciI6IlVubGltaXRlZCJ9XSwiaWF0IjoxNTcxNzY1Njk2LCJqdGkiOiJhOWVmMDFmYi1kNDA1LTQ0YTYtOWVkMi02ZTdhZjUyZGQ3ODMifQ==.KbxcrZv7buRSqtyI44eCGA_4mrGTRc0-ik4hmsYsmoFs5wbTXrcC1vZ7-fe9KMEWnyW6VeWJq-PnqDZzc4wOno02YMlUH9kGZ6bWj3z4RH9vVLd_xeBV50EXEDm7MbyeI-t7ADMYoOWOBBafNfiigm_86gj7LfeoSkGjsreFIJyhWIxepm3lO54cfYcDJAk3pB-T2bKC0aHJzFn_N_HuBN9lOy2yCPdJyoThQEbedBwtvh8WlTNKh7kL9Nj2E1ZwhKli0M9tuIsp08aztwUP3a-QPF4oIx4Lid0rYIr5jyQCHHor55wtzxJKH2VayZnEFIdySEjQBBj7SAfjcLXvXw=="
     ```

     ``` bash tab="Response"
     [{"name":"BBQ Chicken Bacon","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions in barbeque sauce","price":"24.99","icon":"/images/6.png"},{"name":"Chicken Parmesan","description":"Grilled chicken, fresh tomatoes, feta and mozzarella cheese","price":"11.99","icon":"/images/1.png"},{"name":"Chilly Chicken Cordon Bleu","description":"Spinash Alfredo sauce topped with grilled chicken, ham, onions and mozzarella","price":"23.99","icon":"/images/10.png"},{"name":"Double Bacon 6Cheese","description":"Hickory-smoked bacon, Julienne cut Canadian bacon, Parmesan, mozzarella, Romano, Asiago and and Fontina cheese","price":"20.99","icon":"/images/9.png"},{"name":"Garden Fresh","description":"Slices onions and green peppers, gourmet mushrooms, black olives and ripe Roma tomatoes","price":"11.99","icon":"/images/3.png"},{"name":"Grilled Chicken Club","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions topped with Roma tomatoes","price":"14.99","icon":"/images/8.png"},{"name":"Hawaiian BBQ Chicken","description":"Grilled white chicken, hickory-smoked bacon, barbeque sauce topped with sweet pine-apple","price":"12.99","icon":"/images/7.png"},{"name":"Spicy Italian","description":"Pepperoni and a double portion of spicy Italian sausage","price":"23.99","icon":"/images/2.png"},{"name":"Spinach Alfredo","description":"Rich and creamy blend of spinach and garlic Parmesan with Alfredo sauce","price":"25.99","icon":"/images/5.png"},{"name":"Tuscan Six Cheese","description":"Six cheese blend of mozzarella, Parmesan, Romano, Asiago and Fontina","price":"24.99","icon":"/images/4.png"}]
     ```

- Specify as a query parameter in the API request.

     - `<url_encoded_API_key_value>` - Encode the API key using a URL encoder (e.g., [https://www.urlencoder.org](ttps://www.urlencoder.org)).

     ``` bash tab="Format"
     curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu?apikey=<url_encoded_API_key_value>"
     ```

     ``` bash tab="Example"
     curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu?apikey=eyJ4NXQiOiJaalJtWVRNd05USmpPV1U1TW1Jek1qZ3pOREkzWTJJeU1tSXlZMkV6TWpkaFpqVmlNamMwWmc9PSIsImtpZCI6ImdhdGV3YXlfY2VydGlmaWNhdGVfYWxpYXMiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJrYW5jaGFuYSIsImFwcGxpY2F0aW9uIjp7Im93bmVyIjoia2FuY2hhbmEiLCJ0aWVyIjoiVW5saW1pdGVkIiwibmFtZSI6IkRlZmF1bHRBcHBsaWNhdGlvbiIsImlkIjozNSwidXVpZCI6IjFmYjBiYjZlLTNiNWUtNDVmZS04Y2I1LTEwN2QzMGJmOTU0NyJ9LCJ0aWVySW5mbyI6eyJVbmxpbWl0ZWQiOnsic3RvcE9uUXVvdGFSZWFjaCI6dHJ1ZSwic3Bpa2VBcnJlc3RMaW1pdCI6MCwic3Bpa2VBcnJlc3RVbml0IjpudWxsfX0sImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOiJjYXJib24uc3VwZXIiLCJuYW1lIjoiUGl6emFTaGFja0FQSSIsImNvbnRleHQiOiJcL3Bpenphc2hhY2tcLzEuMC4wIiwicHVibGlzaGVyIjoiYWRtaW4iLCJ2ZXJzaW9uIjoiMS4wLjAiLCJzdWJzY3JpcHRpb25UaWVyIjoiVW5saW1pdGVkIn0seyJzdWJzY3JpYmVyVGVuYW50RG9tYWluIjoiY2FyYm9uLnN1cGVyIiwibmFtZSI6IlBpenphU2hhY2tBUEkiLCJjb250ZXh0IjoiXC9waXp6YXNoYWNrXC8xLjAuMCIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEuMC4wIiwic3Vic2NyaXB0aW9uVGllciI6IlVubGltaXRlZCJ9XSwiaWF0IjoxNTcxNzY1Njk2LCJqdGkiOiJhOWVmMDFmYi1kNDA1LTQ0YTYtOWVkMi02ZTdhZjUyZGQ3ODMifQ%3D%3D.KbxcrZv7buRSqtyI44eCGA_4mrGTRc0-ik4hmsYsmoFs5wbTXrcC1vZ7-fe9KMEWnyW6VeWJq-PnqDZzc4wOno02YMlUH9kGZ6bWj3z4RH9vVLd_xeBV50EXEDm7MbyeI-t7ADMYoOWOBBafNfiigm_86gj7LfeoSkGjsreFIJyhWIxepm3lO54cfYcDJAk3pB-T2bKC0aHJzFn_N_HuBN9lOy2yCPdJyoThQEbedBwtvh8WlTNKh7kL9Nj2E1ZwhKli0M9tuIsp08aztwUP3a-QPF4oIx4Lid0rYIr5jyQCHHor55wtzxJKH2VayZnEFIdySEjQBBj7SAfjcLXvXw%3D%3D"
     ```

     ``` bash tab="Response"
     [{"name":"BBQ Chicken Bacon","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions in barbeque sauce","price":"24.99","icon":"/images/6.png"},{"name":"Chicken Parmesan","description":"Grilled chicken, fresh tomatoes, feta and mozzarella cheese","price":"11.99","icon":"/images/1.png"},{"name":"Chilly Chicken Cordon Bleu","description":"Spinash Alfredo sauce topped with grilled chicken, ham, onions and mozzarella","price":"23.99","icon":"/images/10.png"},{"name":"Double Bacon 6Cheese","description":"Hickory-smoked bacon, Julienne cut Canadian bacon, Parmesan, mozzarella, Romano, Asiago and and Fontina cheese","price":"20.99","icon":"/images/9.png"},{"name":"Garden Fresh","description":"Slices onions and green peppers, gourmet mushrooms, black olives and ripe Roma tomatoes","price":"11.99","icon":"/images/3.png"},{"name":"Grilled Chicken Club","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions topped with Roma tomatoes","price":"14.99","icon":"/images/8.png"},{"name":"Hawaiian BBQ Chicken","description":"Grilled white chicken, hickory-smoked bacon, barbeque sauce topped with sweet pine-apple","price":"12.99","icon":"/images/7.png"},{"name":"Spicy Italian","description":"Pepperoni and a double portion of spicy Italian sausage","price":"23.99","icon":"/images/2.png"},{"name":"Spinach Alfredo","description":"Rich and creamy blend of spinach and garlic Parmesan with Alfredo sauce","price":"25.99","icon":"/images/5.png"},{"name":"Tuscan Six Cheese","description":"Six cheese blend of mozzarella, Parmesan, Romano, Asiago and Fontina","price":"24.99","icon":"/images/4.png"}]
     ```

## Additional Information
<a name="import"></a>

### Importing the public certificate into the client trust store

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Make sure to import the Store certificate to the APIM gateway client-truststore under the same alias. </p>
</div> 
</html>
     
Follow the instructions below to import the public certificate into the client trust store.

1. Navigate to the `<API-M_HOME>/repository/resources/security/` directory.

2. Run the following command to export the public certificate from WSO2 API Manager's key store (`wso2carbon.jks`). 

    `keytool -export -alias wso2carbon -file wso2.crt -keystore wso2carbon.jks`

3. Enter `wso2carbon` as the default password of the key store when prompted.

4. Run the following command to import the public certificate into the trust store. 

     ```
     keytool -import -trustcacerts -keystore client-truststore.jks -alias gateway_certificate_alias -file wso2.crt
     ```

5. Enter `wso2carbon` as the default password of the trust store when prompted.

<a name="alias"></a>

### Changing the alias name in the JWT

By default, the alias name is `gateway_certificate_alias`. Follow the instructions below if you need to change the alias name in the JWT.

1. Navigate to the `<API-M_HOME>/repository/conf/deployment.toml` file.

2. Configure the `api_key_alias` value under `[apim.devportal]` as follows:

     ```
     [apim.devportal]
     api_key_alias = "<alias-name>"
     ```
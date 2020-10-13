# Secure APIs using JWT (Self Contained) Access Tokens

JSON Web Token (JWT) is an open standard of transmitting information securely between two parties. As the tokens are digitally signed, the information is secured. The authentication and authorization process uses JWT access tokens. It is ideal to use JWT access tokens as API credentials because JWT access tokens can carry claims (data) that are used in order to authenticate and authorize requests.

WSO2 API Manager supports the use of self-contained and signed JWT formatted OAuth2.0 access tokens as API credentials. Therefore, you can use JWT formatted OAuth2.0 access tokens to authenticate any API that is secured using the OAuth2 security scheme. The App Developer can create a `JWT` application via the Developer Portal, in WSO2 API Manager, in order to subscribe to an API. These applications uses self-contained signed JWT formatted access tokens.

When an API is invoked using these access tokens, the API Gateway validates the request by itself without communicating to the Key Manager component (in a distributed deployment).

## Prerequisites for JWT based tokens

The following prerequisites have to be satisfied for JWT based tokens to work.

-   Only signed JWT access tokens are allowed.

-   The expected token format is as follows: 

     `base64(header).base64(payload).base64(signature)`

-   The public certificate of the private key that is used to sign the tokens should be added to the trust store under the `"gateway_certificate_alias"` alias. For more information, see [Import the public certificate into the client trust store.](#import)

      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>The latter mentioned prerequisite is not applicable if you use the default certificates, which are the certificates that are shipped with the product itself. </p>
      </div> 
     </html>

## Mandatory attributes of a JWT access token

The following are the mandatory attributes that are required for a JWT access token.

- `Header`
   <table>
      <tbody>
         <tr>
            <td>`alg`</td>
            <td>The algorithm used to sign the token (e.g., RS256).</td>
         </tr>
      </tbody>
   </table>

- `Payload`
   <table>
      <tbody>
         <tr>
            <td>`sub`</td>
            <td>The subject of the token, which identifies as to whom the token refers to.</td>
         </tr>
         <tr>
            <td>`iat`</td>
            <td>The time the token was issued.</td>
         </tr>
         <tr>
            <td>`exp`</td>
            <td>The expiry time of the token.</td>
         </tr>
         <tr>
            <td>`iss`</td>
            <td>The claim identifies the principal that issued the JWT.</td>
         </tr>
      </tbody>
   </table>

## Using JWT access tokens

Follow the instructions below to work with JWT Authentication in WSO2 API Manager.

### Step 1 - Access the Developer Portal

Sign in to the Developer Portal.  
    
`https://<hostname>:9443/devportal`

### Step 2 - Create a JWT access token based application

1. Click **Applications**.

2. Click **ADD NEW APPLICATION**.

     ![Add new application option](../../../../assets/img/learn/add-new-application-option.png)

3. Enter the application details.

     Let's create an application with the following details.

     <html>
     <table>
     <th>Field</th><th>Value</th>
     <tr><td>Application Name</td><td>TestApp</td></tr>
     <tr><td>Per Token Quota</td><td>10PerMin</td></tr>
     <tr><td>Description</td><td>Test App</td></tr>
     </table>
     </html>

     ![Add new Application](../../../../assets/img/learn/add-new-application.png)

### Step 3 - Generate a JWT access token

1. Click **APIs** and click on the PizzaShackAPI.

2. Click **Credentials**.

3. Select the application that you created and select a throttling policy.

4. Click **Subscribe**.
     ![Subscribe to the API](../../../../assets/img/learn/subscribe-to-api.png)

5. Click **PROD KEYS**, which corresponds to the application.

     ![View list of credentials](../../../../assets/img/learn/view-credentials-list.png)

6. Click **GENERATE ACCESS TOKEN**, click **Generate**, and copy the JWT.

### Step 4 - Invoke the API using the JWT access token

Invoking an API with a JWT formatted access token is similar to invoking the API with a regular opaque access token. Use the cURL command below to invoke the API via the API Gateway.

``` bash tab="Format"
curl -k -X GET  "<API_URL>" -H "accept: application/json" -H "Authorization: Bearer <JWT_TOKEN>"
```

``` bash tab="Example"
curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhdXQiOiJBUFBMSUNBVElPTiIsImF1ZCI6IkZ4Sm9kaWFPTTVEclc5WDFiUDR6c0E4Nk0yQWEiLCJuYmYiOjE2MDI1ODEyOTAsImF6cCI6IkZ4Sm9kaWFPTTVEclc5WDFiUDR6c0E4Nk0yQWEiLCJzY29wZSI6ImFtX2FwcGxpY2F0aW9uX3Njb3BlIGRlZmF1bHQiLCJpc3MiOiJodHRwczpcL1wvbG9jYWxob3N0Ojk0NDRcL29hdXRoMlwvdG9rZW4iLCJleHAiOjE2MDI1ODQ4OTAsImlhdCI6MTYwMjU4MTI5MCwianRpIjoiZTRhMzg2ZWQtM2I5OC00OTczLTgzZTAtYjk1NmE0NjZmODI4In0.RnTRzSOwEO0a7JWdwsxz-gajvziM6tZf-mB_u_MDzyZOLKG87qdZe2quyZxD3hI-gxrsszMl8R8pPh3eGWQNq0sy_vX0FAMxwioWg8tGtzFMZSI23IAfHcHoh3mZiwTKWV9i8Br-_AkO_WU-GRk6Xk-4IKKLqSSk9Apj_DamZ2H-xjImMVBH_OfRK4KQbrarmMRXi00iOkZEDENCAbxzJ3WgqzQdCp2vvWc-5D1FBukzYyppIioSybyOhJWqVEA0shugfN4rAOAsY6qkzNIdpX9wq23TMthRNQe_ZQrle0DCg5dVXGb33rcbOO6W9yuxe4vK4-CtYf5qS30vHpnofg"
```

``` bash tab="Response"
[ 
   { 
      "name":"BBQ Chicken Bacon",
      "description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions in barbeque sauce",
      "price":"24.99",
      "icon":"/images/6.png"
   },
   { 
      "name":"Chicken Parmesan",
      "description":"Grilled chicken, fresh tomatoes, feta and mozzarella cheese",
      "price":"27.99",
      "icon":"/images/1.png"
   },
   { 
      "name":"Chilly Chicken Cordon Bleu",
      "description":"Spinash Alfredo sauce topped with grilled chicken, ham, onions and mozzarella",
      "price":"13.99",
      "icon":"/images/10.png"
   },
   { 
      "name":"Double Bacon 6Cheese",
      "description":"Hickory-smoked bacon, Julienne cut Canadian bacon, Parmesan, mozzarella, Romano, Asiago and and Fontina cheese",
      "price":"26.99",
      "icon":"/images/9.png"
   },
   { 
      "name":"Garden Fresh",
      "description":"Slices onions and green peppers, gourmet mushrooms, black olives and ripe Roma tomatoes",
      "price":"18.99",
      "icon":"/images/3.png"
   },
   { 
      "name":"Grilled Chicken Club",
      "description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions topped with Roma tomatoes",
      "price":"11.99",
      "icon":"/images/8.png"
   },
   { 
      "name":"Hawaiian BBQ Chicken",
      "description":"Grilled white chicken, hickory-smoked bacon, barbeque sauce topped with sweet pine-apple",
      "price":"25.99",
      "icon":"/images/7.png"
   },
   { 
      "name":"Spicy Italian",
      "description":"Pepperoni and a double portion of spicy Italian sausage",
      "price":"16.99",
      "icon":"/images/2.png"
   },
   { 
      "name":"Spinach Alfredo",
      "description":"Rich and creamy blend of spinach and garlic Parmesan with Alfredo sauce",
      "price":"22.99",
      "icon":"/images/5.png"
   },
   { 
      "name":"Tuscan Six Cheese",
      "description":"Six cheese blend of mozzarella, Parmesan, Romano, Asiago and Fontina",
      "price":"10.99",
      "icon":"/images/4.png"
   }
]
```

## Additional Information
<a name="import"></a>

### Importing the public certificate into the client trust store
     
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
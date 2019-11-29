# Secure APIs using OAuth2 Opaque(Reference) Access Tokens

An opaque or a reference token is a random and a unique string of characters which has been issued by the token service as an identifier to be used for API authentication purposes. These tokens does not carry any information related to user, hence it is required to open a back channel to the token validation service to validate it and retrieve token information.

## Using OAuth2 Opaque(Reference) Tokens

Follow the instructions below to work with OAuth2 Opaque Authentication in WSO2 API Manager.


### Step 1 - Access the Developer Portal

Sign in to the Developer Portal.  
    
`https://<hostname>:9443/devportal`

### Step 2 - Create an OAuth token-based application

1. Click **Applications**.

2. Click **ADD NEW APPLICATION**.

      <a href="../../../../../assets/img/Learn/add-new-application-option.png" ><img src="../../../../../assets/img/Learn/add-new-application-option.png" alt="Add new application option" title="Add new application option" width="70%" /></a>

3. Enter the application details.

     Let's create an application with the following details.

     <html>
     <table>
     <th>Field</th><th>Value</th>
     <tr><td>Application Name</td><td>TestApp</td></tr>
     <tr><td>Per Token Quota</td><td>10PerMin</td></tr>
     <tr><td>Token Type</td><td>OAUTH</td></tr>
     <tr><td>Description</td><td>Test App</td></tr>
     </table>
     </html>

     <a href="../../../../../assets/img/Learn/create-oauth-application.png" ><img src="../../../../../assets/img/Learn/create-oauth-application.png" alt="Add oauth application" title="Add oauth application" width="70%" /></a>

### Step 3 - Generate a OAuth2 Reference token

1. Click **APIs** and click on the PizzaShackAPI.

2. Click **Credentials**.

3. Select the OAuth Opaque token-based application that you created and select a throttling policy.

4. Click **Subscribe**.

    <a href="../../../../../assets/img/Learn/subscribe-to-api.png" ><img src="../../../../../assets/img/Learn/subscribe-to-api.png" alt="Subscribe" title="Subscribe" width="70%" /></a>

5. Click **PROD KEYS**, which corresponds to the OAuth Opaque token-based application.

     <a href="../../../../../assets/img/Learn/view-credentials-list.png" ><img src="../../../../../assets/img/Learn/view-credentials-list.png" alt="View Credentials" title="View Credentials" width="70%" /></a>

6. Click **Generate** to generate keys and access token.

      <a href="../../../../../assets/img/Learn/opaque-access-token.png" ><img src="../../../../../assets/img/Learn/opaque-access-token.png" alt="Generate Tokens" title="Generate Tokens" width="70%" /></a>

### Step 4 - Invoke the API using the OAuth Access Token

   Use the cURL command below to invoke the API via the API Gateway.

``` bash tab="Format"
curl -k -X GET  "<API_URL>" -H "accept: application/json" -H "Authorization: Bearer <Opaque_Token>"
```

``` bash tab="Example"
curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H "accept: application/json" -H "Authorization: Bearer 16b28458-ba6a-33df-ae6b-ff7552c1e315"
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

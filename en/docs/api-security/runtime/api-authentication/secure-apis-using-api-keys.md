# Secure APIs with API Keys

From WSO2 API Manager 4.7.0 onwards, you can secure APIs using **API-bound API keys** - opaque tokens that are scoped to a single API. Unlike traditional application-bound keys that can be reused across multiple APIs, an API key bounded to an API is valid only for the specific API it was generated for.

API keys are generated directly from the Developer Portal without communicating with the Key Manager, making them lightweight and straightforward to issue and manage.

## Key Characteristics of API Keys

- API-specific – The key is linked to one API.
- Limited scope – It cannot be used to call other APIs.
- Security control – Reduces misuse because the key works only with the assigned API.
- Simpler authorization – The gateway validates that the key is mapped to the requested API along with the IP and referred restrictions. Additionally, it does subscription validation for the subscription enabled APIs.
- Subscriptionless API support – For APIs that do not require a subscription, an API key can be used to invoke the API without a subscription or any application association. Optionally, the key can be associated with an application to gain usage insights and analytics.
- Environment scoping – When generating an API key, you can specify whether it is for the **Production** or **Sandbox** environment, allowing you to use separate keys for testing and production traffic.

When an API is invoked specifying an API key as the authentication method, the APIM Gateway performs the following basic validations.

- Subscription validation
- IP and referrer validation

## Using API keys to secure an API

Follow the instructions below to use API key Authentication in WSO2 API Manager.

### Step 1 - Create and publish an API

Create, publish and deploy an API that is secured with the API key security scheme as the application-level security. Let's work with the sample app for this purpose.

{!includes/design/create-publish-api.md!}

### Step 2 - Generate the API Key

{!includes/design/generate-api-key.md!}

### Step 3 - Invoke the API

Invoke the API using the API key. You can use either of the following methods to invoke the API.

- Specify the API Key in the `apikey` header.

    === "Format"
          ``` bash
          curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H "accept: application/json" -H "apikey: <API_key_value>"
          ```

    === "Example"
          ``` bash
          curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu" -H "accept: application/json" -H "apikey: lTiFQrRvNBOkVShNrKG13VhuXoZ2EfgJ_qU529RyXB8"
          ```

    === "Response"
          ``` bash
          [{"name":"BBQ Chicken Bacon","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions in barbeque sauce","price":"24.99","icon":"/images/6.png"},{"name":"Chicken Parmesan","description":"Grilled chicken, fresh tomatoes, feta and mozzarella cheese","price":"11.99","icon":"/images/1.png"},{"name":"Chilly Chicken Cordon Bleu","description":"Spinash Alfredo sauce topped with grilled chicken, ham, onions and mozzarella","price":"23.99","icon":"/images/10.png"},{"name":"Double Bacon 6Cheese","description":"Hickory-smoked bacon, Julienne cut Canadian bacon, Parmesan, mozzarella, Romano, Asiago and and Fontina cheese","price":"20.99","icon":"/images/9.png"},{"name":"Garden Fresh","description":"Slices onions and green peppers, gourmet mushrooms, black olives and ripe Roma tomatoes","price":"11.99","icon":"/images/3.png"},{"name":"Grilled Chicken Club","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions topped with Roma tomatoes","price":"14.99","icon":"/images/8.png"},{"name":"Hawaiian BBQ Chicken","description":"Grilled white chicken, hickory-smoked bacon, barbeque sauce topped with sweet pine-apple","price":"12.99","icon":"/images/7.png"},{"name":"Spicy Italian","description":"Pepperoni and a double portion of spicy Italian sausage","price":"23.99","icon":"/images/2.png"},{"name":"Spinach Alfredo","description":"Rich and creamy blend of spinach and garlic Parmesan with Alfredo sauce","price":"25.99","icon":"/images/5.png"},{"name":"Tuscan Six Cheese","description":"Six cheese blend of mozzarella, Parmesan, Romano, Asiago and Fontina","price":"24.99","icon":"/images/4.png"}]
          ```

- Specify as a query parameter in the API request.

    - `<url_encoded_API_key_value>` - Encode the API key using a URL encoder (e.g., [https://www.urlencoder.org](https://www.urlencoder.org)).

    === "Format"
          ``` bash
          curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu?apikey=<url_encoded_API_key_value>"
          ```

    === "Example"
          ``` bash
          curl -k -X GET "https://localhost:8243/pizzashack/1.0.0/menu?apikey=lTiFQrRvNBOkVShNrKG13VhuXoZ2EfgJ_qU529RyXB8"
          ```

    === "Response"
          ``` bash
          [{"name":"BBQ Chicken Bacon","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions in barbeque sauce","price":"24.99","icon":"/images/6.png"},{"name":"Chicken Parmesan","description":"Grilled chicken, fresh tomatoes, feta and mozzarella cheese","price":"11.99","icon":"/images/1.png"},{"name":"Chilly Chicken Cordon Bleu","description":"Spinash Alfredo sauce topped with grilled chicken, ham, onions and mozzarella","price":"23.99","icon":"/images/10.png"},{"name":"Double Bacon 6Cheese","description":"Hickory-smoked bacon, Julienne cut Canadian bacon, Parmesan, mozzarella, Romano, Asiago and and Fontina cheese","price":"20.99","icon":"/images/9.png"},{"name":"Garden Fresh","description":"Slices onions and green peppers, gourmet mushrooms, black olives and ripe Roma tomatoes","price":"11.99","icon":"/images/3.png"},{"name":"Grilled Chicken Club","description":"Grilled white chicken, hickory-smoked bacon and fresh sliced onions topped with Roma tomatoes","price":"14.99","icon":"/images/8.png"},{"name":"Hawaiian BBQ Chicken","description":"Grilled white chicken, hickory-smoked bacon, barbeque sauce topped with sweet pine-apple","price":"12.99","icon":"/images/7.png"},{"name":"Spicy Italian","description":"Pepperoni and a double portion of spicy Italian sausage","price":"23.99","icon":"/images/2.png"},{"name":"Spinach Alfredo","description":"Rich and creamy blend of spinach and garlic Parmesan with Alfredo sauce","price":"25.99","icon":"/images/5.png"},{"name":"Tuscan Six Cheese","description":"Six cheese blend of mozzarella, Parmesan, Romano, Asiago and Fontina","price":"24.99","icon":"/images/4.png"}]
          ```

## Regenerating an API Key

You can regenerate API Keys from the **API Keys** section of the API in the Developer Portal. When you regenerate a key, the existing key is immediately revoked and a new opaque token is issued in its place. The existing application association is preserved - you do not need to re-associate the key with the application after regeneration. Update your client application with the new key value to resume API invocations.

   [![Regenerate API Key]({{base_path}}/assets/img/learn/api-keys/regenerate-apikey.png)]({{base_path}}/assets/img/learn/api-keys/regenerate-apikey.png)

## Revoking an API Key

Once an API key is revoked, it is immediately invalidated and any API calls using that key will be rejected. API keys can be revoked in two ways.

### Revoking via the Developer Portal

An API key can be revoked by the API consumer from the **API Keys** section of the API in the Developer Portal.

   [![Revoke API Key from Devportal]({{base_path}}/assets/img/learn/api-keys/revoke-apikey-consumer.png)]({{base_path}}/assets/img/learn/api-keys/revoke-apikey-consumer.png)

### Revoking via the Admin Portal

Administrators can revoke API keys via the Admin Portal. This allows centrally managing and invalidating keys across all APIs and applications without requiring Developer Portal access.

   [![Revoke API Key from Admin]({{base_path}}/assets/img/learn/api-keys/revoke-apikey-admin.png)]({{base_path}}/assets/img/learn/api-keys/revoke-apikey-admin.png)

## API key security restrictions for IP address and HTTP referrer

After issuing an API key for an API or an application, it can be used by anyone to invoke an API subscribed to an associated application. However, if an unauthorized party gets hold of the token, they can create unnecessary invocations to the APIs. To prevent this issue, you can define the authorized parties when generating a token. 

WSO2 API Manager allows API keys to be restricted based on two approaches.

### IP address restriction

The IP address restriction allows only the clients with specific IP addresses to use the token. The IP addresses can be specified
in the following formats.

- IPv4 (e.g., `192.168.1.2`)
- IPv6 (e.g., `2002:eb8::2`)
- IP range in CIDR notation (e.g. `152.12.0.0/13`, `1001:ab8::/14`)

**Generating an API key with an IP restriction**

1. Navigate to API-bound or Application-bound key generation window of the specific API or application in the Developer Portal.

2. Select `Preferred IP` option, add the IP addresses in the text input as shown below, and generate the key.

   [![IP Restricted API key]({{base_path}}/assets/img/learn/api-keys/ip-restrictions.png){: style="width:80%"}]({{base_path}}/assets/img/learn/api-keys/ip-restrictions.png)

### HTTP referrer restriction

When the HTTP referrer restriction has been enabled, only the specific HTTP referrers can use the token. Therefore, by using this restriction, when API clients run on web browsers, you can limit the access to an API through only specific web pages. The referrer can be specified in the following formats.

- A specific URL with an exact path: `www.example.com/path`
- Any URL in a single subdomain, using a wildcard asterisk (*): `sub.example.com/*`
- Any subdomain or path URLs in a single domain, using wildcard asterisks (\*): `*.example.com/*`

**Generating an API key with the HTTP referrer restriction**

1. Navigate to API key generation window of that specific API or application in the Developer Portal.

2. Select `Preferred Referrer` option and add the referrers in the text input as shown below and generate the key.

   [![HTTP Referer Restricted API key]({{base_path}}/assets/img/learn/api-keys/referrer-restrictions.png){: style="width:80%"}]({{base_path}}/assets/img/learn/api-keys/referrer-restrictions.png)

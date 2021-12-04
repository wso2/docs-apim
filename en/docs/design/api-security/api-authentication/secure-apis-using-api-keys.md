# Secure APIs with API Keys

An API key is the simplest form of application-based security that you can configure for an API. You can obtain an API key for a client application from WSO2 API Manager's Developer Portal, via the UI, or via REST APIs. Thereafter, the client application can use the API key to invoke the APIs that are secured with the API key security scheme.

WSO2 API Manager uses a self-contained JSON Web Token (JWT) as the API key, and this JWT access token is generated via the Developer Portal without communicating with the Key Manager.

When an API is invoked specifying an API key as the authentication method, the APIM Gateway performs the following two basic validations.

- Signature validation
- Subscription validation

## Prerequisites for API keys

- The API key should be a valid JWT signed using the primary KeyStore private key of the Developer Portal. 

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

Create, publish and deploy an API that is secured with the API key security scheme as the application-level security. Let's work with the sample app for this purpose.

{!includes/design/create-publish-api.md!}

### Step 2 - Generate the API Key

{!includes/design/generate-api-key.md!}

### Step 3 - Invoke the API

{!includes/design/invoke-api-key.md!}

## Additional Information
<a name="import"></a>

### Importing the public certificate into the client trust store

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Make sure to import the Developer Portal certificate to the APIM Gateway client-truststore under the same alias. </p>
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

### API key restriction for IP address and HTTP referrer

After issuing an API key for an application, it can be used by anyone to invoke an API subscribed to the application. However, if an unauthorized party gets hold of the token, they can create unnecessary invocations to the APIs. To prevent this issue, you can define the authorized parties when generating a token. 

WSO2 API Manager allows API keys to be restricted based on two approaches.

{!includes/design/additional-api-key.md!}

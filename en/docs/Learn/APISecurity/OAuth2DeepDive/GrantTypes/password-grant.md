# dup\_Password Grant

You can obtain an access token by providing the resource owner's username and password as an authorization grant. It requires the base64 encoded string of the `consumer-key:consumer-secret` combination. You need to meet the following prerequisites before using the Token API to generate a token.

#### Prerequisites

-   A valid user account in the API Store. You can self sign up if it is [enabled by an admin](https://docs.wso2.com/display/AM260/Customizing+the+API+Store#CustomizingtheAPIStore-Enablingselfsign-up) .
-   A valid consumer key and consumer secret pair. Initially, these keys must be generated through the API Store by clicking **Generate Keys** on the **Production Keys** tab of the application.
-   A running API Gateway instance (typically an API Manager instance should be running). For instructions on API Gateway, see [Components](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-APIManagercomponents) .

-   If the Key Manager is on a different server than the API Gateway, change the server URL (host and ports) of the Key Manager accordingly in the `<APIKeyManager><ServerURL>` element of the `<AM_HOME>/repository/conf/api-manager.xml` file.
-   If you have multiple Carbon servers running on the same computer, [change the port with an offset](https://docs.wso2.com/display/AM260/Changing+the+Default+Ports+with+Offset) to avoid port conflicts.

#### Invoking the Token API to generate tokens

1.  Combine the consumer key and consumer secret keys in the format **consumer-key:consumer-secret** and encode the combined string using base64. Encoding to base64 can be done using the URL: [http://base64encode.org](http://base64encode.org/) .

    Here's an example consumer key and secret combination: `wU62DjlyDBnq87GlBwplfqvmAbAa:ksdSdoefDDP7wpaElfqvmjDue` . And here's the string encoded from the example: `d1U2MkRqbHlEQm5xODdHbEJ3cGxmcXZtQWJBYTprc2RTZG9lZkREUDd3cGFFbGZxdm1qRHVl` .The encoded string should be used in the header of the cURL command.

2.  Access the Token API by using a REST client such as cURL, with the following parameters.

    -   Assuming that both the client and the API Gateway are run on the same server, the token API url is [https://localhost:8243/token](https://localhost:8243/login)
    -   payload - `"grant_type=password&username=<username>&password=<password>&scope=<scope>"` . Replace the `<username>` and `<password>` values as appropriate.

                !!! tip
        **Tip:** `<scope>` is optional.

        If you define a **scope** for an API's resource, the API can only be accessed through a token that is issued for the scope of the said resource. For example, if you define a scope named 'update' and issue one token for the scopes 'read' and 'update', the token is allowed to access the resource. However, if you issue the token for the scope named 'read', the request to the API will be blocked.


    -   headers - `Authorization: Basic <base64 encoded string>, Content-Type: application/x-www-form-urlencoded` . Replace the `<base64 encoded string>` as appropriate.

    For example, use the following cURL command to access the Token API. It generates two tokens as an access token and a refresh token. You can use the refresh token at the time a token is renewed .

    ``` java
        curl -k -d "grant_type=password&username=<username>&password=<password>" -H "Authorization: Basic d1U2MkRqbHlEQm5xODdHbEJ3cGxmcXZtQWJBYTprc2RTZG9lZkREUDd3cGFFbGZxdm1qRHVl" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
    ```

    You receive a response similar to the following:

    ``` java
            Response:
            {
                "scope":"default",
                "token_type":"Bearer",
                "expires_in":3600,
                "refresh_token":"ca5a51f18b2edf4eaa9e4b871e42b58a",
                "access_token":"f2c66f146278aaaf6513b585b5b68d1d"
            }
    ```

Instead of using the Token API, you can generate access tokens from the API Store's UI.

!!! note
Note that for users to be counted in the [Registered Users for Application statistics](https://docs.wso2.com/display/AM260/Viewing+API+Statistics#ViewingAPIStatistics-topUsers) which takes the number of users shared each of the Application, they should have to generate access tokens using [Password Grant](https://docs.wso2.com/display/AM210/Password+Grant) type.



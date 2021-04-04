# Password Grant

You can obtain an access token by providing the resource owner's username and password as an authorization grant. It requires the base64 encoded string of the `consumer-key:consumer-secret` combination. You need to meet the following prerequisites before using the Token API to generate a token.

The resource owner password credentials grant type is suitable in cases where the resource owner has a trust relationship with the client (e.g., a service’s own mobile client) and in situations where the client can obtain the resource owner’s credentials.

#### The flow

Instead of redirecting the user to the authorization server, the client itself will ask the user for the resource owner's username and password. The client will then send these credentials to the authorization server along with the client’s own credentials.

The diagram below illustrates the resource owner password credentials grant flow.

![]({{base_path}}/assets/img/learn/oauth-resource-owner-diagram.png)

#### Prerequisites

-   A valid user account in the API Developer Portal. You can self sign up if it is [enabled by an admin]({{base_path}}/consume/customizations/customizing-the-developer-portal/enabling-or-disabling-self-signup/).
-   A valid consumer key and consumer secret pair. Initially, these keys must be generated through the API Developer Portal by clicking **GENERATE KEYS** on the **Production Keys** tab of the application.
-   A running API Gateway instance (typically an API Manager instance should be running). For instructions on API Gateway, see [Components]({{base_path}}/getting-started/basic-architecture/#api-gateway).

-   If the Key Manager is on a different server than the API Gateway, change the server URL (host and ports) of the Key Manager accordingly by adding following configuration in `<APIM_HOME>/repository/conf/deployment.toml` file.

``` java
[apim.key_manager]
configuration.ServerURL = "<key-manager-server-url>"

```
If you have multiple Carbon servers running on the same computer, [change the port with an offset]({{base_path}}/install-and-setup/deploying-wso2-api-manager/changing-the-default-ports-with-offset/#changing-the-default-ports-with-offset) to avoid port conflicts.

#### Invoking the Token API to generate tokens

1.  Combine the consumer key and consumer secret keys in the format **consumer-key:consumer-secret** and encode the combined string using base64. Encoding to base64 can be done using the URL: [http://base64encode.org](http://base64encode.org/) .

    Here's an example consumer key and secret combination:     
    ```
        wU62DjlyDBnq87GlBwplfqvmAbAa:ksdSdoefDDP7wpaElfqvmjDue
    ```
    
    And here's the string encoded from the example:    

    ```
        d1U2MkRqbHlEQm5xODdHbEJ3cGxmcXZtQWJBYTprc2RTZG9lZkREUDd3cGFFbGZxdm1qRHVl
    ```
    
    The encoded string should be used in the header of the cURL command.

2.  Access the Token API by using a REST client such as cURL, with the following parameters.

    -   Assuming that both the client and the API Gateway are running on same server, the token API url is [https://localhost:8243/token](https://localhost:8243/login)
    -   payload - `"grant_type=password&username=<username>&password=<password>&scope=<scope>"`. Replace the `<username>` and `<password>` values as appropriate.

        !!! tip
            **`<scope>` is optional.**
    
            If you define a [scope]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/) for an API's resource, the API can only be accessed through a token that is issued for the scope of the said resource. For example, if you define a scope named 'update' and issue one token for the scopes 'read' and 'update', the token is allowed to access the resource. However, if you issue the token for the scope named 'read', the request to the API will be blocked.


    -   Headers 

        <table>
        <colgroup>
        <col style="width: 11%" />
        <col style="width: 70%" />
        </colgroup>
        <thead>
        <tr class="header">
        <th>Header</th>
        <th>Value</th>
        </tr>
        </thead>
        <tbody>
        <tr class="odd">
        <td>Authorization</td>
        <td><code>Basic &lt;base64encode(clientId:clientSecret)></code></td>
        </tr>
        <tr class="even">
        <td>Content-Type</td>
        <td><code>application/x-www-form-urlencoded</code></td>
        </tr>
        </tbody>
        </table>

    Replace the `<base64encode(clientId:clientSecret)>` as appropriate.

    For example, use the following cURL command to access the Token API. It generates two tokens as an access token and a refresh token. You can use the refresh token at the time a token is renewed. Replace the `<username>` and `<password>` as appropriate.

    ``` java tab="Format"
    curl -k -d "grant_type=password&username=<username>&password=<password>" -H "Authorization: Basic EncodeToBase64(consumer-key:consumer-secret)" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
    ```
    
    ``` java tab="Example"
    curl -k -d "grant_type=password&username=admin&password=admin" -H "Authorization: Basic d1U2MkRqbHlEQm5xODdHbEJ3cGxmcXZtQWJBYTprc2RTZG9lZkREUDd3cGFFbGZxdm1qRHVl" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
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

Instead of using the Token API, you can generate access tokens from the API Developer Portal's UI.

!!! tip
    If you want to disable the **Password grant type** in the APIM instance, add the following entry to the `deployment.toml` file in the `<APIM_HOME>/repository/conf/` folder.

    ``` toml
    [oauth.grant_type.password]
    enable = false
    ```

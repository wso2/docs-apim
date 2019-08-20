# dup\_Authorization Code Grant

Instead of requesting authorization directly from the resource owner (resource owner's credentials), in this grant type, the client directs the resource owner to an authorization server. The authorization server works as an intermediary between the client and resource owner to issues an authorization code, authenticate the resource owner and obtain authorization. As this is a redirection-based flow, the client must be capable of interacting with the resource owner's user-agent (typically a Web browser) and receiving incoming requests (via redirection) from the authorization server.

The client initiates the flow by directing the resource owner's user-agent to the authorization endpoint (you can use the `         /authorize        ` endpoint for the authorization code grant type of OAuth 2.0). It includes the client identifier, response\_type, requested scope, and a redirection URI to which the authorization server sends the user-agent back after granting access. The authorization server authenticates the resource owner (via the user-agent) and establishes whether the resource owner granted or denied the client's access request. Assuming the resource owner grants access, the authorization server then redirects the user-agent back to the client using the redirection URI provided earlier. The redirection URI includes an authorization code.

The client then requests an access token from the authorization server's `         /token        ` endpoint by including the authorization code received in the previous step. When making the request, the client authenticates with the authorization server. It then includes the redirection URI used to obtain the authorization code for verification. The authorization server authenticates the client, validates the authorization code, and ensures that the redirection URI matches the URI used to redirect the client from the /authorize endpoint in the previous response. If valid, the authorization server responds back with an access token and, optionally, a refresh token.

#### Invoking the Token API to generate tokens

Assuming that both the client and the API Gateway are run on the same server, the Authorization API URL is `                   https://localhost:8243/authorize                  .        `

-   query component: `          response_type=code&client_id=<consumer_key>&scope=PRODUCTION&redirect_uri=<application_callback_url>         `
-   headers: `          Content-Type: application/x-www-form-urlencoded         `

For example, the client directs the user-agent to make the following HTTP request using TLS.

``` java
    GET
    /authorize?response_type=code&client_id=wU62DjlyDBnq87GlBwplfqvmAbAa&scope=PRODUCTION&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb
    HTTP/1.1 
    Host: server.example.com 
    Content-Type:
    application/x-www-form-urlencoded 
```

The authorization server redirects the user-agent by sending the following HTTP response:

``` java
    HTTP/1.1 302 Found 
    Location:
    https://client.example.com/cb?code=SplxlOBeZQQYbYS6WxSbIA
```

Now the client makes the following HTTP request using TLS to the `         /token        ` endpoint.

``` java
    POST /token HTTP/1.1 
    Host: server.example.com 
    Authorization: Basic
    SVpzSWk2SERiQjVlOFZLZFpBblVpX2ZaM2Y4YTpHbTBiSjZvV1Y4ZkM1T1FMTGxDNmpzbEFDVzhh
    Content-Type:
    application/x-www-form-urlencoded 
    grant_type=authorization_code&code=SplxlOBeZQQYbYS6WxSbIA&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb
```

The `         /token        ` endpoint responds in the same way like in password grant type.

Note that if you are using a separate server for authentication (e.g., a distributed API Manager setup or an instance of WSO2 Identity Server as the authentication server), be sure to give the full URL of the authentication server in the `         <APIM_HOME>/repository/conf/identity/application-authentication.xml        ` file. The default configuration has a relative path, which works in a standalone API Manager setup:

``` xml
    <AuthenticationEndpointURL>/authenticationendpoint/login.do</AuthenticationEndpointURL>
    <AuthenticationEndpointRetryURL>/authenticationendpoint/retry.do</AuthenticationEndpointRetryURL>
```

### Try Authorization Code Grant

The steps below show how access tokens are generated for the authorization code grant type.

!!! note
Before you begin,

The following instructions use the sample playground webapp. For instructions on how to set up the sample webapp, see [Setting up the Sample Webapp](https://docs.wso2.com/display/IS530/Setting+Up+the+Sample+Webapp) .


1.  Log in to the API Manager Store and create a new application.
    ![](attachments/126561109/126561118.png)2.  Go to the **Production Keys** tab.
3.  Add the Callback URL of your playground app, select **Code** Grant type click **Generate Keys** .

        !!! note
    By default the implicit and code grant type selection checkboxes are disabled in the UI. You need to enter the callback URL first to enable selecting the code grant type.


    ![](attachments/126561109/126561110.png)
4.  Go to the playground app and click Import Photos.
    ![](attachments/126561109/126561115.png)5.  Give the information in the table below and click **Authorize** .

    | Field                    | Sample Value                                                                                          |
    |--------------------------|-------------------------------------------------------------------------------------------------------|
    | Authorization Grant Type | Authorization Code                                                                                    |
    | Client Id                | Consumer Key obtained for your application                                                            |
    | Scope                    | The scope you have selected for you application                                                       |
    | Callback URL             | The callback URL of your application                                                                  |
    | Authorize Endpoint       | `                               https://localhost:9443/oauth2/authorize                             ` |

    ![](attachments/126561109/126561114.png)
6.  The playground application redirects to the login page. Enter you username and password and click **Sign In.**
    ![](attachments/126561109/126561113.png)7.  Click Approve to provide access to your information.
    ![](attachments/126561109/126561112.png)    You will receive the access token as follows
    ![](attachments/126561109/126561111.png)
        !!! note
    Note that for users to be counted in the [Registered Users for Application statistics](https://docs.wso2.com/display/AM260/Viewing+API+Statistics#ViewingAPIStatistics-topUsers) which takes the number of users shared each of the Application, they should have to generate access tokens using [Password Grant](_Password_Grant_) type.




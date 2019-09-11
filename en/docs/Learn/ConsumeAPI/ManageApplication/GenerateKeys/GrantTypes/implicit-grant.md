# Implicit Grant

Implicit grant type is used to obtain access tokens if your application (client) is a mobile application or a browser based app such as a JavaScript client. Similar to authorization code grant, the implicit grant type is also based on redirection flow. The redirection URI includes the access token in the URI fragment. Therefore, the client application is capable of interacting with the resource owner user agent to obtain the access token from the redirection URI which is sent from the authorization server.

The implicit grant type does not require client authentication, and relies on the presence of the resource owner and the registration of the redirection URI. The resource owner is authenticated by the authorization server to obtain the access token. The access token is encoded into the redirection URI. This may be exposed to the resource owner and other applications residing inside the same device.

The diagram below depicts the flow of Implicit Grant.

![](https://lh6.googleusercontent.com/QOxOfpBsDRBFJhArtbY_nHSCPDxcT_o9_ggjNV4ztf46HDDtJidzjAuWGxjQK8zg4yPYtmWIKvF0AZaxm9p-pQRi_GF1NuUvWw6yCPJbvDAP9xA2tVJ8xJ1zzVJ-d-zoIyjjzk4o)
1.  The client requests for the access token with the client ID and grant type, and other optional parameters.

2.  Since the resource owner authenticates directly with the authorization server, their credentials will not be shared with the client.

3.  The Authorization Server sends the access token through a URI fragment to the client.

4.  The client extracts the token from the fragment and sends the API request to the Resource Server with the access token.

!!! note
The refresh token will not be issued for the client with this grant, as the client type is public. Also note that, the Implicit grant does not include client authentication use the client secret of the application


The following parameters are required to implement the Implicit grant type in WSO2 API Manager.

| Name                                     | Description                                                 | Sample value                                                                                         |
|------------------------------------------|-------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| `scope`| The OAuth scope you are requesting for the particular token | `openid`|
| `response_type` | The required response format                                | `id_token`|
| `redirect_uri`| The URL of the Oauth application requesting for the token   | `http://localhost:8080/playground2/oauth2client` |
| `nonce`| Any random value                                            | `13e2312637dg136e1`|
| `client_id`| Client ID of the OAuth application                          | `mzdQQ0RZOIqAf549ucIImB4h0SIa`|

An example is given below :

``` java
    https://localhost:8243/authorize
    scope=openid
    &response_type=id_token
    &redirect_uri=http://localhost:8080/playground2/oauth2client
    &nonce=13e2312637dg136e1
    &client_id=mzdQQ0RZOIqAf549ucIImB4h0SIa
```

#### Invoking the Token API to generate tokens

In this example we use the WSO2 Playground, which is hosted as a web application, to obtain the access token with implicit grant.

!!! note
Before you begin,

The following instructions use the sample playground webapp. For instructions on how to set up the sample webapp, see [Setting up the Sample Webapp](https://docs.wso2.com/display/IS530/Setting+Up+the+Sample+Webapp) .


1.  Login to WSO2 API Manager Store and create an application as shown below.
    ![](attachments/103335293/103335295.png)2.  Go to the **Production keys** tab for the application. Add <http://localhost:8080/playground2/oauth2client> as the **Callback URL.** Select **Implicit** from the list of grant types and click **Generate Keys** .

        !!! note
    The Implicit grant and Code grant type checkboxes are disabled by default in the UI. To enable selecting the checkboxes, enter the Callback URL for the application.


    ![](attachments/103335293/103335296.png)
3.  Go to playground app <http://wso2is.local:8080/playground2/index.jsp> and click **import photos.**
    **![](attachments/103335293/103335297.png)    **
4.  Give the information in the table below and click **Authorize** .

    | Field                    | Sample Value                                                                                   |
    |--------------------------|------------------------------------------------------------------------------------------------|
    | Authorization Grant Type | Implicit                                                                                       |
    | Client Id                | Consumer Key obtained for your application                                                     |
    | Scope                    | The scope you have selected for you application                                                |
    | Callback URL             | The callback URL of your application                                                           |
    | Authorize Endpoint       | `https://localhost:8243/authorize` |

    ![](attachments/103335293/103335294.png)
5.  The playground application redirects to the login page. Enter you username and password and click **Sign In.**

    ![](attachments/103335293/103335300.png)
6.  Click Approve to provide access to your information.

    ![](attachments/103335293/103335298.png)
7.  You will receive the access token as follows

    ![access-token.png](attachments/57743277/61047220.png)
!!! note
For users to be counted in the [Registered Users for Application statistics](https://docs.wso2.com/display/AM220/Viewing+API+Statistics#ViewingAPIStatistics-topUsers) , which takes the number of users shared each of the Application, they have to generate access tokens using [Password Grant](https://docs.wso2.com/display/AM210/Password+Grant) type.



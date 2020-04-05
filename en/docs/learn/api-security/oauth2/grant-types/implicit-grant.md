# Implicit Grant

Implicit grant type is used to obtain access tokens if your application (client) is a mobile application or a browser based app such as a JavaScript client. Similar to authorization code grant, the implicit grant type is also based on redirection flow. The redirection URI includes the access token in the URI fragment. Therefore, the client application is capable of interacting with the resource owner user agent to obtain the access token from the redirection URI which is sent from the authorization server.

#### Flow

The implicit grant type does not require client authentication, and relies on the presence of the resource owner and the registration of the redirection URI. The resource owner is authenticated by the authorization server to obtain the access token. The access token is encoded into the redirection URI. This may be exposed to the resource owner and other applications residing inside the same device.

The diagram below depicts the flow of Implicit Grant :

![]({{base_path}}/assets/img/learn/oauth-implicit-grant-diagram.png)

1.  The client requests for the access token with the client ID and grant type, and other optional parameters.

2.  Since the resource owner authenticates directly with the authorization server, their credentials will not be shared with the client.

3.  The Authorization Server sends the access token through a URI fragment to the client.

4.  The client extracts the token from the fragment and sends the API request to the Resource Server with the access token.

!!! note
    The refresh token will not be issued for the client with this grant, as the client type is public. Also note that, Implicit grant does not include client authentication using client secret of the application


The following parameters are required to implement the Implicit grant type in WSO2 API Manager.

<table>
<thead>
<tr class="header">
<th>Name</th>
<th>Description</th>
<th>Sample value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>scope</td>
<td>The OAuth scope you are requesting for the particular token</td>
<td><code>openid</code></td>
</tr>
<tr class="even">
<td>response_type</td>
<td>The required response format</td>
<td><code>id_token</code></td>
</tr>
<tr class="odd">
<td>redirect_uri</td>
<td>The URL of the Oauth application requesting for the token</td>
<td><code>http://wso2is.local:8080/playground2/oauth2client</code></td>
</tr>
<tr class="even">
<td>nonce</td>
<td>Any random value</td>
<td><code>13e2312637dg136e1</code></td>
</tr>
<tr class="odd">
<td>client_id</td>
<td>Client ID of the OAuth application </td>
<td><code>mzdQQ0RZOIqAf549ucIImB4h0SIa</code></td>
</tr>
</tbody>
</table>

!!! Tip 
        The playground application will send a authorization request the **authorize** endpoint using the following format.
        
``` java tab="Format"
https://<host>:<port>/oauth2/authorize?response_type=token
&client_id=<client-ID>
&redirect_uri=<callback-url>
&scope=<scope>
```
 
``` java tab="Example"
https://localhost:9443/oauth2/authorize?response_type=id_token+token
&client_id=Cx4LKFNObeuXocx7xgOpz5vfzFoa
&redirect_uri=http://wso2is.local:8080/playground2/oauth2client
&scope=openid
```

#### Try implicit grant to generate tokens

In this example we use the WSO2 Playground app, which is hosted as a web application, to obtain the access token with implicit grant.

!!! note
    **Before you begin**

    The following instructions use the sample playground webapp. For instructions on how to set up the sample webapp, see [Setting up the Sample Webapp](https://is.docs.wso2.com/en/latest/learn/deploying-the-sample-app/#deploy-the-sample-web-app).

1.  Open a terminal window and add the following entry to the `/etc/hosts` file of your machine to configure the hostname.
   ```
    127.0.0.1   wso2is.local
    127.0.0.1   localhost.com
   ```
    
    !!!info "Why is this step needed?"
        Some browsers do not allow you to create cookies for a naked hostname, such as `localhost`. Cookies are required when working with SSO . Therefore, to ensure that the SSO capabilities work as expected in this tutorial, you need to configure the `/etc/host` file as explained in this step.
        
         The `/etc/host` file is a read-only file. Therefore, you won't be able to edit it by opening the file via a text editor. Instead, edit the file using the terminal commands. For example, use the following command if you are working on a Mac/Linux environment.
        
         ``` java
         sudo nano /etc/hosts
         ```
         
2.  Login to WSO2 API Manager Store and create an application as shown below.

    [![]({{base_path}}/assets/img/learn/create-application.png)]({{base_path}}/assets/img/learn/create-application.png)
    
3.  Go to the **Production keys** tab for the application. Add <http://wso2is.local:8080/playground2/oauth2client> as the **Callback URL.** Select **Implicit** from the list of grant types and click **Generate Keys.**

    [![]({{base_path}}/assets/img/learn/implicit-grant.png)]({{base_path}}/assets/img/learn/implicit-grant.png)

    !!! note
        The Implicit grant and Code grant type checkboxes are disabled by default in the UI. To enable selecting the checkboxes, enter the Callback URL for the application.
    
4.  Go to playground app <http://wso2is.local:8080/playground2/> and click **import photos.**

    [![]({{base_path}}/assets/img/learn/playground2-app.png)]({{base_path}}/assets/img/learn/playground2-app.png)

5.  Give the information in the table below and click **Authorize.**

    <table>
    <thead>
    <tr class="header">
    <th>Field</th>
    <th>Sample value</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Authorization Grant Type</td>
    <td>Implicit</td>
    </tr>
    <tr class="even">
    <td>Client Id </td>
    <td>Consumer Key obtained for your application</td>
    </tr>
    <tr class="odd">
    <td>Scope</td>
    <td>The scope you have selected for your applicaton</td>
    </tr>
    <tr class="even">
    <td>Implicit Response Type</td>
    <td>ID token Only or ID token & Access Token</td>
    </tr>
    <tr class="odd">
    <td>Callback URL</td>
    <td>The callback URL of your application</td>
    </tr>
    <tr class="even">
    <td>Authorize Endpoint</td>
    <td><code>https://localhost:9443/oauth2/authorize</code></td>
    </tr>
    </tbody>
    </table>

    [![]({{base_path}}/assets/img/learn/playground2-implicit-grant.png)]({{base_path}}/assets/img/learn/playground2-implicit-grant.png)

6.  The playground application redirects to the login page. Enter you username and password and click **Sign In.**

    [![]({{base_path}}/assets/img/learn/login-page.png)]({{base_path}}/assets/img/learn/login-page.png)

7.  Select **Approve Once** or **Approve Always** to provide access to your profile information.

    [![]({{base_path}}/assets/img/learn/authorization-code-consent-page.png)]({{base_path}}/assets/img/learn/authorization-code-consent-page.png)  

8.  You will receive the access token as follows

    [![]({{base_path}}/assets/img/learn/implicit-grant-access-token-page.png)]({{base_path}}/assets/img/learn/implicit-grant-access-token-page.png)



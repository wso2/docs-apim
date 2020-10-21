# Configure Okta as a Key Manager

It is possible to integrate the WSO2 API Manager with an external Identity and Access Management server (IAM) using the Okta OAuth Authorization Server to manage the OAuth clients and tokens that are required by WSO2 API Manager. WSO2 API Manager has inbuilt support to consume APIs exposed by Okta OAuth.

Follow the instructions below to configure Okta as a third-party Key Manager:

## Step 1 - Configure Okta

1. Navigate to the [Okta sign up page](https://developer.okta.com/signup/).

     [![Okta signup]({{base_path}}/assets/img/administer/okta-signup.png)]({{base_path}}/assets/img/administer/okta-signup.png)

     Create an Okta account and get the Okta instance URL.

     Example:
    
     [https://dev-735404.okta.com](https://dev-735404.okta.com)

2. Obtain the authorization server ID.

    1. Click **API** and then click **Authorization Servers** in the Okta Developer Dashboard.
    2. Create a new authorization server.
    
         Alternatively, you can use the default server.
       
         [![Okta authorization server]({{base_path}}/assets/img/administer/okta-authorization-server.png)]({{base_path}}/assets/img/administer/okta-authorization-server.png)

         <a name="step12c"></a>

    3. Add a default scope. 
    
         1. Select the authorization server (e.g., default) and click **Scopes** to navigate to the Scopes section.
       
         2. Create a new scope (e.g., default). 
       
         3. Select **Default Scope**.

             [![Okta default scope]({{base_path}}/assets/img/administer/okta-default-scope.png)]({{base_path}}/assets/img/administer/okta-default-scope.png)

             [![Okta scope list]({{base_path}}/assets/img/administer/okta-scope-list.png)]({{base_path}}/assets/img/administer/okta-scope-list.png)

3. Get the API key.

    1. Click **API** and then click **Tokens** in the Okta Developer Dashboard.
    2. Click **Create Token** and enter a name for the token.
    3. Copy the token value and keep it for future use.

         [![Okta token]({{base_path}}/assets/img/administer/okta-token.png)]({{base_path}}/assets/img/administer/okta-token.png)

4. Create access policies.

     If you already have at least one access policy in your authorization server, skip the following steps and go to <a href="#step15">Step 1 - (5)</a>.

    1. Click **API** and then click **Authorization Servers** in the Okta Developer Dashboard.
    2. Select an Authorization Server.
    3. Click **Access Policies** and then click **Add New Access Policy**
    4. Enter the required information.
        
        [![Okta access policy]({{base_path}}/assets/img/administer/okta-access-policy.png)]({{base_path}}/assets/img/administer/okta-access-policy.png)

    5. Click **Create Policy** to save the policy.

     <a name="step15"></a>

5. Create Rules for the Access Policy.

     If you already have at least one rule in your access policy, skip the following steps and go to <a href="#step16">Step 1 - (6)</a>.

     1. Click **API** and then click **Authorization Servers** in the Okta Developer Dashboard.
     2. Select the name of an authorization server, and select **Access Policies**.
     3. Select the name of an access policy, and click **Add Rule**.

         [![Okta rule]({{base_path}}/assets/img/administer/okta-rule.png)]({{base_path}}/assets/img/administer/okta-rule.png)

    4. Enter the requested information.
    5. Click **Create Rule** to save the rule.

       <a name="step16"></a>

6. Create an OAuth application to get the credentials to access the introspect API:

    1. Click **Applications** and then click **Add Application**.
    2. Click **Web** and then click **Next**.

         [![okta add application introduction]({{base_path}}/assets/img/administer/okta-add-application-intro.png)]({{base_path}}/assets/img/administer/okta-add-application-intro.png)

         <a name="section6"></a>

    3. Navigate to the **Grant type allowed** section and select **Client Credentials**.
    4. After the application is created, note down the **Client ID** and **Client secret** that appears under the **Client Credentials** section.

7. Note down the Authorization server's settings.

   1. Click **API** and then click **Authorization Servers**.
   2. Select the authorization server.
   3. Note down the settings related to the Authorization server.

     [![Okta authorization server settings]({{base_path}}/assets/img/administer/okta-authorization-server-settings.png)]({{base_path}}/assets/img/administer/okta-authorization-server-settings.png)


## Step 2 - Configure WSO2 API Manager

1. Start WSO2 API Manager.

2. Sign in to the Admin Portal.

     `https://<hostname>:9443/admin`
     
     `https://localhost:9443/admin`

3. Add a new Key Manager.

     1. Click **Key Managers** and then click **Add Key Manager**.

         [![Add new Key Manager]({{base_path}}/assets/img/administer/add-key-manager.png)]({{base_path}}/assets/img/administer/add-key-manager.png)

     2. Add the following Key Manager configurations.

           [![Okta Configuration]({{base_path}}/assets/img/administer/okta-admin-configuration.png)]({{base_path}}/assets/img/administer/okta-admin-configuration.png)

        !!! note "Auto-filling Key Manager configurations"
            The Key Manager configurations can be auto-filled by clicking the **Import** button after providing the well-known endpoint of Okta. The well-known-URL is the **Metadata URI**, under **Settings** section.

         The following table provides definitions for each of the Key Manager configurations.

          <table>
          <tr class="header">
          <th><b>Configuration</b></th>
          <th><b>Description</b></th>
          <th> </th>
          </tr>
        
          <tr class="odd">
          <td>Name</td>
          <td>The name of the authorization server.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="even">
          <td>Display Name</td>
          <td>A name to display in the UI.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
          <td>Description</td>
          <td>A brief description of the Key Manager.</td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>Key Manager Type</td>
          <td>The type of the Key Manager to be selected.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
          <td>Well-known-url</td>
          <td><p>The well-known URL of the Authorization Server (Key Manager).
          <br/>
          If the well-known URL is provided, other endpoints can be imported. 
          <br/> Example:</br> https://dev-599740.okta.com/oauth2/default/.well-known/oauth-authorization-server</p>
          </td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>Issuer</td>
          <td>The issuer that consumes or validates access tokens. <br/>Example:</br> https://dev-599740.okta.com/oauth2/default</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td><b>Key Manager Endpoints</b></td>
          <td></td>
          <td></td>
          </tr>
          <tr class="even">
          <td>Client Registration Endpoint </td>
          <td><p>The endpoint that verifies the identity and obtain profile information of the end-user based on the authentication performed by an authorization server.</p></td>
          <td>Optional if the well-known URI is provided.</td>
          </tr>
          <tr class="odd">
          <td>Introspection Endpoint</td>
          <td>The endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth client.</td>
          <td>Optional if the well-known URI is provided.</td>
          </tr>
          <tr class="even">
          <td>Token Endpoint</td>
          <td>The endpoint that issues the access tokens.</td>
          <td>Optional if the well-known URI is provided.</td>
          </tr>
          <tr class="odd">
          <td>Revoke Endpoint</td>
          <td>The endpoint that revokes the access tokens.</td>
          <td>Optional if the well-known URI is provided.</td>
          </tr>
          <tr class="even">
          <td>Userinfo Endpoint</td>
          <td>The endpoint that allows clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user.</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td>Authorize Endpoint</td>
          <td>The endpoint used to obtain an authorization grant from the resource owner via the user-agent redirection.</td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>Scope Management Endpoint </td>
          <td>The endpoint used to manage the scopes.</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td><b>Connector Configurations</b></td>
          <td></td>
          <td></td>
          </tr>
          <tr class="even">
          <td>API Key</td>
          <td>The API key generated from <a href="#section6">section 6</a>.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
          <td>Client ID</td>
          <td>The client ID generated from <a href="#section6">section 6</a>.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="even">
          <td>Client Secret</td>
          <td>The client secret generated from <a href="#section6">section 6</a>.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
          <td><b>Claim URIs</b></td>
          <td>This provides claim URIs for the consumer key and the scopes.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="even">
          <td>Consumer Key Claim URI</td>
          <td>The claim URI for consumer key </br>Example:</br> cid</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
          <td>Scopes Claim URI</td>
          <td>The claim URI for scopes </br>Example:</br> scp</td>
          <td>Mandatory</td>
          </tr>
          <tr class="even">
          <td>Grant Types</td>
          <td>The supported grant types.</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td><b>Certificates</b></td>
          <td></td>
          <td></td>
          </tr>
          <tr class="even">
          <td>PEM</td>
          <td>Either copy and paste the certificate in PEM format or upload the PEM file.</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td>JWKS</td>
          <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This URL returns the Okta's public key set in JSON web key set format.
          This contains the signing key(s) the Relying Party (RP) uses to validate signatures from the Okta.
          </br>
          Example:</br> https://dev-599740.okta.com/oauth2/default/v1/keys
          </td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td><b>Advanced Configurations</b></td>
          <td></td>
          <td></td>
          </tr>
          <tr class="odd">
          <td>Token Generation</td>
          <td>This enables token generation via the authorization server.</td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>Out Of Band Provisioning</td>
          <td>This enables the provisioning of Auth clients that have been created without the use of the Developer Portal, such as previously created Auth clients.</td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>OAuth App Creation</td>
          <td>This enables the creation of Auth clients.</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td><b>Token Validation Method</b></td>
          <td>The method used to validate the JWT signature.
              This is mandatory if the Token Validation Method is <b>introspect</b></td>
          <td></td>
          </tr>
          <tr class="even">
          <td>Self Validate JWT</td>
          <td>The <code>kid</code> value is used to validate the JWT token signature. If the `<code>kid</code> value is not present, the <code>gateway_certificate_alias</code> is used.</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td>Use introspect</td>
          <td>The JWKS endpoint is used to validate the JWT token signature.
          If this option is used to validate the tokens it is mandatory to add a Token Handling Option
               For Okta it should be <b>JWT</b> and it is required to specify a claim mapping as a unique identifier.
          </br>Example:</br> Claim Key : iss</br> 
          Claim Value : https://dev-599740.okta.com/oauth2/default
          </td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td><b>Token Handling Options</b></td>
          <td>This provides a way to validate the token for this particular authorization server.</td>
          <td>Optional
              This is mandatory if the Token Validation Method is <b>introspect</b></td>
          </tr>
          <tr class="odd">
          <td>REFERENCE</td>
          <td>The tokens that match a specific regular expression (regEx) are validated.</td>
          <td></td>
          </tr>
          <tr class="even">
          <td>JWT</td>
          <td>The tokens that match a specific JWT is validated.</td>
          <td></td>
          </tr>
          <tr class="odd">
          <td>CUSTOM</td>
          <td>The tokens that match a custom pattern are validated.</td>
          <td></td>
          </tr>
          <tr class="even">
          <td><b>Claim Mappings</b></td>
          <td>Local and remote claim mapping.</td>
          <td>Optional</td>
          </tr>
        </table>

## Step 3 - Generate keys using the Okta Key Manager

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    `https://localhost:9443/devportal`

2. Click **Applications**.
3. Create a new application or use the default application.
4. Click **Sandbox Keys**.

     [![Okta Developer Portal generate keys]({{base_path}}/assets/img/administer/okta-devportal-generate-keys.png)]({{base_path}}/assets/img/administer/okta-devportal-generate-keys.png)

5. Select the **Response Type**.

6. Click **Generate Keys**.

    !!! tip
        If you want to generate the tokens with scopes, those scopes should have been defined in Okta as mentioned in the <a href="#step12c">Step 1 - (2) c</a>.

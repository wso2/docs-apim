# Configure ForgeRock as a Key Manager

WSO2 API Manager has the capability to support multiple Key Managers at the same time. So with the use of connectors, it is capable of supporting any authorization server as a Key Manager. Additionally, WSO2 API Manager is prepacked with an inbuilt resident Key Manager.

WSO2 API Manager can connect to ForgeRock out-of-the-box using the [WSO2 API-M ForgeRock Connector](https://github.com/wso2-extensions/apim-km-forgerock).

Follow the instructions given below to configure ForgeRock as a third-party Key Manager:

## Before you begin

- Install ForgeRock.
- [Download and install WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/installing-api-m-runtime/).

## Step 1 - Configure ForgeRock

Follow the instructions given below to configure the Fogerock Authorization Server to work with WSO2 API Manager.

### Step 1.1 - Configure OAuth2 Provider

1. Navigate to the URL where the ForgeRock Authorization server is deployed.

2. Navigate to **Realms** -> **Top Level Realm**. 
   
    !!! note
        The examples and configurations in this guide are based on the root realm named **Top level realm**, which exists by default.
   
    [![ForgeRock realms]({{base_path}}/assets/img/administer/forgerock-realms.png)]({{base_path}}/assets/img/administer/forgerock-realms.png)

3. Navigate to **Root Realm** -> **Dashboard** -> **Configure OAuth Provider** -> **Configure OAuth 2.0** section.

4. Create an OAuth provider based on the following values.

     <table>
     <tr>
     <th><b>Field</b></th> <th><b>Value</b></th>
     </tr>
     <tr>
     <td>Realm</td> <td>/</td>
     </tr>
     </tr>
     <tr>
     <td>Refresh Token Lifetime (seconds)</td> <td>60</td>
     </tr>

     </tr>
     <tr>
     <td>Authorization Code Lifetime (seconds)</td> <td>120</td>
     </tr>
     </tr>
     <tr>
     <td>Access Token Lifetime (seconds)</td> <td>3600</td>
     </tr>

     </tr>
     <tr>
     <td>Issue Refresh Tokens</td> <td>Enabled</td>
     </tr>

     </tr>
     <tr>
     <td>Issue Refresh Tokens on Refreshing Access Tokens</td> <td>Disabled</td>
     </tr>

     </tr>
     <tr>
     <td>Scope Implementation Class</td> <td>org.forgerock.openam.oauth2</td>
     </tr>

     </table>
  
   
    [![ForgeRock create OAuth Provider]({{base_path}}/assets/img/administer/forgerock-createOauthProvider.png)]({{base_path}}/assets/img/administer/forgerock-createOauthProvider.png)

5. Navigate to **Root Realm** -> **Service Provider** -> **OAuth2 Provider** and click on the **Advanced** tab.

6. Configure the scopes and the signing algorithm of the created OAuth2 Provider using the following values.

     <table>
     <tr>
     <th><b>Field</b></th> <th><b>Value</b></th>
     </tr>

     <tr>
     <td>Client Registration Scope Whitelist</td> <td>default</td>
     </tr>

     <tr>
     <td>Subject Types supported</td> <td>public</td>
     </tr>

     <tr>
     <td>Default Client Scopes</td> <td>default</td>
     </tr>

     <tr>
     <td>OAuth2 Token Signing Algorithm</td> <td>RS256</td>
     </tr>
     </table>
   
    [![ForgeRock provider advance config]({{base_path}}/assets/img/administer/forgerock-provider-advance-config.png)]({{base_path}}/assets/img/administer/forgerock-provider-advance-config.png)

7. Navigate to the **Dynamic client registration** tab and configure it to allow dynamic client registration using the following values.

     <table>
     <tr>
     <th><b>Field</b></th> <th><b>Value</b></th>
     </tr>

     <tr>
     <td>Require Software Statement for Dynamic Client Registration</td> <td>Disabled</td>
     </tr>

     <tr>
     <td>Required Software Statement Attested Attributes</td> <td>redirect_uris</td>
     </tr>

     <tr>
     <td>Allow Open Dynamic Client Registration</td> <td>Disabled</td>
     </tr>

     <tr>
     <td>Generate Registration Access Tokens</td> <td>Enabled</td>
     </tr>

     <tr>
     <td>Scope to give access to dynamic client registration</td> <td>dynamic_client_registration</td>
     </tr>

     </table>

   
    [![ForgeRock configure dcr]({{base_path}}/assets/img/administer/forgerock-configure-dcr.png)]({{base_path}}/assets/img/administer/forgerock-configure-dcr.png)
   
You can configure the other properties of the OAuth2 provider based on your requirements.

### Step 1.2 - Configure an OAuth2 client

Create a static OAuth client as follows so that you can use the OAuth client keys for the purpose of dynamic client registration.

1. Navigate to **Realm** -> **OAuth 2.0** -> **Applications** -> **Add client** to create a client.
   
    !!! note
        Ensure to add the mentioned two scopes when creating the client because these scopes are required for dynamic client registration and introspection.

     <table>
     <tr>
     <th><b>Field</b></th> <th><b>Value</b></th>
     </tr>
     
     <tr>
     <td>Client ID</td> <td>amAdmin</td>
     </tr>

     <tr>
     <td>Client secret</td> <td>Enter a value of your choice.</td>
     </tr>

     <tr>
     <td>Scope(s)</td> <td><code>am-introspect-all-tokens</code> </br><code>dynamic_client_registration</code></td>
     </tr>

     </table>
   
     [![ForgeRock add client]({{base_path}}/assets/img/administer/forgerock-add-client.png)]({{base_path}}/assets/img/administer/forgerock-add-client.png)

2. Navigate to the above created client under **Applications** -> **Client ID of the App** -> **Core** -> **Access Token LifeTime**.

3. Set a long value for the **Access Token LifeTime** to obtain a long living registration access token. You will use this token to register and update clients dynamically.
    
4. Navigate to the **Advanced** tab and configure the `client_credential` grant type that you need to use to obtain the access token.
   
      [![ForgeRock client grant]({{base_path}}/assets/img/administer/forgerock-client-grant.png)]({{base_path}}/assets/img/administer/forgerock-client-grant.png)

If you want to work with scopes, then you need to assign the relevant scopes to the relevant OAuth clients beforehand.    

## Step 2 - Configure WSO2 API Manager

Follow the instructions given below to configure WSO2 API Manager to work with the Fogerock Authorization Server.

1. [Start WSO2 API Manager]({{base_path}}/install-and-setup/install/installing-the-product/running-the-api-m/#starting-the-server).

     `<API-M_HOME>` refers to the root folder of the extracted WSO2 API-M distribution.

2. Add a Key Manager.

    1. Sign in to the Admin Portal. 

         `https://<hostname>:9443/admin`

    2. Click Key Manager and then click **Add Key Manager**.

         [![Add Key Manger]({{base_path}}/assets/img/administer/add-key-manager.png)]({{base_path}}/assets/img/administer/add-key-manager.png)

    3. Add the following configuration to add a new Key Manager.

         [![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-1.png)]({{base_path}}/assets/img/administer/forgerock-add-km-1.png)

         [![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-2.png)]({{base_path}}/assets/img/administer/forgerock-add-km-2.png)

         [![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-3.png)]({{base_path}}/assets/img/administer/forgerock-add-km-3.png)

         [![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-4.png)]({{base_path}}/assets/img/administer/forgerock-add-km-4.png)

         The following table provides definitions for each of the configurations.

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
            <td>A name to display on the UI.</td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Description</td>
            <td>A brief description of the Key Manager.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Key Manager Type</td>
            <td>The type of Key Manager to be selected.</td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Well-known-url</td>
            <td>The well-known URL of the authorization server (Key Manager). </br>
            If the well-known URL is provided, other endpoints can be imported.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Issuer</td>
            <td>The issuer that consumes or validates the access tokens
            </br> Example: </br>http://localhost:8080/openam/oauth2</br>
            </td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td><b>Key Manager Endpoints</b></td>
            <td> </td>
            <td> </td>
          </tr>
          <tr class="even">
            <td>Client Registration Endpoint </td>
            <td>The endpoint to verify the identity and obtain profile information of the end-user based on the authentication performed by an authorization server.
            </br> Example: </br>http://localhost:8080/openam/oauth2/register
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Introspection Endpoint</td>
            <td>The endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth client.
            </br> Example: </br>
            http://localhost:8080/openam/oauth2/introspect</br>
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="even">
            <td>Token Endpoint</td>
            <td>The endpoint that issues the access tokens.
            </br> Example: </br>
            http://localhost:8080/openam/oauth2/access_token</br>
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Revoke Endpoint</td>
            <td>The endpoint that revokes the access tokens.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Userinfo Endpoint</td>
            <td>The endpoint that allows clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td>Authorize Endpoint</td>
            <td>The endpoint that is used to obtain an authorization grant from the resource owner via user-agent redirection.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Scope Management Endpoint </td>
            <td>The endpoint that is used to manage the scopes.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td><b>Connector Configurations</b></td>
            <td></td>
            <td></td>
          </tr>
          <tr class="even">
            <td>Client ID</td>
            <td>The client Id of the static client to invoke the introspection endpoint. </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Client Secret</td>
            <td>The client secret of the static client to invoke the introspection endpoint.</td>
            <td>Mandatory</td>
          </tr>
          <tr class="even">
            <td><b>Claim URIs</b></td>
            <td>Provide the claim URIs for the consumer key and the scopes.</td>
            <td></td>
          </tr>
          <tr class="odd">
            <td>Consumer Key Claim URI</td>
            <td>The claim URI for the consumer key.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Scopes Claim URI</td>
            <td>The claim URI for scopes.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td>Grant Types</td>
            <td>The supported grant types.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td><b>Certificates</b></td>
            <td></td>
            <td></td>
          </tr>
          <tr class="odd">
            <td>PEM</td>
            <td>Either copy and paste the certificate in PEM format or upload the PEM file.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>JWKS</td>
            <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This URL returns ForgeRock's public key set in JSON web key set format.
            This contains the signing key(s) the Relying Party (RP) uses to validate signatures from ForgeRock.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td><b>Advanced Configurations</b></td>
            <td>Token Generation</td>
            <td></td>
          </tr>
          <tr class="even">
            <td>Token Generation</td>
            <td>Enables token generation via the authorization server.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td>Out Of Band Provisioning</td>
            <td>This enables the provisioning of Auth clients that have been created without the use of the Developer Portal, such as previously created Auth clients.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Oauth App Creation</td>
            <td>This enables the creation of Auth clients.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td><b>Token Validation Method</b></td>
            <td>The method used to validate the JWT signature.</td>
            <td></td>
          </tr>
          <tr class="even">
            <td>Self Validate JWT</td>
            <td>The kid value is used to validate the JWT token signature. If the kid value is not present, `gateway_certificate_alias` is used.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td>Use introspect</td>
            <td>The JWKS endpoint is used to validate the JWT token signature.
            If this option is used to validate the tokens it is mandatory to add a Token Handling Option.
            </td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td><b>Token Handling Options</b></td>
            <td>Provides a way to validate the token for this particular authorization server.
            This is mandatory if the Token Validation Method is <b>introspect</b></br>
            For Forgerock if its <b>JWT</b> it is required to specify a claim mapping as a unique identifier and
            If its <b>REFERENCE</b> its required to set a regular expression for the length of the token.
            </br><b>Example For JWT</b> </br> Claim Key : iss
            </br>Claim Value : http://loccbcalhost:8080/openam/oauth2
            </br> <b>Example for Reference</b><br>{27}</td>
            <td></td>
          </tr>
          <tr class="odd">
            <td>REFERENCE</td>
            <td>The tokens matching a specific regular expression (regEx) is validated.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>JWT</td>
            <td>The tokens matching a specific JWT is validated.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td>CUSTOM</td>
            <td>The token matching a custom pattern is validated.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td><b>Claim Mappings</b></td>
            <td>Local and remote claim mapping.</td>
            <td>Optional</td>
          </tr>
          </table>

## Step 3 - Generate keys using the ForgeRock Key Manager

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`

2. Click **Applications**.
3. Create a new application or use the default application.
4. Click **Production Keys**.

     [![ForgeRock Developer Portal generate keys]({{base_path}}/assets/img/administer/forgerock-devportal-genkeys.png)]({{base_path}}/assets/img/administer/forgerock-devportal-genkeys.png)

5. Click **Generate Keys**.

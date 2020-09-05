# Configure a Custom Key Manager

WSO2 API Manager is capable of intigrating with any external OAuth Authorization Server to manage the OAuth clients and tokens that are required by WSO2 API Manager. This can be achieved by writing a custom key manager connector as explained below.

   You may use below out of the box connectors as a reference.
   
  1. [Okta Connector](https://github.com/wso2-extensions/apim-km-okta/)
   
  2. [Keycloak Connector](https://github.com/wso2-extensions/apim-keymanager-keycloak/)


## Step 1 - Create Key Manager Connector Bundle 

1. First You need to create a maven project. 

   This needs 
   
   i. A class that implements `KeyManagerConnectorConfiguration` interface which is responsible for managing configurations related to the Authorization Server. 
   
   ii. A class that extends `AbstractKeyManager` abstract class which is responsible for managing OAuth clients and Tokens needed by WSO2 API Manager.
   
   Alternatively you may download the sample project from [here]({{base_path}}/attachments/administer/custom.auth.client.zip).

2. Implement `KeyManagerConnectorConfiguration`.

  In the sample project this has been implemented in `org.wso2.custom.client.CustomOAuthClient.java` class

  Following are the methods that the `KeyManagerConnectorConfiguration` interface uses to carry out operations.

  <table>
  <colgroup>
  <col width="30%" />
  <col width="70%" />
  </colgroup>
  <thead>
  <tr class="header">
  <th>Method</th>
  <th>Description</th>
  </tr>
  </thead>
  <tbody>
  <tr class="odd">
  <td><strong>getImplementation</strong></td>
  <td><p>Provides fully Qualified class name of implementation of KeyManager.</p></td>
  </tr>
  <tr class="even">
  <td><strong>getJWTValidator</strong></td>
  <td><p>Provides fully Qualified class name of implementation of JWTValidator.</p></td>
  </tr>
  <tr class="odd">
  <td><strong>getConnectionConfigurations</strong></td>
  <td><p>Provides list of Configurations that need to show in Admin portal in order to connect with KeyManager.</p></td>
  </tr>
  <tr class="even">
  <td><strong>getApplicationConfigurations</strong></td>
  <td><p>Provides list of configurations need to create Oauth applications in Oauth server in Devportal.
  </p></td>
  </tr>
  <tr class="odd">
  <td><strong>getType</strong></td>
  <td><p>Type of Connector ex: Okta.</p></td>
  </tr>
  <tr class="even">
  <td><strong>getDisplayName</strong></td>
  <td><p>Display name to show in Admin portal.</p></td>
  </tr>
  <tr class="odd">
  <td><strong>getDefaultScopesClaim</strong></td>
  <td><p>Default scope claim available in jwt if different than <b>scope</b>.</p></td>
  </tr>
  <tr class="even">
  <td><strong>getDefaultConsumerKeyClaim</strong></td>
  <td><p>Default Consumer Key Claim available in JWT if different than <b>azp</b>.</p></td>
  </tr>
  </tbody>
</table>  
  
3. Extend `AbstractKeyManager`.

`AbstractKeyManager` implements `KeyManager` interface.
To learn about the KeyManager interface operation please refer [Extending KeyManager Interface]({{base_path}}/develop/extending-api-manager/extending-key-management/extending-the-key-manager-interface) documentation.


  In the sample project `AbstractKeyManager` has been extended by the `org.wso2.custom.client.CustomOAuthClient.java` class

4. If you need to customize the JWTValidation, it is required to [extend JWTValidator]({{base_path}}/develop/extending-api-manager/extending-key-management/extending-key-validation)
5. Build the project by navigating to <PROJECT_HOME> and issue below command.
     
      
      mvn clean install
     
     

## Step 2 - Deploy the bundle in API-M Server

1. Stop the API-M server if it is already running. And copy the jar file generated in `custom.key.manager` component target directory into <API-M Server>/repository/components/dropins

2. Start the Server

## Step 3 - Configure the Connector using Admin Portal

1. Sign in to the Admin Portal.

     `https://<hostname>:9443/admin`
     
     `https://localhost:9443/admin`

3. Add a new Key Manager.

     1. Click **Key Managers** and then click **Add Key Manager**.

         [![Add new Key Manager]({{base_path}}/assets/img/administer/add-key-manager.png)]({{base_path}}/assets/img/administer/add-key-manager.png)

     2. Add the following Key Manager configurations.

         The following table provides definitions for each of the Key Manager configurations.

          <table>
          <tr class="header">
          <th>Configuration</th>
          <th>Description</th>
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
          <br/> e.g., https://dev-599740.okta.com/oauth2/default/.well-known/oauth-authorization-server</p>
          </td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>Issuer</td>
          <td>The issuer that consumes or validates access tokens. <br/>e.g., https://dev-599740.okta.com/oauth2/default</td>
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
          <td>The claim URI for consumer key e.g., cid</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
          <td>Scopes Claim URI</td>
          <td>The claim URI for scopes e.g., scp</td>
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
          e.g., https://dev-599740.okta.com/oauth2/default/v1/keys
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
          </b>e.g., Claim Key : iss
          </b>Claim Value : https://dev-599740.okta.com/oauth2/default
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

## Step 4 - Generate keys using the Custom Key Manager

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    `https://localhost:9443/devportal`

2. Click **Applications**.
3. Create a new application or use the default application.
4. Select the Key  Manager.

5. Click **Generate Keys**.

!!! tip
     If you want to generate the tokens with scopes, those scopes should have been defined in the Authorization Server side.


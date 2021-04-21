# Configure a Custom Key Manager

WSO2 API Manager is capable of integrating with any external OAuth Authorization Server to manage the OAuth clients and tokens that are required by WSO2 API Manager. Therefore, you need to use a custom Key Manager connector for this purpose. 

## Step 1 - Create a Key Manager connector bundle 

You need to write a custom Key Manager connector as explained below.

!!! tip
    The following are some out-of-the-box connectors that you can use as references.
   
      - [Okta Connector](https://github.com/wso2-extensions/apim-km-okta/)
   
      - [Keycloak Connector](https://github.com/wso2-extensions/apim-keymanager-keycloak/)

1. Create a Maven project.

      Let's download the sample project from [here]({{base_path}}/assets/attachments/administer/custom.auth.client.zip).
   
      However, when manually creating a Maven project, you will need to follow the following steps.

      1. Define a class that implements the `KeyManagerConnectorConfiguration` interface that is responsible for managing the configurations related to the Authorization Server. 
   
      2. Define a class that extends the `AbstractKeyManager` abstract class which is responsible for managing OAuth clients and the tokens that are needed by WSO2 API Manager.

2. Implement `KeyManagerConnectorConfiguration`.

      In the sample project, this has been implemented in the `org.wso2.custom.client.CustomOAuthClient.java` class.

      The following are the methods that the `KeyManagerConnectorConfiguration` interface uses to carry out various related operations.

     <table>
     <colgroup>
     <col width="30%" />
     <col width="70%" />
     </colgroup>
     <thead>
     <tr class="header">
     <th><b>Method</b></th>
     <th><b>Description</b></th>
     </tr>
     </thead>
     <tbody>
     <tr class="odd">
     <td><strong>getImplementation</strong></td>
     <td><p>Provides the fully qualified class name of the implementation that corresponds to the `KeyManager` interface.</p></td>
     </tr>
     <tr class="even">
     <td><strong>getJWTValidator</strong></td>
     <td><p>Provides the fully qualified class name of the implementation that corresponds to the `JWTValidator`.</p></td>
     </tr>
     <tr class="odd">
     <td><strong>getConnectionConfigurations</strong></td>
     <td><p>Provides the list of configurations that need to appear in the Admin Portal in order to connect with the Key Manager.</p></td>
     </tr>
     <tr class="even">
     <td><strong>getApplicationConfigurations</strong></td>
     <td><p>Provides the list of configurations that are needed to create OAuth applications in the OAuth server in the Developer Portal.
     </p></td>
     </tr>
     <tr class="odd">
     <td><strong>getType</strong></td>
     <td><p>Type of connector. For example, Okta.</p></td>
     </tr>
     <tr class="even">
     <td><strong>getDisplayName</strong></td>
     <td><p>Display name to show in the Admin Portal.</p></td>
     </tr>
     <tr class="odd">
     <td><strong>getDefaultScopesClaim</strong></td>
     <td><p>The default scope claim available in JWT if it is different than the <b>scope</b>.</p></td>
     </tr>
     <tr class="even">
     <td><strong>getDefaultConsumerKeyClaim</strong></td>
     <td><p>The default consumer key claim available in JWT if it is different to <b>azp</b>, which is the Authorized party - the party to which the ID token was issued.</p></td>
     </tr>
     </tbody>
     </table>  
  
3. Extend `AbstractKeyManager`.

      The `AbstractKeyManager` implements the `KeyManager` interface. For more information on the operations carried out on the `KeyManager` interface, see [Extending the KeyManager Interface]({{base_path}}/develop/extending-api-manager/extending-key-management/extending-the-key-manager-interface).


      In the sample project, the `AbstractKeyManager` interface has been extended using the `org.wso2.custom.client.CustomOAuthClient.java` class.

4. If you need to customize the `JWTValidation` interface, you need to [extend the JWTValidator]({{base_path}}/develop/extending-api-manager/extending-key-management/extending-key-validation).

5. Build the project.

      Navigate to the `<PROJECT_HOME>` directory and execute the following command.
      
      `mvn clean install`

      This will create a custom Key Manager connector JAR.
     
## Step 2 - Deploy the bundle in the WSO2 API-M Server

1. Stop the API-M server if it is already running. 

2. Copy the JAR file that is generated in the `custom.key.manager` component target directory, and add it in to the `<API-M Server>/repository/components/dropins/` directory.

3. Start the Server

## Step 3 - Configure the connector using the Admin Portal

1. Sign in to the Admin Portal.

      `https://<hostname>:9443/admin`
     
      `https://localhost:9443/admin`

2. Add a new Key Manager.

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
          <br/> e.g., <code>https://dev-599740.okta.com/oauth2/default/.well-known/oauth-authorization-server</code></p>
          </td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>Issuer</td>
          <td>The issuer that consumes or validates access tokens. <br/>e.g., <code>https://dev-599740.okta.com/oauth2/default</code></td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td><b>Key Manager Endpoints</b></td>
          <td></td>
          <td></td>
          </tr>
          <tr class="even">
          <td>Client Registration Endpoint </td>
          <td><p>The endpoint that verifies the identity and obtains profile information of the end-user based on the authentication performed by an authorization server.</p></td>
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
          <td>The endpoint is used to obtain an authorization grant from the resource owner via the user-agent redirection.</td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td>Scope Management Endpoint </td>
          <td>The endpoint is used to manage the scopes.</td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td><b>Connector Configurations</b></td>
          <td></td>
          <td></td>
          </tr>
          <tr class="even">
          <td>API Key</td>
          <td>The API key that was generated from the Authorization Server.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
          <td>Client ID</td>
          <td>The client ID that was generated from the Authorization Server.</td>
          <td>Mandatory</td>
          </tr>
          <tr class="even">
          <td>Client Secret</td>
          <td>The client secret that was generated from the Authorization Server.</td>
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
          This contains the signing key(s) that the Relying Party (RP) uses to validate signatures from Okta.
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
          <td>This enables the token generation process via the Authorization Server.</td>
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
               For Okta it should be <b>JWT</b> and it is required to specify a claim mapping as a unique identifier.</br>
          </b>e.g., </br>Claim Key : iss</br>
          </b>Claim Value : https://dev-599740.okta.com/oauth2/default
          </td>
          <td>Optional</td>
          </tr>
          <tr class="even">
          <td><b>Token Handling Options</b></td>
          <td>This provides a way to validate the token for this particular Authorization Server.</td>
          <td>Optional
              </br>This is mandatory if the token validation method is <b>introspect</b></td>
          </tr>
          <tr class="odd">
          <td>REFERENCE</td>
          <td>The tokens that match a specific regular expression (regEx) are validated.</td>
          <td></td>
          </tr>
          <tr class="even">
          <td>JWT</td>
          <td>The tokens that match a specific JWT are validated.</td>
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

## Step 4 - Generate the keys using the custom Key Manager

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    `https://localhost:9443/devportal`

2. Click **Applications**.
3. Create a new application or use the default application.
4. Select the Key  Manager.

5. Click **Generate Keys**.

    !!! tip
        If you want to generate the tokens with scopes, make sure that those scopes are defined in the Authorization Server.


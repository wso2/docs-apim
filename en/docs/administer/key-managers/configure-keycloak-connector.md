# Configure Keycloak as a Key Manager

WSO2 API Manager supports multiple Key Managers. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager and with the use of connectors it is capable of supporting any authorization server as a Key Manager.

Therefore, WSO2 API Manager can connect Keycloak out-of-the-box using the [WSO2 API-M Keycloak Connector](https://github.com/wso2-extensions/apim-keymanager-keycloak).

Follow the instructions given below to configure Keycloak as a third-party Key Manager. 

!!! info
    For more information, see the [Getting Started Guide, which is under the official Keycloak documentation](https://www.keycloak.org/guides#getting-started).

## Step 1 - Configure Keycloak

1. Sign in to the Keycloak Management Console.
     
    `http://localhost:8080/`

    !!! Note
        The documentation provides steps to configure the KeyCloak version 24.0.1. If you are using a different version, the screenshots could be different. Moreover, The steps which have been provided is to a local docker image of Keycloak. If you are using a different setup, the URL may vary.
    
2. Click **Client Scopes** and create client scope named "default".

     [![add default client scope]({{base_path}}/assets/img/administer/keycloak-add-client-scope-default.png)]({{base_path}}/assets/img/administer/keycloak-add-client-scope-default.png)

3. Click **Clients** and create a client with the Redirect URIs https://localhost:9443/.

    [![Keycloak add client - step 1]({{base_path}}/assets/img/administer/keycloak-add-client-1.png)]({{base_path}}/assets/img/administer/keycloak-add-client-1.png)

    [![Keycloak add client - step 2]({{base_path}}/assets/img/administer/keycloak-add-client-2.png)]({{base_path}}/assets/img/administer/keycloak-add-client-2.png)

    [![Keycloak add client - step 3]({{base_path}}/assets/img/administer/keycloak-add-client-3.png)]({{base_path}}/assets/img/administer/keycloak-add-client-3.png)

4. Optionally, define a longer value as the **Access Token Lifespan** in the client settings in the **Advanced** tab under **Advanced settings** section.

     [![Set expiry time]({{base_path}}/assets/img/administer/keycloak-set-expiry-time.png)]({{base_path}}/assets/img/administer/keycloak-set-expiry-time.png)

5. Click **Client Scopes** and add the default scope created previously to the client as default scope.

     [![Add scope to client scopes]({{base_path}}/assets/img/administer/keycloak-add-to-client-scopes.png)]({{base_path}}/assets/img/administer/keycloak-add-to-client-scopes.png)

6. Click **Service Account Roles** and assign the `admin` role as an assigned role.

     [![Assign service account roles]({{base_path}}/assets/img/administer/keycloak-serviceaccount-assign-admin.png)]({{base_path}}/assets/img/administer/keycloak-serviceaccount-assign-admin.png)

    <a name="confidentialclient"></a>

7. Copy the client credentials.

     [![Keycloak client secret]({{base_path}}/assets/img/administer/keycloak-client-secret.png)]({{base_path}}/assets/img/administer/keycloak-client-secret.png)

## Step 2 - Configure WSO2 API Manager

1. If you are configuring TLS between Keycloak and WSO2 API Manager, add the Keycloak cert to the API Manager truststore and vice versa.

    !!! Note
        For information on [Configuring TLS in Keycloak](https://www.keycloak.org/server/enabletls), see the Keycloak official documentation.

2. Start WSO2 API Manager.

     `<API-M_HOME>` refers to the root folder of the extracted WSO2 API-M distribution.

3. Add a Key Manager.

    1. Sign in to the Admin Portal. 

         `https://<hostname>:9443/admin`

         `https://localhost:9443/admin`

    2. Click Key Manager and then click **Add Key Manager**.
        
         [![Add new Key Manager]({{base_path}}/assets/img/administer/add-new-key-manager.png)]({{base_path}}/assets/img/administer/add-new-key-manager.png)

    3. Add the following configuration to add a new Key Manager.
    
         [![Add Keycloak configurations]({{base_path}}/assets/img/administer/keycloak-endpoints.png)]({{base_path}}/assets/img/administer/keycloak-endpoints.png)
         
        !!! tip
             * Configuring the well-known URL populates all the default configurations in the table once you click **Import**. 
             * It is mandatory to provide the **Client Id** and **Client Secret**.

         The following table provides definitions for each of the configurations.

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
            <td>The type of the Key Manager to be selected.</td>
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
            </br> e.g., https://localhost:8443/auth/realms/master</br>
               http://localhost:8080/auth/realm</td>
          <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td><b>Key Manager Endpoints</b></td>
            <td> </td>
            <td> </td>
          </tr>
          <tr class="even">
            <td>Client Registration Endpoint </td>
            <td>The endpoint to verify the identity and obtain profile information of the end-user based on the authentication performed by an authorization server.</br>
            e.g., https://localhost:8443/auth/realms/master/clients-registrations/openid-connect
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Introspection Endpoint</td>
            <td>The endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth client.
            </br> e.g., 
            http://localhost:8080/auth/realms/master/protocol/openid-connect/token/introspect </br>
               https://localhost:8443/auth/realms/master/protocol/openid-connect/token/introspect
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="even">
            <td>Token Endpoint</td>
            <td>The endpoint that issues the access tokens.
            </br>
            e.g.,
            http://localhost:8080/auth/realms/master/protocol/openid-connect/token</br>
            https://localhost:8443/auth/realms/master/protocol/openid-connect/token
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
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Authorize Endpoint</td>
            <td>The endpoint used to obtain an authorization grant from the resource owner via user-agent redirection.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Scope Management Endpoint </td>
            <td>The endpoint used to manage the scopes.</td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td><b>Connector Configurations</b></td>
            <td></td>
            <td></td>
          </tr>
          <tr class="even">
            <td>Client ID</td>
            <td>The client ID obtained in Keycloak for the <a href="#confidentialclient">confidential type client </a></br>e.g., apim-client.</td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Client Secret</td>
            <td>The client secret obtained in generated from <a href="#confidentialclient">Keycloak for the confidential type client</a>.</td>
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
            <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This URL returns Keycloak's public key set in JSON web key set format.
            This contains the signing key(s) the Relying Party (RP) uses to validate signatures from Keycloak.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
          <td><b>Permissions</b></td>
          <td></td>
          <td></td>
          </tr>
          <tr class="even">
          <td>Key Manager Permission</td>
          <td>Permission type for role-based Key Manager restriction.</br>
          e.g., <code>PUBLIC</code>, <code>ALLOW</code>, <code>DENY</code></td>
          <td>Optional</td>
          </tr>
          <tr class="odd">
          <td>Roles</td>
          <td>Roles to Whitelist or Blacklist</td>
          <td>Optional</td>
          </tr>
          <tr class="even">
            <td><b>Advanced Configurations</b></td>
            <td>Token Generation</td>
            <td></td>
          </tr>
          <tr class="odd">
            <td>Token Generation</td>
            <td>Enables token generation via the authorization server.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Out Of Band Provisioning</td>
            <td>This enables the provisioning of Auth clients that have been created without the use of the Developer Portal, such as previously created Auth clients.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td>Oauth App Creation</td>
            <td>This enables the creation of Auth clients.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td><b>Token Validation Method</b></td>
            <td>The method used to validate the JWT signature.</td>
            <td></td>
          </tr>
          <tr class="odd">
            <td>Self Validate JWT</td>
            <td>The kid value is used to validate the JWT token signature. If the kid value is not present, `gateway_certificate_alias` is used.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>Use introspect</td>
            <td>The JWKS endpoint is used to validate the JWT token signature.
            If this option is used to validate the tokens it is mandatory to add a Token Handling Option.
                For the Okta it should be <b>JWT</b> and it is required to specify a claim mapping as a unique identifier.
            </br>e.g.,; Claim Key : iss
            </br>Claim Value : https://localhost:8443/auth/realms/master </td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td><b>Token Handling Options</b></td>
            <td>Provides a way to validate the token for this particular authorization server.
            This is mandatory if the Token Validation Method is <b>introspect</b></td>
            <td></td>
          </tr>
          <tr class="even">
            <td>REFERENCE</td>
            <td>The tokens matching a specific regular expression (regEx) is validated.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td>JWT</td>
            <td>The tokens matching a specific JWT is validated.</td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td>CUSTOM</td>
            <td>The token matching a custom pattern is validated.</td>
            <td>Optional</td>
          </tr>
          <tr class="odd">
            <td><b>Claim Mappings</b></td>
            <td>Local and remote claim mapping.</td>
            <td>Optional</td>
          </tr>
          </table>

## Step 3 - Generate keys using the Keycloak Key Manager

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    `https://localhost:9443/devportal`

2. Click **Applications**.

3. Create a new application or use the default application.

4. Click **Sandbox Keys**.

     ![Keycloak Developer Portal generate keys]({{base_path}}/assets/img/administer/keycloak-devportal-generate-keys.png)

5. Select the **Response Type**.

6. Click **Generate Keys**.

!!! tip
     * If you want to generate the tokens with scopes, those scopes should have been defined in Keycloak as mentioned in the <a href="#step12">Step 1 - (2)</a>.
     * When generating a token in the Developer Portal, you need to have the `code` and `implicit` grant types selected and you need to enter the response type as `none`. Without these, the token generation process fails.

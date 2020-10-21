# Configure PingFederate as a Key Manager

WSO2 API Manager supports multiple Key Managers at the same time. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager, and with the use of connectors, it is capable of supporting any authorization server as a Key Manager.

WSO2 API Manager can connect PingFederate out-of-the-box using the [WSO2 API-M PingFederate Connector](https://github.com/wso2-extensions/apim-km-pingfederate).

Follow the instructions given below to configure PingFederate as a third-party Key Manager:

## Step 1 - Configure PingFederate

1. Sign in to the PingFederate Management Console.

    `https://localhost:9999/pingfederate/app`

2. Click **OAuth Clients** and create a client with the following information in order to introspect the tokens.

     <table>
     <tr><td> <b>CLIENT ID</b> </td><td> apim-client </td></tr><tr>
     <td> <b>ALLOWED GRANT TYPES</b> </td><td> Access Token Validation (Client is a Resource Server) </td></tr>
     </table>

    [![PingFederate - add client]({{base_path}}/assets/img/administer/pingfederate-client-create-1.png)]({{base_path}}/assets/img/administer/pingfederate-client-create-1.png)

    [![PingFederate - add client]({{base_path}}/assets/img/administer/pingfederate-client-create-2.png)]({{base_path}}/assets/img/administer/pingfederate-client-create-2.png)

3. Generate and store the Client Secret.

     [![PingFederate client secret]({{base_path}}/assets/img/administer/pingfederate-client-secret.png)]({{base_path}}/assets/img/administer/pingfederate-client-secret.png)

## Step 2 - Configure PingFederate

1. Import the PingFederate certificate into the WSO2 API Manager truststore.

    1. The default PingFederate keystore can found under the **Certificate & Key Management** section on the **SSL Server Certificates** page.

         [![SSL Server Certificate]({{base_path}}/assets/img/administer/ping-federate-ssl-certificate.png)]({{base_path}}/assets/img/administer/ping-federate-ssl-certificate.png)

    2. Export the certificate from SSL server certificates.

         [![SSL Server Certificate Import]({{base_path}}/assets/img/administer/ping-federate-ssl-certificate-export.png)]({{base_path}}/assets/img/administer/ping-federate-ssl-certificate-export.png)

    3. Import the certificate into the WSO2 API-M truststore.

          ```
          keytool -import -trustcacerts -alias pingfederate -file ping.crt -keystore client-truststore.jks -storepass wso2carbon -noprompt
          ```

2. Start WSO2 API Manager.

     `<API-M_HOME>` refers to the root folder of the extracted WSO2 API-M distribution.

3. Add a Key Manager.

    1. Sign in to the Admin Portal. 

         `https://<hostname>:9443/admin`

         `https://localhost:9443/admin`

    2. Click Key Manager and then click **Add Key Manager**.

         [![Add new Key Manager]({{base_path}}/assets/img/administer/add-new-key-manager.png)]({{base_path}}/assets/img/administer/add-new-key-manager.png)

    3. Add the following configuration to add a new Key Manager.

         [![Add PingFederate configurations]({{base_path}}/assets/img/administer/pingfederate-endpoints.png)]({{base_path}}/assets/img/administer/pingfederate-endpoints.png)

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
            </br> Example: </br>https://localhost:9031</br>
               https://localhost:9031</td>
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
            </br> Example: </br>https://localhost:9031/pf-ws/rest/oauth/clients
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Introspection Endpoint</td>
            <td>The endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth client.
            </br> Example: </br>
            https://localhost:9031/as/introspect.oauth2 </br>
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="even">
            <td>Token Endpoint</td>
            <td>The endpoint that issues the access tokens.
            </br> Example: </br>
            https://localhost:9031/as/token.oauth2</br>
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
            <td>Username</td>
            <td>The Administrative user's username to invoke the client registration endpoint. </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Client Secret</td>
            <td>The Administrative user's password to invoke the client registration endpoint.</td>
            <td>Mandatory</td>
          </tr>
          <tr class="even">
            <td>Client ID</td>
            <td>The client ID obtained from PingFederate to validate tokens from Introspection endpoint</td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Client Secret</td>
            <td>The client secret obtained from PingFederate to validate tokens from Introspection endpoint.</td>
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
            <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This URL returns PingFederate's public key set in JSON web key set format.
            This contains the signing key(s) the Relying Party (RP) uses to validate signatures from PingFederate.</td>
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
                For the PingFederate it should be <b>JWT</b> and it is required to specify a claim mapping as a unique identifier.
            </br> Example: </br> Claim Key : iss
            </br>Claim Value : https://localhost:9031 </td>
            <td>Optional</td>
          </tr>
          <tr class="even">
            <td><b>Token Handling Options</b></td>
            <td>Provides a way to validate the token for this particular authorization server.
            This is mandatory if the Token Validation Method is <b>introspect</b></td>
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

## Step 3 - Generate keys using the PingFederate Key Manager

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    `https://localhost:9443/devportal`

2. Click **Applications**.
3. Create a new application or use the default application.
4. Click **Production Keys**.

     ![PingFederate Developer Portal generate keys]({{base_path}}/assets/img/administer/ping-devportal-generate-keys.png)

5. Click **Generate Keys**.

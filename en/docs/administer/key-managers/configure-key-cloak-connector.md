# Configure Key Cloak as a Key Manager

With the introduction of multiple key managers support for WSO2 API Manager(since v3.2.0), WSO2 API Manager is prepacked with an inbuilt resident key manager and is capable of supporting any authorization server as a key manager by using connectors.
It enables connecting Key Cloak out of the box with the [WSO2 APIM Keycloak Connector](https://github.com/wso2-extensions/apim-keymanager-keycloak).

Please follow the steps given below to configure Key Cloak as a third-party Key Manager component.
Alternatively [Key Cloak documentation](https://www.keycloak.org/docs/latest/getting_started/) provides the details.

1. Login to KeyCloak Management.
http://localhost:8080/auth

2. Goto Client Scopes
[![]({{base_path}}/assets/img/administer/keycloak-scopes.png)]

3. Create <b>default</b> Client Scope
![]({{base_path}}/assets/img/administer/keycloak-add-client-scope-default.png)

4. Goto Clients and create a confidential type client.
![]({{base_path}}/assets/img/administer/keycloak-add-client.png)

   !!! Note:
       Set the Access Type to Credentials
       Valid Redirect URIs ex: https://localhost:9443/*

5. Configure a longer value into Access Token life span in Advance Settings.
[![]({{base_path}}/assets/img/administer/keycloak-set-expiry-time.png)]

6. Goto Client Scopes and Add default scope as Default Client scope
[![]({{base_path}}/assets/img/administer/keycloak-add-to-client-scopes.png)]

7. Goto Service Account roles and assign admin role as assign role.
[![]({{base_path}}/assets/img/administer/keycloak-serviceaccount-assign-admin.png)]

8. Copy Client Credentials from Credentials tab.
[![]({{base_path}}/assets/img/administer/keycloak-client-secret.png)]

Now required Key Cloak configurations are done.
Next it is required to configure the key cloak in WSO2 API Manager. For that

9. Import key cloak certificate into WSO2 API Manager trust store.

 Key Cloak default keystore is application.keystore.
 In a stand alone setup, the application.keystore can be found in <KEYCLOAK_HOME>/standalone/configuration directory.
 Alternatively, following command can be used to generate a self-signed certificate in KeyCloak.

`keytool -genkey -alias server -keyalg RSA -keysize 2048 -validity 3650 -keystore application.keystore -dname "CN=localhost,OU=Support,O=WSO2,L=Colombo,S=Western,C=LK" -storepass password -keypass password -noprompt -ext SAN=dns:localhost`


Please note that the alias should be <b>server<b>.


Following command can be used to export the certificate in application.keystore

```
keytool -export -alias server -file keycloak.crt -keystore application.keystore -storepass password -noprompt
```

Alternatively KeyCloak official documentation provides information on [Enabling SSL/HTTPS for the Keycloak Server](https://www.keycloak.org/docs/latest/server_installation/)



To import the certificate into APIM truststore, the following command can be used:

`keytool -import -trustcacerts -alias keycloak -file keycloak.crt -keystore client-truststore.jks -storepass wso2carbon -noprompt`

9. Start WSO2 API Manager Server.

    `<APIM_HOME>` will refer to the root folder of the extracted WSO2 APIM.

9. Login to [admin portal](https://localhost:9443/admin)

10. Navigate to keymanagers tab in the left panel and Click on Add Keymanager button to add a new key manager configuration.
 ![Add new Key Manager]({{base_path}}/assets/img/administer/add-new-key-manager.png)

11. Add  key manager configurations as below.
 ![Add Key Cloak configurations]({{base_path}}/assets/img/administer/keycloak-endpoints.png)
  The below table provides definitions for each configuration.

    <table>
      <thead>
        <tr class="header">
          <th>Configuration</th>
          <th>Description</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr class="odd">
          <td>Name</td>
          <td>Name of the Authorization Server</td>
          <td>Mandatory</td>
        </tr>
        <tr class="even">
          <td>Display Name</td>
          <td>A Name to display on the UI</td>
          <td>Mandatory</td>
        </tr>
        <tr class="odd">
          <td>Description</td>
          <td>A brief description of the key manager</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>Key Manager Type</td>
          <td>Type of the Key Manager to be selected</td>
          <td>Mandatory</td>
        </tr>
        <tr class="odd">
          <td>Well-known-url</td>
          <td><p>Well known URL of the Authorization Server(Key Manager)
           ex: https://localhost:8443/auth/realms/master/clients-registrations/openid-connect
           If the Well known URL is provided, other endpoints can be imported. </p></td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>Issuer</td>
          <td>Issuer that consume/validate access tokens
           ex: https://localhost:8443/auth/realms/master</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td><b>Key Manager Endpoints</b></td>
          <td></td>
          <td></td>
        </tr>
        <tr class="even">
           <td>Client Registration Endpoint </td>
           <td><p>Endpoint to verify the identity and obtain profile information of the end user based on the authentication performed by an authorization server</p></td>
           <td>Optional if the well-known URI is provided</td>
        </tr>
        <tr class="odd">
           <td>Introspection Endpoint</td>
           <td><p>Endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth Client</p>
           <td>Optional if the well-known URI is provided</td>
        </tr>
        <tr class="even">
           <td>Token Endpoint</td>
           <td>Endpoint that issue access tokens</td>
           <td>Optional</td>
         </tr>
         <tr class="odd">
           <td>Revoke Endpoint</td>
           <td>Endpoint that revoke access tokens</td>
           <td>Optional</td>
        </tr>
        <tr class="even">
           <td>Userinfo Endpoint</td>
          <td>Endpoint That allow clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td>Authorize Endpoint</td>
          <td>Endpoint to obtain an authorization grant from the resource owner via user-agent redirection.</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>Scope Management Endpoint </td>
          <td>Endpoint for the management of scopes</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td><b>Connector Configurations</b></td>
          <td></td>
          <td>Mandatory</td>
        </tr>
        <tr class="even">
          <td>Client ID</td>
          <td>Client ID obtained in key cloak for the confidential type client ex: apim-client</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>Client Secrete</td>
          <td>Client Secret obtained in key cloak for the confidential type client(Credentials tab)</td>
          <td></td>
        </tr>
        <tr class="even">
          <td><b>Claim URIs</b></td>
          <td>Provide claim URIs for consumer key and scopes.</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>Consumer Key Claim URI</td>
          <td>Claim URI for consumer key</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>Scopes Claim URI</td>
          <td>Claim URI for scopes</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td>Grant Types</td>
          <td>Supported grant types </td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td><b>Certificates</b></td>
          <td></td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>PEM</td>
          <td>Either Copy and Paste the certificate in PEM format or upload the PEM file</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>JWKS</td>
          <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This url returns the Key Cloak's public key set in Json web key set format.
          This contains the signing key(s) the RP uses to validate signatures from the Key Cloak.</td>
          <td>Optional<td/>
        </tr>
        <tr class="odd">
          <td><b>Advanced Configurations</b></td>
          <td>Token Generation</td>
          <td></td>
        </tr>
        <tr class="even">
          <td>Token Generation</td>
          <td>Enables the token generation from the authorization server</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td>Out Of Band Provisioning</td>
          <td>Enables provisioning auth clients created outside the developer portal such as previously created once</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>Oauth App Creation</td>
          <td>Enables creating of auth clients</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td><b>Token Validation Method</b></td>
          <td>Method to validate JWT signature</td>
          <td></td>
        </tr>
        <tr class="even">
          <td>Self Validate JWT</td>
          <td>JWT token signature validation happens by the kid value. If the kid value is not present, gateway_certificate_alias is used.</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td>Use introspect</td>
          <td>JWT token signature validation happens by the JWKS endpoint</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td><b>Token Handling Options</b></td>
          <td>Enables to provide a mean of validating the token for this particular Authorization Server</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>REFERENCE</td>
          <td>tokens matching to a specific regular expression is validated.</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>JWT</td>
          <td>tokens matching to a specific JWT is validated.</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td>CUSTOM</td>
          <td>Token matching to a custom pattern is validated.</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td><b>Claim Mappings</b></td>
          <td>Local and Remote claim mapping</td>
          <td>Optional</td>
        </tr>
      </tbody>
      </table>


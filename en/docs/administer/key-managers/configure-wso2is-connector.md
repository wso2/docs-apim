# Configure WSO2 IS as a Key Manager

WSO2 API Manager supports multiple Key Managers. As a result, WSO2 API Manager is prepacked with an inbuilt resident Key Manager and it has the inbuilt capability of configuring WSO2 Identity Server (WSO2 IS) as a Key Manager.

Follow the steps given below to configure WSO2 IS as a Key Manager component:

## Step 1 - Configure WSO2 IS

1. Download and install the [WSO2 Identity Server 5.11.0](https://wso2.com/identity-and-access-management/previous-releases/).
     
     If you downloaded the archive, extract it.
   `<IS_HOME>` refers to the root folder of the extracted WSO2 IS.

2. Add following configurations in the `<IS_HOME>/repository/conf/deployment.toml` file.

    ```toml
    [[event_listener]]
    id = "token_revocation"
    type = "org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"
    name = "org.wso2.is.notification.ApimOauthEventInterceptor"
    order = 1
    [event_listener.properties]
    notification_endpoint = "https://localhost:9443/internal/data/v1/notify"
    username = "${admin.username}"
    password = "${admin.password}"
    'header.X-WSO2-KEY-MANAGER' = "WSO2-IS"

    [[resource.access_control]]
    context = "(.)/keymanager-operations/user-info/claims(.)"
    secure = true
    http_method = "GET"
    permissions = "/permission/admin/manage/identity/usermgt/list"
    scopes = "internal_user_mgt_list"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/user-info/claims/generate"
    secure = true
    http_method = "POST"
    permissions = "/permission/admin/manage/identity/usermgt/list"
    scopes = "internal_user_mgt_list"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register"
    secure = true
    http_method = "POST"
    permissions = "/permission/admin/manage/identity/applicationmgt/create"
    scopes = "internal_application_mgt_create"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register(.*)"
    secure = true
    http_method = "GET"
    permissions = "/permission/admin/manage/identity/applicationmgt/view"
    scopes = "internal_application_mgt_view"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register(.*)"
    secure = true
    http_method = "PUT"
    permissions = "/permission/admin/manage/identity/applicationmgt/update"
    scopes = "internal_application_mgt_update"
    
    [[resource.access_control]]
    context = "(.)/keymanager-operations/dcr/register(.)"
    secure = true
    http_method = "POST"
    permissions = "/permission/admin/manage/identity/applicationmgt/update"
    scopes = "internal_application_mgt_update"

    [[resource.access_control]]
    context = "(.*)/keymanager-operations/dcr/register(.*)"
    secure = true
    http_method = "DELETE"
    permissions = "/permission/admin/manage/identity/applicationmgt/delete"
    scopes = "internal_application_mgt_delete"

    [tenant_context.rewrite]
    custom_webapps = ["/keymanager-operations/"]
    ```

3. Download the [WSO2 IS Connector]({{base_path}}/assets/attachments/administer/wso2is-extensions-1.2.10.zip).

4. Extract the distribution and copy the following JAR files to the `<IS_HOME>/repository/components/dropins` directory.

     - `wso2is.key.manager.core-1.2.10.jar`
     - `wso2is.notification.event.handlers_1.2.10.jar`

5. Add `keymanager-operations.war` to the `<IS_HOME>/repository/deployment/server/webapps` directory.

6. Start WSO2 Identity Server with a port offset.
   portOffset is required only if you are running both API-m and ID in the same JVM.

      `sh wso2server.sh -DportOffset=1`

## Step 2 - Configure WSO2 API Manager

1. Start WSO2 API Manager.

     `<APIM_HOME>` refers to the root folder of the extracted WSO2 APIM.

2. Sign in to the Admin Portal. 
 
     `https://<hostname>:9443/admin`

     `https://localhost:9443/admin`

3. Click **Key Managers** and then click **Add Key Manager** to add the configuration related to a new Key Manager.

     ![Add new Key Manager]({{base_path}}/assets/img/administer/add-key-manager.png)

4. Add the  Key Manager configurations.
  
     ![Add wso2is configurations]({{base_path}}/assets/img/administer/wso2is-km-configuration.png)

     The following table provides definitions for each configuration.

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
      <td>The type of the Key Manager to be selected.</br>
       e.g., WSO2 Identity Server</td>
      <td>Mandatory</td>
      </tr>
      <tr class="odd">
      <td>Well-known-url</td>
      <td>The well-known URL of the authorization server (Key Manager).</td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td>Issuer</td>
      <td>The issuer that consumes or validates access tokens </br>e.g., https://localhost:9444/services</td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td><b>Key Manager Endpoints</b></td>
      <td></td>
      <td></td>
      </tr>
      <tr class="even">
      <td>Client Registration Endpoint </td>
      <td><p>The endpoint that verifies the identity and obtain profile information of the end-user based on the authentication performed by an authorization server.</br>
        e.g., https://localhost:9444/keymanager-operations/dcr/register</p></td>
      <td>Optional if the well-known URI is provided.</td>
      </tr>
      <tr class="odd">
      <td>Introspection Endpoint</td>
      <td><p>The endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth Client.</br>
        e.g., https://localhost:9444/oauth2/introspect</p></td>
      <td>Optional if the well-known URI is provided.</td>
      </tr>
      <tr class="even">
      <td>Token Endpoint</td>
      <td>The endpoint that issues the access tokens.</br>
        e.g., https://localhost:9444/oauth2/token</td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td>Revoke Endpoint</td>
      <td>The endpoint that revokes the access tokens.</br>
        e.g., https://localhost:9444/oauth2/revoke</td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td>Userinfo Endpoint</td>
      <td><p>The endpoint that allows clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user.</br>
      e.g., https://localhost:9444/oauth2/userinfo?schema=openid</p></td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td>Authorize Endpoint</td>
      <td>The endpoint used to obtain an authorization grant from the resource owner via the user-agent redirection.</br>
      e.g., https://localhost:9444/oauth2/authorize</td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td>Scope Management Endpoint </td>
      <td>The endpoint used to manage the scopes.</br>
      e.g., https://wso2is.com:9444/api/identity/oauth2/v1.0/scopes</td>
      <td>Mandatory</td>
      </tr>
      <tr class="odd">
      <td><b>Connector Configurations</b></td>
      <td></td>
      <td></td>
      </tr>
      <tr class="even">
      <td>Username</td>
      <td>The username of an admin user who is authorized to connect to the authorization server.</td>
      <td>Mandatory</td>
      </tr>
      <tr class="odd">
      <td>Password</td>
      <td>The password corresponding to the latter mentioned admin user who is authorized to connect to the authorization server.</td>
      <td>Mandatory</td>
      </tr>
      <tr class="even">
      <td><b>Claim URIs</b></td>
      <td>Provide the claim URIs for the consumer key and the scopes.</td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td>Consumer Key Claim URI</td>
      <td>The claim URI for the consumer key.</td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td>Scopes Claim URI</td>
      <td>The claim URI for the scopes.</td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td>Grant Types</td>
      <td>The supported grant types. Add multiple grant types by adding a grant type press Enter.</br>
       e.g., refresh_token, password, client_credentials, authorization_code</td>
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
      <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This URL returns the Identity Server's public key set in JSON web key set format.
      This contains the signing key(s) the Relying Party (RP) uses to validate signatures from the Identity Server. </br>
      e.g., https://localhost:9443/oauth2/jwks</td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td><b>Advanced Configurations</b></td>
      <td></td>
      <td></td>
      </tr>
      <tr class="even">
      <td>Token Generation</td>
      <td>This enables token generation via the authorization server.</td>
      <td>Mandatory</td>
      </tr>
      <tr class="odd">
      <td>Out Of Band Provisioning</td>
      <td>This enables the provisioning of Auth clients that have been created without the use of the Developer Portal, such as previously created Auth clients.</td>
      <td>Mandatory</td>
      </tr>
      <tr class="even">
      <td>Oauth App Creation</td>
      <td>This enables the creation of Auth clients.</td>
      <td>Mandatory</td>
      </tr>
      <tr class="odd">
      <td><b>Token Validation Method</b></td>
      <td>The method used to validate the JWT signature.</td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td>Self Validate JWT</td>
      <td>The kid value is used to validate the JWT token signature. If the kid value is not present, `gateway_certificate_alias` will be used.</td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td>Use introspect</td>
      <td>The JWKS endpoint is used to validate the JWT token signature.</td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td><b>Token Handling Options</b></td>
      <td>This provides a way to validate the token for this particular authorization server.
      This is mandatory if the Token Validation Method is <b>introspect</b></td>
      <td></td>
      </tr>
      <tr class="odd">
      <td>REFERENCE</td>
      <td>The tokens that match a specific regular expression (regEx) are validated.
      e.g., <code>[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}</code></td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td>JWT</td>
      <td>The tokens that match a specific JWT are validated.</td>
      <td>Optional</td>
      </tr>
      <tr class="odd">
      <td>CUSTOM</td>
      <td>The token that match a custom pattern are validated.</td>
      <td>Optional</td>
      </tr>
      <tr class="even">
      <td><b>Claim Mappings</b></td>
      <td>Local and remote claim mapping.</td>
      <td>Optional</td>
      </tr>
      </tbody>
      </table>

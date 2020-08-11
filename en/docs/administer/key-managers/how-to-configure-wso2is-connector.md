# Configuring WSO2 IS as a Key Manager

With the introduction of multiple key managers support for WSO2 API Manager(since v3.2.0), WSO2 API Manger is prepacked with an inbuilt resident key manager and it has the inbuilt capability of configuring WSO2 IZ as a third-party Key Manager

Follow the steps given below to configure WSO2 IS as a third party Key Manager component.

### Step 1 : Configuring WSO2 IS

1. Download and install latest WSO2 Identity Server from [here](https://wso2.com/identity-and-access-management/).
   If you downloaded the archive, extract it.
   `<IS_HOME>` will refer to the root folder of the extracted WSO2 IS.

2. Add following configurations in `<IS_HOME>/repository/conf/deployment.toml`

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
    'header.X-WSO2-KEY-MANAGER' = "WSO2IS"

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
    context = "(.*)/keymanager-operations/dcr/register(.*)"
    secure = true
    http_method = "DELETE"
    permissions = "/permission/admin/manage/identity/applicationmgt/delete"
    scopes = "internal_application_mgt_delete"

    [tenant_context.rewrite]
    custom_webapps = ["/keymanager-operations/"]
    ```

3. Download the [WSO2 IS Connector](({{base_path}}/assets/attachments/administer/key-managers/wso2is-km-connector-1.0.15.zip))


4. Extract the distribution. Copy the following jar files to the `<IS_HOME>/repository/components/dropins` directory.

    `wso2is.key.manager.core-1.0.15`

     `wso2is.notification.event.handlers_1.0.15`

6. Add `keymanager-operations.war` to the `<IS_HOME>/repository/deployment/server/webapps` directory


7. Start WSO2 IS

### Step 2 : Configuring WSO2 API Manager

    `<APIM_HOME>` will refer to the root folder of the extracted WSO2 APIM.

1. Sign in to [admin portal](https://localhost:9443/admin)

2. Navigate to key Managers tab in the left panel and Click on Add Key Manager button to add a new key manager configuration.
 ![Add new Key Manager]({{base_path}}/assets/img/administer/add-key-manager.png)

3. Add  key manager configurations as below.
 ![Add wso2is configurations]({{base_path}}/assets/img/administer/wso2is-km-configuration.png)
  Below table provides definitions for each configuration.

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
         <td>Well known URL of the Authorization Server(Key Manager)</td>
         <td>Optional</td>
       </tr>
       <tr class="even">
         <td>Issuer</td>
         <td>Issuer that consume/validate access tokens ex: https://localhost:9444/services</td>
         <td>Optional</td>
       </tr>
       <tr class="odd">
         <td><b>Key Manager Endpoints</b></td>
         <td></td>
         <td></td>
       </tr>
       <tr class="even">
          <td>Client Registration Endpoint </td>
          <td><p>Endpoint to verify the identity and obtain profile information of the end user based on the authentication performed by an authorization server
           ex: https://localhost:9444/keymanager-operations/dcr/register</p></td>
          <td>Optional if the well-known URI is provided</td>
       </tr>
       <tr class="odd">
          <td>Introspection Endpoint</td>
          <td><p>Endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth Client
           ex: https://localhost:9444/oauth2/introspect</p></td>
          <td>Optional if the well-known URI is provided</td>
       </tr>
       <tr class="even">
          <td>Token Endpoint</td>
          <td>Endpoint that issue access tokens
           ex: https://localhost:9444/oauth2/token</td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td>Revoke Endpoint</td>
          <td>Endpoint that revoke access tokens
           ex: https://localhost:9444/oauth2/revoke</td>
          <td>Optional</td>
       </tr>
       <tr class="even">
          <td>Userinfo Endpoint</td>
         <td><p>Endpoint That allow clients to verify the identity of the end-user based on the authentication performed by an authorization server, as well as to obtain basic profile information about the end-user
          ex: https://localhost:9444/oauth2/userinfo?schema=openid</p></td>
         <td>Optional</td>
       </tr>
       <tr class="odd">
         <td>Authorize Endpoint</td>
         <td>Endpoint to obtain an authorization grant from the resource owner via user-agent redirection.
          ex: https://localhost:9444/oauth2/authorize</td>
         <td>Optional</td>
       </tr>
       <tr class="even">
         <td>Scope Management Endpoint </td>
         <td>Endpoint for the management of scopes
          ex: https://wso2is.com:9444/api/identity/oauth2/v1.0/scopes</td>
         <td>Optional</td>
       </tr>
       <tr class="odd">
         <td><b>Connector Configurations</b></td>
         <td></td>
         <td></td>
       </tr>
       <tr class="even">
         <td>Username</td>
         <td>Admin user who is authorized to connect to the  Authorization Server</td>
         <td>Mandatory</td>
       </tr>
       <tr class="odd">
         <td>Password</td>
         <td>passowrd</td>
         <td>Mandatory</td>
       </tr>
       <tr class="even">
         <td><b>Claim URIs</b></td>
         <td>Provide claim URIs for consumer key and scopes.</td>
         <td>Optional</td>
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
         <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This url returns the Identity Server's public key set in Json web key set format.
         This contains the signing key(s) the RP uses to validate signatures from the Identity Server.</td>
         <td>Optional<td/>
       </tr>
       <tr class="odd">
         <td><b>Advanced Configurations</b></td>
         <td></td>
         <td></td>
       </tr>
       <tr class="even">
         <td>Token Generation</td>
         <td>Enables the token generation from the authorization server</td>
         <td>Mandatory</td>
       </tr>
       <tr class="odd">
         <td>Out Of Band Provisioning</td>
         <td>Enables provisioning auth clients created outside the devpoler portal such as previously created once</td>
         <td>Mandatory</td>
       </tr>
       <tr class="even">
         <td>Oauth App Creation</td>
         <td>Enables creating of auth clients</td>
         <td>Mandatory</td>
       </tr>
       <tr class="odd">
         <td><b>Token Validation Method</b></td>
         <td>Method to validate JWT signature</td>
         <td>Optional</td>
       </tr>
       <tr class="even">
         <td>Self Validate JWT</td>
         <td>JWT token signature validation happens by the kid value. If the kid value is not present, gateway_certificate_alias will be used.</td>
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
         <td>tokens matching to a specific regEx will be validated.</td>
         <td>Optional</td>
       </tr>
       <tr class="even">
         <td>JWT</td>
         <td>tokens matching to a specific JWT will be validated.</td>
         <td>Optional</td>
       </tr>
       <tr class="odd">
         <td>CUSTOM</td>
         <td>Token matching to a custom pattern will be validated.</td>
         <td>Optional</td>
       </tr>
       <tr class="even">
         <td><b>Claim Mappings</b></td>
         <td>Local and Remote claim mapping</td>
         <td>Optional</td>
       </tr>
     </tbody>
     </table>


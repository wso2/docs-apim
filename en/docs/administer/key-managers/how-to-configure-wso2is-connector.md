# How to configure WSO2 Identity Server as a key manager

With the introduction of multiple key managers support for WSO2 API Manager(since v3.2.0), WSO2 API Manger is prepacked with an inbuilt resident key manager and is capable of supporting any authorization server as a key manager by means of connectors.
It also supports connecting WSO2 Identity Server out of the box.

Please follow the steps given below to configure WSO2 IS as third party Key Manager component.

1. Download and install latest WSO2 Identity Server from [here](https://wso2.com/identity-and-access-management/install/download/?type=downloader).
If you downloaded the archive please extract it.
`<IS_HOME>` will refer to the root folder of the extracted WSO2 IS.

2. Add following in `<IS_HOME>/repository/conf/deployment.toml`
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
http_method = "DELETE"
permissions = "/permission/admin/manage/identity/applicationmgt/delete"
scopes = "internal_application_mgt_delete"

[tenant_context.rewrite]
custom_webapps = ["/keymanager-operations/"]
```

3. Add below code snippet in `<IS_HOME>/repository/resources/conf/templates/repository/conf/identity/identity.xml.j2` under under `TenantContextsToRewrite -> WebApp`

      [![]({{base_path}}/assets/img/administer/wso2is-tenantcontextrewrite.png)]
   !!! tip
       identity.xml.j2 change will be included in a wum update in the IS.

4. Build [WSO2IS Connector repo](https://github.com/wso2-extensions/apim-km-wso2is) or download the `distribution.zip` from [maven repo](https://maven.wso2.org/nexus/content/repositories/releases/org/wso2/km/ext/wso2is/distribution/1.0.15/distribution-1.0.15.zip)


5. Extract the distribution. Copy the following jar files to the `<IS_HOME>/repository/components/dropins` directory.

    `wso2is.key.manager.core-1.0.15`

     `wso2is.notification.event.handlers_1.0.15`

6. Add `keymanager-operations.war` to the `<IS_HOME>/repository/deployment/server/webapps` directory


7. Start WSO2 IS

8. Start WSO2 API Manager Server.

    `<APIM_HOME>` will refer to the root folder of the extracted WSO2 APIM.

9. Login to [admin portal](https://localhost:9443/admin)

10. Navigate to keymanagers tab in the left panel and Click on Add Keymanager button to add a new key manager configuration.
 ![Add new Key Manager]({{base_path}}/assets/img/administer/add-new-key-manager.png)

11. Add  key manager configurations as below.
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
    <td>A brief description of the key manager
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
    <td>Description</td>
    <td>A brief description of the key manager
    <td>Optional</td>
    </tr>
     <tr class="odd">
     <td>Issuer</td>
     <td>Issuer that consume/validate access tokens ex: https://localhost:9444/services</td>
     <td>Mandatory</td>
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
    <td>Optional</td>
    </tr>
    <tr class="odd">
    <td>PEM</td>
    <td>Either Copy and Paste the certificate in PEM format or upload the PEM file</td>
    <td></td>
    </tr>
    <tr class="even">
    <td>JWKS</td>
    <td>"The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This url returns the Identity Server's public key set in Json web key set format.
        This contains the signing key(s) the RP uses to validate signatures from the Identity Server."
    </td>
    <td><td/>
    </tr>
    <tr class="odd">
    <td><b>Advanced Configurations</b></td>
    <td>Token Generation</td>
    <td></td>
    </tr>
    <tr class="even">
    <td>Display Name</td>
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
    <td>Mandatory</td>
    </tr>
    <tr class="even">
    <td>Self Validate JWT</td>JWT token signature validation happens by the kid value. If the kid value is not present, gateway_certificate_alias will be used.</td>A brief description of the key manager
    <td></td>
    </tr>
    <tr class="odd">
    <td>Use introspect</td>
    <td>JWT token signature validation happens by the JWKS endpoint</td>
    <td></td>
    </tr>
    <tr class="even">
    <td><b>Token Handling Options</b></td>
    <td>Enables to provide a mean of validating the token for this particular Authorization Server</td>
    <td>Optional</td>
    </tr>
    <tr class="odd">
    <td>REFERENCE</td>
    <td>tokens matching to a specific regEx will be validated.</td>
    <td></td>
    </tr>
    <tr class="even">
    <td>JWT</td>
    <td>tokens matching to a specific JWT will be validated.</td>
    <td></td>
    </tr>
    <tr class="odd">
    <td>CUSTOM</td>
    <td>Token matching to a custom pattern will be validated.</td>
    <td></td>
    </tr>
    <tr class="even">
    <td><b>Claim Mappings</b></td>
    <td>Local and Remote claim mapping
    <td>Optional</td>
    </tr>
    </tbody>
    </table>


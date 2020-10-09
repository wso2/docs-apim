# Configure Auth0 as a Key Manager

It is possible to integrate the WSO2 API Manager with an external Identity and Access Management server (IAM) using the Auth0 OAuth Authorization Server to manage the OAuth clients and tokens that are required by WSO2 API Manager. WSO2 API Manager has inbuilt support to consume APIs exposed by Auth0 OAuth.

Follow the instructions below to configure Auth0 as a third-party Key Manager:

!!! info
    For more information, see the [Getting Started Guide, which is under the official Auth0 documentation](https://auth0.com/docs/get-started).

## Step 1 - Configure Auth0

1.  Create an Auth0 account. Get the URL for the tenant and then sign in to the dashboard.

   [![auth0 dashboard]({{base_path}}/assets/img/administer/auth0-dashboard.png)]({{base_path}}/assets/img/administer/auth0-dashboard.png)

2.  Then you need to create an application to use the management API. Then need's to allow that application to use the management API.

    [![auth0 management api]({{base_path}}/assets/img/administer/auth0-management-api.png)]({{base_path}}/assets/img/administer/auth0-management-api.png)

    [![auth0 new application]({{base_path}}/assets/img/administer/auth0-new-application.png)]({{base_path}}/assets/img/administer/auth0-new-application.png)
    
    [![auth0 permission to use app]({{base_path}}/assets/img/administer/auth0-permission-to-use-app.png)]({{base_path}}/assets/img/administer/auth0-permission-to-use-app.png)
   
    Make sure you have granted all the permissions to Create, Manage Apps and Resource servers. 
   
3.  Create a custom API by navigating to APIs as below.

    [![auth0 create custom api]({{base_path}}/assets/img/administer/auth0-create-custom-api.png)]({{base_path}}/assets/img/administer/auth0-create-custom-api.png)

    <a name="step13"></a>
    
4.  Create a new scope named `default` for the API by navigating to permissions tab in the custom API.    

    [![auth0 create scope]({{base_path}}/assets/img/administer/auth0-create-scope.png)]({{base_path}}/assets/img/administer/auth0-create-scope.png)

## Step 2 - Configure WSO2 API Manager

1.  Log into the admin portal of the API Manager and add a new Key Manager.
    
    [![auth0 add app admin]({{base_path}}/assets/img/administer/auth0-add-app-admin.png)]({{base_path}}/assets/img/administer/auth0-add-app-admin.png)
    
2.  Then select the Key manager type as Auth0 and provide the relevant fields accordingly.

    [![auth0 km type]({{base_path}}/assets/img/administer/auth0-km-type.png)]({{base_path}}/assets/img/administer/auth0-km-type.png)
 
    **List of well know address could be found in advance section of the Auth0 Application settings**    
    
        Eg. https://my-tenant.us.auth0.com/.well-known/openid-configuration
    
    [![auth0 endpoints]({{base_path}}/assets/img/administer/auth0-endpoints.png)]({{base_path}}/assets/img/administer/auth0-endpoints.png)    
    
    The introspection endpoint will not be populated since it is not exposed in Auth0. Therefore, 
    set its value as <code>none</code>. Select the token validation method as <code>Self validate JWT</code> like below.
    
    [![auth0 token validation]({{base_path}}/assets/img/administer/auth0-token-validation.png)]({{base_path}}/assets/img/administer/auth0-token-validation.png)    

3.  Set the grant types which are allowed in Auth0 as below. The format of the grant types can be found in 
<a href="https://auth0.com/docs/applications/application-grant-types">this link</a>.
    
    [![auth0 grant types]({{base_path}}/assets/img/administer/auth0-grant-types.png)]({{base_path}}/assets/img/administer/auth0-grant-types.png)        
    
4.  The client ID, Client secret of the application created to invoke Manage API should be provided for the settings. You can get to the audience 
value from Manage API.

    [![auth0 connector configs]({{base_path}}/assets/img/administer/auth0-connector-configs.png)]({{base_path}}/assets/img/administer/auth0-connector-configs.png)    
    
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
                <br/> e.g., https://dev-ted144kt.us.auth0.com/.well-known/openid-configuration</p>
            </td>
            <td>Optional</td>
        </tr>
        <tr class="even">
            <td>Issuer</td>
            <td>The issuer that consumes or validates access tokens. <br/>e.g., https://dev-ted144kt.us.auth0.com/</td>
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
            <td>The introspection endpoint will not be populated since it is not exposed in Auth0. Therefore,
                set its value as <code>none</code></td>
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
            <td>Client ID</td>
            <td>The client ID generated when creating application Auth0.</td>
            <td>Mandatory</td>
        </tr>
        <tr class="odd">
            <td>Client Secret</td>
            <td>The client secret generated when creating application Auth0.</td>
            <td>Mandatory</td>
        </tr>
        <tr class="even">
            <td>Audience</td>
            <td>Audience of the Admin API. Can be found by navigating to the `Auth0 Management API` in Auth0</td>
            <td>Mandatory</td>
        </tr>
        <tr class="odd">
            <td><b>Claim URIs</b></td>
            <td>This provides claim URIs for the consumer key and the scopes.</td>
            <td>Mandatory</td>
        </tr>
        <tr class="even">
            <td>Consumer Key Claim URI</td>
            <td>The claim URI for consumer key e.g., azp</td>
            <td>Mandatory</td>
        </tr>
        <tr class="odd">
            <td>Scopes Claim URI</td>
            <td>The claim URI for scopes e.g., scope</td>
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
            <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This URL returns the Auth0's public key set in JSON web key set format.
                This contains the signing key(s) the Relying Party (RP) uses to validate signatures from the Auth0.
                </br>
                e.g., https://dev-ted144kt.us.auth0.com/.well-known/jwks.json
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
                This is not mandatory since the Token Validation Method cannot be <b>introspect</b> for Auth0</td>
            <td></td>
        </tr>
        <tr class="even">
            <td>Self Validate JWT</td>
            <td>The <code>kid</code> value is used to validate the JWT token signature. If the `<code>kid</code> value is not present, the <code>gateway_certificate_alias</code> is used.</td>
            <td>Optional</td>
        </tr>
        <tr class="odd">
            <td>Use introspect</td>
            <td>Cannot use this option since Auth0 does not expose an introspection endpoint</td>
            <td>Optional</td>
        </tr>
        <tr class="even">
            <td><b>Token Handling Options</b></td>
            <td>This provides a way to validate the token for this particular authorization server.</td>
            <td>Optional. 
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

5.  Finally, you can save the configs.

## Step 3 - Generate keys using the Auth0 Key Manager

1.  Create new application from the developer portal.

    [![auth0 dev app create]({{base_path}}/assets/img/administer/auth0-dev-app-create.png)]({{base_path}}/assets/img/administer/auth0-dev-app-create.png)    

2.  Then click either production or sandbox, Select Auth0 fill the relevant fields accordingly.

    [![auth0 app creation form]({{base_path}}/assets/img/administer/auth0-app-creation-form.png)]({{base_path}}/assets/img/administer/auth0-app-creation-form.png)    
    
    *Please note that Audience of the API field is mandatory to generate an access token for Auth0. Therefore, please provide it when the application keys generating.*
    
    You can get the audience of the api by checking the API.
    
    [![auth0 resource api]({{base_path}}/assets/img/administer/auth0-resource-api.png)]({{base_path}}/assets/img/administer/auth0-resource-api.png)    

3.  Once the keys generated, It will reflect in the UI.
    
    [![auth0 created app]({{base_path}}/assets/img/administer/auth0-created-app.png)]({{base_path}}/assets/img/administer/auth0-created-app.png)        
    
5. Finally, token will be generated successfully.

    [![auth0 success]({{base_path}}/assets/img/administer/auth0-success.png)]({{base_path}}/assets/img/administer/auth0-success.png)        

!!! tip
     If you want to generate the tokens with scopes, those scopes should have been defined in Auth0 as mentioned in 
     the <a href="#step13">Step 1 - (3)</a>.


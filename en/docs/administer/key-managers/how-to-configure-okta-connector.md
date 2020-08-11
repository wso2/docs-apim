# Configuring Okta as a Key Manager

In this guide, we explain how to integrate the WSO2 API Manager with an external Identity and Access Management server (IAM) using the Okta OAuth Authorization Server
to manage the OAuth clients and tokens required by WSO2 API Manager. WSO2 API Manager has the inbuilt support to consume APIs exposed by Okta OAuth.

Follow the instructions below to configure Okta as a third-party Key Manager

### Step 1 : Configuring Okta

Create an Okta developer account. Get the Instance URL, authorization server ID, API Key, and configure the access policy and the rule.

1. Go to the [Okta sign up page](https://developer.okta.com/signup/).

    ![alt text]({{base_path}}/assets/img/administer/okta-signup.png)

    Create an Okta account and get the Okta instance URL.
    E.g., [https://dev-735404.okta.com](https://dev-735404.okta.com)

2. Get the authorization server ID by following the steps below :

    1. Go to the **Authorization Servers** section in the **API** tab.
    2. Create a new authorization server. Alternatively, you can use the default server.
        ![alt text]({{base_path}}/assets/img/administer/okta-authorization-server.png)

    3. Add a default scope. For that select the authorization server (ex: default) and go to the **Scopes** tab and create a new scope (say default). Select the default tick.
        ![alt text]({{base_path}}/assets/img/administer/okta-default-scope.png)

        ![alt text]({{base_path}}/assets/img/administer/okta-scope-list.png)

3. Get the API key :

    1. Go to the **Authorization Servers** section in the **API** tab and select the **Tokens** tab.
    2. Click **Create Token** and provide the name for the token.
    3. After successful token creation, copy the Token value for the further use.

    ![alt text]({{base_path}}/assets/img/administer/okta-token.png)

4. Create Access Policies : If you already have at least one access policy in your authorization server, skip the following steps and go to `step 1: (5)`.

    1. In the Okta Developer Dashboard, navigate to **API > Authorization Servers**.
    2. Choose the name of an Authorization Server.
    3. Choose **Access Policies > Add Policy**
    4. Provide the requested information.
        ![alt text]({{base_path}}/assets/img/administer/okta-access-policy.png)
    5. Click **Create Policy** to save the policy.

5. Create Rules for Access Policy : If you already have at least one rule in your access policy,  skip the following steps and go to `step 1: (6)`.

    1. In the Okta Developer Dashboard, navigate to **API > Authorization Servers**.
    2. Choose the name of an authorization server, and select **Access Policies**.
    3. Choose the name of an access policy, and select **Add Rule**.
        ![alt text]({{base_path}}/assets/img/administer/okta-rule.png)
    4. Enter the requested information.
    5. Click **Create Rule** to save the rule.

6. Create OAuth application to get credentials to access the introspect api:

    1. Go to the **Applications** tab and select **Add Application** button.
    2. Select **Web** type in the list and select next
        ![alt text]({{base_path}}/assets/img/administer/okta-add-application-intro.png)
    3. Under the **Grant type allowed** section, tick **Client Credentials**
    4. Once app is created, note down the **Client ID** and **Client secret** under **Client Credentials** section.

7. Note down the Authorization server's setting by navigating to  **API > Authorization Servers**. Select the authorization server.

    ![alt text]({{base_path}}/assets/img/administer/okta-authorization-server-settings.png)


### Step 2: Configure WSO2 API Manager

1. Start **WSO2 API Manager**.
2. Sign in to the [admin portal](https://localhost:9443/admin)
3. Navigate to keymanagers tab in the left panel and Click on Add Keymanager button to add a new key manager configuration.
    ![Add new Key Manager]({{base_path}}/assets/img/administer/add-key-manager.png)

4. Add  key manager configurations as below.
    ![Okta Configuration]({{base_path}}/assets/img/administer/okta-admin-configuration.png)

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
          <td><p>Well known URL of the Authorization Server(Key Manager)
           If the Well known URL is provided, other endpoints can be imported. Ex: https://dev-599740.okta.com/oauth2/default/.well-known/oauth-authorization-server</p></td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>Issuer</td>
          <td>Issuer that consume/validate access tokens Ex: https://dev-599740.okta.com/oauth2/default</td>
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
          <td>API Key</td>
          <td>API key generated from section 6</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>Client ID</td>
          <td>Client ID generated from section 6</td>
          <td></td>
        </tr>
        <tr class="even">
          <td>Client Secrete</td>
          <td>Client Secret Client secret generated from section 6</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td><b>Claim URIs</b></td>
          <td>Provide claim URIs for consumer key and scopes.</td>
          <td>Mandatory</td>
        </tr>
        <tr class="even">
          <td>Consumer Key Claim URI</td>
          <td>Claim URI for consumer key ex: cid</td>
          <td>Mandatory</td>
        </tr>
        <tr class="odd">
          <td>Scopes Claim URI</td>
          <td>Claim URI for scopes ex: scp</td>
          <td>Mandatory</td>
        </tr>
        <tr class="even">
          <td>Grant Types</td>
          <td>Supported grant types </td>
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td><b>Certificates</b></td>
          <td></td>
          <td>Optional</td>
        </tr>
        <tr class="even">
          <td>PEM</td>
          <td>Either Copy and Paste the certificate in PEM format or upload the PEM file</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>JWKS</td>
          <td>The JSON Web Key Set (JWKS) endpoint is a read-only endpoint. This url returns the Okta's public key set in Json web key set format.
          This contains the signing key(s) the RP uses to validate signatures from the Okta.</td>
          <td><td/>
        </tr>
        <tr class="even">
          <td><b>Advanced Configurations</b></td>
          <td>Token Generation</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>Token Generation</td>
          <td>Enables the token generation from the authorization server</td>
          <td>Optional</td>
        </tr>
        <tr class="even">
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
          <td>Optional</td>
        </tr>
        <tr class="odd">
          <td>REFERENCE</td>
          <td>tokens matching to a specific regular expression is validated.</td>
          <td></td>
        </tr>
        <tr class="even">
          <td>JWT</td>
          <td>tokens matching to a specific JWT is validated.</td>
          <td></td>
        </tr>
        <tr class="odd">
          <td>CUSTOM</td>
          <td>Token matching to a custom pattern is validated.</td>
          <td></td>
        </tr>
        <tr class="even">
          <td><b>Claim Mappings</b></td>
          <td>Local and Remote claim mapping</td>
          <td>Optional</td>
        </tr>
      </tbody>
      </table>

### Step 3: Generate keys using Okta key manager

1. Login to Developer Portal.
2. Go to Applications
3. Create a new application ou use the default application
4. Go to Sandbox Keys menu from the Left menu.

   ![alt text]({{base_path}}/assets/img/administer/okta-devportal-generate-keys.png)

   !!!
      Response Type need to be selected from the drop down menu.
# Configure Forgerock as a Key Manager

WSO2 API Manager has the capability to support multiple Key Managers at the same time. So with the use of connectors, it is capable of supporting any authorization server as a Key Manager.
Additionally it is prepacked with an inbuilt resident Key Manager.

WSO2 API Manager can connect to Forgerock out-of-the-box using the [WSO2 API-M Forgerock Connector](https://github.com/wso2-extensions/apim-km-forgerock).

Follow the instructions given below to configure Forgerock as a third-party Key Manager:

### Configure Forgerock Server to work with APIM
We assume that you already have a Forgerock installation and follow the steps below to configure the Fogerock Authorization server to work with WSO2 API Manager.

#### Connfigure Oauth2 Provider
1. Go to the URL where the Forgerock Authorization server is deployed and <br> navigate to 
   Realms -> Top Level Realm. Top level realm which exists by default is the root realm and the examples and configurations in this guide are based on that.
   
    ![alt text]({{base_path}}/assets/img/administer/forgerock-realms.png)

2. Navigate to Root Realm -> Dashboard -> Configure Oauth provider -> Configure Ouath 2.0 and create an oauth provider by filling up the values.
   
    ![alt text]({{base_path}}/assets/img/administer/forgerock-createOauthProvider.png)   

3. Navigate to Root Realm -> Service Provider -> Oauth2 Provider-> Advance tab and configure scopes and signing algorithm of the created oauth2 provider as in the image
   
    ![alt text]({{base_path}}/assets/img/administer/forgerock-provider-advance-config.png)

4. Navigate to the Dynamic client registration tab and configure it to allow dynamic client registration as follows.
   
    ![alt text]({{base_path}}/assets/img/administer/forgerock-configure-dcr.png)
   
The other properties of the Oauth2 provider could be configured as per your requirement.   

#### Configure Oauth2 client   
Once the Oauth2 provider is configured, its time to create a static oauth client, whose keys will be used for dynamic client registration

1. Move to Realm -> Oauth 2.0 -> Applications -> Add client to create a client. Ensure to add the two scopes which are shown in the image while creating the client. These are rquired for dynamic client registration and introspection.
   
     ![alt text]({{base_path}}/assets/img/administer/forgerock-add-client.png)

2. Navigate to the above created client under Applications -> client Id of the App -> Core -> Access Token LifeTime and set a long value to Access Token LifeTime to obtain a registration access token which would be used to dynamically register and update clients.
    
3. Navigate to the advance tab and confure the grant type which you need to use to obtain the access token. Configue Password grant type to use the example in step 4.
   
      ![alt text]({{base_path}}/assets/img/administer/forgerock-client-grant.png)

4. Obtain a registration access token by curl or some rest client as follows. Ensure to obtain a long living as the above token is used for oauth clients creation and update.
   
    `curl --request POST --user "username:password" --data "grant_type=password&username=username&password=password&scope=dynamic_client_registration am-introspect-all-tokens" http://localhost:8080/openam/oauth2/realms/root/access_token`
   
     We recommend to create the above token in Reference format for encryption purposes within the API Manager. 
     The toggle button  available under the core configs of Oauth2 provider as shown in the image could be used to decide whether tokens should be created in Reference or JWT format. 
     So only while generating the registation token we recommend to disable it and you could enable it back once the registration token is generated.        
    
     ![alt text]({{base_path}}/assets/img/administer/forgerock-token-format.png)
    
5. Save the access token obtained through the previous step.

If you want to work with scopes then the relevant scopes should be assigned to the relevant oauth clients before hand.    

### Step 2: Configure WSO2 API Manager

1. Add the attached jar to `<API-M_HOME>`/repository/components/dropins/ 

2. Start WSO2 API Manager.

     `<API-M_HOME>` refers to the root folder of the extracted WSO2 API-M distribution.

3. Add a Key Manager.

    1. Sign in to the Admin Portal. 

         `https://<hostname>:9443/admin`

    2. Click Key Manager and then click **Add Key Manager**.
         ![Add Key Manger]({{base_path}}/assets/img/administer/add-key-manager.png)
    3. Add the following configuration to add a new Key Manager.

         ![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-1.png)
         ![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-2.png)
         ![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-3.png)
         ![Add ForgeRock configurations]({{base_path}}/assets/img/administer/forgerock-add-km-4.png)

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
            </br> Example: </br>http://localhost:8080/openam/oauth2</br>
            </td>
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
            </br> Example: </br>http://localhost:8080/openam/oauth2/register
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Introspection Endpoint</td>
            <td>The endpoint that allows authorized protected resources to query the authorization server to determine the set of metadata for a given token that was presented to them by an OAuth client.
            </br> Example: </br>
            http://localhost:8080/openam/oauth2/introspect</br>
            </td>
            <td>Mandatory</td>
          </tr>
          <tr class="even">
            <td>Token Endpoint</td>
            <td>The endpoint that issues the access tokens.
            </br> Example: </br>
            http://localhost:8080/openam/oauth2/access_token</br>
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
            <td>Registration Access token</td>
            <td>The token obtained using the registered static client</td>
            <td>Mandatory</td>
          </tr>
          <tr class="even">
            <td>Client ID</td>
            <td>The client Id of the static client to invoke the introspection endpoint. </td>
            <td>Mandatory</td>
          </tr>
          <tr class="odd">
            <td>Client Secret</td>
            <td>The client secret of the static client to invoke the introspection endpoint.</td>
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

## Step 3 - Generate keys using the ForgeRock Key Manager

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`

2. Click **Applications**.
3. Create a new application or use the default application.
4. Click **Production Keys**.

     ![ForgeRock Developer Portal generate keys]({{base_path}}/assets/img/administer/forgerock-devportal-genkeys.png)

5. Click **Generate Keys**.

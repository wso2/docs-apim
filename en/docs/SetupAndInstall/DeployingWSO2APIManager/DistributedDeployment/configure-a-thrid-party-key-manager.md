# Configure a Thrid Party Key Manager

The **Key Manager** handles all clients, security, and access token-related operations. In a typical API Manager production deployment, different components talk to the Key Manager component for achieving different tasks. The API Gateway connects with the Key Manager to check the validity of OAuth tokens, subscriptions, and API invocations. When a subscriber generates an access token to the application using the API Store, the Store makes a call to the Key Manager to create an OAuth App and obtains an access token. Similarly, to validate a token, the API Gateway calls the Key Manager, which fetches and validates the token details from the database. For more information, see [Key Manager](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-KeyManager) .

The Key Manager decouples the OAuth client and access token management from the rest of its operations, so that you can plug in a third-party OAuth provider for managing OAuth clients and access tokens. When working with an external Key Manager, you need to extend the required Key Manager interface(s), which are explained below, based on your requirements.

-   **[Key Manager interface](https://github.com/wso2/carbon-apimgt/blob/v6.1.81/components/apimgt/org.wso2.carbon.apimgt.api/src/main/java/org/wso2/carbon/apimgt/api/model/KeyManager.java)** - This interface handles functionalities of the API Store. It contains methods to create, update, get, and delete OAuth2 applications, to map the existing consumer keys and secrets, and to generate the application access tokens. For more information, see [Extending the Key Manager Interface](https://docs.wso2.com/display/AM260/Extending+the+Key+Manager+Interface) .
-   **[Key Validation handler](https://github.com/wso2/carbon-apimgt/blob/v6.1.81/components/apimgt/org.wso2.carbon.apimgt.keymgt/src/main/java/org/wso2/carbon/apimgt/keymgt/handlers/DefaultKeyValidationHandler.java)** - This interface handles functionalities of the Key Manager component. It contains methods to implement at API runtime to validate the token, subscriptions, and scopes, and also to generate JSON Web Tokens (JWTs). For more information, see [Extending Key Validation](https://docs.wso2.com/display/AM260/Extending+Key+Validation) .

Let's see what basic steps you need to follow when writing a Key Manager implementation that acts as the bridge between a third-party OAuth provider and WSO2 API Manager.

In this guide, we explain how to integrate WSO2 API Store with an external Identity and Access Management (IAM) by using the **Surf OAuth Authorization Server** , which is an open source IAM, to manage the OAuth clients and tokens required by WSO2 API Manager. We have a sample client implementation that consumes APIs exposed by Surf OAuth.

!!! note
This sample only extends the Key Manager interface.


Follow the instructions below to configure the third-party Key Manager:

-   [Step 1: Start the authorization server](#ConfigureaThridPartyKeyManager-Step1:Starttheauthorizationserver)
-   [Step 2: Configure WSO2 API Manager](#ConfigureaThridPartyKeyManager-Step2:ConfigureWSO2APIManager)
-   [Step 3: Run the sample](#ConfigureaThridPartyKeyManager-Step3:Runthesample)

### Step 1: Start the authorization server

1.  Download the binary located [here](https://github.com/Rajith90/surf-oauth-demo/blob/v2.1.0/resources/surf-oauth.war) and deploy it in a Tomcat server.

        !!! info
    Alternatively, you can build the OAuth Server from scratch and start the server by issuing the [mvn jetty:run](https://github.com/OAuth-Apis/apis/blob/master/README.md#getting-started) command in the `api-authorization-server-war` folder. Detailed steps for building and starting the server are provided [here](https://github.com/OAuth-Apis/apis/blob/master/README.md#getting-started) .

        !!! tip
    **Tip** : The Surf OAuth web application that you just downloaded has the following customizations:

    -   The `apis.application.properties` file is copied to the classpath.
    -   All the URLs starting with `localhost` are replaced by the loop back IP (127.0.0.1).
    -`org.surfnet.oaaas.noop.NoopAuthenticator` authenticator is set as the default authenticator.
    -   Token expiry time is increased to 99999 seconds. This ensures that the tokens issued for the web client last several months.


2.  Move the web application to the ROOT context to ensure that the Surf Oauth web applications work on Tomcat.

    ``` java
        rm -rf tomcat7/webapps/ROOT
        mv tomcat7/webapps/surf-oauth tomcat7/webapps/ROOT
    ```

3.  Access `http://127.0.0.1:8080/` to see the following page:
    ![]({{base_path}}/assets/attachments/126563044/126563117.png)    The server is now up and running.
4.  Follow the steps below to create a resource server.
    1.  In Surf OAuth, click the **Resource Servers** link where all the OAuth clients are grouped together.
    2.  Register a resource server representing WSO2 API Manager.
    3.  Add two scopes named `test` and `scope1` and save your changes.
        You will use them when creating clients.
        ![]({{base_path}}/assets/attachments/126563044/126563118.png)        The front end is now registered as a distinct client with the authorization server.
5.  Follow the steps to create an OAuth Client.
    1.  Click the **Access Tokens** link and note all the tokens issued for the web client.
        These tokens are obtained at the time you sign in, by a Javascript client running on the browser. The same token is then used for subsequent operations.
        ![]({{base_path}}/assets/attachments/126563044/126563119.png)    2.  Pick an active access token from the above list.
        You use it to create clients through WSO2 API Manager.
    3.  Get a registration endpoint that is needed to register the client.
        As Surf OAuth doesn’t support a spec-compliant client registration yet, you can use an endpoint with similar capabilities. For example, as shown below, you can enable Developer Tools in Google Chrome to see the URL and the request:
        ![]({{base_path}}/assets/attachments/126563044/126563120.png)
### Step 2: Configure WSO2 API Manager

1.  Build the demo.client available at <https://github.com/Rajith90/surf-oauth-demo/tree/v2.1.0> .

2.  Copy the JAR files that you built in to the `<API-M_HOME>/repository/components/lib` directory.

        !!! note
    If you are setting up a distributed environment, copy and paste the JAR files that you built in to the respective directories given below in the **Key Manager** node and the **Store** node respectively.

    -   API Key Manager - `<API-M_KEY_MANAGER_HOME>/repository/components/lib            `

    -   API Store - `<API-M_STORE_HOME>/repository/components/lib            `


3.  Uncomment the `<APIKeyManager>` element in the `/repository/conf/api-manager.xml` file, which is in the API Key Manager and API Store and change the values based on your third-party implementation.

        !!! tip
    **Tip:** Be sure to replace the `<RegistrationEndpoint>` and `<AccessToken>` elements with the client registration endpoint and the access token you obtained earlier in step 7 and 6. ConsumerKey and Secret should be that of the created resource server. Also change the `<hostname>` in the `<IntrospectionURL>` accordingly.

        !!! note
    The `nl.surfnet.demo.SurfOAuthClient` class, which is mentioned in the following example, extends the Key Manager interface.


    **Example**

    ``` java
        <APIKeyManager>
               <KeyManagerClientImpl>nl.surfnet.demo.SurfOAuthClient</KeyManagerClientImpl>
                <Configuration>    
                    <RegistrationEndpoint><Give the client registration endpoint you got in step 7></RegistrationEndpoint>
                    <AccessToken><Give the access token you got in step 6></AccessToken>
                    <IntrospectionURL>http://<hostname>:port/v1/tokeninfo</IntrospectionURL>
                    <ConsumerKey>xxx</ConsumerKey>
                    <ConsumerSecret>xxx</ConsumerSecret>
                </Configuration>
        </APIKeyManager> 
    ```

        !!! tip
    For a sample on Key Manager implementation, see the [WSO2 default Key Manager implementation](https://docs.wso2.com/download/attachments/97563674/AMDefaultKeyManagerImpl.java?version=1&modificationDate=1487913243000&api=v2) .


### Step 3: Run the sample

You have connected WSO2 API Manager with a third-part authorization server. Let's see how WSO2 API Manger creates OAuth clients at Surf OAuth when applications are registered in the API Store. In this guide, we use [Product APIs](https://docs.wso2.com/display/AM260/Product+APIs) to test invoke this process.

1.  Start [WSO2 API Manager](https://docs.wso2.com/display/AM260/Running+the+Product) .
2.  Sign in to the WSO2 API Store and create an application.

    ``` java
        curl -k -X POST -c cookies https://localhost:9443/store/site/blocks/user/login/ajax/login.jag -d 'action=login&username=admin&password=admin'
        curl -k -X POST -b cookies https://localhost:9443/store/site/blocks/application/application-add/ajax/application-add.jag -d 'action=addApplication&application=SurfClientApp&tier=Unlimited&description=&callbackUrl='
    ```

3.  Register an OAuth client of the type PRODUCTION in the authorization server.
    As shown below, you need to send the specific parameters required by the OAuth Server in JSON.

    ``` java
            curl -k -X POST -b cookies https://localhost:9443/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=generateApplicationKey&application=SurfClientApp&authorizedDomains=ALL&keytype=PRODUCTION&validityTime=3600&jsonParams={"scopes":["test"],"contactName":"John Doe","contactEmail":"john@doe.com"}'
    ```

4.  Go to the **Client Applications** link in the Surf OAuth UI.
    Note the newly created client listed there.
    ![]({{base_path}}/assets/attachments/126563044/126563121.png)    You have now created an application and registered an OAuth Client corresponding to it.
5.  Validate tokens by subscribing to a SurfClient application and obtaining a token.
    1.  Sign in to the API Publisher and deploy the sample API ( `PizzaShackAPI` ) if you haven't done so already.
        ![]({{base_path}}/assets/attachments/126563044/126563122.png)
    2.  Assuming you still have the OAuth client created earlier, subscribe to this API as follows:

        ``` java
                    curl -k -X POST -b cookies https://localhost:9443/store/site/blocks/subscription/subscription-add/ajax/subscription-add.jag -d 'action=addAPISubscription&name=PizzaShackAPI&version=1.0.0&provider=admin&tier=Unlimited&applicationName=SurfClientApp'
        ```

        Let's obtain a token from the OAuth Provider.

    3.  Go to the **Edit** view of the OAuth client and make sure the `client_credentials` grant type is enabled, and a token expiration time is specified.
        ![]({{base_path}}/assets/attachments/126563044/126563123.png)
    4.  Obtain a token.
        Replace `<ConsumerKey:ConsumerSecret>` with the Base64 encoded `ConsumerKey:ConsumerSecret` of the client application you just created.

        ``` java
                    curl -k -d "grant_type=client_credentials&scope=test" -H "Authorization: Basic <ConsumerKey:ConsumerSecret>" -H "Content-Type: application/x-www-form-urlencoded" https://localhost:8243/token
        ```

    5.  Update the token endpoint in the `<API-M_GATEWAY_HOME>/repository/deployment/server/synapse-configs/default/api/_TokenAPI_.xml` file accordingly.
    6.  Update the revoke endpoint in the `<API-M_GATEWAY_HOME>/repository/deployment/server/synapse-configs/default/api/_RevokeAPI_.xml` file accordingly.
    7.  If you use the authorization code grant type to generate tokens, update the authorize endpoint in the `<API-M_GATEWAY_HOME>/repository/deployment/server/synapse-configs/default/api/AuthorizeAPI.xml` file accordingly.

                !!! info
        The Token endpoint format for above e, f, and g steps is: http://&lt;surf-hostname&gt;:port/v1/token. A sample change done in \_TokenAPI\_.xml is as follows:

        ``` xml
                <api xmlns="http://ws.apache.org/ns/synapse" name="_WSO2AMTokenAPI_" context="/token">
                ...
                   <endpoint>
                      <http uri-template="http://<surf-hostname>:port/v1/token">
                         <timeout>
                            <duration>60000</duration>
                            <responseAction>fault</responseAction>
                         </timeout>
                      </http>
                   </endpoint>
                ...
                </api>
        ```


    8.  Invoke the API using the token obtained.

        ``` java
                curl -k -H "Authorization: Bearer 02316379-8c19-4d72-94d1-6306ea2703a4" "https://localhost:8243/pizzashack/1.0.0/menu"
        ```



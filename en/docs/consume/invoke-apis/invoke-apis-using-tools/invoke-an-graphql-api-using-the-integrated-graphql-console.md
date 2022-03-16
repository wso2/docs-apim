# Test a GraphQL API Using the Integrated GraphQL Console

WSO2 API Manager (WSO2 API-M) has an Integrated GraphiQL UI for the GraphQL APIs.

[GraphQL](https://github.com/graphql/graphiql) is the graphical, interactive, web-based GraphQL integrated development environment (IDE) for GraphQL query and it has a reference implementation from the GraphQL Foundation. 

GraphiQL UI supports full GraphQL Language Specification (Queries, Mutations, Subscriptions, Fragments, Unions, directives, multiple operations per query, etc.) and it provides interactive schema documentation, real-time error highlighting and reporting for queries and variables, automatic query and variables completion, it automatically adds the required fields to the queries, and also queries the history using local storage.

<!-- Feature removed for further improvement
!!! note "Try out using Postman"
    If required, instead of using the Integrated GraphQL Console you can try out your GraphQL API by downloading your GraphQL Schema as a Postman collection and trying it out on Postman. For more information, see [Try out using Postman]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/try-out-using-postman). -->

Follow the instructions below to use the GraphQL Console, which is in the WSO2 API Manager Developer Portal, to invoke a GraphQL API:

!!! Note
    You can only try out HTTPS based APIs via the GraphQL Console because the API Store runs on HTTPS.

The examples here use the `StarWarsAPI` GraphQL API, which was created in [Create a GraphQL API]({{base_path}}/design/create-api/create-a-graphql-api/).

1. Sign in to the WSO2 Developer Portal and click on an API (e.g., `StarWarsAPI`).

     `https://<hostname>:9443/devportal`

2. Subscribe to the GraphQL API (e.g., `StarWarsAPI` 1.0.0) using an application and an available throttling policy.

    [![Subscribe to the GraphQL API]({{base_path}}/assets/img/learn/subscribe-to-graphql-api.png)]({{base_path}}/assets/img/learn/subscribe-to-graphql-api.png)

3. Click **Applications** and open the application that you used to subscribe to the API.

4. Click **Production Keys** and navigate to **OAuth2 Tokens**.[![Navigate to OAuth Token]({{base_path}}/assets/img/learn/navigate-to-oauth-tokens-graphql-console.png)]({{base_path}}/assets/img/learn/navigate-to-oauth-tokens-graphql-console.png)

5. Scroll down and generate a production key
   
    [![Generate production key]({{base_path}}/assets/img/learn/graphql-generate-keys-production.png)]({{base_path}}/assets/img/learn/graphql-generate-keys-production.png)

    !!! tip
         **Production and Sandbox Tokens**
            
         To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more details, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip 
         **JWT vs OAuth tokens**

         If the application you are using for this example is self-contained (JWT), then **copy the generated access token** before proceeding to the next step. If the application is of OAuth type, then the GraphQL console will be automatically populated with the generated token in the authorization field.

6. Click **APIs** to navigate to the APIs and select the GraphQL API that you want to invoke. 

7. Click **Try Out** in the  **Overview** tab.

    [![Test GraphQL API]({{base_path}}/assets/img/learn/graphql-console-try-button.png)]({{base_path}}/assets/img/learn/graphql-console-try-button.png)

    This opens the GraphiQL UI (GraphQL Console) to test the StarWarsAPI.

8. Copy the generated access token to the Authorization field as shown below.

    [![Copy Access Token for tryout GraphQL API]({{base_path}}/assets/img/learn/graphql-api-copy-access-token.png)]({{base_path}}/assets/img/learn/graphql-api-copy-access-token.png)

9. Invoke the GraphQL API using the [GraphiQL console](#using-the-graphiql-console).

## Using the GraphiQL console

Let's see how to invoke a GraphQL API using the GraphiQL console, which is a type of GraphQL console.

### Invoke a GraphQL Query operation

Follow the instructios below to invoke a **GraphQL Query operation** using the GraphiQL console:

1. Enter the following sample query.

    ```
    query{
        human(id:1000){
            id
            name
        }
        droid(id:2000){
            name
            friends{
                name
                appearsIn
            }
        }
    }
          
    ```
 
2. Click **Execute**.

    [![Execute GraphQL Query]({{base_path}}/assets/img/consume/invoke-apis/graphql-console/graphql-console-execute-query.png)]({{base_path}}/assets/img/consume/invoke-apis/graphql-console/graphql-console-execute-query.png)

    !!! info "Troubleshooting"
        If you **cannot invoke the API's HTTPS endpoint** (this causes the **SSLPeerUnverified exception**), it could be because the security certificate issued by the server is not trusted by your browser. 
        
        To resolve this issue, access the HTTPS endpoint directly from your browser and accept the security certificate.
        
        If the API Manager has a **certificate signed by a Certificate Authority (CA)**, the HTTPS endpoints should work out-of-the-box.

     Note the successful response for the API invocation. 

     [![Response of GraphQL Query]({{base_path}}/assets/img/learn/graphql-response-query.png)]({{base_path}}/assets/img/learn/graphql-response-query.png)

You have now successfully invoked a GraphQL API using the GraphQL API Console.

### Invoke a GraphQL Subscription operation

Follow the instructios below to invoke a **GraphQL Subscription operation** using the GraphiQL console:

1. Enter the following sample query to execute a subscription operation via WebSockets.

    ```
    subscription {
        reviewAdded(episode: JEDI) {
            stars
            episode
            commentary
        }
    }
    ```

2. Click **Execute**. 
   
     If you inspect the network calls from your browser developer tools, you can see the messages passed between the GraphiQL client and the backend.

     [![Response of GraphQL Subscription]({{base_path}}/assets/img/consume/invoke-apis/graphql-console/graphql-sub-init-response.png)]({{base_path}}/assets/img/consume/invoke-apis/graphql-console/graphql-sub-init-response.png)

     Now a successful WebSocket connection is established between the client and backend via WSO2 API Gateway.

    !!! info "Troubleshooting"
        If you **cannot invoke the API's WSS endpoint during handshake** (this causes the **SSLPeerUnverified exception**), it could be because the security certificate issued by the server is not trusted by your browser. 
        
        This will result in the following error being printed in the backend.

        ```
        ERROR - InboundWebsocketSourceHandler Endpoint not found for port : 8099 tenant domain : null
        ```       
        
        To resolve this issue, access the corresponding HTTPS endpoint of the WSS endpoint directly from your browser and accept the security certificate. (e.g., `https://localhost:8099/swapi/1.0.0`) 
        
        If the API Manager has a **certificate signed by a Certificate Authority (CA)**, the WSS endpoints should work out-of-the-box.

     <a name="step3"></a>

3.  While keeping the Developer Portal web browser page opened, separately open a terminal and directly invoke the backend API’s `createReview` mutation operation by executing the following command.

     ```
     curl -X POST "http://localhost:8080/graphql" -H  "accept: application/json" -H  "Content-Type: application/json" -d '{"query":"mutation {createReview(episode: JEDI, review: { stars: 3, commentary: \"Excellent\"}) { stars   episode   commentary }}","variables":null}' -k
     ```

     When the mutation is successful, the GraphQL API will send the following message as a response:

     ```
     {"data":{"createReview":{"stars":3,"episode":"JEDI","commentary":"Excellent"}}}
     ```

4.  Go back to the Developer Portal browser page.

     You will notice that you have received a subscription event response corresponding to the mutation operation that you carried out in <a href="#step3">Step 3</a>.

     [![Response Event of GraphQL Subscription]({{base_path}}/assets/img/consume/invoke-apis/graphql-console/try-out-sub-event.png)]({{base_path}}/assets/img/consume/invoke-apis/graphql-console/try-out-sub-event.png)

     You have now successfully invoked a GraphQL API using the GraphQL API Console.

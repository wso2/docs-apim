# Invoke an GraphQL API using the Integrated GraphQL Console

WSO2 API Manager(WSO2 API-M) has an integrated GraphiQL UI for the GraphQL APIs.

[GraphiQL](https://github.com/graphql/graphiql) is the graphical, interactive, web-based GraphQL integrated development environment (IDE) for GraphQL query and It is reference implementation from the GraphQL foundation. 

GraphiQL UI supports full GraphQL Language Specification (Queries, Mutations, Subscriptions, Fragments, Unions, directives, multiple operations per query, etc) and it provides interactive schema documentation, real-time error highlighting and reporting for queries and variables, automatic query and variables completion, automatically adds required fields to queries, query History using local storage. 

Let's see how to use the GraphQL Console in the Store to invoke an GraphQL API.

!!! Note
    You can only try out HTTPS based APIs via the GraphQL Console because the API Store runs on HTTPS.


The examples here use the `StarWarsAPI` GraphQL API, which was created in [Create a GraphQL API]({{base_path}}/learn/design-api/create-api/create-a-graphql-api/) .

1.  Sign in to the WSO2 Develeoper Portal (`https://<hostname>:9443/devportal`) and click an API (e.g., `StarWarsAPI` ).

2.  Subscribe to the GraphQL API (e.g., `StarWarsAPI` 1.0.0) using an application and an available tier.

    [![Subscribe to the GraphQL API]({{base_path}}/assets/img/learn/subscribe-to-graphql-api.png)]({{base_path}}/assets/img/learn/subscribe-to-graphql-api.png)

3.  On the **Applications** menu, open the application you used to subscribe to the API. Click the **Production Keys** tab and click **Generate keys** to generate a production key.

    [![Generate production key]({{base_path}}/assets/img/learn/graphql-generate-keys-production.png)]({{base_path}}/assets/img/learn/graphql-generate-keys-production.png)

    !!! tip
        **Production and Sandbox Tokens**

        To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more details, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip
        **JWT vs Oauth tokens**

        If the application you are using for this example is self-contained(JWT), then **copy the generated access token** before proceeding to the next step. If the application is of oauth type, then the graphql console will be automatically populated with the generated token in the authorization field. 


4.  On the **APIs** menu, select the GraphQL API that you want to invoke.When the API opens, click on **Test** button under operations section.

    [![Test GraphQL API]({{base_path}}/assets/img/learn/graphql-console-test-button.png)]({{base_path}}/assets/img/learn/graphql-console-test-button.png)

5. This will open the GraphiQL UI(GraphQL Console) to test the StarWarsAPI. Copy the generated access token to the Authorization field as depicted in the following figure.

    [![Copy Access Token for tryout GraphQL API]({{base_path}}/assets/img/learn/graphql-api-copy-access-token.png)]({{base_path}}/assets/img/learn/graphql-api-copy-access-token.png)


6.  Enter the following sample query. Then click on execute button as follows.

    ```
    query{
        allFilms{
            title
            episodeId
        }
        allPlanets{
            films{
                species{
                    skinColor
                }
            }
        }
    }
          
    ```
 
    [![Execute GraphQL Query]({{base_path}}/assets/img/learn/graphql-console-execute.png)]({{base_path}}/assets/img/learn/graphql-console-execute.png)


    !!! Note
        **Troubleshooting**

        If you **cannot invoke the API's HTTPS endpoint** (this causes the **SSLPeerUnverified exception** ), it could be because the security certificate issued by the server is not trusted by your browser. To resolve this issue, access the HTTPS endpoint directly from your browser and accept the security certificate.
        
        If the API Manager has a **certificate signed by a Certificate Authority** (CA), the HTTPS endpoints should work out of the box.


    Note the successful response for the API invocation. 

    [![Response of GraphQL Query]({{base_path}}/assets/img/learn/graphql-response.png)]({{base_path}}/assets/img/learn/graphql-response.png)

You have now succesfully invoked a GraphQL API using the GraphQL API Console.


# Try out using Postman

Let's see how to download a GraphQL as a Postman collection.

1.  Click **Try Out** to go to the Try out section.If you haven't subscribed to this API, you should `Subscribe` to an API as mentioned above.

    Then choose the application name and click the `Postman collection` button to download the Postman collection.

 ![[Postman try out-graphQL]({{base_path}}/assets/img/learn/postman_try_out_graphql.png)]({{base_path}}/assets/img/learn/postman_try_out_graphql.png)
    
2.  As there's a security for the Postman collection, you have to get the authentication code. **Generate** the authentication code and **Copy** the access token you generted.(See the above step 05)

3. Open the Postman application and **Import** the Postman collection file you downloaded.

    ![[Import Postman- graphQL]({{base_path}}/assets/img/learn/postman_import_graphql.png)]({{base_path}}/assets/img/learn/postman_import_graphql.png)

4. Select a resource from the Postman collection to test.

5. Click the **Authorization** tab and select `Bearer Token` as the token type.

    ![[Token type -graphQL]({{base_path}}/assets/img/learn/postman_token_type_graphql.png)]({{base_path}}/assets/img/learn/postman_token_type_graphql.png)

6. Paste the copied token.

7. Click **Send** to proceed.

    ![[Put token-graphQL]({{base_path}}/assets/img/learn/postman_put_token_graphql.png)]({{base_path}}/assets/img/learn/postman_put_token_graphql.png)

8. You can see the result under the `Body` tab.

    ![[Postman result-grapgQL]({{base_path}}/assets/img/learn/postman_result_graphql.png)]({{base_path}}/assets/img/learn/postman_result_graphql.png)
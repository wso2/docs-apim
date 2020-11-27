# Invoke an GraphQL API using the Integrated GraphQL Console

WSO2 API Manager (WSO2 API-M) has an integrated GraphiQL UI for the GraphQL APIs.

[GraphiQL](https://github.com/graphql/graphiql) is the graphical, interactive, web-based GraphQL integrated development environment (IDE) for GraphQL query and it has a reference implementation from the GraphQL Foundation. 

GraphiQL UI supports full GraphQL Language Specification (Queries, Mutations, Subscriptions, Fragments, Unions, directives, multiple operations per query, etc.) and it provides interactive schema documentation, real-time error highlighting and reporting for queries and variables, automatic query and variables completion, it automatically adds the required fields to the queries, and also queries the history using local storage. 

Let's see how to use the GraphQL Console in the Developer Portal to invoke a GraphQL API.

!!! Note
    You can only try out HTTPS based APIs via the GraphQL Console because the API Store runs on HTTPS.

The examples here use the `StarWarsAPI` GraphQL API, which was created in [Create a GraphQL API]({{base_path}}/learn/design-api/create-api/create-a-graphql-api/).

1. Sign in to the WSO2 Developer Portal and click on an API (e.g., `StarWarsAPI`).

     `https://<hostname>:9443/devportal`

     <a name="step2"></a>

2. Subscribe to the GraphQL API (e.g., `StarWarsAPI` 1.0.0) using an application and an available throttling policy.

     [![Subscribe to the GraphQL API]({{base_path}}/assets/img/learn/subscribe-to-graphql-api.png)]({{base_path}}/assets/img/learn/subscribe-to-graphql-api.png)

3. Click **Applications** and open the application that you used to subscribe to the API. 


4. Click **Production Keys** and click **Generate keys** to generate a production key.

     [![Generate production key]({{base_path}}/assets/img/learn/graphql-generate-keys-production.png)]({{base_path}}/assets/img/learn/graphql-generate-keys-production.png)

    !!! tip "Production and Sandbox Tokens"

        To generate keys for the Sandbox endpoint, go to the **Sandbox Keys** tab. For more details, see [Maintaining Separate Production and Sandbox Gateways]({{base_path}}/learn/api-gateway/maintaining-separate-production-and-sandbox-gateways/#multiple-gateways-to-handle-production-and-sandbox-requests-separately).

    !!! tip "JWT vs OAuth tokens"

        If the application you are using for this example is self-contained (JWT), then **copy the generated access token** before proceeding to the next step. If the application is of OAuth type, then the GraphQL console will be automatically populated with the generated token in the authorization field. 


5. Click **APIs** to navigate to the APIs and select the GraphQL API that you want to invoke. 

6. Click **Test** under the **operations** section.

    [![Test GraphQL API]({{base_path}}/assets/img/learn/graphql-console-test-button.png)]({{base_path}}/assets/img/learn/graphql-console-test-button.png)

    This opens the GraphiQL UI (GraphQL Console) to test the StarWarsAPI. 

    <a name="generatetoken"></a>

7. Copy the generated access token to the Authorization field as shown below.

    [![Copy Access Token for tryout GraphQL API]({{base_path}}/assets/img/learn/graphql-api-copy-access-token.png)]({{base_path}}/assets/img/learn/graphql-api-copy-access-token.png)


8. Enter the following sample query.

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
 
9. Click **Execute**.

     [![Execute GraphQL Query]({{base_path}}/assets/img/learn/graphql-console-execute.png)]({{base_path}}/assets/img/learn/graphql-console-execute.png)


    !!! info "Troubleshooting"
        If you **cannot invoke the API's HTTPS endpoint** (this causes the **SSLPeerUnverified exception**), it could be because the security certificate issued by the server is not trusted by your browser. 
        
        To resolve this issue, access the HTTPS endpoint directly from your browser and accept the security certificate.
        
        If the API Manager has a **certificate signed by a Certificate Authority (CA)**, the HTTPS endpoints should work out-of-the-box.


    Note the successful response for the API invocation. 

    [![Response of GraphQL Query]({{base_path}}/assets/img/learn/graphql-response.png)]({{base_path}}/assets/img/learn/graphql-response.png)

You have now successfully invoked a GraphQL API using the GraphQL API Console.

## Try out using Postman

Let's see how to download a GraphQL as a Postman collection.

1. Click **Try Out** to go to the Try out section. 

2. Subscribe to an API <a href="#step2">as mentioned above</a> if you have not done so already.

3. Select the application name and click `Postman collection`.
     
     This downloads the Postman collection.

    ![[Postman try-out GraphQL]({{base_path}}/assets/img/learn/postman_try_out_graphql.png)]({{base_path}}/assets/img/learn/postman_try_out_graphql.png)
    
2.  As the Postman collection is secure obtain the authentication code. 

     **Generate** the authentication code and **copy** the access token that you generated as mentioned above in <a href="#generatetoken">step 9</a>.

3. Open the Postman application and click **Import** to import the Postman collection file that you downloaded.

    ![[Import Postman GraphQL]({{base_path}}/assets/img/learn/postman_import_graphql.png)]({{base_path}}/assets/img/learn/postman_import_graphql.png)

4. Select a resource from the Postman collection to test.

5. Click on the **Authorization** tab and select `Bearer Token` as the token type.

    ![[Token type GraphQL]({{base_path}}/assets/img/learn/postman_token_type_graphql.png)]({{base_path}}/assets/img/learn/postman_token_type_graphql.png)

6. Paste the copied token.

7. Click **Send** to proceed.

    ![[Put token GraphQL]({{base_path}}/assets/img/learn/postman_put_token_graphql.png)]({{base_path}}/assets/img/learn/postman_put_token_graphql.png)
    
    You can now see the result under the **Body** tab.

    ![[Postman result GraphQL]({{base_path}}/assets/img/learn/postman_result_graphql.png)]({{base_path}}/assets/img/learn/postman_result_graphql.png)

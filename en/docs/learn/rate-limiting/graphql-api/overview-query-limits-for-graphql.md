# GraphQL Rate Limiting Overview 

GraphQL is an open-source data query & manipulation language for APIs. It provides a common interface between the client and the server for data fetching and manipulations.

With GraphQL queries, the client which requests data has more flexibility compared to REST where it can request any amount of data it wishes. This flexibility comes at a cost since now the GraphQL service might have to do complex operations to serve each type of query it receives. To overcome this hardship, the query needs to be analysed before execution. Without any protection to the backend, we’ll be vulnerable to DoS attacks (due to excessive load to the server, database or network), which are caused by the execution of malicious and complex queries that are passed either
intentionally or unintentionally. 

Since clients have the possibility to request very complex queries, servers must be ready to handle them properly. 
**WSO2 API-Manager introduces Static Query Analyser to Secure GraphQL APIs** to address such issues.

### Static Query Analyser

Through the static query analyzer, we analyse the query and based on the previously set limitations/policy and block complex queries before it reaches the backend. Given below is the basic outline of the policies which are to be defined within the policy definition.

   - [Query Depth Limitation]({{base_path}}/learn/api-security/graphql-query-analysis/query-depth-limitation)
    
   - [Query Complexity Limitation]({{base_path}}/learn/api-security/graphql-query-analysis/query-complexity-limitation)


In order to implement applying query limits for GraphQL apis, two optional fields have been introduced to the Subscription Policy: **GraphQL Max Depth** and  **GraphQL Max Complexity**.

Through the Subscription Policy UI in the admin portal, GraphQL Max Depth value and GraphQL Max Complexity values can be set Once done, the corresponding subscription plan can be chosen via the business plans to engage these validations to an API.

Also, the policy for the custom complexity values would be as follows;

   [![GraphQL Complexity Policy]({{base_path}}/assets/img/learn/graphql-complexity-policy.png)]({{base_path}}/assets/img/learn/graphql-complexity-policy.png)


The following model shows how to use a given policy during run time:

  [![Model of the GraphQL Query Analysis]({{base_path}}/assets/img/learn/graphql-query-complexity-model.jpg)]({{base_path}}/assets/img/learn/graphql-query-complexity-model.jpg)


Figure given below depicts the overall flow of API invocation - from the request made by the client to the response 
which is given back to the client.
 
  [![Flow of the GraphQL Query Analysis]({{base_path}}/assets/img/learn/graphql-query-analysis-flow.jpg)]({{base_path}}/assets/img/learn/graphql-query-analysis-flow.jpg)






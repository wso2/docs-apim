# GraphQL Rate Limiting Overview 

GraphQL is an open-source data query & manipulation language for APIs. It provides a common interface between the client and the server for data fetching and manipulations.

With GraphQL queries, the client which requests data has more flexibility compared to REST where it can request any amount of data it wishes. This flexibility comes at a cost since now the GraphQL service might have to perform complex operations to serve each type of query it receives. To overcome this hardship, the query needs to be analysed before execution. Without any protection, backends are vulnerable to DoS attacks(which can cause excessive load on the server, database or network), which are caused by the execution of malicious and complex queries that are passed either intentionally or unintentionally. 

Since clients have the possibility to request very complex queries, servers must be ready to handle them properly. 
**WSO2 API-Manager introduces Static Query Analyser to Secure GraphQL APIs** to address such issues.

### Static Query Analyser

The Static Query Analyser detects complex queries based on a predefined policy and prevents them from reaching the backend. A basic outline of such a policy is shown below.

   - [Query Depth Limitation]({{base_path}}/learn/api-security/graphql-query-analysis/query-depth-limitation)
    
   - [Query Complexity Limitation]({{base_path}}/learn/api-security/graphql-query-analysis/query-complexity-limitation)


To implement applicable query limits for the GraphQL APIs, two optional fields, **GraphQL Max Depth** and **GraphQL Max Complexity**, were introduced to Subscription Policies.

The **GraphQL Max Depth** and **GraphQL Max Complexity** values can be set through the Subscription Policy UI in the admin portal. Once done, the corresponding subscription plan can be chosen via the business plans to engage these validations for an API.

Also, the policy for the custom complexity values would be as follows;

   [![GraphQL Complexity Policy]({{base_path}}/assets/img/learn/graphql-complexity-policy.png)]({{base_path}}/assets/img/learn/graphql-complexity-policy.png)


The following shows how a given policy is enforced at runtime:

  [![Model of the GraphQL Query Analysis]({{base_path}}/assets/img/learn/graphql-query-complexity-model.jpg)]({{base_path}}/assets/img/learn/graphql-query-complexity-model.jpg)


The below figure depicts the overall request/response flow of a GraphQL API invocation

 
  [![Flow of the GraphQL Query Analysis]({{base_path}}/assets/img/learn/graphql-query-analysis-flow.jpg)]({{base_path}}/assets/img/learn/graphql-query-analysis-flow.jpg)






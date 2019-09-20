# Create and Publish a GraphQL API

GraphQL, which has been developed by Facebook, is a data query language for APIs where a particular user can specify exactly what data is needed from an API. GraphQL APIs are an alternative to REST-based APIs. Similar to designing a SOAP API using WSDL and designing a REST API using a Swagger Definition (OpenAPI Specification) in WSO2 API Manager (WSO2 API-M), you can use a Schema Definition Language (SDL) schema to design a GraphQL API in WSO2 API Manager.

All GraphQL schemas generally have three operation root types, which are namely query, mutation, and subscription. The subscription root type is applicable for GraphQL WebSocket APIs. Therefore, every POST request or GET request against the GraphQL endpoint of a GraphQL server needs to have a payload starting with either the query or mutation root type including its related operation name. You can manage the security, authorization, and throttling aspect of each operation based on its operation name. 

Follow the instructions below to design and publish a GraphQL API:

Let's create a simple GraphQL API named HackerNews that has the following functionality.

- HackerNews stores details such as the URL and the description for specific links.
- You can use the HackerNews API to add new links and retrieve data with regard to the stored links. 
- HackerNews GraphQL schema contains only query and mutation operation types.

### Step 1 - Design a GraphQL API
1. Sign in to the WSO2 API Publisher.
   
    `https://<hostname>:9443/publisher-new` 
   
    Example: `https://localhost:9443/publisher-new`

    Use your username and password to sign in.

2. Click **CREATE API** and then click **I Have a GraphQL SDL schema**.
   ![Create GraphQL schema option](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/create-graphQL-schema-option.png)

3. Import the schema and click **Next**.  
    Let's use the following sample schema to create the schema file. 
   
    The file extension can be `.graphql`, `.txt` or `.json`, and the name of the file can be any name based on your preference.
   ```
   schema {
      query: Query
      mutation: Mutation
   }

   type Link {
      id: ID!
      url: String!
      description: String
   }

   input LinkFilter {
      description_contains: String
      url_contains: String
   }

   type Query {
      allLinks(filter: LinkFilter, skip: Int = 0, first: Int = 0): [Link]
   }

   type Mutation {
      createLink(url: String!, description: String!): Link
   }
   ```

      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>You need to define the SDL Schema based on the [GraphQL schema design best practices](https://leapgraph.com/graphql-schema-design-best-practices).</p>
      </div> 
      </html>

      ![Import graphQL schema by adding a file](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/import-graphQL-schema-via-file.png)

4. Enter the information of the GraphQL API and click **Finish**. 
    
    Use the following sample data to create an API named HackerNews.
      <html>
         <table>
            <thead>
            <tr class="header">
            <th><div>
            <div>
            Protocol State
            </div>
            </div></th>
            <th><div>
            <div>
            Description
            </div>
            </div></th>
            </tr>
            </thead>
            <td >
               <p>Name</p>
            </td>
            <td>
               <p>HackerNews</p>
            </td>
            </tr>
            <tr>
            <td >
               <p>Context</p>
            </td>
            <td>
               <p>/hackernews</p>
            </td>
            </tr>
            <tr>
            <td >
               <p>Version</p>
            </td>
            <td>
               <p>1.0.0</p>
            </td>
            </tr>
            <tr>
            <td >
               <p>End point</p>
            </td>
            <td>
               <p>Example: <a href="http://localhost:8080">http://localhost:8080</a>
               </p>
               <p>This should be the GraphQL Java backend that you created. For more information on creating a GraphQL Java backend for HackerNews API, go to the <a href="https://www.howtographql.com/graphql-java/1-getting-started/"> GraphQL Java Tutorials Getting Started guide</a>.</p>
            </td>
            </tr>
            <tr>
            <td >
               <p>Tiers</p>
            </td>
            <td>
               <p>Unlimited</p>
            </td>
            </tr>
            <tr>
            <td >
               <p>Visibility on Store</p>
            </td>
            <td>
               <p>Public</p>
            </td>
            </tr>
            <tr>
            <td >
               <p>Tags</p>
            </td>
            <td>
               <p>hackernews, graphq</p>
            </td>
            </tr>
         </tbody>
         </table>
      </html>

      ![Import GraphQL schema](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/import-graphQL-schema.png)

      Instead of resources, which get populated for REST APIs, operations get populated for GraphQL APIs.

   6. Update the GraphQL API operations as required.
      1. Click **Edit** under the **Operations** section in the **OVERVIEW** page to navigate to the operations page.
         ![GraphQL API operations](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/operations.png)   
      2. Update the operations as required.
          
          The Publisher can add throttle policies, scopes, and enable/disable security for the GraphQL API operations.
         ![Update GraphQL API operations](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/update-operations.png)  
   
   7. Add a schema definition.
      1. Click **SCHEMA DEFINITIONS**.
      2. Download the schema or import a new schema.
         ![Add schema definition](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/add-schema-definition.png)
   
   8. Click **LIFECYCLE** to navigate to the API lifecycle and publish the API.

### Step 2 - Invoke a GraphQL API
1. Navigate to the WSO2 Developer Portal.
   
    `https://<hostname>:9443/store-new` 
   
    Example: `https://localhost:9443/store-new`

    ![WSO2 API Manager Developer Portal](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/HackerNews-in-dev-portal.png)
    
2. Click on the API.
    
    The API overview appears.
    ![API overview](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/api-overview.png)

3. Optionally, download the API schema if required.

    Click **More** on the API overview page and then click **GRAPHQL SCHEMA**.

    ![Download GraphQL API schema](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/download-schema.png)

4. Subscribe to the API.
    1. Sign in to the WSO2 Developer Portal.
    2. Click **SUBSCRIBE TO AVAILABLE APP** to subscribe to the API using an existing application.
    3. Generate the production and sandbox keys.

5. Try out the operations.
    1. Click **TEST** to navigate to the developer console.
       
        The authorization token is displayed.

        ![Authorization token](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/authorization-token.png)

    2. Click **POST** and then click **Try it out**.   
        ![Try out the post operation](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/post-try-out.png)

    3. Enter the payload and click **Execute**.
        
        For more information on the payload, see [GraphQL root type - Query](#GraphQL-root-type---Query) and [GraphQL root type - Mutation](#GraphQL-root-type---Mutation).
   
#### GraphQL root type - Query
You need to send a query when you need to request data from the server.

<div class="admonition note">
<p class="admonition-title">Note</p>
<p> 
You can either use a <b>GET</b> method or a <b>POST</b> method to retrieve data using a GraphQL query.
</p>
</div>

##### Query based on GET method
For example, if you want to retrieve the URLs and descriptions of all the links stored in the database, you can send the following query to your GraphQL server when calling the HackerNews GraphQL API. 

` { allLinks  {url,description}}`

![GET method for query](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/query-get-method.png)

A response similar to the following appears.
![GET method response for query](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/query-get-response.png)

##### Query based on POST method
When using the POST method to send a query, you can specify the query within the payload using two different syntaxes. For example, the following two queries contain the two different syntaxes to retrieve the URLs and descriptions of all the links stored in the database.
<html>
<table>
<thead>

<tr class="header">
<th>Syntax</th>
<th>Query</th>
<th>Payload</th>
</tr>
</thead>
<tr>
<td >1</td>
<td>
<b>Format</b>
```
{ <query> }
```
<b>Example</b>
```
{ allLinks { url, description} }
```
</td>
<td>

<b>Format</b>
```
{
"query": "{ <query> }",
"variables": <variables>,
"operationName": <operation-name>
}

```
<b>Example</b>
```
{
"query": "{ allLinks { url, description } }",
"variables": null,
"operationName": null
}

```

</td>
</tr>
<tr>
<td >2</td>
<td>
<b>Format</b>
```
query <operation-name> {
   <query>
}
```

<b>Example</b>
```
query links {
   allLinks {
         url
         description
   }
}
```
</td>
<td >
<b>Format</b>
```
{
"query": "query <operation-name>{ <query> }",
"variables": <variables>,
"operationName": "<operation-name>"
}
```
<b>Example</b>
```
{
"query": "query links{ allLinks { url description } }",
"variables": null,
"operationName": "links"
}
```
</td>
</tr>

</table>
</html>
![POST method for query](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/query-post-method.png)
A response similar to the following appears.
![POST method response for query](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/query-post-response.png)

##### Samples
The following samples contain syntax and examples that will help you get familiar with the various ways in which you can define a query or a payload when using query as the root type in GraphQL.
<div class="admonition info">
<p class="admonition-title">Info</p>
<p>
<b>Example</b>
```
{
"query": "query aTest($arg1: String!) { test(who: $arg1) }",
"operationName": "aTest",
"variables": { "arg1": "me" }
}
```
In the above payload note that the ```variables``` field is not null. It contains the variable ```$arg``` of the data type String, which is passed in the query, and its value is ```me```.
</p>
</div> 

<html>
<table >

<thead>
<tr class="header">
<th>Query</th>
<th>Payload</th>
</tr>
</thead>

<tr>
<td>
```
{
  allLinks(filter: {description_contains: "back", url_contains: "cool"}) {
    url
    description
  }
}
```
</td>
<td>
<b>Format</b>
```
{
  "query": "{ <query>}",
  "variables": <variables>,
  "operationName": "<operation-name>"
}
```
<b>Example</b>
```     
{
  "query": "{ allLinks(filter: {description_contains: \"back\", url_contains: \"cool\"}) { url, description } }",
  "variables": null,
  "operationName": "links"
}
```
</td>
</tr>

<tr>
<td>
```
{
  allLinks(first: 1) {
    url
    description
  }
}
```
</td>
<td>
<b>Format</b>
```
{
  "query": "{ <query> }",
  "variables": <variables>,
  "operationName": "<operation-name>"
}
```
<b>Example</b>
```
{
  "query": "{ allLinks(first: 1) { url, description } }",
  "variables": null,
  "operationName": "links"
}
```
</td>
</tr>
<tr>
<td>
```
query links {
  allLinks(first: 1) {
    url
    description
  }
}
```
</td>
<td>
<b>Format</b>
```
{
  "query": "query <operation-name> { <query>}",
  "variables": <variables>,
  "operationName": "<operation-name>"
}
```
<b>Example</b>
```
{
  "query": "query links { allLinks(first: 1) { url, description } }",
  "variables": null,
  "operationName": "links"
}
```
</td>
</tr>

</table>
</html>

#### GraphQL root type - Mutation

When working with GraphQL APIs you need to use the Mutation operations root type for the following tasks:
<ul>
<li>Create new data</li>
<li>Update existing data</li>
<li>Delete existing data</li>
</ul> 
The syntax for mutations look almost the same as queries, but the syntaxes must start with the `mutation` keyword.
<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>When working with GraphQL Mutations you should only use <b>POST</b> methods.</p>
</div> 
</html>

<b>Example:</b>
If you want to create a new link with the URL: “https://wso2.com” and the description: "WSO2 official website" using the following mutation,
```
mutation createLink {
  createLink(url: "https://wso2.com", description:"WSO2 official website"){
    url
    Description
}
```
The corresponding payload should be as follows:

``` json tab="Format"
{
  "query": "mutation <operation-name> { <query>){ <requested-fields> } }",
  "variables": <variables>,
  "operationName": "<operation-name>"
}
```

``` json tab="Example"
{
  "query": "mutation createLink { createLink(url: \"https://wso2.com\", description:\"WSO2 official website\"){ url, description } }",
  "variables": null,
  "operationName": "createLink"
}
```

Note that in this mutation the query is passed along with the operation name.
![Mutation payload](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/mutation-payload.png)
A response similar to the following appears.
![Mutation response](../../assets/img/Learn/DesignAPI/CreateAPI/GraphQL/mutation-response.png)
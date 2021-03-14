# Create a GraphQL API

GraphQL, which has been developed by Facebook, is a data query language for APIs. When using GraphQL, users can explicitly specify as to what data they need from an API. GraphQL APIs are an alternative to REST-based APIs. 

You can use a Schema Definition Language (SDL) schema to design a GraphQL API in WSO2 API Manager (WSO2 API-M) similar to creating SOAP APIs using WSDLs and developing REST APIs using OpenAPI Specifications (a.k.a. Swagger Definitions).

All GraphQL schemas generally have three operation root types, which are namely query, mutation, and subscription. Therefore, every request against a GraphQL endpoint of a GraphQL server should have a payload starting with any one of the root types, including its related operation name. You can manage the security, authorization, and rate limiting aspect of each operation based on its operation name. 

Follow the instructions below to design a GraphQL API

### Design a GraphQL API

1. Sign in to the API Publisher Portal.
   
    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    Use your username and password to sign in.

2. Click **CREATE API** and then click **I Have a GraphQL SDL schema**.

     <html>
     <img src="{{base_path}}/assets/img/learn/create-graphql-schema-option.png" alt="Create GraphQL schema option" title="Create GraphQL schema option" width="600"/>
     </html>


3. Import the schema and click **Next**.  

     [![Import a graphQL schema by adding a file]({{base_path}}/assets/img/learn/import-graphql-schema.png)]({{base_path}}/assets/img/learn/import-graphql-schema.png)

     Let's use the [StarWarsAPI schema definition]({{base_path}}/assets/attachments/learn/schema_graphql.graphql) to create the schema file. 
   

      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <ul><li>
      <p>You need to define the SDL Schema based on the <a href="https://leapgraph.com/graphql-schema-design-best-practices">GraphQL schema design best practices</a>.</p></li>
      <li>The file extension can be either `.graphql` or `.txt`. </li><li> The file name can be any name, which is based on your preference.</li></ul>
      </div>


      [![Import a graphQL schema by adding a file]({{base_path}}/assets/img/learn/import-graphql-schema-via-file.png)]({{base_path}}/assets/img/learn/import-graphql-schema-via-file.png)

4. Enter the GraphQL API related details and click **Create**.

    !!! important

        Let's use the Star Wars sample backend server as the backend for our GraphQL API.

        - Clone the [WSO2 API Manager Samples](https://github.com/wso2/samples-apim) repository.
            ```
            git clone https://github.com/wso2/samples-apim
            ```
        - Navigate to `graphql-backend` directory.
        - Run `npm install` to install the necessary node modules.
        - Run `npm start` to start the server.

        Once the above steps are done, the Star Wars server will be running on `http://localhost:8080`. We can use
        `http://localhost:8080/graphql` as the endpoint when creating the API. 
    
    Let's create an API named "StarWarsAPI" using the following sample data.
      
    <table>
    <thead>
    <tr>
    <th>
    <div>
    Protocol State
    </div>
    </th>
    <th>
    <div>
    Description
    </div></th>
    </tr>
    </thead>
    <td>
    <p>Name</p>
    </td>
    <td>
    <p>StarWarsAPI</p>
    </td>
    </tr>
    <tr>
    <td>
    <p>Context</p>
    </td>
    <td>
    <p>/swapi</p>
    </td>
    </tr>
    <tr>
    <td>
    <p>Version</p>
    </td>
    <td>
    <p>1.0.0</p>
    </td>
    </tr>
    <tr>
    <td>
    <p>Endpoint</p>
    </td>
    <td>
    <a href="http://localhost:8080/graphql" target="_blank">http://localhost:8080/graphql</a>
    </td>
    </tr>
    <tr>
    <td>
    <p>Business Plans</p>
    </td>
    <td>
    <p>Unlimited</p>
    </td>
    </tr>
    </table>
      
    [![Add GraphQL API details]({{base_path}}/assets/img/learn/create-graphql-api-details.png)]({{base_path}}/assets/img/learn/create-graphql-api-details.png)

5. Optionally, modify the existing GraphQL schema definition.

     1. Click **Schema Definition**.

     2. Click **DOWNLOAD DEFINITION**.

         The existing GraphQL API schema gets downloaded.

         [![Add schema definition]({{base_path}}/assets/img/learn/download-schema-definition.png)]({{base_path}}/assets/img/learn/download-schema-definition.png)   

     3. Update the schema definition as required.

     4. Click **IMPORT DEFINITION** to import the updated schema definition.

6. Update the GraphQL API operations as required.

     Instead of resources, which get populated for REST APIs, operations get populated for GraphQL APIs.

     1. Click **Show More** under the **Operations** section in the **OVERVIEW** page to navigate to the operations page.

       
         [![GraphQL API operations]({{base_path}}/assets/img/learn/operations.png)]({{base_path}}/assets/img/learn/operations.png)
     
     2. Update the operations as required.
         
         The Publisher can add rate limiting policies, scopes, and enable/disable security for each of the GraphQL API operations.

         1. Create scopes.

             Repeat the following sub-steps to create two scopes named `adminScope` and `FilmSubscriberScope`.

             1. Click **Scopes** > **ADD NEW SCOPE**.

                [![Add a scope page]({{base_path}}/assets/img/learn/add-scope.png)]({{base_path}}/assets/img/learn/add-scope.png)

             2. Enter the required details.

                <div class="admonition note">
                <p class="admonition-title">Note</p>
                <p> 
                The role that you enter should be a valid role that already exists in WSO2 API Manager. Make sure to assign the role to the user.
                </p>
                </div>
                  
                Create a role named `FilmSubscriber` and assign it to the `admin` user for this example scenario. For more information, see [Adding Users]({{base_path}}/administer/product-administration/managing-users-and-roles/adding-users) and [Adding User Roles]({{base_path}}/administer/product-administration/managing-users-and-roles/adding-user-roles).
               

                [![Create a scope]({{base_path}}/assets/img/learn/create-scope.png)]({{base_path}}/assets/img/learn/create-scope.png)

             3. Press `Enter` to add each scope. 

             4. Click **SAVE**.

                 [![List of added scopes]({{base_path}}/assets/img/learn/starwars-scope-list.png)]({{base_path}}/assets/img/learn/starwars-scope-list.png) 

         2. Define the operation level configurations.

             1. Click **Operations**.
            
             2. Click **Operation Level** to apply rate limiting for operations.

                 [![Update GraphQL API operations]({{base_path}}/assets/img/learn/update-operations.png)]({{base_path}}/assets/img/learn/update-operations.png) 

            3. Select a throttling policy, scope, and enable or disable security for each of the operations.

                 For more information on the payload, see [GraphQL operations](#graphql-operations). 

                 Apply the `adminScope` and `FilmSubscriberScope` scopes to the `allFilms` and `allPlanets` operations, respectively.
            
            4. Click **Save**.

                 If you check the list of scopes, it should appear as follows:

                 [![Scope list]({{base_path}}/assets/img/learn/scope-list.png)]({{base_path}}/assets/img/learn/scope-list.png)

Now, you have successfully created and configured a GraphQL API. Next, let's [Publish your API]({{base_path}}/learn/design-api/publish-api/publish-an-api).

### GraphQL operations

The following sub-sections explain as to how authorization, security, and throttling affect API operations.

#### Authorization for GraphQL operations
A scope acts as a limiting factor on what API resources can be accessed using an access token and thereby defines the authorization aspect for API requests.

- **Authorization for a single operation**

    When a query has a single operation, the access token should include the scope that is attached to that specific operation to be able to invoke the API.

- **Authorization for multiple operations**
 
    When a query has multiple operations, the access token should include all the scopes that are attached to the operations that correspond to that specific API to be able to invoke the API.

#### Security for GraphQL operations
Security can be enabled or disabled for GraphQL operations. Security is enabled for GraphQL operations by default.

- **Security for a single operation**

    When a query has an operation that has security enabled, the users need to enter their credentials to invoke the respective API. However, when security is disabled for the operation, the users can invoke the respective API without entering their credentials.

- **Security for multiple operations**
  
    The API request takes into consideration the security configurations of all the operations that belong to the API. When a query has security enabled for one of the operations that belong to a specific API, then security is automatically applied for all the operations. Therefore, in such cases, users have to use their credentials when invoking that respective API.

#### Rate limiting for GraphQL operations
Rate limiting is set to unlimited, and thereby disabled by default. 

- **Rate limiting for a single operation**

    When a query has an operation with a rate limiting policy applied to it, the respective rate limiting policy is taken into account to rate limit the request when it exceeds the desired limit. 

- **Rate limiting for multiple operations**

    WSO2 API Manager checks all the operation related rate limiting policies when determining the overall rate limit. When the requests exceed the minimum rate limit, which corresponds to the operations in the query, they will be throttled out.
   

<div class="admonition note">
<p class="admonition-title">What's Next?</p>

<p>Learn more by trying out the tutorial on <a href="{{base_path}}/learn/tutorials/create-and-publish-a-graphql-api">Creating and Publishing a GrapQL API</a>.</p>
</div> 

# Create and Publish a GraphQL API

Follow the instructions in this tutorial to design, publish, and invoke a GraphQL API.
<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>For more information on GraphQL APIs, see <a href="{{base_path}}/Learn/DesignAPI/CreateAPI/create-a-graphql-api">Create a GraphQL API</a>.</p>
</div> 
</html>
### Step 1 - Design a GraphQL API

1. Sign in to the API Publisher Portal.
   
    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    Let's use `admin` as your username and password to sign in.

2. Click **CREATE API** and then click **I Have a GraphQL SDL schema**.

     <html>
     <head>
     </head>
     <body>
     <img src="{{base_path}}/assets/img/Learn/create-graphQL-schema-option.png" alt="Create GraphQL schema option" title="Create GraphQL schema option" width="600" />
     </body>
     </html>


3. Import the schema and click **Next**.  

     [![Import a graphQL schema by adding a file]({{base_path}}/assets/img/Learn/import-graphQL-schema.png)]({{base_path}}/assets/img/Learn/import-graphQL-schema.png)

     Let's use the [StarWarsAPI schema definition]({{base_path}}/assets/attachments/Learn/schema_graphql.graphql) to create the schema file. 
   
      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <ul><li>
      <p>You need to define the SDL Schema based on the [GraphQL schema design best practices](https://leapgraph.com/graphql-schema-design-best-practices).</p></li>
      <li>The file extension can be either `.graphql`, `.txt`, or `.json`. </li><li> The file name can be any name, which is based on your preference.</li></ul>
      </div> 
      </html>


      [![Import a graphQL schema by adding a file]({{base_path}}/assets/img/Learn/import-graphQL-schema-via-file.png)]({{base_path}}/assets/img/Learn/import-graphQL-schema-via-file.png)

4. Enter the GraphQL API related details and click **Create**. 
    
    Let's create an API named "StarWarsAPI" using the following sample data.
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
               <p>StarWarsAPI</p>
            </td>
            </tr>
            <tr>
            <td>
               <p>Context</p>
            </td>
            <td>
               <p>	
               /swapi</p>
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
               <a href="https://api.graph.cool/simple/v1/swapi" target="_blank">https://api.graph.cool/simple/v1/swapi</a>
            </td>
            </tr>
            <tr>
            <td >
               <p>Business Plans</p>
            </td>
            <td>
               <p>Unlimited</p>
            </td>
            </tr>
         </table>
      </html>

      [![Add GraphQL API details]({{base_path}}/assets/img/Learn/add-graphql-API-details.png)]({{base_path}}/assets/img/Learn/add-graphql-API-details.png)

5. Optionally, modify the existing GraphQL schema definition.

    1. Click **Schema Definition**.

    2. Click **DOWNLOAD DEFINITION**.

         The existing GraphQL API schema gets downloaded.

         [![Add schema definition]({{base_path}}/assets/img/Learn/download-schema-definition.png)]({{base_path}}/assets/img/Learn/download-schema-definition.png)

    3. Update the schema definition as required.

    4. Click **IMPORT DEFINITION** to import the updated schema definition.

6. Update the GraphQL API operations as required.

    Instead of resources, which get populated for REST APIs, operations get populated for GraphQL APIs.

    1. Click **Show More** under the **Operations** section in the **OVERVIEW** page to navigate to the operations page.

         [![GraphQL API operations]({{base_path}}/assets/img/Learn/operations.png)]({{base_path}}/assets/img/Learn/operations.png)  
     
    2. Update the operations as required.
         
        The Publisher can add rate limiting policies, scopes, and enable/disable security for each of the GraphQL API operations.

        1. Create scopes.

            Repeat the following sub-steps to create two scopes named `adminScope` and `FilmSubscriberScope`.

            1. Click **Scopes** > **ADD NEW SCOPE**.

                  [![Add a scope page]({{base_path}}/assets/img/Learn/add-scope.png)]({{base_path}}/assets/img/Learn/add-scope.png)

            2. Enter the required details.

                  <div class="admonition note">
                  <p class="admonition-title">Note</p>
                  <p> 
                  The role that you enter should be a valid role that already exists in WSO2 API Manager. Make sure to assign the role to the user.
                  </p>
                  </div>
                  
                  Create a role named `FilmSubscriber` and assign it to the `admin` user for this example scenario. For more information, see [Adding Users]({{base_path}}/Administer/ProductAdministration/ManagingUsersAndRoles/adding-users/) and [Adding User Roles]({{base_path}}/Administer/ProductAdministration/ManagingUsersAndRoles/adding-user-roles/).

                  [![Create a scope]({{base_path}}/assets/img/Learn/create-scope.png)]({{base_path}}/assets/img/Learn/create-scope.png)

            3. Press `Enter` to add each scope. 

            4. Click **SAVE**.

                 [![List of added scopes]({{base_path}}/assets/img/Learn/starwars-scope-list.png)]({{base_path}}/assets/img/Learn/starwars-scope-list.png)

         2. Define the operation level configurations.

            1. Click **Operations**.
            
            2. Click **Operation Level** to apply rate limiting for operations.

                 [![Update GraphQL API operations]({{base_path}}/assets/img/Learn/update-operations.png)]({{base_path}}/assets/img/Learn/update-operations.png) 

            3. Select a throttling policy, scope, and enable or disable security for each of the operations. 

                 Apply the `adminScope` and `FilmSubscriberScope` scopes to the `allFilms` and `allPlanets` operations, respectively.
            
            4. Click **Save**.

                 If you check the list of scopes, it should appear as follows:

                 [![Scope list]({{base_path}}/assets/img/Learn/scope-list.png)]({{base_path}}/assets/img/Learn/scope-list.png)

Now, you have created and configured the GraphQL API successfully. 

### Step 2 - Publish the GraphQL API

Click **LIFECYCLE** to navigate to the API lifecycle and click **PUBLISH** to publish the API to the API Developer Portal.

[![Publish GraphQL API]({{base_path}}/assets/img/Learn/publish-graphql-api.png)]({{base_path}}/assets/img/Learn/publish-graphql-api.png)

### Step 3 - Invoke the GraphQL API

1. Sign in to the **DEVELOPER PORTAL**.
   
     `https://<hostname>:9443/devportal` 
   
      Example: `https://localhost:9443/devportal`

     [![Developer Portal]({{base_path}}/assets/img/Learn/starwars-in-dev-portal.png)]({{base_path}}/assets/img/Learn/starwars-in-dev-portal.png)
    
2. Click on the GraphQL API.
   
     The API overview appears.
 
     [![StarWarsAPI API overview]({{base_path}}/assets/img/Learn/api-overview.png)]({{base_path}}/assets/img/Learn/api-overview.png)

3. Optionally, download the API schema if required.

      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p> You can download the API schema even without signing in to the Developer Portal</p>
      </div> 
      </html>

     Click **More** on the API overview page and then click **GRAPHQL SCHEMA** to download the API schema.

     [![Download GraphQL API schema]({{base_path}}/assets/img/Learn/download-schema.png)]({{base_path}}/assets/img/Learn/download-schema.png)

5. Subscribe to the API.

    1. Click **KEY GENERATION WIZARD**.
    
       This wizard takes you through the steps of creating a new application, subscribing, generating keys, and generating an access token to invoke the API. Add the two scopes (`allFilms`, `allPlanets`) that you assigned to the operations.

       <div class="admonition note">
       <p class="admonition-title">Note</p>
       <p> 
       You can use any application (e.g., JWT or OAuth) to subscribe to the API.
       </p>
       </div>

       [![Key generation wizard]({{base_path}}/assets/img/Learn/starwars-scopes-gen-access-token.png)]({{base_path}}/assets/img/Learn/starwars-scopes-gen-access-token.png)

    2. Copy the authorization token that appears.

       [![Copy the authorization token]({{base_path}}/assets/img/Learn/copy-access-token-starwars.png)]({{base_path}}/assets/img/Learn/copy-access-token-starwars.png)

6. Try out the operations.
    1. Click **TEST** to navigate to the developer console.

       [![Authorization token]({{base_path}}/assets/img/Learn/authorization-token.png)]({{base_path}}/assets/img/Learn/authorization-token.png)

    2. Select whether to invoke the API using HTTP or HTTPS from **Servers**.

    3. Paste the access token that you previously copied into the **Access Token** field.

    4. Click **POST**.
    
    5. Click **Try it out** and enter the following sample payload as the StarWarsAPI POST request.
    
         ```
         {
         "query": "{ allFilms{title  episodeId}  allPlanets {films { species {skinColor} } }}"
         }   
         ```

         [![Try out the post operation]({{base_path}}/assets/img/Learn/post-try-out-starwars.png)]({{base_path}}/assets/img/Learn/post-try-out-starwars.png)

      <html>
      <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>If you are going to invoke QUERY Operation, payload should be started with either with 'query' keyword or without any keyword.</p>
      <p>If you are going to invoke MUTATION Operation, payload should be started starting with 'mutation' keyword.</p>
      </div> 
      </html>

    6. Click **Execute**.

        [![Try out the post operation]({{base_path}}/assets/img/Learn/post-response-starwars.png)]({{base_path}}/assets/img/Learn/post-response-starwars.png)

You have successfully created and published your first GraphQL API, subscribed to it, obtained an access token for testing and tested your API with the access token.

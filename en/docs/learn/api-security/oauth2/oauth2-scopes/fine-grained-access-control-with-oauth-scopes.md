# Fine Grained Access Control with OAuth Scopes

Scopes enable fine-grained access control to API resources based on user roles. You define scopes to an API's resources. When a user invokes the API, his/her OAuth 2 bearer token cannot grant access to any API resource beyond its associated scopes.

For example, there can be requirements such as restricting the access to a given API resource to admin users only, while other resources of the same API access should be allowed to consumers with less privileges. Let's see how this kind of role based access control can be managed with the use of OAuth2 scopes.


## Creating a Scope

The scopes can be created and applied to an API resources at API create time. Please follow below steps to create a scope.

1. Login to API Publisher (https://localhost:9443/publisher) 

2. Start creating an API as described [here]({{base_path}}learn/design-api/create-api/create-a-rest-api).

3. Navigate to Scope section and click on create scope button.

    <a href="../../../../../assets/img/learn/start-creating-scope.png" ><img src="../../../.
    ./../assets/img/learn/start-creating-scope.png" alt="Start Creating a Scope" 
         title="Start Creating a Scope" width="70%" /></a>

4. In scope creation wizard, you will be prompted to enter a scope name, scope description and optionally, allowed roles and a description. Fill in required details of the scope and click **Save** button.
 Click **Save**.

    <table>
    <tbody>
    <tr class="odd">
    <td><strong>Scope Key</strong></td>
    <td>A unique key for identifying the scope. Typically, it is prefixed by part of the API's name for uniqueness, but is not necessarily reader-friendly.</td>
    </tr>
    <tr class="even">
    <td><strong>Scope Name</strong></td>
    <td>A human-readable name for the scope. It typically says what the scope does.</td>
    </tr>
    <tr class="odd">
    <td><strong>Roles</strong></td>
    <td><div class="content-wrapper">
    <p>The user role(s) that are allowed to obtain a token against this scope. E.g., manager, employee.</p>
    <p>Note that the role name is <strong>case sensitive</strong> in the DBMSs that are case sensitive, such as PostgreSQL.</p>
    <p>When the role you specify is in a secondary user store, you have to give the role as <code>&lt;userstore name&gt;/&lt;role name&gt;</code>.</p>
    
    </div></td>
    </tr>
    </tbody>
    </table>

    <a href="../../../../../assets/img/learn/create-a-new-scope.png" ><img src="../../../../../assets/img/learn/create-a-new-scope.png" alt="Create a Scope" 
         title="Create a Scope" width="70%" /></a>

## Applying a Scope to an API Resource

A scopes has be applied to a resource, in order to restrict the access to a user group/groups. Please follow below steps to apply a scope to a resource.

1. Go to API Resource section and click on the resource you would like to apply the scope.

    <a href="../../../../../assets/img/learn/select-resource.png" ><img src="../../../../../assets/img/learn/select-resource.png" alt="Select Resource" 
         title="Select Resource" width="70%" /></a>

2. Select the created scope from the drop down and click on **Save** button to save changes.

    <a href="../../../../../assets/img/learn/apply-scope.png" ><img src="../../../../../assets/img/learn/apply-scope.png" alt="Apply Scope" 
         title="Apply Scope" width="70%" /></a>

3. Publish the API.

## Obtaining Tokens with Scopes

When a scope has been assigned to an API resource, the access is getting restricted to the users who has the role/roles specified in the scope. Hence, the API consumers has to specifically request for the relevant scope when generating an access token to invoke the API resource. Please follow below steps to obtain an access token specifying the requested scopes.

1. Login to API Portal(https://localhost:9443/devportal/)

2. Navigate to the API which has the scope protected API resource and go to Credential section to subscribe to an application.

    <a href="../../../../../assets/img/learn/subscribe-weatherapi.png" ><img src="../../../../../assets/img/learn/subscribe-weatherapi.png" alt="Subscribe" 
         title="Subscribe" width="50%" /></a>
         
3. Generate production keys for the application.

    <a href="../../../../../assets/img/learn/generate-app-keys.png" ><img src="../../../../../assets/img/learn/generate-app-keys.png" alt="Generate App Keys" 
         title="Generate App Keys" width="60%" /></a>

4. Click on **GENERATE ACCESS TOKEN** button. Then select the scope from the prompted window and generate the access token.

    <a href="../../../../../assets/img/learn/generate-access-token-with-scopes.png" ><img src="../../../../../assets/img/learn/generate-access-token-with-scopes.png" alt="Generate App Keys" 
         title="Generate App Keys" width="50%" /></a>

5. If the user has the roles specified in the scope, the access token will be issued with the requested scope. Unless, only the default scopes will be returned with the access token.
 
    <a href="../../../../../assets/img/learn/token-scopes.png" ><img src="../../../../../assets/img/learn/token-scopes.png" alt="Token scopes" 
         title="Token Scopes" width="40%" /></a>   
         
6. Invoke the API resource with the above generated access token. If the user is assigned with the authorized roles, the API invocation will be successful. An API resource access by an unauthorized user will be failed giving 403 Forbidden error.

     <a href="../../../../../assets/img/learn/unauthorized-access.png" ><img src="../../../../../assets/img/learn/unauthorized-access.png" alt="Token scopes" 
         title="Token Scopes" width="50%" /></a>




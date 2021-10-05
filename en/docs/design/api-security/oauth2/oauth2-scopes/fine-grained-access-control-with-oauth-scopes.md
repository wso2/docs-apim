# Fine Grained Access Control with OAuth Scopes

Scopes enable fine-grained access control to API resources based on user roles. You define scopes to an API's resources. When a user invokes the API, his/her OAuth 2 bearer token cannot grant access to any API resource beyond its associated scopes.

For example, there can be requirements such as restricting the access to a given API resource to admin users only, while other resources of the same API access should be allowed to consumers with less privileges. Let's see how this kind of role based access control can be managed with the use of OAuth2 scopes.

## Shared Scopes

In WSO2 API-M, an OAuth scope can be created before the API is created and shared across multiple APIs of the same tenant. The API-M Publisher portal provides a scope management UI to view, create, edit and delete these shared scopes. 

!!! info
     Shared scopes can be viewed by any Publisher portal user with a role associated with `apim:api_view` Publisher 
     REST API scope. Shared scope create, update and delete operations are only allowed for user roles associated with 
     `apim:shared_scope_manage` Publisher REST API scope. 
     
     By default, only an `admin` user can perform create, update and delete operations of shared scopes.

### Creating a Shared Scope

The shared scope need to be created before API creation/update time. Follow below steps to create a new shared scope.

1. Login to API Publisher (https://localhost:9443/publisher). 

2. Navigate to **Scopes** from the top menu and click on **Create a new scope** button.

     [![Start Creating a Scope]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/create-shared-scope.png)]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/create-shared-scope.png)

3. In **Create New Scope** wizard, you will be prompted to enter a scope name, scope display name and optionally, scope description and allowed roles. Fill in required details of the scope and click **Save** button.

     [![Create New Scope]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/create-op-shared-scope.png)]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/create-op-shared-scope.png)

    <table>
     <tbody>
          <tr class="odd">
               <td><strong>Scope Name</strong></td>
               <td>A unique key for identifying the scope.</td>
          </tr>
          <tr class="even">
               <td><strong>Scope Display Name</strong></td>
               <td>A human-readable name for the scope. It typically says what the scope does. This is used for consent
               screens.</td>
          </tr>
          <tr class="odd">
               <td><strong>Scope Description</strong></td>
               <td>The description for the scope.</td>
          </tr>          
          <tr class="even">
               <td><strong>Roles</strong></td>
               <td><div class="content-wrapper">
                    <p>The user role(s) that are allowed to obtain a token against this scope. E.g., manager, employee.</p>
                    <p>Note that the role name is <strong>case sensitive</strong> in the DBMSs that are case sensitive, such as PostgreSQL.</p>
                    <p>When the role you specify is in a secondary user store, you have to give the role as <code>&lt;userstore name&gt;/&lt;role name&gt;</code>.</p>
              </div></td>
          </tr>
     </tbody>
    </table>     

### Applying a Shared Scope to an API Resource

A shared scope has to be applied to a resource, in order to restrict the access to a user group/groups. A shared scope can be attached to more than one APIs of the same tenant. Follow below steps to apply a shared scope to a resource.

1. Go to API **Resources** section and click on the resource you would like to apply the scope.

    <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/select-resource.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/select-resource.png" alt="Select Resource" 
         title="Select Resource" width="70%" /></a>

2. Select the created scope from the dropdown. The created shared scope will be listed under **Shared Scopes** in the drop down.

     <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/attach-shared-scope.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/attach-shared-scope.png" alt="Select Shared Scope" 
          title="Select Shared Scope" width="70%" /></a>

     Once you select the scope from dropdown, it will be shown as follows.

     <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/shared-scope-attached.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/shared-scope-attached.png" alt="Attched Shared Scope" 
          title="Attached Shared Scope" width="70%" /></a>         


3. Click on **Save** button to save changes.         

4. Publish the API.

!!! info

     Once a shared scope is created and attached to an API, you are restricted to delete the shared scope. In order to
     delete a shared scope, first you need to remove its resource attachments from relevant APIs.

## Local Scopes 

!!! warning
     
    This feature is **DEPRECATED** from **WSO2 API-M 3.2 onwards** and, it is recommended to use 
    [Shared Scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#shared-scopes).

In WSO2 API-M, API developers can also create OAuth scopes during the API creation time and attach them locally to the API. These scopes are local and unique to the relevant API. 

### Creating a Local Scope

A local scope can be created and applied to a resource at API creation time by following below steps.

1. Login to API Publisher (https://localhost:9443/publisher) 

2. Start creating an API as described [here]({{base_path}}/design/create-api/create-rest-api/create-a-rest-api/).

3. Navigate to **Scopes** section and click on **CREATE SCOPES** button.

     [![Start Creating a Scope]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/api-scopes/start-creating-scope.png)]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/api-scopes/start-creating-scope.png)

4. In **Create New Scope** wizard, you will be prompted to enter a scope name and optionally, allowed roles and a description. Fill in required details of the scope and click **Save** button.

    <table>
     <tbody>
          <tr class="odd">
               <td><strong>Scope Name</strong></td>
               <td>A unique key for identifying the scope. This should be unique across all the APIs of the tenant.</td>
          </tr>
          <tr class="even">
               <td><strong>Scope Description</strong></td>
               <td>The description for the scope.</td>
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

    <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/api-scopes/create-a-new-scope.png" >
    <img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/api-scopes/create-a-new-scope.png" alt="Create a Scope" 
         title="Create a Scope" width="70%" /></a>

### Applying a Local Scope to a Resource

A local scope, when applied to a resource, will restrict access for a user group(s). A local scope can only be attached to the relevant API in which it is created under. Follow below steps to apply a local scope to a resource.

1. Go to API **Resources** section and click on the resource you would like to apply the scope.

    <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/select-resource.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/select-resource.png" alt="Select Resource" 
         title="Select Resource" width="70%" /></a>

2. Select the created local scope from the dropdown. The created local scope will be listed under **API Scopes** in the 
dropdown.

    <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/api-scopes/apply-scope.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/api-scopes/apply-scope.png" alt="Apply Scope" 
         title="Apply Scope" width="70%" /></a>

3. Click on **Save** button to save changes.         

4. Publish the API.

## Applying Multiple Scopes Per Resource

From API-M Publisher Portal, you can attach multiple scopes to each API resource.

[![Attaching Multiple Scopes per Resource]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/multiple-scopes-per-resource.png)]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/multiple-scopes-per-resource.png)

Once you attach multiple scopes per resource, the resource will look as follows.

[![After Attaching Multiple Scopes per Resource]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/after-attaching-multiple-scopes.png)]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/after-attaching-multiple-scopes.png)

## Defining OAuth Scopes in API Definition

Both [Shared Scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#shared-scopes) 
and [Local Scopes]({{base_path}}/design/api-security/oauth2/oauth2-scopes/fine-grained-access-control-with-oauth-scopes/#local-scopes) should be defined in same way in the OpenAPI definition as follows.

<a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/resource-scope-api-definition.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/resource-scope-api-definition.png" alt="Resource Scopes API Definition" 
     title="Resource Scopes API Definition" width="50%" /></a>

[![Scopes Security Definition API Definition]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/scopes-api-definition.png)]({{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/scopes-api-definition.png)

## Disable role validation at scope creation 
   When creating scopes, it validates the added roles against the underline user store to check if they exist. However, we can override this behavior such that it does not validate the roles in the user store. For this purpose, set the Java system property `disableRoleValidationAtScopeCreation` to `true` at the server startup:
   This can be done in one of two ways.

   **Option 1**: Adding in startup script

         Open <API-M_HOME>/bin/api-manager.(sh|bat) file.
         Add -DdisableRoleValidationAtScopeCreation=true at the end of the file.
         Restart the server.

   **Option 2**: Provide as a parameter during server startup 
    
   Restart the server with the parameter set as below.
         
   - Linux/Mac OS
         
       ``` tab="Format"
         ./api-manager.sh -DdisableRoleValidationAtScopeCreation=<boolean_value>
       ```
             
       ``` tab="Example"
         ./api-manager.sh -DdisableRoleValidationAtScopeCreation=true
       ```
             
   - Windows
         
       ``` tab="Format"
         api-manager.bat -DdisableRoleValidationAtScopeCreation=<boolean_value>
       ```
             
       ``` tab="Example"
             api-manager.bat -DdisableRoleValidationAtScopeCreation=true           
       ```
       
## Obtaining Tokens with Scopes

When a scope is attached to an API resource, access to it gets restricted based on the role(s) that is specified in the scope. In order to invoke the API resource, the API consumer has to generate an access token bound to the scope that is attached to the API resource. Follow below steps to obtain an access token specifying the requested scopes.

1. Login to API Developer Portal (https://localhost:9443/devportal/).

2. Navigate to the API which has the scope protected API resource and go to **Subscription** section to subscribe to an application.

     <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/subscribe-api.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/subscribe-api.png" alt="Subscribe" 
          title="Subscribe" width="50%" /></a>
         
3. Generate PRODUCTION or SANDBOX keys for the application.

     <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/generate-keys.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/generate-keys.png" alt="Generate App Keys" 
          title="Generate App Keys" width="60%" /></a>

4. Click **GENERATE ACCESS TOKEN** button. Then select the scope from dropdown in the prompted window and click **GENERATE** button to generate the access token.

     <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/generate-keys.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/token-scopes.png" alt="Select Token Scopes" 
          title="Select Token Scopes" width="60%" /></a>

5. If the user has the roles specified in the scope, the access token will be issued with the requested scope. Otherwise, only the default scopes will be returned with the access token.            

    ??? info
        By default in WSO2 API-M, if no scopes are requested or if none of requested scopes are allowed, the token will be issued with `default` scope.
        In addition, a token obtained using client credentials grant will be issued with `am_application_scope`.     

     <a href="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/token-scopes-output.png" ><img src="{{base_path}}/assets/img/learn/api-security/oauth2/oauth2-scopes/token-scopes-output.png" alt="Token Scopes" 
          title="Token Scopes" width="60%" /></a>

6. Invoke the API resource with the above generated access token. If the user is assigned with the authorized roles, the API invocation will be successful. An API resource access by an unauthorized user will be failed giving 403 Forbidden error.

     <a href="{{base_path}}/assets/img/learn/unauthorized-access.png" ><img src="{{base_path}}/assets/img/learn/unauthorized-access.png" alt="Token scopes" 
         title="Token Scopes" width="50%" /></a>

!!! info

     If you first create a local scope and then create a shared scope with same scope name before attaching the local scope to any API resource, the local scope will removed from local scope UI. However, it will not be reflected in the API Definition, unless you save the API. This is an identified limitation in supporting both local and shared scopes. Hence, we recommend you to use Shared Scopes only from 3.2 onwards. Local scopes are deprecated and will be removed in future release.




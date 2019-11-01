# Fine Grained Access Control with OAuth Scopes



# Applying a scope

You apply scopes to an API resource at the time the API is created or modified. In the API Publisher, click the **APIs &gt; CREATE API** button (to add a new API) or the **Edit** an existing API. Then, navigate to the **Scopes** section and wou will see the **Create Scopes** button.

On the screen that appears, enter a scope key, scope name and optionally, allowed roles and a description. Click **Save** .

![](/../../../../assets/img/Learn/create-scope.png)

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

To apply the scope, you can add the scope to a resource in **Resources** section, save and publish the API.

!!! tip
     When you generate [access tokens](../../../../ConsumeAPI/ManageApplication/GenerateKeys/ObtainAccessToken/overview-of-access-tokens/) for applications with APIs protected by scope/s in the API Developer Portal, a **Scopes** drop down list is displayed in the **Production Keys** tab of the application, where you can select the scope/s and generate the token.

![](/../../../../assets/img/Learn/resource-scope.png)

!!! note
    For a complete example, please refer the article : [An Overview of Scope Management with WSO2 API Manager](https://wso2.com/library/articles/2017/01/article-an-overview-of-scope-management-with-wso2-api-manager/#example)






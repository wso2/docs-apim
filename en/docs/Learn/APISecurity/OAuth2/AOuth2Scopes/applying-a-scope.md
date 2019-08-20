# Applying a scope

You apply scopes to an API resource at the time the API is created or modified. In the API Publisher, click the **API &gt; Add** menu (to add a new API) or the **Edit** link next to an existing API. Then, navigate to the **Manage** tab and scroll down to see the **Add Scopes** button under **Resources** .

On the screen that appears, enter a scope key, scope name and optionally, allowed roles and a description. Click **Add Scope** .

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
!!! note
<p>Note that the role name is <strong>case sensitive</strong> in the DBMSs that are case sensitive, such as PostgreSQL.</p>
<p>When the role you specify is in a secondary user store, you have to give the role as &lt;userstore name&gt;/&lt;role name&gt;.</p>

</div></td>
</tr>
</tbody>
</table>

To apply the scope, you add the scope to a resource, save and publish the API.

!!! tip
**Tip** : When you generate [access tokens](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-Accesstokens) for applications with APIs protected by scope/s in the API Store, a **Scopes** drop down list is displayed in the **Production Keys** tab of the application, where you can select the scope/s after the token is generated.

!!! note
For a complete example, please refer the article : [An Overview of Scope Management with WSO2 API Manager](https://wso2.com/library/articles/2017/01/article-an-overview-of-scope-management-with-wso2-api-manager/#example)



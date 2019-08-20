# Scope Whitelisting

A scope is not always used for controlling access to a resource. You can also use it to simply mark an access token. There are scopes that cannot be associated to roles (e.g., openid, device\_). Such scopes do not have to have roles associated with them. Skipping role validation for scopes is called scope whitelisting.

If you do not want a role validation for a scope in an API's request, add the scope under the `         <OAuthConfigurations>        ` element in the `         <APIM_HOME>/repository/conf/api-manager.xml        ` file and restart the server. It will be whitelisted. For example,

<table>
<colgroup>
<col width="100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><div class="container" title="Hint: double-click to select code">
<div class="line number1 index0 alt2">
<code class="java plain">                 &lt;ScopeWhitelist&gt;                </code>
</div>
<div class="line number2 index1 alt1">
<code class="java spaces">                </code> <code class="java plain">                 &lt;Scope&gt;^device_.*&lt;/Scope&gt;                </code>
</div>
<div class="line number3 index2 alt2">
<code class="java spaces">                </code> <code class="java plain">                 &lt;Scope&gt;some_random_scope&lt;/Scope&gt;                </code>
</div>
<div class="line number4 index3 alt1">
<code class="java plain">                 &lt;/ScopeWhitelist&gt;                </code>
</div>
</div></td>
</tr>
</tbody>
</table>

Next, invoke the Token API to get a token for the scope that you just whitelisted. For example,

<table>
<colgroup>
<col width="100%" />
</colgroup>
<tbody>
<tr class="odd">
<td><div class="container" title="Hint: double-click to select code">
<div class="line number1 index0 alt2">
<code class="java plain">                 curl -k -d                </code> <code class="java string">                 &quot;grant_type=password&amp;username=admin&amp;password=admin&amp;scope=some_random_scope&quot;                </code> <code class="java plain">                 -H                </code> <code class="java string">                 &quot;Authorization: Basic WmRFUFBvZmZwYVFnR25ScG5iZldtcUtSS3IwYTpSaG5ocEVJYUVCMEN3T1FReWpiZTJwaDBzc1Vh&quot;                </code> <code class="java plain">                 -H                </code> <code class="java string">                 &quot;Content-Type: application/x-www-form-urlencoded&quot;                </code> <code class="java plain">                 https:                </code> <code class="java comments">                 //10.100.0.3:8243/token                </code>
</div>
</div></td>
</tr>
</tbody>
</table>

Note that the issued token has the scope you requested. You get the token without any role validation as the scope is whitelisted.

|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `                 {                ` `                 "scope"                ` `                 :                ` `                 "some_random_scope"                ` `                 ,                ` `                 "token_type"                ` `                 :                ` `                 "bearer"                ` `                 ,                ` `                 "expires_in"                ` `                 :                ` `                 3600                ` `                 ,                ` `                 "refresh_token"                ` `                 :                ` `                 "59e6676db0addca46e68991e44f2b8b8"                ` `                 ,                ` `                 "access_token"                ` `                 :                ` `                 "48855d444db883171c347fa21ba77e8"                ` `                 }                ` |

------------------------------------------------------------------------

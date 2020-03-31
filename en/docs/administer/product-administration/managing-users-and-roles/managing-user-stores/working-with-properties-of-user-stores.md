# Working with Properties of User Stores

The following table provides descriptions of the key properties you use to configure primary user stores.

<table>
<thead>
<tr class="header">
<th><p>Property name</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>             MaxUserNameListLength            </code></td>
<td>Controls the number of users listed in the user store of a WSO2 product. This is useful when you have a large number of users and don't want to list them all. Setting this property to 0 displays all users.</td>
</tr>
<tr class="even">
<td><code>             ConnectionURL            </code></td>
<td><p>Connection URL to the user store server. In the case of default LDAP in Carbon, the port is specified in the <code>              carbon.xml             </code> file, and a reference to that port is included in this configuration.</p></td>
</tr>
<tr class="odd">
<td><code>             ConnectionName            </code></td>
<td><p>The username used to connect to the database and perform various operations. This user does not have to be an administrator in the user store or have an administrator role in the WSO2 product that you are using, but this user MUST have permissions to read the user list and users' attributes and to perform search operations on the user store. The value you specify is used as the DN ( <code>              Distinguish Name             </code> ) attribute of the user. This property is mandatory.</p></td>
</tr>
<tr class="even">
<td><code>             ConnectionPassword            </code></td>
<td>Password for the <code>             ConnectionName            </code> user.</td>
</tr>
<tr class="odd">
<td><code>             DisplayNameAttribute            </code></td>
<td>This is an optional property. The Display Name Attribute is the name by which users will be listed when you search for users in the management console (Go to <strong>Configuration -&gt; Users</strong> tab).</td>
</tr>
<tr class="even">
<td><code>             PasswordHashMethod            </code></td>
<td>Password hash method to use when storing user entries in the user store.</td>
</tr>
<tr class="odd">
<td><code>             UserNameListFilter            </code></td>
<td><p>Filtering criteria for listing all the user entries in the user store. This query or filter is used when doing search operations on users. In this case, the search operation only provides the objects created from the specified class. This query is the same as listing out all the available users in the management console.</p></td>
</tr>
<tr class="even">
<td><code>             UserEntryObjectClass            </code></td>
<td>Object class used to construct user entries. By default, it is a custom object class defined with the name <code>             wso2Person            </code> .</td>
</tr>
<tr class="odd">
<td><code>             UserSearchBase            </code></td>
<td><div class="content-wrapper">
<p>DN of the context or object under which the user entries are stored in the user store. In this case, it is the &quot;users&quot; container. When the user store searches for users, it will start from this location of the directory.</p>
!!! info
<p>Different databases have different search bases.</p>

</div></td>
</tr>
<tr class="even">
<td><code>             UserNameSearchFilter            </code></td>
<td>Filtering criteria used to search for a particular user entry.</td>
</tr>
<tr class="odd">
<td><code>             UserNameAttribute            </code></td>
<td><div class="content-wrapper">
<p>The attribute used for uniquely identifying a user entry. Users can be authenticated using their email address, UID, etc.</p>
!!! info
<p>The name of the attribute is considered as the username.</p>

<p>For information on using email address to authenticate users, click <a href="https://docs.wso2.com/display/IS530/Using+Email+Address+as+the+Username">here</a> .</p>
</div></td>
</tr>
<tr class="even">
<td><code>             UsernameWithEmailJavaScriptRegEx            </code></td>
<td><div class="content-wrapper">
<p>This property defines the JavaScript regular expression pattern when the <code>               EnableEmailUserName              </code> property is set to <code>               true              </code> in <strong>carbon.xml</strong> configuration file. If you need to support both email as a user name and normal user names, you can set this property as follows.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;Property name=&quot;UsernameWithEmailJavaScriptRegEx&quot;&gt;^[\S]{3,30}$&lt;/Property&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td><p><code>              PasswordJavaScriptRegEx             </code></p></td>
<td>Policy that defines the password format.</td>
</tr>
<tr class="even">
<td><code>             UsernameJavaScriptRegEx            </code></td>
<td>The regular expression used by the front-end components for username validation.</td>
</tr>
<tr class="odd">
<td><code>             UsernameJavaRegEx            </code></td>
<td><div class="content-wrapper">
<p>A regular expression to validate usernames. By default, strings have a length of 5 to 30. Only non-empty characters are allowed. You can provide ranges of alphabets, numbers and also ranges of ASCII values in the RegEx properties.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;Property name=&quot;UsernameJavaRegEx&quot;&gt;[a-zA-Z0-9._\-|/]{3,30}$&lt;/Property&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td><code>             RolenameJavaScriptRegEx            </code></td>
<td>The regular expression used by the front-end components for role name validation.</td>
</tr>
<tr class="odd">
<td><code>             RolenameJavaRegEx            </code></td>
<td><div class="content-wrapper">
<p>A regular expression used to validate role names. By default, strings have a length of 5 to 30. Only non-empty characters are allowed.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;Property name=&quot;RolenameJavaRegEx&quot;&gt;[a-zA-Z0-9._\-|/]{3,30}$&lt;/Property&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="even">
<td><p><code>              CaseInsensitiveUsername             </code></p></td>
<td><div class="content-wrapper">
<p>(JDBC) This property can be set to 'false' for case insensitive JDBC user stores for performance improvements.</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;Property name=&quot;CaseInsensitiveUsername&quot;&gt;false&lt;/Property&gt;</code></pre>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td><code>             ReadGroups            </code></td>
<td>Specifies whether groups should be read from the user store. If this is disabled by setting it to <code>             false            </code> , none of the groups in the user store can be read, and the following group configurations are NOT mandatory: <code>             GroupSearchBase            </code> , <code>             GroupNameListFilter            </code> , or <code>             GroupNameAttribute            </code> .</td>
</tr>
<tr class="even">
<td><code>             Referral            </code></td>
<td>Guides the request to a domain controller in the correct domain</td>
</tr>
<tr class="odd">
<td><code>             WriteGroups            </code></td>
<td>Specifies whether groups should be written to user store.</td>
</tr>
<tr class="even">
<td><code>             EmptyRolesAllowed            </code></td>
<td>Specifies whether the underlying user store allows empty groups to be created. In the case of LDAP in Carbon, the schema is modified such that empty groups are allowed to be created. Usually LDAP servers do not allow you to create empty groups.</td>
</tr>
<tr class="odd">
<td><code>             GroupSearchBase            </code></td>
<td>DN of the context under which user entries are stored in the user store.</td>
</tr>
<tr class="even">
<td><code>             GroupSearchFilter            </code></td>
<td>The query used to search for groups.</td>
</tr>
<tr class="odd">
<td><code>             GroupNameListFilter            </code></td>
<td>Filtering criteria for listing all the group entries in the user store. Groups are created in LDAP using the &quot; <code>             groupOfName            </code> &quot; class. The group search operation only returns objects created from this class.</td>
</tr>
<tr class="even">
<td><code>             GroupEntryObjectClass            </code></td>
<td>Object class used to construct group entries.</td>
</tr>
<tr class="odd">
<td><code>             GroupNameSearchFilter            </code></td>
<td>Filtering criteria used to search for a particular group entry.</td>
</tr>
<tr class="even">
<td><code>             GroupNameAttribute            </code></td>
<td>Attribute used for uniquely identifying a user entry. This attribute is to be treated as the group name.</td>
</tr>
<tr class="odd">
<td><code>             MembershipAttribute            </code></td>
<td>Attribute used to define members of groups.</td>
</tr>
<tr class="even">
<td><code>             MembershipAttributeRange            </code></td>
<td>Attribute used by Active Directories where they need limit membership attributes. The default value for this is 1500.</td>
</tr>
<tr class="odd">
<td><code>             UserRolesCacheEnabled            </code></td>
<td>This is to indicate whether to cache the role list of a user. By default this is set to <code>             true            </code> . Set it to <code>             false            </code> if the user roles are changed by external means and those changes should be instantly reflected in the Carbon instance.</td>
</tr>
<tr class="even">
<td><code>             UserDNPattern            </code></td>
<td>(LDAP) The patten for the user's DN, which can be defined to improve the search. When there are many user entries in the LDAP user store, defining a <code>             UserDNPattern            </code> provides more impact on performances as the LDAP does not have to travel through the entire tree to find users.</td>
</tr>
<tr class="odd">
<td><code>             ReplaceEscapeCharactersAtUserLogin            </code></td>
<td>(LDAP) If the user name has special characters it replaces it to validate the user logging in. Only &quot; <strong>\</strong> &quot; and &quot; <strong>\\</strong> &quot; are identified as escape characters.</td>
</tr>
<tr class="even">
<td><code>             TenantManager            </code></td>
<td>Includes the location of the tenant manager.</td>
</tr>
<tr class="odd">
<td><p><code>              ReadOnly             </code></p></td>
<td>(LDAP and JDBC) Indicates whether the user store of this realm operates in the user read only mode or not.</td>
</tr>
<tr class="even">
<td><p><code>              IsEmailUserName             </code></p></td>
<td>(JDBC) Indicates whether the user's email is used as their username (apply when realm operates in read-only mode).</td>
</tr>
<tr class="odd">
<td><p><code>              DomainCalculation             </code></p></td>
<td>(JDBC) Can be either default or custom (this applies when the realm operates in read only mode).</td>
</tr>
<tr class="even">
<td><p><code>              PasswordDigest             </code></p></td>
<td><p>(JDBC) Digesting algorithm of the password. Has values such as, PLAIN_TEXT, SHA etc.</p></td>
</tr>
<tr class="odd">
<td><p><code>              StoreSaltedPassword             </code></p></td>
<td><div class="content-wrapper">
<p>(JDBC) Indicates whether to salt the password.</p>
!!! tip
<p><strong>Tip:</strong> Make sure you secure the password with salt and key.</p>

</div></td>
</tr>
<tr class="even">
<td><p><code>              UserNameUniqueAcrossTenants             </code></p></td>
<td><p>(JDBC) An attribute used for multi-tenancy.</p></td>
</tr>
<tr class="odd">
<td><p><code>              PasswordJavaRegEx             </code></p></td>
<td><p>(LDAP and JDBC) A regular expression to validate passwords. By default, strings having a length between 5 to 30 with non-empty characters are allowed.</p></td>
</tr>
<tr class="even">
<td><p><code>              PasswordJavaScriptRegEx             </code></p></td>
<td>The regular expression used by the front-end components for password validation.</td>
</tr>
<tr class="odd">
<td><p><code>              UsernameJavaRegEx             </code></p></td>
<td>A regular expression to validate usernames. By default, strings having a length 5 to 30 between with non-empty characters are allowed.</td>
</tr>
<tr class="even">
<td><code>             UsernameJavaScriptRegEx            </code></td>
<td>The regular expression used by the front-end components for username validation.</td>
</tr>
<tr class="odd">
<td><p><code>              RolenameJavaRegEx             </code></p></td>
<td>A regular expression to validate role names. By default, strings having a length between 5 to 30 with non-empty characters are allowed.</td>
</tr>
<tr class="even">
<td><p><code>              RolenameJavaScriptRegEx             </code></p></td>
<td>The regular expression used by the front-end components for rolename validation.</td>
</tr>
<tr class="odd">
<td><pre><code>MultiTenantRealmConfigBuilder</code></pre></td>
<td>Tenant Manager specific realm config parameter. Can be used to build different types of realms for the tenant.</td>
</tr>
<tr class="even">
<td><code>             SharedGroupEnabled            </code></td>
<td>This property is used to enable/disable the shared role functionality.</td>
</tr>
<tr class="odd">
<td><code>             SharedGroupSearchBase            </code></td>
<td>Shared roles are created for other tenants to access under the mentioned DN.</td>
</tr>
<tr class="even">
<td><code>             SharedTenantObjectClass            </code></td>
<td>Object class for the shared groups created.</td>
</tr>
<tr class="odd">
<td><code>             SharedTenantNameAttribute            </code></td>
<td>Name attribute for the shared group.</td>
</tr>
<tr class="even">
<td><code>             SharedTenantNameListFilter            </code></td>
<td>This is currently not used.</td>
</tr>
<tr class="odd">
<td><p><code>                             LDAPConnectionTimeout                           </code></p></td>
<td>If the connection to an LDAP is inactive for the length of time (in milliseconds) specified by this property, the connection will be terminated.</td>
</tr>
</tbody>
</table>



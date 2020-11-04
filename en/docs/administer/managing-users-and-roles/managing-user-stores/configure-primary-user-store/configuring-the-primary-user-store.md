# Configuring the Primary User Store

This is the main user store that is shared among all the tenants in the system. Only one user store can be configured as the primary user store. This documentation explains the process of setting up a primary user store for your system.

!!! info
    **The default User Store** : The primary user store that is configured by default, is a JDBC user store, which reads/writes into an internal database. By default, the internal database is H2. This database is used by the Authorization Manager (for user authorization information) as well as, the User Store Manager (for defining users and roles).


Instead of using the embedded database, you can set up a separate repository and configure it as your primary user store. Since the user store you want to connect to might have different schemas from the ones available in the embedded user store, it needs to go through an adaptation process. We do the necessary adaptations depending on the user store type. We support the following primary user store types.

<table>
<colgroup>
<col width="20%" />
<col width="40%" />
<col width="40%" />
</colgroup>
<thead>
<tr class="header">
<th>User store type</th>
<th>User store manager class</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>read_only_ldap</strong></td>
<td><code>org.wso2.carbon.user.core.ldap.UniqueIDReadOnlyLDAPUserStoreManager</code></td>
<td><p>Use <code>read_only_ldap</code> to do read-only operations for external LDAP user stores.</p></td>
</tr>
<tr class="even">
<td><strong>read_write_ldap</strong></td>
<td><code>org.wso2.carbon.user.core.ldap.UniqueIDReadWriteLDAPUserStoreManager</code></td>
<td><p>Use <code>read_write_ldap</code> for external LDAP user stores to do both read and write operations.</p></td>
</tr>
<tr class="odd">
<td><strong>active_directory</strong></td>
<td><code>org.wso2.carbon.user.core.ldap.UniqueIDActiveDirectoryUserStoreManager </code></td>
<td><p>Use <code>active_directory</code> to configure an Active Directory Domain Service (AD DS) or Active Directory Lightweight Directory Service (AD LDS). This can be used <strong>only</strong> for read/write operations. If you need to use AD as read-only, you must use <code>read_only_ldap</code> .</p></td>
</tr> 
<tr class="even">
<td><strong>database_unique_id</strong></td>
<td><code>org.wso2.carbon.user.core.jdbc.UniqueIDJDBCUserStoreManager</code></td>
<td><p>Use <code>database</code> for both internal and external JDBC user stores. This is the user store configuration which is configured by default.</p></td>
</tr>
</tbody>
</table>

This can be defined in the `[user_store]` section of the `<APIM_HOME>/repository/conf/deployment.toml` file.

``` bash tab="Response Format"
[user_store]
type = <type>
```

``` bash tab="Example Response"
[user_store]
type = "database_unique_id"
```

Follow the links given below to setup the required type of primary user store.

-   [Configuring a JDBC User Store](../configuring-a-jdbc-user-store)
-   [Configuring a Read-Only LDAP User Store](../configuring-a-read-only-ldap-user-store)
-   [Configuring a Read-Write Active Directory User Store](../configuring-a-read-write-active-directory-user-store)
-   [Configuring a Read-Write LDAP User Store](../configuring-a-read-write-ldap-user-store)

!!! note
    You can create a simple custom user store manager for WSO2 API Manager.
    See [Writing a custom user store manager]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/writing-a-custom-user-store-manager).
    
   
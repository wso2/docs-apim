# admin\_Configuring the Primary User Store

User management functionality is provided by default in all WSO2 Carbon-based products and is configured in the `user-mgt.xml` file found in the `<PRODUCT_HOME>/repository/conf/` directory. This documentation explains the process of setting up a primary user store for your system.

!!! info
The default User Store

The primary user store that is configured by default in every WSO2 product is a JDBC user store, which reads/writes into the internal database of the product server. By default, the internal database is H2 (except for WSO2 IS, which uses an LDAP as the default user store). This database is used by the Authorization Manager (for user authentication information) as well as the User Store Manager (for defining users and roles).


Instead of using the embedded database, you can set up a separate repository and configure it as your primary user store. Since the user store you want to connect to might have different schemas from the ones available in the embedded user store, it needs to go through an adaptation process. WSO2 products provide the following adapters, for connecting to LDAP, Active Directory and JDBC. Thereby, these adapters enable you to authenticate users from different types of user stores.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>User store manager class</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre><code>org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager</code></pre></td>
<td><p>Use <code>              ReadOnlyLDAPUserStoreManager             </code> to do read-only operations for external LDAP user stores.</p></td>
</tr>
<tr class="even">
<td><code>             org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager            </code></td>
<td><p>Use <code>              ReadWriteLDAPUserStoreManager             </code> for external LDAP user stores to do both read and write operations. This is the user store configuration which is uncommented in the code in the <code>              user-mgt.xml             </code> file for WSO2 Identity Server.</p></td>
</tr>
<tr class="odd">
<td><pre><code>org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager</code></pre></td>
<td><p>Use <code>              ActiveDirectoryUserStoreManager             </code> to configure an Active Directory Domain Service (AD DS) or Active Directory Lightweight Directory Service (AD LDS). This can be used <strong>only</strong> for read/write operations. If you need to use AD as read-only, you must use <code>              org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager             </code> .</p></td>
</tr>
<tr class="even">
<td><pre><code>org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager</code></pre></td>
<td><p>Use <code>              JDBCUserStoreManager             </code> for both internal and external JDBC user stores. This is the user store configuration which is uncommented in the code in the <code>              user-mgt.xml             </code> file for all WSO2 products, except WSO2 Identity Server (which uses the <code>              ReadWriteLDAPUserStoreManager             </code> ).</p></td>
</tr>
</tbody>
</table>

The `user-mgt.xml` file already has sample configurations for all of the above user stores. To enable the required user store configuration, you must uncomment them in the code and comment out the ones that you do not need as explained in the following topics.

-   [admin\_Configuring a JDBC User Store](_admin_Configuring_a_JDBC_User_Store_)
-   [admin\_Configuring a Read-Only LDAP User Store](_admin_Configuring_a_Read-Only_LDAP_User_Store_)
-   [admin\_Configuring a Read-Write Active Directory User Store](_admin_Configuring_a_Read-Write_Active_Directory_User_Store_)
-   [admin\_Configuring a Read-Write LDAP User Store](_admin_Configuring_a_Read-Write_LDAP_User_Store_)


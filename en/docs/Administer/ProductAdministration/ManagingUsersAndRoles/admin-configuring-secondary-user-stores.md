# admin\_Configuring Secondary User Stores

The default configurations of WSO2 products have a single, embedded user store (primary user store). If required, you can configure WSO2 products to connect to several secondary user stores as well. After configuration, users from different stores can log in and perform operations depending on their roles/permissions. You can also configure your own customized user stores and connect them with the products as secondary stores.

The topics below explain how to configure secondary user stores manually or using the management console:

-   [Configuring using the management console](#admin_ConfiguringSecondaryUserStores-Configuringusingthemanagementconsole)
-   [Configuring manually](#admin_ConfiguringSecondaryUserStores-Configuringmanually)

!!! tip
Before you begin:

If you are setting up a database other than the default H2 that comes with the product to store user information, select the script relevant to your database type from the `<PRODUCT_HOME>/dbscripts` folder and run it on your database. It creates the necessary tables.


#### Configuring using the management console

1.  Log in to the management console and click **Add** under the **User Stores** submenu in the **Main** menu.
2.  The **Add New User Store** page opens.

        !!! info
    **Note** : You cannot update the PRIMARY user store at runtime, so it is not visible on this page.


3.  In the User Store Manager Class list, select the type of user store you are creating.

    <table>
    <thead>
    <tr class="header">
    <th>User store manager</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><pre><code>org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager</code></pre></td>
    <td><p>Use <code>                ReadOnlyLDAPUserStoreManager               </code> to do read-only operations for LDAP user stores.</p></td>
    </tr>
    <tr class="even">
    <td><code>               org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager              </code></td>
    <td><p>Use <code>                ReadWriteLDAPUserStoreManager               </code> for LDAP user stores to do both read and write operations.</p></td>
    </tr>
    <tr class="odd">
    <td><pre><code>org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager</code></pre></td>
    <td><p>Use <code>                ActiveDirectoryUserStoreManager               </code> to configure an Active Directory Domain Service (AD DS) or Active Directory Lightweight Directory Service (AD LDS). This can be used <strong>only</strong> for read/write operations. If you need to use AD as read-only, you must use <code>                org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager               </code> .</p></td>
    </tr>
    <tr class="even">
    <td><pre><code>org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager</code></pre></td>
    <td><p>Use <code>                JDBCUserStoreManager               </code> for JDBC user stores. The JDBC user store can be configured for read-only mode or read/write mode using the following property: <code>                &lt;Property name=&quot;ReadOnly&quot;&gt;false/true&lt;/Property&gt;               </code> .</p></td>
    </tr>
    <tr class="odd">
    <td><code>               org.wso2.carbon.identity.user.store.remote.CarbonRemoteUserStoreManger              </code></td>
    <td><div class="content-wrapper">
    <p>Use <code>                 CarbonRemoteUserStoreManager                </code> to configure another WSO2 product based on WSO2 Carbon as the user store manager.</p>
        !!! note
        <p><strong>Note</strong> : Any secondary user stores that are configured to the WSO2 product are not supported. However, the primary user store of the WSO2 product you point to works as expected.</p>

    </div></td>
    </tr>
    </tbody>
    </table>

    You can also populate this drop-down list with custom user store manager implementations by adding them to the server.
    [Here](https://github.com/wso2/product-is/tree/v5.1.0/modules/samples/user-mgt/sample-custome-user-store-manager) we are maintaining the samples under the WSO2 Identity Server product repo itself and you can filter that based on the Identity Server version.

4.  Enter a unique domain name with no underscore (\_) characters, and optionally enter a description for this user store.

5.  Enter values for the properties, using the descriptions in the Descriptions column for guidance. The properties that appear vary based on the user store manager class you selected, and there may be additional properties in Optional or Advanced sections at the bottom of the screen. For information on the properties that are used when defining user stores, see [Properties of User Stores](https://docs.wso2.com/display/ADMIN44x/Working+with+Properties+of+User+Stores) .

    ![](attachments/126562324/126562326.png)
        !!! note
    Make sure that you do not enter “federated” as the domain name as the term is reserved for federated users.


6.  Ensure that all the mandatory fields are filled and a valid domain name is given and click **Add** .

7.  A message appears saying that the user stores are being added.
    ![](attachments/31130739/31359112.png)

        !!! info
    **Note** : The above message does not imply that the user store is added successfully. It simply means that the server is attempting to add the new user store to the end of the available chain of stores.


8.  Refresh the page after a few seconds to check the status.

9.  If the new user store is successfully added, it will appear in the **User Stores** page. This can be viewed at any time by clicking **List** under **User Stores** in the **Main** menu.

10. After adding to the server, you can edit the properties of the new secondary user store and enable/disable it in a dynamic manner.

#### Configuring manually

By default, the configuration of the primary user store is saved in the `user-mgt.xml` file. When you create a secondary user store using the management console as explained above, its configuration is saved to an XML file with the same name as the domain name you specify. Alternatively, you can create this XML file manually and save it as follows:

-   -   When you configure multiple user stores, you must **give a unique domain name to each user store** in the `<DomainName>` element. If you configure a user store without specifying a domain name, the server throws an exception at startup.
    -   If it is the configuration of a super tenant, save the secondary user store definitions in &lt; `PRODUCT_HOME>/repository/deployment/server/userstores` directory.
    -   If it is a general tenant, save the configuration in &lt; `PRODUCT_HOME>/repository/tenants/<tenantid>/userstores` directory.
    -   The secondary user store configuration file must have the same name as the domain with an underscore (\_) in place of the period. For example, if the domain is `wso2.com,` name the file as `wso2_com.xml           `
    -   Only one file contains the definition for one user store domain.



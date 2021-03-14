# Configuring Secondary User Stores

The default configuration of the WSO2 API Manager has a single, embedded user store (primary user store). If required, you can configure WSO2 products to connect to several secondary user stores as well. After configuration, users from different stores can log in and perform operations depending on their roles/permissions. You can also configure customized user stores and connect them with the products as secondary stores.

There are two approaches to configure a secondary user store. It can be configured manually or configured using the management console.

!!! tip
    **Before you begin:**

    If you are setting up a database other than the default H2 that comes with the product to store user information, select the script relevant to your database type from the `<API-M_HOME>/dbscripts` folder and run it on your database. It creates the necessary tables.


## Configuring secondary user stores via the management console

1. Sign in to the WSO2 API-M Management Console 

2. Click **Main** --> **User Stores** --> **Add**.

     The **Add New User Store** page appears.

    !!! info
        **Note** : You cannot update the PRIMARY user store at runtime, so it is not visible on this page.

3. Select the type of user store that you are creating from the User Store Manager Class list.

    <table>
    <thead>
    <tr class="header">
    <th><b>User store manager</b></th>
    <th><b>Description</b></th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><code>org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager</code> or <code>org.wso2.carbon.user.core.ldap.UniqueIDReadOnlyLDAPUserStoreManager</code></td>
    <td><p>Use <code>ReadOnlyLDAPUserStoreManager</code> to carry out read-only operations for LDAP user stores.</p></td>
    </tr>
    <tr class="even">
    <td><code>org.wso2.carbon.user.core.ldap.ReadWriteLDAPUserStoreManager</code> or <code>org.wso2.carbon.user.core.ldap.UniqueIDReadWriteLDAPUserStoreManager</code></td>
    <td><p>Use <code>ReadWriteLDAPUserStoreManager</code> for LDAP user stores to carry out both read and write operations.</p></td>
    </tr>
    <tr class="odd">
    <td><code>org.wso2.carbon.user.core.ldap.ActiveDirectoryUserStoreManager</code> or <code>org.wso2.carbon.user.core.ldap.UniqueIDActiveDirectoryUserStoreManager</code></td>
    <td><p>Use <code>ActiveDirectoryUserStoreManager</code> to configure an Active Directory Domain Service (AD DS) or Active Directory Lightweight Directory Service (AD LDS). This can be used <strong>only</strong> for read/write operations. If you need to use AD as read-only, you must use <code>org.wso2.carbon.user.core.ldap.UniqueIDReadOnlyLDAPUserStoreManager</code> or <code>org.wso2.carbon.user.core.ldap.ReadOnlyLDAPUserStoreManager</code>.</p></td>
    </tr>
    <tr class="even">
    <td><code>org.wso2.carbon.user.core.jdbc.JDBCUserStoreManager</code> or <code>org.wso2.carbon.user.core.jdbc.UniqueIDJDBCUserStoreManager</code></td>
    <td><p>Use <code>JDBCUserStoreManager</code> for JDBC user stores. The JDBC user store can be configured for read-only mode or read/write mode using the following property: <code>&lt;Property name=&quot;ReadOnly&quot;&gt;false/true&lt;/Property&gt;</code>.</p></td>
    </tr>
    </tbody>
    </table>

    You can also populate this drop-down list with custom user store manager implementations by adding them to the server. For information on implementing a custom user store manager, see [Writing a Custom User Store Manager]({{base_path}}/administer/managing-users-and-roles/managing-user-stores/writing-a-custom-user-store-manager).

    For samples, see [Sample Custom User Store Manager](https://github.com/wso2/product-is/tree/v5.10.0/modules/samples/user-mgt/sample-custom-user-store-manager) in the WSO2 Identity Server product repository.

4. Enter a unique domain name.

     Do not enter underscore (\_) characters in the domain name, and optionally enter a description for this user store.

5. Enter values for the properties, using the descriptions in the Descriptions column for guidance. 

     The properties vary based on the user store manager class that you selected, and there may be additional properties under "Optional" or "Advanced" sections at the bottom of the screen. For information on the properties that are used when defining user stores, see [Properties of User Stores](https://docs.wso2.com/display/ADMIN44x/Working+with+Properties+of+User+Stores).

    [![Secondary user store definition]({{base_path}}/assets/img/administer/secondary-user-store-definition.png)]({{base_path}}/assets/img/administer/secondary-user-store-definition.png)

    !!! note
        Make sure that you do not enter `federated` as the domain name as the term is reserved for federated users.

6. Ensure that all the mandatory fields are filled and a valid domain name is given and click **Add**.

     A message appears saying that the user stores are being added.
     [![Secondary user store update msg]({{base_path}}/assets/img/administer/secondary-user-store-update-msg.png)]({{base_path}}/assets/img/administer/secondary-user-store-update-msg.png)

    !!! Note
        The above message does not imply that the user store is added successfully. It simply means that the server is attempting to add the new user store to the end of the available chain of stores.

7. Refresh the page after a few seconds to check the status.

8. Check if the user store is successfully added.

     If the new user store is successfully added, it will appear in the **User Stores** page. Click **Main** --> **User Stores** --> **List** in the WSO2 API-M management console to view the newly created user store.

9. After adding the user store to the server, edit the properties of the new secondary user store, and enable/disable it in a dynamic manner.

## Configuring secondary user stores manually

By default, the configuration of the primary user store is saved in the `user-mgt.xml` file. When you create a secondary user store using the management console as explained above, its configuration is saved to an XML file with the same name as the domain name that you specified. Alternatively, you can create this XML file manually and save it as follows:

-   When you configure multiple user stores, you must **define unique domain names to each of the user stores** in the `<DomainName>` element. If you configure a user store without specifying a domain name, the server throws an exception at startup.
-   If the configuration is for a super tenant, save the secondary user store definitions in the `<API-M_HOME>/repository/deployment/server/userstores` directory.
-   If the configuration is for a general tenant, save the configuration in the `<API-M_HOME>/repository/tenants/<tenantid>/userstores` directory.
-   The secondary user store configuration file must have the same name as the domain with an underscore (\_) in place of the period. 

     For example, if the domain is `wso2.com,` name the secondary user store configuration file as `wso2_com.xml`

- Each file should only contain the definition for a single user store domain.

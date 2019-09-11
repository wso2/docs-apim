# Managing Tenants

You can add a new tenant in the management console and then view it by following the procedure below. In order to add a new tenant, you should be logged in as a super user.

1.  Click **Add New Tenant** in the **Configure** tab of the management console.

    ![](attachments/103333432/103333433.png)

2.  Enter the tenant information in **Register A New Organization** screen as follows, and click **Save** .

    | Parameter Name                   | Description                                                                                                                                                                                                                                                                                       |
    |----------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **Domain**                       | The domain name for the organization, which should be unique (e.g., abc.com). This is used as a unique identifier for your domain. You can use it to log into the admin console to be redirected to your specific tenant. The domain is also used in URLs to distinguish one tenant from another. |
    | **Select Usage Plan for Tenant** | The usage plan defines limitations (such as number of users, bandwidth, etc.) for the tenant. For on-premises deployment, there is only one default plan, i.e., Demo.                                                                                                                             |
    | **First Name** / **Last Name**   | The name of the tenant admin.                                                                                                                                                                                                                                                                     |
    | **Admin Username**               | The login username of the tenant admin. The username always ends with the domain name (e.g., admin@abc.com)                                                                                                                                                                                       |
    | **Admin Password**               | The password used to log in using the admin username specified.                                                                                                                                                                                                                                   |
    | **Admin Password (Repeat)**      | Repeat the password to confirm.                                                                                                                                                                                                                                                                   |
    | **Email**                        | The email address of the admin.                                                                                                                                                                                                                                                                   |

        !!! note
    Note thant all the above parameters are required parameters.


3.  After saving, the newly added tenant appears in the **Tenants List** page as shown below. Click **View Tenants** in the **Configure** tab of the management console to see information of all the tenants that currently exist in the system.  Enter the domain name in the **Enter the Tenant Domain** parameter and click **Find** to find the newly added tenant in the list.
    ![](attachments/103333432/103333438.png)

When you create multiple tenants in an API Manager deployment, the API Stores of each tenant are displayed in a muti-tenanted view for all users to browse and permitted users to subscribe to as shown below:

1.  Access the API Store URL (by default, `https://localhost:9443/store` ) using a Web browser. You see the storefronts of all the registered tenant domains listed there. For example,
    ![](attachments/103333432/103333440.png)    This is called the public store. Each icon here is linked to the API Store of a registered tenant, including the super tenant, which is `carbon.super` . That is, the super tenant is also considered a tenant.
2.  Click the **Visit Store** link associated with a given store to open it.
3.  Anonymous users can browse all stores and all public APIs that are published to them. However, in order to subscribe to an API, the user must log in.

    For example, if you are a user in the `domain1.com` tenant domain,

    -   You can access the public store ( `https://localhost:9443/store` ), go to the `domain1.com` store, log in to it and subscribe to its APIs.
    -   You can also browse the other tenant stores listed in the public store. But, within other tenant stores, you can only subscribe to the APIs to which your tenant domain is permitted to subscribe to. At the time an API is created, the API creator can specify which tenants are allowed to subscribe to the API. For information, see [API Subscriptions](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API#CreateandPublishanAPI-Subscriptions) .

        !!! info
    Other tenant management operations such as activating, deactivating, updating and deleting, which are not available in the Management Console UI, can be done through the `RemoteTenantManager` Admin Service. Y ou can invoke these operations u sing a SOAP client like SOAP UI. Follow the steps below to do the onfigurations using SOAP UI.

    1.  Open the `<API-M_HOME>/repository/conf/carbon.xml` file and set `HideAdminServiceWSDLs` parameter to false.
    2.  Start SOAP UI client, and import the WSDL `https://localhost:9443/services/RemoteTenantManagerService?wsdl` . This assumes that you are running the SOAP UI client from the same machine as the API Manager instance.

    3.  Note that there are several operations shown in the SOAP UI after importing the wsdl file:
        ![](attachments/103333432/103333434.png)    4.  Click on each operation to open the request view. For an example, for `activateTenant` operation, you can see the following request view:
        ![](attachments/103333432/103333435.png)
    5.  You can invoke the `RemoteTenantManager` Admin service and do the tenant activation operation with the corresponding tenant ID. You can perform the other operations via SOAP UI as well. Note that you need to set the admin user credentials from the SOAP UI to invoke tenant admin operations.

!!! warning
If you perform operations such as tenant deletion, even though the tenant details are removed, any data stored in registry, file system, other databases, etc. will not be removed. Such data will need to be removed manually.



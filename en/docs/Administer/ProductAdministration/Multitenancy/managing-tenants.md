# Managing Tenants

You can add a new tenant in the management console and then view it by following the procedure below. In order to add a new tenant, you should be logged in as a super user.

1.  Click **Add New Tenant** in the **Configure** tab of the management console.

    ![]({{base_path}}/assets/attachments/103333432/103333433.png)

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
        Note that all the above parameters are required parameters.


3.  After saving, the newly added tenant appears in the **Tenants List** page as shown below. Click **View Tenants** in the **Configure** tab of the management console to see information of all the tenants that currently exist in the system.  Enter the domain name in the **Enter the Tenant Domain** parameter and click **Find** to find the newly added tenant in the list.
    [![](../../../../assets/img/Administer/tenant-list.png)](../../../../assets/img/Administer/tenant-list.png)

When you create multiple tenants in an API Manager deployment, the API Developer Portals of each tenant are displayed in a muti-tenanted view for all users to browse and permitted users to subscribe to as shown below:

1.  Access the API Developer Portal URL (by default, `https://localhost:9443/devportal` ) using a Web browser. You see the storefronts of all the registered tenant domains listed there. For example,
    [![](../../../../assets/img/Administer/tenant-developer-portals.png)](../../../../assets/img/Administer/tenant-developer-portals.png)
    
     This is called the public Developer Portal. Each icon here is linked to the API Developer Portal of a registered tenant, including the super tenant, which is `carbon.super` . That is, the super tenant is also considered a tenant.

2.  Click the domain associated with a given Developer Portal to open it.

3.  Anonymous users can browse all Developer Portals and all public APIs that are published to them. However, in order to subscribe to an API, the user must log in.

    For example, if you are a user in the `domain1.com` tenant domain,

    -   Click the **Go To Public Dev Portal** option available in the Navigation bar, go to the `domain1.com` Developer Portal, log in to it and subscribe to its APIs.
    [![](../../../../assets/img/Administer/tenant-naviagtion-bar.png)](../../../../assets/img/Administer/tenant-naviagtion-bar.png)
    -   You can also browse the other tenant Developer Portals listed in the public Developer Portal. But, within other tenant Developer Portals, you can only subscribe to the APIs to which your tenant domain is permitted to subscribe to. At the time an API is created, the API creator can specify which tenants are allowed to subscribe to the API. For information, see [API Subscriptions](../../../Learn/ConsumeAPI/ManageSubscription/subscribe-to-an-api.md) .

    !!! info
        Deleting tenant which is not available in the Management Console UI, can be done through the `RemoteTenantManager` Admin Service. You can invoke these operations using a SOAP client like SOAP UI. Follow the steps below to do the onfigurations using SOAP UI.


        1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and add the following configuration.
        ``` java
            [admin_service.wsdl]
            enable=true
        ```
        
        2.  Start SOAP UI client, and import the WSDL `https://localhost:9443/services/RemoteTenantManagerService?wsdl` . This assumes that you are running the SOAP UI client from the same machine as the API Manager instance.

        3.  Note that there are several operations shown in the SOAP UI after importing the wsdl file:
            ![]({{base_path}}/assets/attachments/103333432/103333434.png)    
            
        4.  Click on each operation to open the request view. For an example, for `activateTenant` operation, you can see the following request view:
            ![]({{base_path}}/assets/attachments/103333432/103333435.png)
        5.  You can invoke the `RemoteTenantManager` Admin service and do the tenant activation operation with the corresponding tenant ID. You can perform the other operations via SOAP UI as well. Note that you need to set the admin user credentials from the SOAP UI to invoke tenant admin operations.

!!! warning
    If you perform operations such as tenant deletion, even though the tenant details are removed, any data stored in registry, file system, other databases, etc. will not be removed. Such data will need to be removed manually.



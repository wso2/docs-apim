# Managing Tenants


##Adding a new tenant
You can add a new tenant in the management console and then view it by following the procedure below. In order to add a new tenant, you should be logged in as a super user.

1.  Click **Add New Tenant** in the **Configure** tab of the management console.
    ![]({{base_path}}/assets/img/administer/configure-tenants.png)
    
2.  Enter the tenant information in **Register A New Organization** screen as follows, and click **Save** .

    | Parameter Name                   | Description                                                                                                                                                                                                                                                                                       |    Required    |
    |----------------------------------|----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **Domain**                       | The domain name for the organization, which should be unique (e.g., abc.com). This is used as a unique identifier for your domain. You can use it to log into the admin console to be redirected to your specific tenant. The domain is also used in URLs to distinguish one tenant from another. |    yes|
    | **Select Usage Plan for Tenant** | The usage plan defines limitations (such as number of users, bandwidth, etc.) for the tenant. For on-premises deployment, there is only one default plan, i.e., Demo.        |  yes                                                                                                                 |
       | **First Name** / **Last Name**   | The name of the tenant admin.                                                                                                                                                                                                                                                                     | yes|
       | **Admin Username**               | The login username of the tenant admin. The username always ends with the domain name (e.g., admin@abc.com)                                                                                                                                                                                       |yes|
       | **Admin Password**               | The password used to log in using the admin username specified.                                                                                                                                                                                                                                   |yes|
       | **Admin Password (Repeat)**      | Repeat the password to confirm.                                                                                                                                                                                                                                                                   |yes|
       | **Email**                        | The email address of the admin.                                                                                                                                                                                                                                                                   |yes|    


3.  After saving, the newly added tenant appears in the **Tenants List** page as shown below. Click **View Tenants** in the **Configure** tab of the management console to see information of all the tenants that currently exist in the system.  Enter the domain name in the **Enter the Tenant Domain** parameter and click **Find** to find the newly added tenant in the list.

    [![]({{base_path}}/assets/img/administer/tenant-list.png)]({{base_path}}/assets/img/administer/tenant-list.png)
    
##Tenant Developer Portals

When you create multiple tenants in an API Manager deployment, the API developer portals of each tenant are displayed in a multi-tenanted view for all users to browse and for permitted users to subscribe to as shown below:

1.  Access the API Developer Portal URL (`https://<hostname>:9443/devportal` ) using a Web browser. The Developer Portal fronts of all the registered tenant domains are listed on the landing page. For example,

    [![]({{base_path}}/assets/img/administer/tenant-developer-portals.png)]({{base_path}}/assets/img/administer/tenant-developer-portals.png)
    
     This is called the public developer portal. Each icon here is linked to the API developer portal of a registered tenant, including the super tenant, which is `carbon.super` . That is, the super tenant is also considered a tenant.

2.  Click the domain associated with a given developer portal to open it.

3.  Anonymous users can browse all developer portals and all public APIs that are published to them. However, in order to subscribe to an API, the user must log in.

    For example, if you are a user in the `domain1.com` tenant domain,

    -   Click the **Go To Public Dev Portal** option available in the Navigation bar, go to the `domain1.com` developer portal, log in to it and subscribe to its APIs.
    [![]({{base_path}}/assets/img/administer/tenant-naviagtion-bar.png)]({{base_path}}/assets/img/administer/tenant-naviagtion-bar.png)
    -   You can also browse the other tenant developer portals listed in the public developer portal. But, within other tenant developer portals, you can only subscribe to the APIs to which your tenant domain is permitted to subscribe to. At the time an API is created, the API creator can specify which tenants are allowed to subscribe to the API. For information, see [API Subscriptions]({{base_path}}/consume/manage-subscription/subscribe-to-an-api.md) .

    !!! info
        A tenant can be deleted through the `RemoteTenantManager` Admin Service. Admin service operations can be invoked using a SOAP client such as SOAP UI. Follow the steps below to do the configurations using SOAP UI.

        1. Open the `<API-M_HOME>/repository/conf/deployment.toml` file and add the following configuration.
        ``` java
            [admin_service.wsdl]
            enable=true
        ```
        
        2.  Start SOAP UI client, and import the WSDL `https://localhost:9443/services/RemoteTenantManagerService?wsdl` . This assumes that you are running the SOAP UI client from the same machine as the API Manager instance.

        3.  Note that there are several operations shown in the SOAP UI after importing the wsdl file:
        [![]({{base_path}}/assets/img/administer/tenant-admin-service-wsdl-list.png)]({{base_path}}/assets/img/administer/tenant-admin-service-wsdl-list.png)
            
        4.  Click on each operation to open the request view. For an example, for `activateTenant` operation, you can see the following request view:
        [![]({{base_path}}/assets/img/administer/tenant-admin-service-wsdl-service.png)]({{base_path}}/assets/img/administer/tenant-admin-service-wsdl-service.png)
        5.  A tenant can be activated by passing the corresponding tenant ID to the tenant activation operation of the `RemoteTenantManager` Admin service. You can perform the other operations via SOAP UI as well. Note that you need to set the admin user credentials from the SOAP UI to invoke tenant admin operations.

!!! warning
    If you perform operations such as tenant deletion, even though the tenant details are removed, any data stored in registry, file system, other databases, etc. will not be removed. Such data will need to be removed manually.



# Adding New Tenants

See the topics given below for instructions.

-   [Adding tenants using the management console](#AddingNewTenants-Addingtenantsusingthemanagementconsole)
-   [Managing tenants using Admin Services](#AddingNewTenants-ManagingtenantsusingAdminServices)

### Adding tenants using the management console

You can add a new tenant in the management console and then view it by following the procedure below. In order to add a new tenant, you should be logged in as a super user.

1.  Click **Add New Tenant** in the **Configure** tab of your product's management console.

    ![]({{base_path}}/assets/attachments/126562777/126562778.png)

2.  Enter the tenant information in **Register A New Organization** screen as follows, and click **Save**.

    | Parameter Name                   | Description                                                                                                                                                                                                                                                                                       |
    |----------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    | **Domain**                       | The domain name for the organization, which should be unique (e.g., abc.com). This is used as a unique identifier for your domain. You can use it to log into the admin console to be redirected to your specific tenant. The domain is also used in URLs to distinguish one tenant from another. |
    | **Select Usage Plan for Tenant** | The usage plan defines limitations (such as the number of users, bandwidth etc.) for the tenant.                                                                                                                                                                                                  |
    | **First Name** / **Last Name**   | The name of the tenant admin.                                                                                                                                                                                                                                                                     |
    | **Admin Username**               | The login username of the tenant admin. The username always ends with the domain name (e.g., admin@abc.com )                                                                                                                                                                                      |
    | **Admin Password**               | The password used to log in using the admin username specified.                                                                                                                                                                                                                                   |
    | **Admin Password (Repeat)**      | Repeat the password to confirm.                                                                                                                                                                                                                                                                   |
    | **Email**                        | The email address of the admin.                                                                                                                                                                                                                                                                   |

3.  After saving, the newly added tenant appears in the **Tenants List** page as shown below. Click **View Tenants** in the **Configure** tab of the management console to see information of all the tenants that currently exist in the system. If you want to view only tenants of a specific domain, enter the domain name in the **Enter the Tenant Domain** parameter and click **Find** .
    ![]({{base_path}}/assets/attachments/126562777/126562781.png)
### Managing tenants using Admin Services

Other tenant management operations such as activating, deactivating, and updating, which are not available in the management console UI, can be done through one of the following admin services:

-`TenantMgtAdminService`
-`RemoteTenantManagerService`

You can invoke these operations using a SOAP client like SOAP UI as follows:

1.  Open the `<PRODUCT_HOME>/repository/conf/carbon.xml` file and set the `HideAdminServiceWSDLs` parameter to false.
2.  Start the product server by executing the product startup script from the `<PRODUCT_HOME>/bin` directory:

    **In Linux**

    ``` java
        sh api-manager.sh
    ```

    **In Windows**

    ``` java
            api-manager.bat
    ```

        !!! tip
    Get the list of available admin services

    If you want to discover the admin services that are exposed by your product:

    1.  Execute the following command:

        **In Linux**

        ``` java
                sh api-manager.sh -DosgiConsole
        ```

        **In Windows**

        ``` java
                    api-manager.bat -DosgiConsole
        ```

    2.  When the server is started, hit the enter/return key several times to get the OSGI shell in the console.
    3.  In the OSGI shell, enter the following: `listAdminServices`

    This will give the list of admin services for your product.


3.  Start the SOAP UI client, and import the WSDL of the admin service that you are using:

    -   For `TenantMgtAdminService: https://localhost:9443/services/TenantMgtAdminService?wsdl`
    -   For `RemoteTenantManagerService: https://localhost:9443/services/RemoteTenantManagerService?wsdl`

    This assumes that you are running the SOAP UI client from the same machine as the product instance. Note that there are several operations shown in the SOAP UI after importing the wsdl file:

    ![]({{base_path}}/assets/attachments/126562777/126562782.png)
        !!! warning
    Before invoking an operation:

    -   Be sure to set the admin user's credentials for authorization in the SOAP UI.
    -   Note that it is **not recommended** to delete tenants.


4.  Click on the operation to open the request view. For example, to activate a tenant use the `activateTenant` operation.

5.  If your tenant domain is abc.com, invoke the `activateTenant` operation with the following request:

    ``` java
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.mgt.tenant.carbon.wso2.org">
           <soapenv:Header/>
           <soapenv:Body>
              <ser:activateTenant>
                 <!--Optional:-->
                 <ser:tenantDomain>abc.com</ser:tenantDomain>
              </ser:activateTenant>
           </soapenv:Body>
        </soapenv:Envelope>
    ```



# Setting up the Microsoft Dynamics365 Environment with Azure

The Microsoft Dynamics 365 (Microsoft Dynamics CRM) Connector allows you to access the [Microsoft Dynamics 365 Web API](https://docs.microsoft.com/en-us/previous-versions/dynamicscrm-2016/developers-guide/mt593051(v=crm.8)?redirectedfrom=MSDN) through WSO2 Enterprise Integrator. The Microsoft Dynamics CRM system (now known as Microsoft Dynamics 365) is a standalone CRM product from Microsoft that provides sales, marketing, and service management capabilities only via individual modules.

To use the Microsoft Dynamics 365, you must have folowing accounts. 

* A Microsoft Dynamics 365 (online) system user account with administrator role for the Microsoft Office 365 subscription
* A Microsoft Azure subscription for application registration

## Authentication to Dynamics 365 using Azure Apps

Dynamics 365 authentication is recommended only through Azure AD (for online instances). To achieve this,

1. Create and configure the app in Azure Active Directory.
2. Create a user in Azure AD and configure it as an application user in Dynamics 365
3. Generate the Access Token and make requests to Dynamics 365 with the above-generated Access Token.

* ## Setting Up an App in Azure

    1. Navigate to the [Azure portal](https://portal.azure.com/) and select **Create an Azure Account**.

        > **Note**: If you creating a Azure account you should get a Microsoft Azure subscription for application registration. Purchase Azure services directly from Microsoft with [pay-as-you-go-pricing](https://azure.microsoft.com/en-us/offers/ms-azr-0003p/). This offer is billed at the standard Pay-As-You-Go rates.

    2. Log in to the created **Azure account**.
    
       <img src="{{base_path}}/assets/img/integrate/connectors/portal-azure-com.png" title="Azure Management Console" width="800" alt="Azure Management Console"/> 
       
    3. Navigate to **Azure Active Directory** –> **App Registration** –> **New Application registration**.
           
       <img src="{{base_path}}/assets/img/integrate/connectors/new-application-registration.png" title="Azure new application registration console" width="800" alt="Azure new application registration console"/> 
       
    4. Now fill in the required fields as shown below and hit **Register**.
    
       <img src="{{base_path}}/assets/img/integrate/connectors/register-an-application.png" title="Register an application" width="800" alt="Register an application"/>
    
       > **Note**:Note that the sign-on URL only matters for something like a single page application – otherwise just putting a localhost URL is just fine.
       
    5. Select **created Application**. 
        
       <img src="{{base_path}}/assets/img/integrate/connectors/created-app.png" title="Created TestWebAPI application" width="800" alt="Created TestWebAPI application"/>       
     
    6. Now you have successfully created an Azure app. Double click the app and you will see its details as shown below. Copy the value of the **Application (client) ID** and **Directory (tenant) ID**.
        
       <img src="{{base_path}}/assets/img/integrate/connectors/application-id.png" title="Application ID" width="800" alt="Application ID"/>
  
    7. You need to give permission to the app to access Dynamics 365. Navigate to **View API permissions**. 
    
       <img src="{{base_path}}/assets/img/integrate/connectors/view-api-permissions.png" title="View API permissions" width="800" alt="View API permissions"/>
    
    8. Click **Add a permission**. 
    
       <img src="{{base_path}}/assets/img/integrate/connectors/add-permission.png" title="Add a permission" width="800" alt="Add a permission"/>  
           
    9. Then select **Dynamics CRM**.     
    
       <img src="{{base_path}}/assets/img/integrate/connectors/select-api.png" title="Select an API" width="800" alt="Select an API"/>
       
    10. Make sure to check the Delegated Permissions checkboxes as shown below. **Select permissions** and click **Add permission**.
     
        <img src="{{base_path}}/assets/img/integrate/connectors/select-permission.png" title="Select CRM permission" width="800" alt="Select CRM permission"/>
       
    11. Click on **Grant Permissions** and click **Yes**.   
       
        <img src="{{base_path}}/assets/img/integrate/connectors/grant-required-permission.png" title="Grant permission" width="800" alt="Grant permission"/>
       
    12. After setting up CRM permissions you will see following console.   
    
        <img src="{{base_path}}/assets/img/integrate/connectors/after-setup-permission.png" title="After setup CRM permissions" width="800" alt="After setup CRM permissions"/> 
    
    13. Now you need to create secret keys. Navigate to **Certificates & secrets**.
        
        <img src="{{base_path}}/assets/img/integrate/connectors/certificate-and-secrets.png" title="Create certificate and secrets" width="800" alt="Create certificate and secrets"/> 
    
    14. Click **New client secrets**.
    
        <img src="{{base_path}}/assets/img/integrate/connectors/new-client-secret.png" title="New client secret" width="800" alt="New client secret"/> 
     
    15. Add **Description** and **Expires** values. Click **Add** and copy the value.    
    
        <img src="{{base_path}}/assets/img/integrate/connectors/add-client-secret.png" title="Add client secret" width="800" alt="Add client secret"/>
    
    16. Search **Users** inside the Azure Active Directory and Create **New user** (this user would be linked to the Application User, which is created in the Dynamics 365 CRM).    
        
        <img src="{{base_path}}/assets/img/integrate/connectors/add-new-user.png" title="Create new user" width="800" alt="Create new user"/>
        
    17. Fill all mandatory fields and click **Create**.    
       
        <img src="{{base_path}}/assets/img/integrate/connectors/create-user.png" title="Fill new user details" width="800" alt="Fill new user details"/>

* ## Setting Up the Application user in Microsoft Dynamics 365 CRM
    
    1. Navigate to [Microsoft Dynamics 365 account](https://portal.office.com/) and select **Create a Dynamics 365  Account**.
    
    2. Log in to the created **Dynamics 365 account**. Click the **Admin** icon.
    
       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-admin-icon.png" title="Dynamics365 admin center" width="800" alt="Dynamics365 admin center"/>
    
    3. Click **Show all** from the dropdown in the left corner scroll bar.
    
       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-show-all.png" title="Dynamics365 show all" width="800" alt="Dynamics365 show all"/>
       
    4. Click **All admin centers** and click **Dynamics 365** icon. It will navigate to the **Power Platform admin center**.

       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-all-admin-center.png" title="Dynamics365 all admin center" width="800" alt="Dynamics365 all admin center"/>

    5. Select the created environment and click **Open environment**.
    
       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-select-environment.png" title="Dynamics365 select environment" width="800" alt="Dynamics365 select environment"/>
       
    6. Navigate to **Settings**.
    
       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-settings.png" title="Dynamics365 settings" width="800" alt="Dynamics365 settings"/>
       
    7. Click **Security** -> **Users**.   
        
       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-Users.png" title="Dynamics365 users" width="800" alt="Dynamics365 users"/>
    
    8. Choose **Application Users** in the view filter.Select -> **New**.
    
       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-filter-application-user.png" title="Filter application users" width="800" alt="Filter application users"/>
    
    9. In the **Application User** form, enter the required information.      
     
       <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics-new-application-user.png" title="Dynamics365 new application user" width="800" alt="Dynamics365 new application user"/>

       The user name information must not match a user that exists in the Azure Active Directory.
       In the **Application ID** field, enter the application ID of the app you registered earlier in the Azure AD.
       
    10. If all goes well, after selecting SAVE, the Application ID URI and Azure AD Object Id fields will auto-populate with correct values. 
    
        <img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-created-application-user.png" title="Dynamics365 created application user" width="800" alt="Dynamics365 created application user"/> 
    
    11. Before exiting the user form, choose MANAGE ROLES and assign a security role to this application user so that the application user can access the desired organization data.
   
## Generate Access Token 

After setting up Azure and Microsoft Dynamics 365 CRM, you can get the access token by invoking the following HTTP request.

POST URL: https://login.microsoftonline.com/<tenant_id>/oauth2/token

Header: Content-Type: application/json

Body: x-www-form-urlencoded

| Key        | Value |
| ------------- |-------------|
| client_id    | Application ID of the registered app in Azure. |
| resource      |https://trial.crm.dynamics.com (Dynamics 365 Online Insance URL |
| Client_secret |Key value from the registered app in Azure|
| Grant_type    |client_credentials|

Please note you need to replace the <tenant_id> with an actual value from your registered app.

Make a request using Postman as below.

<img src="{{base_path}}/assets/img/integrate/connectors/MSdynamics365-access-token.png" title="Obtaining access token" width="800" alt="Obtaining access token"/>

You need to copy and save the following parameter values to proceed with configuring the WSO2 Microsoft Dynamics 365 Connector.

| Key        | Value |
| ------------- |-------------|
| apiUrl    | The instance URL for your organization.|
| accessToken| Value of the Access Token to access the Microsoft Dynamic CRM Web API via request.|
| clientSecret| The secret key of the application that is registered in the Azure AD.|
| resource| The App ID URI of the web API (E.g "https://kavi859.crm5.dynamics.com/).|
# Setting up the Microsoft Azure Storage Environment

To work with the Microsoft Azure Storage connector, you need to have a Microsoft Azure account. If you do not have a Microsoft Azure account, you are prompted to create one when you sign up.

## Signing Up for Microsoft Azure

To sign up for Microsoft Azure:

  1. Navigate to [Microsoft Azure](https://azure.microsoft.com/en-in/free/)  and create a **Microsoft Azure account** using **Start free** button.
    
  2. Follow the online instructions.
    
Part of the sign-up procedure involves receiving a phone call and entering a verification code using the phone keypad. Microsoft Azure will notify you by email when your account is active and available for you to use.
    
## Create Microsoft Azure Storage account

Follow the steps below to obtain the access credentials from Microsoft Azure Storage account.

   1. Go to [Microsoft Azure](https://azure.microsoft.com/en-in/free/), and sign in to the created Microsoft Azure account. On the Azure portal menu, select **All services**. In the list of resources, type **Storage Accounts**. As you begin typing, the list filters based on your input. Select **Storage Accounts**.                                                                                                                           
      
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-homepage.png" title="MS Azure Home Page" width="800" alt="MS Azure Home Page"/>MS-azure-storage-select-account.png   

   2. Go to the dashboard and click **Storage accounts** then click **Add** and fill the required details to create a new storage account.
   
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-select-account.png" title="Select MS Azure storage account" width="800" alt="Select MS Azure storage account"/>
   
   3. On the **Storage Accounts** window that appears, choose **Add**.
   
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-add-storage-account.png" title="MS Azure add storage account" width="800" alt="MS Azure add storage account"/>
   
   4. Select the subscription in which to create the storage account.   
      
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-basic-configurations.png" title="MS azure storage basic configurations" width="800" alt="MS azure storage basic configurations"/>
   
   5. Under the **Resource group** field, select **Create new**. Enter a name for your new resource group.
   
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-create-resource-group.png" title="Create resource group" width="800" alt="Create resource group"/>
     
   6. Enter a name for your **storage account**.    
   
   7. Select a location for your storage account, or use the default location.
   
   8. Leave these fields set to their default values:
      
      | Field        | Value |
      | ------------- |-------------|
      |Deployment model |Resource Manager|
      |Performance    |  Standard|
      |Replication   |   Read-access geo-redundant storage (RA-GRS)|
      |Access tier	|   Hot|
      
   9. Select **Review + Create** to review your storage account settings and create the account.
   
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-review-create.png" title="Review and create" width="800" alt="Review and create"/>
      
   10. Select **Create**.

## Obtaining the access credentials   
   
   1. Navigate to the created **storage account** and click it. 
      
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-select-created-storage.png" title="Select created storage account" width="800" alt="Select created storage account"/>
      
   2. Click **Access keys** under **Settings**.
   
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-getting-accesskeys.png" title="Getting access keys" width="800" alt="Getting access keys"/>
      
   3. Obtain the access key.   
            
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-copy-access-key.png" title="Copy access keys" width="800" alt="Copy access keys"/>   
           
> **Note**:  Azure Storage Account does not support HTTP requests. If you are using a storage key to access the storage account, please set **Secure transfer required** to **Disabled** in storage account configuration on Azure Portal.  
    <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-http-request.png" title="Copy access keys" width="800" alt="Copy access keys"/> 
  
## Setting up the Microsoft Azure Storage Connector

Before you start configuring the Microsoft Azure Storage Connector, you also need WSO2 EI and we refer to that location as <PRODUCT_HOME>.

In order to use the Microsoft Azure Storage connector, you need to download the following .jar file and move it to the `<PRODUCT_HOME>/lib directory`.  

* [azure-storage-6.1.0.jar](https://mvnrepository.com/artifact/com.microsoft.azure/azure-storage/6.1.0)       
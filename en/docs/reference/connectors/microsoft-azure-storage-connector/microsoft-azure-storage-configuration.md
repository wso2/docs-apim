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

## Obtaining the Client credentials

!!! Note
    If you are planning to use Access key for authentication, skip this and check [Obtaining the access credentials]({{base_path}}/reference/connectors/microsoft-azure-storage-connector/microsoft-azure-storage-configuration/#obtaining-the-access-key)
   
   1. Create an Azure Active Directory application and service principal. For more information refer [Create an Azure Active Directory application](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal).

   2. Assign an Azure role for access to blob data. For more information refer [Assign an Azure role](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal) and [Assign an Azure role for access to blob data](https://learn.microsoft.com/en-us/azure/storage/blobs/assign-azure-role-data-access?tabs=portal).

   3. Obtain the Client ID, client Secret and Tenant ID. For more information refer [Create a new application secret](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal#option-3-create-a-new-application-secret) and [Active Directory tenant ID](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/how-to-find-tenant).

## Obtaining the Access Key

!!! Note
    If you are planning to use Client credentials for authentication, skip this and check [Obtaining the Client credentials]({{base_path}}/reference/connectors/microsoft-azure-storage-connector/microsoft-azure-storage-configuration/#obtaining-the-client-credentials)
   
   1. Navigate to the created **storage account** and click it. 
      
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-select-created-storage.png" title="Select created storage account" width="800" alt="Select created storage account"/>
      
   2. Click **Access keys** under **Settings**.
   
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-getting-accesskeys.png" title="Getting access keys" width="800" alt="Getting access keys"/>
      
   3. Obtain the access key.   
            
      <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-copy-access-key.png" title="Copy access keys" width="800" alt="Copy access keys"/>   
           
> **Note**:  Azure Storage Account does not support HTTP requests. If you are using a storage key to access the storage account, please set **Secure transfer required** to **Disabled** in storage account configuration on Azure Portal.  
    <img src="{{base_path}}/assets/img/integrate/connectors/ms-azure-storage-http-request.png" title="Copy access keys" width="800" alt="Copy access keys"/> 
  
## Setting up the Microsoft Azure Storage Connector

Before you start configuring the Microsoft Azure Storage Connector, you also need the WSO2 integration runtime and we refer to that location as `<PRODUCT_HOME>`.

!!! Note
    If you are using the older connector **1.x.x** add only the [azure-storage-6.1.0.jar](https://mvnrepository.com/artifact/com.microsoft.azure/azure-storage/6.1.0) jar to `<PRODUCT_HOME>/lib` directory and skip the following.

In order to use the Microsoft Azure Storage connector, you need to download the following jars and move them to the `<PRODUCT_HOME>/lib` directory.  

 - [azure-storage-blob-12.23.0.jar](https://mvnrepository.com/artifact/com.azure/azure-storage-blob/12.23.0)
 - [azure-identity-1.9.2.jar](https://mvnrepository.com/artifact/com.azure/azure-identity/1.9.2)
 - [azure-storage-common-12.22.0.jar](https://mvnrepository.com/artifact/com.azure/azure-storage-common/12.22.0)
 - [azure-json-1.0.1.jar](https://mvnrepository.com/artifact/com.azure/azure-json/1.0.1)
 - [azure-core-http-netty-1.13.5.jar](https://mvnrepository.com/artifact/com.azure/azure-core-http-netty/1.13.5)
 - [msal4j-1.13.8.jar](https://mvnrepository.com/artifact/com.microsoft.azure/msal4j/1.13.8)
 - [content-type-2.2.jar](https://mvnrepository.com/artifact/com.nimbusds/content-type/2.2)
 - [netty-resolver-dns-4.1.95.Final.jar](https://mvnrepository.com/artifact/io.netty/netty-resolver-dns/4.1.95.Final)
 - [reactive-streams-1.0.4.jar](https://mvnrepository.com/artifact/org.reactivestreams/reactive-streams/1.0.4)
 - [reactor-netty-http-1.1.9.jar](https://mvnrepository.com/artifact/io.projectreactor.netty/reactor-netty-http/1.1.9)
 - [jackson-dataformat-xml-2.13.5.jar](https://mvnrepository.com/artifact/com.fasterxml.jackson.dataformat/jackson-dataformat-xml/2.13.5)
 - [oauth2-oidc-sdk-10.7.1.jar](https://mvnrepository.com/artifact/com.nimbusds/oauth2-oidc-sdk)
 - [reactor-core-3.4.30.jar](https://mvnrepository.com/artifact/io.projectreactor/reactor-core/3.4.30)
 - [stax2-api-4.2.1.jar](https://mvnrepository.com/artifact/org.codehaus.woodstox/stax2-api/4.2.1)
 - [reactor-netty-core-1.1.9.jar](https://mvnrepository.com/artifact/io.projectreactor.netty/reactor-netty-core/1.1.9)
 - [woodstox-core-6.4.0.jar](https://mvnrepository.com/artifact/com.fasterxml.woodstox/woodstox-core/6.4.0)

!!! Note
    If you are using MI 4.0.0, in addition to the above you need to add [netty-codec-http2-4.1.95.Final.jar](https://mvnrepository.com/artifact/io.netty/netty-codec-http2/4.1.95.Final) and [netty-handler-proxy-4.1.95.Final.jar](https://mvnrepository.com/artifact/io.netty/netty-handler-proxy/4.1.95.Final) to `<PRODUCT_HOME>/lib` directory.

!!! Note
      By default `INFO` logs are enabled for the Microsoft Azure SDKs, therefore you may need to update the `log4j2.properties` of the WSO2 integration runtime (MI) accordingly to set the log level. The following configuration will disable the logs printed by the SDK. Eventhough the SDK logs are disabled, MI will print them in case of an error.

      1. Add the following loggers.

            logger.Azure.name = com.azure
            logger.Azure.level = OFF

            logger.Microsoft.name = com.microsoft
            logger.Microsoft.level = OFF

      2. Append `Azure` and `Microsoft` to the loggers list.

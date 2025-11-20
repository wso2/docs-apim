# Discover API on Azure API Gateway

From the 4.6.0 release, WSO2 API Manager supports federated API discovery for APIs deployed in Azure API Gateway. This enables APIs created and managed in Azure to be discovered and brought under the centralized control plane of WSO2 API Manager.

Once discovered, these APIs can fully leverage the control plane capabilities of WSO2 API Manager, including:

Governance enforcement – apply security, compliance, and lifecycle policies consistently.

Unified management – maintain a centralized view of all APIs, eliminating manual imports and fragmented operations.

Developer Portal Features – provide a unified catalog where developers can discover Azure-hosted APIs, explore documentation and test endpoints

By integrating Azure APIs into the control plane, organizations can ensure consistent standards, stronger governance, and improved visibility across their API ecosystem.

Follow the instructions given below to configure Azure API Gateway as a Federated API Gateway.

## Step 1: Create an Azure API Management Service

1. Login to your [Azure](https://portal.azure.com) account and navigate to Home. 
2. Go to **Subscriptions** and create a new Subscription.
3. Go to **Resource Groups** and create a new resource group.
4. Navigate to Home, create a resource, search for **API Management** in the services search bar, select the **API Management** service, and create an API Management service after choosing a subscription.

## Step 2: Create an application and generate credentials

1. In the Azure portal, navigate to Home, then **Microsoft Entra ID**.
2. Click on **Add**, then **App Registration**.
3. Create an application.
4. Navigate to your application, click on the **Manage** dropdown, and select **Certificates and Secrets**.
5. Click on **New Client Secret** and click **Add**.
6. Save the secret **Value** somewhere safe.

!!!note 
    Please save the secret value somewhere safe as you will only be able to view it immediately after creation.

## Step 3 : Register Azure API Gateway as a Federated Gateway in WSO2 API Manager

1. Start WSO2 API Manager.
2. Sign in to the Admin Portal.

    `https://<hostname>:9443/admin`

    `https://localhost:9443/admin`

3. Add a new Gateway Environment.
4. Select the Gateway type as Azure and provide the relevant details in the fields accordingly.
    1. **Gateway Mode** must be either Write-Only or Read-Write if you need to deploy APIs.
    2. **Tenant ID** - Navigate to Home, Microsoft Entra ID, overview, and find the Tenant ID.
    3. **Subscription ID** - Navigate to Home, subscriptions, and find the subscription ID in front of your subscription ID.
    4. **Client ID** - Navigate to Microsoft Entra ID, Manage, App Registrations, and find the client ID in front of your application.
    5. **Client Secret** - The secret value you saved before when creating the client secret.
    6. **Resource Group** - Navigate to Home, Resource group, and find the name of your resource group.
    7. **APIM Service name** - Navigate to Home, All resources, and find the name of your resource.
    8. **APIM Hostname** - The hostname assigned to APIs deployed on Azure. The default is `azure-api.net`, but custom domains can be configured.
3. Save the configurations.

    [![add azure gateway environment]({{base_path}}/assets/img/deploy/add-azure-gw-environment.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/add-azure-gw-environment.png)


## Step 4 : Publish to Developer Portal

1. Sign in to Publisher Portal.

   `https://<hostname>:9443/publisher`

   `https://localhost:9443/publisher`

2. Go to APIs view and the APIs discovered from Azure API Gateway will be listed.
3. Click on the API to view the API details.
4. From the left menu, click **Lifecycle** and select **Publish** so that API will deploy to the Developer Portal.

## Step 4 : Invoke the API
1. Sign in to the Developer Portal.

   `https://<hostname>:9443/devportal`

   `https://localhost:9443/devportal`

2. Navigate to tryout and invoke the API.

!!!note
    WSO2 API Manager currently does not support subscription keys for Azure API invocation. If you need to try out the API from WSO2 API Manager, disable the `subscription required` option in the API's settings tab on Azure.
    If you have enabled the `validate-jwt` policy from Azure, then you can provide the token from WSO2 side in the try out portal.

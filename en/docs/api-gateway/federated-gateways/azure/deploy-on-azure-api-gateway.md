
# Deploy API on Azure API Gateway

WSO2 API Manager supports deploying APIs to Azure API Gateways from version 4.6.0 onwards. WSO2 API Manager comes packed with an Azure gateway connector and it is capable of deploying/undeploying APIs created with WSO2 API Manager to Azure API Gateways.

Follow the instructions given below to configure Azure API Gateway as a Federated API Gateway on WSO2 API Manager.

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
    Save the secret value somewhere safe as you will only be able to view it immediately after creation.

## Step 3 : Register Azure API Gateway as a Federated Gateway in WSO2 API Manager

1. Start WSO2 API Manager.
2. Sign in to the Admin Portal.

    `https://<hostname>:9443/admin`

    `https://localhost:9443/admin`

3. Add a new Gateway Environment.
4. Select the Gateway type as Azure and provide the relevant details in the fields accordingly.
    1. **Gateway Mode** must be either Write-Only or Read-Write if you need to deploy APIs.
    2. **Tenant ID** - Navigate to Home, Microsoft Entra ID, overview, and find the Tenant ID.
    3. **Subscription ID** - Navigate to Home, subscriptions, and find the subscription ID in front of your subscription.
    4. **Client ID** - Navigate to Microsoft Entra ID, Manage, App Registrations, and find the client ID in front of your application.
    5. **Client Secret** - The secret value you saved before when creating the client secret.
    6. **Resource Group** - Navigate to Home, Resource group, and find the name of your resource group.
    7. **APIM Service name** - Navigate to Home, All resources, and find the name of your resource.
    8. **APIM Hostname** - The hostname assigned to APIs deployed on Azure. The default is `azure-api.net`.
3. Save the configurations.

    [![add azure gateway environment]({{base_path}}/assets/img/deploy/add-azure-gw-environment.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/add-azure-gw-environment.png)

## Step 4 : Create and Design API

1. Sign in to the Publisher Portal.

    `https://<hostname>:9443/publisher`

    `https://localhost:9443/publisher`

2. Create a new REST API and select Gateway Type as Azure. And provide a valid endpoint URL.

    [![select azure gateway]({{base_path}}/assets/img/deploy/select-azure-gateway.png){: style="width:90%"}]({{base_path}}/assets/img/deploy/select-azure-gateway.png)

3. Design the API as required.

## Step 5 : Configure Security for the API

By default, APIs will be deployed in Azure without any security. But the capability to enable jwt validation is provided out of the box. Adding the Azure OAuth2 policy from the WSO2 API Manager's publisher portal as an API level or operation level policy will enable the `validate-jwt` policy of the same type (Operation level or API level) in Azure API Management side. You will need to provide an Open ID configuration endpoint URL from where Open ID configuration metadata can be obtained (A well known URL), with which jwt tokens provided with the API invocation will be validated.


1. In WSO2 API Publisher portal, navigate to the `Policies` section of the API created in Step 4 and move to the API level policies tab.

2. Attach the Azure OAuth2.0 policy to the API. Here you will have to provide the OpenID URL .

    [![attach azure oauth policy]({{base_path}}/assets/img/deploy/attach-azure-oauth-policy.png){: style="width:70%"}]({{base_path}}/assets/img/deploy/attach-azure-oauth-policy.png)

## Step 6 : Deploy and Publish API

1. Navigate to `Deployments` and deploy the API to the Azure API Gateway configured in Step 1.

2. Navigate to Lifecycle and Publish the API to the Developer portal.

## Step 7 : Invoke the API

1. Sign in to the Developer Portal.

   `https://<hostname>:9443/devportal`

   `https://localhost:9443/devportal`

2. Create an Application and obtain a jwt access token from where you provided the OpenID URL.

3. Navigate to tryout and invoke the API with the above access token.

!!!note
    If you do not specify an Azure OAuth2 policy when deploying the API, the API will be deployed without any security. Azure OAuth2 policy can be applied at either the API level or the resource level.

!!!note
    Please note that no subscriptions are required for the APIs deployed to Azure API Gateway.

!!!note
    Please note that only REST APIs are supported for deployment to Azure API Gateway.

!!!note
    Out of the policies that are supported by Azure, WSO2 supports enable-jwt (which is the aforementioned OAuth policy), set-header, rate-limit, and CORS. They behave the same as their Azure counterparts. Adding an Azure policy to a flow in an Azure API in WSO2 Publisher portal will add the same to Azure when deployed.
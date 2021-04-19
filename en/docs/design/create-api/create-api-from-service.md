# Create a REST API from an Integration Service

You can create a new REST API by using an integration service that is running in the integration layer (Micro Integrator) of WSO2 API Manager. That is, the backend of the REST API you create is the integration service that is running on the Micro Integrator. This allows you to expose integration services as managed APIs.

To create an API from a service, the integration service should already be published to the **Service Catalog** of the API-M layer by the integration layer.

## Step 1: Discover services

To discover integration services:

1.  Go to the **Publisher Portal**: `https://localhost:9443/publisher`
2.  Click the **Hamburger** in the upper left corner of the **Publisher** and click **Service Catalog** as shown below.

    <a href="{{base_path}}/assets/img/integrate/service-catalog/select-service-catalog.png"><img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/select-service-catalog.png" alt="open service catalog" width="200"></a>

    You will see the list of available integration services:

    <a href="{{base_path}}/assets/img/integrate/service-catalog/services-catalog-list.png"><img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/services-catalog-list.png" alt="service catalog listings"></a>

4.  Use the **search** option to find a specific service.

## Step 2: View details of the service

Click the service from the catalog to view the service details. 

You can view the service name, version, description, usages in APIs, and other important metadata.

<a href="{{base_path}}/assets/img/integrate/service-catalog/service-overview.png"><img src="{{base_path}}/assets/img/integrate/service-catalog/service-overview.png" alt="service overview"></a>

**Download a service definition**

If required, you can **download** the service definition.

**View the service definition**

If you want to see the service definition before creating an API, click **View Definition**:

<a href="{{base_path}}/assets/img/integrate/service-catalog/view-api-definition.png"><img src="{{base_path}}/assets/img/integrate/service-catalog/view-api-definition.png" alt="view api definition"></a>

## Step 3: Create an API from the service

1.  Open the service and click **Create API** to open the **Create API** dialog box.

    <a href="{{base_path}}/assets/img/integrate/service-catalog/create-api-from-service.png"><img src="{{base_path}}/assets/img/integrate/service-catalog/create-api-from-service.png" alt="create api dialog box"></a>

2.  Provide the API name, context, and version (mandatory details), and click **Create API**. 

    The new API is now listed the **APIs** tab:

    <a href="{{base_path}}/assets/img/integrate/service-catalog/new-api-list.png"><img src="{{base_path}}/assets/img/integrate/service-catalog/new-api-list.png" alt="apis list"></a>

    The API is now created.

3.  Click the API to update configurations and to manage the API.

    <a href="{{base_path}}/assets/img/integrate/service-catalog/new-api-view.png"><img src="{{base_path}}/assets/img/integrate/service-catalog/new-api-view.png" alt="apis list"></a>

Once you complete configuring the API, [Publish the API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api/).

!!! More

        Click the following topics to learn more on the concepts that you need to know when creating an API:
       -   [API Visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/)
       -   [Endpoints]({{base_path}}/design/endpoints/endpoint-types/)
       -   [Throttling Tiers]({{base_path}}/design/rate-limiting/introducing-throttling-use-cases/)
       -   [Custom Properties]({{base_path}}/design/create-api/adding-custom-properties-to-apis/)
       -   [API Security]({{base_path}}/design/api-security/api-authentication/secure-apis-using-oauth2-tokens)
       -   [Life Cycle Management]({{base_path}}/design/lifecycle-management/api-lifecycle/)
       -   [API Documentation]({{base_path}}/design/api-documentation/add-api-documentation/)
       -   [API Monetization]({{base_path}}/design/api-monetization/monetizing-an-api/)

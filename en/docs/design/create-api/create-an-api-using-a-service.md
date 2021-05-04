# Create an API Using a Service

The service catalog in WSO2 API Manager contains services that correspond to either the Micro Integrator or the Streaming Integrator. The Micro Integrator services correspond to the REST API backend services, and the Streaming Integrator services correspond to the Streaming API (i.e., WebSocket, WebHook/WebSub or SSE) backend services that are managed by the respective integration layer (Micro Integrator or Streaming Integrator).

Therefore, you can use the respective services to either create REST APIs or Streaming APIs to expose integration services or streaming integration services as managed APIs.

## Step 1 - Create and publish your service to the service catalog

Create and publish your integration service or streaming integration service to the **Service Catalog** of the WSO2 API-M layer via the integration layer.

More information:

- For information on creating and publishing a REST API based on an integration service, see [Exposing an Integration Service as a Managed API]({{base_path}}/integrate/develop/working-with-service-catalog).

- For information on creating and publishing a Streaming API based on a streaming integration service, see [Exposing a Stream as a Managed API]({{base_path}}/use-cases/streaming-usecase/exposing-stream-as-managed-api-in-service-catalog/).

## Step 2 - Discover the services

Follow the instructions below to discover the integration services:

1.  {!includes/sign-in-publisher.md!}

2.  Click on the **Hamburger** in the upper left corner of the Publisher and click **Service Catalog** as shown below.

    <a href="{{base_path}}/assets/img/integrate/service-catalog/select-service-catalog.png"><img src="{{base_path}}/assets/img/integrate/tutorials/service-catalog/select-service-catalog.png" alt="open service catalog" width="200"></a>

    The available integration services appear.

    <a href="{{base_path}}/assets/img/common/service-catalog/services-catalog-list.png"><img src="{{base_path}}/assets/img/common/service-catalog/services-catalog-list.png" width="50%" alt="service catalog listings"></a>

## Step 3 - Optionally, view the details of the service

1. Click on the service that is in the service catalog to view the service details. 

     You can view the service name, version, description, usages in APIs, and other important metadata.

     <a href="{{base_path}}/assets/img/common/service-catalog/service-overview.png"><img src="{{base_path}}/assets/img/common/service-catalog/service-overview.png" width="80%" alt="service overview"></a>

2. Optionally, **download a service definition**.

     If required, click **Download** to download the service definition.

3. Optionally, **view the service definition**.

     If you want to see the service definition before creating an API, click **View Definition**.

     <a href="{{base_path}}/assets/img/common/service-catalog/view-api-definition.png"><img src="{{base_path}}/assets/img/common/service-catalog/view-api-definition.png" alt="view api definition"></a>

## Step 4 - Create an API from the service

1.  Click on the service that is in the service catalog.

2.  Click **Create API**.

     This opens the **Create API** dialog box with the API details that are generated based on the service.

    <a href="{{base_path}}/assets/img/common/service-catalog/create-api-from-service.png"><img src="{{base_path}}/assets/img/common/service-catalog/create-api-from-service.png" alt="create api dialog box"></a>

3.  Update the API name, context, and version if required, and click **Create API**. 

    The overview page of the API that you just created appears. 

    <a href="{{base_path}}/assets/img/common/service-catalog/new-api-view.png"><img src="{{base_path}}/assets/img/common/service-catalog/new-api-view.png" alt="apis list"></a>

4.  Update the portal configurations and API configurations as required.

     Now, you have successfully created an API using a service.

After you complete configuring the API, [Publish the API]({{base_path}}/deploy-and-publish/publish-on-dev-portal/publish-an-api/).

## See Also

Learn more on the concepts that you need to know when creating an API:

 - [Endpoints]({{base_path}}/design/endpoints/endpoint-types/)
 -   [API Security]({{base_path}}/design/api-security/api-authentication/secure-apis-using-oauth2-tokens/)
 -   Rate Limiting:
     -   [Rate Limiting for REST APIs]({{base_path}}/design/rate-limiting/introducing-throttling-use-cases/)
     -   [Rate Limiting for Streaming APIs]({{base_path}}/design/rate-limiting/rate-limiting-for-streaming-apis/)
 -   [Life Cycle Management]({{base_path}}/design/lifecycle-management/api-lifecycle/)
 -   [API Monetization]({{base_path}}/design/api-monetization/monetizing-an-api/)
 -   [API Visibility]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/)
 -   [API Documentation]({{base_path}}/design/api-documentation/add-api-documentation/)
 -   [Custom Properties]({{base_path}}/design/create-api/adding-custom-properties-to-apis/)

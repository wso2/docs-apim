# Publish an API to Developer Portal

This guide provides step-by-step instructions for publishing APIs, AI APIs, MCP Servers, and API Products to the WSO2 API Manager Developer Portal, making them available for application developers to discover, subscribe, and consume.

!!! info
    You can publish the following to the Developer Portal:

      - **APIs**: REST, SOAP, SSE, WebSocket, WebSub, GraphQL 
      - **AI APIs** 
      - **MCP Servers**
      - **API Products**

## Overview

**API Publishing** is the process of making an API visible and available for subscription in the Developer Portal. When an API is published:

- The lifecycle state changes from **CREATED** to **PUBLISHED** (see [API Lifecycle]({{base_path}}/api-design-manage/design/lifecycle-management/api-lifecycle/))
- API metadata becomes visible in the Developer Portal
- Application developers can discover and subscribe to the API
- The API becomes available for consumption through applications

---

## Prerequisites

Before publishing, ensure the following requirements are met:

1. **Endpoint Configuration**: Valid [endpoint URL]({{base_path}}/api-design-manage/design/endpoints/endpoint-types/) configured (for APIs and AI APIs)
2. **Business Plans**: At least one [business plan]({{base_path}}/api-design-manage/design/rate-limiting/assign-business-plans/) (subscription tier) selected
3. **Created State**: The API, AI API, MCP Server, or API Product must be created and in CREATED state

!!! tip
    You can check if these requirements are met in the Lifecycle page of the Publisher Portal.

---
## Publishing an to Developer Portal

### Step 1: Sign in to the Publisher Portal

1. Navigate to the Publisher Portal:
   ```
   https://<hostname>:9443/publisher
   ```
   Example: `https://localhost:9443/publisher`

2. Sign in with your credentials.

### Step 2: Select the API or AI API or API Product or MCP Server to Publish

1. Click on an API or AI API or API Product or MCP Server that is in the **CREATED** state

   <img src="{{base_path}}/assets/img/learn/select-created-api.png" alt="Select API" title="Select API" width="35%" />

!!! note "Enhanced API Visibility"
    You can enhance the API tile display in developer portal by configuring the following settings in:
        
    `<APIM_HOME>/repository/deployment/server/webapps/devportal/site/public/theme/settings.json`
    
    ```json
    "tileDisplayInfo": {
        "showMonetizedState": true,
        "showBusinessDetails": true,
        "showTechnicalDetails": true
    }
    ```
    
    This displays:

    - Monetization status
    - Business owner information (with email on hover)
    - Technical owner information (with email on hover)
    
    <img src="{{base_path}}/assets/img/learn/select-created-api-with-monetization.png" alt="API with Business Info" title="Select API" width="35%" />

### Step 3: Navigate to Lifecycle

1. Click on the **Lifecycle** tab in the left menu

      ![Lifecycle Tab]({{base_path}}/assets/img/learn/default-lifecycle.png)


2. The lifecycle state transition grid appears. Check for any missing requirements:
      - Endpoint provided
      - Business Plan(s) selected

      ![Publish Requirements]({{base_path}}/assets/img/learn/publish-api-requirements.png)

!!! warning
    If requirements are not satisfied, navigate to the relevant sections (Endpoints, Subscriptions) to provide the missing information.

### Step 4: Publish the API

1. Click the **PUBLISH** button

      ![Publish API]({{base_path}}/assets/img/learn/publish-api.png)

2. Upon successful publication, the lifecycle state changes to **PUBLISHED**

      ![Published State]({{base_path}}/assets/img/learn/api-state-change-to-publish.png)

### Step 5: Verify in Developer Portal

1. Navigate to the Developer Portal:
   ```
   https://<hostname>:9443/devportal
   ```
   Example: `https://localhost:9443/devportal`

2. Verify that your published API is visible under the **APIs** listing

!!! success
    Your API is now published and available for developers to discover and subscribe!

---

## Publishing Third-party APIs

WSO2 API Manager supports publishing APIs that are deployed on external gateways. These APIs are listed in the Developer Portal for discovery but are not proxied through WSO2 Gateway.

For detailed instructions on adding and configuring third-party APIs, see [Add a Third-party API]({{base_path}}/api-design-manage/deploy-and-publish/publish-on-dev-portal/third-party-api-support/).

---

## Best Practices

### Before Publishing

1. **Complete API Documentation**: Add comprehensive documentation before publishing - See [Add API Documentation]({{base_path}}/api-design-manage/design/api-documentation/add-api-documentation/)
2. **Configure Appropriate Business Plans**: Select business plans that match your API's target audience - See [Assign Business Plans]({{base_path}}/api-design-manage/design/rate-limiting/assign-business-plans/)
3. **Set Correct Visibility**: Configure API visibility (Public, Restricted, Private) - See [Control API Visibility and Subscription Availability]({{base_path}}/api-design-manage/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal/)
4. **Add Business Information**: Include business owner and technical owner details
5. **Test Endpoints**: Verify all endpoints are reachable and working

### During Publishing

1. **Monitor Lifecycle State**: Ensure the state transition completes successfully

### After Publishing

1. **Verify in Developer Portal**: Always check the API appears correctly
2. **Test Subscription Flow**: Create a test application and subscribe
3. **Monitor Analytics**: Keep track of API usage and subscriber growth
4. **Update Documentation**: Keep documentation current with API changes

---

Following these steps ensures your APIs, AI APIs, MCP Servers, and API Products are properly published and discoverable in the Developer Portal, enabling application developers to easily find, subscribe to, and consume them.

## See Also

- [Consume APIs Overview]({{base_path}}/api-developer-portal/consume-api-overview/) - Learn how application developers can discover and consume published APIs.
- [Discover APIs]({{base_path}}/api-developer-portal/discover-apis/search/) - Explore how to search and find APIs in the Developer Portal.
- [Subscribe to an API]({{base_path}}/api-developer-portal/manage-subscription/subscribe-to-an-api/) - Subscribe to published APIs from an application.
- [Create Application]({{base_path}}/api-developer-portal/manage-application/create-application/) - Create applications to consume APIs.

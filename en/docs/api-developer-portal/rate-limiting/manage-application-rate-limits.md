# Manage Application Rate Limits

As an application developer, you can view and modify your application's rate limiting configuration, manage API subscriptions, and reset individual user quotas when needed. This guide shows you how to perform these management tasks in the Developer Portal.

## Creating an Application with Rate Limiting

When you create a new application, you must select a rate limiting tier that defines the total number of requests your application can make across all subscribed APIs.

### Create a New Application

To create an application with rate limiting:

1. Sign in to the Developer Portal
2. Navigate to **Applications**
3. Click **Add New Application**
4. Enter the following details:
   - **Application Name**: A unique name for your application
   - **Per Token Quota**: Select a rate limiting tier from the dropdown (e.g., 10PerMin, 20PerMin, 50PerMin, or Unlimited)
   - **Description**: (Optional) Add a description for your application
5. Click **Save** to create the application

[![Application create policy]({{base_path}}/assets/img/learn/application-create-policy.png){: style="width:65%"}]({{base_path}}/assets/img/learn/application-create-policy.png)

!!! tip
    The available rate limiting tiers are configured by your API administrator. If you need a custom tier with specific limits, contact your administrator before creating the application.

## Viewing and Modifying Application Tiers

Your application's rate limiting tier controls the total number of requests your application can make across all subscribed APIs.

### View Your Current Application Tier

To view your application's current rate limiting tier:

1. Sign in to the Developer Portal
2. Navigate to **Applications**
3. Select your application
4. View the current tier on the application overview page

### Modify Your Application Tier

You can modify your application's tier by editing the application settings in the Developer Portal. However, the available tiers are determined by your API administrator.

To upgrade your application tier or request custom limits, contact your API administrator. They can:

- Create custom tiers with specific request limits or bandwidth restrictions
- Adjust tier limits to match your application's needs
- Configure burst control policies to manage traffic spikes

!!! note
    When you change your application tier, you may need to regenerate your access tokens for the changes to take effect across all your subscribed APIs.

## Managing Subscriptions

Each API subscription operates under a subscription-level rate limiting tier that controls how many requests your application can make to that specific API.

### View Available Subscription Tiers

To view subscription limits for a specific API:

1. Navigate to the API in the Developer Portal
2. Go to the API's details page
3. Check the **Subscriptions** section for available tiers
4. Review the request limits for each tier (e.g., Bronze: 1000 req/min, Silver: 2000 req/min, Gold: 5000 req/min)

### Subscribe to an API

When subscribing to an API, select the tier that matches your needs:

1. Navigate to the API in the Developer Portal
2. Click **Subscribe**
3. Select your application from the dropdown
4. Choose the appropriate subscription tier based on your expected usage
5. Complete the subscription

[![Subscribe application tier]({{base_path}}/assets/img/learn/subscribe-application-tier.png)]({{base_path}}/assets/img/learn/subscribe-application-tier.png)

!!! tip
    Some APIs may offer custom subscription tiers with specialized configurations for different API types:
    - **GraphQL APIs**: Complexity and depth limits
    - **Streaming APIs**: Event count limits
    - **AI APIs**: Token-based limits
    
    Check the API documentation for details on how these limits are calculated.

### Change Subscription Tiers

If your usage requirements change, you can upgrade or downgrade your subscription tier:

1. Navigate to **Applications** in the Developer Portal
2. Select your application
3. Find the API subscription you want to modify
4. Update the subscription tier

!!! warning
    After modifying a subscription, regenerate your access tokens to ensure the new tier takes effect.

## See Also

- [Rate Limiting for App Developers]({{base_path}}/api-developer-portal/rate-limiting/rate-limiting-for-app-developers/) - Understand how rate limiting works
- [Handle Rate Limiting Errors]({{base_path}}/api-developer-portal/rate-limiting/handle-rate-limiting-errors/) - Implement error handling strategies
- [Reset Application Throttling Policies]({{base_path}}/api-developer-portal/rate-limiting/resetting-application-throttling-policies/) - Reset individual user quotas

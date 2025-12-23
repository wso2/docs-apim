# Rate Limiting for App Developers

Rate limiting controls how many requests your application can make to APIs within a specific time period. This protects backend services from overload and ensures fair resource distribution among all API consumers.

As an application developer, you encounter rate limiting at two levels: application-level and subscription-level. Understanding how these limits work together helps you build reliable applications that handle API quotas effectively.

## Application-Level Rate Limiting

Application-level rate limiting applies to all API calls made by your application, regardless of which specific API you're calling. When you create an application in the Developer Portal, you select a rate limiting tier that defines your application's total request capacity.

!!! tip
    Application level throttle policies are defined by Administrators in the Admin Portal. For information on creating custom application plans, see [Adding a new application-level Rate Limiting tier]({{base_path}}/administer/rate-limiting/manage-application-policies/).


### How Application-Level Limits Work

An application is a logical collection of one or more APIs. When you create an application in the Developer Portal, you select a rate limiting tier (e.g., 10PerMin, 50PerMin) that defines the maximum total requests your application can make across all subscribed APIs within a given time period.

For example, if your application has a **20PerMin** tier and subscribes to three APIs, your application can make a combined total of 20 requests per minute across those three APIs—not 20 requests per API.

For step-by-step instructions on creating an application, see [Creating an Application with Rate Limiting]({{base_path}}/api-developer-portal/rate-limiting/manage-application-rate-limits/#creating-an-application-with-rate-limiting).

### Default Application Tiers

The default rate limiting tiers are as follows:

| **Tier** | **Limit** |
|----------|-----------|
| 10PerMin | 10 requests per minute |
| 20PerMin | 20 requests per minute |
| 50PerMin | 50 requests per minute |
| Unlimited | No limit (available by default) |

!!! note
    The **Default Application**, which is provided out of the box, has the tier set to Unlimited. Custom tiers with different limits or bandwidth-based restrictions may also be available depending on your administrator's configuration.
    
### Per Token Quota

Application-level limits are enforced per access token. When your application serves multiple users with different access tokens, each token has its own quota based on the application tier. This ensures fair distribution of the quota among all users of your application.

For example, if your application has a **20PerMin** tier and serves 10 users (each with their own token), each user can make 20 requests per minute. The counters maintained when evaluating per token quotas are shared across all nodes in the Gateway cluster.

!!! tip
    Applications allow you to use a single access token to invoke a collection of APIs and to subscribe to one API multiple times with different service levels.

### Burst Control

Application-level tiers can include burst control to protect against sudden traffic spikes. Burst control defines tiers with a combination of criteria, for example, 1000 requests per day and 10 requests per second. This throttles users at two layers.

For instance, if an application-level policy allows 20 requests per minute, a user could potentially send all 20 requests in the first few seconds. By defining a burst control policy of 10 requests per second, the requests are distributed evenly across the minute, protecting the backend from sudden spikes and denial-of-service (DoS) attacks.

!!! note
    By default, burst control limits are enforced locally on each Gateway node. For clustered deployments where you need consistent enforcement across all nodes, administrators can configure distributed counters using Redis.

## Subscription-Level Rate Limiting

Subscription-level limits apply when your application subscribes to a specific API. The API publisher defines which subscription tiers are available (e.g., Bronze, Silver, Gold), and you choose one when subscribing.

### How Subscription-Level Limits Work

Each subscription tier specifies how many requests your application can make to that particular API. The limit applies to all users of your application accessing that API combined—it's a shared quota among all users.

For example, if you subscribe to an API using the **Bronze** tier (1000 requests per minute), all users of your application share that 1000 request quota for that API.

For step-by-step instructions on subscribing to APIs with business plans, see [Subscribe to an API]({{base_path}}/api-developer-portal/rate-limiting/manage-application-rate-limits/#subscribe-to-an-api).

### Default Subscription Tiers

The default subscription tiers are as follows:

| **Tier** | **Limit** |
|----------|-----------|
| Bronze | 1000 requests per minute |
| Silver | 2000 requests per minute |
| Gold | 5000 requests per minute |
| Unlimited | No limit |

!!! tip
    Some APIs may offer custom subscription tiers with different limits or specialized configurations (like GraphQL complexity limits or streaming event counts). Check the API's subscription page for available options.

## How Rate Limits Work Together

When your application makes an API call, multiple limits may apply simultaneously. The most restrictive limit determines whether the request succeeds. Rate limits are evaluated in the following order:

1. **Application-level limit** - Total requests across all APIs for your application
2. **Subscription-level limit** - Requests to the specific API
3. **API-level advanced limits** (if configured by publisher) - Additional restrictions based on IP addresses, headers, JWT claims, or query parameters
4. **Backend throughput limits** (if configured by publisher) - Maximum load the backend can handle

### Example Scenario

Consider the following configuration:

- Your application has a **20PerMin** tier (application-level)
- You subscribe to API-A with **Bronze** tier (1000 requests per minute)
- You subscribe to API-B with **Silver** tier (2000 requests per minute)

Even though API-A allows 1000 requests per minute and API-B allows 2000 requests per minute, your application can only make 20 requests total per minute across both APIs due to the application-level limit of 20PerMin.

!!! warning
    Rate limits are calculated using real-time clock intervals. For example, with a 10 requests per minute limit, if you make your first request at the 30th second, you can make 10 requests until the end of that minute. When the next minute starts, the limit resets, potentially allowing 20 requests within a 60-second window from a user's perspective.

### Advanced Rate Limiting

API publishers can configure advanced rate limiting policies that filter requests based on specific conditions. These policies may include:

- **IP address and address range**: Different limits for internal vs external consumers
- **HTTP request headers**: Special limits based on content type or other headers
- **JWT claims**: Different limits based on user roles or other claim values
- **Query parameters**: Different limits for different search categories or parameters

As an application developer, you should be aware that these additional restrictions may apply to your API requests, even if you haven't exceeded your application or subscription limits.

## What Happens When Limits Are Exceeded

When your application exceeds a rate limit, the API Gateway rejects the request with an HTTP **429 Too Many Requests** response. The response includes details about which limit was exceeded.

For information on throttled responses, see [Handle Rate Limiting Errors]({{base_path}}/api-developer-portal/rate-limiting/handle-rate-limiting-errors/).

## Additional Considerations

### Per Token Quota

Application-level limits are enforced per access token. Each user with their own token gets the full application quota, ensuring fair access. Subscription-level limits are shared across all users of your application accessing that specific API.

### Rate Limiting Precision

The rate limiting solution in API Manager is designed in a fully asynchronous and distributed manner. While this architecture enhances scalability and responsiveness, it may lead to some degree of variation beyond the defined throttle limits. Absolute precision cannot always be guaranteed due to factors such as network latency and the complexities of asynchronous processing.

## See Also

- **Manage your rate limits**: Learn how to view, modify, and optimize your application's rate limiting configuration. See [Manage Application Rate Limits]({{base_path}}/api-developer-portal/rate-limiting/manage-application-rate-limits/).
- **Handle errors gracefully**: Implement robust error handling for rate limit responses. See [Handle Rate Limiting Errors]({{base_path}}/api-developer-portal/rate-limiting/handle-rate-limiting-errors/).
- **Reset user quotas**: Learn how to reset individual user quotas when needed. See [Reset Application Throttling Policies]({{base_path}}/api-developer-portal/rate-limiting/resetting-application-throttling-policies/).

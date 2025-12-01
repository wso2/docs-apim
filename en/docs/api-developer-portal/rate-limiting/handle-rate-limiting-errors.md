# Handle Rate Limiting Errors

When your application exceeds rate limits, the API Gateway returns HTTP 429 (Too Many Requests) responses. Understanding how to detect, handle, and recover from rate limiting helps you build resilient applications.

## Recognizing Rate Limiting Responses

When a request is throttled, you receive an HTTP **429 Too Many Requests** status code with a response body containing details about why the request was blocked.

**Example throttled response:**

```json
{
    "code": "900800",
    "message": "Message throttled out",
    "description": "You have exceeded your quota"
}
```

The response typically indicates which limit was exceeded:

- **Application-level limit** - Your application has reached its total request quota across all APIs
- **Subscription-level limit** - Your application has reached its quota for a specific API
- **Backend throughput limit** - The API's backend service capacity has been reached

## Implementing Retry Logic

Your application should implement intelligent retry strategies when encountering 429 responses:

### Exponential Backoff

Implement a retry mechanism that waits progressively longer between attempts. Start with a short delay (e.g., 1 second) and double it after each failed retry, adding some randomness to prevent synchronized retries from multiple clients. Set a maximum number of retry attempts (typically 3-5) to avoid infinite loops.

### Check Retry-After Header

When you receive a 429 response, check for a `Retry-After` header that indicates when you can retry. If present, wait for the specified duration before making another request. If the header is absent, use a default wait time (e.g., 60 seconds) before retrying.

## Rate Limiting Best Practices

### 1. Distribute Requests Over Time

Avoid sending burst traffic at the start of each time window. Instead of exhausting your quota in the first few seconds, distribute requests evenly throughout the time period. For example, if you have 1000 requests per minute, aim for approximately 16-17 requests per second rather than sending all 1000 in the first 10 seconds.

### 2. Implement Client-Side Rate Limiting

Track your request rate locally before requests reach the API Gateway. Maintain a counter of recent requests within your time window and check against your quota before making new requests. This prevents wasted requests that would be rejected anyway and reduces unnecessary network traffic.

### 3. Cache API Responses

Reduce API calls by caching responses that don't change frequently. Store API responses with timestamps and serve cached data for subsequent requests within a defined time period (e.g., 5 minutes). This is particularly effective for data that updates infrequently, such as configuration data, reference lists, or user profiles.

### 4. Monitor Your Usage

Track API usage patterns to identify optimization opportunities. Log successful requests, throttled requests, and errors separately. Calculate your throttle rate (throttled requests / total requests) to understand how close you are to your limits. Set up alerts when throttle rates exceed acceptable thresholds (e.g., more than 5% of requests throttled).

## Testing Rate Limiting Behavior

Before deploying to production, test your application's rate limiting behavior:

### 1. Create a Test Application

Set up a test environment with controlled limits:

1. Sign in to the Developer Portal
2. Create a new application with a low tier (e.g., **10PerMin**)
3. Subscribe to your target API with a low subscription tier (e.g., **Bronze**)
4. Generate access tokens for testing

### 2. Trigger Rate Limiting

Intentionally exceed the limits to verify throttling works as expected. Make rapid successive requests (e.g., 100 requests in quick succession) and confirm that you receive 429 responses after exhausting your quota. Track both successful and throttled requests to understand the threshold.

### 3. Verify Recovery

Test that your application recovers properly after the time window resets. Exhaust your quota to trigger throttling, confirm you receive 429 responses, then wait for the time window to reset (e.g., 60 seconds for per-minute limits). Verify that requests succeed again after the reset.

## Common Rate Limiting Scenarios

### Scenario 1: Application Tier Too Restrictive

**Problem:** Your application has a 10PerMin tier, but you need to call multiple APIs frequently.

**Solution:** 
1. Contact your administrator to upgrade your application tier to 50PerMin or higher
2. Optimize your code to reduce API calls (implement caching, batch requests)
3. Consider using multiple applications for different use cases

### Scenario 2: Subscription Tier Insufficient

**Problem:** Your API subscription uses Bronze (1000 req/min), but you need higher throughput.

**Solution:**
1. Check if higher subscription tiers (Silver, Gold) are available for the API
2. Subscribe using a higher tier if available
3. Contact the API publisher to request custom tier options

### Scenario 3: Shared Quota Exhaustion

**Problem:** Multiple users of your application exhaust the subscription quota quickly.

**Solution:**
1. Implement user-level throttling in your application layer
2. Distribute load across multiple subscriptions (different application instances)
3. Optimize heavy API consumers' usage patterns

## Next Steps

- Learn about rate limiting tiers: [Rate Limiting for App Developers]({{base_path}}/api-developer-portal/rate-limiting/rate-limiting-for-app-developers/)
- Reset user quotas in your application: [Reset Application Throttling Policies]({{base_path}}/api-developer-portal/rate-limiting/resetting-application-throttling-policies/)
- Review your application's current tier: [Manage Applications]({{base_path}}/api-developer-portal/manage-application/create-application/)
- Monitor API usage in the Developer Portal analytics dashboard


# Understand Rate Limit Enforcement

The API Gateway enforces rate limiting policies in real-time as API requests flow through it. Rate limiting protects your APIs from security attacks such as denial of service (DoS), regulates traffic according to infrastructure availability, and enables different service levels for API monetization.

Understanding how the Gateway evaluates and applies multiple rate limiting policies, and how it communicates with the Traffic Manager, helps you configure effective protection for your APIs and backend services.

## Rate Limiting Architecture

The API Gateway works in conjunction with the Traffic Manager to enforce rate limiting policies. This distributed architecture enables scalable, real-time throttling across Gateway clusters.

### Components

**API Gateway**

The Gateway is the entry point for all API requests. It validates tokens, applies security policies, enforces rate limits, and routes requests to backend services.

**Traffic Manager**

The Traffic Manager is a specialized component that processes throttling policies in real-time using a dynamic throttling engine. It maintains centralized request counters for:

- Subscription-level throttling
- Application-level throttling  
- Resource-level and API-level throttling
- Custom throttling policies

The Traffic Manager aggregates request counts from all Gateway nodes and makes throttling decisions based on configured policies. When a limit is exceeded, it publishes throttle events back to the Gateway nodes.

### Communication Flow

1. **Initialization**: When a Gateway node starts, it subscribes to the Traffic Manager's JMS topic to receive throttle events.

2. **Request Processing**: When the Gateway receives an API request:

    - It first checks if the request matches any active throttle condition (based on the evaluation hierarchy)
    - If the request is already throttled, the Gateway immediately rejects it with HTTP 429
    - If not throttled, the Gateway allows the request to proceed and asynchronously publishes the request event to the Traffic Manager
    - The Traffic Manager updates its counters and evaluates limits
    - If a limit is exceeded, the Traffic Manager publishes a throttle event back to the Gateway

3. **Throttle Enforcement**: Gateway nodes receive throttle events via JMS and cache the throttled conditions. Subsequent requests matching these conditions are immediately blocked without contacting the Traffic Manager.

This asynchronous, distributed design provides high scalability and performance, though it may result in minor slippage beyond configured limits during traffic bursts due to network latency and replication delays.

## How the Gateway Evaluates Rate Limits

When a request arrives at the API Gateway, multiple rate limiting policies may apply simultaneously. The Gateway evaluates these policies in a specific order and enforces the most restrictive limit.

### Policy Types

Rate limiting policies are defined at different levels to address various use cases:

#### Subscription-Level Throttling

Controls the rate at which an application can access a specific API through a subscription. Publishers define subscription tiers (Bronze, Silver, Gold, etc.) with different limits, enabling API monetization. The quota is shared among all users of the application accessing that API. 

When an API request comes to the Gateway, it sends data to the Traffic Manager, which evaluates throttle policies through its Siddhi runtime and takes throttle decisions based on the policy conditions.

- Default tiers: Bronze (1000 req/min), Silver (2000 req/min), Gold (5000 req/min), Unlimited

#### Subscription-Level Burst Control

Prevents applications from consuming their entire subscription quota in a short time span. For example, if a subscription allows 1000 requests per hour, burst control can limit it to 25 requests per minute to distribute load evenly. Burst control only applies to request counts, not bandwidth. Counters are maintained locally on each Gateway node (or in Redis for distributed enforcement).

#### Application-Level Throttling

Limits the total number of requests an application can make across all its API subscriptions. This prevents a single application from overwhelming the system. The quota applies per access token, ensuring fair distribution among users.

When an API request comes to the Gateway, it sends data to the Traffic Manager, which evaluates throttle policies through its Siddhi runtime and takes throttle decisions based on the policy conditions.

-  Default tiers : 10PerMin, 20PerMin, 50PerMin, Unlimited

#### Application-Level Burst Control

Similar to subscription burst control, but applies across all APIs that the application accesses. Helps prevent sudden spikes in application usage from affecting backend systems. Counters are maintained locally on each Gateway node (or in Redis for distributed enforcement).

#### Resource-Level and API-Level Throttling (Advanced Policies)

Publishers can apply throttling at either the resource level (per operation) or the API level (entire API), but not both simultaneously. Advanced policies support conditional throttling based on:

- **IP address and range**: Grant different limits to internal vs external consumers
- **HTTP headers**: Apply special limits for specific content types or custom headers
- **JWT claims**: Filter by user roles, organizations, or custom claims in backend JWT
- **Query parameters**: Different limits for different categories in search APIs

When an API request comes to the Gateway, it sends data to the Traffic Manager, which evaluates throttle policies through its Siddhi runtime and takes throttle decisions based on the policy conditions.

-   Default tiers : 10KPerMin, 20KPerMin, 50KPerMin, Unlimited

#### Custom Policies

Dynamic rules defined using Siddhi queries that evaluate complex conditions across multiple request attributes. Enables sophisticated throttling scenarios beyond standard policies.

When an API request comes to the Gateway, it sends data to the Traffic Manager, which evaluates these custom throttle policies through its Siddhi runtime and takes throttle decisions based on the policy conditions.

#### Backend Throughput Limits

Protects backend services from being overwhelmed regardless of subscription quotas. Acts as a hard limit on total requests to the backend per unit time, applied across all applications and users. This ensures backend capacity is never exceeded even if individual quotas allow more traffic. Counters are maintained locally on each Gateway node (or in Redis for distributed enforcement).

#### Deny Policies

Explicit rules that block requests matching specific conditions (e.g., blacklisted IP addresses). These are evaluated first and immediately reject matching requests without checking other policies.

### Evaluation Hierarchy

The Gateway checks rate limits in the following order:

1. **Deny policies** - Conditions that explicitly block requests (e.g., deny specific IP addresses)
2. **Resource-level throttling OR API-level throttling** - Limits applied to specific operations or the entire API
3. **Subscription-level throttling** - Quota for the specific API subscription
4. **Subscription-level burst control** - Short-term spike protection for the subscription
5. **Application-level throttling** - Total quota across all APIs for the application
6. **Application-level burst control** - Short-term spike protection for the application
7. **Custom policies** - Dynamic rules defined using Siddhi queries
8. **Backend throughput limits** - Maximum capacity of the backend service

!!! note
    When an API is configured in the Publisher Portal, you choose to apply throttling at either the **resource level** (per operation) or the **API level** (for the entire API). The Gateway evaluates only the configured level, not both.

    If advanced rate limiting policies (resource-level or API-level) are configured for a specific API or API resource, they will be evaluated early in the hierarchy. Requests will be allowed or rejected based on the conditions specified in these advanced rate limiting policies as well.

If any limit in this hierarchy is exceeded, the Gateway immediately rejects the request with an HTTP 429 (Too Many Requests) response, without evaluating subsequent policies.

The following diagram shows how throttle policies are applied at different levels:

[![rate limiting levels]({{base_path}}/assets/img/learn/throttling-levels.png)]({{base_path}}/assets/img/learn/throttling-levels.png)

## Distributed Counter Behavior in Clusters

In a clustered Gateway deployment, counter management varies by policy type:

**Traffic Manager Counters** (Subscription, Application, Resource/API, Custom Policies)

All Gateway nodes publish request events to the Traffic Manager via JMS. The Traffic Manager maintains aggregated counters across the cluster and publishes throttle events to all nodes via JMS topic. This ensures consistent enforcement across the Gateway cluster.

**Local Gateway Counters** (Burst Control, Backend Throughput)

By default, each Gateway node maintains its own local counters. This means the effective limit is multiplied by the number of nodes (e.g., 10 req/sec on 3 nodes = up to 30 req/sec cluster-wide).

**Distributed Counters with Redis** (Burst Control, Backend Throughput)

For precise cluster-wide enforcement, configure Redis as a distributed counter store. All Gateway nodes share counters via Redis, eliminating the per-node multiplication effect.

- **Throttling policies**: Continue to use Traffic Manager (unchanged)
- **Burst control and backend throughput**: Use Redis for cluster-wide accuracy

For configuration details, see [Connect to Redis/Valkey]({{base_path}}/api-gateway/rate-limiting/configuring-rate-limiting-api-gateway-cluster/).

## Enforcement Accuracy

### Clock-Based Windows

Rate limits use real-time clock intervals rather than sliding windows. For example, with a "10 requests per minute" limit:

- If the first request arrives at second 30 of a minute, 10 requests can be made until second 60
- At second 00 of the next minute, the counter resets, allowing 10 more requests
- From a user's perspective, up to 20 requests could be made within a 60-second span

### Distributed Counter Slippage

The throttling solution in API Manager is designed in a fully asynchronous and distributed manner. While this architecture enhances scalability and responsiveness, it may lead to some degree of slippage beyond the defined throttle limits. Therefore, absolute precision cannot always be guaranteed due to factors such as network latency and the complexities of asynchronous processing.

## GraphQL and Streaming APIs

GraphQL and Streaming APIs have specialized enforcement mechanisms due to their unique characteristics:

- **GraphQL APIs**: GraphQL APIs use complexity-based and depth-based limiting in addition to request-based rate limiting and burst control. The maximum values for complexity and depth can be enforced through the subscription policy. See [GraphQL Query Complexity Limit]({{base_path}}/api-design-manage/design/rate-limiting/graphql-api/query-complexity-analysis/) and [GraphQL Query Depth Limit]({{base_path}}/api-design-manage/design/rate-limiting/graphql-api/query-depth-analysis/) for details.

- **Streaming APIs**: Business plans for Streaming APIs count events/frames rather than HTTP requests, and limit number of active long-lived connections. See [Streaming API Enforcement]({{base_path}}/api-design-manage/design/rate-limiting/rate-limiting-for-streaming-apis/) for details.

## Monitoring and Troubleshooting

### Identifying Which Limit Was Exceeded

When a request is throttled, the 429 response includes details about which policy caused the rejection:

```json
{
    "code": "900800",
    "message": "Message throttled out",
    "description": "You have exceeded your quota"
}
```

Check the Gateway logs for more detailed information about which specific limit was triggered.

## See Also

- [Configuring Distributed Throttling]({{base_path}}/api-gateway/rate-limiting/distributed-throttling/) - To maintain traffic counts at a global level
- [Connecting to Redis/Valkey]({{base_path}}/api-gateway/rate-limiting/configuring-rate-limiting-api-gateway-cluster/) - Configure Distributed Burst Control, Backend Rate Limiting for an API Gateway Cluster
- [Custom Throttling]({{base_path}}/api-gateway/rate-limiting/enforce-custom-throttling/) - To implement custom rate limiting logic

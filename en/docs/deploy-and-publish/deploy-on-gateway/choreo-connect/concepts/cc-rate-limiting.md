# Rate Limiting

Rate limiting allows users to limit the number of incoming requests to Choreo Connect. Choreo Connect connects
with API Manager's Traffic Manager component in order to publish and receive Rate Limiting data, which is referred to as Global Rate Limiting.

You can use the [distributed rate limiting]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/rate-limiting/distributed-throttling) option to globally rate limit requests.

Choreo Connect supports Rate Limiting at the following levels:

- API level
- Resource level
- Subscription level
- Application level throttling

## Distributed rate limiting

In a deployment with multiple Choreo Connect instances, Rate Limiting becomes a challenge with node local Rate Limiting since the Rate Limiting decision is made based on the local counter within each node. If we proceed with the node local Rate Limiting in such environment, the API user would be allowed to send multiples of the Rate Limiting limit. I.e., if the Rate Limiting limit is set to 10, if we have three Gateways in a cluster, it will allow 30 requests to pass to the backend before all three Gateways throttle out requests. This will put an unexpected load on the backend. 

To address this requirement, Choreo Connect supports distributed Rate Limiting where it is able to work with a central traffic management solution. In this case, multiple Choreo Connect instances can connect with WSO2 API Manager ([WSO2 Traffic Manager]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles) and perform rate-limiting precisely. Find information on how to enable distributed rate limiting from [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/rate-limiting/distributed-throttling).

!!! note
    If you start the WSO2 API Manager without providing any profile, it runs as All in One Node (All the profiles are activated). For testing purposes, you can simply start the API Manager following the [quick start guide]({{base_path}}/getting-started/quick-start-guide/) and test.

## Different levels of rate limiting

### Advanced rate limiting (API publisher)

Advanced rate limiting policies are applied when you are Publishing an API. It can be further divided into the following two levels based on the applicability.

- API level rate limiting
- Resource level (operational level) rate limiting

For more information on advanced rate limiting capabilities, see [Advanced rate limiting (API Publisher)]({{base_path}}/design/rate-limiting/setting-throttling-limits/#advanced-rate-limiting-api-publisher).

### Subscription-level rate limiting (API subscriber)

Subscription-level Rate Limiting tiers are set to an API during the API implementation. When a user subscribes to the API through the developer portal, the subscription-level Rate Limiting tiers selected for the API will be listed from which one can be selected.

Based on the selected tier, a subscriber will be throttled out upon reaching the maximum number of requests specified in the tier, see [subscription-level Rate Limiting (API Publisher)]({{base_path}}/design/rate-limiting/setting-throttling-limits/#subscription-level-rate-limiting-api-publisher).

### Application-level rate limiting (application developer)

Application-level Rate Limiting tiers are defined at the time an application is created in the API Developer Portal as shown [here]({{base_path}}/design/rate-limiting/setting-throttling-limits/#application-level-rate-limiting-application-developer). The limits are restricted per token for a specific application.

An application is a logical collection of one or more APIs. An API is subscribed to an application. A single access token generated for an application can be used to invoke all the APIs subscribed to that application.

An application can be used to support environment restrictions. For e.g., if there is an infrastructure limitation to serve a maximum number of requests at a given time, a Rate Limiting tier can be set to an application to avoid the system being overloaded.

For more information on application-level Rate Limiting tiers, see [Application-Level Rate Limiting tiers]({{base_path}}/design/rate-limiting/setting-throttling-limits/#application-level-rate-limiting-application-developer).

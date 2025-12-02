# Set Streaming API Limits

Streaming APIs (WebSocket, WebHook/WebSub, and SSE) require different rate limiting approaches than REST APIs. Instead of limiting requests per minute, you control the number of events clients can consume and how long they can maintain connections.

## Understanding Streaming API Rate Limiting

Streaming APIs support three types of limits through subscription tiers:

- **Event Count Limits** - Restrict the total number of events an application can receive (e.g., 5000 events per day, 1M events, or unlimited).

- **Time-based Limits** - Control how long a client can maintain a subscription (e.g., 1 week, 1 month, or unlimited duration).

- **Hybrid Limits** - Combine both event count and time constraints (e.g., 1M events within 24 hours).

!!! tip
    Subscription tiers with streaming-specific limits are created by Administrators. As a Publisher, you select which tiers to make available for your Streaming API. For creating custom subscription tiers, see [Adding a new subscription-level Rate Limiting tier]({{base_path}}/design/rate-limiting/adding-new-throttling-policies/#adding-a-new-subscription-level-rate-limiting-tier).

## How Events Are Counted

Event counting varies by protocol:

**WebSocket APIs**
: Each WebSocket frame (in either direction) counts as one event. The total includes both client-to-server and server-to-client frames. For example, if a tier allows 10,000 events and your API exchanges 8,000 frames, 2,000 events remain.

**Server-Sent Events (SSE)**
: Each server event (typically delimited by `\n\n`) counts as one event. Only events sent from server to client are counted.

**WebSub/WebHook APIs**
: Two metrics apply:
    - **Active Subscriptions** - Number of concurrent callback registrations per application
    - **Event Count** - Total events delivered to callbacks within the time period

## Assigning Subscription Tiers

To apply rate limiting to your Streaming API:

1. Log in to the API Publisher.
2. Select your Streaming API and navigate to **Portal Configurations** > **Subscriptions**.
3. Select subscription tiers designed for streaming APIs.

Applications subscribing to your API will be limited by the event count, duration, or subscription limits defined in their chosen tier.

[![Streaming API Business Plans]({{base_path}}/assets/img/design/rate-limiting/stream-api-business-plans.png)]({{base_path}}/assets/img/design/rate-limiting/stream-api-business-plans.png)

## Default Streaming Tiers

The following default subscription tiers are available for Streaming APIs:

| **Subscription Tier**                                                     | **API Type** |
|---------------------------------------------------------------------------|----------------|
| AsyncGold : 50,000 events per day                                   | WebSocket, SSE |
| AsyncSilver : 25,000 events per day                                 | WebSocket, SSE |
| AsyncBronze : 5,000 events per day                                  | WebSocket, SSE |
| AsyncUnlimited : Unlimited events                                  | WebSocket, SSE |
| AsyncWHGold : 10,000 events per month + 1,000 active subscriptions | WebHook/WebSub |
| AsyncWHSilver : 5,000 events per month + 500 active subscriptions | WebHook/WebSub |
| AsyncWHBronze : 1,000 events per month + 500 active subscriptions | WebHook/WebSub |

!!! note
    Choose tiers based on your backend's capacity to handle concurrent connections and event throughput. WebSocket and SSE APIs can generate high event volumes with persistent connections, while WebHook APIs typically have lower event rates but require tracking active callback registrations.

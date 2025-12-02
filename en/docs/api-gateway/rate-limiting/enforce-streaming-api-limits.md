# Enforce Streaming API Limits

Streaming APIs (WebSocket, WebHook/WebSub, and SSE) maintain long-lived connections and deliver events over time, requiring different rate limiting approaches than traditional REST APIs. The Gateway enforces rate limiting for Streaming APIs based on event counts and connection duration rather than simple request counts.

## Rate Limiting Policy Types

The Gateway enforces three types of rate limiting policies for Streaming APIs, configured through subscription Business Plans:

### Count-based Rate Limiting

Rate limiting based on the total number of events an application can receive. Examples include 1M total events, 10M events, or Unlimited events. When an application reaches its limit, the Gateway throttles out the application.

### Time-based Rate Limiting

Rate limiting based on how long a client can maintain a subscription to a given topic/API. Examples include 1 week, 1 month, or unlimited duration. When the client reaches the specified time limit, the Gateway throttles out the connection.

### Count-time Hybrid Rate Limiting

Rate limiting based on both event count and time duration. For example, 1M events within a day. The Gateway enforces whichever limit is reached first.

## How the Gateway Enforces Limits by Protocol

### WebSocket APIs

Once the initial WebSocket handshake is complete, communication occurs via WebSocket frames. The Gateway counts each WebSocket frame as an event, regardless of direction (client-to-server or server-to-client).

**Enforcement:**

- The Gateway tracks the aggregate count of frames sent in both directions
- When the total frame count reaches the limit defined in the subscription policy, the Gateway throttles out the connection

### Server-Sent Events (SSE) APIs

In SSE, the server pushes events to the client over a long-lived HTTP connection. The Gateway counts each event, which is typically delimited with `\n\n`.

**Enforcement:**

- The Gateway tracks the number of events sent from server to client
- When the event count reaches the limit defined in the subscription policy, the Gateway throttles out the connection

### WebSub (WebHook) APIs

For WebSub/WebHook APIs, the Gateway enforces rate limiting based on two metrics:

- **Number of Active Connections** : The number of active subscriptions for an application in a given time unit

- **Number of Events** : The number of events consumed for a given unit of time for a single application subscription

**Enforcement:**

- When an application is throttled out, the Gateway sends a throttled out message to the callback URL
- This message is sent upon receiving the first event after throttling occurs

## Default Business Plans

The Gateway enforces the following default Business Plans for Streaming APIs:

**WebSocket and SSE APIs:**

| Business Plan     | Limit                      |
|-------------------|----------------------------|
| AsyncGold         | 50,000 events per day      |
| AsyncSilver       | 25,000 events per day      |
| AsyncBronze       | 5,000 events per day       |
| AsyncUnlimited    | Unlimited events           |

**WebHook/WebSub APIs:**

| Business Plan     | Limit                                                      |
|-------------------|-----------------------------------------------------------|
| AsyncWHGold       | 10,000 events per month and 1,000 active subscriptions   |
| AsyncWHSilver     | 5,000 events per month and 500 active subscriptions      |
| AsyncWHBronze     | 1,000 events per month and 500 active subscriptions      |

## Related Topics

- [Rate Limiting for Streaming APIs]({{base_path}}/api-design-manage/design/rate-limiting/rate-limiting-for-streaming-apis/) - How to configure Business Plans for Streaming APIs

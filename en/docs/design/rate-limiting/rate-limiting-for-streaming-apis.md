# Rate Limiting for Streaming APIs

## Overview

All Streaming APIs, such as WebSocket APIs, WebHook APIs, WebSub APIs and SSE APIs, use the following rate limiting policies in subscriptions.

- Count-based rate limiting - Rate limiting policies based on the number of total events an application can receive. For example, 1M total events, or 10M events or Unlimited events. Once the application reaches its limit the application will be kicked off. This can be used in the process of monetization.

- Time-based rate limiting -  Rate limiting policies based on how long the client can subscribe to a given topic/API. For example, 1 week, 1 month or forever. Once the time is reached the client will be kicked off. This can be used in the process of monetization.

Time-based Rate Limiting can be adjoined with the above count-based rate limiting policy as well which will result in a count-time hybrid rate limiting policy. For example, 1M events within a day.

## How it works

### WebSockets

Once the initial handshake is done, the communication in a WebSocket connection is done via WebSocket frames. WebSocket frames can be sent from client to server, and vice versa. Each WebSocket frame is counted as an event. WebSocket frames will be throttled out once the aggregate amount of frames sent from client to server and vice versa reach the amount defined in the rate limiting policy.

### Server-Sent Events (SSE)

In Server Sent Events, every event is counted. An event is usually delimited with `\n\n`. The connection will be throttled out when the number of events from the server to the client reaches the amount defined in the rate limiting policy.

### WebSub

Rate limiting events are counted in the following ways for WebSub Streaming APIs (WebHook Streaming APIs).

- Number of Active Connections

     The number of active connections, for an application subscription, in a given time unit.

- Number of Events

     The number of events, which can be consumed for a given unit of time, for a single application subscription.

A throttled out message will be sent to the callback URL, upon receiving the very first message after being throttled out.

## Business Plans

The API Creators need to select a minimum of one Business Plan when creating an API. These Business Plans can be either a default Business Plan, a custom Business Plan, or a combination of the two. The Business Plans are used to enforce rate limiting by allowing you to limit the number of events via the Streaming API during a given period of time.

### Default Business Plans

[![Streaming API Business Plans]({{base_path}}/assets/img/design/rate-limiting/stream-api-business-plans.png)]({{base_path}}/assets/img/design/rate-limiting/stream-api-business-plans.png)

The following is the list of default Business Plans that are related to Streaming APIs.

| **Default Business Plans**                                                    | **Applicable API** |
|---------------------------------------------------------------------------|----------------|
| AsyncGold : Allows 50000 events per day                                   | WebSocket, SSE |
| AsyncSilver : Allows 25000 events per day                                 | WebSocket, SSE |
| AsyncBronze : Allows 5000 events per day                                  | WebSocket, SSE |
| AsyncUnlimited : Allows unlimited events                                  | WebSocket, SSE |
| AsyncWHGold : Allows 10000 events per month and 1000 active subscriptions | WebHook/WebSub |
| AsyncWHSilver : Allows 5000 events per month and 500 active subscriptions | WebHook/WebSub |
| AsyncWHBronze : Allows 1000 events per month and 500 active subscriptions | WebHook/WebSub |

### Custom Business Plans

Instead of using the default Business Plans, a user who has the admin role, with access to the Admin Portal, can create custom Business Plans, which API Creators can use. For more information, see [Adding a new subscription-level throttling tier]({{base_path}}/design/rate-limiting/adding-new-throttling-policies/#adding-a-new-subscription-level-throttling-tier).

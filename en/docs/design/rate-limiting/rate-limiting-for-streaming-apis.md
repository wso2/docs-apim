# Rate Limiting for Streaming APIs 


### WebSockets

Once the initial handshake is done, the communication in a WebSocket connection is done via WebSocket frames. WebSocket frames can be sent from client to server, and vice versa. Each WebSocket frame is counted as an event. WebSocket frames will be throttled out once the aggregate amount of frames sent from client to server and vice versa reach the amount defined in the throttling policy.


### Server Sent Events

In Server Sent Events, every event is counted. An event is usually delimited with `\n\n`. The connection will be throttled out when the number of events from the server to the client reach the amount defined in the throttling policy.


### WebSub

Throttling events are counted in the following ways for WebSub Streaming APIs. A throttled out message will be sent to the callback URL, upon receiving the very first message after being throttled out.

#### Number of Active Connections

Number of active connections for an application subscription, in a given time unit.

#### Number of Events

How many events can be consumed for a given time unit, for a single application subscription.

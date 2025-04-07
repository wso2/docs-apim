# Monitoring WebSocket Logs

Logs related to WebSocket API invocations can be enabled in WSO2 API Manager. These logs allow you to monitor WebSocket
API invocations and debug/troubleshoot issues that may arise.
There are multiple ways to monitor WebSocket logs in WSO2 API Manager. Following are the major types of logs that can be
enabled.

1. Access Logs
2. General Debug Logs

## Access Logs

Websocket Access logs provide information about the WebSocket API invocations and related events. Information related to
websocket channel registration, handshake request, handshake response, inbound websocket frame (frame sent by client),
outbound websocket frame (frame sent by the websocket server), channel unregistration are printed in the Websocket
access logs.

You can enable access logs for WebSocket APIs by adding related configuration in the `log4j2.properties` file, so it is
not required to restart the server to enable them.

1. Add the following appender and logger configuration to the `log4j2.properties` file in
   the `<APIM_HOME>/repository/conf` directory.
   Please note that the logger name (property `logger.ws-access-logger.name` here) should be always set
   to `org.wso2.carbon.inbound.endpoint.protocol.websocket.WebSocketAccessLoggingHandler` as below.

    ```properties
    
    # Appender for WebSocket Access Logs
    appender.WSAccessAppender.type = RollingFile
    appender.WSAccessAppender.name = WSAccessAppender
    appender.WSAccessAppender.fileName = ${sys:carbon.home}/repository/logs/websocket-access.log
    appender.WSAccessAppender.filePattern=${sys:carbon.home}/repository/logs/websocket-access-%d{MM-dd-yyyy}.log
    appender.WSAccessAppender.layout.type = PatternLayout
    appender.WSAccessAppender.layout.pattern = [%d] [%tenantId] - [%m%ex] "%X{channel}" "%X{method}" "%X{uriPath}" "%X{httpProtocolVersion}" "%X{userAgentHeader}" "%X{host-port}" "%X{connectionHeader}" "%X{upgradeHeader}" "%X{secWebSocketVersion}" "%X{frameLength}" "%X{httpResponse}" "%X{handshakeStatus}"%n
    appender.WSAccessAppender.policies.type=Policies
    appender.WSAccessAppender.policies.time.type=TimeBasedTriggeringPolicy
    appender.WSAccessAppender.policies.time.interval=1
    appender.WSAccessAppender.policies.time.modulate=true
    appender.WSAccessAppender.policies.size.type=SizeBasedTriggeringPolicy
    appender.WSAccessAppender.policies.size.size=10MB
    appender.WSAccessAppender.strategy.type=DefaultRolloverStrategy
    appender.WSAccessAppender.filter.threshold.type=ThresholdFilter
    appender.WSAccessAppender.filter.threshold.level=TRACE
    appender.WSAccessAppender.strategy.max=20
    
    # Logger for WebSocket Access Logs
    logger.ws-access-logger.name=org.wso2.carbon.inbound.endpoint.protocol.websocket.WebSocketAccessLoggingHandler
    logger.ws-access-logger.level=DEBUG
    logger.ws-access-logger.additivity=false
    logger.ws-access-logger.appenderRefs=WSAccessAppender
    logger.ws-access-logger.appenderRef.WSAccessAppender.ref=WSAccessAppender
    
    ```

2. After adding above **logger** named `ws-access-logger` and **appender** named `WSAccessAppender`, set them to end of the list
   of `loggers` section and to the end of the list of `appenders` section accordingly as clarified below.

    ```properties
    appenders= ..., WSAccessAppender
    ```
    ```properties
    loggers= .., ws-access-logger
    ```

Sample access logs printed when Websocket connection is initiated is mentioned below.

```properties
[2025-01-08 18:11:37,453] [-1234] - [CHANNEL REGISTERED] "[id: 0xd463950d, L:/127.0.0.1:9099 - R:/127.0.0.1:51616]" "-" "-" "-" "-" "-" "-" "" "-" "-" "-" "-"
[2025-01-08 18:11:37,488] [-1234] - [HANDSHAKE REQUEST] "[id: 0xd463950d, L:/127.0.0.1:9099 - R:/127.0.0.1:51616]" "GET" "/exchange/1" "HTTP/1.1" "" "localhost:9099" "Upgrade" "websocket" "13" "-" "-" "-"
[2025-01-08 18:11:37,668] [-1234] - [HANDSHAKE RESPONSE] "[id: 0xd463950d, L:/127.0.0.1:9099 - R:/127.0.0.1:51616]" "-" "-" "HTTP/1.1" "-" "-" "upgrade" "websocket" "-" "-" "101 Switching Protocols" "success"
[2025-01-08 18:11:38,435] [-1234] - [OUTBOUND FRAME] "[id: 0xd463950d, L:/127.0.0.1:9099 - R:/127.0.0.1:51616]" "-" "-" "-" "-" "-" "-" "-" "-" "32" "-" "-"
```

Sample logs printed when a frame is sent from client and an echo response is returned back to the client, is mentioned below.
```properties
[2025-01-08 18:11:46,557] [-1234] - [INBOUND FRAME] "[id: 0xd463950d, L:/127.0.0.1:9099 - R:/127.0.0.1:51616]" "-" "-" "-" "-" "-" "-" "-" "-" "4" "-" "-"
[2025-01-08 18:11:46,944] [-1234] - [OUTBOUND FRAME] "[id: 0xd463950d, L:/127.0.0.1:9099 - R:/127.0.0.1:51616]" "-" "-" "-" "-" "-" "-" "-" "-" "4" "-" "-"
```

### Interpreting Websocket Access Logs

As illustrated in the above sample logs, the information related to following events are printed in the Websocket Access Logs.

1. **CHANNEL REGISTERED** 
    - This log is printed when a new channel is registered in the Websocket server.
2. **HANDSHAKE REQUEST** 
    - This log is printed when a handshake event is triggered.
3. **HANDSHAKE RESPONSE** 
    - This log is printed when a handshake response is sent back to the client.
4. **INBOUND FRAME** 
    - This log is printed when a frame is received from the client.
5. **OUTBOUND FRAME** 
    - This log is printed when a frame is sent back to the client.
6. **CHANNEL UNREGISTERED** 
    - This log is printed when a channel is unregistered from the Websocket server.
7. **UNAUTHORIZED REQUEST** 
    - This log is printed when an unauthorized request is received by the API-M Gateway.

A label from one of above is printed as a prefix in each log line within square brackets. The label is used to identify the type of the log.

The log pattern configured in log4j2.properties file is as below. You can remove the unneeded fields and customize the log pattern as preferred.
```properties
 appender.WSAccessAppender.layout.pattern = [%d] [%tenantId] - [%m%ex] "%X{channel}" "%X{method}" "%X{uriPath}" "%X{httpProtocolVersion}" "%X{userAgentHeader}" "%X{host-port}" "%X{connectionHeader}" "%X{upgradeHeader}" "%X{secWebSocketVersion}" "%X{frameLength}" "%X{httpResponse}" "%X{handshakeStatus}"%n \
```

All the supported properties for Websocket access logs are listed below with short descriptions and please note that
there will be values for only the related fields in the log line related to the event. If a particular field is not applicable for given
event related log line, empty default value (i.e. "-") will be printed.

<table>
<thead>
<tr class="header">
<th>Field</th>
<th>Description</th>
<th>Sample Values</th>
</tr>
</thead>
<tbody>

<tr class="odd">
<td>channel</td>
<td>Information on websocket channel. This is printed in a format which include Channel id ("id"), Local address ("L") 
with port and Remote address ("R") with port.</td>
<td>[id: 0xd463950d, L:/127.0.0.1:9099 - R:/127.0.0.1:51616]</td>
</tr>

<tr class="even">
<td>method</td>
<td>HTTP method initiated from the initial Websocket connection request.</td>
<td>GET</td>
</tr>

<tr class="odd">
<td>uriPath</td>
<td>URI path of the initial Websocket request.</td>
<td>/exchange/1</td>
</tr>

<tr class="even">
<td>httpProtocolVersion</td>
<td>HTTP protocol version of the Websocket connection request.</td>
<td>HTTP/1.1</td>
</tr>

<tr class="odd">
<td>userAgentHeader</td>
<td>Value of "User-Agent" header of the Websocket connection request.</td>
<td>PostmanRuntime/7.32.2</td>
</tr>

<tr class="even">
<td>host-port</td>
<td>Host and port of the Websocket connection request.</td>
<td>localhost:9099</td>
</tr>

<tr class="odd">
<td>connectionHeader</td>
<td>Value of the "Connection" header of the Websocket connection request or the Handshake response.</td>
<td>Upgrade</td>
</tr>

<tr class="even">
<td>upgradeHeader</td>
<td>Value of the "Upgrade" header of the Websocket connection request or the Handshake response.</td>
<td>websocket</td>
</tr>

<tr class="odd">
<td>secWebSocketVersion</td>
<td>Value of the "Sec-WebSocket-Version" header of the Websocket connection request.</td>
<td>13</td>
</tr>

<tr class="even">
<td>frameLength</td>
<td>Length of the frame sent/received through the Websocket connection.</td>
<td>32</td>
</tr>

<tr class="odd">
<td>httpResponse</td>
<td>HTTP response of the Websocket handshake.</td>
<td>101 Switching Protocols</td>
</tr>

<tr class="even">
<td>handshakeStatus</td>
<td>Status of the Websocket handshake.</td>
<td>"success" / "failure"</td>

</tbody>
</table>

## General Debug Logs

Debugs logs are provided in WSO2 Websocket implementation as similar to other code implementations. Among
them, `WebSocketClientHandler` debug logs important as they are more specifically organized to debug issues in Websocket
API invocations. The information logged in the `WebSocketClientHandler` debug logs includes, all headers of websocket connection call,
local/remote address, backend url, frame messages, etc.

To enable `WebSocketClientHandler` debug logs for WebSocket APIs, add the following logger configuration to the `log4j2.properties` file.

```properties
logger.webSocket-client-handler.name=org.wso2.carbon.websocket.transport.WebSocketClientHandler
logger.webSocket-client-handler.level=DEBUG
```

Sample logs printed when Websocket connection is initiated is mentioned below.

```properties
[2024-12-11 00:09:39,758] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] Date:Tue, 10 Dec 2024 18:39:40 GMT
[2024-12-11 00:09:39,759] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] Connection:upgrade
[2024-12-11 00:09:39,760] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] upgrade:websocket
[2024-12-11 00:09:39,760] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] sec-websocket-accept:hiOG8HhTfcEqAlWFdpBxB1cM2Ws=
[2024-12-11 00:09:39,760] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] via:1.1 fly.io
[2024-12-11 00:09:39,760] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] fly-request-id:01JERXXA53CXVC195BG62B9QSR-sin
[2024-12-11 00:09:39,760] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] CF-Cache-Status:DYNAMIC
[2024-12-11 00:09:39,761] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] Report-To:{"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v4?s=5VVuNqFKpCg2yxi36ZbLTxlUPm8NDQRdptZoB80paqEa4p6p5GeADO1DC9Tbn3ELy4m5792Jc%2FpZ35P2ZuJyvAXSBFP9ZWGfppSO3pbfmRJIeLYN6WTAWhZFAXEfyys%3D"}],"group":"cf-nel","max_age":604800}
[2024-12-11 00:09:39,761] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] NEL:{"success_fraction":0,"report_to":"cf-nel","max_age":604800}
[2024-12-11 00:09:39,761] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] X-Content-Type-Options:nosniff
[2024-12-11 00:09:39,762] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] Server:cloudflare
[2024-12-11 00:09:39,762] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] CF-RAY:8eff5be0dd6e4900-SIN
[2024-12-11 00:09:39,762] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] alt-svc:h3=":443"; ma=86400
[2024-12-11 00:09:39,762] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] server-timing:cfL4;desc="?proto=TCP&rtt=58037&min_rtt=58037&rtt_var=29018&sent=1&recv=3&lost=0&retrans=0&sent_bytes=0&recv_bytes=180&delivery_rate=0&cwnd=232&unsent_bytes=0&cid=0000000000000000&ts=0&x=0"
[2024-12-11 00:09:39,762] DEBUG - WebSocketClientHandler  >> Headers [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] content-length:0
[2024-12-11 00:09:39,763] DEBUG - WebSocketClientHandler WebSocket client connected to remote WS endpoint on context id : [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80]
[2024-12-11 00:09:39,763] DEBUG - WebSocketClientHandler  >> [id: 0x921ce4ed, L:/192.168.1.3:63326 - R:ws.ifelse.io/104.21.29.32:80] Request served by 6e82931b755587
[2024-12-11 00:09:39,763] DEBUG - WebSocketClientHandler injecting message to sequence : outDispatchSeq
[2024-12-11 00:09:39,763] DEBUG - WebSocketClientHandler injecting message to sequence : outDispatchSeq
[2024-12-11 00:09:39,806]  INFO - DataBridge user admin connected
```
Sample logs printed when a frame is sent from client, is mentioned below.

```properties
[2024-12-11 00:30:43,895] DEBUG - WebSocketClientHandler  >> [id: 0xfb77dea2, L:/192.168.1.3:63730 - R:ws.ifelse.io/104.21.29.32:80] aaa
[2024-12-11 00:30:43,909] DEBUG - WebSocketClientHandler injecting message to sequence : outDispatchSeq
```
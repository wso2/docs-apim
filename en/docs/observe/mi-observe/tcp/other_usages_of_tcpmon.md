# Other Usages of TCPMon

TCPMon is primarily used for message monitoring. Additionally, TCPMon
can also be used for sending requests to web services and as a proxy
service. Refer [Starting TCPMon]({{base_path}}/observe/mi-observe/tcp/starting_tcp_mon) for
details on how to start the tool.

## Sending requests to Web services

TCPMon can also be used as a request sender for Web services. The
request SOAP message can be pasted on the **Send** screen and sent directly
to the server.

![TCP Sender]({{base_path}}/assets/img/integrate/tcp/tcpmon-sender-other-usages.png)

## As a proxy

TCPMon can act as a proxy. To start it in proxy mode, select the **Proxy**
option shown below. When acting as a proxy, TCPMon only needs the listener port to
be configured.

![Select Proxy]({{base_path}}/assets/img/integrate/tcp/tcpmon-proxy-dialog.png)

## Advanced settings

TCPMon can simulate a slow connection, in which case the delay and the
bytes to be dropped can be configured. This is useful when testing Web
services.

![Advanced settings]({{base_path}}/assets/img/integrate/tcp/tcpmon-simulate-slow-connection.png)

Also, if HTTP proxy support is required, that can also be set on the
admin screen.

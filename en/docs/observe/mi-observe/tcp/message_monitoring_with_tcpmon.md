# Message Monitoring with TCPMon

Users can view and monitor the messages passed along a TCP-based conversation using the TCPMon utility. Therefore, this tool is particularly useful for debugging when you develop Web services. TCPMon is an **Apache** project distributed under **Apache 2.0 License**.

## How TCPMon works

TCPMon is not dependent on any third party libraries. Its user interface is based on a swing UI and works on almost all platforms that support Java. The most common usage of TCPMon is as an intermediary, which monitors the communication between the client (front end) and the back-end server. That is, the messages sent from the client are received by the intermediary instead of the back-end server. These messages are then forwarded to the back-end server from the intermediary.

## Example use case

The following diagram depicts a typical communication between the front
end client and the back-end server. 80 is the listening port of the back-end server, which receives the messages from the client:  

![Client Server Communication]({{base_path}}/assets/img/integrate/tcp/client-server-communication.png)

The following diagram depicts how TCPMon is placed between the client
and the server in order to monitor the messages. 8081 is the listening
port in TCPMon, which receives the messages from the client instead of
the back-end server:

![Client-TCP-Server Communication]({{base_path}}/assets/img/integrate/tcp/client-tcp-server-communication.png)

!!! Note
    -   As an intermediary, TCPMon only receives messages and forwards them to the back-end server. Therefore, it is a safe tool to be used for debugging purposes.
    -   Note that TCPMon cannot be used to view messages transferred over the HTTPS protocol.

## Start using TCPMon

To monitor messages from client to server using TCPMon:

1.  [Start TCPMon]({{base_path}}/observe/mi-observe/tcp/starting_tcp_mon) .
2.  Give 8081 (the listening port of TCPMon) in the **Listen Port**
    field (This could be any unused port in your local machine).
3.  Give the address of the back end server as the target hostname. For
    example, if you are monitoring messages sent to
    [www.apache.org](http://www.apache.org) , enter this web address as
    the hostname.
4.  Give 80 as the target port, which is the listening port of
    [www.apache.org.](http://www.apache.org.)  

    ![TCPMon console]({{base_path}}/assets/img/integrate/tcp/tcpmon-admin-console.png)

5.  Click **Add** to save the setting.
6.  Now, point the browser to 'localhost:8081' instead of [www.apache.org](http://www.apache.org).
7.  A new tab in TCPMon will indicate the 8081 port. You can view the
    requests and responses passing through TCPMon as shown below.  

    ![TCPMon ports]({{base_path}}/assets/img/integrate/tcp/tcpmon-port8081-console.png)

8.  The options at the bottom of the screen can be used to have the
    messages in XML format (useful in debugging Web services), to save
    and resend the messages and also to switch the layout of the message
    windows.

    ![TCPMon console option]({{base_path}}/assets/img/integrate/tcp/tcp-console-options.png)

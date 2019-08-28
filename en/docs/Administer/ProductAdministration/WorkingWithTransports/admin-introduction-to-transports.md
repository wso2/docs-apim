# admin\_Introduction to Transports

WSO2 Carbon is the base platform on which all WSO2 Java products are developed. Built on OSGi, WSO2 Carbon encapsulates all major SOA functionality. It supports a variety of transports, which make Carbon-based products capable of receiving and sending messages over a multitude of transport and application-level protocols. This functionality is implemented mainly in the Carbon core, which combines a set of transport-specific components to load, enable, manage and persist transport related functionality and configurations.

All transports currently supported by WSO2 Carbon are directly or indirectly based on the Apache Axis2 transports framework. This framework provides two main interfaces for each transport implementation.

-   org.apache.axis2.transport.TransportListener - Implementations of this interface should specify how incoming messages are received and processed before handing them over to the Axis2 engine for further processing.
-   org.apache.axis2.transport.TransportSender - Implementations of this interface should specify how a message can be sent out from the Axis2 engine.

Each transport implementation generally contains a transport receiver/listener and a transport sender, since they use the interfaces above. The Axis2 transport framework enables the user to configure, enable and manage transport listeners and senders independent to each other, without having to restart the server. For example, one may enable only the JMS transport sender without having to enable JMS transport listener.

There are two main types of transports: blocking and non-blocking. In a blocking transport, the I/O threads get blocked since the same worker thread that sends the request to the server will remain open to receive the response, until messages are completely processed by the underlying Axis2 engine . However, in non-blocking transports the worker thread that sends the request will not wait for the response and another thread will receive the response. Thereby, non-blocking transports increase the performance of the server.

The transport management capability of WSO2 Carbon is provided by the following feature in the WSO2 feature repository:

**Name** : WSO2 Carbon - Transport Management Feature
**Identifier** : org.wso2.carbon.transport.mgt.feature.group

If transport management capability is not included in your product by default, you can add it by installing the above feature using the instructions given in the [Feature Management](https://docs.wso2.com/display/Carbon420/Installing+Features+via+the+UI) section.

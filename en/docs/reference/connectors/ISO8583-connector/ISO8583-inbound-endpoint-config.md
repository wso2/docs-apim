# ISO8583 Inbound Endpoint Reference

The following operations allow you to work with the ISO8583 Inbound Endpoint. Click an operation name to see parameter details and samples on how to use it.

ISO8583 Inbound endpoint allows the ISO8583 standard messages through WSO2 EI. ISO8583 is a message standard that is used in financial transactions. There are various versions of the ISO8583 standard. The Inbound Endpoint is developed based on the 1987 version of the standard. For more information about ISO8583 Standard, go to ISO8583 Documentation.

WSO2 EI ISO8583 inbound endpoint acts as a message consumer. Since it is a listening inbound, it is listening on port 5000. When a client is connected on port 5000, WSO2 EI ISO8583 Inbound Endpoint starts to consume the ISO8583 standard messages and inject the messages in XML format into sequence.

In order to use the ISO8583 inbound endpoint, you need to do the following: 

- Download the inbound `org.wso2.carbon.inbound.iso8583-1.0.0.jar` file from the [https://store.wso2.com/store/assets/esbconnector/ISO8583](https://store.wso2.com/store/assets/esbconnector/ISO8583). 
- Download the `jpos-1.9.4.jar` from the [http://mvnrepository.com/artifact/org.jpos/jpos/1.9.4](http://mvnrepository.com/artifact/org.jpos/jpos/1.9.4). 
- Download `jdom-1.1.3.jar` from [http://mvnrepository.com/artifact/org.jdom/jdom/1.1.3](http://mvnrepository.com/artifact/org.jdom/jdom/1.1.3). 
- Download `commons-cli-1.3.1.jar` from [http://mvnrepository.com/artifact/commons-cli/commons-cli/1.3.1](http://mvnrepository.com/artifact/commons-cli/commons-cli/1.3.1). 

Copy the .jar files to the <EI_HOME>/lib directory.

> **Note**: `jpos` is the third party library, and `jposdef.xml` has the field definitions of the standard ISO8583 Messages. According to the field definitions, each and every ISO8583 message that  comes from the client will be unpacked and the fields of the ISO8583 standard messages will be identified.

To handle the concurrent messages in ISO8583 inbound endpoint, you need to create the threadpool and it can contain a varying amount of threads. The number of threads in the pool is determined by these variables:

- `corePoolSize`: The number of threads to keep in the pool, even if they are idle.
- `maximumPoolSize`: The maximum number of threads to allow in the pool.

Another parameter in `threadPool` configuration is `keepAliveTime`, which is the maximum time that excess idle threads will be alive for new tasks before terminating. 

<table>
    <tr>
        <th>Parameter Name</th>
        <th>Description</th>
        <th>Required</th>
    </tr>
    <tr>
        <td>port</td>
        <td>Hosts have ports. The socket connection is created according to that port and the server starts listening to that port once the socket connection is established. Possible values are 0-65535 and the default is 5000.</td>
        <td>Yes</td>
    </tr>
    <tr>
        <td>coreThreads</td>
        <td>The number of threads to keep in the pool.</td>
        <td>Yes</td>
    </tr>
    <tr>
        <td>maxThreads</td>
        <td>The maximum number of threads to allow in the pool.</td>
        <td>Yes</td>
    </tr>
    <tr>
        <td>keepAliveTime</td>
        <td>If the pool currently has more than corePoolSize threads, excess threads will be terminated if they have been idle for more than the keepAliveTime.</td>
        <td>Yes</td>
    </tr>
</table>

**Sample configuration**

```xml
<inboundEndpoint
        class="org.wso2.carbon.inbound.iso8583.listening.ISO8583MessageConsumer"
        name="custom_listener" onError="fault" sequence="request" suspend="false">
        <parameters>
            <parameter name="sequential">true</parameter>
            <parameter name="inbound.behavior">listening</parameter>
            <parameter name="port">5000</parameter>
        </parameters>
</inboundEndpoint>
```

> **Note**: To send ISO8583 Standard messages to an inbound endpoint, you can use Java client applications. The client needs to produce the ISO8583 Standard messages and get the acknowledgement from the inbound endpoint.

A Sample test client program is provided in https://github.com/wso2-docs/CONNECTORS/tree/master/ISO8583/ISO8583TestClient. You can use this sample client to test the inbound endpoint.
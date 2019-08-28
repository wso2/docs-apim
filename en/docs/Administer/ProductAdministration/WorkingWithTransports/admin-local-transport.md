# admin\_Local Transport

Apache Axis2's local transport implementation is used to make internal service calls and transfer data within the Axis2 instance. The following class implements the sender API:

-   `          org.apache.axis2.transport.local.LocalTransportSender         `

The transport does not have a receiver implementation as of now.

It provides an opportunity for fast in-VM service call.

!!! info
To use this transport, configure an endpoints with the `         local://        ` prefix. For example, to make an in-VM call to the HelloService, use `                   local://HelloService                 ` .


##### Configuring a local transport with WSO2 products

Shown below is how to configure a local transport with any WSO2 Carbon-based product.

1. In the carbon.xml file at location &lt;PRODUCT\_HOME&gt;/repository/conf, an endpoint is available as follows by default.

``` html/xml
    <ServerURL>local://services/&lt;/ServerURL>
```

2. In the axis2.xml file at location &lt;PRODUCT\_HOME&gt;/repository/conf/axis2, there is a transport sender named 'local' specified as follows:

``` html/xml
    <transportSender name="local" class="org.apache.axis2.transport.local.LocalTransportSender"/>
```

It has to be replaced with the following sender/receiver pair.

``` html/xml
    <transportReceiver name="local" class="org.wso2.carbon.core.transports.local.CarbonLocalTransportReceiver"/>
    <transportSender name="local" class="org.wso2.carbon.core.transports.local.CarbonLocalTransportSender"/>
```

For more information about transports, refer to Transport Management .

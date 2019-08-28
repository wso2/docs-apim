# admin\_UDP Transport

The UDP transport implementation is in the Apache WS-Commons Transports project. The following classes implement the Axis2 transport listener and sender APIs respectively.

-   org.apache.axis2.transport.udp.UDPListener
-   org.apache.axis2.transport.udp.UDPSender

The axis2-transport-udp.jar archive file contains the above implementation classes.

To enable the UDP transport for samples, simple open the file repository/conf/axis2.xml in a text editor and add the following transport configurations. UDP transport component is shipped with the WSO2 ESB by default.

``` java
    <transportReceiver name="udp"/>
     <transportSender name="udp"/>
```

If you wish to use the sample Axis2 client to send UDP messages, you have to uncomment the UDP transport sender configuration in the samples/axis2Client/client\_repo/conf/axis2.xml file.

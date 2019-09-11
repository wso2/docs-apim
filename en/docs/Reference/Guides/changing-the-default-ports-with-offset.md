# Changing the Default Ports with Offset

When you run multiple WSO2 products/clusters or multiple instances of the same product on the same server or virtual machines (VMs), you must change their default ports with an offset value to avoid port conflicts. An offset defines the number by which all ports in the runtime (e.g., HTTP/S ports) will be increased. For example, if the default HTTP port is 9763 and the offset is 1, the effective HTTP port will change to 9764. For each additional WSO2 product instance, you set the port offset to a unique value. The offset of the default port is considered to be 0.

There are two ways to set an offset to a port:

-   Pass the port offset to the server during startup. The following command starts the server with the default port incremented by 3 `:./wso2server.sh -DportOffset=3         `
-   Set the offset in the Ports section of `<PRODUCT_HOME>/repository/conf/carbon.xml` . E.g., `<Offset>3</Offset>         `

When you offset the server's port, it automatically changes all ports it uses. However, you are also able to manually adjust the ports for the Thrift client and Thrift server if needed.

#### Changing the Thrift client and server ports

The port offset specified earlier in the `carbon.xml` file affects the ports of the Thrift client and server as well (the default port is 10397). However, since Thrift is run as a separate server within WSO2 servers, it is possible to adjust the ports manually in the `<APIM_HOME>/repository/conf/api-manager.xml` file. By default, the `<ThriftClientPort>` and `<ThriftServerPort>` elements are commented out. If you want to adjust those ports manually, first uncomment the elements and change the Thrift ports separately. For example,

``` html/xml
    <KeyValidatorClientType>ThriftClient</KeyValidatorClientType>
    <ThriftClientPort>10399</ThriftClientPort>
    <ThriftClientConnectionTimeOut>10000</ThriftClientConnectionTimeOut>
    <ThriftServerPort>10399</ThriftServerPort>
    <ThriftServerHost>localhost</ThriftServerHost>
    <EnableThriftServer>true</EnableThriftServer>  
```

!!! note
If you specify the Thrift client and server ports manually, the port offset specified in the `carbon.xml` file has no effect on those two ports and the value that is set manually is used instead.


When you run multiple instances of the API Manager in distributed mode, the Gateway and Key Manager (used for validation and authentication) can run on two different JVMs. When the API Gateway receives API invocation calls, it contacts the API Key Manager service for verification (given that [caching](https://docs.wso2.com/display/AM260/Configuring+Caching) is not enabled at the Gateway level). Communication between API Gateway and Key Manager happens in either of the following ways:

-   Through a Web service call
-   Through a Thrift call

The default communication mode is using Thrift. Assume that the Gateway port is offset by 2, Key Manager port by 5 and the default Thrift port is 10397. If the Thrift ports are changed by the offsets of Gateway and Key Manager, the Thrift client port (Gateway) will now be 10399 while the Thrift server port (Key Manager) will change to 10402. This causes communication between the Gateway and Key Manager to fail because the Thrift client and server ports are different.

To fix this, you must change the Thrift client and server ports of the Gateway and Key Manager to the same value. In this case, the difference between the two offsets is 3, so you can either increase the default Thrift client port by 3 or else reduce the Thrift server port by 3.

#### Changing the offset of the Workflow Callback Service

The API Manager has a Service which listens for workflow callbacks. This service configuration can be found at `<APIM_HOME>/repository/deployment/server/synapse-configs/default/proxy-services/WorkflowCallbackService.xml` . Open this file and change the port value of the `<address uri>` accordingly.

For example,

``` html/xml
    <address uri="https://localhost:9445/store/site/blocks/workflow/workflow-listener/ajax/workflow-listener.jag" format="rest"/>
```

For a list of all default ports opened in WSO2 API Manager, see [Default Product Ports](_Default_Product_Ports_) .

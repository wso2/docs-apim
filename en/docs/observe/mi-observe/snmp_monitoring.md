# SNMP Monitoring

Simple Network Management Protocol (SNMP) is an Internet-standard
protocol for managing devices on IP networks. Given below is how to
configure SNMP in WSO2 Micro Integrator, which exposes
various MBeans via SNMP.

## Enabling SNMP

1.  Download the following jar files from [http://www.snmp4j.org](http://www.snmp4j.org/) and add them to the
    `MI_HOME/lib` directory. 
    -  **snmp4j-2.1.0.jar**
    -  **snmp4j-agent-2.0.6.jar**
2.  Enable SNMP in the `ei.toml` file, stored in the `MI_HOME/conf/` file by
    adding the following entry: 
    
    ```toml
    [synapse_properties]
    'synapse.snmp.enabled'=true
    ``` 

WSO2 Micro Integrator can now monitor MBeans with SNMP. For example:

``` java
Monitoring Info : OID branch "1.3.6.1.4.1.18060.14" with the following sub-branches:
    
1 - ServerManager MBean
2 - Transport MBeans
3 - NHttpConnections MBeans
4 - NHTTPLatency MBeans
5 - NHTTPS2SLatency MBeans
```

## MBean OID mappings

Following are the OID equivalents of the server manager and transport MBeans, which are described in [JMX Monitoring]({{base_path}}/observe/mi-observe/jmx_monitoring):

```
Name=ServerManager@ServerState as OID: 
1.3.6.1.4.1.18060.14.1.21.1.0

Name=passthru-http-sender@ActiveThreadCount as OID:
1.3.6.1.4.1.18060.14.2.17.1.0

Name=passthru-http-sender@AvgSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.17.2.0

Name=passthru-http-sender@AvgSizeSent as OID:
1.3.6.1.4.1.18060.14.2.17.3.0

Name=passthru-http-sender@BytesReceived as OID:
1.3.6.1.4.1.18060.14.2.17.4.0

Name=passthru-http-sender@BytesSent as OID:
1.3.6.1.4.1.18060.14.2.17.5.0

Name=passthru-http-sender@FaultsReceiving as OID:
1.3.6.1.4.1.18060.14.2.17.6.0

Name=passthru-http-sender@FaultsSending as OID:
1.3.6.1.4.1.18060.14.2.17.7.0

Name=passthru-http-sender@LastResetTime as OID:
1.3.6.1.4.1.18060.14.2.17.8.0

Name=passthru-http-sender@MaxSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.17.9.0

Name=passthru-http-sender@MaxSizeSent as OID:
1.3.6.1.4.1.18060.14.2.17.10.0

Name=passthru-http-sender@MessagesReceived as OID:
1.3.6.1.4.1.18060.14.2.17.11.0

Name=passthru-http-sender@MessagesSent as OID:
1.3.6.1.4.1.18060.14.2.17.12.0

Name=passthru-http-sender@MetricsWindow as OID:
1.3.6.1.4.1.18060.14.2.17.13.0

Name=passthru-http-sender@MinSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.17.14.0

Name=passthru-http-sender@MinSizeSent as OID:
1.3.6.1.4.1.18060.14.2.17.15.0

Name=passthru-http-sender@QueueSize as OID:
1.3.6.1.4.1.18060.14.2.17.16.0

Name=passthru-http-sender@TimeoutsReceiving as OID:
1.3.6.1.4.1.18060.14.2.17.18.0

Name=passthru-http-sender@TimeoutsSending as OID:
1.3.6.1.4.1.18060.14.2.17.19.0

Name=passthru-https-sender@ActiveThreadCount as OID:
1.3.6.1.4.1.18060.14.2.18.1.0

Name=passthru-https-sender@AvgSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.18.2.0

Name=passthru-https-sender@AvgSizeSent as OID:
1.3.6.1.4.1.18060.14.2.18.3.0

Name=passthru-https-sender@BytesReceived as OID:
1.3.6.1.4.1.18060.14.2.18.4.0

Name=passthru-https-sender@BytesSent as OID:
1.3.6.1.4.1.18060.14.2.18.5.0

Name=passthru-https-sender@FaultsReceiving as OID:
1.3.6.1.4.1.18060.14.2.18.6.0

Name=passthru-https-sender@FaultsSending as OID:
1.3.6.1.4.1.18060.14.2.18.7.0

Name=passthru-https-sender@LastResetTime as OID:
1.3.6.1.4.1.18060.14.2.18.8.0

Name=passthru-https-sender@MaxSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.18.9.0

Name=passthru-https-sender@MaxSizeSent as OID:
1.3.6.1.4.1.18060.14.2.18.10.0

Name=passthru-https-sender@MessagesReceived as OID:
1.3.6.1.4.1.18060.14.2.18.11.0

Name=passthru-https-sender@MessagesSent as OID:
1.3.6.1.4.1.18060.14.2.18.12.0

Name=passthru-https-sender@MetricsWindow as OID:
1.3.6.1.4.1.18060.14.2.18.13.0

Name=passthru-https-sender@MinSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.18.14.0

Name=passthru-https-sender@MinSizeSent as OID:
1.3.6.1.4.1.18060.14.2.18.15.0

Name=passthru-https-sender@QueueSize as OID:
1.3.6.1.4.1.18060.14.2.18.16.0

Name=passthru-https-sender@TimeoutsReceiving as OID:
1.3.6.1.4.1.18060.14.2.18.18.0

Name=passthru-https-sender@TimeoutsSending as OID:
1.3.6.1.4.1.18060.14.2.18.19.0

Name=passthru-http-receiver@ActiveThreadCount as OID:
1.3.6.1.4.1.18060.14.2.19.1.0

Name=passthru-http-receiver@AvgSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.19.2.0

Name=passthru-http-receiver@AvgSizeSent as OID:
1.3.6.1.4.1.18060.14.2.19.3.0

Name=passthru-http-receiver@BytesReceived as OID:
1.3.6.1.4.1.18060.14.2.19.4.0

Name=passthru-http-receiver@BytesSent as OID:
1.3.6.1.4.1.18060.14.2.19.5.0

Name=passthru-http-receiver@FaultsReceiving as OID:
1.3.6.1.4.1.18060.14.2.19.6.0

Name=passthru-http-receiver@FaultsSending as OID:
1.3.6.1.4.1.18060.14.2.19.7.0

Name=passthru-http-receiver@LastResetTime as OID:
1.3.6.1.4.1.18060.14.2.19.8.0

Name=passthru-http-receiver@MaxSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.19.9.0

Name=passthru-http-receiver@MaxSizeSent as OID:
1.3.6.1.4.1.18060.14.2.19.10.0

Name=passthru-http-receiver@MessagesReceived as OID:
1.3.6.1.4.1.18060.14.2.19.11.0

Name=passthru-http-receiver@MessagesSent as OID:
1.3.6.1.4.1.18060.14.2.19.12.0

Name=passthru-http-receiver@MetricsWindow as OID:
1.3.6.1.4.1.18060.14.2.19.13.0

Name=passthru-http-receiver@MinSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.19.14.0

Name=passthru-http-receiver@MinSizeSent as OID:
1.3.6.1.4.1.18060.14.2.19.15.0

Name=passthru-http-receiver@QueueSize as OID:
1.3.6.1.4.1.18060.14.2.19.16.0

Name=passthru-http-receiver@TimeoutsReceiving as OID:
1.3.6.1.4.1.18060.14.2.19.18.0

Name=passthru-http-receiver@TimeoutsSending as OID:
1.3.6.1.4.1.18060.14.2.19.19.0

Name=passthru-https-receiver@ActiveThreadCount as OID:
1.3.6.1.4.1.18060.14.2.20.1.0

Name=passthru-https-receiver@AvgSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.20.2.0

Name=passthru-https-receiver@AvgSizeSent as OID:
1.3.6.1.4.1.18060.14.2.20.3.0

Name=passthru-https-receiver@BytesReceived as OID:
1.3.6.1.4.1.18060.14.2.20.4.0

Name=passthru-https-receiver@BytesSent as OID:
1.3.6.1.4.1.18060.14.2.20.5.0

Name=passthru-https-receiver@FaultsReceiving as OID:
1.3.6.1.4.1.18060.14.2.20.6.0

Name=passthru-https-receiver@FaultsSending as OID:
1.3.6.1.4.1.18060.14.2.20.7.0

Name=passthru-https-receiver@LastResetTime as OID:
1.3.6.1.4.1.18060.14.2.20.8.0

Name=passthru-https-receiver@MaxSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.20.9.0

Name=passthru-https-receiver@MaxSizeSent as OID:
1.3.6.1.4.1.18060.14.2.20.10.0

Name=passthru-https-receiver@MessagesReceived as OID:
1.3.6.1.4.1.18060.14.2.20.11.0

Name=passthru-https-receiver@MessagesSent as OID:
1.3.6.1.4.1.18060.14.2.20.12.0

Name=passthru-https-receiver@MetricsWindow as OID:
1.3.6.1.4.1.18060.14.2.20.13.0

Name=passthru-https-receiver@MinSizeReceived as OID:
1.3.6.1.4.1.18060.14.2.20.14.0

Name=passthru-https-receiver@MinSizeSent as OID:
1.3.6.1.4.1.18060.14.2.20.15.0

Name=passthru-https-receiver@QueueSize as OID:
1.3.6.1.4.1.18060.14.2.20.16.0

Name=passthru-https-receiver@TimeoutsReceiving as OID:
1.3.6.1.4.1.18060.14.2.20.18.0

Name=passthru-https-receiver@TimeoutsSending as OID:
1.3.6.1.4.1.18060.14.2.20.19.0
```

# Using the FIX Transport

This example demonstrates the usage of the FIX (Financial Information eXchange) transport with proxy services.

## Synapse configuration

WSO2 Micro Integrator will create a session with an Executor and forward the order request. The responses coming from the Executor will be sent back to
Banzai.

```xml
<proxy name="FIXProxy" transports="fix" xmlns="http://ws.apache.org/ns/synapse">
    <parameter name="transport.fix.AcceptorConfigURL">file:/home/synapse_user/fix-config/fix-synapse.cfg</parameter>
    <parameter name="transport.fix.InitiatorConfigURL">file:/home/synapse_user/fix-config/synapse-sender.cfg</parameter>
    <parameter name="transport.fix.AcceptorMessageStore">file</parameter>
    <parameter name="transport.fix.InitiatorMessageStore">file</parameter>
    <target>
        <endpoint>
            <address uri="fix://localhost:19876?BeginString=FIX.4.0&amp;SenderCompID=SYNAPSE&amp;TargetCompID=EXEC"/>
        </endpoint>
    <inSequence>
    <log level="full"/>
    </inSequence>
        <outSequence>
            <log level="full"/>
            <send/>
        </outSequence>
    </target>
</proxy>
```

## Build and run

-   You will need the two sample FIX applications that come with
    Quickfix/J (Banzai and Executor). [Configure the two applications]({{base_path}}/install-and-setup/setup/mi-setup/transport_configurations/configuring-transports/#configuring-the-fix-transport) to
    establish sessions with the Micro Integrator and enable the FIX transport in the Micro-Integrator.
-   Start the Micro-Integrator.
-   Be sure that the
    `           transport.fix.AcceptorConfigURL          ` property
    points to the `           fix-synapse.cfg          ` file you
    created. Also make sure that
    `           transport.fix. InitiatorConfigURL          ` property
    points to the `           synapse-sender.cfg          ` file you
    created.

    !!! Note
        The Micro Integrator creates a new FIX session with Banzai at this point.
        
-   Start Banzai and Executor.
-   Send an order request from Banzai to the Micro Integrator.

### Configuring the Micro Integrator for FIX Samples

Create the FIX configuration files as specified below. The `FileStorePath` property in the following two files should point to two directories in your local file system. Once the samples are executed, Synapse will create FIX message stores in these two directories.

```java tab='fix-synapse.cfg'
[default]
    FileStorePath=repository/logs/fix/data
    ConnectionType=acceptor
    StartTime=00:00:00
    EndTime=00:00:00
    HeartBtInt=30
    ValidOrderTypes=1,2,F
    SenderCompID=SYNAPSE
    TargetCompID=BANZAI
    UseDataDictionary=Y
    DefaultMarketPrice=12.30

    [session]
    BeginString=FIX.4.0
    SocketAcceptPort=9876
```

```java tab='synapse-sender.cfg'
[default]
    FileStorePath=repository/logs/fix/data
    SocketConnectHost=localhost
    StartTime=00:00:00
    EndTime=00:00:00
    HeartBtInt=30
    ReconnectInterval=5
    SenderCompID=SYNAPSE
    TargetCompID=EXEC
    ConnectionType=initiator

    [session]
    BeginString=FIX.4.0
    SocketConnectPort=19876
```

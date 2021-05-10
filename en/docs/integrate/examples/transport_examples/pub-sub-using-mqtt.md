# Using the MQTT transport
This sample demonstrates how to run a Pub-Sub use case using MQTT as the broker.  the MQTT listener in the Micro Integrator consumes messages from a MQTT topic, and the MQTT sender publishes messages to a MQTT topic.

## Synapse configuration

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse" name="SampleProxy" transports="mqtt" startOnLoad="true" trace="disable">
    <description/>
    <target>
        <endpoint>
            <address uri="mqtt:/SampleProxy?mqtt.server.host.name=localhost&amp;mqtt.server.port=1883&amp;mqtt.client.id=esb.test.sender&amp;mqtt.topic.name=esb.test2&amp;mqtt.subscription.qos=2&amp;mqtt.blocking.sender=true"/>
        </endpoint>
        <inSequence>
            <property name="OUT_ONLY" value="true"/>
            <property name="FORCE_SC_ACCEPTED" value="true" scope="axis2" type="STRING"/>
        </inSequence>
        <outSequence>
            <send/>
        </outSequence>
    </target>
    <parameter name="mqtt.connection.factory">mqttConFactory</parameter>
    <parameter name="mqtt.topic.name">esb.test1</parameter>
    <parameter name="mqtt.subscription.qos">2</parameter>
    <parameter name="mqtt.content.type">text/plain</parameter>
    <parameter name="mqtt.session.clean">false</parameter>
</proxy>  
```

Add the following configurations to enable the MQTT listener and sender in `<MI_HOME>/conf/deployment.toml` file.

```toml
[transport.mqtt]
listener.enable = true
listener.hostname = "localhost"
listener.connection_factory = "mqttConFactory"
listener.server_port = 1883
listener.client_id = "client-id-1234"
listener.topic_name = "esb.test2"

sender.enable = true
```

## Build and run

-   Download the `org.eclipse.paho.client.mqttv3-1.1.0.jar`
    file.
-   Download mosquitto MQTT broker (http://mosquitto.org/)
-   Copy the `org.eclipse.paho.client.mqttv3-1.1.0.jar` file to the `MI_HOME/lib/` directory.
-   Start the MQTT broker.

Invoke the proxy service:

-   Execute the following command to start the MQTT subscriber on the
    *esb.test2* topic:

    ```bash
    mosquitto_sub -h localhost -t esb.test2
    ```

-   Execute the following command to run the MQTT publisher to publish
    to the *esb.test1* topic:

    ```bash
    mosquitto_pub -h localhost -p 1883 -t esb.test1  -m {"company":"WSO2"}
    ```

When you analyze the output messages on the MQTT subscriber console, you
will see the following log:

```bash
{"company":"WSO2"}
```

# Receiving XML events via MQTT

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling  to receive events to the SweetProductionStream via MQTT transport in XML format and log the events in LowProductionAlertStream to the output console.

## Prerequisites:
1. Save this sample. "`Siddhi App ReceiveMQTTInXMLFormat successfully deployed`" message would be shown in the console.
2. Before running this MQTT sample, set up mosquitto server which supports MQTT. This can be done by the following commands:
    ```bash
    sudo apt-get update
    sudo apt-get install mosquitto
    ```
3. Install mosquitto client packages by executing following command.
    ```bash
    sudo apt-get install mosquitto-clients
    ```
4. After the set up ,start the mosquitto server by running the following command.
    ```bash
    sudo service mosquitto start
    ```

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run', the following messages would be shown on the console.
    ```
    ReceiveMQTTInXMLFormat.siddhi - Started Successfully!
    ```

## Testing the Sample:
##### Option 1: Publish events with the command line publisher:
Open a terminal and publish events using following command. (The values for name and amount attributes can be changed as desired).
```bash
mosquitto_pub -t 'mqtt_topic_input' -m '<events><event><name>sugar</name><amount>300.0</amount></event></events>'
```

##### Option 2: Publish events with mqtt sample client:
1. Open a terminal and navigate to `<WSO2_SI_HOME>/samples/sample-clients/mqtt-client`.
2. Run the following command in the terminal:
    ```bash
    ant
    ```
    If you want to publish custom number of events, you need to run `ant` command as follows.
    ```bash
    ant -DnoOfEventsToSend=5
    ```

## Viewing the Results:
See the output. Following message would be shown on the console.
```
ReceiveHTTPInXMLFormatWithDefaultMapping : LowProducitonAlertStream : Event{timestamp=1511938781887, data=[sugar, 300.0], isExpired=false}
```

## Note:
1. Stop this Siddhi application.
2. Stop the mosquitto server using following command once you are done with the execution.
    ```bash
    sudo service mosquitto stop
    ```

```sql
@App:name("ReceiveMQTTInXMLFormat")
@App:description('Receive events via MQTT transport in XML format and view the output on the console.')


@source(type='mqtt', url= 'tcp://localhost:1883',topic='mqtt_topic_input', @map(type='xml'))
define stream SweetProductionStream (name string, amount double);

@sink(type='log')
define stream LowProductionAlertStream (name string, amount double);

-- passthrough data in the SweetProductionStream into LowProducitonAlertStream
@info(name='query1')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```
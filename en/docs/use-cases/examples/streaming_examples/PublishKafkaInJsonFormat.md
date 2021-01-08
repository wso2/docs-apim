# Publishing JSON Events via Kafka

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send sweet production events via Kafka transport in JSON format.

## Prerequisites:
1. Set up Kafka as follows:
	1. Create a folder called `kafka` and another folder called `kafka-osgi`.
	2. Copy the following files from `{KafkaHome}/libs` to the kafka folder you just created:
		* kafka_2.11-0.10.0.0.jar
		* kafka-clients-0.10.0.0.jar
		* metrics-core-2.2.0.jar
		* scala-library-2.11.8.jar
		* zkclient-0.8.jar
		* zookeeper-3.4.6.jar
	3. Copy these same files to the `{WSO2SIHome}/samples/sample-clients/lib` folder.
	4. Navigate to `{WSO2SIHome}/bin` and issue the following command:
		* For Linux:
			```bash
			./jartobundle.sh <path/kafka> <path/kafka-osgi>
			```
		* For Windows:
			```bash
			./jartobundle.bat <path/kafka> <path/kafka-osgi>
			```
	   If converted successfully, the following messages are shown on the terminal for each lib file:
	   ```
	   - INFO: Created the OSGi bundle <kafka-lib-name>.jar for JAR file <absolute_path>/kafka/<kafka-lib-name>.jar
	   ```
	5. Copy the OSGi-converted kafka libs from the `kafka-osgi` folder to `{WSO2SIHome}/lib`.
2. Save this sample.
3. If there is no syntax error, the following message is shown on the console:
	```
	Siddhi App PublishKafkaInJsonFormat successfully deployed.
	```

## Executing the Sample:
1. Navigate to `{KafkaHome}` and start the zookeeper node using following command.
	```bash
	bin/zookeeper-server-start.sh config/zookeeper.properties
	```
2. Navigate to `{KafkaHome}` and start the kafka server node using following command.
	```bash
	bin/kafka-server-start.sh config/server.properties
	```
3. Navigate to `{WSO2SIHome}/samples/sample-clients/kafka-consumer` and run the `ant` command without arguments.
4. Start the Siddhi application by clicking on 'Run'.
5. If the Siddhi application starts successfully, the following messages are shown on the console:
	```
	- PublishKafkaInJsonFormat.siddhi - Started Successfully!
	- Kafka version : 0.10.0.0
	- Kafka commitId : 23c69d62a0cabf06
	- Kafka producer created.
	```

## Testing the Sample:
Send events through one or more of the following methods.

##### Option 1: Send events to the kafka sink via the event simulator:
1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, specify the values as follows:
	* Siddhi App Name: PublishKafkaInJsonFormat
	* Stream Name: SweetProductionStream
3. In the batchNumber and lowTotal fields, enter the following values and then click Send to send the event.
	```
	batchNumber: 1
	lowTotal: 50.50
	```
4. Send some more events.

##### Option 2: Publish events with Curl to the simulator HTTP endpoint:
1. Open a new terminal and issue the following command:
	```bash
	curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishKafkaInJsonFormat","data": [1, 50.50]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
	```
2. If there is no error, the following messages are shown on the terminal:
	```json
	{"status":"OK","message":"Single Event simulation started successfully"}
	```

##### Option 3: Publish events with Postman to the simulator HTTP endpoint:
1. Install the 'Postman' application from the Chrome web store.
2. Launch the Postman application.
3. Make a 'Post' request to the 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to 'text/plain' and set the request body in text as follows:
	```json
	{"streamName": "SweetProductionStream", "siddhiAppName": "PublishKafkaInJsonFormat","data": [1, 50.50]}
	```
4. Click 'send'. If there is no error, the following messages are shown on the console:
	```
	"status": "OK",
	"message": "Single Event simulation started successfully"
	```

## Viewing the Results:
See the output on the terminal of `{WSO2SIHome}/samples/sample-clients/kafka-consumer`:
```
[java] [org.wso2.si.sample.kafka.consumer.KafkaReceiver] : Event received in Kafka Event Adaptor: {"event":{"name":"chocolate cake","amount":50.50}}, offSet: 0, key: null, topic: kafka_result_topic, partition: 0
[java] [org.apache.kafka.clients.consumer.internals.ConsumerCoordinator] : Committed offset 1 for partition kafka_result_topic-0
```

## Notes:
If the message "'Kafka' sink at `'LowProductionAlertStream' has successfully connected to http://localhost:9092'` does not appear, it could be that port 9092 defined in the Siddhi application is already being used by a different program. To resolve this issue, do the following,
1. Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop').
2. In this Siddhi application's source configuration, change port 9092 to an unused port.
3. Start the application and check whether the specified messages appear on the console.

```sql
@App:name("PublishKafkaInJsonFormat")
@App:description('Send events via Kafka transport using JSON format')


define stream SweetProductionStream (batchNumber long, lowTotal double);

@sink(type='kafka',
      topic='kafka_result_topic',
      bootstrap.servers='localhost:9092',
      @map(type='json'))
define stream LowProductionAlertStream (batchNumber long, lowTotal double);

@info(name='EventsPassthroughQuery')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```
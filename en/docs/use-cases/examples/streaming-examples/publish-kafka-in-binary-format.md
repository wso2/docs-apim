# Publishing Binary Events via Kafka

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send sweet production events via Kafka transport in Binary format.

## Prerequisites:
1. Setup Kafka.
	* Kafka libs to be added and converted to OSGI from {KafkaHome}/libs are as follows.
		* kafka_2.11-0.10.0.0.jar
		* kafka-clients-0.10.0.0.jar
		* metrics-core-2.2.0.jar
		* scala-library-2.11.8.jar
		* zkclient-0.8.jar
		* zookeeper-3.4.6.jar
	*  Add the OSGI converted kafka libs to `{WSO2SIHome}/lib`.
	*  Add the kafka libs to `{WSO2SIHome}/samples/sample-clients/lib`.
2. Save this sample.
3. If there is no syntax error, the following messages would be shown on the console.
	```
	Siddhi App PublishKafkaInBinaryFormat successfully deployed.
	```

## Note:
To convert Kafka libs to OSGI,
1. Create a folder (Eg: Kafka) and copy Kafka libs to be added from `{KafkaHome}/libs`.
2. Create another folder(Eg: Kafka-osgi, This folder will have the libs that converted to OSGI).
3. Navigate to `{WSO2SIHome}/bin` and issue the follwing command.
	* For Linux:
		```bash
		./jartobundle.sh <path/kafka> <path/kafka-osgi>
		```
	* For Windows:
		```bash
		./jartobundle.bat <path/kafka> <path/kafka-osgi>
		```
4. If converted successfully then for each lib, following messages would be shown on the terminal.
	```
	- INFO: Created the OSGi bundle <kafka-lib-name>.jar for JAR file <absolute_path>/kafka/<kafka-lib-name>.jar
	```
5. You can find the osgi converted libs in kafka-osgi folder. You can copy that to `{WSO2SIHome}/lib`.

## Executing the Sample:
1. Navigate to `{KafkaHome}` and start zookeeper node using following command.
	```bash
	bin/zookeeper-server-start.sh config/zookeeper.properties
	```
2. Navigate to `{KafkaHome}` and start kafka server node using following command.
	```bash
	bin/kafka-server-start.sh config/server.properties
	```
3. Navigate to `{WSO2SIHome}/samples/sample-clients/kafka-consumer` and run `ant` command with following arguments.
	```bash
	ant -DisBinaryMessage=true -DtopicList=kafka_result_topic -Dtype=binary
	```
4. Start the Siddhi application by clicking on 'Run'.
5. If the Siddhi application starts successfully, the following messages would be shown on the console.
	```
	- PublishKafkaInBinaryFormat.siddhi - Started Successfully!
	- Kafka version : 0.10.0.0
	- Kafka commitId : 23c69d62a0cabf06
	- Kafka producer created.
	```

## Testing the Sample:
##### Send events with kafka server, through event simulator:

1. To open event simulator by clicking on the second icon or press Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, select values as follows:
	* Siddhi App Name: PublishKafkaInBinaryFormat
	* Stream Name: SweetProductionStream
3. In the batchNumber field and lowTotal fields, enter '1', '85.5' respectively and then click Send to send the event.
4. Send some more events.

##### Publish events with curl command:
Open a new terminal and issue the following command.
```bash
curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishKafkaInBinaryFormat", "data": [1, 85.5]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
```

##### Publish events with Postman:
1. Install 'Postman' application from Chrome web store.
2. Launch the application.
3. Make a 'Post' request to 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to 'text/plain' and set the request body in json format as follows,
	```json
	{"streamName": "SweetProductionStream", "siddhiAppName": "PublishKafkaInBinaryFormat","data": [1, 85.5]}
	```
4. Click 'send'. If there is no error, the following messages would be shown on the console.
	```
	"status": "OK",
	"message": "Single Event simulation started successfully"
	```

## Viewing the Results:
It will print the results in binary format.

## Notes:
If the message "'Kafka' sink at `'LowProducitonAlertStream' has successfully connected to 'http://localhost:9092'` does not appear, it could be due to port 9092, defined in the Siddhi application is already being used by a different program. To resolve this issue, please do the following,
* Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop')
* Change the port 9092 to an unused port, in this Siddhi application's source configuration.
* Start the application and check whether the specified messages appear on the console.

```sql
@App:name("PublishKafkaInBinaryFormat")
@App:description('Send events via Kafka transport using Binary format')


define stream SweetProductionStream (batchNumber long, lowTotal double);

@sink(type='kafka',
      topic='kafka_result_topic',
      bootstrap.servers='localhost:9092',
      is.binary.message='true',
      @map(type='binary'))
define stream LowProductionAlertStream (batchNumber long, lowTotal double);

@info(name='EventsPassthroughQuery')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```
# Publishing Key-value events via JMS

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send sweet production events via JMS transport in Keyvalue format.

## Prerequisites:
1. Setup ActiveMQ
	* Download `activemq-client-5.x.x.jar` (http://central.maven.org/maven2/org/apache/activemq/activemq-client/5.9.0/activemq-client-5.9.0.jar).
	* Download `apache-activemq-5.x.x-bin.zip` (http://archive.apache.org/dist/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.zip)
	* ActiveMQ `activemq-client-5.x.x.jar` lib to be added and converted to OSGI (See Note: To convert ActiveMQ lib to OSGI).
	* Unzip the `apache-activemq-5.x.x-bin.zip` and copy the following ActiveMQ libs in `apache-activemq-5.x.x/lib` to `{WSO2SIHome}/samples/sample-clients/lib` and `{WSO2SIHome}/lib`.
		- hawtbuf-1.9.jar
		- geronimo-j2ee-management_1.1_spec-1.0.1.jar
		- geronimo-jms_1.1_spec-1.1.1.jar
2. Save this sample.
3. If there is no syntax error, the following message is shown on the console:
	```
	Siddhi App PublishJmsInKeyvalueFormat successfully deployed.
	```

## Note:
To convert ActiveMQ lib to OSGI,
1. Navigate to {WSO2SIHome}/bin and run the following command:
	- For Linux:
	```bash
	./icf-provider.sh org.apache.activemq.jndi.ActiveMQInitialContextFactory <Downloaded Jar Path>/activemq-client-5.x.x.jar <Output Jar Path>
	```
	- For Windows:
	```bash
	./icf-provider.bat org.apache.activemq.jndi.ActiveMQInitialContextFactory <Downloaded Jar Path>\activemq-client-5.x.x.jar <Output Jar Path>
	```
	* Provide privileges if necessary using `chmod +x icf-provider.(sh|bat)`.
	* Also, this will register the `InitialContextFactory` implementation according to the OSGi JNDI spec.
2. If converted successfully then it will create `activemq-client-5.x.x` directory in the `<Output Jar Path>` with OSGi converted and original jars:
	- `activemq-client-5.x.x.jar` (Original Jar)
	- `activemq-client-5.x.x_1.0.0.jar` (OSGi converted Jar)
	Also, following messages would be shown on the terminal.
		```
		- INFO: Executing 'jar uf <absolute_path>/activemq-client-5.x.x/activemq-client-5.x.x.jar -C <absolute_path>/activemq-client-5.x.x /internal/CustomBundleActivator.class'
		[timestamp] org.wso2.carbon.tools.spi.ICFProviderTool addBundleActivatorHeader
		- INFO: Running jar to bundle conversion [timestamp] org.wso2.carbon.tools.converter.utils.BundleGeneratorUtils convertFromJarToBundle
		- INFO: Created the OSGi bundle activemq_client_5.x.x_1.0.0.jar for JAR file <absolute_path>/activemq-client-5.x.x/activemq-client-5.x.x.jar
		```
3. You can find the osgi converted libs in `activemq-client-5.x.x` folder. You can copy `activemq-client-5.x.x/activemq-client-5.x.x_1.0.0.jar` to `{WSO2SIHome}/lib` and `activemq-client-5.x.x/activemq-client-5.x.x.jar` to `{WSO2SIHome}/samples/sample-clients/lib`.

## Executing the Sample:
1. Navigate to `{apache-activemq-5.x.x}` unzipped directory and start ActiveMQ server node using `bin/activemq`.
2. Start the Siddhi application by clicking on 'Run'.
3. If the Siddhi application starts successfully, the following messages are shown on the console:
	```
	PublishJmsInKeyvalueFormat.siddhi - Started Successfully!
	```

## Testing the Sample:
1. Open a terminal and navigate to `{WSO2SIHome}/samples/sample-clients/jms-consumer` and run the following comman.
	```bash
	ant -Dtype='keyvalue'
	```
2. Send events through one or more of the following methods.

##### Option 1: Send events to jms sink, via event simulator
1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, specify the values as follows:
	* Siddhi App Name: PublishJmsInKeyvalueFormat
	* Stream Name: SweetProductionStream
3. In the name and amount fields, enter the following and then click Send to send the event.
	```
	name: chocolate cake
	amount: 50.50
	```
4. Send some more events.

##### Option 2: Publish events with Curl command to the simulator http endpoint
1. Open a new terminal and issue the following command:
	```bash
	curl -X POST -d '{"streamName": "SweetProductionStream", "siddhiAppName": "PublishJmsInKeyvalueFormat","data": ["chocolate cake", 50.50]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
	```
2. If there is no error, the following messages are shown on the terminal:
	```json
	{"status":"OK","message":"Single Event simulation started successfully"}
	```

##### Option 3: Publish events with Postman to the simulator http endpoint
1. Install 'Postman' application from Chrome web store.
2. Launch the application.
3. Make a 'Post' request to the 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to 'text/plain' and set the request body in text as follows:
	```json
	{"streamName": "SweetProductionStream", "siddhiAppName": "PublishJmsInKeyvalueFormat","data": ['chocolate cake', 50.50]}
	```
4. Click 'send'. If there is no error, the following messages are shown on the console:
	```
	"status": "OK",
	"message": "Single Event simulation started successfully"
	```

## Viewing the Results:
See the output on the terminal of `{WSO2SIHome}/samples/sample-clients/jms-consumer`:
```
[java] [io.siddhi.core.stream.output.sink.LogSink] : JmsReceiver : logStream : Event{timestamp=1513607495863, data=['chocolate cake', 50.50], isExpired=false}
```

```sql
@App:name("PublishJmsInKeyvalueFormat")
@App:description('Send events via JMS transport using Keyvalue format')


define stream SweetProductionStream (name string, amount double);
@sink(type='jms',
      factory.initial='org.apache.activemq.jndi.ActiveMQInitialContextFactory',
      provider.url='tcp://localhost:61616',
      destination='jms_result_topic',
      connection.factory.type='topic',
      connection.factory.jndi.name='TopicConnectionFactory',
      @map(type='keyvalue'))
define stream LowProductionAlertStream(name string, amount double);

@info(name='EventsPassthroughQuery')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```
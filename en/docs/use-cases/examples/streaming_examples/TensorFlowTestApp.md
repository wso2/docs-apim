# Performing Regression Tasks via an Imported Tensorflow Model

## Purpose
This application demonstrates how to import a pretrained Tensorflow model WSO2 Streaming Integrator to perform a regression task.

## Prerequisites
1. Replace `{SI_HOME}` with absolute path to the Streaming Integrator Tooling home directory.
2. Save this sample.
3. If there is no syntax error, the following message is shown on the console:
	```
	* Siddhi App TensorFlowTestApp successfully deployed.
	```


## Executing the Sample
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages are shown on the console:
	```
	* TensorFlowTestApp.siddhi - Started Successfully!
	```

## Testing the Sample
Send events through one or more of the following methods.

##### Send events to `ProductionInputStream`, via event simulator
1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, specify the values as follows:
	* Siddhi App Name: TensorFlowTestApp
	* Stream Name: InputStream
3. In the x field, enter the following and then click Send to send the event.
```
x: "double:[1,-2]"
```

4. Send some more events.

##### Send events to the simulator http endpoint through the curl command
1. Open a new terminal and issue the following command:
	```bash
	curl -X POST \
		http://localhost:9390/simulation/single \
		-H 'content-type: text/plain' \
		-d '{"streamName": "InputStream", "siddhiAppName": "TensorFlowTestApp","data": ["double:[1,-2]"]}'
	```
2. If there is no error, the following messages are shown on the terminal:
	```json
	{"status":"OK","message":"Single Event simulation started successfully"}
	```

##### Publish events with Postman
1. Install 'Postman' application from Chrome web store.
2. Launch the application.
3. Make a 'Post' request to the 'http://localhost:9390/simulation/single' endpoint. Set the Content-Type to 'text/plain' and set the request body in text as follows:
	```json
	{"streamName": "InputStream", "siddhiAppName": "TensorFlowTestApp","data": ['double:[1,-2]']}
	```
4. Click 'send'. If there is no error, the following messages are shown on the console:
	```
	"status": "OK",
	"message": "Single Event simulation started successfully"
	```

## Viewing the Results
See the output on the terminal.

```sql
@App:name("TensorFlowTestApp")


define stream InputStream (x string);

@sink(type='log')
define stream OutputStream (outputPoint0 double, outputPoint1 double);

@info(name = 'query1')
from InputStream#tensorFlow:predict('{SI_HOME}/samples/artifacts/TensorflowSample/Regression', 'inputPoint', 'outputPoint', x)
select outputPoint0, outputPoint1
insert into OutputStream;
```
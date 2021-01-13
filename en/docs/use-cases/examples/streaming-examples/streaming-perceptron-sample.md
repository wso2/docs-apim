# Making Predictions via a Streaming Perceptron Model

## Purpose
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to perform binary classification using a streaming Perceptron.

## Prerequisites
1. Save this sample.
2. If there is no syntax error, the following message is shown on the console.
	```
	* Siddhi App streaming-perceptron-sample successfully deployed.
	```

## Executing the Sample
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages are shown on the console.
	```
	* streaming-perceptron-sample.siddhi - Started Successfully!
	```

## Testing the Sample

**Note: The Streaming Perceptron for streaming machine learning needs to be trained prior to perform prediction.**

#### Training phase
Send events through one or more of the following methods.

##### Send events to ProductionTrainStream, via event simulator
1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, specify the values as follows:
	* Siddhi App Name: streaming-perceptron-sample
	* Stream Name: ProductionTrainStream
3. In the name and amount fields, enter the following and then click Send to send the event.
	```
	density: 50.4
	emperature: 30.03
	```

4. Send some more events.

##### Send events to the simulator http endpoint through the curl command
1. Open a new terminal and issue the following command:
```bash
curl -X POST -d '{"streamName": "ProductionTrainStream", "siddhiAppName": "streaming-perceptron-sample","data": [50.4, 30.03, true]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
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
	{"streamName": "ProductionTrainStream", "siddhiAppName": "streaming-perceptron-sample","data": [50.4, 30.03, true]}
	```
4. Click 'send'. If there is no error, the following messages are shown on the console:
	```
	"status": "OK",
	"message": "Single Event simulation started successfully"
	```

#### Testing phase
Send events through one or more of the following methods.

##### Send events to ProductionInputStream, via event simulator
1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, specify the values as follows:
	* Siddhi App Name: streaming-perceptron-sample
	* Stream Name: ProductionInputStream
3. In the name and amount fields, enter the following and then click Send to send the event.
	```
	density: 30.4
	emperature: 20.5
	```
4. Send some more events.

##### Send events to the simulator http endpoint through the curl command
1. Open a new terminal and issue the following command:
	```bash
	curl -X POST -d '{"streamName": "ProductionInputStream", "siddhiAppName": "streaming-perceptron-sample","data": [30.4, 20.5]}' http://localhost:9390/simulation/single -H 'content-type: text/plain'
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
	{"streamName": "ProductionInputStream", "siddhiAppName": "streaming-perceptron-sample","data": [30.4, 20.5]}
	```
4. Click 'send'. If there is no error, the following messages are shown on the console:
	```
	"status": "OK",
	"message": "Single Event simulation started successfully"
	```

## Viewing the Results
See the output on the terminal:
```
INFO {io.siddhi.core.query.processor.stream.LogStreamProcessor} - streaming-perceptron-sample: LOGGER, StreamEvent{ timestamp=1513596699142, beforeWindowData=null, onAfterWindowData=null, outputData=[34.0, 12.0, false, 0.0], type=CURRENT, next=null}
```

```sql
@App:name("streaming-perceptron-sample")
@App:description('Train a streaming Perceptron model to predict whether an item passes quality check.')


define stream ProductionTrainStream (density double, temperature double, qualityCheck_pass bool );

define stream ProductionInputStream (density double, temperature double);

@sink(type='log')
define stream PredictedQCStream (density double, temperature double, prediction bool, confidenceLevel double);

@info(name = 'query-train')
from ProductionTrainStream#streamingml:updatePerceptronClassifier('QCmodel', qualityCheck_pass, 0.1, density, temperature)
select *
insert into trainOutputStream;

@info(name = 'query-predict')
from ProductionInputStream#streamingml:perceptronClassifier('QCmodel', 0.0, 0.5, density, temperature)
select *
insert into PredictedQCStream;
```
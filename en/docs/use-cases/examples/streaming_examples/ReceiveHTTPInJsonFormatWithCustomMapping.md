# Receiving Custom JSON Events via HTTP

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator to receive events to the `SweetProductionStream` via HTTP transport in JSON format using custom mapping and log the events in `LowProductionAlertStream` to the output console.

## Prerequisites:
Save this sample.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages would be shown on the console.
	```
	* Source Listener has created for url http://localhost:8006/productionStream
	* ReceiveHTTPInJsonFormatWithDefaultMapping.siddhi - Started Successfully!
	```

## Testing the Sample:
##### Option 1: Publish events with http sample client:
Navigate to `{WSO2SIHome}/samples/sample-clients/http-client` and run `ant` command as follows:

Run `ant` command in the terminal as follows:
```bash
ant -DcustomMapping=true
```
If you want to publish custom number of events, you need to run "ant" command as follows:
```bash
ant -DcustomMapping=true -DnoOfEventsToSend=5
```

##### Option 2: Publish events with curl command:
Publish few events in json format to the http endpoint as follows (The values for name and amount attributes can be changed as desired).
```bash
curl -X POST -d "{\"item\": {\"id\":\"Sugar\",\"amount\": 300.5}}"  http://localhost:8006/productionStream --header "Content-Type:application/json"
```

##### Option 3: Publish events with Postman:
1. Install 'Postman' application from Chrome web store.
2. Launch the application.
3. Make a 'POST' request to 'http://localhost:8006/productionStream' endpoint. Set the Content-Type to 'application/json' and set the request body in json format as follows.
```json
{
	"item": {
		"id": "sugar",
		"amount": 20.0
	}
}
```

## Notes:
If you edit this application while it's running, stop the application -> Save -> Start.
If the message "Source Listener has created for url http://localhost:8006/productionStream" does not appear,it could be due to port 8006, defined in the Siddhi application is already being used by a different program. To resolve this issue, please do the following,
* Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop')
* Change the port 8006 to an unused port, in this Siddhi application's source configuration.
* Start the application and check whether the specified messages appear on the console.

## Viewing the Results:
See the output. Following message would be shown on the console.
```
ReceiveHTTPInJsonFormatWithDefaultMapping : LowProducitonAlertStream : Event{timestamp=1511938781887, data=[sugar, 300.0], isExpired=false}
```

```sql
@App:name("ReceiveHTTPInJsonFormatWithCustomMapping")

@App:description('Receive events via HTTP transport in JSON format with custom mapping and view the output on the console')
@source(type = 'http',
        receiver.url='http://localhost:8006/productionStream',
        basic.auth.enabled='false',@map(type='json', @attributes( name = '$.item.id', amount = '$.item.amount')))
define stream SweetProductionStream (name string, amount double);

@sink(type='log')
define stream LowProductionAlertStream (name string, amount double);

-- passthrough data in the SweetProductionStream into LowProducitonAlertStream
@info(name='query1')
from SweetProductionStream
select *
insert into LowProductionAlertStream;
```
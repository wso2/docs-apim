# Converting String Values to Lowercase

## Purpose
This String function converts the string value to lowercase letters

## Prerequisites
Save this sample. If there is no syntax error, the following messages would be shown on the console
```
* Siddhi App StringExtensionSample successfully deployed.
```

## Executing the Sample
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages would be shown on the console.
	```
	* StringExtensionSample.siddhi - Started Successfully!
	```

## Testing the Sample
You can publish data event to the file, through event simulator.
1. Open event simulator by clicking on the second icon or press Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, select values as follows:
	* Siddhi App Name: StringExtensionSample
	* Stream Name: SweetProductionStream
3. Enter following values in the fields and send.
	```
	name: CaKe
	amount: 55.6
	```


## Viewing the Results
Messages similar to the following would be shown on the console.
```
INFO {io.siddhi.core.stream.output.sink.LogSink} - StringExtensionSample : OutputStream : Event{timestamp=1513760993921, data=[cake, 55.6], isExpired=false}
```

```sql
@App:name("StringExtensionSample")
@App:description('Converts the sweet name to lowercase letters.')


define stream SweetProductionStream (name string, amount double);

@sink(type='log')
define stream OutputStream(name string, amount double);

from SweetProductionStream
select str:lower(name) as name, amount
insert into OutputStream;
```
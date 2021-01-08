# Identifying Sub-sequences in Input Sequences

## Purpose:
This function attempts to find the next sub-sequence of the inputSequence that matches the regex pattern. It returns true if such a sub sequence exists, or returns false otherwise

## Prerequisites:
Save this sample. If there is no syntax error, the following messages would be shown on the console.
```
* Siddhi App RegexExecutionSample successfully deployed.
```

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages would be shown on the console.
	```
	* RegexExecutionSample.siddhi - Started Successfully!
	```

## Testing the Sample:
You can publish data event to the file, through event simulator.

1. Open event simulator by clicking on the second icon or press Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, select values as follows:
	* Siddhi App Name  : RegexExecutionSample
	* Stream Name     : SweetProductionStream
3. Enter following values in the fields and send,
	```
	name: chocolate cake
	startingIndex: 0
	```
4. Enter following values in the fields and send
	```
	name: coffee cake
	startingIndex: 0
	```

## Viewing the Results:
Messages similar to the following would be shown on the console.
```
INFO {io.siddhi.core.stream.output.sink.LogSink} - RegexExecutionSample : ChocolateProductStream : Event{timestamp=1513759840093, data=[chocolate cake, true], isExpired=false}
INFO {io.siddhi.core.stream.output.sink.LogSink} - RegexExecutionSample : ChocolateProductStream : Event{timestamp=1513759907324, data=[coffee cake, false], isExpired=false}
```

```sql
@App:name("RegexExecutionSample")
@App:description('Finds if a sweet is a chocolate product.')


define stream SweetProductionStream (name string, startingIndex int);

@sink(type='log')
define stream ChocolateProductStream(name string, isAChocolateProduct bool);

from SweetProductionStream
select name, regex:find("^chocolate(\s*[a-zA-Z]+)", str:lower(name), startingIndex) as isAChocolateProduct
insert into ChocolateProductStream;
```
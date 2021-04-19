# Text Mapping with In-memory Transport

## Purpose
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to receive events to the SweetProductionStream via TCP transport in binary format and check the custom text mapping and the default text mapping using inMemory transport and log the events in OutputStreams accordingly to the  output  console.

## Prerequisites
1. Save this sample

## Executing the Sample
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages would be shown on the console. <br /><br />

    ```
    * Tcp Server started in 0.0.0.0:9892
    * TextMappingWithInmemoryTransport.siddhi - Started Successfully!
    ```

## Testing the Sample
In order to publish events with TCP client,
1. Go to `{WSO2SIHome}/samples/sample-clients/tcp-client/` directory.
2. Run ant commant as following.
    ```bash
    ant -Dtype=binary
    ```

If you want to publish custom number of events, you need to run "ant" command as follows.
```bash
ant -Dtype=binary -DnoOfEventsToSend=5
```

## Viewing the Results
```
INFO {io.siddhi.core.stream.output.sink.LogSink} - Custom Mapper : Event{timestamp=1513599736271, data=[Jelly Bean, 9.0], isExpired=false}
INFO {io.siddhi.core.stream.output.sink.LogSink} - Default Mapper : Event{timestamp=1513599737255, data=[Froyo, 1534.87], isExpired=false}
INFO {io.siddhi.core.stream.output.sink.LogSink} - Custom Mapper : Event{timestamp=1513599737255, data=[Froyo, 1.0], isExpired=false}
INFO {io.siddhi.core.stream.output.sink.LogSink} - Default Mapper : Event{timestamp=1513599738255, data=[Jelly Bean, 3030.71], isExpired=false}
INFO {io.siddhi.core.stream.output.sink.LogSink} - Custom Mapper : Event{timestamp=1513599738256, data=[Jelly Bean, 3.0], isExpired=false}
INFO {io.siddhi.core.stream.output.sink.LogSink} - Default Mapper : Event{timestamp=1513599739256, data=[Cupcake, 3212.83], isExpired=false}
```

## Notes
If the message "Tcp Server started in 0.0.0.0:9892" does not appear, it could be due to port 9892, defined in the Siddhi application is already being used by a different program. To resolve this issue, please do the following,
* Stop this Siddhi application (Click 'Run' on menu bar -> 'Stop')
* Change the port 9892 to an unused port, in this Siddhi application's source configuration.
* Start the application and check whether the specified messages appear on the console

```sql
@App:name("TextMappingWithInmemoryTransport")
@App:description('Use inmemory transport to custom text mapping and the default text mapping and view the output on the console.')


@source(type='tcp', context='SweetProductionStream', port='9892',
@map(type='binary'))
define stream SweetProductionStream (name string, amount double);

@sink(type='log', prefix='Default Mapper')
define stream DefaultOutputStream (name string, amount double);

@sink(type='log', prefix='Custom Mapper')
define stream CustomOutputStream (name string, amount double);

-- Default text mapping.

@sink(type='inMemory', topic='home', @map(type='text'))
define stream InMemoryDefaultSweetProductionInputData (name string, amount double);

@source(type='inMemory', topic='home', @map(type='text'))
define stream UsageStream (name string, amount double);

-- Custom text mapping.

@sink(type='inMemory', topic='home1', @map(type='text',
@payload("""name:{{name}},
amount:{{amount}}""")))
define stream InMemoryCustomSweetProductionInputData (name string, amount double);

@source(type='inMemory', topic='home1', @map(type='text' , regex.A='((?<=name:)(.*)(?=,))',regex.B='([-0-9]+)',
@attributes(name = 'A', amount = 'B')))
define stream UsageStream2 (name string, amount double);

from SweetProductionStream
select *
insert into InMemoryDefaultSweetProductionInputData;

from UsageStream
select *
insert into DefaultOutputStream;

from SweetProductionStream
select *
insert into InMemoryCustomSweetProductionInputData;

from UsageStream2
select *
insert into CustomOutputStream;
```
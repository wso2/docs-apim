# Sending Custom Keyvalue Events via SNMP

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send snmp set request via SNMP in keyvalue using custom mapping.

## Prerequisites:
1. Save this sample.
2. Install snmp agent on your network node.
    * for linux can install snmpd / for windows it can be configured by 'windows features'.
    * configure snmp agent ex:- community string = public,
3. If there is no syntax error, the following message is shown on the console:
       * - SNMP-set-request-app successfully deployed.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages are shown on the console:
    * SNMP-set-request-app - Started Successfully!

## Testing the Sample:
1. Click on 'Event Simulator' (double arrows on left tab)
2. Click 'Single Simulation' (this will be already selected)
3. Select SNMP-set-request-app as 'Siddhi App Name'
4. Select outputStream as 'StreamName'
5. Provide attribute values
    - sysLocation : asia-branch-singapore
6. Click on the start button (Arrow symbol) next to the newly created simulator

## Viewing the Results:
See the output on the terminal:
INFO {io.siddhi.core.stream.output.sink.LogSink} - SNMP-set-request-app : logStream : Event{timestamp=1*********, data=[asia-branch-singapore], isExpired=false}

## Notes:
Make sure the port number is correct and user have write access to agent

```sql
@App:name("SNMPSetRequestApp")
@App:description('setting oids on agent')


@Sink(type='snmp',
@map(type='keyvalue', @payload('1.3.6.1.2.1.1.6.0' = 'sysLocation')),
host = '127.0.0.1',
version = 'v1',
community = 'public',
agent.port = '2019')
define stream outputStream(sysLocation string);

@sink(type='log')
define stream logStream(sysLocation string);

@info(name='query_name')
from outputStream
select sysLocation
insert into logStream;
```
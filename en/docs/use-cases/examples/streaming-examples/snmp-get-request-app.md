# Receiving Custom Key Value Events via SNMP

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to resive snmp source via SNMP in keyvalue using custom mapping.

## Prerequisites:
1. Save this sample.
2. Install snmp agent on your network node.
    * for linux can install snmpd / for windows it can be configured by 'windows features'.
    * configure snmp agent ex:- community string, port, user access.
3. If there is no syntax error, the following message is shown on the console:
       * - SNMP-get-request-app successfully deployed.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages are shown on the console:
    * SNMP-set-request-app - Started Successfully!


## Viewing the Results:
See the output. Following message would be shown on the console.
```
INFO {io.siddhi.core.stream.output.sink.LogSink} - SNMP-get-request-app : logStream : Event{timestamp=1************, data=[1:28:33.05, mail@wso2.com], isExpired=false}
INFO {io.siddhi.core.stream.output.sink.LogSink} - SNMP-get-request-app : logStream : Event{timestamp=1************, data=[1:28:38.05, mail@wso2.com], isExpired=false}
```


```sql
@App:name("SNMPGetRequestApp")
@App:description('listening oid status from agent')

@source(type ='snmp',
    @map(type='keyvalue',    @attributes(sysUpTime= '1.3.6.1.2.1.1.3.0', sysContact = '1.3.6.1.2.1.1.4.0') ),
    host ='127.0.0.1',
    version = 'v1',
    request.interval = '5000',
    community = 'public',
    agent.port = '2019',
    oids='1.3.6.1.2.1.1.3.0, 1.3.6.1.2.1.1.4.0')
define stream inputStream(sysUpTime string, sysContact string);

@sink(type='log')
define stream logStream (sysUpTime string, sysContact string);

-- passthrough data in the inputStream to logStream
@info(name='query1')
from inputStream
select *
insert into logStream;
```
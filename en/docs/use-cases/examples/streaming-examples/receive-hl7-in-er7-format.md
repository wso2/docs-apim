# Receiving ER7 Events via HL7

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to receive Hl7 events in ER7 format to the hl7Stream via MLLP protocol and log the events in er7Stream to the output console.

## Prerequisites:
1. Install the HAPI testpanel. (Reference: https://hapifhir.github.io/hapi-hl7v2/hapi-testpanel/install.html)
2. Save this sample. If there is no syntax error, the following message is shown on the console:
* - Siddhi App ReceiveHl7InER7Format successfully deployed.

## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'.
2. If the Siddhi application starts successfully, the following messages would be shown on the console.
    * Starting SimpleServer running on port 4000
    * ReceiveHl7InER7Format.siddhi - Started Successfully!

## Testing the Sample:
1. In the HAPI testpanel create a sending connection with port that provided in the siddhi app.
2. Send this message 'MSH|^~\&|sendingSystemA|senderFacilityA|receivingSystemB|receivingFacilityB|20080925161613||ADT^A01|589888ADT30502184808|P|2.3' from the testpanel

## Viewing the Results:
See the output. Following message would be shown on the console if you publish events.
ReceiveHl7InER7Format : er7Stream : Event{timestamp=1552530948958, data=[MSH|^~\&|||||20190211145413.131+0530||ADT^A01|10601|T|2.3 ], isExpired=false}

```sql
@App:name('ReceiveHl7InER7Format')
@App:description('This receives the HL7 messages and sends the acknowledgement message to the client using the MLLP protocol and text mapping.')


@source(type = 'hl7', port = '4000', hl7.encoding = 'er7', @map(type = 'text'))
define stream hl7stream(payload string);

@sink(type='log')
define stream er7Stream (payload string);

@info(name='query1')
from hl7stream
select *
insert into er7Stream;
```
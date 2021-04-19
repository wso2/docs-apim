# Receiving ER7 Events via HL7

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send Hl7 events in ER7 format via MLLP protocol and log the events in hl7Stream and the acknowledgement message to the output console.

## Prerequisites:
1. Install the HAPI testpanel. (Reference: https://hapifhir.github.io/hapi-hl7v2/hapi-testpanel/install.html)
2. Save this sample. If there is no syntax error, the following message is shown on the console:
    - Siddhi App PublishHl7InER7Format successfully deployed.

## Executing the Sample:
1. In the HAPI testpanel create a receiving connection with port that provided in the siddhi app.
2. Start the listener.
3. Start the Siddhi application by clicking on 'Run'.
4. If the Siddhi application starts successfully, the following messages are shown on the console:
    * PublishHl7InER7Format.siddhi - Started Successfully!
	* 'Hl7' sink at 'hl7Stream' stream successfully connected to 'localhost:4000'.
	* Executing HL7Sender: HOST: localhost, PORT: 4000 for stream PublishHl7InER7Format:hl7Stream.

## Testing the Sample:
1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, specify the values as follows:
    * Siddhi App Name  : PublishHl7InER7Format
    * Stream Name      : er7Stream
3. In the payload, enter 'MSH|^~\&|||||20190211145413.131+0530||ADT^A01|10601|T|2.3' and then click Send to send the event.
4. Send more events as desired.

```sql
@App:name('PublishHl7InER7Format')
@App:description('This publishes the HL7 messages in ER7 format, receives and logs the acknowledgement message in the console using MLLP protocol and custom text mapping.')


define stream er7Stream (payload string);

@sink(type = 'hl7', uri='localhost:4000', tls.enabled='false', hl7.encoding='er7', @map(type='text', @payload('{{payload}}')))
define stream hl7Stream (payload String);

@info(name='query1')
from er7Stream
select payload
insert into hl7Stream;
```
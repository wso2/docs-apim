# Publishing XML messages via HL7

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling to send Hl7 events in XML format via MLLP protocol and log the events in hl7Stream and the acknowledgment message to the output console.

## Prerequisites:
1. Install the HAPI testpanel. (Reference: https://hapifhir.github.io/hapi-hl7v2/hapi-testpanel/install.html)
2. Save this sample. If there is no syntax error, the following message is shown on the console:
    - Siddhi App PublishHl7InXmlFormat successfully deployed.

## Executing the Sample:
1. In the HAPI testpanel create a receiving connection with port that provided in the siddhi app.
2. Start the listener.
3. Start the Siddhi application by clicking on 'Run'.
4. If the Siddhi application starts successfully, the following messages are shown on the console:
    * PublishHl7InXmlFormat.siddhi - Started Successfully!
    * 'Hl7' sink at 'hl7Stream' stream successfully connected to 'localhost:4000'.

## Testing the Sample:
1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
2. In the Single Simulation tab of the panel, specifiy the values as follows:
    * Siddhi App Name   :   PublishHl7InXmlFormat
    * Stream Name   :   xmlStream
3. In the MSH1, MSH2, MSH3HD1,MSH4HD1, MSH5HD1, MSH6HD1, MSH7, MSH8, CM_MSG1, CM_MSG2, MSH10, MSH11, MSH12 fields enter '|', '^~\&amp;', 'sendingSystemA', 'senderFacilityA', 'receivingSystemB' , 'receivingFacilityB', '20080925161613', ' ', 'ADT', 'A01', 'S123456789', 'P', '2.3' respectively and then click Send to send the event.
4. Send more events as desired.

```sql
@App:name('PublishHl7InXmlFormat')
@App:description('This publishes the HL7 messages in XML format, receives and logs the acknowledgement message in the console using MLLP protocol and custom xml mapping.')


define stream xmlStream(MSH1 string, MSH2 string, MSH3HD1 string, MSH4HD1 string, MSH5HD1 string, MSH6HD1 string, MSH7 string, MSH8 string, CM_MSG1 string, CM_MSG2 string,MSH10 string,MSH11 string, MSH12 string);

@sink(type = 'hl7', uri = 'localhost:4000', hl7.encoding = 'xml', @map(type = 'xml', enclosing.element="<ADT_A01  xmlns='urn:hl7-org:v2xml'>", @payload('<MSH><MSH.1>{{MSH1}}</MSH.1><MSH.2>{{MSH2}}</MSH.2><MSH.3><HD.1>{{MSH3HD1}}</HD.1></MSH.3><MSH.4><HD.1>{{MSH4HD1}}</HD.1></MSH.4><MSH.5><HD.1>{{MSH5HD1}}</HD.1></MSH.5><MSH.6><HD.1>{{MSH6HD1}}</HD.1></MSH.6><MSH.7>{{MSH7}}</MSH.7><MSH.8>{{MSH8}}</MSH.8><MSH.9><CM_MSG.1>{{CM_MSG1}}</CM_MSG.1><CM_MSG.2>{{CM_MSG2}}</CM_MSG.2></MSH.9><MSH.10>{{MSH10}}</MSH.10><MSH.11>{{MSH11}}</MSH.11><MSH.12>{{MSH12}}</MSH.12></MSH>')))
define stream hl7Stream(MSH1 string, MSH2 string, MSH3HD1 string, MSH4HD1 string, MSH5HD1 string, MSH6HD1 string, MSH7 string, MSH8 string, CM_MSG1 string, CM_MSG2 string,MSH10 string,MSH11 string, MSH12 string);

@info(name='query1')
from xmlStream
select *
insert into hl7Stream;
```
# Publishing Events to a Google Pub/Sub Topic

## Purpose:
This application demonstrates how to configure WSO2 Streaming Integrator Tooling using googlepubsub sink in Siddhi to publish events. Events which are in TEXT format are published to a googlepubsub topic.

## Prerequisites:
1. Create a Google Cloud Platform account.
2. Sign in to Google Account and set up a GCP Console project and enable the API.
3. Create a service account and download a private key as JSON.
4. Place your json file in any system property.
5. Save the sample.
6. If there is no syntax error, the following message is shown on the console:
    - Siddhi App SendGooglePubSubMessage successfully deployed.


## Executing the Sample:
1. Start the Siddhi application by clicking on 'Run'. If the Siddhi application starts successfully, the following messages are shown on the console:
	- SendGooglePubSubMessage.siddhi - Started Successfully!

## Testing the Sample:
1. Send events through one or more of the following methods.
    * You may send events to googlepubsub sink, via event simulator
        1. Open the event simulator by clicking on the second icon or pressing Ctrl+Shift+I.
        2. In the Single Simulation tab of the panel, specify the values as follows:
            * Siddhi App Name  : SendGooglePubSubMessage
            * Stream Name      : FooStream
        3. In the message field, enter the following and then click Send to send the event.
            * message: Hello
        4. Send some more events.

## Viewing the Results:
* See the output on the terminal:<br/>
2019-03-14_12-50-21_966] INFO {io.siddhi.core.stream.output.sink.LogSink} - SendEvent : BarStream : Event{timestamp=1552548021825, data=[Hello], isExpired=false}

## Notes:
Make sure the the credential file is correct and user have write access to make api calls.<br/>
Stop this Siddhi application.

```sql
@App:name("SendGooglePubSubMessage")

@App:description('Send events to a Google Pub/Sub Topic')



@sink(type='googlepubsub', 
      topic.id = 'topic75',
      credential.path = '/../sp.json',
      project.id = 'sp-path-1547649404768',
      @map(type='text'))
define stream FooStream (message string);

@sink(type = 'log')
define stream BarStream(message string);

@info(name = 'query1')
from FooStream
select message 
insert into BarStream;
```